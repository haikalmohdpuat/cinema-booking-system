<%-- 
    Document   : customer-seating-form
    Created on : 2 May 2022, 11:12:25 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="dao.SeatDAO"%>
<%@page import="model.Seat"%>
<%@page import="dao.MovieDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Ticket"%>
<%@page import="model.Movie"%>
<%@page import="model.Hall"%>
<%@page import="java.io.Serializable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="customer-navbar.jsp"/>
<jsp:include page="progress-bar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <title>Seating Plan</title>
        <style>
            body {
                background: black;
            }
            .card {
                background: #222131;
            }
            
            .box{
                margin-top: 10px;
                width:auto; height:100px;  
                border:solid 5px #000;
                border-color:white transparent transparent transparent;
                border-radius: 70%/100px 100px 0 0;
            }
            
            .screen{
                text-align: center;
            }
            
            h1, h3, hr {
                color: white;
            }
            
            .circles {
                display: flex;
                justify-content: center;
            }

            .circle {
                margin: 20px;
            }

            .seat {
                background: #fff;
                color: black;
                height: 50px;
                width: 50px;
                border-radius: 50%;
                display: inline-block;
                text-align: center;
                border-color: grey;
                border-width: thin;
            }
            
            .seat:hover {
                color: #0F0;
            }

            .selected {
              background-color: #985AFE;
              color: #fff;
              font-weight: bold;
/*            background-color: #571B7E; blue*/
/*            color: #0F0; green*/
            }

            .reserved{
                background-color: gray;
                color: darkred;
            }

            .footer {
                display: flex;
                justify-content: space-between;
            }

            .dot-example {
                height: 30px;
                width: 30px;
                transform: translateY(20%);
                background-color: #985AFE;
                border-radius: 50%;
                display: inline-block;
            }
            
            .dot-example[name='reserved'] {
                background-color: gray;
            }
            
            .dot-example[name='available'] {
                background-color: #fff;
            }
            
            .dot-example[name='selected'] {
                background-color: #985AFE;
            }
            
            input[name='seats'] {
                display: none;
            }
           
            .btn[value='chooseSeat'], .btn[value='cancel'] {
               cursor: pointer;
               padding: 10px;
               background-color: #C38EC7;
               color: white;
               font-weight: bold;
            }
            
            .btn[value='cancel'] {
                background-color: #571B7E;
            }
            
            .btn[value='cancel']:hover, .btn[value='chooseSeat']:hover {
                background-color: #483248;
            }
        </style>
    </head>
    <body>
        <%
           Movie movie = (Movie) request.getSession().getAttribute("movie");
           Hall hall = (Hall) request.getSession().getAttribute("hall");
           Ticket ticket = (Ticket) request.getSession().getAttribute("ticket");
           
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
           
           String date = "" + movie.getMovieDate() + "";
           String time = "" + movie.getMovieTime() + "";
           
           String str = hall.getHallID().equals("A")? "A - Standard" : hall.getHallID().equals("B")? "B - Deluxe": "C - Platinum";
        %>
        <div class="rings mt-3">
            <div class="container-step">
                <div class="text">Details</div>
                <div class="completed"><i class="fa-solid fa-check"></i></div>
            </div>
            <span class="connector">></span>
            <div class="container-step">
                <div class="text" style="color: #C38EC7">Seating</div>
                <div class="current"></div>
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
        <form action="../BookingController" method="POST">
            <div class="container mt-5 mb-5 d-flex justify-content-center">
              <div class="card px-100 py-4 w-100">
                  <div class="card-body">
                    <div class="card px-1 py-4">
                      <h6 class="card-title mb-3"></h6>
                      <div class="text-center">
                          <h1><%=movie.getMovieName()%></h1>
                          <h3>P12 | <%=movie.getMovieLanguage()%> | <%=movie.getMovieDuration()%> HOURS</h3>
                          <hr>
                          <h1>Hall <%=str%></h1>
                          <h3><%=ticket.getTicketDate()%> <%=currentTime%> <%=ticket.getTicketType()%></h3>
                      </div>
                    </div>
                    <hr style="height: 5px;" />                   
