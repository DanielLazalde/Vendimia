package Ventas;

import Ventas.*;
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
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

public class clsVentas {

    private clsConexion varClsConexion;
    private final String varNombreEsquema;
    private final String varNombreTabla;

    public clsVentas() {
        varClsConexion = new clsConexion();
        varNombreEsquema = "vendimiadb";
        varNombreTabla = "ctl_ventas";
    }

    public JSONObject metGetLista() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            
            String varSql = "SELECT LPAD(v.idu_venta, 4, '0') as idu_venta, "
                    + "Date_format(v.fec_registro,'%d/%m/%Y') as fec_registro , "
                    + "LPAD(c.idu_cliente,4,'0') as idu_cliente, c.des_nombrecompleto, FORMAT(v.num_total,2) as num_total, "
                    + "v.opc_estatus FROM ctl_ventas v "
                    + "INNER JOIN tbl_clientes c ON c.idu_cliente = v.idu_cliente AND v.opc_estatus = 2 ORDER BY idu_venta"; 

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("idu_venta", varResultado.getString("idu_venta"));
                varJsonObjectP.put("fec_registro", varResultado.getString("fec_registro"));
                varJsonObjectP.put("des_nombrecompleto", varResultado.getString("des_nombrecompleto"));
                varJsonObjectP.put("num_total", varResultado.getString("num_total"));
                varJsonObjectP.put("opc_estatus", varResultado.getString("opc_estatus"));     
                varJsonObjectP.put("idu_cliente", varResultado.getString("idu_cliente"));
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
    
