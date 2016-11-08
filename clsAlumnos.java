package Alumnos;

import Alumnos.*;
import Alumnos.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import herramientas.clsConexion;

public class clsAlumnos {

    private clsConexion varClsConexion;
    private final String varNombreEsquema;
    private final String varNombreTabla;

    public clsAlumnos() {
        varClsConexion = new clsConexion();
        varNombreEsquema = "public";
        varNombreTabla = "tbl_alumnos_alu";
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
                varJsonObjectP.put("AluId", varResultado.getString("alu_id"));
                varJsonObjectP.put("AluNombre", varResultado.getString("alu_nombre"));
                varJsonObjectP.put("AluUsuario", varResultado.getString("alu_usuario"));
                varJsonObjectP.put("AluClave", varResultado.getString("alu_clave"));
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
            String AluNombre,
            String AluUsuario,
            String AluClave) {
        JSONObject varJsonObjectResultado = new JSONObject();
        JSONObject varJsonObjectRegistro = new JSONObject();
        try {
            metGuardarEnBd(
                    AluNombre,
                    AluUsuario,
                    AluClave);

            String varSql = "SELECT * FROM " + varNombreEsquema + "." + varNombreTabla + ";";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectRegistro.put("AluId", varResultado.getString("alu_id"));
                varJsonObjectRegistro.put("AluNombre", varResultado.getString("alu_nombre"));
                varJsonObjectRegistro.put("AluUsuario", varResultado.getString("alu_usuario"));
                varJsonObjectRegistro.put("AluClave", varResultado.getString("alu_clave"));

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
            String AluNombre,
            String AluUsuario,
            String AluClave) {
        try {
            String sql = "INSERT INTO " + varNombreEsquema + "." + varNombreTabla + " "
                    + "(alu_nombre,alu_usuario,alu_clave) "
                    + "VALUES (?,?,?)";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setString(1, AluNombre);
            varPst.setString(2, AluUsuario);
            varPst.setString(3, AluClave);
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
            String AluId,
            String AluNombre,
            String AluUsuario,
            String AluClave) {

        JSONObject varJsonObjectResultado = new JSONObject();

        try {

            String sql = "UPDATE " + varNombreEsquema + "." + varNombreTabla + " "
                    + "SET  "
                    + "alu_nombre = ? ,"
                    + "alu_usuario = ? ,"
                    + "alu_clave = ? "
                    + "WHERE alu_id = ? ";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setString(1, AluNombre);
            varPst.setString(2, AluUsuario);
            varPst.setString(3, AluClave);
            varPst.setInt(4, Integer.parseInt(AluId));

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

    public JSONObject metQuitar(String AluId) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String sql = "DELETE FROM  " + varNombreEsquema + "." + varNombreTabla + " "
                    + "WHERE alu_id =?;";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setInt(1, Integer.parseInt(AluId));

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
