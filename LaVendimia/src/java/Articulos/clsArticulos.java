package Articulos;

import Articulos.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import herramientas.clsConexion;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

public class clsArticulos {

    private clsConexion varClsConexion;
    private final String varNombreEsquema;
    private final String varNombreTabla;

    public clsArticulos() {
        varClsConexion = new clsConexion();
        varNombreEsquema = "vendimiadb";
        varNombreTabla = "tbl_articulos";
    }

    public JSONObject metGetLista() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String varSql = "SELECT "
                    + "LPAD(ART.idu_articulo,4,'0') as idu_articulo,"
                    + "ART.des_articulo,"
                    + "ART.des_modelo,"
                    + "ART.num_precio,"
                    + "ART.num_existencia "
                    + " FROM " + varNombreEsquema + ".tbl_articulos ART WHERE ART.opc_estatus = true "
                    + " ORDER BY ART.idu_articulo "
                    + ";";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("ArcClaveArticulo", varResultado.getString("idu_articulo"));
                varJsonObjectP.put("ArcDescripcion", varResultado.getString("des_articulo"));
                varJsonObjectP.put("ArcModelo", varResultado.getString("des_modelo"));
                varJsonObjectP.put("ArcPrecio", varResultado.getString("num_precio"));
                varJsonObjectP.put("ArcExistencia", varResultado.getString("num_existencia"));              
                varJsonArrayP.add(varJsonObjectP);
            }
            varResultado.close();
            varResultado = null;
            varPst.close();
            varPst = null;
            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
        varJsonObjectResultado.put("Result", "OK");
        varJsonObjectResultado.put("Records", varJsonArrayP);
        return varJsonObjectResultado;
    }

   
    public JSONObject metEditar(
            String idu_articulo,
            String des_articulo,
            String des_modelo,
            String num_precio,
            String num_existencia) {

        JSONObject varJsonObjectResultado = new JSONObject();

        try {

            String sql = "UPDATE " + varNombreEsquema + "." + varNombreTabla + " "
                    + "SET  "
                    + "des_articulo = ? , "
                    + "des_modelo = ? , "
                    + "num_precio = ? , "
                    + "num_existencia = ? , "
                    + "opc_estatus = true "
                    + "WHERE idu_articulo = ? ";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setString(1, des_articulo);
            varPst.setString(2, des_modelo);
            varPst.setFloat(3, Float.parseFloat(num_precio));
            varPst.setLong(4, Long.parseLong(num_existencia));
            varPst.setLong(5,  Long.parseLong(idu_articulo));

            varPst.executeUpdate();

            varJsonObjectResultado.put("Result", "OK");
            varPst.close();
            varPst = null;

            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
        return varJsonObjectResultado;
    }

    public JSONObject metQuitar(String CexId) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String sql = "DELETE FROM "+varNombreEsquema+".tbl_articulos\n"
                    + "WHERE idu_articulo=?;";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setLong(1, Long.parseLong(CexId));
            
            varPst.executeUpdate();

            varJsonObjectResultado.put("Result", "OK");
            varPst.close();
            varPst = null;
            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
        return varJsonObjectResultado;
    }

    
    public JSONArray generarFolioClaveArticulo(String criterio) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            
            String varSql = "select fun_guardararticulo(' ', ' ', 0, 0) as ident ";                   

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("cve_articulo", varResultado.getString("ident")); 
                varJsonArrayP.add(varJsonObjectP);
            }
            varResultado.close();
            varResultado = null;
            varPst.close();
            varPst = null;
            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
        return varJsonArrayP;
    }

}
