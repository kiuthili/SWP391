/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author KienBTCE180180
 */
public class DBContext {

    public Connection getConnection() {
        Connection connector = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
            String dbURL = "jdbc:sqlserver://localhost:1433;"
                    + "databaseName=FSHOP;"
                    + "user=sa;" 
                    + "password=240204;"
                    + "encrypt=true;trustServerCertificate=true";

            connector = DriverManager.getConnection(dbURL);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
        return connector;
    }

    public static void main(String[] args) {
        DBContext db = new DBContext();
        db.getConnection();
    }
}
