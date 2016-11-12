package Configuracion;

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
public class srvConfiguracion extends HttpServlet {

    private HttpServletRequest varRequest = null;
    private HttpServletResponse varResponse = null;
    private PrintWriter varOut = null;
    private HttpSession varSession = null;
    private clsConfiguracion varConfiguracion = null;

    public srvConfiguracion() throws IOException, NamingException {
        varConfiguracion = new clsConfiguracion();
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
            }  else if (varRequest.getParameter("parAccion").equals("update")) {
                metEditar();
            } 

        } finally {
            varOut.close();
        }
    }

    private void metLista() throws SQLException {
        JSONObject varJObjectLista = varConfiguracion.metGetLista();
        varOut.print(varJObjectLista);
    }
//    

    private void metCrear() throws SQLException {
        String idu_configuracion = varRequest.getParameter("idu_configuracion");
        
        if (!idu_configuracion.trim().equals(""))
        {
             metEditar();
        }else{
            
        String num_tasafinanciamiento = varRequest.getParameter("num_tasafinanciamiento");
        String num_porcentajeenganche = varRequest.getParameter("num_porcentajeenganche");
        String num_plazomaximo = varRequest.getParameter("num_plazomaximo");
       
        JSONObject varJObjectNuevoRegistro = varConfiguracion.metNuevo(
                num_tasafinanciamiento,
                num_porcentajeenganche,
                num_plazomaximo
               
        );
        varOut.print(varJObjectNuevoRegistro);
            
        }
     
    }

    private void metCrear2() throws SQLException {
        String UsuCodigo = varRequest.getParameter("UsuCodigo");
        String UsuClave = varRequest.getParameter("UsuClave");
        String UsuNombre = varRequest.getParameter("UsuNombre");
        String UsuApellidoPaterno = varRequest.getParameter("UsuApellidoPaterno");
        String UsuApellidoMaterno = varRequest.getParameter("UsuApellidoMaterno");
        String UsuNroDocumento = varRequest.getParameter("UsuNroDocumento");
        String UsuAdministrador = "false";

        Boolean rsp = null;//varConfiguracion.metGuardarEnBd(
             /*   UsuCodigo,
                UsuClave,
                UsuNombre,
                UsuApellidoPaterno,
                UsuApellidoMaterno,
                UsuNroDocumento,
                UsuAdministrador
        );*/
        if (rsp) {
            varOut.print(1);
        } else {
            varOut.print(0);
        }
    }
                            
    private void metEditar() throws SQLException {
        String idu_configuracion = varRequest.getParameter("idu_configuracion");
        String num_tasafinanciamiento = varRequest.getParameter("num_tasafinanciamiento");
        String num_porcentajeenganche = varRequest.getParameter("num_porcentajeenganche");
        String num_plazomaximo = varRequest.getParameter("num_plazomaximo");
        
        JSONObject varJObjectNuevoRegistro = varConfiguracion.metEditar(
                idu_configuracion,
                num_tasafinanciamiento,
                num_porcentajeenganche,
                num_plazomaximo
        );
        varOut.print(varJObjectNuevoRegistro);
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
            Logger.getLogger(srvConfiguracion.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(srvConfiguracion.class.getName()).log(Level.SEVERE, null, ex);
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
