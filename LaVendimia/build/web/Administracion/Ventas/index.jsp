<%-- 
    Document   : index
    Created on : 08-Nov-2016, 19:41:29
    Author     : Lazalde
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/jquery.datetimepicker.css">
        <link rel="stylesheet" href="../css/bootstrap-theme.min.css">
        <script src="../../js/jquery.min.js"></script>
        <script src="../../js/bootstrap.min.js"></script>
        <script src="../../js/jquery.datetimepicker.js"></script>
        <script src="../../js/jquery-2.0.3.min.js"></script>
        <script src="../../js/jquery-ui-1.10.3.custom.js"></script>
        <link rel="stylesheet" type="text/css" href="../../css/circular-load.css"> 
        <link rel="stylesheet" type="text/css" href="../../css/jquery-ui-1.10.3.custom.css">         
        <link rel="stylesheet" type="text/css" href="../../css/Styles.css"/>

        
        <%@include file="/WEB-INF/jspf/imports.jspf" %> 
        <style type="text/css">
            
            .TablaMensajeGeneralLv2{

            color:blue; 
            font-family:verdana;
            font-size:15px;
            font-weight:bold;
            z-index: 1002;

            }
            
            .TablaMensaje1{

            color:blue; 
            font-family:verdana;
            font-size:15px;
            font-weight:bold;
            z-index: 1002;

            }
            .ui-dialog .ui-widget-header,.ui-widget-header
            {
                background: #42BE33;
                border: 1px solid;
            }
            #dialogEditarDiaRuta
            input[type=text] { 

                padding: 5px;
                margin: 5px;
                width: 98%;
            }
            #dialogNuevoArticulo, #divMensajeGuardado, #divMensajeCantidadMayorAcero, #divPreguntarSalir, #mostrarMensajeGeneral, #divPreguntarBorrar
            { 
                display: none;
                font-size: 10px;
            }
            .row
            {
                padding: 0px;
                margin:0px;
            }
            .col-xs-1,.col-xs-12,.col-xs-9
            {
                padding: 0px;
                margin:5px;
            }
            .ui-autocomplete {
                z-index: 9999;
            }

            #jtable-create-form, #jtable-edit-form {
                width: 500px;
            }
        </style>

        <script type="text/javascript">
            $(document).ready(function() {

                //Prepare jTable
                $('#TablaArticulos').jtable({
                    title: 'Ventas Activas',
                    //toolbarsearch: true,
                    //pageSize: 10,
                    //toolbarsearch:true,
                    actions: {
                        listAction: '../../srvVentas?parAccion=list',
                        //createAction: '../srvExamenes?parAccion=create',
                        //updateAction: '../srvExamenes?parAccion=update',
                        //deleteAction: '../../srvVentas?parAccion=delete'
                    },
                    fields: {
                        
                        idu_venta: {
                            title: 'Folio Venta',
                            key: true,
                            create: false,
                            edit: false,
                            list: true
                        },
                        idu_cliente: {
                            title: 'Clave Cliente',
                            create: true,
                            edit: true,
                            list: true,
                            inputClass: 'validate[required]'
                        },
                        des_nombrecompleto: {
                            title: 'Nombre',
                            create: true,
                            edit: true,
                            list: true,
                            inputClass: 'validate[required]'
                        },
                        num_total: {
                            title: 'Total',
                            create: true,
                            edit: true,
                            list: true,
                            inputClass: 'validate[required]'
                        },
                        fec_registro: {
                            title: 'Fecha',
                            create: true,
                            edit: true,
                            list: true,
                            inputClass: 'validate[required]'
                        }/*,
                        btnEditarArticulo: {
                            title: '',
                            width: '1%',
                            display: function(data) {
                                //alert(data.record.RtdCodigo);
                                return "<input type='text' placeholder='Cantidad' />";
                            }
                        }*/
                    },
                    formCreated: function(event, data) {

                        data.form.find('input[name="des_nombrecompleto"]').prop('maxlength', '100');


                        data.form.find('input[name="des_nombrecompleto"]').css('width', '100%');

                    }/*,
                    recordsLoaded: function(event, data){
                        alert("hoalala   " + data);
                    } */
                    
                });
                $('#TablaArticulos').jtable('load');

            });
            
        </script>
    </head>
    <body>
        
                <%-- NUEVA VENTA --%>
                <div id="dialogNuevoArticulo">
                           
                            <div class="container" >
                                <div class="row">
                                    <div class="col-xs-12">
                                        <form role="form" class="form-horizontal">
                                            <div class="form-group">
                                                <div class="alert alert-danger text-center" style="display:none;" id="error">
                                                    <strong>Adventencia: </strong>Debe completar todos los campos
                                                </div>
                                                <div class="alert alert-success text-center" style="display:none;" id="exito">
                                                    <strong>Bien Hecho: </strong>La Venta ha sido registrada.
                                                </div>  
                                            </div>
                                            
                                            <div class="form-group">
                                                    <div class="form-group">
                                                        <div style="float: right;" class="row">

                                                                <label  type="label" id="mostrarClaveArticulo"/>
                                                                <input type="hidden" didabled class="form-control" id="inputidu_venta" placeholder="Folio Venta">

                                                                <input type="hidden" id="imputSeleccionAbono">

                                                                <input type="hidden" id="txtAbonoSeleccionado" />

                                                                <div style="float: right;" class="form-group">                         
                                                                   <label  type="label" id="mostrarClaveArticulo"/>                           
                                                                   <div style="float: right;" id="mostrarFolioVentaGenerado"></div>
                                                                   <input type="hidden"  class="form-control" id="inputFiltroBusquedaClaveArticulo" placeholder="Clave Articulo">
                                                               </div>
                                                            </div>
                                                      </div>
                                                        <div class="form-group">
                                                            <div class="row" >
                                                                <label type="label" for="inputFiltroBusquedaCliente"  class="control-label col-xs-1">Cliente:</label>
                                                                 <div class="col-xs-4">
                                                                    <input type="text" class="form-control" id="inputFiltroBusquedaCliente" placeholder="Buscar Cliente ...">
                                                                 </div>
                                                                 <label type="label" id="des_rfc"/>                                                              

                                                                 <input type="hidden" id="txtRfc" />
                                                            </div>
                                                         </div>
                                                         
                                                         <div class="form-group">
                                                          <div class="row" >
                                                             <label type="label" for="inputFiltroBusquedaArticulo"  class="control-label col-xs-1">Articulo:</label>
                                                             <div class="col-xs-4">
                                                                 <input type="text" class="form-control" id="inputFiltroBusquedaArticulo" placeholder="Buscar Articulo ...">
                                                                  <span class="help-block"></span>
                                                             </div>
                                                             <div style="margin:10px;" class="row">
                                                                 <button id="btnAgregarArticulo"  type="button" style="float: left;" title="Registro de Articulos" class="btn btn-success btn-sm" onclick="verificaragregararticulo()"><span class="glyphicon glyphicon-plus"></span>  </button>
                                                             </div>
                                                          </div>
                                                         </div>

                                            </div>
                                            
                                            <div class="form-group">
                                                     <div id="TablaDetalleVenta" ></div>
                                            </div>
                                            
                                            <div class="form-group">


                                                <input type="hidden" id="idu_configuracion"/>

                                                <label for="num_enganche" class="control-label col-xs-6">Enganche:</label>
                                                <div class="col-xs-5">
                                                    <input id="num_enganche" name="num_enganche" type="text" disabled class="form-control" placeholder="Enganche ..." onkeyup="validacion('num_enganche');" aria-describedby="inputSuccess2Status">
                                                    <span class="help-block"></span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="num_bonificacionenganche" class="control-label col-xs-6">Bonificación Enganche:</label>
                                                <div class="col-xs-5">
                                                    <input id="num_bonificacionenganche" disabled name="num_bonificacionenganche" type="text" class="form-control" placeholder="Bonificación Enganche" onkeyup="validacion('num_bonificacionenganche');" aria-describedby="inputSuccess2Status">
                                                    <span class="help-block"></span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="num_total" class="control-label col-xs-6">Total:</label>
                                                <div class="col-xs-5">
                                                    <input id="num_total" disabled name="num_total" type="text" class="form-control" placeholder="Total ..." onkeyup="validacion('num_total');" aria-describedby="inputSuccess2Status">
                                                    <span class="help-block"></span>
                                                </div>
                                            </div>

                                             <div class="form-group">
                                                <label for="codigo" class="control-label col-xs-4"></label>

                                                <div  style="float: right;" class="col-xs-5" id="btnsiguiente">
                                                    <button type="button" class="btn btn-primary" onclick='msgPreguntarSalir();'><span class="glyphicon glyphicon-lock"></span> Cancelar</button>   
                                                    <button id="btnsiguientebtn" type="button" class="btn btn-primary" onclick='verificar();'><span class="glyphicon glyphicon-lock"></span> Siguiente</button>   
                                                </div>
                                                
                                                <br>
                                                
                                                <div id="TablaAbonos" ></div>

                                            </div> 

                                        </form>
                                    </div>

                                </div>
                            </div>
                    

                </div>
                
                
                <div style="margin:10px;" class="row">
                    <button  type="button" style="float: right;" title="Registro de Articulos" class="btn btn-success btn-sm" onclick="nuevoArticulo()"><span class="glyphicon glyphicon-plus"></span>   Nuevo</button>
                </div>
                <div id="TablaArticulos"></div>
                <script>
                     var v=true;
                    $("span.help-block").hide();
                    function verificar(){

                            var v1=0,v2=0,v3=0,v4=0,v5=0,v6=0;
                            //v1=validacion('codigo');
                            v2=validacion('inputFiltroBusquedaCliente');
                            /*v3=validacion('dni');
                            v4=validacion('email');
                            v5=validacion('genderRadios');
                            v6=validacion('carrera');*/
                            if (v2===false 
                                    //|| v2===false || v3===false || v4===false || v5===false || v6===false 
                                    ) {
                                 //$("#exito").hide();
                                 $("#error").show();
                            }else{
                                $("#error").hide();
                                //$("#exito").show();
                                
                                mostrarSessionAbonosMensuales();
                            }
                            
                        } 
                        
                    function verificaragregararticulo(){
                            
                            var v1=0,v2=0,v3=0,v4=0,v5=0,v6=0;
                            //v1=validacion('codigo');
                            v2=validacion('inputFiltroBusquedaCliente');
                            v2=validacion('inputFiltroBusquedaArticulo');
                            
                            if (varidu_articulo === -1 || varidu_cliente === -1){
                                v3 = false;  
                                
                                $('#error').html("<strong>Adventencia: </strong>Los datos ingresados no son correctos, por favor verificar.");
                            }
                            
                            if (v2===false || v2===false || v3===false
                                    //|| v2===false || v3===false || v4===false || v5===false || v6===false 
                                    ) {
                                 //$("#exito").hide();
                                 $("#error").show();
                            }else{
                                $("#error").hide();
                                //$("#exito").show();
                                
                                //mostrarSessionAbonosMensuales();
                                agregarDetalleVenta();
                            }
                            
                        }
                        
                        function verificarguardarventafinal(){
                            
                            var v1=0,v2=0,v3=0,v4=0,v5=0,v6=0;
                            //v1=validacion('codigo');
                            v1=validacion('inputFiltroBusquedaCliente');
                            //v2=validacion('inputFiltroBusquedaArticulo');
                            
                            if (contadorarticulosagregados  < 1){
                                v2 = false;                                
                                $('#error').html("<strong>Adventencia: </strong>Asegurarse en tener por lo menos un articulo agregado");
                                
                                $('#mensajeGeneral').html("<strong>Adventencia: </strong>Los datos ingresados no son correctos, favor verificar");
                               
                                mostrarMensajeGeneral();
                            }else v2 = true;
                            
                            if (varidu_cliente === -1){
                                v3 = false;  
                                
                                //$('#error').html("<strong>Adventencia: </strong>Asegurarse en seleccionar un articulo y cliente");
                                $('#mensajeGeneral').html("<strong>Adventencia: </strong>Los datos ingresados no son correctos, favor verificar");
                               
                                mostrarMensajeGeneral();
                            }else v3 = true;
                            
                            
                            
                            var abonosel = $('#txtAbonoSeleccionado').val().trim();
                            if (abonosel === ''){
                                v4 = false;  
                                
                                $('#error').html("<strong>Adventencia: </strong>Los datos ingresados no son correctos, favor verificar");
                                $('#mensajeGeneral').html("<strong>Adventencia: </strong>Los datos ingresados no son correctos, favor verificar");
                               
                                mostrarMensajeGeneral();
                            }else v4=true;
                            
                            
                          
                            if (v1===false || v2===false || v3===false || v4===false
                                    //|| v2===false || v3===false || v4===false || v5===false || v6===false 
                                    ) {
                                 //$("#exito").hide();
                                 $("#error").show();
                            }else{
                                $("#error").hide();
                                //$("#exito").show();
                                
                                //mostrarSessionAbonosMensuales();
                                guardarVentaFinal()();
                            }
                            
                        }
                        
                    function validacion(campo){
                        var a=0;

                        if (campo==='inputFiltroBusquedaCliente'){
                            apellido = document.getElementById(campo).value;
                            if( apellido == null || apellido.length == 0 || /^\s+$/.test(apellido) ) {

                                $("#glypcn"+campo).remove();
                                $('#'+campo).parent().parent().attr("class", "form-group has-error has-feedback");
                                $('#'+campo).parent().children('span').text("Ingrese algo").show();
                                $('#'+campo).parent().append("<span id='glypcn"+campo+"' class='glyphicon glyphicon-remove form-control-feedback'></span>");
                                return false;

                            }
                            else{
                                $("#glypcn"+campo).remove();
                                $('#'+campo).parent().parent().attr("class", "form-group has-success has-feedback");
                                $('#'+campo).parent().children('span').hide();
                                $('#'+campo).parent().append("<span id='glypcn"+campo+"' class='glyphicon glyphicon-ok form-control-feedback'></span>");
                                return true;

                            } 
                        }
                        
                        if (campo==='inputFiltroBusquedaArticulo'){
                            apellido = document.getElementById(campo).value;
                            if( apellido == null || apellido.length == 0 || /^\s+$/.test(apellido) ) {

                                $("#glypcn"+campo).remove();
                                $('#'+campo).parent().parent().attr("class", "form-group has-error has-feedback");
                                $('#'+campo).parent().children('span').text("Ingrese algo").show();
                                $('#'+campo).parent().append("<span id='glypcn"+campo+"' class='glyphicon glyphicon-remove form-control-feedback'></span>");
                                return false;

                            }
                            else{
                                $("#glypcn"+campo).remove();
                                $('#'+campo).parent().parent().attr("class", "form-group has-success has-feedback");
                                $('#'+campo).parent().children('span').hide();
                                $('#'+campo).parent().append("<span id='glypcn"+campo+"' class='glyphicon glyphicon-ok form-control-feedback'></span>");
                                return true;

                            } 
                        }
                        
                    }
                    
                    function cancelarVenta(){ 
                        
                            var idu_folioventa = $('#inputidu_venta').val();
                            //alert(idu_folioventa);
                            $.post('../../srvVentas', {
                                parAccion: 'deleteventa',
                                idu_venta: idu_folioventa
                               
                            },
                                function(responseText) {
                                
                               //alert("Termino de borrar articulo");  
                               var arr = [];
                                    json = JSON.stringify(eval('(' + responseText + ')')); //convert to json string
                                    arr = $.parseJSON(json); //convert to javascript array
                                
                                
                                    var result = arr.Result;
                                    if (result=== "OK"){
                                       //  $("#error").hide();
                                       //  $("#exito").show();
                                       //alert("Cancelo venta satisfactoriamente");
                                    }
                                    
                                   
                               
                               
                            });
                        
                    }
                    
                    
                     function cancelarArticulo(idu_detalle){ 
                        
                            var idu_folioventa = $('#inputidu_venta').val();
                            //alert(idu_folioventa);
                            $.post('../../srvVentas', {
                                parAccion: 'delete',
                                idu_venta: idu_folioventa,
                                idu_detalle: idu_detalle
                               
                            },
                                function(responseText) {
                                
                               //alert("Termino de borrar articulo");  
                               /*var arr = [];
                                    json = JSON.stringify(eval('(' + responseText + ')')); //convert to json string
                                    arr = $.parseJSON(json); //convert to javascript array
                                
                                
                                    var result = arr.Result;
                                    if (result=== "OK"){*/
                                       //  $("#error").hide();
                                       //  $("#exito").show();
                                       //alert("Cancelo venta satisfactoriamente");
                                        $('#TablaDetalleVenta').jtable('load');
                                    
                                    //}
                                    
                                   
                               
                               
                            });
                        
                    }
                    
                   

                    function obtienedatosventa(){
                        
                        //alert("Obtiene datos de la venta");
                            var idu_folioventa = $('#inputidu_venta').val();
                        
                            $.post('../../srvVentas', {
                                parAccion: 'obtenerdatosventa',
                                idu_venta: idu_folioventa,
                                idu_cliente: 0,
                                idu_articulo: 0,
                                num_cantidad: 0
                            },
                                function(responseText) {
                                
                                var arr = [];
                                    json = JSON.stringify(eval('(' + responseText + ')')); //convert to json string
                                    arr = $.parseJSON(json); //convert to javascript array
                                
                                
                                    var result = arr.Result;
                                    if (result=== "OK"){
                                       //  $("#error").hide();
                                       //  $("#exito").show();
                                    }
                                    
                                    var records = arr.Records;                                    
                                    
                                    //alert(records.length);
                                    if (records.length!=0){
                                        //alert(records[0].num_tasafinanciamiento);
                                        
                                        var num_enganche = records[0].num_enganche;                              
                                        var num_bonificacionenganche = records[0].num_bonificacionenganche;
                                        var num_total = records[0].num_total;
                                        
                                         $('#num_enganche').val(num_enganche);
                                         $('#num_bonificacionenganche').val(num_bonificacionenganche);
                                         $('#num_total').val(num_total);
                                         
                                         
                                        
                                    }
                                    else{
                                      
                                        $('#num_enganche').val("");
                                        $('#num_bonificacionenganche').val("");
                                        $('#num_total').val("");
                                         
                                    }
                                
                                    $('#TablaDetalleVenta').jtable('load');
                                    
                        
                               });
                        
                    }
                    
                    function validarcantidad(event, iIdCliente, iIdArticulo, iCantidad){
                        
                        
                        var keypressed = event.keyCode || event.which;
                        if (keypressed == 13) {
                            
                            var idu_folioventa = $('#inputidu_venta').val();
                            
                            if (iCantidad < 0){
                                //alert("Proporcionar una cantidad mayor a cero");
                                //msgCantidad();
                                
                                 $('#mensajeGeneral').html("<strong>Advertencia: </strong>Proporcionar una cantidad mayor a cero");
                               
                                 mostrarMensajeGeneral();
                            }else
                            {
                                
                                        $.post('../../srvVentas', {
                                        parAccion: 'createdetalleventa',
                                        idu_venta: idu_folioventa,
                                        idu_cliente: iIdCliente,
                                        idu_articulo: iIdArticulo,
                                        num_cantidad: iCantidad
                                    },
                                        function(responseText) {
                                                //alert(responseText);
                                            var rsp = responseText.trim();
                                            if (rsp === "1"){
                                                 //alert("Actualizacion de cantidad correcta");
                                                 $('#mensajeGeneral').html("<strong>Bien hecho: </strong>Actualizacion de cantidad correcta");
                               
                                                mostrarMensajeGeneral();
                                            }
                                               

                                             if (rsp === "2"){
                                                //alert("No hay existencia del articulo con esa cantidad");
                                                
                                                $('#mensajeGeneral').html("<strong>Adventencia: </strong>No hay existencia del articulo con esa cantidad");
                               
                                                mostrarMensajeGeneral();

                                                }
                                            obtienedatosventa();
                                            
                                            
                                        

                                       });
                                
                            }
                            
                            
                            $('#inputFiltroBusquedaArticulo').focus();
                                
                                
                            
                            
                        }
                    }
                    var varFolioVenta;
                    
                    function generarFolioVenta(){
                   
                            var UsuCodigo = $('#inputCodigo').val();
                            
                            $.post('../../srvVentas', {
                                parAccion: 'generarfolioventa',                                
                                idu_cliente: 1
                            },
                                function(responseText) {
                                
                                var arr = [];
                                    json = JSON.stringify(eval('(' + responseText + ')')); //convert to json string
                                    arr = $.parseJSON(json); //convert to javascript array
                                
                                    varFolioVenta = arr[0].idu_venta;
                                     
                                     $('#inputidu_venta').val(varFolioVenta);
                                     
                                     $('#mostrarFolioVentaGenerado').html("<h1><p>Folio Venta: "+ varFolioVenta +" <p></h1>");
                                  
                                        
                                            //Prepare jTable
                                            $('#TablaDetalleVenta').jtable({
                                                title: 'Detalle de Ventas',                                                
                                                //pageSize: 10,
                                                //toolbarsearch:true,
                                                actions: {
                                                    listAction: '../../srvVentas?parAccion=listarticulosagregados&idu_venta=' + varFolioVenta,
                                                    //createAction: '../srvExamenes?parAccion=create',
                                                    //updateAction: '../srvExamenes?parAccion=update',
                                                    //deleteAction: '../../srvVentas?parAccion=delete',
                                                },

                                                fields: {
                                                    
                                                    idu_venta: {
                                                        title: 'Venta',
                                                        key: true,
                                                        create: false,
                                                        edit: true,
                                                        list: false
                                                    },
                                                    idu_articulo: {
                                                        title: 'Articulo',
                                                        key: true,
                                                        create: false,
                                                        edit: true,
                                                        list: false
                                                    },                                                    
                                                    idu_detalle: {
                                                        title: 'DetalleVenta',
                                                        key: true,
                                                        create: false,
                                                        edit: true,
                                                        list: false
                                                    },
                                                    des_articulo: {
                                                        title: 'Descripción Articulo',
                                                        key: true,
                                                        create: false,
                                                        edit: false,
                                                        list: true
                                                    },
                                                    des_modelo: {
                                                        title: 'Modelo',
                                                        create: true,
                                                        edit: true,
                                                        list: true,
                                                        inputClass: 'validate[required]'
                                                    },

                                                    /*btnEditarArticulo: {
                                                        title: '',
                                                        width: '1%',
                                                        display: function(data) {
                                                            //alert(data.record.RtdCodigo);
                                                            return "<button type='button' title='Editar articulo' onclick='abrirDialogExamenGenerado(" + data.record.CexId + ");' style='border:none;padding:0px;'><span class='glyphicon glyphicon-eye-open'></span></button>";
                                                        }
                                                    },*/
                                                    num_cantidad: {
                                                        title: 'Cantidad',
                                                        create: true,
                                                        edit: true,
                                                        list: false,
                                                        inputClass: 'validate[required]'
                                                    },                                                    
                                                    txtEditarCantidad: {
                                                        title: 'Cantidad',
                                                        width: '1%',
                                                        display: function(data) {
                                                            //alert(data.record.RtdCodigo);
                                                            //return " <input id='textboxId' type='number' onkeypress='validarcantidad(event, data.record.idu_cliente , data.record.idu_articulo , this.value);'  placeholder='Cantidad'  value='"+ data.record.num_cantidad + "' />" ;
                                                            return " <input id='textboxId' type='number' onkeypress='validarcantidad(event,"+ data.record.idu_cliente +", "+ data.record.idu_articulo +", this.value);'  value='"+ data.record.num_cantidad + "' />" ;
                                                        }
                                                    },
                                                    num_preciocalculado: {
                                                        title: 'Precio',
                                                        create: true,
                                                        edit: true,
                                                        list: true,
                                                        inputClass: 'validate[required]'
                                                    },
                                                    num_importe: {
                                                        title: 'Importe',
                                                        create: true,
                                                        edit: true,
                                                        list: true,
                                                        inputClass: 'validate[required]'
                                                    },
                                                    btnBorrarArticulo: {
                                                        title: '',
                                                        width: '1%',
                                                        display: function(data) {
                                                            //alert(data.record.RtdCodigo);
                                                            return "<button type='button' title='Borrar articulo' onclick='msgPreguntarBorrar(" + data.record.idu_detalle + ");' style='border:none;padding:0px;'><span class='glyphicon glyphicon-remove'></span></button>";
                                                        }
                                                    }
                                                },
                                                formCreated: function(event, data) {

                                                    data.form.find('input[name="des_articulo"]').prop('maxlength', '100');


                                                    data.form.find('input[name="des_articulo"]').css('width', '100%');
                                                    
                                                }
                                            });
                                            $('#TablaDetalleVenta').jtable('load');

                            });

                       
                            
                    }
                    
                                     
                    
                    function guardarArticulo()
                    {
                        var des_articulo = $('#des_articulo').val();
                        var des_modelo = $('#des_modelo').val();
                        var num_precio = $('#num_precio').val();
                        var num_existencia = $('#num_existencia').val();
                        var idu_articulo = claveArticulo;// $('#idu_articulo').val();                              
                        
                        if (des_articulo.trim()=="" ){
                            alert("No es posible debe ingresar <Descripcion> es obligatorio");
                        }
                        else
                         if (num_precio.trim()=="" ){
                            alert("No es posible debe ingresar <num_precio> es obligatorio");
                        }
                        else
                        if (num_existencia.trim()=="" ){
                            alert("No es posible debe ingresar <num_existencia> es obligatorio");
                        }                       
                        else{
                            
                                $.post('../../srvArticulos', {
                                parAccion: 'create',
                                des_articulo: des_articulo,
                                des_modelo: des_modelo,
                                num_precio: num_precio,
                                num_existencia: num_existencia,
                                idu_articulo: idu_articulo
                            }, function(responseText) {
                                var rsp = responseText.trim();
                                //alert(rsp);
                                
                                 var arr = [];
                                    json = JSON.stringify(eval('(' + responseText + ')')); //convert to json string
                                    arr = $.parseJSON(json); //convert to javascript array
                                   //alert(arr.Result);
                                    var result = arr.Result;
                                    //alert(result);
                                    if (result === "OK"){                                        
                                        msgGuardado();
                                        /*$('#TablaArticulos').jtable('load');                            
                                        $(vardialogArticulo).dialog('close');*/
                                    }else{
                                          alert("Errorrrrrrr");
                                    }
                                
                               
                            });
                            
                        }
                      
                        
                    }
                    var vardialogArticulo;
                    function nuevoArticulo()
                    {
                        inicializarDatos();

                        generarFolioVenta();
                        
                        vardialogArticulo = $("#dialogNuevoArticulo").dialog({
                            width: '100%',
                            height: 1000,
                            title: "Registro de Ventas",
                            modal: true,
                            buttons: {
                                 "Cancelar": function() {
                                     //cancelarVenta();
                                     msgPreguntarSalir();
                                     //$('#TablaArticulos').jtable('load');                            
                                    
                                },
                                "Guardar": function() {
                                    //guardarVentaFinal();
                                    verificarguardarventafinal();
                                }
                            }});
                        
                        
                             
                        
                    }
                    
                    function guardarAbonoSeleccionado(valorAbonoSel){


                        $('#txtAbonoSeleccionado').val(valorAbonoSel);

                    }
                                            
                    function mostrarSessionAbonosMensuales(){
                        
                                
                                var idu_folioventa = $('#inputidu_venta').val();
                                //Prepare jTable
                                $('#TablaAbonos').jtable({
                                    title: '<center>ABONOS MENSUALES</center>',
                                    //toolbarsearch: true,
                                    //pageSize: 10,
                                    //toolbarsearch:true,
                                    actions: {
                                        listAction: '../../srvVentas?parAccion=listabonosmensuales&idu_venta='+idu_folioventa,
                                        //createAction: '../srvExamenes?parAccion=create',
                                        //updateAction: '../srvExamenes?parAccion=update',
                                        //deleteAction: '../../srvVentas?parAccion=delete'
                                    },
                                    fields: {
                                        des_abono: {                                           
                                            key: true,
                                            create: false,
                                            edit: false,
                                            list: true
                                        },/*,
                                        num_importeabono: {                                           
                                            create: true,
                                            edit: true,
                                            list: true,
                                            inputClass: 'validate[required]'
                                        }, */                                       
                                        txttotalapagar: {
                                          
                                            width: '1%',
                                            display: function(data) {
                                                //alert(data.record.RtdCodigo);
                                                return "<p>TOTAL A PAGAR $ " + data.record.num_totalapagar+ "</p>";
                                            }
                                        },
                                        txtseahorra: {                                          
                                            width: '1%',
                                            display: function(data) {
                                                //alert(data.record.RtdCodigo);
                                                return "<p>SE AHORRA $ " + data.record.num_seahorra+ "</p>";
                                            }
                                        },                                        
                                        radioseleccion: {                                          
                                            width: '1%',
                                            display: function(data) {
                                                //alert(data.record.RtdCodigo);
                                                return "<input type='radio' onclick='guardarAbonoSeleccionado("+ data.record.num_plazo +")' name='gposelplazoabono' />";
                                                
                                                //return "<input type='radio' onclick='alert($('#imputSeleccionAbono').val("+ data.record.num_plazo +"));' name='gender' value='"+ data.record.num_plazo +"'> ";
                                            }
                                        }
                                    },
                                    formCreated: function(event, data) {

                                        data.form.find('input[name="des_abono"]').prop('maxlength', '100');


                                        data.form.find('input[name="des_abono"]').css('width', '100%');

                                    }

                                });
                                
                                $('#TablaAbonos').show();
                                $('#TablaAbonos').jtable('load');
                                
                                //$("#btnAgregarArticulo").enabled(true);
                                $("#btnsiguiente").hide();
                        
                    }
                    
                    function guardarVentaFinal(){
                        
                                                
                        var idu_folioventa = $('#inputidu_venta').val();
                        var num_plazo = $('#txtAbonoSeleccionado').val();
                        
                          $.post('../../srvVentas', {
                            parAccion: 'guardarVentaFinal',
                            idu_venta: idu_folioventa,
                            num_plazo: num_plazo
                        }, function(responseText) {
                            var rsp = responseText.trim();
                            /*if (rsp === "0")
                                //alert("Insertado Con Exito");
                            if (rsp === "1")*/
                                //alert("Se actualizo el articulo correctamente");
                                //
                            //$('#TablaDetalleVenta').jtable('load');
                                msgGuardado();
                            
                             
                               
                               
                        });
                        
                    }
                    
                    function inicializarDatos(){
                        
                        contadorarticulosagregados = 0;
                        varidu_articulo = -1;
                        varidu_cliente = -1;
                        buscocliente = false;
                        
                        $('#inputidu_venta').val('0');
                        
                        $('#txtAbonoSeleccionado').val('');
                        
                        
                        $('#inputFiltroBusquedaArticulo').val('');
                        
                        $('#inputFiltroBusquedaCliente').val('');
                        
                        
                        
                        $('#des_rfc').html("");
                        
                        $('#txtRfc').val('');                       
                        
                       // $('#TablaDetalleVenta').jtable('load');
                        
                        $('#num_enganche').val(''); 
                        $('#num_bonificacionenganche').val(''); 
                        $('#num_total').val(''); 
                        
                         $('#btnsiguiente').show();
                         
                         
                           $('#TablaAbonos').hide();
 
                        
                    }
                    var contadorarticulosagregados;
                    function agregarDetalleVenta(){
                        
                                                
                        var idu_folioventa = $('#inputidu_venta').val();
                        
                          $.post('../../srvVentas', {
                            parAccion: 'createdetalleventa',
                            idu_venta: idu_folioventa,
                            idu_cliente: varidu_cliente,
                            idu_articulo: varidu_articulo,
                            num_cantidad: 1
                        }, function(responseText) {
                            var rsp = responseText.trim();
                            if (rsp === "0" || rsp === "2"  ){
                                
                            if (rsp === "0"){
                                //alert("Insertado Con Exito");
                                
                                 $('#mensajeGeneral').html("<strong>Bien hecho: </strong>Insertado con éxito");
                               
                                                mostrarMensajeGeneral();
                            }
                            
                            if (rsp === "2")
                                alert("No hay existencia del articulo");
                                
                                 if (rsp === "0")
                                     contadorarticulosagregados = contadorarticulosagregados + 1;
                                 
                                  $('#inputFiltroBusquedaArticulo').val('');
                                 //alert('contador registros agregados ' + contadorarticulosagregados);
                            }
                            //$('#TablaDetalleVenta').jtable('load');
                            
                            obtienedatosventa();
                            
                               
                               
                        });
                        
                    }
                    
                    function msgGuardado()
                    {
                         
                        var vardialoGuardado = $("#divMensajeGuardado").dialog({
                            width: 500,
                            height: 150,
                            title: "Mensaje",
                            modal: true,
                            buttons: {
                                 "Aceptar": function() {                                     
                                     $('#TablaArticulos').jtable('load');                            
                                     $(vardialoGuardado).dialog('close');
                                      $(vardialogArticulo).dialog('close');
                                      
                                    document.location.href = 'index.jsp';
                                }
                            }});
                    }
                    
                    function mostrarMensajeGeneral()
                    {
                         
                        var vardialogomsgneral = $("#mostrarMensajeGeneral").dialog({
                            width: 500,
                            height: 170,
                            title: "Mensaje",
                            modal: true,
                            buttons: {
                                 "Aceptar": function() {                             
                                     $(vardialogomsgneral).dialog('close');
                                }
                            }});
                    }
                    
                    function msgPreguntarSalir()
                    {
                         
                        var vardialopreguntasalir = $("#divPreguntarSalir").dialog({
                            width: 350,
                            height: 150,
                            title: "Mensaje",
                            modal: true,
                            buttons: {                                
                                  "Aceptar": function() {                                     
                                     /*$('#TablaArticulos').jtable('load');                            
                                     $(vardialoGuardado).dialog('close');
                                      $(vardialogArticulo).dialog('close');*/
                                     cancelarVenta();
                                     
                                     document.location.href = './index.jsp';
                                     //$('#TablaDetalleVenta').jtable('load');
                                     //$(vardialogArticulo).dialog('close');
                                      
                                     //$(vardialopreguntasalir).dialog('close');
                                },"Cancelar": function() {                                     
                                     /*$('#TablaArticulos').jtable('load');                            
                                     $(vardialoGuardado).dialog('close');*/
                                      $(vardialopreguntasalir).dialog('close');
                                    
                                }
                            }
                        
                            });
                    }
                    
                    function msgPreguntarBorrar(idu_detalle)
                    {
                         
                        var vardialopreguntaborrar= $("#divPreguntarBorrar").dialog({
                            width: 350,
                            height: 200,
                            title: "Eliminar Articulo",
                            modal: true,
                            buttons: {                                
                                 "Cancelar": function() {                                     
                                     /*$('#TablaArticulos').jtable('load');                            
                                     $(vardialoGuardado).dialog('close');*/
                                      $(vardialopreguntaborrar).dialog('close');
                                    
                                },
                                 "Eliminar": function() {                                     
                                     /*$('#TablaArticulos').jtable('load');                            
                                     $(vardialoGuardado).dialog('close');
                                      $(vardialogArticulo).dialog('close');*/
                                     cancelarArticulo(idu_detalle);
                                     $(vardialopreguntaborrar).dialog('close');
                                    obtienedatosventa();
                                     //document.location.href = './index.jsp';
                                     //$('#TablaDetalleVenta').jtable('load');
                                     //$(vardialogArticulo).dialog('close');
                                      
                                     //$(vardialopreguntasalir).dialog('close');
                                }
                            }
                        
                            });
                    }
                    
                    
                    function msgCantidad()
                    {
                         
                        var vardialocantidad = $("#divMensajeCantidadMayorAcero").dialog({
                            width: 500,
                            height: 150,
                            title: "Mensaje",
                            modal: true,
                            buttons: {
                                 "Aceptar": function() {                                     
                                     //$('#TablaArticulos').('load'); 
                                     
                                     //alert("maximo de datos en jtable " + $('#TablaArticulos').length());
                                     $(vardialocantidad).dialog('close');
                                     // $(vardialogArticulo).dialog('close');
                                }
                            }});
                    }
                    

                    var varidu_cliente;
                    var buscocliente;
                    $("#inputFiltroBusquedaCliente").autocomplete({
                        source: '../../srvVentas?parAccion=metClientesAutocomplete',
                        minLength: 2, //search after two characters
                        select: function(event, ui) {
                            varidu_cliente = ui.item.id;
                            $('#des_rfc').html("RFC: " + ui.item.des_rfc);
                            $('#txt_rfc').val(ui.item.des_rfc);
                            
                           //$('#inputFiltroBusquedaArticulo').focus();
                            buscocliente = true;
                            
                        }
                    });
                    
                      $( "#inputFiltroBusquedaCliente" ).focusout(function() {
                          
                          if (buscocliente != false){
                                var nombrecompleto = $('#inputFiltroBusquedaCliente').val();
                                $('#inputFiltroBusquedaCliente').val(varidu_cliente + " - " + nombrecompleto);
                            }else
                            {
                                varidu_cliente = -1;
                                $('#des_rfc').html("");
                                $('#txt_rfc').val("");
                                $('#inputFiltroBusquedaCliente').val("");
                            }
                            
                            buscocliente = false;

                      });


                   
                    
                    var varidu_articulo;
                    $("#inputFiltroBusquedaArticulo").autocomplete({
                        source: '../../srvVentas?parAccion=metArticulosAutocomplete',
                        minLength: 2, //search after two characters
                        select: function(event, ui) {
                            varidu_articulo = ui.item.id;
                        
                        }
                    });
                    
                    

                </script>
                  
                
                 <div  id="divMensajeGuardado">
                        
                        <table class="TablaMensajeGeneralLv2" align="center" border="0">
                                <tr>
                                        <td align="center">
                                          Bien hecho, se agrego satisfacoriamente
                                         <br><br> 
                                        </td>
                                </tr>
                        </table>
                </div>
                
                 <div  id="divMensajeCantidadMayorAcero">
                        
                        <table  border="1">
                                <tr>
                                        <td align="center">
                                          Proporcionar una cantidad mayor a cero
                                         <br><br>                                         
                                          
                                        </td>
                                </tr>
                        </table>
                </div>
                
                 <div  id="divPreguntarSalir">
                        
                        <table class="TablaMensajeGeneralLv2" align="center" border="0">
                                <tr>
                                        <td align="center">
                                          ¿Esta seguro que desea salir?
                                         <br><br> 
                                        </td>
                                </tr>
                        </table>
                </div>
                 <div  id="divPreguntarBorrar">
                        
                        <table class="TablaMensajeGeneralLv2" align="center" border="0">
                                <tr>
                                        <td align="center">
                                          ¿Esta seguro que desea borrar el articulo?
                                         <br><br> 
                                        </td>
                                </tr>
                        </table>
                </div>
                 <div  id="mostrarMensajeGeneral">
                        
                        <table class="TablaMensajeGeneralLv2" align="center" border="0">
                                <tr>
                                        <td align="center">
                                            <div id="mensajeGeneral"> ?????? </div>
                                         <br><br> 
                                        </td>
                                </tr>
                        </table>
                </div>
              
                
                
                </body>
                </html>

