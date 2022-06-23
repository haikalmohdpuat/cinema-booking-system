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
import dao.OrderDAO;
import dao.PaymentDAO;
import dao.SeatDAO;
import dao.TicketDAO;
import database.MySQL;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;
import model.Hall;
import model.Movie;
import model.Order;
import model.Payment;
import model.Seat;
import model.Ticket;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class BookingController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "createForm":
                    createBooking(request, response);
                    break;

                case "submitForm":
                    submitBooking(request, response);
                    break;

                case "chooseSeat":
                    seatBooking(request, response);
                    break;

                case "editSeat":
                    editSeat(request, response);
                    break;

                case "chooseFood":
                    foodBooking(request, response);
                    break;

                case "Pay":
                    payBooking(request, response);
                    break;

                case "cancel":
                    cancelBooking(request, response);
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/index.html");
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
            Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(BookingController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void createBooking(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

        Connection connection = MySQL.getConnection();

        String id = request.getParameter("movieCode");

        String querySelectMovie = "SELECT * FROM movie where movieID = '" + id + "'";
        PreparedStatement statement = connection.prepareStatement(querySelectMovie);
        ResultSet rs = statement.executeQuery();

        if (rs.next()) {
            Movie movie = new Movie(
                    rs.getString(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getString(6),
                    rs.getInt(7),
                    rs.getDouble(8)
            );

            request.getSession().setAttribute("movie", movie);
            response.sendRedirect("./Customer/customer-booking-form.jsp");
        }
    }

    private void submitBooking(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

        String ticketID = request.getParameter("ticketID");
        String movieID = request.getParameter("movieCode");
        String custID = request.getParameter("custID");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String type = request.getParameter("seat");
        String hallID = request.getParameter("hall");

        Hall hall = new Hall(hallID);
        Ticket ticket = new Ticket(ticketID, movieID, custID, date, time, type);

        request.getSession().setAttribute("ticket", ticket);
        request.getSession().setAttribute("hall", hall);
        response.sendRedirect("./Customer/customer-seating-form.jsp");
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect("./Customer/homepage.jsp");
    }

    private void seatBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        Hall hall = (Hall) request.getSession().getAttribute("hall");
        Ticket ticket = (Ticket) request.getSession().getAttribute("ticket");

        String seats = request.getParameter("seats");
        String[] seatsArray = seats.split(",");
        List<Seat> seatList = new ArrayList<>();

        int i = 0;

        while (i < seatsArray.length) {
            Seat seat = new Seat(seatsArray[i], ticket.getTicketID(), hall.getHallID());
            seatList.add(seat);
            i++;
        }

        if (seatsArray[0].isEmpty() || seats.equals("")) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('You need to choose at least 1 seat');");
            out.println("location=history.back(-2);");
            out.println("</script>");
        } else {
            request.getSession().setAttribute("seatList", seatList);
            response.sendRedirect("./Customer/customer-beverages-form.jsp");
        }
    }

    private void foodBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String price = request.getParameter("itemPrice");
        String description = request.getParameter("itemDetails");
        int totalFoodPrice = 0;
        List<Order> orderList = new ArrayList<>();

        if (!description.equals("")) {
            String total = request.getParameter("totalPrice").replaceAll("RM", "");
            totalFoodPrice = Integer.parseInt(total);
            String[] priceArray = price.split(",");

            for (int j = 0; j < priceArray.length; j++) {
                priceArray[j] = priceArray[j].replaceAll("RM", "");
            }

            String[] descriptionArray = description.split(",");
            int[] quantity = new int[descriptionArray.length];
            int[] pricePerItem = new int[descriptionArray.length];
            int i = 0;

            for (int j = 0; j < pricePerItem.length; j++) {
                pricePerItem[j] = Integer.parseInt(priceArray[j]);
            }

            int x = quantity.length;
            int j = 0;

            for (int k = 0; k < x; k++) {
                if (request.getParameter("quantity" + k) != null) {
                    quantity[j] = Integer.parseInt(request.getParameter("quantity" + k));
                    j++;
                } else {
                    x++;
                }
            }

            while (i < descriptionArray.length) {
                Order order = new Order(descriptionArray[i], quantity[i], pricePerItem[i]);
                orderList.add(order);
                i++;
            }
            request.getSession().setAttribute("orderList", orderList);
        } else {
            Order order = new Order("", 0, 0);
            orderList.add(order);
            request.getSession().setAttribute("orderList", orderList);
        }
        request.getSession().setAttribute("totalFoodPrice", totalFoodPrice);
        response.sendRedirect("./Customer/customer-payment-form.jsp");
    }

    private void payBooking(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();

        List<Seat> seatList = (List<Seat>) request.getSession().getAttribute("seatList");
        List<Order> orderList = (List<Order>) request.getSession().getAttribute("orderList");
        Hall hall = (Hall) request.getSession().getAttribute("hall");
        Customer customer = (Customer) request.getSession().getAttribute("customer");
        Ticket ticket = (Ticket) request.getSession().getAttribute("ticket");

        int balance = Integer.parseInt(request.getParameter("balance"));
        int total = Integer.parseInt(request.getParameter("total"));

        if (balance > 0) {
            int ticketStatus = TicketDAO.add(ticket);
            int seatStatus = -1;
            int orderStatus = -1;
            int updateBalanceStatus = -1;
            int paymentStatus = -1;
            Payment payment = new Payment(customer.getCustID(), ticket.getTicketID(), "Ticket Payment", total, customer.getCustBalance() - total);
            updateBalanceStatus = CustomerDAO.updateBalance(customer.getCustID(), balance);
            paymentStatus = PaymentDAO.add(payment);

            for (int i = 0; i < seatList.size(); i++) {
                seatStatus = SeatDAO.add(seatList.get(i).getSeatID(), ticket.getTicketID(), hall.getHallID());
                if (seatStatus < 0) {
                    break;
                }
            }

            for (int i = 0; i < orderList.size(); i++) {
                orderStatus = OrderDAO.add(ticket.getTicketID(), orderList.get(i).getFoodDetails(),
                        orderList.get(i).getFoodQuantity(), (int) orderList.get(i).getPricePerFood());
                if (orderStatus < 0) {
                    break;
                }
            }

            if (ticketStatus < 0) {
                writer.println("<script type=\"text/javascript\" defer>");
                writer.println("alert('Ticket registration failed. Ticket will be cancelled');");
                writer.println("window.location.href = './Customer/customer-ticket.jsp';");
                writer.println("</script>");
            } else if (seatStatus < 0) {
                writer.println("<script type=\"text/javascript\" defer>");
                writer.println("alert('Seat registration failed. Ticket will be cancelled');");
                writer.println("window.location.href = './Customer/customer-ticket.jsp';");
                writer.println("</script>");
            } else if (updateBalanceStatus < 0) {
                writer.println("<script type=\"text/javascript\" defer>");
                writer.println("alert('Failure in updating balance. Ticket will be cancelled');");
                writer.println("window.location.href = './Customer/customer-ticket.jsp';");
                writer.println("</script>");
            } else if (paymentStatus < 0) {
                writer.println("<script type=\"text/javascript\" defer>");
                writer.println("alert('Failure in updating payment information. Ticket will be cancelled');");
                writer.println("window.location.href = './Customer/customer-ticket.jsp';");
                writer.println("</script>");
            } else {
                customer.setCustBalance(balance);
                writer.println("<script type=\"text/javascript\" defer>");
                writer.println("alert('Ticket record is successfully saved');");
                writer.println("window.location.href = './Customer/customer-ticket.jsp';");
                writer.println("</script>");
            }
        } else {
            writer.println("<script type=\"text/javascript\">");
            writer.println("alert('Insufficient Balance. Ticket will be cancelled');");
            writer.println("window.location.href = './Customer/customer-ticket.jsp';");
            writer.println("</script>");
        }
    }

    private void editSeat(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        String hallID = request.getParameter("hallID");
        String ticketID = request.getParameter("ticketID");

        String newSeats = request.getParameter("seats");
        String oldSeats = request.getParameter("oldSeats");
        String[] newSeatsArray = newSeats.split(",");
        String[] oldSeatsArray = oldSeats.split(",");
        List<Seat> seatList = new ArrayList<>();
        List<Seat> oldSeatList = new ArrayList<>();

        if (newSeatsArray[0].isEmpty() || newSeats.equals("")) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('You did not choose any seat. No seat will be updated');");
            out.println("window.location.href = './Admin/admin-ticket.jsp';");
            out.println("</script>");
        } else {
            int i = 0;

            while (i < newSeatsArray.length) {
                Seat seat = new Seat(newSeatsArray[i], ticketID, hallID);
                seatList.add(seat);
                i++;
            }

            i = 0;

            while (i < oldSeatsArray.length) {
                Seat seat = new Seat(oldSeatsArray[i], ticketID, hallID);
                oldSeatList.add(seat);
                i++;
            }

            int status = 0;

            for (int k = 0; k < seatList.size(); k++) {
                status = SeatDAO.update(seatList.get(k).getSeatID(), oldSeatList.get(k).getSeatID(), ticketID);
                if (status < 1) {
                    break;
                }
            }

            if (status > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Successful update of new seat selection');");
                out.println("window.location.href = './Admin/admin-ticket.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error in updating new seat selection');");
                out.println("window.location.href = './Admin/admin-ticket.jsp';");
                out.println("</script>");
            }
        }

    }
}
