<%-- 
    Document   : customer-ticket
    Created on : 10 May 2022, 9:26:46 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>
<%@page import="dao.OrderDAO"%>
<%@page import="dao.FoodDAO"%>
<%@page import="dao.SeatDAO"%>
<%@page import="dao.PaymentDAO"%>
<%@page import="dao.TicketDAO"%>
<%@page import="dao.MovieDAO"%>
<%@page import="model.Order"%>
<%@page import="model.Seat"%>
<%@page import="model.Payment"%>
<%@page import="model.Customer"%>
<%@page import="model.Ticket"%>
<%@page import="model.Movie"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.Serializable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="bootstrap.jsp"/>
<jsp:include page="customer-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Tickets</title>
    <style>
            .modal-container {
                display: flex;
                justify-content: space-around;
            }
            
            body {
                background-color: black;
            }
            
            .card-body {
                background-color: #222131;
                border: none;
                padding: 2.5em;
            }
            .card-header, .modal-header {
                background-color: #571B7E;
                color: white;
            }
            
            .card-header {
                text-align: center;
                font-size: 1.5em;
            }
            
            th {
                font-size: 16px;
            }
            
            .modal-body input {
                width: 100%;
            }
            
            .no-register td {
                color: black;
                background-color: #FDFDFE;
                text-align: center;
            }
            
            #nav_ticket {
                background: #CF9FFF;
                color: #000;
                font-weight: bold;
                border-radius: 10%;
                height: 100%;
            }
            
            .flex-body {
                display: flex;
                justify-content: center;
                align-items: center;
            }
            
            .card-container {
                width: 1150px;
            }
            
            .flex-end {
                display: flex;
                justify-content: space-between;
            }
            
            @media (max-width: 800px) {
                .card-container {
                  width: 400px;
                }
                
                #nav_ticket {
                    border-radius: 0%;
                }
            }
        </style>
    </head>
    <body>
    <div class='flex-body'>
      <div class="card-container mt-5">        
        <%
            List<Ticket> ticketList = new ArrayList<>();
            
            //Get current customer
            Customer customer = (Customer) request.getSession().getAttribute("customer");
            
            //Get ticket list from table ticket
            //Parameter : current customer's ID
            ticketList = TicketDAO.findAllTicketByCustID(customer.getCustID());
            
            for(int i = 0; i < ticketList.size(); i++) {
                out.print("<form action='../TicketController' method='POST' id='my_form" + (i + 1) + "'></form>");
            }
        %>
                <div class="card-body">
                    <h5 class="card-header">Ticket List</h5>
                        <table class="table table-striped table-dark">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">NO</th>
                                    <th scope="col">TICKET ID</th>
                                    <th scope="col">MOVIE ID</th>
                                    <th scope="col">DATE</th>
                                    <th scope="col">TIME</th>
                                    <th scope="col" style="text-align: center;">ACTION</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(ticketList.size() > 0) {
                                        for(int i = 0; i < ticketList.size(); i++) {
                                            out.print("<tr>");
                                            out.print("<td>");
                                            out.print("<scope='row'>" + (i + 1) + "</td>");
                                            out.print("</td>"); 
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='custID' form='my_form" + (i+1) + "' value='" + customer.getCustID() + "'/>");
                                            out.print("<input type='hidden' name='ticketID' form='my_form" + (i+1) + "' value='" + ticketList.get(i).getTicketID()+ "'/>");
                                            out.print(ticketList.get(i).getTicketID());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='movieID' form='my_form" + (i+1) + "' value='" + ticketList.get(i).getMovieID()+ "'/>");
                                            out.print(ticketList.get(i).getMovieID());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='date' form='my_form" + (i+1) + "' value='" + ticketList.get(i).getTicketDate()+ "'/>");
                                            out.print(ticketList.get(i).getTicketDate());
                                            out.print("</td>");
                                            out.print("<td>");
                                            
                                            //Generate time in 12H format
                                            String timePc = ticketList.get(i).getTicketTime();
                                            int hourOfDay = Integer.parseInt(timePc.substring(0, 2));
                                            int minute = Integer.parseInt(timePc.substring(timePc.length() - 2));
                                            String currentTime = 
                                            (((hourOfDay % 12 == 0) ? "12" : ((hourOfDay % 12) > 9 ? 
                                            (hourOfDay % 12) : "0" + (hourOfDay % 12))) + ":"
                                            + ((minute > 9) ? minute : ("0" + minute)) + " "
                                            + ((hourOfDay >= 12) ? "PM" : "AM"));
                                            //End generating time in 12H format
                                            
                                            out.print("<input type='hidden' name='time' form='my_form" + (i+1) + "' value='" + ticketList.get(i).getTicketTime()+ "'/>");
                                            out.print(currentTime);
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<div class='modal-container'>");
                                            out.print("<button type='button'  class='btn btn-info btn-sm btn-flex' data-toggle='modal' data-target='#exampleModal" + (i+1) +"'><b>Details</b></button>");
                                            out.print("<button type='submit' name='action' value='deleteFromCustomer' form='my_form" + (i+1) + "' class='btn btn-danger btn-sm btn-flex'><b>Cancel</b></button>");
                                            out.print("</div>");
                                            out.print("</td>");
                                            out.print("</tr>");
                                        }
                                    } else {
                                       out.print("<tr class='no-register'><td colspan='6'>No registered tickets</td></tr>");
                                    }
                                    
                                %>                                 
                            </tbody>
                       </table>    
                 </div>
            </div>      
        </div>
        <!--Modal Box-->
            <%
                int x = 0;
                for(int i = 0; i < ticketList.size(); i++) {
                    out.print("<div class='modal fade' id='exampleModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel" + (i+1) +"' aria-hidden='true'>");
                    out.print("<div class='modal-dialog' role='document'>");
                    out.print("<div class='modal-content'>");
                    out.print("<div class='modal-header'>");
                    out.print("<h5 class='modal-title' id='exampleModalLabel" + (i+1) +"'>Ticket Details</h5>");
                    out.print("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                    out.print("<span aria-hidden='true'>&times;</span>");
                    out.print("</button>");
                    out.print("</div>");
                    out.print("<div class='modal-body'>");
                    
                    //Get payment info of current ticket
                    //Parameter = current ticket's id
                    Payment payment = PaymentDAO.findPaymentByID(ticketList.get(i).getTicketID());
                    
                    out.print("<label><b>Total Amount</b></label>");
                    out.print("<input type='text' disabled placeholder='RM " + payment.getPaymentAmount() + "'><br>");
                    
                    //Find list of seat of current ticket
                    List<Seat> seatList = SeatDAO.findSeatByTicketID(ticketList.get(i).getTicketID());
                    
                    //Check hall id of current ticket
                    String str = seatList.get(x).getHall_ID().equals("A")? "Standard" : seatList.get(x).getHall_ID().equals("B")?
                                 "Deluxe" : "Platinum";
                    
                    //Print seats
                    out.print("<br><label><b>Seats (Hall "+ seatList.get(x).getHall_ID() + " - " + str + ")</b></label><ul>");
                    for(int k = 0; k < seatList.size(); k++) {
                        out.print("<li>");
                        out.print(seatList.get(k).getSeatID());
                        out.print("</li>");
                    }
                    
                    List<Order> orderList = OrderDAO.findAllFoodOrderFromTicketID(ticketList.get(i).getTicketID());
                    
                    //Print food orders
                    out.print("</ul><label><b>Foods And Beverages</b></label><ul>");
                    for(int k = 0; k < orderList.size(); k++) {
                        out.print("<li><div class='flex-end'><span>");
                        out.print(orderList.get(k).getFoodDetails()+ "</span><span>(");
                        out.print(orderList.get(k).getFoodQuantity()+ ") ");
                        out.print("RM" + (orderList.get(k).getPricePerFood() * orderList.get(k).getFoodQuantity()) + "</span></div> ");
                        out.print("</li>");
                    }
                    out.print("</ul></div>");
                    out.print("<div class='modal-footer" + "'>");
                    out.print("<button type='button' class='btn btn-info' data-dismiss='modal'>Close</button>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                }
            %>
    </body>
</html>
