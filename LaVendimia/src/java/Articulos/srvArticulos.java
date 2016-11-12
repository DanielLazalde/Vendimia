package Articulos;

import Articulos.*;
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
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//@WebServlet(name = "srvExamenes", urlPatterns = {"/srvExamenes"})
public class srvArticulos extends HttpServlet {

    private HttpServletRequest varRequest = null;
    private HttpServletResponse varResponse = null;
    private PrintWriter varOut = null;
    private HttpSession varSession = null;
    private clsArticulos varArticulos = null;

    public srvArticulos() throws IOException, NamingException {
        varArticulos = new clsArticulos();
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
                //metCrear();
                metModificar();
            } else if (varRequest.getParameter("parAccion").equals("createEnAgregar")) {
                //metCrear();
                metModificarEnAgregar();
            }else if (varRequest.getParameter("parAccion").equals("update")) {
                metModificar();
            } else if (varRequest.getParameter("parAccion").equals("delete")) {
                metEliminar();
            } 
            else if (varRequest.getParameter("parAccion").equals("generarclavearticulo")) {
                generarClaveArticulo();
            }


        } finally {
            varOut.close();
        }
    }
    
    public void generarClaveArticulo() throws SQLException {
        String criterio = ""; //varRequest.getParameter("term");
        System.out.print(criterio);
        varOut.println(varArticulos.generarFolioClaveArticulo(criterio));
    }
   
    private void metLista() throws SQLException {
        JSONObject varJObjectLista = varArticulos.metGetLista();
        varOut.print(varJObjectLista);
    }



    private void metModificar() throws SQLException {
        String idu_articulo = varRequest.getParameter("ArcClaveArticulo").trim();
        String des_articulo = varRequest.getParameter("ArcDescripcion").trim();
        String des_modelo = varRequest.getParameter("ArcModelo").trim();
        String num_precio = varRequest.getParameter("ArcPrecio").trim();
        String num_existencia = varRequest.getParameter("ArcExistencia").trim();
        
        JSONObject varJObjectNuevoRegistro = varArticulos.metEditar(idu_articulo, des_articulo, des_modelo, num_precio, num_existencia );
        varOut.print(varJObjectNuevoRegistro);        
    }
    
    private void metModificarEnAgregar() throws SQLException {
        String idu_articulo = varRequest.getParameter("idu_articulo").trim();
        String des_articulo = varRequest.getParameter("des_articulo").trim();
        String des_modelo = varRequest.getParameter("des_modelo").trim();
        String num_precio = varRequest.getParameter("num_precio").trim();
        String num_existencia = varRequest.getParameter("num_existencia").trim();
        
        JSONObject varJObjectNuevoRegistro = varArticulos.metEditar(idu_articulo, des_articulo, des_modelo, num_precio, num_existencia );
        varOut.print(varJObjectNuevoRegistro);        
    }

    private void metEliminar() throws SQLException {
        String iduArticulo = varRequest.getParameter("ArcClaveArticulo").trim();
        JSONObject varJObjectLista = varArticulos.metQuitar(iduArticulo);
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
            Logger.getLogger(srvArticulos.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(srvArticulos.class.getName()).log(Level.SEVERE, null, ex);
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