<!--                <div class="card-body align-items-center text-center" style="outline: white 2px solid; color: white;">
                        SCREEN
                    </div>-->
                    <div class="box"></div>
                    <div class="screen" style="color: white; margin-top: -70px;"><b>SCREEN</b></div>
                        <br /><br />
                        <input id="seats" name="seats" value="">
                          <%
                              String[] arr = {"A", "B", "C"};
                              
                              if(hall.getHallID().equals("A")) {
                                    for(int i = 0; i < 3; i++) {
                                        out.println("<div class='circles'>");
                                        for(int j = 1; j <= 18; j++) {
                                            if(j == 1 || j == 7 || j == 13) {
                                                out.println("<div class='circle'>");
                                            }
                                            String seatID = "" + arr[i] + j;
                                            int status = SeatDAO.findSeatIDByDateAndTime(date, time, seatID, hall.getHallID());
                                            
                                            if(status == 1) {
                                                out.println("<input type='button' class='seat btn reserved' value='"+ arr[i] + j +"'>");
                                            } else {
                                                out.println("<input type='button' class='seat btn' value='"+ arr[i] + j +"'>");
                                            }
                                            
                                            if(j == 6 || j == 12 || j == 18) {
                                                out.println("</div>");
                                            }                                
                                        }
                                    out.println("</div>");
                                  }
                              } else if(hall.getHallID().equals("B")) {
                                    for(int i = 0; i < 3; i++) {
                                        out.println("<div class='circles'>");
                                        for(int j = 1; j <= 12; j++) {
                                            if(j == 1 || j == 3 || j == 5 || j == 7 || j == 9 || j == 11) {
                                                out.println("<div class='circle'>");
                                            }
                                            
                                            String seatID = "" + arr[i] + j;
                                            int status = SeatDAO.findSeatIDByDateAndTime(date, time, seatID, hall.getHallID());
                                            
                                            if(status == 1) {
                                                out.println("<input type='button' class='seat btn reserved' value='"+ arr[i] + j +"'>");
                                            } else {
                                                out.println("<input type='button' class='seat btn' value='"+ arr[i] + j +"'>");
                                            }
                                            
                                            if(j == 2 || j == 4 || j == 6 || j == 8 || j == 10 || j == 12) {
                                                out.println("</div>");
                                            }                                
                                        }
                                    out.println("</div>");
                                  }
                              } else {
                                    for(int i = 0; i < 3; i++) {
                                        out.println("<div class='circles'>");
                                        for(int j = 1; j <= 6; j++) {
                                            out.println("<div class='circle'>");
                                            
                                            String seatID = "" + arr[i] + j;
                                            int status = SeatDAO.findSeatIDByDateAndTime(date, time, seatID, hall.getHallID());
                                            
                                            if(status == 1) {
                                                out.println("<input type='button' class='seat btn reserved' value='"+ arr[i] + j +"'>");
                                            } else {
                                                out.println("<input type='button' class='seat btn' value='"+ arr[i] + j +"'>");
                                            }
                                            
                                            out.println("</div>");                               
                                        }
                                    out.println("</div>");
                                  }
                              }
                          %>
                        <div class="footer">
                          <div class="button-choice">
                            <button name="action" type="submit" value="chooseSeat" class="btn btn-block confirm-button">Confirm</button>
                            <button name="action" type="cancel" value="cancel"  class="btn btn-block confirm-button">Cancel</button>
                          </div>
                          <div class="legend">
                            <span style="color: white"><span class="dot-example" name="selected"></span> - Selected</span>
                            <span style="color: white"><span class="dot-example" name="available"></span> - Available</span>
                            <span style="color: white"><span class="dot-example" name="reserved"></span> - Reserved</span>
                          </div>
                        </div>
                  </div>
              </div>
          </div>
        </form>      
      <script>
          var ticketType = "<%=ticket.getTicketType()%>";
          var x = 0;
          var y;
          //remove seat from list
            function removeSeat(seatListElm, seatValue) {
                var arr = seatListElm.value.split(',');

                 var p = arr.indexOf(seatValue);
                 if(p !== -1){
                     arr.splice(p, 1);
                     seatListElm.value = arr.join(',');
                 }
            }

            //add seat to list
            function addSeat(seatListElm, seatValue) {
               
                var arr = seatListElm.value.split(',');
                if(arr.join() === ''){ arr = []; }

                var p = arr.indexOf(seatValue);
                if(p === -1){
                    arr.push(seatValue); //append
                    arr=arr.sort(); //sort list
                    seatListElm.value=arr.join(',');
                }
                x++;
            }

            //called everytime a seat is clicked
            function seatClick(seat) {
                seat = (this instanceof HTMLInputElement ) ? this : seat;
                
                var seats = document.querySelector('#seats').value;//get value of current selected seat(s)
                const seatsArr = seats.split(",");//split the array using comma delimiter
                
                y = seatsArr.length; //set length of seats array to y
                var s = document.querySelector('[value="' + seat.value + '"]'); //get element of current selected seat
                var verify = s.classList.contains("selected");//check if element contains "selected" class
                               
                var singleCondition = (ticketType === "Single" && Math.abs(x) > 0);
                var coupleCondition = (ticketType === "Couple" && Math.abs(x) > 1);
                var familyCondition = (ticketType === "Family" && Math.abs(y) > 4);
                
                //Check if current selected seat match the condition
                //1. If user pick Single seat, then this will return true if user choose 2nd seat
                //2. If user pick Couple seat, then this will return true if user choose 3rd seat
                //3. If user pick Family seat, then this will return true if user choose 5th seat
                if((singleCondition || coupleCondition || familyCondition) && seat.classList.contains('reserved') === false) {              
                    if(verify === false) {
                        exceedTicket();
                    } else if(ticketType === "Single" || ticketType === "Couple"){
                        seat.classList.toggle('selected');
                        x--;
                        removeSeat(document.getElementById('seats'), seat.value);
                    } else {
                        seat.classList.toggle('selected');
                        y = seatsArr.length - 1;
                        removeSeat(document.getElementById('seats'), seat.value);
                    }
                } else if (seat.classList.contains('reserved') === false) {
                        if (seat.classList.toggle('selected')) {
                            addSeat(document.getElementById('seats'), seat.value);
                        } else {
                            x--;
                            removeSeat(document.getElementById('seats'), seat.value);
                        }
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'This seat is reserved! Please choose another seat'
                    });
                    removeSeat(document.getElementById('seats'), seat.value);
                    return;
                }
            }

            //adding event click to seats
            var elms = document.getElementsByClassName('seat');
            
            for(var i = 0, l = elms.length ; i < l ; i++){              
                elms[i].onclick = seatClick;
            }
             
            function exceedTicket() {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Exceeded ticket capacity!'
                });
            }          
        </script>
    </body>
</html>
