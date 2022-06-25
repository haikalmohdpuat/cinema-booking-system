<%-- 
    Document   : admin-ticket
    Created on : 24 May 2022, 2:10:19 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="model.Admin"%>
<%@page import="dao.OrderDAO"%>
<%@page import="model.Order"%>
<%@page import="dao.FoodDAO"%>
<%@page import="model.Seat"%>
<%@page import="dao.SeatDAO"%>
<%@page import="model.Payment"%>
<%@page import="dao.PaymentDAO"%>
<%@page import="model.Customer"%>
<%@page import="model.Ticket"%>
<%@page import="dao.TicketDAO"%>
<%@page import="dao.MovieDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Movie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.Serializable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Manage Ticket</title>
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
            
            .card-container, table {
                width: 100%;
            }
            
            .card-container {
                margin-top: -32px;
            }
            
            .flex-end {
                display: flex;
                justify-content: space-between;
            }
            
            .btn-edit-modal {
                font-size: 1em;
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
    <body id="homepage">
        <%
            Admin admin = (Admin) request.getSession().getAttribute("admin");
        %>
        <div class="wrapper">
            <!-- Sidebar -->
            <nav id="sidebar">
                <div class="sidebar-header" style="background: #571B7E;"><h3>Cinema Booking System</h3><strong>CB</strong></div>
                <ul class="list-unstyled components">
                    <li><a href="admin-homepage.jsp"><i class="fa-solid fa-house"></i><span class="ml-2">Home</span></a></li>
                    <li><a href="admin-movie.jsp"><i class="fa-solid fa-film"></i><span class="ml-2">Movie</span></a></li>
                    <li class="active"><a href="#"><i class="fa-solid fa-ticket"></i><span class="ml-2">Tickets</span></a></li>
                    <li><a href="admin-inquiry.jsp"><i class="fa-solid fa-question"></i><span class="ml-3">Inquiry</span></a></li>
                    <li><a href="admin-statistics.jsp"><i class="fa-solid fa-chart-column"></i><span class="ml-2">Statistic</span></a></li>
                </ul>
            </nav>
            <!-- Page Content  -->
            <div id="content">
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                    <div class="container-fluid">
                        <button type="button" id="sidebarCollapse" class="btn btn-dark">
                            <i class="fas fa-align-left"></i>
                        </button>
                        <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <i class="fas fa-align-justify"></i>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="nav navbar-nav ml-auto">
                                <li class="nav-item mr-3">
                                    <a class="nav-link">Hi!, <%=admin.getAdminName()%></a>
                                </li>
                                <li class="nav-item mr-3">
                                    <a class="nav-link" data-toggle="modal" data-target="#adminProfile"  href="#">Profile</a>
                                </li>
<!--                            <li class="nav-item"><a class="nav-link" href="#">Page</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Page</a></li>-->
                                <li class="nav-item"><a class="nav-link" href="../Customer/log-out.jsp">Log Out</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <div class='flex-body'>
                    <div class="card-container">        
                      <%
                          List<Ticket> ticketList = new ArrayList<>();
                          ticketList = TicketDAO.findAllTickets();

                          for(int i = 0; i < ticketList.size(); i++) {
                              out.print("<form action='../TicketController' method='POST' id='my_form" + (i + 1) + "'></form>");
                          }

                          for(int i = 0; i < ticketList.size(); i++) {
                              out.print("<form action='admin-edit-seat.jsp' id='edit_seat_form" + (i+1) + "' method='POST'>");
                          }
                      %>
                    <div class="card-body">
                        <h5 class="card-header">Ticket List</h5>
                            <table class="table table-striped table-dark">
                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col">NO</th>
                                        <th scope="col">CUST ID</th>
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
                                                out.print("<input type='hidden' name='custID' form='my_form" + (i+1) + "' value='" + ticketList.get(i).getCustID()+ "'/>");
                                                out.print(ticketList.get(i).getCustID());
                                                out.print("</td>");
                                                out.print("<td>");
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
                                                
                                                out.print("<td>");
                                                out.print("<input type='hidden' name='time' form='my_form" + (i+1) + "' value='" + ticketList.get(i).getTicketTime()+ "'/>");
                                                out.print(currentTime);
                                                out.print("</td>");
                                                out.print("<td>");
                                                out.print("<div class='modal-container'>");
                                                out.print("<button type='button' title='Edit' class='btn btn-info btn-flex' data-toggle='modal' data-target='#exampleModal" + (i+1) +"'><b><i class='fa-solid fa-pen-to-square'></i></b></button>");
                                                out.print("<button type='submit' title='Delete' name='action' value='deleteFromAdmin' form='my_form" + (i+1) + "' class='btn btn-danger btn-flex'><b><i class='fa-solid fa-trash'></b></button>");
                                                out.print("</div>");
                                                out.print("</td>");
                                                out.print("</tr>");
                                            }
                                        } else {
                                           out.print("<tr class='no-register'><td colspan='7'>No registered tickets</td></tr>");
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
                int s = 0;
                Movie movie = null;
                        
                for(int i = 0; i < ticketList.size(); i++) {
                    out.print("<div  class='modal fade' id='exampleModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel" + (i+1) +"' aria-hidden='true'>");
                    out.print("<div class='modal-dialog' role='document'>");
                    out.print("<div class='modal-content'>");
                    out.print("<div class='modal-header'>");
                    out.print("<h5 class='modal-title' id='exampleModalLabel" + (i+1) +"'>Ticket Details</h5>");
                    out.print("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                    out.print("<span aria-hidden='true'>&times;</span>");
                    out.print("</button>");
                    out.print("</div>");
                    out.print("<form action='admin-edit-seat.jsp' id='edit_seat_form" + (i+1) + "' method='POST'>");
                    out.print("<div class='modal-body'>");
                    
                    Payment payment = PaymentDAO.findPaymentByID(ticketList.get(i).getTicketID());
                    
                    out.print("<label><b>Total Amount</b></label>");
                    out.print("<input type='text' disabled placeholder='RM " + payment.getPaymentAmount() + "'><br>");
                    
                    List<Seat> seatList = SeatDAO.findSeatByTicketID(ticketList.get(i).getTicketID());
                    String str = seatList.get(x).getHall_ID().equals("A")? "Standard" : seatList.get(x).getHall_ID().equals("B")?
                                 "Deluxe" : "Platinum";
                    movie = MovieDAO.findMovieByMovieID(ticketList.get(i).getMovieID());
                            
                    out.print("<input type='hidden' name='movieLanguage' form='edit_seat_form" + (i+1) + "' value='" + movie.getMovieLanguage()+ "'/>");
                    out.print("<input type='hidden' name='movieDuration' form='edit_seat_form" + (i+1) + "' value='" + movie.getMovieDuration()+ "'/>");
                    out.print("<input type='hidden' name='movieName' form='edit_seat_form" + (i+1) + "' value='" + movie.getMovieName()+ "'/>");
                    out.print("<input type='hidden' name='custID' form='edit_seat_form" + (i+1) + "' value='" + ticketList.get(i).getCustID()+ "'/>");
                    out.print("<input type='hidden' name='ticketID' form='edit_seat_form" + (i+1) + "' value='" + ticketList.get(i).getTicketID()+ "'/>");
                    out.print("<input type='hidden' name='ticketType' form='edit_seat_form" + (i+1) + "' value='" + ticketList.get(i).getTicketType()+ "'/>");
                    out.print("<input type='hidden' name='hall' value='" + seatList.get(x).getHall_ID() + "'>");
                    out.print("<input type='hidden' name='time' value='" + ticketList.get(i).getTicketTime() + "'>");
                    out.print("<input type='hidden' name='date' value='" + ticketList.get(i).getTicketDate() + "'>");
                    out.print("<br><label><b>Seats (Hall "+ seatList.get(x).getHall_ID() + " - " + str + ")</b></label>");
                    out.print("<button type='submit' form='edit_seat_form" + (i+1) + "' class='btn btn-info btn-edit-modal ml-4'>Edit</button>");
                    out.print("<ul>");
                    for(s = 0; s < seatList.size(); s++) {
                        out.print("<li>");
                        out.print("<input type='hidden' name='seatID" + (s) + "' form='edit_seat_form" + (i+1) + "' value='" + seatList.get(s).getSeatID() + "'>");
                        out.print(seatList.get(s).getSeatID());
                        out.print("</li>");
                    }
                    
                    out.print("<input type='hidden' name='size' form='edit_seat_form" + (i+1) + "' value='" + s + "'>");
                    s = 0;
                    
                    List<Order> orderList = OrderDAO.findAllFoodOrderFromTicketID(ticketList.get(i).getTicketID());
                    
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
                    out.print("<button type='button' class='btn btn-danger' data-dismiss='modal'>Close</button>");
                    out.print("</div>");
                    out.print("</form>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                }
            %>
            </div>
        </div>
    </body>
</html>
