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
import dao.MovieDAO;
import dao.PaymentDAO;
import dao.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;
import model.Payment;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class TicketController extends HttpServlet {

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
        try(PrintWriter writer = response.getWriter()) {
            
            String id = request.getParameter("ticketID");
            String action = request.getParameter("action");
            
            int balanceStatus = 0;
            int paymentStatus = 0;
            int deleteStatus = 0;
            Customer customer = null;
            Payment payment1, payment2;
           
            switch(action) {
                case "deleteFromCustomer" :
                    customer = (Customer) request.getSession().getAttribute("customer");         
                    payment1 = PaymentDAO.findPaymentByID(id);
                    payment2 = new Payment(customer.getCustID(), id , "Refund", payment1.getPaymentAmount(), customer.getCustBalance() + payment1.getPaymentAmount());
                    deleteStatus = TicketDAO.delete(id);
                    paymentStatus = PaymentDAO.add(payment2);
                    balanceStatus = CustomerDAO.updateBalance(customer.getCustID(), customer.getCustBalance() + payment1.getPaymentAmount());
                        if(deleteStatus > 0 && balanceStatus > 0 && paymentStatus > 0) {
                        customer.setCustBalance(customer.getCustBalance() + payment1.getPaymentAmount());
                        writer.println("<script type=\"text/javascript\" defer>");
                        writer.println("alert('Ticket has been cancelled (by customer)');");
                        writer.println("window.location.href = './Customer/customer-ticket.jsp';");
                        writer.println("</script>");
                    } else {
                        writer.println("<script type=\"text/javascript\">");
                        writer.println("alert('Ticket cancellation failed');");
                        writer.println("window.location.href = './Customer/customer-ticket.jsp';");
                        writer.println("</script>");
                    }
                    break;
                    
                case "deleteFromAdmin" :
                    String custID = request.getParameter("custID");
                    customer = CustomerDAO.findCustomerByID(custID);
                    payment1 = PaymentDAO.findPaymentByID(id);
                    payment2 = new Payment(customer.getCustID(), id , "Refund", payment1.getPaymentAmount(), customer.getCustBalance() + payment1.getPaymentAmount());
                    deleteStatus = TicketDAO.delete(id);
                    paymentStatus = PaymentDAO.add(payment2);
                    balanceStatus = CustomerDAO.updateBalance(customer.getCustID(), customer.getCustBalance() + payment1.getPaymentAmount());
                    if(deleteStatus > 0 && balanceStatus > 0 && paymentStatus > 0) {
                        writer.println("<script type=\"text/javascript\" defer>");
                        writer.println("alert('Ticket has been cancelled (by admin)');");
                        writer.println("window.location.href = './Admin/admin-ticket.jsp';");
                        writer.println("</script>");
                    } else {
                        writer.println("<script type=\"text/javascript\">");
                        writer.println("alert('Ticket cancellation failed');");
                        writer.println("window.location.href = './Admin/admin-ticket.jsp';");
                        writer.println("</script>");
                    }
                    break;

            }
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
            Logger.getLogger(TicketController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(TicketController.class.getName()).log(Level.SEVERE, null, ex);
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

}
