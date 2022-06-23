<%-- 
    Document   : navbar
    Created on : 23 Apr 2022, 12:58:08 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="bootstrap.jsp"/>
<%@page import="java.io.Serializable"%>
<html>
    <head>
        <style>
            nav {
                background-color: #571B7E;
            }
            
            modal-body-profile {
                display: block !important;
            }
            
            .modal-title, .modal-header {
                background-color: #571B7E !important;
                color: white !important;
            }
            
            .modal-body-profile label {
                color: black !important;
                display: block !important;
            }
            
            .modal-body-profile input {
                width: 100% !important;
            }
        </style>
    </head>
    <body>
        <%
            Customer customer = (Customer) request.getSession().getAttribute("customer");
        %>
        <nav class="navbar navbar-expand-md navbar-dark">
             <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" aria-controls="collapsibleNavbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-md-center" id="collapsibleNavbar">
                <ul class="navbar-nav">
                    <a class="navbar-brand" style="pointer-events: none"href="#">
                        <i class="fa-solid fa-user"></i>  Customer
                    </a>
                    <li class="nav-item mr-3">
                        <a class="nav-link" id="nav_home" href="homepage.jsp">Home</a>
                    </li>
                    <li class="nav-item mr-3">
                        <a class="nav-link" id="nav_ticket" href="customer-ticket.jsp">Tickets</a>
                    </li>
                    <li class="nav-item mr-3">
                        <a class="nav-link" id="nav_inquiry" href="customer-inquiry.jsp">Inquiry</a>
                    </li>
                    <li class="nav-item mr-3">
                        <a class="nav-link" data-toggle="modal" data-target="#custProfile"  href="#">Profile</a>
                    </li>
                    <li class="nav-item mr-3">
                        <a class="nav-link" id="nav_finance"  href="customer-finance.jsp">Finance</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="log-out.jsp">Sign out</a>
                    </li>
                </ul>
            </div>
        </nav>
        <div class="modal fade" id="custProfile" tabindex="-1" role="dialog" aria-labelledby="custProfileLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="custProfileLabel">Customer Details</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body modal-body-profile">
                    <label>Customer ID : </label>
                    <input type="text" disabled placeholder='<%=customer.getCustID()%>'><br><br>
                    <label>Customer Name : </label>
                    <input type="text" disabled placeholder='<%=customer.getCustName()%>'><br><br>
                    <label>Customer Email : </label>
                    <input type="text" disabled placeholder='<%=customer.getCustEmail()%>'><br><br>
                    <label>Customer Password : </label>
                    <input type="password" disabled placeholder='<%=customer.getCustPassword()%>'><br><br>
                    <label>Customer Mobile Number: </label>
                    <input type="text" disabled placeholder='<%=customer.getCustMobileNumber()%>'><br><br>
                    <label>Customer Balance: </label>
                    <input type="text" disabled placeholder='<%=customer.getCustBalance()%>'><br>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary btn-danger" data-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
          </div>
    </body>
</html>