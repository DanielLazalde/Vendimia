package Clientes;

import Clientes.*;
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

//@WebServlet(name = "srvAreasConocimiento", urlPatterns = {"/srvAreasConocimiento"})
public class srvClientes extends HttpServlet {

    private HttpServletRequest varRequest = null;
    private HttpServletResponse varResponse = null;
    private PrintWriter varOut = null;
    private HttpSession varSession = null;
    private clsClientes varClientes = null;

    public srvClientes() throws IOException, NamingException {
        varClientes = new clsClientes();
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
        JSONObject varJObjectLista = varClientes.metGetLista();
        varOut.print(varJObjectLista);
    }

    private void metCrear() throws SQLException {
        String ArcNombre = varRequest.getParameter("ArcNombre");
        String ArcApellidoPaterno = varRequest.getParameter("ArcApellidoPaterno");
        String ArcApellidoMaterno = varRequest.getParameter("ArcApellidoMaterno");
        String ArcRFC = varRequest.getParameter("ArcRFC");
        
        JSONObject varJObjectNuevoRegistro = varClientes.metNuevo(ArcNombre, ArcApellidoPaterno, ArcApellidoMaterno, ArcRFC);
        varOut.print(varJObjectNuevoRegistro);
    }

    private void metModificar() throws SQLException {
        String ArcId = varRequest.getParameter("ArcId").trim();
        String ArcClave = ""; //varRequest.getParameter("ArcClave").trim();
        String ArcApellidoPaterno = varRequest.getParameter("ArcApellidoPaterno").trim();
        String ArcApellidoMaterno = varRequest.getParameter("ArcApellidoMaterno").trim();
        String ArcRFC = varRequest.getParameter("ArcRFC").trim();
        
        
        String ArcNombre = varRequest.getParameter("ArcNombre");
        
        

        JSONObject varJObjectNuevoRegistro = varClientes.metEditar(ArcId, ArcClave, ArcNombre, ArcApellidoPaterno, ArcApellidoMaterno, ArcRFC);
        varOut.print(varJObjectNuevoRegistro);
    }

    private void metEliminar() throws SQLException {
        String ArcId = varRequest.getParameter("ArcId").trim();
        JSONObject varJObjectLista = varClientes.metQuitar(ArcId);
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
            Logger.getLogger(srvClientes.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(srvClientes.class.getName()).log(Level.SEVERE, null, ex);
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
