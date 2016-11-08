package Alumnos;

import Alumnos.*;
import Alumnos.*;
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

@WebServlet(name = "srvAlumnos", urlPatterns = {"/srvAlumnos"})
public class srvAlumnos extends HttpServlet {

    private HttpServletRequest varRequest = null;
    private HttpServletResponse varResponse = null;
    private PrintWriter varOut = null;
    private HttpSession varSession = null;
    private clsAlumnos varAlumnos = null;

    public srvAlumnos() throws IOException, NamingException {
        varAlumnos = new clsAlumnos();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("tpxt/html;charset=UTF-8");
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
            } else if (varRequest.getParameter("parAccion").equals("update")) {
                metModificar();
            } else if (varRequest.getParameter("parAccion").equals("delete")) {
                metEliminar();
            }
//            else if (varRequest.getParameter("parAccion").equals("empresas")) metGetEmpresas();

        } finally {
            varOut.close();
        }
    }

    private void metLista() throws SQLException {
        JSONObject varJObjectLista = varAlumnos.metGetLista();
        varOut.print(varJObjectLista);
    }

    private void metCrear() throws SQLException {
        String AluNombre = varRequest.getParameter("AluNombre");
        String AluUsuario = varRequest.getParameter("AluUsuario");
        String AluClave = varRequest.getParameter("AluClave");
        JSONObject varJObjectNuevoRegistro = varAlumnos.metNuevo(AluNombre,AluUsuario,AluClave);
        varOut.print(varJObjectNuevoRegistro);
    }

    private void metModificar() throws SQLException {
        String AluId = varRequest.getParameter("AluId").trim();
        String AluNombre = varRequest.getParameter("AluNombre");
        String AluUsuario = varRequest.getParameter("AluUsuario");
        String AluClave = varRequest.getParameter("AluClave");
        JSONObject varJObjectNuevoRegistro = varAlumnos.metEditar(AluId,AluNombre,AluUsuario,AluClave);
        varOut.print(varJObjectNuevoRegistro);
    }

    private void metEliminar() throws SQLException {
        String AluId = varRequest.getParameter("AluId").trim();
        JSONObject varJObjectLista = varAlumnos.metQuitar(AluId);
        varOut.print(varJObjectLista);
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
            Logger.getLogger(srvAlumnos.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(srvAlumnos.class.getName()).log(Level.SEVERE, null, ex);
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
