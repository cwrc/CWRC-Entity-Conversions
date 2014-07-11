package org.ualberta.db;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author mpm1
 */
public class CEWWDatabaseExtractor {
    private Connection conn;
    
    public void execute() throws ClassNotFoundException, IOException, SQLException{
        Class.forName("com.mysql.jdbc.Driver");
        
        BufferedReader input = new BufferedReader(new InputStreamReader(System.in));
        
        System.out.print("User Name: ");
        String userName = input.readLine();
        
        System.out.print("Password: ");
        String password = input.readLine();
        
        System.out.println("Connecting to database...");
        conn = DriverManager.getConnection("", userName, password);
        
        conn.close();
    }
}
