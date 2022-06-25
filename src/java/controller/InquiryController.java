/*
Project    : CINEMA BOOKING SYSTEM @ CSE3999
Lecturer   : DR. NORAIDA BINTI HJ ALI
Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
 */
package controller;

import dao.InquiryDAO;
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
import model.Inquiry;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class InquiryController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");

            switch(action) {
                case "add":
                    addInquiry(request, response);
                    break;
                case "delete":
                    deleteInquiry(request, response);
                    break;
                case "close":
                    closeInquiry(request, response);
                    break;
                case "save":
                    saveInquiryResponse(request, response);
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
            Logger.getLogger(InquiryController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(InquiryController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void addInquiry(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        
        PrintWriter out = response.getWriter();
        Customer customer = (Customer) request.getSession().getAttribute("customer");
        String categoryName = request.getParameter("inquiryCategory_create");
        String id = request.getParameter("inquiryID_create");
        String message = request.getParameter("inquiryMessage_create");
        String subCategory;
        String category;
        Inquiry inquiry;
        int status = 0;
        
        switch (categoryName) {
            case "profile":
                category = "Profile Update";
                subCategory =  request.getParameter("profileDropdown").equals("1")?
                                      "Name" : request.getParameter("profileDropdown").equals("2")?
                                      "Email": request.getParameter("profileDropdown").equals("3")?
                                      "Password": "Phone Number";
                        
                inquiry = new Inquiry(id, customer.getCustID(), category, subCategory, message, "Open");                        
                status = InquiryDAO.add(inquiry);
                break;
                
            case "ticket":
                category = "Ticket Update";
                subCategory =  request.getParameter("ticketDropdown").equals("1")?
                                      "Seat" : request.getParameter("ticketDropdown").equals("2")?
                                      "Food": "Hall";
                        
                inquiry = new Inquiry(id, customer.getCustID(), category, subCategory, message, "Open");                        
                status = InquiryDAO.add(inquiry);
                break;
            case "bugs":
                category = "Bugs Report";
                subCategory =  request.getParameter("bugsDropdown").equals("1")?
                              "Missing payment details" : request.getParameter("bugsDropdown").equals("2")?
                              "Typo": "Missing ticket details";
                        
                inquiry = new Inquiry(id, customer.getCustID(), category, subCategory, message, "Open");                        
                status = InquiryDAO.add(inquiry);
                break;
            case "movie":
                category = "Movie Request";
                subCategory =  request.getParameter("movieDropdown").equals("1")?
                              "Classic" : request.getParameter("movieDropdown").equals("2")?
                              "Horror": request.getParameter("movieDropdown").equals("3")?
                              "Action": "Sports";
                        
                inquiry = new Inquiry(id, customer.getCustID(), category, subCategory, message, "Open");                        
                status = InquiryDAO.add(inquiry);
                break;
        }
               
        if(status > 0) {                        
            out.println("<script type=\"text/javascript\" defer>");
            out.println("alert('Inquiry has been successfully created. Please wait for the response of admin');");
            out.println("window.location.href = './Customer/customer-inquiry.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Inquiry creation failed');");
            out.println("window.location.href = './Customer/customer-inquiry.jsp';");
            out.println("</script>");
        }
    }

    private void deleteInquiry(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        
        PrintWriter out = response.getWriter();
        String id = request.getParameter("inquiryID");
        
        int status = InquiryDAO.delete(id);
        
        if(status > 0) {                        
            out.println("<script type=\"text/javascript\" defer>");
            out.println("alert('Inquiry has been successfully deleted');");
            out.println("window.location.href = './Customer/customer-inquiry.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Inquiry deletion failed');");
            out.println("window.location.href = './Customer/customer-inquiry.jsp';");
            out.println("</script>");
        }
    }

    private void saveInquiryResponse(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        
        PrintWriter out = response.getWriter();
        String inqid = request.getParameter("txtInquiryID");
        String userid = request.getParameter("userID");
        String answer = request.getParameter("inquiryResponse");
        String type = request.getParameter("userType");
        Inquiry inquiry = new Inquiry(inqid, userid, answer);
        
        int status = InquiryDAO.addResponse(inquiry);
        int status2 = InquiryDAO.update(inqid, "Replied");
                     
        System.out.println(status);
        System.out.println(status2);
        
        if(status > 0 && status2 > 0) {
            if(!type.equals("customer")) {
                out.println("<script type=\"text/javascript\" defer>");
                out.println("alert('Inquiry response has been successfully saved');");
                out.println("window.location.href = './Admin/admin-inquiry.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\" defer>");
                out.println("alert('Inquiry response has been successfully saved');");
                out.println("window.location.href = './Customer/customer-inquiry.jsp';");
                out.println("</script>");
            }
        } else {
            if(!type.equals("customer")) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Inquiry response failed');");
                out.println("window.location.href = './Admin/admin-inquiry.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\" defer>");
                out.println("alert('Inquiry response failed');");
                out.println("window.location.href = './Customer/customer-inquiry.jsp';");
                out.println("</script>");
            }
        }
    }

    private void closeInquiry(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        
        PrintWriter out = response.getWriter();
        String id = request.getParameter("inquiryID");
        
        int status = InquiryDAO.update(id, "Closed");
        
        if(status > 0) {                        
            out.println("<script type=\"text/javascript\" defer>");
            out.println("alert('Inquiry has been closed');");
            out.println("window.location.href = './Customer/customer-inquiry.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Inquiry cannot be closed');");
            out.println("window.location.href = './Customer/customer-inquiry.jsp';");
            out.println("</script>");
        }
    }

}
