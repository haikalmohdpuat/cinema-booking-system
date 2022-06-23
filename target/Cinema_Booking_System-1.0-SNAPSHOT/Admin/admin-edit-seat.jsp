<%-- 
    Document   : admin-edit-seat
    Created on : 24 May 2022, 3:41:16 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>


<%@page import="java.util.Arrays"%>
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
<%--<jsp:include page="customer-navbar.jsp"/>--%>
<jsp:include page="../Customer/bootstrap.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <title>Edit Seating Plan</title>
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
            
            .pre-selected {
              background-color: #702963;
              color: #fff;
              font-weight: bold;
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
            
            .dot-example[name='current'] {
                background-color: #702963;
            }
            
            input[name='seats'], #seatsTwo {
                display: none;
            }
           
            .btn[value='editSeat'], .btn-cancel {
               cursor: pointer;
               padding: 10px;
               background-color: #C38EC7;
               color: white;
               font-weight: bold;
            }
            
            .btn-cancel {
                background-color: #571B7E;
            }
            
            .btn-cancel a {
                text-decoration: none;
                color: inherit;
            }
            
            .btn-cancel:hover, .btn[value='editSeat']:hover {
                background-color: #483248;
                color: white;
            }
            
            .btn-cancel a:hover {
                color: white;
            }
            
            .flex-body {
                display: flex;
                justify-content: space-between;
            }
            
            .flex-body .main-text{
                margin-right: 2.7em;
            }
        </style>
    </head>
    <body>
        <%
           String movieLanguage = request.getParameter("movieLanguage");
           String movieDuration = request.getParameter("movieDuration");
           String movieName = request.getParameter("movieName");
           String type = request.getParameter("ticketType");
           String custID = request.getParameter("custID");
           String id = request.getParameter("ticketID");
           String date = "" + request.getParameter("date") + "";
           String time = "" + request.getParameter("time") + "";
           String hall = request.getParameter("hall");

           int size = Integer.parseInt(request.getParameter("size"));

           String[] seats = new String[size];
           int x = size;
           int f = 0;
             
           for(int k = 0; k < x; k++) {
               if(request.getParameter("seatID" + k) != null) {
                  seats[f] = request.getParameter("seatID" + k);
                  f++;
               } else {
                  x++;
               }
           } 
            
           List<String> seatList = Arrays.asList(seats);
           
           String str = hall.equals("A")? "A - Standard" : hall.equals("B")? "B - Deluxe": "C - Platinum";
        %>
        <form action="../BookingController" method="POST">
            <div class="container mt-5 mb-5 d-flex justify-content-center">
              <div class="card px-100 py-4 w-100">
                  <div class="card-body">
                    <div class="card px-1 py-4">
                      <h6 class="card-title mb-3"></h6>
                      <div class="text-center">
                          <div class='flex-body'><h3><%=id%></h3><h1 class='main-text'>EDIT SEAT</h1><h3><%=custID%></h3></div>
                          <hr>
                          <h1><%=movieName%></h1>
                          <h3>P12 | <%=movieLanguage%> | <%=movieDuration%> HOURS</h3>
                          <input type="hidden" name="hallID" value="<%=str%>">
                          <input type="hidden" name="ticketID" value="<%=id%>">
                          <h3>Hall <%=str%></h3>
                          <h3><%=date%> <%=time%> P.M. <%=type%></h3>
                      </div>
                    </div>
                    <hr style="height: 5px;" />                   
                    <div class="box"></div>
                    <div class="screen" style="color: white; margin-top: -70px;"><b>SCREEN</b></div>
                        <br /><br />
                        <input id="seatsTwo" name="oldSeats" value="<%
                                for (String e : seatList) {  
                                   out.println(e + ",");  
                                 }
                               %>">
                        <input id="seats" name="seats" value="">
                          <%
                              String[] arr = {"A", "B", "C"};
                              
                              if(hall.equals("A")) {
                                    for(int i = 0; i < 3; i++) {
                                        out.println("<div class='circles'>");
                                        for(int j = 1; j <= 18; j++) {
                                            if(j == 1 || j == 7 || j == 13) {
                                                out.println("<div class='circle'>");
                                            }
                                            String seatID = "" + arr[i] + j;
                                            int status = SeatDAO.findSeatIDByDateAndTime(date, time, seatID, hall);
                                            
                                            if(seatList.contains(seatID)) {
                                                out.println("<input type='button' class='seat btn reserved pre-selected' value='"+ arr[i] + j +"'>");
                                            } else if(status == 1) {
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
                              } else if(hall.equals("B")) {
                                    for(int i = 0; i < 3; i++) {
                                        out.println("<div class='circles'>");
                                        for(int j = 1; j <= 12; j++) {
                                            if(j == 1 || j == 3 || j == 5 || j == 7 || j == 9 || j == 11) {
                                                out.println("<div class='circle'>");
                                            }
                                            
                                            String seatID = "" + arr[i] + j;
                                            int status = SeatDAO.findSeatIDByDateAndTime(date, time, seatID, hall);
                                            
                                            if(seatList.contains(seatID)) {
                                                out.println("<input type='button' class='seat btn reserved pre-selected' value='"+ arr[i] + j +"'>");
                                            } else if(status == 1) {
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
                                            int status = SeatDAO.findSeatIDByDateAndTime(date, time, seatID, hall);
                                                                                     
                                            if(seatList.contains(seatID)) {
                                                out.println("<input type='button' class='seat btn reserved pre-selected' value='"+ arr[i] + j +"'>");
                                            } else if(status == 1) {
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
                            <button name="action" type="submit" value="editSeat" class="btn btn-block confirm-button">Confirm</button>
                            <button type="button" class="btn btn-block confirm-button btn-cancel"><a href="admin-ticket.jsp">Cancel</a></button>
                          </div>
                          <div class="legend">
                            <span style="color: white"><span class="dot-example" name="current"></span> - Current</span>
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
          var ticketType = "<%=type%>";
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
                
                var seats = document.querySelector('#seats').value;
                const seatsArr = seats.split(",");
                
                y = seatsArr.length;
                var s = document.querySelector('[value="' + seat.value + '"]');
                var verify = s.classList.contains("selected");
                
                var singleCondition = (ticketType === "Single" && Math.abs(x) > 0);
                var coupleCondition = (ticketType === "Couple" && Math.abs(x) > 1);
                var familyCondition = (ticketType === "Family" && Math.abs(y) > 4);
                
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
                    if(seat.classList.contains('pre-selected')) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'This is customer\'s current seat! Please choose another seat'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'This seat is reserved! Please choose another seat'
                        });
                    }
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

