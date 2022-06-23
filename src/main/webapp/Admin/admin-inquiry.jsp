<%-- 
    Document   : admin-inquiry
    Created on : 23 May 2022, 1:39:26 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="model.Admin"%>
<%@page import="dao.InquiryDAO"%>
<%@page import="model.Inquiry"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Inquiry</title>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Balsamiq+Sans:wght@700&display=swap" rel="stylesheet">
        <style>
            .card-body {
                background-color: #222131;
                border: none;
                padding: 2.5em;
                margin-top: 2em;
            }
            
            .modal-container {
                display: flex;
                justify-content: space-around;
            }
            
            .card-container, table {
                width: 100%;
            }
            
            .card-container {
                margin-top: -3em;
            }
            
            .card-header, .modal-header {
                text-align: center;
                background-color: #571B7E;
                color: white;
            }
            
            .flex-body {
                display: flex;
                justify-content: center;
                align-items: center;
            }
            
            th {
                font-size: 16px;
            }
            
            .no-register td {
                color: black;
                background-color: #FDFDFE;
                text-align: center;
            }
            
            .modal-body input {
                width: 100%;
            }
            
            .btn-inquiry {
                padding: 10px;
                background: #BF40BF;
            }
            
            .btn-inquiry:hover {
                background: #800080;
            }
            
            #nav_inquiry {
                background: #CF9FFF;
                color: #000;
                font-weight: bold;
                border-radius: 10%;
                height: 100%;
            }
            
            .dropdown {
                width: 100%;
                padding: 0.3rem;
            }
 
            @media (max-width: 800px) {
                #nav_inquiry {
                    border-radius: 0%;
                }
            }
        </style>
    </head>
    <body id="inquiry">
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
                    <li class="active"><a href="#"><i class="fa-solid fa-question"></i><span class="ml-3">Inquiry</span></a></li>
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
                        <%
                            List<Inquiry> inquiryList = new ArrayList<>();
                            List<Inquiry> responseList = new ArrayList<>();
                            inquiryList = InquiryDAO.findAllInquiry();

                            for(int i = 0; i < inquiryList.size(); i++) {
                                out.println("<form action='../InquiryController' method='POST' id='inquiry_form" + (i+1) + "'></form>");
                            }
                            
                            for(int i = 0; i < inquiryList.size(); i++) {
                                out.println("<form action='../InquiryController' method='POST' id='response_inquiry_form" + (i+1) + "'></form>");
                            }
                        %> 
                    </div>
                </nav>
                    <div class="flex-body">
                        <div class="card-container">
                            <form action="../BookingController" method="POST">
                                <div class="card-body ">
                                    <h5 class="card-header">Inquiry List</h5>
                                        <table class="table table-striped table-dark">
                                            <thead class="thead-dark">
                                                <tr>
                                                <th scope="col">NO</th>
                                                <th scope="col">INQUIRY ID</th>
                                                <th scope="col">CUSTOMER ID</th>
                                                <th scope="col">CATEGORY</th>
                                                <th scope="col">SUB CATEGORY</th>
                                                <th scope="col">MESSAGE</th>
                                                <th scope="col">STATUS</th>
                                                <th scope="col" class='ml-1'style="text-align: center;">ACTION</th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    if(inquiryList.size() > 0) {
                                                        for(int i = 0; i < inquiryList.size(); i++) {
                                                            out.print("<tr>");
                                                            out.print("<td>");
                                                            out.print("<scope='row'>" + (i + 1) + "</td>");
                                                            out.print("</td>"); 
                                                            out.print("<td>");
                                                            out.print("<input type='hidden' name='inquiryID' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquiryID() + "'/>");
                                                            out.print(inquiryList.get(i).getInquiryID());
                                                            out.print("</td>");
                                                            out.print("<td>");
                                                            out.print("<input type='hidden' name='custID' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getCustID() + "'/>");
                                                            out.print(inquiryList.get(i).getCustID());
                                                            out.print("</td>");
                                                            out.print("<td>");
                                                            out.print("<input type='hidden' name='inquiryCategory' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquiryCategory()+ "'/>");
                                                            out.print(inquiryList.get(i).getInquiryCategory());
                                                            out.print("</td>");
                                                            out.print("<td>");
                                                            out.print("<input type='hidden' name='inquirySubCategory' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquirySubCategory()+ "'/>");
                                                            out.print(inquiryList.get(i).getInquirySubCategory());
                                                            out.print("</td>");
                                                            out.print("<td>");
                                                            out.print("<input type='hidden' name='inquiryMessage' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquiryMessage()+ "'/>");
                                                            out.print(inquiryList.get(i).getInquiryMessage());
                                                            out.print("</td>");
                                                            out.print("<td>");
                                                            out.print("<input type='hidden' name='inquiryStatus' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquiryStatus() + "'/>");
                                                            
                                                            responseList = InquiryDAO.findListOfInquiryAnswerByInquiryID(inquiryList.get(i).getInquiryID());
                                                            String style = inquiryList.get(i).getInquiryStatus().equals("Closed")? "<span style='color:red'>" : inquiryList.get(i).getInquiryStatus().equals("Replied")?
                                                                           "<span style='color: #24a0ed'>" : inquiryList.get(i).getInquiryStatus().equals("Open")? "<span style='color: green'>" : "<span style='color: yellow'>";
                                                            
                                                            if(inquiryList.get(i).getInquiryStatus().equals("Open") == false &&  inquiryList.get(i).getInquiryStatus().equals("Closed") == false) {
                                                                if(responseList.size()%2 == 0) {
                                                                    out.print("<span style='color: yellow'><b>Pending Reply</b></span>");
                                                                } else {
                                                                    out.print(style + "<b>" + inquiryList.get(i).getInquiryStatus() + "</b></span>");
                                                                }
                                                            } else {
                                                                out.print(style + "<b>" + inquiryList.get(i).getInquiryStatus() + "</b></span>");
                                                            }
                                                            out.print("</td>");
                                                            out.print("<td>");
                                                            out.print("<div class='modal-container'>");
                                                            out.print("<button type='button' title='Response' class='btn btn-success btn-flex' data-toggle='modal' data-target='#responseModal" + (i+1) +"'><i class='fa-solid fa-message'></i></button>");
                                                            out.print("</div>");
                                                            out.print("</td>");
                                                            out.print("</tr>");
                                                        }
                                                    } else {
                                                       out.print("<tr class='no-register'><td colspan='8'>No active inquiries</td></tr>");
                                                    }

                                                %>          
                                            </tbody>
                                        </table>
                                    </div>
                             </form>  
                        </div>
                   </div> 
            </div>
        </div>
        <%
            List<Inquiry> inquiryResponseList = new ArrayList<>();

            for(int i = 0; i < inquiryList.size(); i++) {
                out.println("<div  class='modal fade' id='responseModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='responseModalLabel" + (i+1) +"' aria-hidden='true'>");
                out.println("<div class='modal-dialog' role='document'>");
                out.println("<div class='modal-content'>");
                out.println("<div class='modal-header'>");
                out.println("<h5 class='modal-title' id='responseModalLabel" + (i+1) +"'>Inquiry Response</h5>");
                out.println("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                out.println("<span aria-hidden='true'>&times;</span>");
                out.println("</button>");
                out.println("</div>");
                out.println("<div class='modal-body'>");
                out.println("<form action='../InquiryController' method='POST' id='response_inquiry_form" + (i+1) + "'>");
                out.println("<input type='hidden' name='txtInquiryID' form='response_inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquiryID()+ "'>");
                out.println("<label><b>Initial Inquiry Message</b></label>");
                out.println("<input type='text' disabled placeholder='" + inquiryList.get(i).getInquiryMessage()+ "'><br><br>");
                out.print("<input type='hidden' name='userType' value='admin' form='response_inquiry_form" + (i+1) + "'/>");
                out.print("<input type='hidden' name='userID' value='" + admin.getAdminID() +"' form='response_inquiry_form" + (i+1) + "'/>");
                
                inquiryResponseList = InquiryDAO.findListOfInquiryAnswerByInquiryID(inquiryList.get(i).getInquiryID());
                
                if(inquiryList.get(i).getInquiryStatus().equals("Closed")) {             
                    if(inquiryResponseList.size() > 0) {
                        for(int n = 0; n < inquiryResponseList.size(); n++) {
                            if(n%2 == 0) {
                                out.print("<div class='text-right mt-3'><b>Admin</b></div>");
                                out.print("<div class='text-right'>" + inquiryResponseList.get(n).getInquiryAnswer() + "</div>");
                            } else {
                                out.print("<label><b>Customer Response</b></label>");
                                out.print("<div>" + inquiryResponseList.get(n).getInquiryAnswer() + "</div>");
                            }
                        }
                        out.print("<br><div style='font-weight: bold;'>Inquiry has been closed. No response can be send or received</div><br>");
                    } else {
                        out.println("<b>Inquiry is closed without any admin response</b>");
                    }
                    out.println("</div><div class='modal-footer" + "'>");
                    out.println("<button type='button' class='btn btn-danger' data-dismiss='modal'>Close</button>");
                } else if(inquiryList.get(i).getInquiryStatus().equals("Replied")){
                    for(int n = 0; n < inquiryResponseList.size(); n++) {
                        if(n%2 == 0) {
                            out.print("<div class='text-right mt-3'><b>Admin</b></div>");
                            out.print("<div class='text-right'>" + inquiryResponseList.get(n).getInquiryAnswer() + "</div>");
                        } else {
                            out.print("<label><b>Customer Response</b></label>");
                            out.print("<div>" + inquiryResponseList.get(n).getInquiryAnswer() + "</div>");
                        }
                    }
                    
                    if(inquiryResponseList.size()%2 == 0) {
                        if(inquiryList.get(i).getInquiryStatus().equals("Closed") == false) {
                            out.println("<br><label><b>Admin Response</b></label>");
                            out.println("<input type='text' required name='inquiryResponse' form='response_inquiry_form" + (i+1) + "'><br>");
                        }
                    }
                    out.println("</div><div class='modal-footer" + "'>");
                    if(inquiryList.get(i).getInquiryStatus().equals("Open") == false && inquiryResponseList.size()%2 == 0) {
                        out.println("<button type='submit' name='action' value='save' class='btn btn-success' form='response_inquiry_form" + (i+1) + "'>Save</button>");
                    }
                    out.println("<button type='button' class='btn btn-danger' data-dismiss='modal'>Close</button>");
                } else if(inquiryList.get(i).getInquiryStatus().equals("Open")){
                    out.println("<label><b>Admin Response</b></label>");
                    out.println("<input type='text' required name='inquiryResponse' form='response_inquiry_form" + (i+1) + "'><br>");
                    out.println("</div><div class='modal-footer" + "'>");
                    out.println("<button type='submit' name='action' value='save' class='btn btn-success' form='response_inquiry_form" + (i+1) + "'>Save</button>");
                    out.println("<button type='button' class='btn btn-danger' data-dismiss='modal'>Close</button>");
                }               
                out.println("</div>");
                out.println("</form>");
                out.println("</div>");
                out.println("</div>");
                out.println("</div>");
            }
        %>
    </body>
</html>
