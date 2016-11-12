/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.sql.*;

public class clsConexion {

    private static Connection varConexion;

    
    /*private Connection conexion;
static String bd="pmbokdb";
static String user="postgres";
static String password="admin123";
static String server="jdbc:postgresql://localhost:5432/"+bd;*/
    
/*private Connection conexion;
static String bd="vendimiadb";
static String user="root";
static String password="";
static String server="jdbc:mysql://localhost:3306/"+bd;*/

private Connection conexion;
static String bd="vendimiadb";
static String user="root";
static String password="XFfYf1T4Wd";
static String server="jdbc:mysql://node22316-prueba3.jl.serv.net.mx/"+bd;

    public Connection getConexion() {
        try {
            
            System.out.println("ENTRO A CONETCARSE CON BASE DE DATOS - inicio 222");
            establecerConexion();
            System.out.println("ENTRO A CONETCARSE CON BASE DE DATOS 222");
            InitialContext initialContext = new InitialContext();
            //Context context = (Context) initialContext.lookup("java:comp/env");
            //The JDBC Data source that we just created
            //DataSource ds = (DataSource) context.lookup("jdbc/pgpool_destinosur");
            varConexion = getConexion2(); // ds.getConnection2();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return varConexion;
        }
    }

    public void closeConexion() {
        try {
            if (varConexion != null) {
                varConexion.close(); // Return to connection pool
                varConexion = null;  // Make sure we don't close it twice 
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    

//okokok
/*
public void establecerConexion(){
try{
//Class.forName("org.postgresql.Driver");
Class.forName("com.mysql.jdbc.Driver");
//er,user,password);
conexion= DriverManager.getConnection("jdbc:mysql://localhost:3306/vendimiadb",
      "root","");

    System.out.println("coneccion satisfactoria");
}
catch(Exception e){
System.out.println("Imposible realizar conexion con la BD");
e.printStackTrace();
}
}*/


public void establecerConexion(){
try{
//Class.forName("org.postgresql.Driver");
Class.forName("com.mysql.jdbc.Driver");
//er,user,password);
conexion= DriverManager.getConnection(server,
      user,password);

    System.out.println("coneccion satisfactoria");
}
catch(Exception e){
System.out.println("Imposible realizar conexion con la BD");
e.printStackTrace();
}
}

public Connection getConexion2(){
return conexion;
}

public void cerrar(ResultSet rs){
if(rs !=null){
try{
rs.close();
}
catch(Exception e){
System.out.print("No es posible cerrar la Conexion");
}
}
}

public void cerrar(java.sql.Statement stmt){
if(stmt !=null){
try{
stmt.close();
}
catch(Exception e){}
}
}

public void destruir(){

    if(conexion !=null){

    try{
    conexion.close();
    }
    catch(Exception e){}
    }
}
    
    
}
