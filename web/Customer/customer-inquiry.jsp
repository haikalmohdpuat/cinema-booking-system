
<%-- 
    Document   : inquiry
    Created on : 8 May 2022, 9:05:51 am
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="java.util.concurrent.ThreadLocalRandom"%>
<%@page import="model.Customer"%>
<%@page import="dao.InquiryDAO"%>
<%@page import="model.Inquiry"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.Serializable"%>
<jsp:include page="customer-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Inquiry</title>
        <style>
            .modal-container {
                display: flex;
                justify-content: space-around;
            }
            
            body {
                background-color: black;
            }
            
            .card-body {
                background-color: #222131;
                border: none;
                padding: 2.5em;
                margin-top: 2em;
            }
            
            .card-container {
                width: 1150px;
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
            List<Inquiry> inquiryList = new ArrayList<>();
            List<Inquiry> responseList = new ArrayList<>();
            List<Inquiry> inquiryResponseList = new ArrayList<>();
            Customer customer = (Customer) request.getSession().getAttribute("customer");
            inquiryList = InquiryDAO.findAllInquiryByCustID(customer.getCustID());
            
            for(int i = 0; i < inquiryList.size(); i++) {
                out.print("<form action='../InquiryController' method='POST' id='inquiry_form" + (i+1) + "'></form>");
            }
        %>
        <div class="flex-body">
            <div class="card-container mt-5">
            <form action="../BookingController" method="POST">
                <button type="button" class="btn btn-info btn-sm btn-flex btn-inquiry" data-toggle='modal' data-target='#createInquiryModal'><b>Create Inquiry      </b><i class="fa-solid fa-plus"></i></button>
                <div class="card-body ">
                    <h5 class="card-header">Inquiry List</h5>
                        <table class="table table-striped table-dark w-auto">
                            <thead class="thead-dark">
                                <tr>
                                <th scope="col">NO</th>
                                <th scope="col">ID</th>
                                <th scope="col">CATEGORY</th>
                                <th scope="col">SUB CATEGORY</th>
                                <th scope="col">MESSAGE</th>
                                <th scope="col">STATUS</th>
                                <th scope="col" style="text-align: center;">ACTION</th>
                              </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(inquiryList.size() > 0) {
                                        for(int i = 0; i < inquiryList.size(); i++) {
                                            out.println("<tr>");
                                            out.println("<td>");
                                            out.println("<scope='row'>" + (i + 1) + "</td>");
                                            out.println("</td>"); 
                                            out.println("<td>");
                                            out.println("<input type='hidden' name='inquiryID' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquiryID() + "'/>");
                                            out.println(inquiryList.get(i).getInquiryID());
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println("<input type='hidden' name='inquiryType' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquiryCategory()+ "'/>");
                                            out.println(inquiryList.get(i).getInquiryCategory());
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println("<input type='hidden' name='inquirySubCategory' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquirySubCategory()+ "'/>");
                                            out.println(inquiryList.get(i).getInquirySubCategory());
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println("<input type='hidden' name='inquiryMessage' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquiryMessage()+ "'/>");
                                            out.println(inquiryList.get(i).getInquiryMessage());
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println("<input type='hidden' name='inquiryStatus' form='inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquiryStatus() + "'/>");
                                            
                                            responseList = InquiryDAO.findListOfInquiryAnswerByInquiryID(inquiryList.get(i).getInquiryID());
                                            String style = inquiryList.get(i).getInquiryStatus().equals("Closed")? "<span style='color:red'>" : 
                                                           inquiryList.get(i).getInquiryStatus().equals("Replied")? "<span style='color: #24a0ed'>" : "<span style='color: green'>";
                                            
                                            if(inquiryList.get(i).getInquiryStatus().equals("Open") == false &&  inquiryList.get(i).getInquiryStatus().equals("Closed") == false) {
                                                if(responseList.size()%2 == 1) {
                                                    out.println("<span style='color: yellow'><b>Pending Reply</b></span>");
                                                } else {
                                                    out.println(style + "<b>" + inquiryList.get(i).getInquiryStatus() + "</b></span>");
                                                }
                                            } else {
                                                out.println(style + "<b>" + inquiryList.get(i).getInquiryStatus() + "</b></span>");
                                            }
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println("<div class='modal-container'>");
                                            out.println("<button type='button' title='See response' class='btn btn-info btn-flex' data-toggle='modal' data-target='#exampleModal" + (i+1) +"'><b><i class='fa-solid fa-message'></i></b></button>");
                                            if(inquiryList.get(i).getInquiryStatus().equals("Closed") == false) {
                                                out.println("<button type='submit' name='action'  title='Close' value='close' form='inquiry_form" + (i+1) + "' class='btn btn-danger btn-flex'><b><i class='fa-solid fa-xmark'></i></b></button>");
                                            } else {
                                                out.println("<button type='submit' name='action' title='Delete' value='delete' form='inquiry_form" + (i+1) + "' class='btn btn-danger btn-flex'><b><i class='fa-solid fa-trash'></i></b></button>");
                                            }
                                            out.println("</div>");
                                            out.println("</td>");
                                            out.println("</tr>");
                                        }
                                    } else {
                                       out.println("<tr class='no-register'><td colspan='7'>No active inquiries</td></tr>");
                                    }                                   
                                %>          
                            </tbody>
                        </table>
                    </div>
                </form>  
            </div>
        </div>        
        <div class='modal fade' id='createInquiryModal' tabindex='-1' role='dialog' aria-labelledby='createInquiryModalLabel' aria-hidden='true'>
            <div class='modal-dialog' role='document'>
                <div class='modal-content'>
                    <div class='modal-header'>
                        <h5 class='modal-title' id='createInquiryModalLabel'>Create Inquiry</h5>
                        <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
                    </div>                   
                    <div class='modal-body'>
                        <form action='../InquiryController' method='POST'>
                            <%
                                //Generate inquiry ID
                                String inquiryID = "";
                                String str = "";
                                int x = 0;
                                int min = 100000;
                                int max = 999990;
                                int status = 0;
                                int randomNum = ThreadLocalRandom.current().nextInt(min, max + 1);
                                for(int i = 0; i < 10000; i++) {
                                    x = randomNum;
                                    str = "INQ-" + x;
                                    status = InquiryDAO.findInquiryIDByString(str);
                                    if(status == 0) {                   
                                        inquiryID = str;
                                        break;
                                    }
                                } 
                            %>
                            <label><b>Inquiry ID</b></label><br>
                            <input type='text' disabled value="<%=inquiryID%>"><br><br>
                            <input type="hidden" name="inquiryID_create" value="<%=inquiryID%>"/>
                            <label><b>Inquiry Type</b></label>
                            <select name='inquiryCategory_create' class='dropdown' id='inquiryTypeDropdown' onchange='display()'>
                                <option value='profile'>Request profile update</option>
                                <option value='ticket'>Request ticket update</option>
                                <option value='bugs'>Report Bugs</option>
                                <option value='movie'>Request Movie Addition</option>
                            </select>
                            <br><br>
                            <div id='profile' style='margin-top: 3px;'>
                                <label><b>Profile Details to be updated</b></label><br>
                                    <select class='dropdown' name='profileDropdown'>
                                        <option value='1' selected="selected">Name</option>
                                        <option value='2'>Email</option>
                                        <option value='3'>Password</option>
                                        <option value='4'>Phone Number</option>
                                    </select>
                                <br><br>
                            </div>
                            <div id='ticket' style='display: none; margin-top: 3px;'>
                                <label><b>Ticket Details to be updated</b></label><br>
                                    <select class='dropdown' name='ticketDropdown'>
                                        <option value='1' selected="selected">Seat</option>
                                        <option value='2'>Food</option>
                                        <option value='3'>Hall</option>
                                    </select>
                                <br><br>
                            </div>
                            <div id='bugs' style='display: none; margin-top: 3px;'>
                                <label><b>Bugs type</b></label><br>
                                    <select class='dropdown' name='bugsDropdown'>
                                        <option value='1' selected="selected">Missing payment details</option>
                                        <option value='2'>Typo</option>
                                        <option value='3'>Missing ticket details</option>
                                    </select>
                                <br><br>
                            </div>
                            <div id='movie' style='display: none; margin-top: 3px;'>
                                <label><b>Movie Genre</b></label><br>
                                    <select class='dropdown' name='movieDropdown'>
                                        <option value='1' selected="selected">Classic</option>
                                        <option value='2'>Horror</option>
                                        <option value='3'>Action</option>
                                        <option value='4'>Sports</option>
                                    </select>
                                <br><br>
                            </div>
                            <label><b>Inquiry Message</b></label><br>
                            <input type='text' name='inquiryMessage_create'>
                            <div class='modal-footer'>
                                <button type='submit' class='btn btn-success' name='action' value='add'>Save</button>
                                <button type='button' class='btn btn-danger' data-dismiss='modal'>Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>                       
        <!--Modal Box-->
            <%  
                for(int i = 0; i < inquiryList.size(); i++) {
                    out.println("<div  class='modal fade' id='exampleModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel" + (i+1) +"' aria-hidden='true'>");
                    out.println("<div class='modal-dialog' role='document'>");
                    out.println("<div class='modal-content'>");
                    out.println("<div class='modal-header'>");
                    out.println("<h5 class='modal-title' id='exampleModalLabel" + (i+1) +"'>Inquiry Details</h5>");
                    out.println("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                    out.println("<span aria-hidden='true'>&times;</span>");
                    out.println("</button>");
                    out.println("</div>");
                    out.println("<div class='modal-body'>");
                    out.println("<form action='../InquiryController' method='POST' id='response_inquiry_form" + (i+1) + "'>");
                    out.println("<label><b>Initial Inquiry</b></label>");
                    out.println("<input type='text' disabled placeholder='" + inquiryList.get(i).getInquiryMessage() + "'><br><br>");
                    out.println("<input type='hidden' name='txtInquiryID' form='response_inquiry_form" + (i+1) + "' value='" + inquiryList.get(i).getInquiryID()+ "'>");
                    out.println("<input type='hidden' name='userType' value='customer' form='response_inquiry_form" + (i+1) + "'/>");
                    out.println("<input type='hidden' name='userID' value='" + customer.getCustID() +"' form='response_inquiry_form" + (i+1) + "'/>");
                    inquiryResponseList = InquiryDAO.findListOfInquiryAnswerByInquiryID(inquiryList.get(i).getInquiryID());
                    
                    if(inquiryResponseList.size() > 0) {
                        for(int n = 0; n < inquiryResponseList.size(); n++) {
                            if(n%2 == 0) {
                                out.println("<label><b>Admin Response</b></label>");
                                out.println("<div>" + inquiryResponseList.get(n).getInquiryAnswer() + "</div>");
                            } else {
                                out.println("<div class='text-right mt-3'><b>You</b></div>");
                                out.println("<div class='text-right'>" + inquiryResponseList.get(n).getInquiryAnswer() + "</div>");
                            }
                        }
                        if(inquiryResponseList.size()%2 == 1) {
                            if(inquiryList.get(i).getInquiryStatus().equals("Closed") == false) {
                                out.println("<br><label><b>Your Response</b></label>");
                                out.println("<input type='text' required name='inquiryResponse' form='response_inquiry_form" + (i+1) + "'><br>");
                            }
                        }
                    } else {
                        out.println("<label><b>Inquiry Response</b></label>");
                        out.println("<p>No response is recorded yet</p><br>");
                    }
                    
                    if(inquiryList.get(i).getInquiryStatus().equals("Closed")) {
                        out.println("<br><div style='font-weight: bold;'>Inquiry has been closed. No response can be send or received</div><br>");
                    }
                    
                    out.println("</div><div class='modal-footer" + "'>");
                    if(inquiryList.get(i).getInquiryStatus().equals("Replied") == true && inquiryResponseList.size()%2 == 1) {
                        out.println("<button type='submit' name='action' value='save' class='btn btn-success' form='response_inquiry_form" + (i+1) + "'>Save</button>");
                    }
                    out.println("<button type='button' class='btn btn-danger' data-dismiss='modal'>Close</button>");
                    out.println("</div>");
                    out.println("</form>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("</div>");
                }
            %>
        <script>
            function display() {
                var e = document.getElementById("inquiryTypeDropdown");
                var index = e.selectedIndex;
                if(index === 0){
                    document.getElementById("profile").style.display = 'block';
                    document.getElementById("ticket").style.display = 'none';
                    document.getElementById("bugs").style.display = 'none';
                    document.getElementById("movie").style.display = 'none';
                }
                else if(index === 1){
                    document.getElementById("profile").style.display = 'none';
                    document.getElementById("ticket").style.display = 'block';
                    document.getElementById("bugs").style.display = 'none';
                    document.getElementById("movie").style.display = 'none';
                } else if(index === 2){
                    document.getElementById("profile").style.display = 'none';
                    document.getElementById("ticket").style.display = 'none';
                    document.getElementById("bugs").style.display = 'block';
                    document.getElementById("movie").style.display = 'none';
                } else if(index === 3){
                    document.getElementById("profile").style.display = 'none';
                    document.getElementById("ticket").style.display = 'none';
                    document.getElementById("bugs").style.display = 'none';
                    document.getElementById("movie").style.display = 'block';
                }
            }
        </script>
    </body>
</html>
