<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONObject"%>
<!DOCTYPE html>
<html>
    <head>
        <title>MANTENIMIENTO LA VENDIMIA</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="stylesheet" type="text/css" href="../../css/Styles.css"/>
        <link href="../../js/jtable.2.3.1/themes/lightcolor/blue/jtable.css" rel="stylesheet" type="text/css" />

        
<%@include file="/WEB-INF/jspf/imports.jspf" %> 
        <script type="text/javascript">
            
             $(document).ready(function() {

                //Prepare jTable
                $('#TablaClientes').jtable({
                    title: 'Clientes registrados',
                    //toolbarsearch: true,
                    //pageSize: 10,
                    //toolbarsearch:true,
                    actions: {
                        listAction: '../../srvClientes?parAccion=list',
                        createAction: '../../srvClientes?parAccion=create',
                        updateAction: '../../srvClientes?parAccion=update',
                        deleteAction: '../../srvClientes?parAccion=delete'
                    },
                    fields: {
                        ArcId : {
                            title: 'Clave Cliente',
                            key: true,
                            create: false,
                            edit: false,
                            list: true
                        },
                        ArcNombre: {
                            title: 'Nombre',
                            create: true,
                            edit: true,
                            list: true,
                            type: 'textarea',
                            inputClass: 'validate[required]'
                           
                        },                        
                        ArcApellidoPaterno: {
                            title: 'Apellido Paterno',
                            create: true,
                            edit: true,
                            list: false,
                            type: 'textarea',
                            inputClass: 'validate[required]'
                        },                                                
                        ArcApellidoMaterno: {
                            title: 'Apellido Materno:',
                            create: true,
                            edit: true,
                            list: false,
                            type: 'textarea',
                            inputClass: 'validate[required]'
                        },
                        ArcRFC:{
                            title: 'RFC',
                            create: true,
                            edit: true,
                            list: false,
                            type: 'textarea',
                            inputClass: 'validate[required]'
                        }
                    },
                    formCreated: function(event, data) {

                        data.form.find('input[name="ArcNombre"]').prop('maxlength', '100');
                        

                        data.form.find('input[name="ArcNombre"]').css('width', '100%');
                        
                    }
                });
                $('#TablaClientes').jtable('load');
               
            });
            
        </script>

        <style>
            .ui-dialog .ui-widget-header,.ui-widget-header
            {
                background: #42BE33;
                border: 1px solid;
            }
            
        </style>
        <script >
             function cambiarHeighIframe(nombreContenedor)
             {
                 alert(nombreContenedor);
                 var hc=$('#'+nombreContenedor).height();
                 alert(hc);
                 $('#idContenedor').height(hc);
             }
        </script>
    </head>
    <body>
        
         <%--                    String varOperacion = session.getAttribute("session_operacion").toString();
                --%>
        
         <!-- div transparente -->
    <div  style="position:absolute; top:0px; left:0px; z-index:11; background-color:#000; display:none; opacity:0;-moz-opacity:0;filter:alpha(opacity=0)" id="divTransparente"></div>
   
        <div id="TablaClientes"></div>
                    
    
                
    
    </body>
</html>
