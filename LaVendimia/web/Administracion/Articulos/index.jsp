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
        <script src="../js/jquery.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery.datetimepicker.js"></script>
        <script src="../js/jquery-ui-1.9.2.min.js"></script>
        <script src="../js/jquery-ui-1.10.3.custom.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/circular-load.css"> 
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui-1.10.3.custom.css">         
        <link rel="stylesheet" type="text/css" href="../../css/Styles.css"/>
        
        <%@include file="/WEB-INF/jspf/imports.jspf" %> 
        
        
        
        <style type="text/css">

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
            #dialogEditarDiaRuta,#dialogExamen, #dialogNuevoArticulo, #divMensajeGuardado, #dialogExamenPdf
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
                    title: 'Articulos registrados',
                    //toolbarsearch: true,
                    //pageSize: 10,
                    //toolbarsearch:true,
                    actions: {
                        listAction: '../../srvArticulos?parAccion=list',
                        //createAction: '../../srvArticulos?parAccion=create',
                        updateAction: '../../srvArticulos?parAccion=update',
                        deleteAction: '../../srvArticulos?parAccion=delete'
                    },
                    fields: {
                        ArcClaveArticulo : {
                            title: 'Clave Articulo',
                            key: true,
                            create: false,
                            edit: false,
                            list: true,
                            width: '13%',
                        },
                        ArcDescripcion: {
                            title: 'Descripción',
                            create: true,
                            edit: true,
                            list: true,
                            type: 'textarea',
                            inputClass: 'validate[required]',
                            width: '50%',
                           
                        },                        
                        ArcModelo: {
                            title: 'Modelo',
                            create: true,
                            edit: true,
                            list: false,
                            type: 'textarea',
                            inputClass: 'validate[required]'
                        },                                                
                        ArcPrecio: {
                            title: 'Precio',
                            create: true,
                            edit: true,
                            list: false,
                            type: 'label',
                            inputClass: 'validate[custom[number]]'
                        },
                        ArcExistencia:{
                            title: 'Existencia',
                            create: true,
                            edit: true,
                            list: false,
                            type: 'number',
                            inputClass: 'validate[custom[number]]'
                        }
                    },
                    formCreated: function(event, data) {

                        data.form.find('input[name="ArcDescripcion"]').prop('maxlength', '100');
                        
                        data.form.find('input[name="ArcClaveArticulo"]').css('width', '5%');
                        data.form.find('input[name="ArcDescripcion"]').css('width', '100%');
                        
                    }/*,
            //Dispose validation logic when form is closed
            formClosed: function (event, data) {
                data.form.validationEngine('hide');
                data.form.validationEngine('detach');
                alert("sdcsd");
            },
            //Validate form when it is being submitted
            formSubmitting: function (event, data) {
                
                var result = data.form.validationEngine('validate');
                
                alert(result);
                
            }*/


                });
                $('#TablaArticulos').jtable('load');
                
                

            });
            
        </script>
    </head>
    <body>
                
                <%-- NUEVO ARTICULO --%>
                <div id="dialogNuevoArticulo">
                  
                            <div class="container">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <form role="form" class="form-horizontal">
                                            
                                             <div style="float: right;" class="form-group">                         
                                                <label  type="label" id="mostrarClaveArticulo"/>
                                                <div id="mostrarFolioVentaGenerado"></div>
                                                <input type="hidden"  class="form-control" id="inputFiltroBusquedaClaveArticulo" placeholder="Clave Articulo">
                                            </div>
                                            <br>
                                            <div class="form-group">
                                                <div class="alert alert-danger text-center" style="display:none;" id="error">
                                                    <strong>Adventencia: </strong>Los datos ingresados no son correctos, favor verificar!!
                                                </div>
                                                <div class="alert alert-success text-center" style="display:none;" id="exito">
                                                    <strong>Bien Hecho: </strong>La Venta ha sido registrada.
                                                </div>  
                                            </div>
                                            <div class="form-group">

                                                <input type="hidden" id="idu_configuracion"/>

                                                <label for="des_articulo" class="control-label col-xs-4">Descripción:</label>
                                                <div class="col-xs-5">
                                                    <input id="des_articulo" name="des_articulo" type="text" class="form-control" placeholder="Escriba la descripción del articulo" onkeyup="validacion('des_articulo');" aria-describedby="inputSuccess2Status">
                                                    <span class="help-block"></span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="des_modelo" class="control-label col-xs-4">Modelo:</label>
                                                <div class="col-xs-5">
                                                    <input id="des_modelo" name="des_modelo" type="text" class="form-control" placeholder="Escriba el modelo del articulo" onkeyup="validacion('des_modelo');" aria-describedby="inputSuccess2Status">
                                                    <span class="help-block"></span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="num_precio" class="control-label col-xs-4">Precio:</label>
                                                <div class="col-xs-5">
                                                    <input id="num_precio" name="num_precio" type="text" class="form-control" placeholder="Escriba el precio del articulo" onkeyup="validacion('num_precio');" aria-describedby="inputSuccess2Status">
                                                    <span class="help-block"></span>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label for="num_existencia" class="control-label col-xs-4">Existencia:</label>
                                                <div class="col-xs-5">
                                                    <input id="num_existencia" name="num_existencia" type="text" class="form-control" placeholder="Escriba la existencia" onkeyup="validacion('num_existencia');" aria-describedby="inputSuccess2Status">
                                                    <span class="help-block"></span>
                                                </div>
                                            </div>

                                             <div class="form-group">
                                                <label for="codigo" class="control-label col-xs-4"></label>

                                              <%--  <div class="col-xs-5">
                                                    <button type="button" class="btn btn-primary" onclick='mostrarMensajeSalida();'><span class="glyphicon glyphicon-lock"></span> Cancelar</button>   
                                                    <button type="button" class="btn btn-primary" onclick='verificar();'><span class="glyphicon glyphicon-lock"></span> Guardar</button>   
                                                </div>
                                                    --%>

                                            </div> 

                                        </form>
                                    </div>

                                </div>
                            </div>
                            
                            
                            <script type="text/javascript">
                                var v=true;
                                $("span.help-block").hide();

                                function verificar(){
                                        
                                    var v1=0,v2=0,v3=0,v4=0;
                                    v1=validacion('des_articulo');
                                    v2=validacion('des_modelo');
                                    v3=validacion('num_precio');
                                     v4=validacion('num_existencia');

                                    if (v1===false || v2===false || v3===false || v4===false ) {
                                         $("#exito").hide();
                                         $("#error").show();
                                    }else{
                                        $("#error").hide();
                                        /*$("#exito").show();*/

                                        guardarArticulo();
                                    }

                                } 

                                function validacion(campo){
                                    var a=0;
                                    
                                    if (campo==='des_articulo'){
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
                                    if (campo==='des_modelo'){
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
                                    if (campo==='num_precio')
                                    {
                                        codigo = document.getElementById(campo).value;
                                        if( codigo == null || codigo.length == 0 || /^\s+$/.test(codigo) ) {
                                            $("#glypcn"+campo).remove();
                                            $('#'+campo).parent().parent().attr("class", "form-group has-error has-feedback");
                                            $('#'+campo).parent().children('span').text("Ingrese algo").show();
                                            $('#'+campo).parent().append("<span id='glypcn"+campo+"' class='glyphicon glyphicon-remove form-control-feedback'></span>");
                                            return false;

                                        }
                                        else
                                        {
                                            if(isNaN(codigo)) {

                                                $("#glypcn"+campo).remove();
                                                $('#'+campo).parent().parent().attr("class", "form-group has-error has-feedback");
                                                $('#'+campo).parent().children('span').text("No Acepta letras").show();
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

                                    if (campo==='num_existencia')
                                    {
                                        codigo = document.getElementById(campo).value;
                                        if( codigo == null || codigo.length == 0 || /^\s+$/.test(codigo) ) {
                                            $("#glypcn"+campo).remove();
                                            $('#'+campo).parent().parent().attr("class", "form-group has-error has-feedback");
                                            $('#'+campo).parent().children('span').text("Ingrese algo").show();
                                            $('#'+campo).parent().append("<span id='glypcn"+campo+"' class='glyphicon glyphicon-remove form-control-feedback'></span>");
                                            return false;

                                        }
                                        else
                                        {
                                            if(isNaN(codigo)) {

                                                $("#glypcn"+campo).remove();
                                                $('#'+campo).parent().parent().attr("class", "form-group has-error has-feedback");
                                                $('#'+campo).parent().children('span').text("No Acepta letras").show();
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


                                }
                            </script>       
                            
                           

                </div>
                
                
                <div style="margin:15px;" class="row">
                    <button  type="button" style="float: right;" title="Registro de Articulos" class="btn btn-success btn-sm" onclick="nuevoArticulo()"><span class="glyphicon glyphicon-plus-sign"></span>     Nuevo</button>
                </div>
                <div id="TablaArticulos"></div>
                <script>
                    
                    function cerrarArticulos(){                      
                        
                           
                            $.post('../../srvArticulos', {
                                parAccion: 'delete',
                                idu_articulo: claveArticulo
                               
                            },
                                function(responseText) {
                                
                               //alert("Termino de borrar articulo");  

                               
                            });
                        
                    }
                    
                    var claveArticulo;
                    
                    function generarClaveArticulo(){
                   
                            var UsuCodigo = $('#inputCodigo').val();
                            var UsuClave = $('#inputClave').val();
                            var UsuNombre = $('#inputNombre').val();
                            var UsuApellidoPaterno = $('#inputApellidoPaterno').val();
                            var UsuApellidoMaterno = $('#inputApellidoMaterno').val();
                            var UsuNroDocumento = $('#inputNroDocumento').val();
                            $.post('../../srvArticulos', {
                                parAccion: 'generarclavearticulo',
                                UsuCodigo: UsuCodigo,
                                UsuClave: UsuClave,
                                UsuNombre: UsuNombre,
                                UsuApellidoPaterno: UsuApellidoPaterno,
                                UsuApellidoMaterno: UsuApellidoMaterno,
                                UsuNroDocumento: UsuNroDocumento
                            },
                                function(responseText) {
                                
                                var arr = [];
                                    json = JSON.stringify(eval('(' + responseText + ')')); //convert to json string
                                    arr = $.parseJSON(json); //convert to javascript array
                                
                                    claveArticulo = arr[0].cve_articulo;
                                     
                                     $('#inputFiltroBusquedaClaveArticulo').val(claveArticulo);
                                     
                                     $('#mostrarFolioVentaGenerado').html("<h1><p>Clave: "+ claveArticulo +" <p></h1>");
                                     
                                     
                                     
                                //alert(arr[0].cve_articulo);
                                
                                /*var updatedJson = responseText;

    updatedJson.data = [updatedJson.data];
  var objJson = JSON.stringify(updatedJson);
          */
        
  

                                /*if (responseText.trim() < '-1') {
                                    alert('Hubo un error al Registrar');
                                }
                                else{                                   
                                    alert(responseText);
                                    alert('Usuario Registrado con Exito');
                                    parent.location.href = "/LaVendimia/";
                                }*/
                            });

                        /*$("#inputFiltroBusquedaClaveArticulo").autocomplete({
                            source: '../../srvArticulos?parAccion=generarclavearticulo',
                            minLength: 2, //search after two characters
                            select: function(event, ui) {
                                claveArticulo = ui.item.cve_articulo;
                                alert("Folio de clave de articulo generado");
                                alert(claveArticulo);
                            }
                        });*/
                        
                      /*  $.post('../../srvArticulos', {
                                parAccion: 'create',
                                des_articulo: des_articulo,
                                des_modelo: des_modelo,
                                num_precio: num_precio,
                                num_existencia: num_existencia,
                                idu_articulo: idu_articulo
                            }, function(responseText) {
                                var rsp = responseText.trim();
                                if (rsp === "1")
                                    alert("Insertado Con Exito");
                                $('#TablaArticulos').jtable('load');                            
                              
                                //$("#botonGuardarViajeCompleto").prop('disabled', false);
                            });*/
                         
                            
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
                                parAccion: 'createEnAgregar',
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
                                          alert("Error al guardar, verificar!!");
                                    }
                                
                                /*if (rsp === "1")
                                    alert("Insertado Con Exito");
                                    mostraMensajeGuardado();
                                $('#TablaArticulos').jtable('load');                            
                                $(vardialogArticulo).dialog('close');*/
                                //$("#botonGuardarViajeCompleto").prop('disabled', false);
                            });
                            
                        }
                        //alert(preguntas);
                        //alert(alternativas);
                        //alert(nombreExamen);
                        
                    }
                    var vardialogArticulo;
                    function nuevoArticulo()
                    {
                        //alert('');
                        generarClaveArticulo();
                        
                        vardialogArticulo = $("#dialogNuevoArticulo").dialog({
                            width: '100%',
                            height: '450',
                            title: "Registro de Articulos",
                            modal: true,
                            buttons: {
                                 "Cancelar": function() {
                                     cerrarArticulos();
                                     //$('#TablaArticulos').jtafble('load');                            
                                     $(vardialogArticulo).dialog('close');
                                },
                                "Guardar": function() {
                                    //guardarArticulo();
                                    verificar();
                                }
                            }});
                    }
                    
                    function msgGuardado()
                    {
                         
                        var vardialoGuardado = $("#divMensajeGuardado").dialog({
                            width: 400,
                            height: 200,
                            title: "Mensaje",
                            modal: true,
                            buttons: {
                                 "Aceptar": function() {                                     
                                     $('#TablaArticulos').jtable('load');                            
                                     $(vardialoGuardado).dialog('close');
                                      $(vardialogArticulo).dialog('close');
                                }
                            }});
                    }
                    
                   
                </script>
                  
                <div  id="divMensajeGuardado">
                        
                        <table class="TablaMensaje1" border="0">
                                <tr>
                                        <td align="center">
                                            Bien hecho, se agrego satisfactoriamente
                                          <br><br>                                         
                                          
                                        </td>
                                </tr>
                        </table>
                </div>
              
                
                
                </body>
                </html>

