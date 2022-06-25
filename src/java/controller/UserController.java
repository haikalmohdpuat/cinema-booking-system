/*
Project    : CINEMA BOOKING SYSTEM @ CSE3999
Lecturer   : DR. NORAIDA BINTI HJ ALI
Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
 */
package controller;

import dao.CustomerDAO;
import database.MySQL;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Admin;
import model.Customer;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class UserController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "delete":
                deleteCustomer(request, response);
                break;
            case "update":
                updateCustomer(request, response);
                break;
            case "login":
                loginCustomer(request, response);
                break;
            case "register":
                registerCustomer(request, response);
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        
        String custID = request.getParameter("custID");
        String custName = request.getParameter("custName");
        String custEmail = request.getParameter("custEmail");
        String phoneNumber = request.getParameter("phoneNumber");
        
        Customer customer= new Customer();
            
        customer.setCustID(custID);
        customer.setCustName(custName);
        customer.setCustEmail(custEmail);
        customer.setCustMobileNumber(phoneNumber);
                        
        int result = CustomerDAO.update(customer);

        if (result > 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Success in updating customer's record\")");
            out.println("window.location.href = './Admin/admin-homepage.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Failure in updating customer's record\")");
            out.println("window.location.href = './Admin/admin-homepage.jsp';");
            out.println("</script>");
        }
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        
        String custID = request.getParameter("custID");

        out.println("<script type=\"text/javascript\">");
//        out.println("var x = confirm(\"Do you want to delete this customer's account?\")");
//        out.println("if(x === true) {");
        int result = CustomerDAO.delete(custID);
        
        if (result > 0) {
            out.println("alert(\"Success in deleting customer account\")");
            out.println("window.location.href = './Admin/admin-homepage.jsp';");
        } else {
            out.println("alert(\"Failure in deleting the record\")");
            out.println("window.location.href = './Admin/admin-homepage.jsp';");   
        }
        
//        out.println("if(x === false) {");
//        out.println("window.location.href = './Admin/admin-homepage.jsp';}");
        out.println("</script>");
    }

    private void loginCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
       Connection connection = MySQL.getConnection();
        PrintWriter out = response.getWriter();
        String logID = request.getParameter("logID");
        String logPassword = request.getParameter("logPassword");
        String logRole = request.getParameter("logRole");
        Customer customer = null;
        Admin admin = null;
        if(logRole.equals("customer")){
            String selectCustomer = "SELECT * FROM customer where custID='" + logID + "' and " 
                + "custPassword='" + logPassword +"'";
            PreparedStatement statement = connection.prepareStatement(selectCustomer);
            ResultSet rs = statement.executeQuery();
        
                if(logID.isEmpty() || logPassword.isEmpty()) {
                    out.println("<script>");
                    out.println("alert('Please fill in all details')");
                    out.print("location=history.back()");
                    out.print("</script>");
                } else if(rs.next()){
                    
                    customer = new Customer(
                    rs.getString(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getInt(5),
                    rs.getString(6)
                    );
                    request.getSession().setAttribute("customer", customer);
                    response.sendRedirect("./Customer/homepage.jsp");
            } else {
                    out.println("<script>");
                    out.println("alert('Invalid Username or password')");
                    out.print("location=history.back()");
                    out.print("</script>");
            }
        } else if (logRole.equals("admin")){
            String selectAdmin = "SELECT * FROM admin where adminID='" + logID + "' and " 
                + "adminPassword='" + logPassword +"'";
            PreparedStatement statement = connection.prepareStatement(selectAdmin);
            ResultSet rs = statement.executeQuery();
        
                if(logID.isEmpty() || logPassword.isEmpty()) {
                    out.println("<script>");
                    out.println("alert('Please fill in all details')");
                    out.print("location=history.back()");
                    out.print("</script>");
                } else if(rs.next()){
                    
                    admin = new Admin(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
                    request.getSession().setAttribute("admin", admin);
                    response.sendRedirect("./Admin/admin-homepage.jsp");
            } else {
                    out.println("<script>");
                    out.println("alert('Invalid Username or password')");
                    out.print("location=history.back()");
                    out.print("</script>");
            }  
        }
    }

    private void registerCustomer(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        Connection connection = MySQL.getConnection();
        PrintWriter out = response.getWriter();
        //Generate logID String
        String logID = "";
        int startRange = 10000;
        int endRange = 99999;
        String str = "";     
        int status = 0;
        
        for(int i = 0; i < startRange; i++) {
            int rand = startRange + (int) (Math.random() * ((endRange - startRange) + 1));
            str = "S" + rand;
            status = CustomerDAO.findIDByString(str);
            if(status == 0) {
                logID = str;
                break;
            }         
        }
        
        String logName = request.getParameter ("logName");    
        String logEmail = request.getParameter("logEmail");
        String logPassword = request.getParameter("createPassword");
        String logMobileNumber = request.getParameter("logMobileNumber");       

        String selectCustomer = "INSERT INTO customer(custID,custName,custEmail,custPassword,custBalance,custMobileNumber) VALUES (?,?,?,?,?,?)";
        PreparedStatement statement = connection.prepareStatement(selectCustomer);
        
        statement.setString(1, logID);
        statement.setString(2, logName);
        statement.setString(3, logEmail);
        statement.setString(4, logPassword);
        statement.setInt(5, 1500);
        statement.setString(6, logMobileNumber);
        
        int statusRegister = statement.executeUpdate();
        
        if(statusRegister > 0){
            Customer customer = new Customer(
                    logID,
                    logName,
                    logEmail,
                    logPassword,
                    1500,
                    logMobileNumber
            );
            request.getSession().setAttribute("customer", customer);
            out.println("<script>");
            out.print("var x = ");
            out.println("'" + logID + "';");
            out.println("alert('Successful Registration !!!')");
            out.println("alert('Your auto generated ID is ' + x + ' ')");
            out.print("window.location.href='./Customer/homepage.jsp'");
            out.print("</script>");
        } else {
            out.println("<script>");
            out.println("alert('Unuccessful Registration')");
            out.print("window.location.href='./Customer/log-in.jsp'");
            out.print("</script>");
        }
    }
}
