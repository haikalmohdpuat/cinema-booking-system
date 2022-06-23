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
import java.util.ArrayList;
import java.util.List;
import model.Payment;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class PaymentDAO {
    public static int add(Payment payment) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;
            try {
                connection = MySQL.getConnection();
                String sqlInsert = "INSERT INTO payment(custID, ticketID, paymentStatus, paymentAmount, currentBalance) VALUES(?,?,?,?,?)";
                ps = connection.prepareStatement(sqlInsert);
                
                ps.setString(1, payment.getCustID());
                ps.setString(2, payment.getTicketID());
                ps.setString(3, payment.getPaymentStatus());
                ps.setInt(4, payment.getPaymentAmount());
                ps.setInt(5, payment.getCurrentBalance());
                
                status = ps.executeUpdate();
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && ps != null) {
                    connection.close();
                    ps.close();
                }
            }
        return status;
    }
    
    public static Payment findPaymentByID(String id) throws SQLException {
        Payment payment = null;
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM payment where ticketID='" + id + "'";
                ps = connection.prepareStatement(sqlSelect);
                rs = ps.executeQuery(sqlSelect);
                
                if(rs.next()) {
                    payment = new Payment(
                            rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4), 
                            rs.getInt(5),
                            rs.getInt(6));
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && ps != null && rs != null) {
                    MySQL.closeConnection(connection, ps, rs);
                }
            }
        return payment;
    }
    
    public static List<Payment> findAllPayments() throws SQLException {
        List<Payment> plist = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM payment ORDER BY paymentID";
                ps = connection.prepareStatement(sqlSelect);
                rs = ps.executeQuery(sqlSelect);
                
                while(rs.next()) {
                    Payment payment = new Payment(
                            rs.getInt(1), 
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4), 
                            rs.getInt(5),
                            rs.getInt(6));
                    plist.add(payment);                   
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && ps != null && rs != null) {
                    MySQL.closeConnection(connection, ps, rs);
                }
            }
        return plist;
    }
    
    
    public static List<Payment> findListOfPaymentByCustID(String custID) throws SQLException {
        List<Payment> plist = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM payment where custID='" + custID + "'";
                ps = connection.prepareStatement(sqlSelect);
                rs = ps.executeQuery(sqlSelect);
                
                while(rs.next()) {
                    Payment payment = new Payment(
                            rs.getInt(1), 
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4), 
                            rs.getInt(5),
                            rs.getInt(6));
                    plist.add(payment);                   
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && ps != null && rs != null) {
                    MySQL.closeConnection(connection, ps, rs);
                }
            }
        return plist;
    }
    
    public static int delete(String id) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;
            try {
                connection = MySQL.getConnection();
                String sqlInsert = "DELETE FROM payment WHERE custID='" + id + "'";
                ps = connection.prepareStatement(sqlInsert);
                
                status = ps.executeUpdate();
            } catch (SQLException ex) {
                ex.getMessage();
            }  finally {
                if(connection != null && ps != null) {
                    connection.close();
                    ps.close();
                }
            }
        return status;
    }
}
