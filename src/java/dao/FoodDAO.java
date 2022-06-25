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
import model.Food;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class FoodDAO {

    public static List<Food> findAllFoodByFoodType(String foodType) throws SQLException {
        List<Food> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT * FROM food where foodType ='" + foodType + "'";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);
            while (rs.next()) {

                Food f = new Food(
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5)
                );

                l.add(f);
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if (connection != null && stmt != null && rs != null) {
                MySQL.closeConnection(connection, stmt, rs);
            }
        }
        return l;
    }

    public static List<Food> findAllFood() throws SQLException {
        List<Food> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT * FROM food";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);
            while (rs.next()) {

                Food f = new Food(
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5)
                );

                l.add(f);
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if (connection != null && stmt != null && rs != null) {
                MySQL.closeConnection(connection, stmt, rs);
            }
        }
        return l;
    }

    public static int findFoodIDByFoodDescription(String description) throws SQLException {
        int x = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT foodID FROM food where foodDescription='" + description + "'";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);

            if (rs.next()) {
                x = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if (connection != null && stmt != null && rs != null) {
                MySQL.closeConnection(connection, stmt, rs);
            }
        }
        return x;
    }

}
