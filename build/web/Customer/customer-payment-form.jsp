<%-- 
    Document   : payment
    Created on : 7 May 2022, 2:25:51 am
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="model.Ticket"%>
<%@page import="model.Movie"%>
<%@page import="model.Customer"%>
<%@page import="model.Hall"%>
<%@page import="model.Seat"%>
<%@page import="java.util.List"%>
<%@page import="model.Order"%>
<%@page import="java.io.Serializable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="customer-navbar.jsp"/>
<jsp:include page="progress-bar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Confirmation Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                color: white;
            }
            
            body {
                background: black;
            }
            
            .center {
                display: flex;
                justify-content: center;
            }
            
            .hall-id {
                font-weight: bold;
                font-size:3rem;
            }
            
            .movie-name {
                font-size: 1.5em;
                margin-top: -1em;
            }
            
            .box {
                background: #571B7E;
                height: 7rem;
                margin-top: 2rem;
            }
            
            .center .date {
                margin-top: 2.5rem;
            }
            
            .container-details{
                margin-top: 2rem;
                margin-left: 1.5rem;
                width: 40%;
            }
            
            .container-details .card{
                width: auto;
                background-color: #222131;
                border: none; 
            }
                        
            .container-details:first-child, .container-details:nth-child(2) {
                margin-bottom: 2em;
            }
           
            .input-group-prepend {
                width : 15%; 
            }

            .input-group-prepend label {
                width: 100%;
                overflow: hidden;
            }
            
            .flex-group {
                display: flex;
                flex-direction: row-reverse;
                justify-content: space-around;
                flex-wrap: wrap; 
            }
            
            .flex-body-column {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }
            
            .card:nth-child(2) {
                margin-top: 2rem;
            }
            
            .card-title:after {
                content: "";
                background: #BF40BF;
                width: 80px;
                height: 5px;
                border-radius: 5px;
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
            }
            
            .card-2 {
                font-size: 1.1rem;
            }
            
            .card-body .sub-title{
                font-weight: bold;
            }
            
            .flex-end {
                display: flex;
                justify-content: space-between;
            }
            
            .separator-box {
                height: 1em;
                background: #BF40BF;
            }
            
            li span{
                float: right;
            }
            
            .payment-box {
                margin-top: 1rem;
                height: auto;
                padding: 7px;
                font-size: 1.2rem;
                border-left: 5px solid #BF40BF;
            }
            
            .payment-box:nth-child(2), .payment-box:nth-child(3){
                margin-top: 1.55rem;
            }
            
            .success-status-box {
                border-left: 5px solid #0FFF50;
            }
            
            .danger-status-box {
                border-left: 5px solid #D0342C;
            }

            .col-12 .btn {
                background: #BF40BF;
                width: 100%;
                height: 3rem;
                font-size: 1.5rem;
                text-align: center;
                font-weight: bold;
                color: white;
            }
            
            .btn:hover{
                background: #702963;
            }
            
            input[type="hidden"] {
                display: none;
            }
            
            @media only screen and (max-width: 1062px) {
                .container-details{
                    margin-top: 2rem;
                    margin-left: 1.5rem;
                    width: 100%;
                }
                
                .date h3{
                    font-size: 1.5em;
                }
            }
        </style>
    </head>
    <body>
        <%
            List<Seat> seatList = (List<Seat>) request.getSession().getAttribute("seatList");
            List<Order> orderList = (List<Order>) request.getSession().getAttribute("orderList");
            Hall hall = (Hall) request.getSession().getAttribute("hall");
            Customer customer = (Customer) request.getSession().getAttribute("customer");
            Movie movie = (Movie) request.getSession().getAttribute("movie");
            Ticket ticket = (Ticket) request.getSession().getAttribute("ticket");
            int totalFoodPrice = (int) request.getSession().getAttribute("totalFoodPrice");
            Date today = Calendar.getInstance().getTime();
            int foodSize = orderList.get(0).getFoodQuantity() == 0? 0 : orderList.size();
            
            String hallName = hall.getHallID().equals("A")? "Standard": hall.getHallID().equals("B")? "Deluxe":"Platinum";
            
            //Generate time in 12H format
            String timePc = movie.getMovieTime();
            int hourOfDay = Integer.parseInt(timePc.substring(0, 2));
            int minute = Integer.parseInt(timePc.substring(timePc.length() - 2));
            String currentTime = 
            (((hourOfDay % 12 == 0) ? "12" : ((hourOfDay % 12) > 9 ? 
            (hourOfDay % 12) : "0" + (hourOfDay % 12))) + ":"
            + ((minute > 9) ? minute : ("0" + minute)) + " "
            + ((hourOfDay >= 12) ? "PM" : "AM"));
            //End generating time in 12H format
        %>
          <div class="rings mt-3">
            <div class="container-step">
                <div class="text">Details</div>
                <div class="completed"><i class="fa-solid fa-check"></i></div>
            </div>
            <span class="connector">></span>
            <div class="container-step">
                <div class="text">Seating</div>
                <div class="completed"><i class="fa-solid fa-check"></i></div>
            </div>
            <span class="connector">></span>
            <div class="container-step">
                <div class="text">Beverages</div>
                <div class="completed"><i class="fa-solid fa-check"></i></div>
            </div>
            <span class="connector">></span>
            <div class="container-step">
                <div class="text" style="color: #C38EC7">Payment</div>
                <div class="current"></div>
            </div>
          </div>
          <div class="box center">
              <div class="date">
                  <h3>HALL <%=hall.getHallID()%> <span>|</span> 
                      <%=movie.getMovieName()%> <span>|</span> 
                      <%=ticket.getTicketDate()%> <%=currentTime%>
                  </h3>
              </div>
          </div>
          <form action="../BookingController" method="POST">
              <div class="flex-group">                
                <div class="container-details">
                    <div class="card card-2">
                      <div class="card-body">
                        <h5 class="card-title text-center">Booking Summary</h5>
                        <p class="sub-title">Venue</p>
                        <p>Hall ${hall.getHallID()} - <%=hallName%></p>
                        <p class="sub-title">Time</p>
                        <p><%=ticket.getTicketDate()%>  <%=currentTime%> </p>
                        <p class="sub-title">Movie</p>
                        <input type="hidden" name="movieName" value="<%=movie.getMovieName()%>"/>
                        <p><%=movie.getMovieName()%></p>
                        <p class="sub-title flex-end"><span>Seats</span><span><%=seatList.size()%></span></p>
                        <p>
                            <%
                                out.print("<ul>");
                                for(int i = 0; i < seatList.size(); i++) {
                                    out.print("<li>");
                                    out.print(seatList.get(i).getSeatID());
                                    out.print("</li>");
                                }
                                out.print("</ul>");
                            %>
                        </p>
                        <p class="sub-title flex-end"><span>Food</span><span><%=foodSize%></span></p>
                        <p>
                            <%
                                out.print("<ul>");
                                if(foodSize != 0) {
                                    for(int i = 0; i < orderList.size(); i++) {
                                        out.print("<li>");
                                        out.print(orderList.get(i).getFoodDetails()+ " x ");
                                        out.print(orderList.get(i).getFoodQuantity()+ "       ");
                                        out.print("<span>RM " + (orderList.get(i).getPricePerFood() * orderList.get(i).getFoodQuantity()) + "</span>");                            
                                        out.print("</li>");
                                    }
                                }
                                out.print("</ul>");

                                int totalTicketPrice =  seatList.size() * (int) movie.getMoviePrice();
                                int extraCharge = hall.getHallID().equals("A")? 0 : hall.getHallID().equals("B")? 10 : 20;
                                int totalPrice = totalFoodPrice + totalTicketPrice + extraCharge;
                                int balanceAfterPayment = customer.getCustBalance() - totalPrice;
                            %>
                        </p>
                        <div class="separator-box"></div>
                        <br>
                        <input type="hidden" name="total" value="<%=totalPrice%>"/>
                        <input type="hidden" name="balance" value="<%=balanceAfterPayment%>"/>
                        <p class="sub-title">Total Price</p>
                        <p class="flex-end"><span>Food</span><span>RM<%=totalFoodPrice%></span></p>
                        <p class="flex-end"><span>Seats</span><span>RM<%=totalTicketPrice%></span></p>
                        <p class="flex-end"><span>Extra (<%=hallName%> Hall)</span><span>RM<%=extraCharge%></span></p>
                        <p class="sub-title flex-end"><span>GRAND TOTAL</span><span>RM<%=totalPrice%></span></p>
                    </div>
                 </div>
              </div>
              <div class="container-details flex-body-column">
                  <div class="card">
                       <div class="card-body">
                           <h5 class="card-title text-center mb-3">Customer Details</h5>
                               <div class="input-group mb-3">
                                 <div class="input-group-prepend">
                                     <label class="input-group-text text-light bg-dark" for="name">Name</label>
                                 </div>
                                 <input type="text" class="form-control" id="name" name="name" readonly placeholder="<%=customer.getCustName()%>">
                               </div>
                               <div class="input-group mb-3">
                                  <div class="input-group-prepend">
                                     <label class="input-group-text text-light bg-dark" for="email">Email</label>
                                  </div>
                                  <input type="email" class="form-control" id="email" name="email" readonly placeholder="<%=customer.getCustEmail()%>">
                               </div>
                               <div class="input-group mb-3">
                                  <div class="input-group-prepend">
                                     <label class="input-group-text text-light bg-dark" for="phone">Tel</label>
                                  </div>
                                  <input type="tel" class="form-control" id="phone" name="phone" readonly placeholder="<%=customer.getCustMobileNumber()%>">
                               </div>
                       </div>
                 </div>
                 <div class="card">
                      <div class="card-body">
                           <h5 class="card-title text-center mb-3">Payment Details</h5>
                           <div class="payment-box">
                                <p class="flex-end"><span>BALANCE</span><span>Est by <%=today%></span></p>
                                <h2>RM<%=customer.getCustBalance()%>.00</h2>
                           </div>
                           <div class="payment-box">
                                <p>BALANCE AFTER PAYMENT</p>
                                <h2>RM<%=balanceAfterPayment%>.00</h2>
                           </div>
                           <%if(balanceAfterPayment > 0){%>
                           <div class="payment-box success-status-box">
                                <p>STATUS</p>
                                <h2>Sufficient Balance</h2>
                           </div>
                           <%}else{%>
                           <div class="payment-box danger-status-box">
                                <p>STATUS</p>
                                <h2>Insufficient Balance</h2>
                           </div>
                           <%}%>
                      </div>
                  </div>
                </div>
            </div>
            <div class="col-12">
                <input type="submit" value="Pay" name="action" class="btn payment mb-3">
            </div>
          </form>         
    </body>
</html>
