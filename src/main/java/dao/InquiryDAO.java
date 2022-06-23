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
import model.Inquiry;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class InquiryDAO {
    public static int add(Inquiry inquiry) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;
            try {
                connection = MySQL.getConnection();
                String sqlInsert = "INSERT INTO inquiry(inquiryID, custID, inquiryCategory, inquirySubCategory, inquiryMessage, inquiryStatus) VALUES(?,?,?,?,?,?)";
                ps = connection.prepareStatement(sqlInsert);

                ps.setString(1, inquiry.getInquiryID());
                ps.setString(2, inquiry.getCustID());
                ps.setString(3, inquiry.getInquiryCategory());
                ps.setString(4, inquiry.getInquirySubCategory());
                ps.setString(5, inquiry.getInquiryMessage());
                ps.setString(6, inquiry.getInquiryStatus());
                
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
    
    public static int addResponse(Inquiry inquiry) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;

            try {
                connection = MySQL.getConnection();
                String sqlInsert = "INSERT INTO inquiry_record(inquiryID, userID, inquiryAnswer) VALUES(?,?,?)";
                ps = connection.prepareStatement(sqlInsert);

                ps.setString(1, inquiry.getInquiryID());
                ps.setString(2, inquiry.getUserID());
                ps.setString(3, inquiry.getInquiryAnswer());
                
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
    
    public static List<Inquiry> findAllInquiry() throws SQLException {
        List<Inquiry> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlInsert = "SELECT * FROM inquiry";
                ps = connection.prepareStatement(sqlInsert);
                rs = ps.executeQuery();
                while(rs.next()) {
                    
                    Inquiry inquiry = new Inquiry
                            (rs.getString(1), rs.getString(2), rs.getString(3)
                            , rs.getString(4), rs.getString(5), rs.getString(6));
                    
                    l.add(inquiry);
                }
            } catch (SQLException ex) {
                ex.getMessage();
            }  finally {
                if(connection != null && ps != null && rs != null) {
                    MySQL.closeConnection(connection, ps, rs);
                }
            }
        return l;
    }
    
    public static List<Inquiry> findAllInquiryByCustID(String id) throws SQLException {
        List<Inquiry> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
            try {
                connection = MySQL.getConnection();
                String sqlInsert = "SELECT * FROM inquiry WHERE custID='" + id + "'";
                ps = connection.prepareStatement(sqlInsert);
                rs = ps.executeQuery();
                while(rs.next()) {
                    
                    Inquiry inquiry = new Inquiry
                            (rs.getString(1), rs.getString(2), rs.getString(3)
                            , rs.getString(4), rs.getString(5), rs.getString(6));
                    
                    l.add(inquiry);
                }
            } catch (SQLException ex) {
                ex.getMessage();
            }  finally {
                if(connection != null && ps != null && rs != null) {
                    MySQL.closeConnection(connection, ps, rs);
                }
            }
        return l;
    }
    
    public static int findInquiryIDByString(String id) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
            try {
                connection = MySQL.getConnection();
                String sqlInsert = "SELECT inquiryID FROM inquiry WHERE inquiryID='" + id + "'";
                ps = connection.prepareStatement(sqlInsert);
                rs = ps.executeQuery();
                if(rs.next()) {
                    status++;
                }
            } catch (SQLException ex) {
                ex.getMessage();
            }  finally {
                if(connection != null && ps != null && rs != null) {
                    MySQL.closeConnection(connection, ps, rs);
                }
            }
        return status;
    }
    
    public static List<Inquiry> findListOfInquiryAnswerByInquiryID(String id) throws SQLException {
        List<Inquiry> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlInsert = "SELECT * FROM inquiry_record WHERE inquiryID='" + id + "'";
                ps = connection.prepareStatement(sqlInsert);
                rs = ps.executeQuery();
                while(rs.next()) {
                    Inquiry inquiry = new Inquiry(rs.getString(2), rs.getString(3), rs.getString(4));
                    l.add(inquiry);
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && ps != null && rs != null) {
                    MySQL.closeConnection(connection, ps, rs);
                }
            }
        return l;
    }
    
    public static int delete(String id) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;

            try {
                connection = MySQL.getConnection();
                String sqlInsert = "DELETE FROM inquiry WHERE inquiryID='" + id + "'";
                ps = connection.prepareStatement(sqlInsert);
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
    
    public static int update(String id, String message) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;

            try {
                connection = MySQL.getConnection();
                String sqlInsert = "UPDATE inquiry SET inquiryStatus='" + message + "' WHERE inquiryID='" + id + "'";
                ps = connection.prepareStatement(sqlInsert);
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
    
}