    public JSONObject metGetListaArticulosVenta(String sIduVenta) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            
            String varSql = "SELECT v.idu_venta, dv.idu_detalle, a.idu_articulo, v.idu_cliente,  a.des_articulo, a.des_modelo, dv.num_cantidad, FORMAT(dv.num_preciocalculado,2) as num_preciocalculado, FORMAT(dv.num_importe,2) as num_importe, FORMAT(v.num_enganche,2) as num_enganche, FORMAT(v.num_bonificacionenganche,2) as num_bonificacionenganche, FORMAT(v.num_total,2) as num_total FROM ctl_ventas v INNER JOIN ctl_detalleventas dv ON dv.idu_venta = v.idu_venta INNER JOIN tbl_articulos a ON a.idu_articulo = dv.idu_articulo WHERE v.idu_venta = ?"; 

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);
            varPst.setLong(1, Long.parseLong(sIduVenta));
            
            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                
                varJsonObjectP.put("idu_venta", varResultado.getString("idu_venta"));
                varJsonObjectP.put("idu_articulo", varResultado.getString("idu_articulo"));
                 varJsonObjectP.put("idu_detalle", varResultado.getString("idu_detalle"));
                varJsonObjectP.put("idu_cliente", varResultado.getString("idu_cliente"));
                                
                varJsonObjectP.put("des_articulo", varResultado.getString("des_articulo"));
                varJsonObjectP.put("des_modelo", varResultado.getString("des_modelo"));
                varJsonObjectP.put("num_cantidad", varResultado.getString("num_cantidad"));
                varJsonObjectP.put("num_preciocalculado", varResultado.getString("num_preciocalculado"));
                varJsonObjectP.put("num_importe", varResultado.getString("num_importe"));
                
                varJsonObjectP.put("num_enganche", varResultado.getString("num_enganche"));
                varJsonObjectP.put("num_bonificacionenganche", varResultado.getString("num_bonificacionenganche"));
                varJsonObjectP.put("num_total", varResultado.getString("num_total"));
                
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
    
    public JSONObject metEjecutarCalculosAbonosMensuales(String sIduVenta) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String sql = "SELECT fun_calculoabonomensuales(?, 1, 1) as result;";                    
                 
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setLong(1, Long.parseLong(sIduVenta));                      

            varPst.executeQuery();

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

    
    public JSONObject metListaAbonosMensuales(String sIduVenta) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            
            metEjecutarCalculosAbonosMensuales(sIduVenta);
            
            String varSql = "SELECT idu_venta, num_plazo,  des_abono, FORMAT(num_importeabono,2) as num_importeabono, "
                    + "FORMAT(num_totalapagar,2) as num_totalapagar, FORMAT(num_seahorra,2) as num_seahorra, opc_estatus "
                    + "FROM tmp_abonosmensuales WHERE idu_venta = ?;"; 
            
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);
            varPst.setLong(1, Long.parseLong(sIduVenta));
            
            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("idu_venta", varResultado.getString("idu_venta"));
                varJsonObjectP.put("num_plazo", varResultado.getString("num_plazo"));
                                
                varJsonObjectP.put("des_abono", varResultado.getString("des_abono"));
                varJsonObjectP.put("num_importeabono", varResultado.getString("num_importeabono"));
                varJsonObjectP.put("num_totalapagar", varResultado.getString("num_totalapagar"));
                varJsonObjectP.put("num_seahorra", varResultado.getString("num_seahorra"));
                varJsonObjectP.put("opc_estatus", varResultado.getString("opc_estatus"));
                
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
    
    

                
     public JSONObject metObtenerDatosVenta(String sIduVenta) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {            
            
            String varSql = "SELECT FORMAT(v.num_enganche,2) as num_enganche, FORMAT(v.num_bonificacionenganche,2) as num_bonificacionenganche, FORMAT(v.num_total,2) as num_total FROM ctl_ventas v INNER JOIN ctl_detalleventas dv ON dv.idu_venta = v.idu_venta INNER JOIN tbl_articulos a ON a.idu_articulo = dv.idu_articulo WHERE v.idu_venta = ? limit 1"; 

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);
            varPst.setLong(1, Long.parseLong(sIduVenta));
            
            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("num_enganche", varResultado.getString("num_enganche"));
                varJsonObjectP.put("num_bonificacionenganche", varResultado.getString("num_bonificacionenganche"));
                varJsonObjectP.put("num_total", varResultado.getString("num_total"));
                         
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
            
            
            
     public JSONArray generarFolioVenta(String sIdu_cliente) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            
            String varSql = "select LPAD(fun_generafolioventa(?),4,'0') as folio ";                   

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);
            varPst.setLong(1, Long.parseLong(sIdu_cliente));
              
            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("idu_venta", varResultado.getString("folio")); 
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
     
     public String metGuardarEnBdDetalleVenta(
            String idu_venta, 
            String idu_cliente, 
            String idu_articulo, 
            String num_cantidad) {
         
         String rsp = "0";
        try {
            
            
            String sql = "SELECT fun_guardardetalleventa(?,?,?,?) as resul; ";
                   
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setLong(1, Long.parseLong(idu_venta));
            varPst.setLong(2, Long.parseLong(idu_cliente));
            varPst.setLong(3, Long.parseLong(idu_articulo));
            varPst.setInt(4, Integer.parseInt(num_cantidad));
           
             ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                rsp = varResultado.getString("resul");
                
            }
            
            varPst.close();
            varPst = null;
           
            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
        
        return rsp;
    }
     
     public String metGuardarVentaFinal(
            String idu_venta, 
            String num_plazo 
            ) {         
         String rsp = "0";
        try {
                        
            String sql = "SELECT fun_guardarventafinal(?,?) as resul; ";
                   
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setLong(1, Long.parseLong(idu_venta));
            varPst.setLong(2, Long.parseLong(num_plazo));
            
            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                rsp = varResultado.getString("resul");                
            }
            
            varPst.close();
            varPst = null;
           
            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
        
        return rsp;
    }

    public JSONObject metEditar(
            String ArcId,
            String ArcNombre) {

        JSONObject varJsonObjectResultado = new JSONObject();

        try {

            String sql = "UPDATE " + varNombreEsquema + "." + varNombreTabla + " "
                    + "SET  "
                    + "arc_nombre = ? "
                    + "WHERE arc_id = ? ";

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);

            varPst.setString(1, ArcNombre);
            varPst.setInt(2, Integer.parseInt(ArcId));

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

    public JSONObject metEjecutarCalculosDeVenta(String sIduVenta) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String sql = "SELECT fun_calculodeventa(?,0,0) as result;";                    
                 
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setLong(1, Long.parseLong(sIduVenta));                      

            varPst.executeQuery();

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

    public JSONObject metQuitar(String sIduVenta, String sIduDetalle) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String sql = "DELETE FROM ctl_detalleventas "  //Elimina el articulo del detalle
                    + "WHERE idu_venta=? AND idu_detalle = ? ;";
                    //+ "SELECT fun_calculodeventa(?,0,0);"; //Actualiza datos del enganche
                 
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setLong(1, Long.parseLong(sIduVenta));
            varPst.setLong(2, Long.parseLong(sIduDetalle));
            
            varPst.executeUpdate();

            varJsonObjectResultado.put("Result", "OK");
            
            metEjecutarCalculosDeVenta(sIduVenta);
            
            varPst.close();
            varPst = null;
            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
        return varJsonObjectResultado;
    }
    
    public JSONObject metQuitarVenta(String sIduVenta) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String sql = "CALL proc_cancelarventa(?);"; //Elimina la venta
                 
            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(sql);
            varPst.setLong(1, Long.parseLong(sIduVenta));
            //varPst.setLong(2, Long.parseLong(sIduVenta));
            //varPst.setLong(3, Long.parseLong(sIduVenta));
            
            varPst.executeUpdate();

            varJsonObjectResultado.put("Result", "OK");
            
            metEjecutarCalculosDeVenta(sIduVenta);
            
            varPst.close();
            varPst = null;
            varClsConexion.closeConexion();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e);
        }
        return varJsonObjectResultado;
    }


    public JSONArray metClientesAutocomplete(String criterio) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String varSql = "SELECT "
                    + "LPAD(idu_cliente,4,'0') as idu_cliente, "
                    + "des_nombrecompleto, des_apellidopaterno, des_apellidomaterno, "
                    + "des_rfc "
                    + "FROM tbl_clientes "
                    + "WHERE "
                    + "upper(des_nombrecompleto) like upper('%" + criterio + "%') OR  "
                    + "upper(des_apellidopaterno) like upper('%" + criterio + "%') OR  "
                    + "upper(des_apellidomaterno) like upper('%" + criterio + "%')  "
                    + "order by idu_cliente  limit 20;";            

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("value", varResultado.getString("des_nombrecompleto") + " " + varResultado.getString("des_apellidopaterno") + " " +  varResultado.getString("des_apellidomaterno"));
                varJsonObjectP.put("id", varResultado.getString("idu_cliente"));
                varJsonObjectP.put("des_rfc", varResultado.getString("des_rfc"));
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
    
    public JSONArray metArticulosAutocomplete(String criterio) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String varSql = "SELECT LPAD(idu_articulo, 4, '0') as idu_articulo, "
                    + "des_articulo FROM tbl_articulos " +
                    "WHERE upper(des_articulo) "
                    + "LIKE upper('%" + criterio + "%') AND opc_estatus = 1 "
                    + "ORDER BY idu_articulo LIMIT 10; ";                     

            PreparedStatement varPst = varClsConexion.getConexion().prepareStatement(varSql);

            ResultSet varResultado = varPst.executeQuery();

            while (varResultado.next()) {
                varJsonObjectP.put("value", varResultado.getString("des_articulo"));
                varJsonObjectP.put("id", varResultado.getString("idu_articulo"));
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
