<%-- 
    Document   : main
    Created on : 07-Nov-2016, 10:38:33
    Author     : Lazalde 
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/WEB-INF/jspf/acceso.jspf" %>  
        <%-- <link href="css/bootstrap-combined.min.css" rel="stylesheet"> --%> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/jquery.js"></script>
        <!--<script type="text/javascript" src="js/jquery-ui-1.9.2.min.js"></script>
        -->

        <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.10.3.custom.js"></script>
        <link rel="stylesheet" href="css/jquery-ui-1.10.4.custom.min.css" />
        
      


        <link rel="stylesheet" type="text/css" href="css/aciTree.css" media="all">
        <%--<link rel="stylesheet" type="text/css" href="css/demo.css" media="all">
        <script type="text/javascript" src="js/jquery.min.js"></script>--%>
        <script type="text/javascript" src="js/jquery.aciPlugin.min.js"></script>
        <script type="text/javascript" src="js/jquery.aciTree.min.js"></script>

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">
        <script src="js/bootstrap.min.js"></script>

        <title>Gestión de Ventas</title>
        <style>
            html {
                height: 100%;
                margin: 0px auto;
                padding: 0;
            }
            body {
                height: 100%;
                margin: 0px auto;
                padding: 0;

                //font-family: sans-serif;
                font-size: 10px;
            }
            #contenedor {
                height: calc(100% - 5px);
            }
            #cabecera {
                height: 50px;
                padding-bottom: 5px;


            }
            #menu {
                float: left;
                width: 17%;
                height: calc(100% - 45px);

            }
            #contenido {
                float: left;
                width: 83%;
                overflow: auto;
                height: calc(100% - 45px);
                border-bottom: 2px solid rgb(224,224,224);

            }

            /*FIN ESTRUCTURA*/
            input, select
            {
                box-sizing: border-box;
                -moz-box-sizing: border-box;
                -webkit-box-sizing: border-box;
            }

            /*CABECERA*/

            /*FIN CABECERA*/
            /*MENU*/
            /*#selector {

                font-size: 10px;

            }*/
            #menu-container {
                /*width: 100%;*/
                border-right: 5px solid rgb(224,224,224);
                border-bottom: 2px solid rgb(224,224,224);
                height: calc(100% - 20px);
                font-family: sans-serif;
                overflow: auto;
            }
            #menu-cabecera {
                height: 20px;
                width: 100%;
                font-size: 12px;

                background: #f0f9ff; /* Old browsers */
                background: -moz-linear-gradient(top,  #f0f9ff 0%, #e0e0e0 47%, #c8c8c8 100%); /* FF3.6+ */
                background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f0f9ff), color-stop(47%,#e0e0e0), color-stop(100%,#c8c8c8)); /* Chrome,Safari4+ */
                background: -webkit-linear-gradient(top,  #f0f9ff 0%,#e0e0e0 47%,#c8c8c8 100%); /* Chrome10+,Safari5.1+ */
                background: -o-linear-gradient(top,  #f0f9ff 0%,#e0e0e0 47%,#c8c8c8 100%); /* Opera 11.10+ */
                background: -ms-linear-gradient(top,  #f0f9ff 0%,#e0e0e0 47%,#c8c8c8 100%); /* IE10+ */
                background: linear-gradient(to bottom,  #f0f9ff 0%,#e0e0e0 47%,#c8c8c8 100%); /* W3C */
                filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f0f9ff', endColorstr='#c8c8c8',GradientType=0 ); /* IE6-9 */

                /*height: 20px;*/
            }
            #divArbol {

                /*height: calc(100%-20px);*/
                /*width: 100%;*/
            }
            /*spanArbolOculto*/
            #btnSize {
                cursor: pointer;
                cursor: hand;
                /*height: calc(100%-20px);*/
                /*width: 100%;*/
            }

            /*FIN MENU*/
            /*PIE*/

            /*FIN PIE*/


            /*#container {
                
                width: 100%;
                height: 100%;
                //height: calc(100% - 2px);

            }*/



        </style>

   <%-- Relog y fecha --%>     
   <script language="JavaScript" type="text/javascript">
  
    function show5(){
            if (!document.layers&&!document.all&&!document.getElementById)
            return

             var Digital=new Date()
            
             var hours=Digital.getHours()
             var minutes=Digital.getMinutes()
             var seconds=Digital.getSeconds()

            var dn="PM"
            if (hours<12)
            dn="AM"
            if (hours>12)
            hours=hours-12
            if (hours==0)
            hours=12

             if (minutes<=9)
             minutes="0"+minutes
             if (seconds<=9)
             seconds="0"+seconds
            //change font size here to your desire
            myclock="<b> :   "+hours+":"+minutes+":"
             +seconds+" "+dn+"</b>"
            if (document.layers){
            document.layers.liveclock.document.write(myclock)
            document.layers.liveclock.document.close()
            }
            else if (document.all)
            liveclock.innerHTML=myclock
            else if (document.getElementById)
            document.getElementById("liveclock").innerHTML=myclock
            setTimeout("show5()",1000)
         }
        window.onload=show5
  
 </script>


        <script>



            function alertaTras5seg() {
//setTimeout(mostrarAlerta, 5000);
//setInterval(mostrarAlerta,180000);
                ///setInterval(comprobarSesion, 61000);
            }
            $(document).ready(function() {
                metNroExamenesPendientes();
                $('#menu').resizable({handles: 'e, w',
                    start: function(event, ui) {
                        $('#contenido').hide();
                    },
                    stop: function(event, ui) {
                        var size = $('#menu').css('width');
                        $('#contenido').css('width', parseInt($(window).width()) - parseInt(size));
                        $('#contenido').show();
                    }
                });
                $("#menu").resizable("option", "minWidth", 200);
                $('#selector').css('font-family', 'sans-serif');
                $('#selector').css('font-size', '10px');
                //
                //$('#container').attr("src", "container-main.jsp");



                //MENU SLIDE
                $('#btnSize').click(function() {
                    //transform: rotate(-90deg);
                    if ($('#btnSize span').text() == "<<")
                    {
                        $("#menu-cabecera > span").hide('fast');
                        $("#menu").animate({width: '27px'}, {
                            duration: 500,
                            complete: function() {
                                $("#contenido").css('width', 'calc(100% - 27px)');
                                $('#btnSize span').text('>>');
                            }
                        });
                        $("#divArbol").hide();
                    } else {
                        $("#menu").animate({width: '15%'}, {
                            duration: 500,
                            complete: function() {
                                $("#contenido").css('width', '85%');
                                $("#menu-cabecera > span").show('fast');
                                $('#btnSize span').text('<<');
                            }
                        });
                        $("#divArbol").show();
                    }

                });
            });
            function metNroExamenesPendientes()
            {
                
                $.post('srvVirtuales', {
                    parAccion: 'metGetNroPendientes'
                }, function(rsp)
                {
                    $('#idNroPendientes').html(rsp);
                    setTimeout("metNroExamenesPendientes()", 10000);
                });
            }
            function desplegarMenu()
            {
                //$('#btnSize').click();
            }

        </script>
        <style>

            * {
                margin:0px;
                padding:0px;
            }

            #header {
                margin:auto;
                width:500px;
                font-family:Arial, Helvetica, sans-serif;
            }

            ul, ol {
                list-style:none;
            }

            .nav > li {
                float:left;
            }

            .nav li a {
                background-color:#000;
                color:#fff;
                text-decoration:none;
                padding:10px 12px;
                display:block;
            }

            .nav li a:hover {
                background-color:#434343;
            }

            .nav li ul {
                display:none;
                position:absolute;
                min-width:140px;
            }

            .nav li:hover > ul {
                display:block;
            }

            .nav li ul li {
                position:relative;
            }

            .nav li ul li ul {
                right:-140px;
                top:0px;
            }

        </style>
    </head>
    <body >
        <div id="contenedor">
            <div id="cabecera" 
                 style="
                 border-color: #252525;
                 ">
                <%                    String varUsuNombre = session.getAttribute("session_usu_nombre").toString();
                %>

                <div  >
                    <div  style="
                          background:#000 ;

                          box-shadow: inset 0 1px 0 0 rgba(255, 255, 255, 0.5);
                          border: 1px solid;
                          padding: 10px 0px 10px;
                          "> <%--#707070 --%>                  
                        <div style="width: 100%">
                            <a href="#" style="
                               font-family: sans-serif;
                               color: #f0f9ff;text-align:left;
                               font-size: 20px;
                               width: 100%;
                               text-decoration: none;
                               text-rendering: optimizelegibility;" >
                                  La Vendimia <%/*= varEmpNombre + "- "*/%> <%=   " - " + varUsuNombre%>
                            </a>
                            <div style="float: right; padding: 10px 5px;" >

                                <a href = "srvIniciarSesion?parAccion=cerrar_sesion"  
                                   style="text-decoration: none;font-size: 11.9px;

                                   font-weight: bold;
                                   text-rendering: optimizelegibility;" >
                                    <font color="#f0f9ff">Cerrar Sesión</font>
                                </a> 
                                <font color="#EAF88D">|</font>
                                <%--<a  onclick="desplegarMenu();"
                                    target="container" href = "Maestros/Usuarios/cambiarPassword.jsp"
                                    style="text-decoration: none;font-size: 11.9px;

                                    font-weight: bold;
                                    text-rendering: optimizelegibility;
                                    " >
                                    <font color="#EAF88D"  >Cambiar Contraseña</font>
                                    
                                </a> --%>
                                
                                <font color="#f0f9ff"  >
                                   <script type="text/javascript"> var meses = new Array ("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"); var diasSemana = new Array("Domingo","Lunes","Martes","Miércoles","Jueves","Viernes","Sábado"); var f=new Date(); document.write(diasSemana[f.getDay()] + " " + f.getDate() + " de " + meses[f.getMonth()] + " de " + f.getFullYear()); </script>
                                   <span id="liveclock" style="left:0;top:0; font-size:10px; font-family:'Lucida Sans'"></span>
                                </font>
                            </div>

                           <%-- <div style="float: right;">
                                <a class="btn btn-success" target="container" href = "Perfil/ExamenesPendientes/" >
                                    Pendientes&nbsp;<span class="badge"><div id="idNroPendientes"></div></span>
                                </a>
                            </div> --%>




                        </div>

                    </div>
                </div>

            </div>
            <div id="menu">
                <div id="menu-cabecera" >
                    <span style="position: relative; top: 2px; padding-left: 10px;" ><b>Gestión de Ventas</b></span>
                    <button id="btnSize" type="button" style="margin-right: 2px; float: right; height: 18px; width: 20px;"><span style="position: relative; left: 0px; top: 0;" ><<</span></button>
                </div>
                <div id="menu-container">

                    <div id="divArbol">


                        <div id="tree" class="aciTree" >

                        </div>
                        <script type="text/javascript">
                            $(function() {
                                // init the tree
                                $('#tree').aciTree({
                                    ajax: {
                                        url: 'srvIniciarSesion?parAccion=getMenu'//'Menu/Arbol.json'
                                    },
                                    itemHook: function(parent, item, itemData, level) {
                                        if (!itemData.inode) {
                                            // a custom item implementation to show a link
                                            this.setLabel(item, {
                                                label: '<a  href="' + itemData['my-url'] + '" target="container" onclick="desplegarMenu();" title="Abrir ' + itemData.label + '">' + itemData.label + '</a>'
                                            });
                                        }
                                    }
                                });

                            });
                        </script>
                    </div>
                </div>
            </div>

            <div id="contenido" >
                <iframe  id="container"  width="100%" height="99%"   frameBorder="0" name="container"></iframe>
            </div>
        </div>

    </body>
</html>
