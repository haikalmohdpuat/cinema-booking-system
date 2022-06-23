<%-- 
    Document   : admin-homepage
    Created on : 22 May 2022, 5:24:37 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="dao.CustomerDAO"%>
<%@page import="model.Customer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="dao.MovieDAO"%>
<%@page import="model.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Home Page</title>
        <style>
                        .modal-container {
                display: flex;
                justify-content: space-around;
            }
            
            body:not(.container) {
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
                background-color: #FDFDFE;
                text-align: center;
            }
            
            #nav_home {
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
            
            .btn-edit {
                width: 60px;
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
                    <li class="active"><a href="#"><i class="fa-solid fa-house"></i><span class="ml-2">Home</span></a></li>
                    <li><a href="admin-movie.jsp"><i class="fa-solid fa-film"></i><span class="ml-2">Movie</span></a></li>
                    <li><a href="admin-ticket.jsp"><i class="fa-solid fa-ticket"></i><span class="ml-2">Tickets</span></a></li>
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
<!--                                <li class="nav-item"><a class="nav-link" href="#">Page</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Page</a></li>-->
                                <li class="nav-item"><a class="nav-link" href="../Customer/log-out.jsp">Log Out</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <%
                    List<Customer> customerList = CustomerDAO.findAllCustomers();
                    
                    for(int i = 0; i < customerList.size(); i++) {
                        out.print("<form action='../UserController' method='POST' id='my_form" + (i + 1) + "'></form>");
                    }
                %>      
                <div class="card-body ">
                    <h5 class="card-header">List of Customers</h5>
                        <table class="table table-striped table-dark">
                            <thead class="thead-dark">
                                <tr>
                                <th scope="col">CUSTOMER ID</th>
                                <th scope="col">CUSTOMER NAME</th>
                                <th scope="col">PHONE NUMBER</th>
                                <th scope="col">EMAIL</th>
                                <th scope="col" style="text-align: center;">ACTION</th>
                              </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (int i = 0; i < customerList.size(); i++) {
                                        out.println("<tr>");
                                        out.print("<input type='hidden' name='custID' form='my_form" + (i+1) + "' value='" + customerList.get(i).getCustID()+ "'/>");
                                        out.println("<td>" + customerList.get(i).getCustID() + "</td>");
                                        out.println("<td>" + customerList.get(i).getCustName() + "</td>");
                                        out.println("<td>" + customerList.get(i).getCustMobileNumber() + "</td>");
                                        out.println("<td>" + customerList.get(i).getCustEmail() + "</td>");
                                        out.print("<td>");
                                        out.print("<div class='modal-container'>");
                                        out.print("<button type='submit' onclick=\"window.location.href = 'admin-update-customer.jsp?custID="+ customerList.get(i).getCustID() + "'; return false;\" class='btn btn-success btn-sm btn-flex btn-edit'><b>Edit</b></button>");
                                        out.print("<button type='submit' name='action' value='delete' form='my_form" + (i+1) + "' class='btn btn-danger btn-sm btn-flex'><b>Delete</b></button>");
                                        out.print("</td>");
                                        out.println("</tr>");             
                                    }
                                %>                           
                            </tbody>
                       </table>
                </div>
            </div>
        </div>
    </body>
</html>
