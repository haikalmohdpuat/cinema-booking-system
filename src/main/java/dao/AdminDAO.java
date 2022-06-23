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
import model.Admin;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class AdminDAO {
    /**
     * This method is used to get a record with full details from database
     *
     * @param id
     * @return instance if successful
     */
    public static Admin getRecordAdmin(int id) {
        Admin e = new Admin();
        try {
            Connection connection = MySQL.getConnection();
            Statement stmt = connection.createStatement();
            String sqlSelect = "select * from admin where admin_id=" + id;
            ResultSet rs = stmt.executeQuery(sqlSelect);
            if (rs.next()) {
                e.setAdminID(rs.getString(1));
                e.setAdminName(rs.getString(2));
                e.setAdminEmail(rs.getString(3));
                e.setAdminPassword(rs.getString(4));
            }
        } catch (SQLException ex) {
            ex.getMessage();
        }
        return e;
    }

    /**
     * This method is used to retrieve all records of admin from database
     *
     * @param id
     * @return List of records from database
     */
    public static List<Admin> findAllAdmin() {
        List<Admin> list = new ArrayList<>();
        try {
            Connection connection = MySQL.getConnection();
            Statement stmt = connection.createStatement();
            String sqlSelect = "select * from admin";
            ResultSet rs = stmt.executeQuery(sqlSelect);
            while (rs.next()) {
                Admin e = new Admin(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)
                    );
                
                list.add(e);

            }
        } catch (SQLException ex) {
            ex.getMessage();
        }

        return list;
    }

    /**
     * This method is used to add admin into the database with its
     *
     * @param e
     * @return status > 0 if successful
     */
    public static int add(Admin e) {
        int status = 0;
        try {
            String sqlInsert = "insert into admin(admin_id,admin_name,admin_email,admin_password)"
                    + "values(?,?,?,?)";
            PreparedStatement pstmt = MySQL.getConnection().prepareStatement(sqlInsert);
            pstmt.setString(1, e.getAdminID());
            pstmt.setString(2, e.getAdminName());
            pstmt.setString(3, e.getAdminEmail());
            pstmt.setString(4, e.getAdminPassword());
            status = pstmt.executeUpdate();
        } catch (SQLException ex) {
            ex.getMessage();
        }
        return status;
    }

    /**
     * Use this method to update admin to database
     *
     * @param e
     * @return status > 0 if the method is successful
     */
    public static int update(Admin e) {
        int status = 0;
        try {
            //Connection con = MySQL.getConnection();
            String sqlUpdate = "update admin set admin_id=?,movie_name=?,admin_email=?,admin_password=? "
                    + "where admin_id=?";
            PreparedStatement ps
                    = MySQL.getConnection().prepareStatement(sqlUpdate);
            ps.setString(1, e.getAdminID());
            ps.setString(2, e.getAdminName());
            ps.setString(3, e.getAdminEmail());
            ps.setString(4, e.getAdminPassword());
            status = ps.executeUpdate();

        } catch (SQLException ex) {
            ex.getMessage();
        }

        return status;
    }

    /**
     * This method delete a record of a admin from a table in database
     *
     * @param e
     * @return status > 0 if successful
     */
    public static int delete(Admin e) {
        int status = 0;
        try {
            Statement stmt = MySQL.getConnection().createStatement();
            String sqlDelete = "delete from admin where admin_id=" + e.getAdminID();
            status = stmt.executeUpdate(sqlDelete);

        } catch (SQLException ex) {
            ex.getMessage();
        }
        return status;
    }
}
