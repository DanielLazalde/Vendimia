-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-11-2016 a las 11:32:56
-- Versión del servidor: 10.1.16-MariaDB
-- Versión de PHP: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `vendimiadb`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `debug` (`msg` VARCHAR(255))  BEGIN
   SELECT CONCAT("*** ", msg) AS '*** DEBUG:'; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cancelarventa` (IN `pIdVenta` BIGINT)  NO SQL
BEGIN

DELETE FROM ctl_detalleventas 
WHERE idu_venta= pIdVenta; 

DELETE FROM ctl_ventas WHERE idu_venta=pIdVenta; 

DELETE FROM tmp_abonosmensuales WHERE idu_venta=pIdVenta;     


END$$

--
-- Funciones
--

CREATE DEFINER=`root`@`localhost` FUNCTION `fun_calculoabonomensuales` (`pIdVenta` BIGINT, `pIdDetalleVenta` BIGINT, `pCantidad` INT) RETURNS TEXT CHARSET utf8 NO SQL
BEGIN


    DECLARE _preciocontado DECIMAL(18,3);

    DECLARE _plazomaximo INT;
     DECLARE _plazo INT;
    DECLARE _porcentajeenganche INT;
    DECLARE _existenciaarticuloactual INT;
    DECLARE _iduarticulo BIGINT;


    DECLARE _tasa DECIMAL(18,3);
    DECLARE _totaladeudo DECIMAL(18,3);

    DECLARE _totalapagar DECIMAL(18,3);
    DECLARE _importeabono DECIMAL(18,3);
    DECLARE _importeahorro DECIMAL(18,3);

    DECLARE _tasaxplazo DECIMAL(18,3);
    DECLARE _tasaxplazotresmeses DECIMAL(18,3);
    DECLARE _tasaxplazoseismeses DECIMAL(18,3);
    DECLARE _tasaxplazonuevemeses DECIMAL(18,3);
    DECLARE _tasaxplazodocemeses DECIMAL(18,3);
     DECLARE _plazotr INT;
    
    /* OBTENER DATOS CONFIGURACION */

    SET _tasa = (SELECT num_tasafinanciamiento FROM tbl_configuracion LIMIT 1 );
    SET _plazomaximo = (SELECT num_plazomaximo FROM tbl_configuracion LIMIT 1 );
    SET _porcentajeenganche = (SELECT num_porcentajeenganche FROM tbl_configuracion LIMIT 1 );


    SET _tasaxplazotresmeses = (_tasa * 3) / 100;
    SET _tasaxplazoseismeses = (_tasa * 6) / 100;
    SET _tasaxplazonuevemeses = (_tasa * 9) / 100;
    SET _tasaxplazodocemeses = (_tasa * 12) / 100;

    SET _totaladeudo = (SELECT num_total FROM ctl_ventas WHERE idu_venta = pIdVenta);
    

    SET _preciocontado = (_totaladeudo / ( 1 + _tasaxplazodocemeses));



    /* BORRAR LA TABLA TEMPORAL DE LA VENTA */

    DELETE FROM tmp_abonosmensuales where idu_venta = pIdVenta;

    /* Obtener el listado de los abonos */


         
          SET _plazotr = 3;

          WHILE _plazotr <= _plazomaximo DO
          
          
			     IF (_plazotr%3!=0) THEN
                 
                 	   SET _plazo = _plazotr;
                       
                 ELSE
                 
                 	   SET _plazo = _plazotr;
                     
                    SET _tasaxplazo = (_tasa * _plazo) / 100;
                    SET _totalapagar = (_preciocontado * ( 1 + _tasaxplazo));
                    SET _importeabono = _totalapagar / _plazo;
                    SET _importeahorro = _totaladeudo - _totalapagar;

                    INSERT INTO tmp_abonosmensuales (idu_venta, des_abono, num_plazo, num_importeabono, num_totalapagar,  num_seahorra)
                    VALUES (pIdVenta, CONCAT(_plazo, ' ABONOS DE $', _importeabono), _plazo, _importeabono, _totalapagar, _importeahorro);
                    
                 END IF;
                

                SET _plazotr=_plazotr+1;

           
          END WHILE;

   


RETURN "OK";


    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fun_calculodeventa` (`pIdVenta` BIGINT, `pIdDetalleVenta` BIGINT, `pCantidad` INT) RETURNS TEXT CHARSET utf8 NO SQL
