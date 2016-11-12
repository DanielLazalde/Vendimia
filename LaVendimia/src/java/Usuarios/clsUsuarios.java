package Usuarios;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import herramientas.clsConexion;

public class clsUsuarios {

    private clsConexion varClsConexion;
    private final String varNombreEsquema;
    private final String varNombreTabla;

    public clsUsuarios() {
        varClsConexion = new clsConexion();
        //varNombreEsquema = "public";
        varNombreEsquema = "vendimiadb";
        varNombreTabla = "tbl_usuarios_usu";
    }

    public JSONObject metGetLista() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();

        try {
            String varSql = "SELECT * FROM "+varNombreEsquema+".tbl_usuarios_usu;";
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);
            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("UsuCodigo", varResultado.getString("usu_codigo"));
                varJsonObjectP.put("UsuClave", varResultado.getString("usu_clave"));
                varJsonObjectP.put("UsuNombre", varResultado.getString("usu_nombre"));
                varJsonObjectP.put("UsuApellidoPaterno", varResultado.getString("usu_apellido_paterno"));
                varJsonObjectP.put("UsuApellidoMaterno", varResultado.getString("usu_apellido_materno"));
                varJsonObjectP.put("UsuNroDocumento", varResultado.getString("usu_nro_documento"));
                varJsonObjectP.put("UsuAdministrador", varResultado.getBoolean("usu_administrador"));
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
            String UsuCodigo,
            String UsuClave,
            String UsuNombre,
            String UsuApellidoPaterno,
            String UsuApellidoMaterno,
            String UsuNroDocumento,
            String UsuAdministrador) {
        JSONObject varJsonObjectResultado = new JSONObject();
        JSONObject varJsonObjectRegistro = new JSONObject();
        try {
            /*Boolean rsp=*/
            metGuardarEnBd(UsuCodigo,
                    UsuClave,
                    UsuNombre,
                    UsuApellidoPaterno,
                    UsuApellidoMaterno,
                    UsuNroDocumento,
                    UsuAdministrador);
            String varSql = "SELECT * FROM "+varNombreEsquema+".tbl_usuarios_usu;";
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);
            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectRegistro.put("UsuCodigo", varResultado.getString("usu_codigo"));
                varJsonObjectRegistro.put("UsuClave", varResultado.getString("usu_clave"));
                varJsonObjectRegistro.put("UsuNombre", varResultado.getString("usu_nombre"));
                varJsonObjectRegistro.put("UsuApellidoPaterno", varResultado.getString("usu_apellido_paterno"));
                varJsonObjectRegistro.put("UsuApellidoMaterno", varResultado.getString("usu_apellido_materno"));
                varJsonObjectRegistro.put("UsuNroDocumento", varResultado.getString("usu_nro_documento"));
                varJsonObjectRegistro.put("UsuAdministrador", varResultado.getBoolean("usu_administrador"));
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

    public Boolean metGuardarEnBd(
            String UsuCodigo,
            String UsuClave,
            String UsuNombre,
            String UsuApellidoPaterno,
            String UsuApellidoMaterno,
            String UsuNroDocumento,
            String UsuAdministrador) {

        try {
            String sql = "INSERT INTO "+varNombreEsquema+".tbl_usuarios_usu(\n"
                    + "usu_codigo, usu_nombre, usu_clave, usu_apellido_paterno, usu_apellido_materno, \n"
                    + "usu_nro_documento,usu_administrador)\n"
                    + "VALUES (?, ?, ?, ?, ?, \n"
                    + "?,?);";
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setString(1, UsuCodigo);
            varPst.setString(2, UsuNombre);
            varPst.setString(3, UsuClave);
            varPst.setString(4, UsuApellidoPaterno);
            varPst.setString(5, " "); // juan.lazalde Mientras vacio
            varPst.setString(6, UsuNroDocumento);
            //varPst.setBoolean(7, Boolean.parseBoolean(UsuAdministrador));
            varPst.setBoolean(7, true); // juan.lazalde Todos los usuario administradores por default
            varPst.execute();
            varPst.close();
            varPst = null;
            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
            return false;
        }
        return true;
    }

    public JSONObject metEditar(
            String UsuCodigo,
            String UsuClave,
            String UsuNombre,
            String UsuApellidoPaterno,
            String UsuApellidoMaterno,
            String UsuNroDocumento,
            String UsuAdministrador) {

        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String sql = "UPDATE "+varNombreEsquema+".tbl_usuarios_usu\n"
                    + "SET "
                    + "usu_nombre=?\n"
                    + ",usu_clave=?\n"
                    + ",usu_apellido_paterno=?\n"
                    + ",usu_apellido_materno=?\n"
                    + ",usu_nro_documento=?"
                    + ",usu_administrador=?\n"
                    + "WHERE usu_codigo = ?;\n";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setString(1, UsuNombre);
            varPst.setString(2, UsuClave);
            varPst.setString(3, UsuApellidoPaterno);
            varPst.setString(4, UsuApellidoMaterno);
            varPst.setString(5, UsuNroDocumento);
            varPst.setBoolean(6, Boolean.parseBoolean(UsuAdministrador));
            varPst.setString(7, UsuCodigo);

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

    public JSONObject metEliminar(String UsuCodigo) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String sql = "DELETE FROM  " + varNombreEsquema + "." + varNombreTabla + " "
                    + "WHERE usu_codigo = ?;";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setString(1, UsuCodigo);

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

    public Boolean metCambiarPassword(String varUsuCodigo, String varUsuClave, String varUsuNuevaClave) {
        Boolean correcto = false;
        try {
            String sql = "SELECT usu.usu_nombre\n"
                    + "FROM "+varNombreEsquema+".tbl_usuarios_usu AS usu\n"
                    + "WHERE  usu.usu_codigo=? AND usu.usu_clave=?";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setString(1, varUsuCodigo);
            varPst.setString(2, varUsuClave);

            System.out.println("sql " + varPst.toString());
            //varPst.executeQuery();

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                correcto = true;
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
        /////////////////////////////////////
        if (correcto) {
            try {
                String sql = "UPDATE "+varNombreEsquema+".tbl_usuarios_usu SET usu_clave = ? WHERE usu_codigo = ?";

                PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
                varPst.setString(1, varUsuNuevaClave);
                varPst.setString(2, varUsuCodigo);

                System.out.println("sql " + varPst.toString());

                varPst.executeUpdate();

                varPst.close();
                varPst = null;

                varClsConexion.closeConexion();
            } catch (Exception e) {
                e.printStackTrace();
                System.out.print(e);
                correcto = false;
            }

        }
        return correcto;
    }
}
