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
import model.Order;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class OrderDAO {
    public static int add(String tid, String details, int quantity, int price) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement ps = null;

            try {
                connection = MySQL.getConnection();
                String sqlInsert = "INSERT INTO food_order(ticketID, foodDetails, foodQuantity, pricePerFood) VALUES(?,?,?,?)";
                ps = connection.prepareStatement(sqlInsert);
                
                ps.setString(1, tid);
                ps.setString(2, details);
                ps.setInt(3, quantity);
                ps.setInt(4, price);
                
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
    
    public static List<Order> findAllFoodOrderFromTicketID(String ticketID) throws SQLException {
        List<Order> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM food_order where ticketID='" + ticketID +"'";
                ps = connection.prepareStatement(sqlSelect);
                rs = ps.executeQuery(sqlSelect);
                while(rs.next()) {                
                    Order f = new Order(
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5)
                    );
                
                    l.add(f);
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
}