BEGIN

    DECLARE _precioarticulo DECIMAL(18,3);

    DECLARE _plazomaximo INT;
    DECLARE _porcentajeenganche INT;
    DECLARE _existenciaarticuloactual INT;
    DECLARE _iduarticulo BIGINT;


    DECLARE _tasa DECIMAL(18,3);
    DECLARE _tasaxplazo DECIMAL(18,3);
    DECLARE _preciocalculado DECIMAL(18,3);
    DECLARE _enganche DECIMAL(18,3);
    DECLARE _bonificacion DECIMAL(18,3);
    DECLARE _totaladeudo DECIMAL(18,3);
    DECLARE _importe DECIMAL(18,3);

       DECLARE  _importetotal DECIMAL(18,3);

  

/*SELECT @A:=SUM(salary) FROM table1 WHERE TYPE=1;*/


/*OBTENER DATOS DE CONFIGURACION*/

        SET _tasa = (SELECT num_tasafinanciamiento FROM tbl_configuracion LIMIT 1 );
        SET _plazomaximo = (SELECT num_plazomaximo FROM tbl_configuracion LIMIT 1 );
        SET _porcentajeenganche = (SELECT num_porcentajeenganche FROM tbl_configuracion LIMIT 1 );

        SET _tasaxplazo = (_tasa * _plazomaximo) / 100;

/*UPDATE table2 SET summary=@A WHERE TYPE=1;*/

   IF EXISTS(SELECT idu_detalle FROM ctl_detalleventas WHERE idu_venta = pIdVenta AND idu_detalle = pIdDetalleVenta) THEN

        SET _precioarticulo = (SELECT num_precio FROM ctl_ventas v INNER JOIN ctl_detalleventas dv on v.idu_venta = dv.idu_venta INNER JOIN tbl_articulos a ON a.idu_articulo = dv.idu_articulo
          WHERE v.idu_venta = pIdVenta AND dv.idu_detalle = pIdDetalleVenta);

        SET _iduarticulo = (SELECT a.idu_articulo FROM ctl_ventas v INNER JOIN ctl_detalleventas dv on v.idu_venta = dv.idu_venta INNER JOIN tbl_articulos a ON a.idu_articulo = dv.idu_articulo
          WHERE v.idu_venta = pIdVenta AND dv.idu_detalle = pIdDetalleVenta);
      

        SET _preciocalculado = (_precioarticulo * (1 + _tasaxplazo));

        SET _importe = _preciocalculado * pCantidad;

       
        /*ACTUALIZAR IMPORTE Y PRECIO EN LA TABLA DETALLE DE VENTAS*/

        UPDATE ctl_detalleventas
        SET num_preciocalculado = _preciocalculado, num_importe = _importe
        WHERE idu_venta = pIdVenta and idu_detalle = pIdDetalleVenta;

        
          /*VALIDAR EXISTENCIA*/

          SET _existenciaarticuloactual = ( SELECT num_existencia FROM tbl_articulos WHERE idu_articulo = _iduarticulo);


          IF (_existenciaarticuloactual - pCantidad) < 0  THEN
          
            UPDATE ctl_detalleventas
            SET opc_hayexistencia = false
            WHERE idu_venta = pIdVenta AND idu_detalle = pIdDetalleVenta;

          ELSE 

            UPDATE ctl_detalleventas
            SET opc_hayexistencia = true
            WHERE idu_venta = pIdVenta AND idu_detalle = pIdDetalleVenta;

          END IF;

    END IF;


    /*CALULAR ENGANCHE, BONIFICACION, TOTALADEUDO*/

    SET _importetotal = (SELECT SUM(num_importe) FROM ctl_detalleventas WHERE idu_venta = pIdVenta);


    SET _enganche = (_porcentajeenganche / 100) * _importetotal;

    SET _bonificacion = _enganche * _tasaxplazo;

    SET _totaladeudo = _importetotal - _enganche - _bonificacion;


    /*ACTUALIZAR EN LA TABLA VENTAS calculos de enganche*/


    UPDATE ctl_ventas
    SET num_enganche = _enganche, num_bonificacionenganche = _bonificacion, num_total = _totaladeudo
    WHERE idu_venta = pIdVenta;


    

    RETURN "OK";
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fun_generafolioventa` (`pIdCliente` BIGINT) RETURNS TEXT CHARSET utf8 NO SQL
BEGIN
  DECLARE _start BIGINT DEFAULT 0;

  INSERT INTO ctl_ventas(idu_cliente)
  VALUES (pIdCliente);
  
  SET _start = (SELECT @@identity AS id);
  
  RETURN CONCAT(_start);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fun_guardararticulo` (`vDescripcion` VARCHAR(45), `vModelo` VARCHAR(45), `dPrecio` DECIMAL, `iExistencia` BIGINT) RETURNS TEXT CHARSET ascii NO SQL
