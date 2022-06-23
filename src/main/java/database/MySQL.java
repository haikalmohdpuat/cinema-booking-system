/*
Project    : CINEMA BOOKING SYSTEM @ CSE3999
Lecturer   : DR. NORAIDA BINTI HJ ALI
Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
 */
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class MySQL {
    public static Connection getConnection() throws SQLException {
        Connection myConnection = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/cinema_booking_system";
            String user = "root";
            String password = "admin";

            // create a connection to the database
            myConnection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }
        return myConnection;
    }
    
    public static void closeConnection(Connection connection, PreparedStatement statement, ResultSet resultSet) throws SQLException {
       connection.close();
       statement.close();
       resultSet.close();
    }
}
