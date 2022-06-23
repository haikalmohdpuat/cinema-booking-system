/*
Project    : CINEMA BOOKING SYSTEM @ CSE3999
Lecturer   : DR. NORAIDA BINTI HJ ALI
Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
 */
package dao;

import database.MySQL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Customer;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class CustomerDAO {
    
    public static int update(Customer customer) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "UPDATE customer "
                    + "SET custName=?, custEmail=?, custMobileNumber=? "
                    + "WHERE custID=?";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, customer.getCustName());
            stmt.setString(2, customer.getCustEmail());
            stmt.setString(3, customer.getCustMobileNumber());
            stmt.setString(4, customer.getCustID());
            result = stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Exception is ; " + e);
        } finally {
            if(connection != null && stmt != null) {
                connection.close();
                stmt.close();
            }
        }
        return result;
    }
    
    public static int delete(String custID) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        String id = custID.trim();
        System.out.println("Kucing");
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "DELETE FROM customer WHERE custID=?";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, id);
            
            result = stmt.executeUpdate();
        }
        catch (SQLException e) {
            System.out.println("Exception is ;" + e);
        } finally {
            if(connection != null && stmt != null) {
                connection.close();
                stmt.close();
            }
        }
        return result;
    }
    
    public static List<Customer> findAllCustomers() throws SQLException {
        List<Customer> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
             connection = MySQL.getConnection();
             String sqlSelect = "SELECT * FROM customer";
             stmt = connection.prepareStatement(sqlSelect);
             rs = stmt.executeQuery(sqlSelect);
             
             while(rs.next()) {
                 Customer customer = new Customer(rs.getString(1), rs.getString(2), rs.getString(3),
                                                  rs.getString(4), rs.getInt(5), rs.getString(6));
                 l.add(customer);
             } 
        } catch(Exception e) {
            System.out.println(e);
        } finally {
            if(connection != null && stmt != null && rs != null) {
                MySQL.closeConnection(connection, stmt, rs);
            }
        }
        return l;
    } 
    
    public static Customer findCustomerByID(String id) throws SQLException {
        Customer customer = null;
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
             connection = MySQL.getConnection();
             String sqlSelect = "SELECT * FROM customer where custID='" + id + "'";
             stmt = connection.prepareStatement(sqlSelect);
             rs = stmt.executeQuery(sqlSelect);
             
             if(rs.next()) {
                 customer = new Customer(rs.getString(1), rs.getString(2), rs.getString(3),
                                                  rs.getString(4), rs.getInt(5), rs.getString(6));
             }
        } catch(Exception e) {
            System.out.println(e);
        }  finally {
            if(connection != null && stmt != null && rs != null) {
                MySQL.closeConnection(connection, stmt, rs);
            }
        }
        return customer;
    } 
    
    public static int updateBalance(String id, int balance) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement stmt = null;        
            try {
                connection = MySQL.getConnection();
                String sqlInsert = "UPDATE customer SET custBalance=? WHERE custID=?";
                PreparedStatement ps = connection.prepareStatement(sqlInsert);
                
                ps.setInt(1, balance);
                ps.setString(2, id);
                
                status = ps.executeUpdate();
            } catch (SQLException ex) {
                ex.getMessage();
            }  finally {
                if(connection != null && stmt != null) {
                    connection.close();
                    stmt.close();
                }
            }
        return status;
    }
    
    public static String findCustomerIDByNameAndEmail(String name, String email) throws SQLException {
        String s = "";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
             connection = MySQL.getConnection();
             String sqlSelect = "SELECT custID FROM customer where custName='" + name + "' AND"
                                + " custEmail='" + email + "'";
             stmt = connection.prepareStatement(sqlSelect);
             rs = stmt.executeQuery(sqlSelect);
             
             if(rs.next()) {
                 s = rs.getString(1);
             }
        } catch(SQLException e) {
            System.out.println(e);
        }  finally {
            if(connection != null && stmt != null && rs != null) {
                MySQL.closeConnection(connection, stmt, rs);
            }
        }
        return s;
    }
    
    public static int findIDByString(String rand) {
        int status = 0;
        try {
             Connection connection = MySQL.getConnection();
             Statement stmt = connection.createStatement();
             String sqlSelect = "SELECT custID FROM customer where custID='" + rand + "'";
             ResultSet rs = stmt.executeQuery(sqlSelect);
             
             if(rs.next()) {
                 status++;
             }
        } catch(Exception e) {
            System.out.println(e);
        }
        return status;
    }
}