BEGIN
  DECLARE _start BIGINT DEFAULT 0;

  INSERT INTO tbl_articulos(des_articulo, des_modelo, num_precio, num_existencia)
VALUES (vDescripcion, vModelo, dPrecio, iExistencia);
  
  SET _start = (SELECT @@identity AS id);
  
  RETURN LPAD(_start,5,'0');
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fun_guardardetalleventa` (`pIdVenta` BIGINT, `pIdCliente` BIGINT, `pIdArticulo` BIGINT, `pCantidad` INT) RETURNS TEXT CHARSET utf8 NO SQL
BEGIN

DECLARE _respuesta INT;
DECLARE _existencia INT;
DECLARE _idudetalleventa BIGINT;
DECLARE _rescalculoventa VARCHAR(10);

SET _respuesta = 0;
/* Respuesta = 1 -- >  EL ARTICULO YA EXISTE EN LA TABLA DETALLE DE ARTICULOS DE LA VENTA*/

/* Respuesta = 2 -- >  NO HAY EXISTENCIA DEL ARTICULO */

/* VALIDA QUE EL CLIENTE SEA EL DE LA VENTA */

/* VALIDA SI HAY EXISTENCIA DEL ARTICULO */

SET _existencia = (SELECT num_existencia FROM tbl_articulos WHERE idu_articulo = pIdArticulo LIMIT 1);

IF (_existencia - pCantidad) < 0 THEN
    SET _respuesta = 2;

    RETURN _respuesta;

END IF;


/* BUSCAR SI EL ARTICULO EXITE DENTRO DEL DETALLE DE LA VENTA */

IF exists(SELECT a.idu_articulo FROM tbl_articulos a INNER JOIN ctl_detalleventas dv ON dv.idu_articulo = a.idu_articulo
 WHERE dv.idu_articulo = pIdArticulo AND dv.idu_venta = pIdVenta) THEN

  SET _respuesta = 1;
  UPDATE ctl_detalleventas
  SET num_cantidad = pCantidad
  WHERE idu_venta = pIdVenta AND idu_articulo = pIdArticulo;



ELSE

  /* ASIGNAR CLIENTE AL FOLIO DE LA VENTA */
  UPDATE ctl_ventas 
  SET idu_cliente = pIdCliente
  WHERE idu_venta = pIdVenta; 

  /*INSERTA ARTICULO AL DETALLE DE LA VENTA */

  INSERT INTO ctl_detalleventas(idu_venta, idu_articulo, num_cantidad) values (pIdVenta, pIdArticulo, 1);

END IF;


/* CALULOS DE IMPORTES, ENGANCHES, BONIFICACIONES, ETC */

 SET _idudetalleventa = (SELECT idu_detalle FROM ctl_detalleventas WHERE idu_venta = pIdVenta AND idu_articulo = pIdArticulo);



 SET _rescalculoventa = (SELECT fun_calculodeventa(pIdVenta, _idudetalleventa, pCantidad));


/* */

/* */
/* */
/* */
/* */
/* */

 RETURN _respuesta;


END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fun_guardarventafinal` (`pIdVenta` BIGINT, `pNumPlazo` INT) RETURNS TEXT CHARSET utf8 NO SQL
BEGIN
 	 DECLARE _plazomaximo INT;
     DECLARE _plazo INT;
      DECLARE l_last_row INT ;
       DECLARE cTeleMail VARCHAR(90) DEFAULT '';
     DECLARE ResultVar VARCHAR(100) DEFAULT '';
    
    DECLARE _iduarticulo BIGINT;
    DECLARE _inum_cantidad INT;

  /* Declaración del cursor de nombre ´cursor1´ */ 
     DECLARE cursor1 CURSOR FOR SELECT dv.idu_articulo, dv.num_cantidad FROM ctl_ventas v INNER JOIN  ctl_detalleventas dv on dv.idu_venta = v.idu_venta WHERE v.idu_venta = pIdVenta;
   
    
     /* Flag que permitirá saber si existen más registros por recorrer */
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET l_last_row=1;  
     UPDATE ctl_ventas 
     SET opc_estatus = 2
     WHERE idu_venta = pIdVenta;
     
      UPDATE tmp_abonosmensuales
     set opc_estatus = true
     WHERE idu_venta = pIdVenta AND num_plazo = pNumPlazo;


     /* Restar existencia del articulo */
       /* Declaración de variables */
     
     /* Abrimos el cursor para empezar a recorrerlo */
     OPEN cursor1;
     c1_loop: LOOP    
        
         /* Cada registro se le otorga a la variable ‘cTeleMail’ */
        FETCH cursor1 INTO _iduarticulo, _inum_cantidad ;        
         IF (l_last_row=1) THEN           
             LEAVE c1_loop;        
         END IF;
        
         /* Lógica propia de la función que se está creando */

          UPDATE tbl_articulos
          SET num_existencia = num_existencia - _inum_cantidad
          WHERE idu_articulo = _iduarticulo;

        /*IF ResultVar ='' THEN
             SET ResultVar = TRIM(cTeleMail);
         ELSE
             SET ResultVar = CONCAT(ResultVar , ‘ ; ‘ , TRIM(cTeleMail));
        END IF;*/
        
     END LOOP c1_loop;
    
     /* cerramos el cursor y retornamos el dato que nos interesa en este caso la variable ‘ResultVar’ */
    
     CLOSE cursor1;
     RETURN ResultVar;   
     
     RETURN "OK";
 END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ctl_detalleventas`
--

CREATE TABLE `ctl_detalleventas` (
  `idu_detalle` bigint(20) NOT NULL,
  `idu_venta` bigint(20) NOT NULL DEFAULT '0',
  `idu_articulo` bigint(20) NOT NULL DEFAULT '0',
  `num_cantidad` int(11) NOT NULL DEFAULT '0',
  `num_preciocalculado` decimal(18,2) NOT NULL DEFAULT '0.00',
  `num_importe` decimal(18,2) NOT NULL DEFAULT '0.00',
  `opc_estatus` tinyint(1) NOT NULL DEFAULT '1',
  `opc_hayexistencia` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ctl_ventas`
