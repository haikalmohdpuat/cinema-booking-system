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
import model.Seat;


/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class SeatDAO {
    
    public static int add(String seatID, String ticketID, String hallID) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;

            try {
                connection = MySQL.getConnection();
                String sqlInsert = "INSERT INTO seat(seatID, ticketID, hall_ID) VALUES(?,?,?)";
                ps = connection.prepareStatement(sqlInsert);
                
                ps.setString(1, seatID);
                ps.setString(2, ticketID);
                ps.setString(3, hallID);
                
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
    
    public static List<Seat> findSeatByTicketID(String ticketID) throws SQLException {
        List<Seat> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlInsert = "SELECT * FROM seat WHERE ticketID=?";
                ps = connection.prepareStatement(sqlInsert);
                
                ps.setString(1, ticketID);
                
                rs = ps.executeQuery();
                
                while(rs.next()) {
                    Seat seat = new Seat(rs.getString(1), rs.getString(2), rs.getString(3));
                    l.add(seat);
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
    
    public static int findSeatIDByDateAndTime(String date, String time, String seatID, String id) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlInsert = "SELECT seatID FROM seat INNER JOIN ticket ON ticket.ticketID = seat.ticketID "
                                 + "INNER JOIN movie ON movie.movieID = ticket.movieID "
                                 + "WHERE movieDate='" +  date + "'AND movieTime='" + time
                                 + "' AND seatID='" + seatID + "' AND hall_ID='" + id + "'";
                ps = connection.prepareStatement(sqlInsert);                
                rs = ps.executeQuery();
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
    
   public static int update(String newSeat, String oldSeat, String ticket) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;

            try {
                connection = MySQL.getConnection();
                String sqlInsert = "UPDATE seat SET seatID=? WHERE seatID=? AND ticketID=?";
                ps = connection.prepareStatement(sqlInsert);
                
                ps.setString(1, newSeat);
                ps.setString(2, oldSeat);
                ps.setString(3, ticket);
                
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
