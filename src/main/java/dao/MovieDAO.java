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

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class MovieDAO {
    
    public static int add(Movie movie) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        int length = movie.getMovieDate().length();
        String year = movie.getMovieDate().substring(0, 4);
        String month = movie.getMovieDate().substring(5, 7);
        String day = movie.getMovieDate().substring(length - 2);
        
        String date = day + "/" + month + "/" + year;
        
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "INSERT INTO movie "
                    + "(movieID, movieName, movieGenre, movieDate, movieTime, movieLanguage, movieDuration, moviePrice) " 
                    + "value(?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, movie.getMovieID());
            stmt.setString(2, movie.getMovieName());
            stmt.setString(3, movie.getMovieGenre());
            stmt.setString(4, date);
            stmt.setString(5, movie.getMovieTime());
            stmt.setString(6, movie.getMovieLanguage());
            stmt.setInt(7, movie.getMovieDuration());
            stmt.setDouble(8, movie.getMoviePrice());
            result = stmt.executeUpdate();
        }
        catch (SQLException e) {
            System.out.println("Exception is ;" + e);
        } finally {
            if(connection != null && stmt != null && rs != null) {
                MySQL.closeConnection(connection, stmt, rs);
            }
        }
        return result;
    }
    
    public static int update(Movie movie) {
        int result = 0;
        Connection connection = null;
        PreparedStatement myPs = null;
        
        int length = movie.getMovieDate().length();
        String year = movie.getMovieDate().substring(0, 4);
        String month = movie.getMovieDate().substring(5, 7);
        String day = movie.getMovieDate().substring(length - 2);
        
        String date = day + "/" + month + "/" + year;
        
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "update movie "
                    + "set movieName=?, movieGenre=?, movieDate=?, movieTime=?, movieLanguage=?, movieDuration=?, moviePrice=? "
                    + "where movieID=?";
            myPs = connection.prepareStatement(mySqlQuery);
            myPs.setString(1, movie.getMovieName());
            myPs.setString(2, movie.getMovieGenre());
            myPs.setString(3, date);
            myPs.setString(4, movie.getMovieTime());
            myPs.setString(5, movie.getMovieLanguage());
            myPs.setInt(6, movie.getMovieDuration());
            myPs.setDouble(7, movie.getMoviePrice());
            myPs.setString(8, movie.getMovieID());
            result = myPs.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Exception is ; " + e);
        } finally {
            try {
                connection.close();
                myPs.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
        return result;
    }
    
    public static int delete(String movieID) {
        int result = 0;
        Connection connection = null;
        PreparedStatement myPs = null;
        
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "DELETE FROM movie WHERE movieID=?";
            myPs = connection.prepareStatement(mySqlQuery);
            myPs.setString(1, movieID);
            result = myPs.executeUpdate();
        }
        catch (SQLException e) {
            System.out.println("Exception is ;" + e);
        } finally {
            try {
                connection.close();
                myPs.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
        return result;
    }
    
    public static List<Movie> findAllMovies() throws SQLException {
        List<Movie> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM movie";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                while(rs.next()) {
                
                    Movie s = new Movie(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                    );
                
                    l.add(s);
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
            return l;
    }
    
    public static Movie findMovieByMovieID(String id) throws SQLException {
        Movie movie = null;
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM movie where movieID='" + id +"'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                if(rs.next()) {
                
                    movie = new Movie(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                    );
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
            return movie;
    }
    
    public static String findMovieIDByMovieName(String name) throws SQLException {
        String s = "";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT movieID FROM movie where movieName='" + name + "'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                if(rs.next()) {                
                    s = rs.getString(1);
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        return s;
    }
    
    public static String findMovieNameByMovieID(String id) throws SQLException {
        String s = "";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT movieName FROM movie where movieID='" + id + "'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                if(rs.next()) {                
                    s = rs.getString(1);
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        return s;
    }
    
    public static int findMoviePriceByMovieID(String id) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT moviePrice FROM movie where movieID='" + id + "'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                if(rs.next()) {                
                    status = rs.getInt(1);
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        return status;
    }
    
    public static int findMovieIDByString(String id) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT movieID FROM movie where movieID='" + id + "'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                if(rs.next()) {                
                    status++;
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        return status;
    }
}