--

CREATE TABLE `ctl_ventas` (
  `idu_venta` bigint(20) NOT NULL,
  `fec_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `idu_cliente` bigint(20) NOT NULL,
  `opc_estatus` int(11) NOT NULL DEFAULT '1',
  `num_enganche` decimal(18,2) NOT NULL DEFAULT '0.00',
  `num_bonificacionenganche` decimal(18,2) NOT NULL DEFAULT '0.00',
  `num_total` decimal(18,2) NOT NULL DEFAULT '0.00',
  `num_plazo` int(11) NOT NULL DEFAULT '0',
  `num_totalapagar` decimal(18,2) NOT NULL DEFAULT '0.00',
  `num_seahorra` decimal(18,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_articulos`
--

CREATE TABLE `tbl_articulos` (
  `idu_articulo` bigint(20) NOT NULL,
  `des_articulo` varchar(45) NOT NULL,
  `des_modelo` varchar(45) NOT NULL,
  `num_precio` decimal(18,2) NOT NULL,
  `num_existencia` bigint(20) DEFAULT NULL,
  `opc_estatus` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_clientes`
--

CREATE TABLE `tbl_clientes` (
  `idu_cliente` bigint(20) NOT NULL,
  `cve_cliente` varchar(50) DEFAULT NULL,
  `des_nombrecompleto` varchar(50) NOT NULL,
  `des_apellidopaterno` varchar(45) NOT NULL,
  `des_apellidomaterno` varchar(45) NOT NULL,
  `des_rfc` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_configuracion`
--

CREATE TABLE `tbl_configuracion` (
  `idu_configuracion` bigint(20) NOT NULL,
  `num_tasafinanciamiento` decimal(18,2) NOT NULL DEFAULT '0.00',
  `num_porcentajeenganche` int(11) DEFAULT NULL,
  `num_plazomaximo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuarios_usu`
--

CREATE TABLE `tbl_usuarios_usu` (
  `usu_codigo` varchar(10) NOT NULL,
  `usu_nombre` varchar(50) DEFAULT NULL,
  `usu_clave` varchar(20) DEFAULT NULL,
  `usu_apellido_paterno` varchar(20) DEFAULT NULL,
  `usu_apellido_materno` varchar(20) DEFAULT NULL,
  `usu_nro_documento` varchar(12) DEFAULT NULL,
  `usu_administrador` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tmp_abonosmensuales`
--

CREATE TABLE `tmp_abonosmensuales` (
  `idu_venta` bigint(20) NOT NULL,
  `num_plazo` int(11) NOT NULL DEFAULT '0',
  `des_abono` varchar(120) NOT NULL DEFAULT '',
  `num_importeabono` decimal(18,2) NOT NULL DEFAULT '0.00',
  `num_totalapagar` decimal(18,2) NOT NULL DEFAULT '0.00',
  `num_seahorra` decimal(18,2) NOT NULL DEFAULT '0.00',
  `opc_estatus` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tmp_abonosmensuales`
--



--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ctl_detalleventas`
--
ALTER TABLE `ctl_detalleventas`
  ADD PRIMARY KEY (`idu_detalle`),
  ADD KEY `idu_venta` (`idu_venta`),
  ADD KEY `idu_articulo` (`idu_articulo`);

--
-- Indices de la tabla `ctl_ventas`
--
ALTER TABLE `ctl_ventas`
  ADD PRIMARY KEY (`idu_venta`),
  ADD KEY `idu_cliente` (`idu_cliente`);

--
-- Indices de la tabla `tbl_articulos`
--
ALTER TABLE `tbl_articulos`
  ADD PRIMARY KEY (`idu_articulo`);

--
-- Indices de la tabla `tbl_clientes`
--
ALTER TABLE `tbl_clientes`
  ADD PRIMARY KEY (`idu_cliente`);

--
-- Indices de la tabla `tbl_configuracion`
--
ALTER TABLE `tbl_configuracion`
  ADD PRIMARY KEY (`idu_configuracion`);

--
-- Indices de la tabla `tbl_usuarios_usu`
--
ALTER TABLE `tbl_usuarios_usu`
  ADD PRIMARY KEY (`usu_codigo`);



--
-- Filtros para la tabla `ctl_detalleventas`
--
ALTER TABLE `ctl_detalleventas`
  ADD CONSTRAINT `idu_articulo` FOREIGN KEY (`idu_articulo`) REFERENCES `tbl_articulos` (`idu_articulo`),
  ADD CONSTRAINT `idu_venta` FOREIGN KEY (`idu_venta`) REFERENCES `ctl_ventas` (`idu_venta`);

--
-- Filtros para la tabla `ctl_ventas`
--
ALTER TABLE `ctl_ventas`
  ADD CONSTRAINT `idu_cliente` FOREIGN KEY (`idu_cliente`) REFERENCES `tbl_clientes` (`idu_cliente`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
