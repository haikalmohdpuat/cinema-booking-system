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
import model.Movie;
import model.Ticket;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class TicketDAO {    
    
    public static int add(Ticket t) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;

            try {
                connection = MySQL.getConnection();
                String sqlSelect = "INSERT INTO ticket(ticketID, movieID, custID, ticketDate, ticketTime, ticketType) VALUES(?,?,?,?,?,?)";
                ps = connection.prepareStatement(sqlSelect);
                
                ps.setString(1, t.getTicketID());
                ps.setString(2, t.getMovieID());
                ps.setString(3, t.getCustID());
                ps.setString(4, t.getTicketDate());
                ps.setString(5, t.getTicketTime());
                ps.setString(6, t.getTicketType());
                
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
    
    public static int delete(String id) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;

            try {
                connection = MySQL.getConnection();
                String sqlSelect = "DELETE from ticket where ticketID=?";
                ps = connection.prepareStatement(sqlSelect);
                
                ps.setString(1, id);
                
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
    
    public static int update(Movie movie) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;
        
        int length = movie.getMovieDate().length();
        String year = movie.getMovieDate().substring(0, 4);
        String month = movie.getMovieDate().substring(5, 7);
        String day = movie.getMovieDate().substring(length - 2);
        
        String date = day + "/" + month + "/" + year;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "UPDATE ticket SET ticketDate=?, ticketTime=? WHERE movieID=?";
                ps = connection.prepareStatement(sqlSelect);
                
                ps.setString(1, date);
                ps.setString(2, movie.getMovieTime());
                ps.setString(3, movie.getMovieID());
                
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
    
    public static List<Ticket> findTicketID() throws SQLException {
        List<Ticket> l = new ArrayList<>();        
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT ticketID FROM ticket";
                ps = connection.prepareStatement(sqlSelect);
                rs = ps.executeQuery(sqlSelect);
                while(rs.next()) {
                
                    Ticket s = new Ticket(
                        rs.getString(1)
                    );
                    l.add(s);
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
    
    public static int findTicketIDByString(String str) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT ticketID FROM ticket where ticketID='" + str + "'";
                ps = connection.prepareStatement(sqlSelect);
                rs = ps.executeQuery(sqlSelect);
                if(rs.next()) {                  
                    status++;
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && ps != null && rs != null) {
                    MySQL.closeConnection(connection, ps, rs);
                }
            }
            return status;
    }
    
    public static List<Ticket> findNumOfTicketByMovieID(String str) throws SQLException {
        List<Ticket> list = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT ticketID FROM ticket where movieID='" + str + "'";
                ps = connection.prepareStatement(sqlSelect);
                rs = ps.executeQuery(sqlSelect);
                while(rs.next()) {                  
                    Ticket t = new Ticket (
                            rs.getString(1)
                        );
                    list.add(t);
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && ps != null && rs != null) {
                    MySQL.closeConnection(connection, ps, rs);
                }
            }
        return list;
    }
    
    public static List<Ticket> findAllTickets() throws SQLException {
        List<Ticket> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM ticket";
                ps = connection.prepareStatement(sqlSelect);
                rs = ps.executeQuery(sqlSelect);
                while(rs.next()) {
                
                    Ticket s = new Ticket(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)
                    );
                
                    l.add(s);
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
    
    public static List<Ticket> findAllTicketByCustID(String id) throws SQLException {
        List<Ticket> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM ticket where custID='" + id + "'";
                ps = connection.prepareStatement(sqlSelect);
                rs = ps.executeQuery(sqlSelect);
                while(rs.next()) {
                
                    Ticket s = new Ticket(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)
                    );
                
                    l.add(s);
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
    
    public static int findTicketIDByMovieID(String str) throws SQLException {
        int status = 0;
        String id = str.trim();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM ticket where movieID='" + id + "'";
                ps = connection.prepareStatement(sqlSelect);
                rs = ps.executeQuery(sqlSelect);
                if(rs.next()) {                  
                    status++;
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && ps != null && rs != null) {
                    MySQL.closeConnection(connection, ps, rs);
                }
            }
        return status;
    }
    
}
