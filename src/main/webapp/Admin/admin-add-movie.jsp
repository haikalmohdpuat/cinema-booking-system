<%-- 
    Document   : admin-add-movie
    Created on : 31 May 2022, 12:06:12 am
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>
<%@page import="dao.MovieDAO"%>
<%@page import="model.Movie"%>
<%@page import="model.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.Serializable"%>
<jsp:include page="../Customer/bootstrap.jsp"/>
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cinema Booking System</title>
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
                width : 30%; /*adjust as needed*/
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
                    <li class="active"><a href="admin-movie.jsp"><i class="fa-solid fa-film"></i><span class="ml-2">Movie</span></a></li>
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
                    //Generate ticketID            
                    String movieID = "";
                    String str = "";
                    String randomStr = generateString(3);
                    int status = 0;

                    for(int i = 0; i < 10000; i++) {
                        str = "MOV-" + randomStr;
                        status = MovieDAO.findMovieIDByString(str);
                        if(status == 0) {                   
                            movieID = str;
                            break;
                        }
                    }           
                    //End generating ticketID
                %>
                <div class="header">
                  <h2>REGISTER NEW MOVIE</h2>
                </div>   
                <div class="flex-body">
                       <form id="MovieForm" action="../MovieController" method="POST">
                            <div class="container mt-5 mb-5 d-flex justify-content-center">
                                <div class="card px-1 py-4">
                                    <div class="card-body">
                                        <h6 class="card-title mb-3">Add Movie Form</h6>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text text-dark" for="movieID">Movie Code</label>
                                                </div>
                                                <input type="text" readonly class="form-control" id="id" value="<%=movieID%>">
                                                <input type="hidden" name="id" value="<%=movieID%>">
                                            </div>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text text-dark" for="movieName">Movie Name</label>
                                                </div>
                                                <input type="text" class="form-control" id="name" name="name"required="required">
                                            </div>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text text-dark" for="movieGenre">Movie Genre</label>
                                                </div>
                                                <select id="genre" class="form-control" name="genre" required="required">
                                                    <option>Horror</option>
                                                    <option>Sports</option>
                                                    <option>Romance</option>
                                                    <option>Comedy</option>
                                                    <option>Action</option>
                                                    <option>Fiction</option>
                                                </select>
                                            </div>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text text-dark" for="movieDate">Movie Date</label>
                                                </div>
                                                <input type="date" class="form-control" id="date" name="date"required="required">
                                            </div>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text text-dark" for="movieTime">Movie Time</label>
                                                </div>
                                                <input type="time" class="form-control" id="time" name="time"required="required">
                                            </div>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text text-dark" for="movieLanguage">Movie Language</label>
                                                </div>
                                                <select id="language" class="form-control" name="language" required="required">
                                                    <option>Bahasa Melayu</option>
                                                    <option>English</option>
                                                    <option>Mandarin</option>
                                                    <option>Tamil</option>
                                                    <option>Arabic</option>
                                                    <option>Indonesian</option>
                                                </select>
                                            </div>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text text-dark" for="duration">Duration (Hours)</label>
                                                </div>
                                                <select id="duration" class="form-control" name="duration" required="required">
                                                    <option>1</option>
                                                    <option>2</option>
                                                    <option>3</option>
                                                    <option>4</option>
                                                </select>
                                            </div>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text text-dark" for="price">Price</label>
                                                </div>
                                                <input type="number" step='1' min='10' max="50" class="form-control" id="price" name="price"required="required">
                                            </div>

                                        <br />
                                          <button class="btn btn-block confirm-button" type='submit' name="action" value="add">Save</button>
                                          <button class="btn btn-block confirm-button" name="cancel" value="Cancel" onclick="window.location.href = 'admin-movie.jsp'; return false;">
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
