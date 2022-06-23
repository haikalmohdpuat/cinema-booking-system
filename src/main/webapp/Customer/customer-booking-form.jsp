<%-- 
    Document   : customer-booking-form
    Created on : 30 Apr 2022, 11:47:48 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="java.util.concurrent.ThreadLocalRandom"%>
<%@page import="dao.TicketDAO"%>
<%@page import="model.Ticket"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Customer"%>
<%@page import="model.Movie"%>
<%@page import="java.io.Serializable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="customer-navbar.jsp"/>
<jsp:include page="progress-bar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Form</title>
        <style>          
            .card {
              min-width: 550px;
              background-color: #222131;
              outline: 5px solid #C38EC7;
              border: none;
              border-radius: 12px
            }
                       
            .card-title, h1, label, h6 {
                color: white;
            }
            
            input[readonly] {
                background-color: red;
            }
                 
            .flex-body {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
            }
            
            .input-group-prepend {
                width : 18%; /*adjust as needed*/
            }

            .input-group-prepend label {
                width: 100%;
                overflow: hidden;
            }
            
            .btn {
                cursor: pointer;
               padding: 10px;
               background-color: #571B7E;
               color: white;
               font-weight: bold;
            }
            
            .btn:hover {
                background-color: #483248;
            }
            
            @media only screen and (max-width: 600px) {
                .card {
                    min-width: 0;
                  width: auto;
                }
            }
        </style>
    </head>
    <body>
        <%!
            public String generateString(int n) {
  
                // chose a Character random from this String
                String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                StringBuilder sb = new StringBuilder(n);
  
                for (int i = 0; i < n; i++) {

                    int index = (int)(AlphaNumericString.length()
                                * Math.random());  
                    // add Character one by one in end of sb
                    sb.append(AlphaNumericString.charAt(index));
                }
             return sb.toString();
            }
        %>
        <%
            Movie movie = (Movie) request.getSession().getAttribute("movie");
            Customer customer = (Customer) request.getSession().getAttribute("customer");
            
            //Generate ticketID            
            String ticketID = "";
            String str = "";
            String randomStr = generateString(3);
            int x = 0;
            int min = 100000;
            int max = 999990;
            int status = 0;
            int randomNum = ThreadLocalRandom.current().nextInt(min, max + 1);
            for(int i = 0; i < 10000; i++) {
                x = randomNum;
                str = "TIC-" + x + "-" + randomStr;
                status = TicketDAO.findTicketIDByString(str);
                if(status == 0) {                   
                    ticketID = str;
                    break;
                }
            }           
            //End generating ticketID
            
            //Generate time in 12H format
            String time = movie.getMovieTime();
            int hourOfDay = Integer.parseInt(time.substring(0, 2));
            int minute = Integer.parseInt(time.substring(time.length() - 2));
            String currentTime = 
            (((hourOfDay % 12 == 0) ? "12" : ((hourOfDay % 12) > 9 ? 
            (hourOfDay % 12) : "0" + (hourOfDay % 12))) + ":"
            + ((minute > 9) ? minute : ("0" + minute)) + " "
            + ((hourOfDay >= 12) ? "PM" : "AM"));
            //End generating time in 12H format
        %>
        <div class="rings mt-3">
            <div class="container-step">
                <div class="text"  style="color: #C38EC7">Details</div>
                <div class="current"></div>
            </div>
            <span class="connector" style="color: gray">></span>
            <div class="container-step">
                <div class="text" style="color: gray">Seating</div>
                <div class="next" style="color: gray"></div>
            </div>
            <span class="connector" style="color: gray">></span>
            <div class="container-step">
                <div class="text" style="color: gray">Beverages</div>
                <div class="next" style="color: gray"></div>
            </div>
            <span class="connector" style="color: gray">></span>
            <div class="container-step">
                <div class="text" style="color: gray">Payment</div>
                <div class="next"></div>
            </div>
        </div>
        <div class="flex-body">
            <form id="myForm" action="../BookingController" method="POST">
                <div class="container mt-5 mb-5 d-flex justify-content-center">
                    <div class="card px-1 py-4">
                        <div class="card-body">
                            <h6 class="card-title mb-3">Booking Ticket Form</h6>
                                <div class="text-center"><h1><%=movie.getMovieName()%></h1></div>
                                    <h6 class="information mt-4">Ticket Details</h6>
                                    <input type="hidden" name="movieCode" value="${movie.getMovieID()}"/>
                                    <input type="hidden" name="custID" value="${customer.getCustID()}"/>
                                    <input type="hidden" name="ticketID" value="<%=ticketID%>"/>
                                    <input type="hidden" name="date" value="<%=movie.getMovieDate()%>"/>
                                    <input type="hidden" name="time" value="<%=movie.getMovieTime()%>"/>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text text-dark" for="ticket">Ticket ID</label>
                                        </div>
                                        <input type="text" class="form-control" id="ticketID" name="ticket" readonly placeholder="<%=ticketID%>">
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text text-dark" for="name">Name</label>
                                        </div>
                                        <input type="text" class="form-control" id="name" name="name" readonly placeholder="<%=customer.getCustName()%>">
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text text-dark" for="email">Email</label>
                                        </div>
                                        <input type="email" class="form-control" id="email" name="email" readonly placeholder="<%=customer.getCustEmail()%>">
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text text-dark" for="tel">Tel</label>
                                        </div>
                                        <input type="tel" class="form-control" id="tel" name="tel" readonly placeholder="<%=customer.getCustMobileNumber()%>">
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text text-dark" for="inputDate">Date</label>
                                        </div>
                                        <input type="text" class="form-control" id="date" name="date" readonly placeholder="<%=movie.getMovieDate()%>">
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text text-dark" for="inputTime">Time</label>
                                        </div>
                                        <input type="text" class="form-control" id="time" name="time" readonly placeholder="<%=currentTime%>">
                                    </div>
                                    <h6 class="information mt-4">Fill in the details regarding the movie</h6>    
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text text-dark" for="inputSeat">Seat</label>
                                        </div>
                                        <select name="seat" class="custom-select" id="inputSeat">
                                            <option value="Single" selected="">Single</option>
                                            <option value="Couple">Couple</option>
                                            <option value="Family">Family</option>
                                        </select>
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <label class="input-group-text text-dark" for="inputHall">Hall</label>
                                        </div>
                                        <select name="hall" class="custom-select" id="inputHall">
                                            <option value="A" selected="">A - Standard</option>
                                            <option value="B">B - Deluxe</option>
                                            <option value="C">C - Platinum</option>
                                        </select>
                                    </div>    
                                <br />
                               <button class="btn btn-block confirm-button" name="action" value="submitForm">Submit</button>
                               <button class="btn btn-block confirm-button" name="action" value="cancel">Cancel</button>
                         </div>
                    </div>
                </div>
            </form>                                       
        </div>      
    </body>
</html>
