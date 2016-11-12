<%-- 
    Document   : main
    Created on : 07-Nov-2016, 10:54:12
    Author     : Lazalde
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.10.4.custom.min.css"> 
<%@include file="/WEB-INF/jspf/imports.jspf" %> 
        <title>Ingreso</title>
    </head>
    <body>
        <script language="Javascript">
            function registrarUsuario()
            {
                var UsuCodigo = $('#inputCodigo').val();
                var UsuClave = $('#inputClave').val();
                var UsuNombre = $('#inputNombre').val();
                var UsuApellidoPaterno = $('#inputApellidoPaterno').val();
                var UsuApellidoMaterno = $('#inputApellidoMaterno').val();
                var UsuNroDocumento = $('#inputNroDocumento').val();
                $.post('srvUsuarios', {
                    parAccion: 'create2',
                    UsuCodigo: UsuCodigo,
                    UsuClave: UsuClave,
                    UsuNombre: UsuNombre,
                    UsuApellidoPaterno: UsuApellidoPaterno,
                    UsuApellidoMaterno: UsuApellidoMaterno,
                    UsuNroDocumento: UsuNroDocumento
                }, function(responseText) {
                    if (responseText.trim() === '1') {
                        alert('Usuario Registrado con Exito');
                        parent.location.href = "/LaVendimia/";
                    }
                    else
                        alert('Hubo un error al Registrar');
                });
            }
        </script>
        <div class="panel panel-primary" style="border-color: #42BE33; width: 300px;margin:0 auto;">
            <div class="panel-body text-left" >
                <div class="col" >                    
                    <label class="control-label" for="inputCodigo">Código</label>
                    <input class="form-control" type="text" id="inputCodigo">
                    <label class="control-label" for="inputClave">Clave</label>
                    <input class="form-control"  id="inputClave" >
                    <label class="control-label" for="inputNombre">Nombres</label>
                    <input class="form-control"  id="inputNombre" >
                    <label class="control-label" for="inputApellidoPaterno">Ape.Paterno</label>
                    <input class="form-control"  id="inputApellidoPaterno" >
                    <label class="control-label" for="inputApellidoMaterno">Ape.Materno</label>
                    <input class="form-control"  id="inputApellidoPaterno" >
                    <label class="control-label" for="inputNroDocumento">Nro.Documento</label>
                    <input class="form-control"  id="inputNroDocumento" >
                    <br>
                    <button class="form-control" onclick="registrarUsuario();" type="button">Registrar</button>

                </div>
            </div>

        </div>
    </body>
</html>
