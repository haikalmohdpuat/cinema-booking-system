<%-- 
    Document   : chart
    Created on : 15 May 2022, 1:20:36 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.FoodDAO"%>
<%@page import="model.Food"%>
<%@page import="dao.OrderDAO"%>
<%@page import="model.Order"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="dao.PaymentDAO"%>
<%@page import="model.Payment"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="model.Customer"%>
<%@page import="java.util.Random"%>
<%@page import="dao.TicketDAO"%>
<%@page import="model.Ticket"%>
<%@page import="dao.MovieDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Movie"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="customer-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <title>Customer Finance</title>
        <style>           
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
/*                font-family: 'Poppins', sans-serif;*/
                color: white;
            }
            
            [data-tab-content] {
                display: none;
            }
            
            .active[data-tab-content] {
                display: inline;
            }

            body {
                background: black;
            }
            
            .flex-group {
                margin-top: 2.4em;
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
            }
            
            .flex-group-evenly {
                margin-top: 2.4em;
                display: flex;
                justify-content: space-evenly;
                flex-wrap: wrap;
                gap: 35px;
            }
            
            .flex-group:nth-child(2) {
                margin-top: 2em;
                display: flex;
                flex-wrap: wrap;
            }
            
            .flex-group .card{
                width: 30%;
                background-color: #222131;
                border: none; 
            }
            
            .chart {
                width: 65%;
                height: auto;
                margin-left: auto;
                margin-right: auto;
            }
            
            .chart2 {
                width: 55%;
                height: auto;
                margin-left: auto;
                margin-right: auto;
            }
            
            .chart-horizontal-bar {
                width: 100%;
            }
            
            .card-body {
                padding-bottom: 2.4em;
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
            
            .card-body .sub-title{
                font-weight: bold;
            }
            
            .flex-end {
                display: flex;
                justify-content: space-between;
            }

            .payment-box {
                margin-top: 1rem;
                height: auto;
                padding: 7px;
                font-size: 1.2rem;
                border-left: 5px solid #BF40BF;
            }
            
            .btn-nav {
                border-radius: 12px;
                color: black;
                background: #222131;
                padding: 0.7em 1.5em;
                font-weight: bold;
            }
            
            .btn-nav a {
                color: white;
                font-weight: bold;
                text-decoration: none;
            }
            
            .btn-nav:hover {
                background:#36454F;
                color: black;
            }
            
            .btn-nav.active:hover {
                background: white;
                color: black;
            }
            
            .btn-tab {
                margin-left: -13rem;
            }
            
            .active {
                background: white;
                color: black;
            }
            
            .sub-title {                
                font-size: 1.6em;
                margin-left: 1em;
            }
            
            .chartBox {
                width: 90%;
                padding: 20px;
                border-radius: 20px;
                border: solid 3px #702963;
                background: white;
            }
            
            .error-message {
                display: flex;
                justify-content: center;
                font-weight: bold;
                padding: 2em;
                margin-top: 1em;
            }
            
            .hidden {
                display: none;
            }
            
            .no-register td {
                color: black;
                background-color: #FDFDFE;
                text-align: center;
            }
            
            .center-item {
                display: flex;
                justify-content: center;
                align-items: center;
                font-weight: bold;
            }
            
            #nav_finance {
                background: #CF9FFF;
                color: #000;
                font-weight: bold;
                border-radius: 10%;
                height: 100%;
            }
            
            @media (max-width: 800px) {
                #nav_finance {
                    border-radius: 0%;
                }
            }
        </style>
    </head>
    <body id="finance">
        <%
            Customer customer = (Customer) request.getSession().getAttribute("customer");
            List<Payment> paymentList = new ArrayList<>();
            List<Ticket> ticketList = new ArrayList<>();
            List<Order> orderListPlaceholder = new ArrayList<>();
            List<Order> orderList = new ArrayList<>();
            List<Food> foodList = new ArrayList<>();
 
            paymentList = PaymentDAO.findListOfPaymentByCustID(customer.getCustID());
            ticketList = TicketDAO.findAllTicketByCustID(customer.getCustID());
            
            for(int i = 0; i < ticketList.size(); i++) {
                orderListPlaceholder = OrderDAO.findAllFoodOrderFromTicketID(ticketList.get(i).getTicketID());
                orderList.addAll(orderListPlaceholder);
            }
            
            Date today = Calendar.getInstance().getTime();
            final DecimalFormat df = new DecimalFormat("0.00");
            double percentage = Math.floor((customer.getCustBalance()-1500)*100)/1500;  
        %>      
        <div class="flex-group flex-group-evenly">
            <div class="card">
                <div class="card-body">
                   <h5 class="card-title text-center">Finance Details</h5>
                    <div class="payment-box">
                        <p class="flex-end"><span>BALANCE</span><span><%=today%></span></p>
                        <h2>RM<%=customer.getCustBalance()%>.00</h2>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                   <h5 class="card-title text-center">Percentages</h5>
                    <div class="payment-box">
                        <%if(customer.getCustBalance() < 1500){%>
                        <p class="flex-end"><span>You are currently down</span></p>
                        <h2><span style="color:red;"><%=df.format(percentage)%>%</span></h2>
                        <%}else if(customer.getCustBalance() > 1500){%>
                        <p class="flex-end"><span>You are currently up</span></p>
                        <h2><span style="color:#00FF00;"><%=df.format(percentage)%>%</span></h2>
                        <%} else if(customer.getCustBalance() == 1500) {%>
                        <p class="flex-end"><span>No changes detected</span></p>
                        <h2><span><%=df.format(percentage)%>%</span></h2>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex-group">
            <div class="btn-tab">
                <ul>
                    <li class="btn btn-nav ml-5 show active" name="tab1" data-tab-target="#history">History</li>
                    <li class="btn btn-nav ml-5" name="tab2" data-tab-target="#statistics">Statistics</li>
                </ul>
            </div>
            <div>
                <input type="hidden"/>
            </div>
        </div>
        <div class="tab-content">
            <div id="history" data-tab-content  class="active">
              <div class="flex-group mb-5">
                  <div class="card w-75">
                       <div class="card-body">
                          <h5 class="card-title text-center mb-3">Latest Transactions</h5>
                          <table class="table table-dark table-hover">
                              <thead>
                                   <th scope="col">No</th>
                                   <th scope="col">Payment ID</th>
                                   <th scope="col">Operation Type</th>
                                   <th scope="col">Amount</th>
                              </thead>
                              <tbody>
                                  <%
                                      if(paymentList.size() > 0) {
                                        for(int i = 0; i < paymentList.size(); i++) {

                                           out.print("<tr>");
                                           out.print("<th scope='row'>" + (i+1) + "</th>");
                                           out.print("<td>" + paymentList.get(i).getPaymentID() + "</td>");
                                           out.print("<td>" + paymentList.get(i).getPaymentStatus() + "</td>");
                                           if(paymentList.get(i).getPaymentStatus().equals("Refund")){
                                               out.print("<td><span style='color: green'>+RM" + paymentList.get(i).getPaymentAmount()+ ".00</span></td>");
                                           } else {
                                               out.print("<td><span style='color: red'>- RM" + paymentList.get(i).getPaymentAmount()+ ".00</span></td>");
                                           }
                                           out.print("</tr>");
                                        }
                                      } else {
                                           out.print("<tr class='no-register'><td colspan='4'>No available payment records</td></tr>");
                                      }
                                  %>                          
                              </tbody>
                          </table>
                       </div>
                   </div>
               </div>          
          </div>
          <div id="statistics" data-tab-content>
              <div class="flex-group">
                  <div class="card w-75">
                      <div class="card-body">
                          <span class="sub-title">Ticket Allocation</span>
                          <%
                              if(ticketList.size() == 0) {
                                out.print("<div class='error-message'>");
                                out.print("Zero tickets. No available data.");
                                out.print("</div>");
                                out.print("<div class='hidden'>");
                                out.print("<canvas id='ticketChart'></canvas>");
                                out.print("</div>");
                              } else {
                          %>
                          <div class="chart2 mt-5 mb-5">
                              <canvas id="ticketChart"></canvas>
                          </div>
                          <%}%>
                          <span class="sub-title mt-3">Food Allocation</span>
                          <%
                              if(orderList.size() == 0) {
                                out.print("<div class='error-message'>");
                                out.print("Zero tickets. No available data.");
                                out.print("</div>");
                                out.print("<div class='hidden'>");
                                out.print("<canvas id='foodChart'></canvas>");
                                out.print("</div>");
                              } else {
                          %>
                          <div class="chart chart-horizontal-bar chartBox mt-5 mb-5">
                              <canvas id="foodChart"></canvas>
                          </div>
                          <%}%>
                          <span class="sub-title mt-3">Money Flow</span>
                          <%
                              if(paymentList.size() == 0) {
                                out.print("<div class='error-message'>");
                                out.print("Payment records are unavailable.");
                                out.print("</div>");
                                out.print("<div class='hidden'>");
                                out.print("<canvas id='moneyChart'></canvas>");
                                out.print("</div>");
                              } else {
                          %>
                          <div class="chart chart-horizontal-bar chartBox mt-5 mb-5">
                              <canvas id="moneyChart"></canvas>
                          </div>
                          <%}%>
                      </div>
                 </div>      
              </div>             
          </div>          
        </div>
      <%
          List<Movie> movieList = new ArrayList<>();
          int counter = 0, counter2 = 0;
          movieList = MovieDAO.findAllMovies();
          foodList = FoodDAO.findAllFood();
      %>
        <script>
            const tabs = document.querySelectorAll('[data-tab-target]');
            const tabContents = document.querySelectorAll('[data-tab-content]');

                tabs.forEach(tab => {
                    tab.addEventListener('click', () => {
                        const target = document.querySelector(tab.dataset.tabTarget);
                        tabContents.forEach(tabContent => {
                          tabContent.classList.remove('active');
                        });
                        tabs.forEach(tab => {
                          tab.classList.remove('active');
                        });
                        tab.classList.add('active');
                        target.classList.add('active');
                    });
                });

            let myChart = document.getElementById('ticketChart').getContext('2d');

            Chart.defaults.font.family = 'Poppins';
            Chart.defaults.font.size = 14;
            Chart.defaults.font.color = '#fff';

            //Ticket Chart
            let massPopChart = new Chart(myChart, {
                type:'doughnut',
                data: {
                    labels:[
                        <%
                            for(int i = 0; i < movieList.size(); i++) {
                                out.print("'" + movieList.get(i).getMovieName() + "'");
                                if(i != movieList.size()-1)
                                out.print(",");
                            }
                        %>
                    ],
                    datasets:[{
                        label: 'Points',
                        data:[
                            <%
                            for(int i = 0; i < movieList.size(); i++) {
    //                            To search all ticket allocation for all customer
    //                            String str = "" + movieList.get(i).getMovieID();
    //                            ticketList = TicketDAO.findNumOfTicketByMovieID(str);
    //                            out.print(ticketList.size());

                                //To search ticket allocation for single user
                                for(int k = 0; k < ticketList.size(); k++) {
                                    if(ticketList.get(k).getMovieID().equals(movieList.get(i).getMovieID()))
                                    counter++;
                                }
                                out.print(counter);
                                counter = 0;

                                if(i != movieList.size()-1)
                                out.print(",");
                            }
                        %>
                        ],
                        backgroundColor: [
                            <%
                           for(int i = 0; i < movieList.size(); i++) {
                                Random obj = new Random();
                                int rand_num = obj.nextInt(0xffffff + 1);
                                // format it as hexadecimal string and print
                                String colorCode = String.format("#%06x", rand_num);
                                out.print("'" + colorCode + "'");
                                if(i != movieList.size()-1)
                                out.print(",");
                           }
                           %>
                        ]
                    }]
                }, 
                options:{
                    animation: {
                        animateScale: false
                    }
                }
            });

          //Food Chart
          const data = {
          labels: [<%
                        for(int i = 0; i < foodList.size(); i++) {
                            out.print("'" + foodList.get(i).getFoodDescription()+ "'");
                            if(i != foodList.size()-1)
                            out.print(",");
                        }
                   %>],
          datasets: [{
            label: 'Quantity',
            data: [<%
                        for(int i = 0; i < foodList.size(); i++) {                                
                            for(int k = 0; k < orderList.size(); k++) {
                                if(orderList.get(k).getFoodDetails().equals(foodList.get(i).getFoodDescription()))
                                    counter2 += orderList.get(k).foodQuantity;
                            }
                            out.print(counter2);
                            counter2 = 0;
                            if(i != foodList.size()-1)
                                out.print(",");
                        }
                   %>],
            backgroundColor: [
              'rgba(25, 25, 112, 0.2)',
              'rgba(136, 8, 8, 0.2)',
              'rgba(204, 85, 0, 0.2)',
              'rgba(0, 255, 255, 0.2)',
              'rgba(69, 75, 27, 0.2)',
              'rgba(223, 255, 0, 0.2)',
              'rgba(93, 63, 211, 0.2)',
              'rgba(27, 18, 18, 0.2)',
              'rgba(123, 63, 0, 0.2)',
              'rgba(127, 0, 255, 0.2)',
              'rgba(98, 159, 64, 0.2)',
              'rgba(255, 222, 173, 0.2)'
            ],
            borderColor: [
              'rgba(25, 25, 112, 1)',
              'rgba(136, 8, 8, 1)',
              'rgba(204, 85, 0, 1)',
              'rgba(0, 255, 255, 1)',
              'rgba(69, 75, 27, 1)',
              'rgba(223, 255, 0, 1)',
              'rgba(93, 63, 211, 1)',
              'rgba(27, 18, 18, 1)',
              'rgba(123, 63, 0, 1)',
              'rgba(127, 0, 255, 1)',
              'rgba(98, 159, 64, 1)',
              'rgba(255, 222, 173, 1)'
            ],
            borderWidth: 1,
            tension: 1
          }]
        };

        //Money Chart        
        const labels = [<%
                            for(int i = 0; i < paymentList.size() + 1; i++) {
                                out.print("'TRX " + (i+1) + "'");
                                if(i != paymentList.size())
                                out.print(",");
                            }        
                        %>];
        const data2 = {
          labels: labels,
          datasets: [{
            label: 'Money Flow Dataset',
            data: [<%
                       if(paymentList.size() > 0) {
                            if(paymentList.get(0).getPaymentStatus().equals("Ticket Payment")) {
                                 out.print(paymentList.get(0).getCurrentBalance() + paymentList.get(0).getPaymentAmount() + ",");
                            } else {
                                 out.print(paymentList.get(0).getCurrentBalance() - paymentList.get(0).getPaymentAmount() + ",");
                            }
                            for(int k = 0; k < paymentList.size(); k++) {
                                 out.print(paymentList.get(k).getCurrentBalance());
                                 if(k != paymentList.size()-1)
                                 out.print(",");
                            }
                       } 
                  %>],
            fill: false,
            borderColor: 'rgb(75, 192, 192)',
            tension: 0.1
          }]
        };
        
        // config 
        const config = {
          type: 'bar',
          data: data,
          options: {
              indexAxis : 'y',
            scales: {
              y: {
                beginAtZero: true
              }
            }
          }
        };
        const config2 = {
            type: 'line',
            data: data2,
            options: {
                scales: {
                        y: {
                            display: true,
                            labelString: "Balance",
                            ticks: {                           
                                callback: function(value, index, ticks) {
                                    return 'RM' + value;
                                }
                            }
                        },
                        x: {
                            display: true,
                            labelString: "PaymentID"
                        }
                }
            }
        };
        
        const myChart3 = new Chart(document.getElementById('foodChart'),config);
        const myChart4 = new Chart(document.getElementById('moneyChart'),config2);
        </script>
    </body>
</html>
