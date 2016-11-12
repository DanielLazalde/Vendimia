package Configuracion;

import Configuracion.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import herramientas.clsConexion;
import javax.swing.JOptionPane;

public class clsConfiguracion {

    private clsConexion varClsConexion;
    private final String varNombreEsquema;
    private final String varNombreTabla;

    public clsConfiguracion() {
        varClsConexion = new clsConexion();
        varNombreEsquema = "vendimiadb";
        varNombreTabla = "tbl_configuracion";
    }

    public JSONObject metGetListaConboBox() throws SQLException, SQLException {

       
            
        JSONObject varJsonObjectP = new JSONObject();
        try {
            //String varSql = "SELECT arc_id,arc_nombre FROM " + varNombreEsquema + "." + varNombreTabla + ";";
            String varSql = "SELECT idu_configuracion, num_tasafinanciamiento, num_porcentajeenganche, num_plazomaximo FROM " + varNombreEsquema + "." + varNombreTabla + ";";
 
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put(varResultado.getInt("arc_id"), varResultado.getString("num_tasafinanciamiento"));
//System.out.println(varResultado.getInt("arc_id")+"-"+varResultado.getString("arc_nombre"));
            }
            varPst.close();
            varResultado.close();
            varClsConexion.closeConexion();
        } catch (Exception e) {
            if (varClsConexion.getConexion() != null) {
                varClsConexion.closeConexion();
            }
            e.printStackTrace();
        }

        return varJsonObjectP;
    }

    public JSONObject metGetLista() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String varSql = "SELECT * "
                    + "FROM " + varNombreEsquema + "." + varNombreTabla + ""
                    + " "
                    + ";";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("idu_configuracion", varResultado.getString("idu_configuracion"));
                varJsonObjectP.put("num_tasafinanciamiento", varResultado.getString("num_tasafinanciamiento"));  
                varJsonObjectP.put("num_porcentajeenganche", varResultado.getString("num_porcentajeenganche"));  
                varJsonObjectP.put("num_plazomaximo", varResultado.getString("num_plazomaximo"));  
                
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

    public JSONObject metNuevo(
            String num_tasafinanciamiento, 
            String num_porcentajeenganche, 
            String num_plazomaximo) {
        JSONObject varJsonObjectResultado = new JSONObject();
        JSONObject varJsonObjectRegistro = new JSONObject();
        try {
            metGuardarEnBd(num_tasafinanciamiento, num_porcentajeenganche, num_plazomaximo);

            String varSql = "SELECT * FROM " + varNombreEsquema + "." + varNombreTabla + ";";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectRegistro.put("idu_configuracion", varResultado.getString("idu_configuracion"));
                varJsonObjectRegistro.put("num_tasafinanciamiento", varResultado.getString("num_tasafinanciamiento"));
                varJsonObjectRegistro.put("num_porcentajeenganche", varResultado.getString("num_porcentajeenganche"));
                varJsonObjectRegistro.put("num_plazomaximo", varResultado.getString("num_plazomaximo"));
                
            }
            varJsonObjectResultado.put("Result", "OK");
            
            varJsonObjectResultado.put("Record", varJsonObjectRegistro);
            varResultado.close();
            varResultado = null;
            varPst.close();
            varPst = null;

            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
        return varJsonObjectResultado;
    }

    private void metGuardarEnBd(
            String num_tasafinanciamiento, 
            String num_porcentajeenganche, 
            String num_plazomaximo) {
        try {
            String sql = "INSERT INTO " + varNombreEsquema + "." + varNombreTabla + " "
                    + "(num_tasafinanciamiento, num_porcentajeenganche, num_plazomaximo) "
                    + "VALUES (?, ?, ?)";
                      

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setFloat(1, Float.parseFloat(num_tasafinanciamiento));
            varPst.setInt(2, Integer.parseInt(num_porcentajeenganche));
            varPst.setInt(3, Integer.parseInt(num_plazomaximo));
           
            varPst.execute();
            
            
            varPst.close();
            varPst = null;

            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
    }

    public JSONObject metEditar(
            String idu_configuracion,
            String num_tasafinanciamiento,
            String num_porcentajeenganche,
            String num_plazomaximo) {

        JSONObject varJsonObjectResultado = new JSONObject();

        try {

            String sql = "UPDATE " + varNombreEsquema + "." + varNombreTabla + " "
                    + "SET  "
                    + "num_tasafinanciamiento = ? ,"
                    + "num_porcentajeenganche = ? ,"
                    + "num_plazomaximo = ? "                    
                    + "WHERE idu_configuracion = ? ";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setFloat(1, Float.parseFloat(num_tasafinanciamiento));
            varPst.setInt(2, Integer.parseInt(num_porcentajeenganche));
            varPst.setInt(3, Integer.parseInt(num_plazomaximo));
            varPst.setInt(4, Integer.parseInt(idu_configuracion));
            
            varPst.executeUpdate();

            varJsonObjectResultado.put("Result", "OK");
           /*varJsonObjectResultado.put("Message", "SE REALIZO OK");
            JOptionPane.showMessageDialog(null, "Se actualizo");*/
            varPst.close();
            varPst = null;

            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
        return varJsonObjectResultado;
    }

    public JSONObject metQuitar(String ArcId) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String sql = "DELETE FROM  " + varNombreEsquema + "." + varNombreTabla + " "
                    + "WHERE idu_configuracion =?;";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setLong(1, Long.parseLong(ArcId));

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
}
