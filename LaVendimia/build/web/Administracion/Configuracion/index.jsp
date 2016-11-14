

<link rel="stylesheet" href="../../css/bootstrap.min.css">

 <script language="Javascript">
                 
            function actualizarConfiguracion()
            {
                
                var num_tasafinanciamiento = $('#num_tasafinanciamiento').val();
                var num_porcentajeenganche = $('#num_porcentajeenganche').val();
                var num_plazomaximo = $('#num_plazomaximo').val();
                var idu_configuracion = $('#idu_configuracion').val();
                
                $.post('../../srvConfiguracion', {
                    parAccion: 'create',
                    num_tasafinanciamiento: num_tasafinanciamiento,
                    num_porcentajeenganche: num_porcentajeenganche,
                    num_plazomaximo: num_plazomaximo,
                    idu_configuracion: idu_configuracion
                }, function(responseText) {
                    
                                     var arr = [];
                                    json = JSON.stringify(eval('(' + responseText + ')')); //convert to json string
                                    arr = $.parseJSON(json); //convert to javascript array
                                    
                                    var result = arr.Result;
                                    if (result=== "OK"){
                                         $("#error").hide();
                                         $("#exito").show();
                                    }
                                    
                                    var records = arr.Records;                                    
                                    
                                    //alert(records.length);
                                    if (records.length!=0){
                                        //alert(records[0].num_tasafinanciamiento);
                                        
                                        varnum_tasafinanciamiento = records[0].num_tasafinanciamiento;
                                        varnum_porcentajeenganche = records[0].num_porcentajeenganche;
                                        varnum_plazomaximo = records[0].num_plazomaximo;
                                        
                                        $('#num_tasafinanciamiento').val(varnum_tasafinanciamiento);
                                        $('#num_porcentajeenganche').val(varnum_porcentajeenganche);
                                        $('#num_plazomaximo').val(varnum_plazomaximo);
                                        
                                        
                                    }
                                    else{
                                        
                                       /* $('#num_tasafinanciamiento').val("3131");
                                        $('#num_porcentajeenganche').val("234");
                                        $('#idu_configuracion').val("34");*/
            
                                        varidu_configuracion = "";
                                    }
                    
                    
                    if (responseText.trim() === '1') {
                        //alert('Usuario Registrado con Exito');
                        //parent.location.href = "/LaVendimia/";
                        $("#error").hide();
                        $("#exito").show();
                    }
                    else
                        alert('Hubo un error al Registrar');
                });
            }
            
            var varidu_configuracion;
            var varnum_tasafinanciamiento;
            var varnum_porcentajeenganche;
            var varnum_plazomaximo;
            function obtenerConfiguracion()
            {     
                
                $.post('../../srvConfiguracion', {
                    parAccion: 'list'                  
                }, function(responseText) {
                    if (responseText.trim().length != '0') {
                        
                        //alert(responseText);
                       
                        //parent.location.href = "/LaVendimia/";
                                    var arr = [];
                                    json = JSON.stringify(eval('(' + responseText + ')')); //convert to json string
                                    arr = $.parseJSON(json); //convert to javascript array
                                
                                    var records = arr.Records;                                    
                                    
                                    //alert(records.length);
                                    if (records.length!=0){
                                        
                                        varnum_tasafinanciamiento = records[0].num_tasafinanciamiento;
                                        varnum_porcentajeenganche = records[0].num_porcentajeenganche;
                                        varnum_plazomaximo = records[0].num_plazomaximo;
                                        varidu_configuracion = records[0].idu_configuracion; 
                                        
                                        $('#num_tasafinanciamiento').val(varnum_tasafinanciamiento);
                                        $('#num_porcentajeenganche').val(varnum_porcentajeenganche);
                                        $('#num_plazomaximo').val(varnum_plazomaximo);
                                        $('#idu_configuracion').val(varidu_configuracion);
                                        
                                    }
                                    else{
                                      
                                        varidu_configuracion = "";
                                    }
                                   
                                     //$('#inputFiltroBusquedaClaveArticulo').text = claveArticulo;
                    }
                    
                });
            }
        </script>

        <body onload="obtenerConfiguracion();">
    <!--Barra de Navegacion-->
    <nav class="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Cambiar Navegacion</span>
                <span class="icon-bar"></span>
           dsdfdsf
            </button>
            
           
        </div>

       
    </nav>
    
     <div  style="
                          background:#0081c2 ;

                          box-shadow: inset 0 1px 0 0 rgba(255, 255, 255, 0.5);
                          border: 1px solid;
                          padding: 10px 0px 10px;
                          width: 90%
                   
                          "> <%--#707070 --%>      
             <div style="width: 80%">
                            <a href="#" style="
                               font-family: sans-serif;
                               color: #FFF;text-align:left;
                               font-size: 15px;
                               width: 80%;
                               text-decoration: none;
                               text-rendering: optimizelegibility;" >
                                Configuración general 
                            </a>
             </div>
             </div>
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <form role="form" class="form-horizontal">
                    <div class="form-group">
                        <div class="alert alert-danger text-center" style="display:none;" id="error">
                            <strong>Adventencia: </strong>Los datos ingresados nos son correctos, favor verificar
                        </div>
                        <div class="alert alert-success text-center" style="display:none;" id="exito">
                            <strong>Bien Hecho: </strong>La Configuración ha sido registrada.
                        </div>  
                    </div>
                    <div class="form-group">
                        
                        
                        <input type="hidden" id="idu_configuracion"/>
                        
                        <label for="num_tasafinanciamiento" class="control-label col-xs-4">Tasa financiamiento:</label>
                        <div class="col-xs-5">
                            <input id="num_tasafinanciamiento" name="num_tasafinanciamiento" type="text" class="form-control" placeholder="Escriba la tasa de financiamiento" onkeyup="validacion('num_tasafinanciamiento');" aria-describedby="inputSuccess2Status">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="num_porcentajeenganche" class="control-label col-xs-4">% Enganche:</label>
                        <div class="col-xs-5">
                            <input id="num_porcentajeenganche" name="num_porcentajeenganche" type="text" class="form-control" placeholder="Escriba el porcentaje de enganche" onkeyup="validacion('num_porcentajeenganche');" aria-describedby="inputSuccess2Status">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="num_plazomaximo" class="control-label col-xs-4">Plazo Máximo:</label>
                        <div class="col-xs-5">
                            <input id="num_plazomaximo" name="num_plazomaximo" type="text" class="form-control" placeholder="Escriba el número de plazo máximo" onkeyup="validacion('num_plazomaximo');" aria-describedby="inputSuccess2Status">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    
                     <div class="form-group">
                        <label for="codigo" class="control-label col-xs-4"></label>
                                               
                        <div class="col-xs-5">
                            <button type="button" class="btn btn-primary" onclick='mostrarMensajeSalida();'><span class="glyphicon glyphicon-remove-circle"></span> Cancelar</button>   
                            <button type="button" class="btn btn-primary" onclick='verificar();'><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>   
                        </div>
                        
                       
                    </div> 
                                   
                </form>
            </div>
            
        </div>
    </div>
    <script type="text/javascript" src="../../js/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="../../js/bootstrap.min.js"></script>
   
    <script type="text/javascript">
        var v=true;
        $("span.help-block").hide();

        function verificar(){

            var v1=0,v2=0,v3=0;
            v1=validacion('num_tasafinanciamiento');
            v2=validacion('num_porcentajeenganche');
            v3=validacion('num_plazomaximo');
            
            if (v1===false || v2===false || v3===false ) {
                 $("#exito").hide();
                 $("#error").show();
            }else{
                /*$("#error").hide();
                $("#exito").show();*/
                
                actualizarConfiguracion();
            }
            
        } 
        
        function validacion(campo){
            var a=0;
            
            if (campo==='num_tasafinanciamiento')
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
            
            if (campo==='num_porcentajeenganche')
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
            
            if (campo==='num_plazomaximo')
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
</body>
</html>
