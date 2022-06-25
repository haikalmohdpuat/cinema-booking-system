<%-- 
    Document   : admin-update-customer
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
 .card {
              width: 600px;
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
            
            .iti--allow-dropdown {
                width: 100%;
            }
            
            .flex-body {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
                background: black;
            }
            
            .input-group-prepend {
                width : 30%;
            }

            .input-group-prepend label {
                width: 100%;
                overflow: hidden;
            }
            
            .confirm-button {
               cursor: pointer;
               padding: 10px;
               background-color: #571B7E;
               color: white;
               font-weight: bold;
            }
            
            .confirm-button:hover {
                background-color: #483248;
            }
            
            h2{
                color: white;
                background: black;
                text-align: center;
                margin-bottom: -10px;
                padding-top: 20px;
            }
            
            .header {
                margin-top: -20px;
            }
            
            @media (max-width: 800px) {
                .card {
                  width: 400px;
                  font-size: 12px;
                }
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
                    String custID = request.getParameter("custID");
                    Customer customer = CustomerDAO.findCustomerByID(custID);
               %>                
                <div class="header">
                    <h2>MANAGE CUSTOMER DETAILS</h2>
                </div>
                <div class="flex-body">
                   <form id="updatemovie" action="../UserController" method="POST">
                        <div class="container mt-5 mb-5 d-flex justify-content-center">
                            <div class="card px-1 py-4">
                                <div class="card-body">
                                    <h6 class="card-title mb-3">Update the Customer</h6>
                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <label class="input-group-text text-dark" for="custID">Customer  ID</label>
                                                </div>
                                            <input type="text" class="form-control" readonly id="custID" value="<%=customer.getCustID()%>"/>
                                            <input type="hidden" class="form-control" readonly name="custID" value="<%=customer.getCustID()%>"/>
                                        </div>
                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <label class="input-group-text text-dark" for="custName">Customer Name</label>
                                            </div>
                                            <input type="text" class="form-control" id="custname" name="custName"value="<%=customer.getCustName()%>">
                                        </div>
                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <label class="input-group-text text-dark" for="custMobileNumber">Phone Number</label>
                                            </div>
                                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="<%=customer.getCustMobileNumber()%>">
                                        </div>
                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <label class="input-group-text text-dark" for="custEmail">Email</label>
                                            </div>
                                            <input type="text" class="form-control" id="custEmail" name="custEmail" value="<%=customer.getCustEmail()%>">
                                        </div>

                                    <br />
                                      <button class="btn btn-block confirm-button" name="action" value="update">Save</button>
                                      <button class="btn btn-block confirm-button" name="cancel" value="Cancel" onclick="window.location.href = 'admin-homepage.jsp'; return false;">
                                      Cancel</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div> 
            </div>
        </div>
    </body>
</html>
