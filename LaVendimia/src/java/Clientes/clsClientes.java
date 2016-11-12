package Clientes;

import Clientes.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import herramientas.clsConexion;
import javax.swing.JOptionPane;

public class clsClientes {

    private clsConexion varClsConexion;
    private final String varNombreEsquema;
    private final String varNombreTabla;

    public clsClientes() {
        varClsConexion = new clsConexion();
        varNombreEsquema = "vendimiadb";
        varNombreTabla = "tbl_clientes";
    }

    public JSONObject metGetListaConboBox() throws SQLException, SQLException {

        JSONObject varJsonObjectP = new JSONObject();
        try {
            //String varSql = "SELECT arc_id,arc_nombre FROM " + varNombreEsquema + "." + varNombreTabla + ";";
            String varSql = "SELECT idu_cliente, cve_cliente, des_nombrecompleto, des_rfc FROM " + varNombreEsquema + "." + varNombreTabla + ";";
 
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put(varResultado.getInt("arc_id"), varResultado.getString("des_nombrecompleto"));
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
            String varSql = "SELECT LPAD(idu_cliente,4,'0') as idu_cliente, des_apellidopaterno, des_apellidomaterno, des_rfc, des_nombrecompleto " 
                    + "FROM " + varNombreEsquema + "." + varNombreTabla + ""
                    + " "
                    + ";";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("ArcId", varResultado.getString("idu_cliente"));
                varJsonObjectP.put("ArcClave", varResultado.getString("idu_cliente"));  
                varJsonObjectP.put("ArcApellidoPaterno", varResultado.getString("des_apellidopaterno"));  
                varJsonObjectP.put("ArcApellidoMaterno", varResultado.getString("des_apellidomaterno"));  
                varJsonObjectP.put("ArcRFC", varResultado.getString("des_rfc"));  
                varJsonObjectP.put("ArcNombre", varResultado.getString("des_nombrecompleto"));
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
            String ArcNombre, 
            String ArcApellidoPaterno, 
            String ArcApellidoMaterno, 
            String ArcRFC ) {
        JSONObject varJsonObjectResultado = new JSONObject();
        JSONObject varJsonObjectRegistro = new JSONObject();
        try {
            metGuardarEnBd(ArcNombre, ArcApellidoPaterno, ArcApellidoMaterno, ArcRFC);

            String varSql = "SELECT * FROM " + varNombreEsquema + "." + varNombreTabla + ";";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectRegistro.put("ArcId", varResultado.getString("idu_cliente"));
                varJsonObjectRegistro.put("ArcClave", varResultado.getString("idu_cliente"));
                varJsonObjectRegistro.put("ArcNombre", varResultado.getString("des_nombrecompleto"));
                varJsonObjectRegistro.put("ArcApellidoPaterno", varResultado.getString("des_apellidopaterno"));
                varJsonObjectRegistro.put("ArcApellidoMaterno", varResultado.getString("des_apellidomaterno"));
                varJsonObjectRegistro.put("ArcRFC", varResultado.getString("des_rfc"));

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
            String ArcNombre, 
            String ArcApellidoPaterno, 
            String ArcApellidoMaterno, 
            String ArcRFC) {
        try {
            String sql = "INSERT INTO " + varNombreEsquema + "." + varNombreTabla + " "
                    + "(des_nombrecompleto, des_apellidopaterno, des_apellidomaterno, des_rfc) "
                    + "VALUES (?, ?, ?, ?)";
                      

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setString(1, ArcNombre);
            varPst.setString(2, ArcApellidoPaterno);
            varPst.setString(3, ArcApellidoMaterno);
            varPst.setString(4, ArcRFC);
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
            String ArcId,
            String ArcClave,
            String ArcNombre,
            String ArcApellidoPaterno,
            String ArcApellidoMaterno,
            String ArcRFC) {

        JSONObject varJsonObjectResultado = new JSONObject();

        try {

            String sql = "UPDATE " + varNombreEsquema + "." + varNombreTabla + " "
                    + "SET  "
                    + "des_nombrecompleto = ? ,"
                    + "des_apellidopaterno = ? ,"
                    + "des_apellidomaterno = ? ,"
                    + "des_rfc = ? "
                    + "WHERE idu_cliente = ? ";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setString(1, ArcNombre);
            varPst.setString(2, ArcApellidoPaterno);
            varPst.setString(3, ArcApellidoMaterno);
            varPst.setString(4, ArcRFC);
            varPst.setInt(5, Integer.parseInt(ArcId));

            varPst.executeUpdate();

            varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("Message", "SE REALIZO OK");
            //JOptionPane.showMessageDialog(null, "Se actualizo");
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
                    + "WHERE idu_cliente =?;";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setInt(1, Integer.parseInt(ArcId));

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
