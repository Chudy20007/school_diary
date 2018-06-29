/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dziennik;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.PreparedStatement;
import java.io.*;
import java.util.regex.Pattern;

/**
 *
 * @author Kacper-PC
 */
public class DbContext{ 

    private String connectionUrl;
    Connection DbConnection;
    private Teacher loggedTeacher;

    public DbContext(String connUrl, Teacher teacher) {

        this.connectionUrl = connUrl;
        this.loggedTeacher = teacher;

    }
 public void setConnection(){
             try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            DbConnection = DriverManager.getConnection(this.connectionUrl, loggedTeacher.getTeacherLogin(), loggedTeacher.getTeacherPassword());
            if (!DbConnection.isClosed()) {
                System.out.println("Successfully connected to " + "MySQL server using TCP/IP...");
            }
        } catch (Exception ex) {
            Logger.getLogger(DbContext.class.getName()).log(Level.SEVERE, null, ex);
        }
 }   
    public Connection getDbConnection(){
        return DbConnection;
    }
    
    public PreparedStatement prepareStatement(String query){
      
        try {
            PreparedStatement statement;
            statement = getDbConnection().prepareStatement(query);
            return statement;
        } catch (SQLException ex) {
            Logger.getLogger(DbContext.class.getName()).log(Level.SEVERE, null, ex);
        }
       
         return null;   
        }
    
    public boolean checkString(String value){
        final Pattern pattern = Pattern.compile("^[A-Za-z, ]++$");
    if (!pattern.matcher(value).matches()) {
        return false;
    }
       return true; 
    }
    
        public boolean checkDecimal(String value){
        final Pattern pattern = Pattern.compile("^\\d*\\.\\d+|\\d+\\.\\d*$");
    if (!pattern.matcher(value).matches()) {
        return false;
    }
       return true; 
    }
    
  
    
    }

