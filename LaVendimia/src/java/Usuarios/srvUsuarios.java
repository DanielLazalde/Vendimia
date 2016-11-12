package Usuarios;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;

//@WebServlet(name = "srvUsuarios", urlPatterns = {"/srvUsuarios"})
public class srvUsuarios extends HttpServlet {

    private HttpServletRequest varRequest = null;
    private HttpServletResponse varResponse = null;
    private PrintWriter varOut = null;
    private HttpSession varSession = null;
    private clsUsuarios varUsuarios = null;

    public srvUsuarios() throws IOException, NamingException {
        varUsuarios = new clsUsuarios();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try {
            varRequest = request;
            varResponse = response;
            varSession = request.getSession();
            varOut = varResponse.getWriter();

            if (varRequest.getParameter("parAccion").equals("list")) {
                metLista();
            } else if (varRequest.getParameter("parAccion").equals("create")) {
                metCrear();
            } else if (varRequest.getParameter("parAccion").equals("create2")) {
                metCrear2();
            } else if (varRequest.getParameter("parAccion").equals("update")) {
                metEditar();
            } else if (varRequest.getParameter("parAccion").equals("delete")) {
                metEliminar();
            } else if (varRequest.getParameter("parAccion").equals("funCambiarPassword")) {
                metCambiarPassword();
            }

        } finally {
            varOut.close();
        }
    }

    private void metLista() throws SQLException {
        JSONObject varJObjectLista = varUsuarios.metGetLista();
        varOut.print(varJObjectLista);
    }
//    

    private void metCrear() throws SQLException {
        String UsuCodigo = varRequest.getParameter("UsuCodigo");
        String UsuClave = varRequest.getParameter("UsuClave");
        String UsuNombre = varRequest.getParameter("UsuNombre");
        String UsuApellidoPaterno = varRequest.getParameter("UsuApellidoPaterno");
        String UsuApellidoMaterno = varRequest.getParameter("UsuApellidoMaterno");
        String UsuNroDocumento = varRequest.getParameter("UsuNroDocumento");
        String UsuAdministrador = varRequest.getParameter("UsuAdministrador");

        JSONObject varJObjectNuevoRegistro = varUsuarios.metNuevo(
                UsuCodigo,
                UsuClave,
                UsuNombre,
                UsuApellidoPaterno,
                UsuApellidoMaterno,
                UsuNroDocumento,
                UsuAdministrador
        );
        varOut.print(varJObjectNuevoRegistro);
    }

    private void metCrear2() throws SQLException {
        String UsuCodigo = varRequest.getParameter("UsuCodigo");
        String UsuClave = varRequest.getParameter("UsuClave");
        String UsuNombre = varRequest.getParameter("UsuNombre");
        String UsuApellidoPaterno = varRequest.getParameter("UsuApellidoPaterno");
        String UsuApellidoMaterno = varRequest.getParameter("UsuApellidoMaterno");
        String UsuNroDocumento = varRequest.getParameter("UsuNroDocumento");
        String UsuAdministrador = "false";

        Boolean rsp = varUsuarios.metGuardarEnBd(
                UsuCodigo,
                UsuClave,
                UsuNombre,
                UsuApellidoPaterno,
                UsuApellidoMaterno,
                UsuNroDocumento,
                UsuAdministrador
        );
        if (rsp) {
            varOut.print(1);
        } else {
            varOut.print(0);
        }
    }

    private void metEditar() throws SQLException {
        String UsuCodigo = varRequest.getParameter("UsuCodigo");
        String UsuClave = varRequest.getParameter("UsuClave");
        String UsuNombre = varRequest.getParameter("UsuNombre");
        String UsuApellidoPaterno = varRequest.getParameter("UsuApellidoPaterno");
        String UsuApellidoMaterno = varRequest.getParameter("UsuApellidoMaterno");
        String UsuNroDocumento = varRequest.getParameter("UsuNroDocumento");
        String UsuAdministrador = varRequest.getParameter("UsuAdministrador");
        JSONObject varJObjectNuevoRegistro = varUsuarios.metEditar(
                UsuCodigo,
                UsuClave,
                UsuNombre,
                UsuApellidoPaterno,
                UsuApellidoMaterno,
                UsuNroDocumento,
                UsuAdministrador
        );
        varOut.print(varJObjectNuevoRegistro);
    }

    private void metEliminar() throws SQLException {
        String varUsuCodigo = varRequest.getParameter("UsuCodigo");
        JSONObject varJObjectLista = varUsuarios.metEliminar(varUsuCodigo);
        varOut.print(varJObjectLista);
    }

    private void metCambiarPassword() throws SQLException {
        System.out.println("entro en metcambiarpassword");
        String varUsuCodigo = varSession.getAttribute("session_usu_codigo").toString();
        System.out.println("varUsuCodigo " + varUsuCodigo);
        String varUsuClave = varRequest.getParameter("varPostUsuClave");
        System.out.println("varUsuClave " + varUsuClave);
        String varUsuNuevaClave = varRequest.getParameter("varPostUsuNuevaClave");
        System.out.println("varUsuNuevaClave " + varUsuNuevaClave);

        Boolean res = varUsuarios.metCambiarPassword(varUsuCodigo, varUsuClave, varUsuNuevaClave);

        if (res) {
            varOut.print(1);
        } else {
            varOut.print(0);
        }

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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(srvUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(srvUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
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
