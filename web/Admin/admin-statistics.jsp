<%-- 
    Document   : admin-statistics
    Created on : 22 May 2022, 5:24:37 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="dao.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.List"%>
<%@page import="dao.MovieDAO"%>
<%@page import="model.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Manage Statistics</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <!--SweetAlert2 - External JS Library-->
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!--FontAwesome-->
        <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://github.s3.amazonaws.com/downloads/lafeber/world-flags-sprite/flags32.css">
        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/highcharts-3d.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/export-data.js"></script>
        <script src="https://code.highcharts.com/modules/accessibility.js"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                color: white;
                font-family: 'Poppins', sans-serif;
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
                margin-left: -10.4rem;
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
            
            p {
                font-size: 0.9em;
            }
            
            a:hover i, a:hover span{
                color: #7386D5;
            }
            
            a[name='current'] i,  a[name='current'] span{
                color: #fff;
            }
            @media (max-width: 800px) {
                #nav_finance {
                    border-radius: 0%;
                }
            }
            
            #container {
                height: 400px;
              }

              .highcharts-figure,
              .highcharts-data-table table {
                min-width: 310px;
                max-width: 800px;
                margin: 1em auto;
              }

              .highcharts-data-table table {
                font-family: Verdana, sans-serif;
                border-collapse: collapse;
                border: 1px solid #ebebeb;
                margin: 10px auto;
                text-align: center;
                width: 100%;
                max-width: 500px;
              }

              .highcharts-data-table caption {
                padding: 1em 0;
                font-size: 1.2em;
                color: #555;
              }

              .highcharts-data-table th {
                font-weight: 600;
                padding: 0.5em;
              }

              .highcharts-data-table td,
              .highcharts-data-table th,
              .highcharts-data-table caption {
                padding: 0.5em;
              }

              .highcharts-data-table thead tr,
              .highcharts-data-table tr:nth-child(even) {
                background: #f8f8f8;
              }

              .highcharts-data-table tr:hover {
                background: #f1f7ff;
              }
        </style>
    </head>
    <body>
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
                    <li><a href="admin-ticket.jsp"><i class="fa-solid fa-ticket"></i><span class="ml-2">Tickets</span></a></li>
                    <li><a href="admin-inquiry.jsp"><i class="fa-solid fa-question"></i><span class="ml-3">Inquiry</span></a></li>
                    <li class="active"><a href="#"><i class="fa-solid fa-chart-column"></i><span class="ml-2">Statistic</span></a></li>
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
<!--                                <li class="nav-item"><a class="nav-link" href="#">Page</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Page</a></li>-->
                                <li class="nav-item"><a class="nav-link" href="../Customer/log-out.jsp">Log Out</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <%
            List<Customer> customerList = new ArrayList<>();
            List<Payment> paymentList = new ArrayList<>();
            List<Ticket> ticketList = new ArrayList<>();
            List<Ticket> ticketListPlaceholder = new ArrayList<>();
            List<Order> orderListPlaceholder = new ArrayList<>();
            List<Order> orderList = new ArrayList<>();
            List<Food> foodList = new ArrayList<>();
            
            int totalRevenue = 0, totalRefund = 0, countRefund = 0;
            
            //Get list of all customers
            customerList = CustomerDAO.findAllCustomers();
            
            //Get list of all payment records
            paymentList = PaymentDAO.findAllPayments();
            
            //Get list of all tickets
            for(int i = 0; i < customerList.size(); i++) {
                ticketListPlaceholder = TicketDAO.findAllTicketByCustID(customerList.get(i).getCustID());
                ticketList.addAll(ticketListPlaceholder);
            }

            //Get list of all order
            for(int i = 0; i < ticketList.size(); i++) {
                orderListPlaceholder = OrderDAO.findAllFoodOrderFromTicketID(ticketList.get(i).getTicketID());
                orderList.addAll(orderListPlaceholder);
            }
            
            // Get total amount of revenue and refund
            // Separate tha amount based on payment status
            for(int i = 0; i < paymentList.size(); i++) {
                 if(!paymentList.get(i).getPaymentStatus().equals("Refund")) {
                    totalRevenue += paymentList.get(i).getPaymentAmount();
                 } else {
                    countRefund++;
                    totalRefund += paymentList.get(i).getPaymentAmount();
                 }
            }
            Date today = Calendar.getInstance().getTime();
        %>      
        <div class="flex-group flex-group-evenly">
            <div class="card">
                <div class="card-body">
                   <h5 class="card-title text-center">Revenue</h5>
                    <div class="payment-box">
                        <p class="flex-end"><span>GROSS</span><span><%=today%></span></p>
                        <h2 style='color: green;'>RM <%=totalRevenue%></h2>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                   <h5 class="card-title text-center">Refund</h5>
                   <div class="payment-box">
                       <p class="flex-end"><span>Total of <b><%=countRefund%> refunds</b> are issued</span></p>
                        <h2 style='color: red;'>RM <%=totalRefund%></h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex-group">
            <div class="btn-tab">
                <ul>
                    <li class="btn btn-nav ml-5 show active" id='btn-nav-move'name="tab1" data-tab-target="#history">History</li>
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
                                   <th scope="col">Cust ID</th>
                                   <th scope="col">Payment ID</th>
                                   <th scope="col">Operation Type</th>
                                   <th scope="col">Amount</th>
                              </thead>
                              <tbody>
                                  <%
                                      //Display payment list
                                      if(paymentList.size() > 0) {
                                        for(int i = 0; i < paymentList.size(); i++) {

                                           out.print("<tr>");
                                           out.print("<th scope='row'>" + (i+1) + "</th>");
                                           out.print("<td>" + paymentList.get(i).getCustID()+ "</td>");
                                           out.print("<td>" + paymentList.get(i).getPaymentID() + "</td>");
                                           out.print("<td>" + paymentList.get(i).getPaymentStatus() + "</td>");
                                           if(paymentList.get(i).getPaymentStatus().equals("Refund")){
                                               out.print("<td><span style='color: red'>- RM" + paymentList.get(i).getPaymentAmount()+ ".00</span></td>");
                                           } else {
                                               out.print("<td><span style='color: green'>+ RM" + paymentList.get(i).getPaymentAmount()+ ".00</span></td>");
                                           }
                                           out.print("</tr>");
                                        }
                                      } else {
                                           out.print("<tr class='no-register'><td colspan='5'>No available payment records</td></tr>");
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
                                      out.print("<figure class='highcharts-figure><div id='container'></div></figure>'");
                                      out.print("</div>");
                                    } else {
                                %>
                                <figure class="highcharts-figure">
                                    <div id="container"></div>
                                </figure>
                                <%}%>
                                <span class="sub-title mt-3">Food Allocation</span>
                                <%
                                    if(orderList.size() == 0) {
                                      out.print("<div class='error-message'>");
                                      out.print("Zero tickets. No available data.");
                                      out.print("</div>");
                                      out.print("<div class='hidden'>");
                                      out.print("<figure class='highcharts-figure><div id='container2'></div></figure>'");
                                      out.print("</div>");
                                    } else {
                                %>
                                <figure class="highcharts-figure">
                                    <div id="container2"></div>
                                </figure>
                                <%}%>
                                <span class="sub-title mt-3">Money Flow</span>
                                <%
                                    if(paymentList.size() == 0) {
                                      out.print("<div class='error-message'>");
                                      out.print("Payment records are unavailable.");
                                      out.print("</div>");
                                      out.print("<div class='hidden'>");
                                      out.print("<figure class='highcharts-figure><div id='container4'></div></figure>'");
                                      out.print("</div>");
                                    } else {
                                %>
                                <figure class="highcharts-figure">
                                    <div id="container4"></div>
                                </figure>
                                <%}%>
                            </div>
                       </div>      
                    </div>             
                </div>          
              </div>
            </div>
        </div>
    </body>
    <%
          List<Movie> movieList = new ArrayList<>();
          int counter = 0;
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

            Highcharts.chart('container', {
                chart: {
                  type: 'pie',
                  options3d: {
                    enabled: true,
                    alpha: 45
                  }
                },
                title: {
                  text: 'Ticket Allocation for each movie in the system'
                },
                subtitle: {
                  text: 'Hover the chart to see the statistics'
                },
                plotOptions: {
                  pie: {
                    innerSize: 100,
                    depth: 45
                  }
                },
                series: [{
                  name: 'Number of tickets',
                  data: [
                    <%
                        for(int i = 0; i < movieList.size(); i++) {
                            //To search all ticket allocation for all customer
                            String str = "" + movieList.get(i).getMovieID();
                            ticketList = TicketDAO.findNumOfTicketByMovieID(str);
                            out.print("['" + movieList.get(i).getMovieName() + "'");
                            out.print(", " + ticketList.size() + "]");

                            if(movieList.size() > 1 && i != movieList.size()-1)
                            out.print(",");
                        }
                    %>
                  ]
                }]
              });
              
              Highcharts.chart('container2', {
                chart: {
                  type: 'pie',
                  options3d: {
                    enabled: true,
                    alpha: 45,
                    beta: 0
                  }
                },
                title: {
                  text: 'Percentage of Food sold through the system'
                },
                accessibility: {
                  point: {
                    valueSuffix: '%'
                  }
                },
                tooltip: {
                  pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                  pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    depth: 35,
                    dataLabels: {
                      enabled: true,
                      format: '{point.name}'
                    }
                  }
                },
                series: [{
                  type: 'pie',
                  name: 'Percentage Bought',
                  data: [
                    <%
                        for(int i = 0; i < foodList.size(); i++) {                                
                            for(int k = 0; k < orderList.size(); k++) {
                                if(orderList.get(k).getFoodDetails().equals(foodList.get(i).getFoodDescription()))
                                    counter += orderList.get(k).foodQuantity;
                            }
                            
                            out.print("['" + foodList.get(i).getFoodDescription() + "'");
                            out.print(", " + counter + "]");
                            counter = 0;
                            if(foodList.size() > 1 &&i != foodList.size()-1)
                                out.print(",");
                        }
                   %>
                  ]
                }]
              });
              
              
              Highcharts.chart('container4', {
                title: {
                  text: 'Revenue of Cinema Booking System'
                },

                subtitle: {
                  text: 'Hover the line to see detailed description'
                },

                yAxis: {
                  title: {
                    text: 'Total Revenue'
                  }
                },

                xAxis: {
                  categories : [<%
                            for(int i = 0; i < paymentList.size() + 1; i++) {
                                out.print("'TRX " + (i+1) + "'");
                                if(i != paymentList.size())
                                out.print(",");
                            }        
                        %>]
                },

                legend: {
                  layout: 'vertical',
                  align: 'right',
                  verticalAlign: 'middle'
                },

                plotOptions: {
                  series: {
                    label: {
                      connectorAllowed: false
                    },
                  }
                },

                series: [{
                  name: 'Revenue',
                  data: [
                      <%
                        out.print("0,");
                        for(int k = 0; k < paymentList.size(); k++) {                                
                            if(paymentList.get(k).getPaymentStatus().equals("Refund")) {
                                counter -= paymentList.get(k).getPaymentAmount();
                            } else {
                                counter += paymentList.get(k).getPaymentAmount();
                            }
                            out.print(counter);
                            
                            if(k != paymentList.size()-1)
                               out.print(",");
                        }
                        %>
                    ]
                }],

                responsive: {
                  rules: [{
                    condition: {
                      maxWidth: 500
                    },
                    chartOptions: {
                      legend: {
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                      }
                    }
                  }]
                }

              });             
              </script>
            </div>
        </div>
    </body>
</html>
