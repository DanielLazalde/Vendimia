/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Login;

import herramientas.clsConexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 *
 * @author CometO
 */
//@WebServlet(name = "srvIniciarSesion", urlPatterns = {"/srvIniciarSesion"})
public class srvIniciarSesion extends HttpServlet {

    private clsConexion varClsConexion;
    private PreparedStatement pstmt;
    private String varNombreEsquema = "vendimiadb";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String varAccion = request.getParameter("parAccion");
        if (varAccion.equals("cerrar_sesion")) {
            metCerrarSesion(request, response);
            return;
        }
        try {
            
            System.out.println("ENTROOOOO -- Login.srvIniciarSesion.processRequest() varAccion -->" + varAccion);
            HttpSession session = request.getSession();
            if (varAccion.equals("getMenu")) {
                System.out.println("GET MENUUUUU");
                String administrador = session.getAttribute("session_usu_administrador").toString();
                if (administrador.equals("true")) {
                    out.print(metMenuAdministrador());
                } else {
                    out.print(metMenuVendedor());
                }
            } else if (varAccion.equals("consulta")) {
                String consulta = "SELECT "
                        + "CONCAT(usu_nombre,' ',usu_apellido_paterno,' ',usu_apellido_materno) usu_nombre,"
                        + "usu_codigo,"
                        + "usu_administrador "
                        + "FROM "+varNombreEsquema+".tbl_usuarios_usu  "
                        + "WHERE "
                        + "usu_codigo=(?) "
                        + "AND "
                        + "usu_clave=(?);";
                varClsConexion = new clsConexion();
                pstmt = varClsConexion.getConexion().prepareStatement(consulta);
                pstmt.setString(1, request.getParameter("parCodigo").toString());
                pstmt.setString(2, request.getParameter("parContrasenha").toString());
                ResultSet varResultado = pstmt.executeQuery();
                boolean hayUsuario = false;
                String varNombreUsuario = "", varCodigoUsuario = "";
                Boolean varAdministrador = false;
                while (varResultado.next()) {
                    hayUsuario = true;
                    varNombreUsuario = varResultado.getString("usu_nombre");
                    varCodigoUsuario = varResultado.getString("usu_codigo");
                    varAdministrador = varResultado.getBoolean("usu_administrador");
                }
                varResultado.close();
                varResultado = null;
                pstmt.close();
                pstmt = null;
                varClsConexion.closeConexion();
                session.setAttribute("session_usu_codigo", varCodigoUsuario);
                session.setAttribute("session_usu_nombre", varNombreUsuario);
                session.setAttribute("session_usu_administrador", varAdministrador);
                
                System.out.println("HAY USUARIO");
                out.print(hayUsuario);
                
                
            }

        } catch (SQLException ex) {

            Logger.getLogger(srvIniciarSesion.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
        }
    }
    private PrintWriter varOut = null;

    private void metCerrarSesion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("/LaVendimia/");

    }

    
    public String metMenuAdministrador() {
        
        System.out.println("ENTRO MENU ADMINISTRADR --> Login.srvIniciarSesion.metMenuAdministrador()");
        String menu = "[\n"
                + "    {\"id\":19,\"label\":\"INICIO\",\"inode\":true,\"open\":false,\"branch\":\n"
                + "[\n"
                + "{\"id\":32,\"label\":\"Ventas\",\"inode\":false,\"my-hash\":\"hash-5\",\"my-url\":\"Administracion/Ventas/\"},\n"
                + "{\"id\":33,\"label\":\"Clientes\",\"inode\":false,\"my-hash\":\"hash-5\",\"my-url\":\"Administracion/Clientes/\"},\n"
                + "{\"id\":34,\"label\":\"Articulos\",\"inode\":false,\"my-hash\":\"hash-5\",\"my-url\":\"Administracion/Articulos/\"},\n"
                + "{\"id\":35,\"label\":\"Configuracion\",\"inode\":false,\"my-hash\":\"hash-5\",\"my-url\":\"Administracion/Configuracion/\"}\n"
                + "\n"
                + "],\n"
                + "\"my-hash\":\"hash-1\",\"my-url\":\"sample.php?request=page-1\"}\n"               
                + "]";

        return menu;
    }
    
    public String metMenuVendedor() {
         System.out.println("ENTRO MENU VENDEDOR --> Login.srvIniciarSesion.metMenuAdministrador()");
        String menu = "[\n"
                + "    {\"id\":19,\"label\":\"INICIO\",\"inode\":true,\"open\":false,\"branch\":\n"
                + "[\n"
                + "{\"id\":32,\"label\":\"Ventas\",\"inode\":false,\"my-hash\":\"hash-5\",\"my-url\":\"Administracion/Ventas/\"},\n"
                + "{\"id\":33,\"label\":\"Clientes\",\"inode\":false,\"my-hash\":\"hash-5\",\"my-url\":\"Administracion/Clientes/\"},\n"
                + "{\"id\":34,\"label\":\"Articulos\",\"inode\":false,\"my-hash\":\"hash-5\",\"my-url\":\"Administracion/Articulos/\"},\n"
                + "{\"id\":35,\"label\":\"Configuracion\",\"inode\":false,\"my-hash\":\"hash-5\",\"my-url\":\"Administracion/Configuracion/\"}\n"
                + "\n"
                + "],\n"
                + "\"my-hash\":\"hash-1\",\"my-url\":\"sample.php?request=page-1\"}\n"               
                + "]";

        return menu;
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
