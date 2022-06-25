<%-- 
    Document   : admin-update-movie
    Created on : 31 May 2022, 10:24:24 am
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="model.Movie"%>
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
                    <li  class="active"><a href="admin-movie.jsp"><i class="fa-solid fa-film"></i><span class="ml-2">Movie</span></a></li>
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
                    String movieID = request.getParameter("id");
                    Movie movie = MovieDAO.findMovieByMovieID(movieID);
                %>
                <div class="header">
                    <h2>UPDATE MOVIE DETAILS</h2>
                </div>
                <div class="flex-body">
                   <form id="updatemovie" action="../MovieController" method="get">
                        <div class="container mt-5 mb-5 d-flex justify-content-center">
                            <div class="card px-1 py-4">
                                <div class="card-body">
                                    <h6 class="card-title mb-3">Update the Movie</h6>
                                        <div class="input-group mb-3">
                                            <input type="hidden" class="form-control" id="id" name="id" value="<%=movie.getMovieID()%>"/>
                                        </div>
                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <label class="input-group-text text-dark" for="movieName">Movie Name</label>
                                            </div>
                                            <input type="text" class="form-control" id="name" name="name"value="<%=movie.getMovieName()%>">
                                        </div>
                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <label class="input-group-text text-dark" for="movieGenre">Movie Genre</label>
                                            </div>
                                            <select id="genreDropdown" class="form-control" name="genre" required="required">
                                                <option selected><%=movie.getMovieGenre()%></option>
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
                                            <input type="date" class="form-control" id="date" name="date">
                                        </div>
                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <label class="input-group-text text-dark" for="movieTime">Movie Time</label>
                                            </div>
                                            <input type="time" class="form-control" id="time" name="time" value="<%=movie.getMovieTime()%>">
                                        </div>
                                        <div class="input-group mb-3">
                                            <div class="input-group-prepend">
                                                <label class="input-group-text text-dark" for="movieLanguage">Movie Language</label>
                                            </div>
                                            <select id="languageDropdown" class="form-control" name="language" required="required">
                                                <option selected><%=movie.getMovieLanguage()%></option>
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
                                            <select id="durationDropdown" class="form-control" name="duration" required="required">
                                                <option selected><%=movie.getMovieDuration()%></option>
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
                                            <input type="number" class="form-control" id="price" min='10' max='50' name="price" value="<%=(int)movie.getMoviePrice()%>">
                                        </div>
                                    <br />
                                      <button class="btn btn-block confirm-button" name="action" value="update">Save</button>
                                      <button class="btn btn-block confirm-button" name="cancel" value="Cancel" onclick="window.location.href = 'admin-movie.jsp'; return false;">
                                      Cancel</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            //10/07/2022
            int length = movie.getMovieDate().length();
            String year = movie.getMovieDate().substring(length - 4);
            String month = movie.getMovieDate().substring(3, 5);
            String day = movie.getMovieDate().substring(0, 2);
            
            String date = year + "-" + month + "-" + day;
        %>
        <script>
            var e = document.getElementById("genreDropdown"); // get element of ID genre dropdown
            //Get the respective value of option in "select" tag
            var current = e.options[0].value;
            var val1 = e.options[1].value;
            var val2 = e.options[2].value;
            var val3 = e.options[3].value;
            var val4 = e.options[4].value;
            var val5 = e.options[5].value;
            var val6 = e.options[6].value;
            
            // Check if the current value (or current genre) is the same to the available genre
            // then remove the option to avoid redundant option
            if(current === val1) {
                e.remove(1);
            } else if (current === val2) {
                e.remove(2);
            } else if (current === val3) {
                e.remove(3);
            } else if (current === val4) {
                e.remove(4);
            } else if (current === val5) {
                e.remove(5);
            } else if (current === val6) {
                e.remove(6);
            }
            
            var l = document.getElementById("languageDropdown"); // get element of ID date dropdown
            //Get the respective value of option in "select" tag
            var currentLang = l.options[0].value;
            var val1 = l.options[1].value;
            var val2 = l.options[2].value;
            var val3 = l.options[3].value;
            var val4 = l.options[4].value;
            var val5 = l.options[5].value;
            var val6 = l.options[6].value;
            
            // Check if the current value (or current genre) is the same to the available genre
            // then remove the option to avoid redundant option
            if(currentLang === val1) {
                l.remove(1);
            } else if (currentLang === val2) {
                l.remove(2);
            } else if (currentLang === val3) {
                l.remove(3);
            } else if (currentLang === val4) {
                l.remove(4);
            } else if (currentLang === val5) {
                l.remove(5);
            } else if (currentLang === val6) {
                l.remove(6);
            }
            
            var d = document.getElementById("durationDropdown"); // get element of ID duration dropdown
            //Get the respective value of option in "select" tag
            var currentLang = d.options[0].value;
            var val1 = d.options[1].value;
            var val2 = d.options[2].value;
            var val3 = d.options[3].value;
            var val4 = d.options[4].value;
            
            // Check if the current value (or current genre) is the same to the available genre
            // then remove the option to avoid redundant option
            if(currentLang === val1) {
                d.remove(1);
            } else if (currentLang === val2) {
                d.remove(2);
            } else if (currentLang === val3) {
                d.remove(3);
            } else if (currentLang === val4) {
                d.remove(4);
            } 
            
            var date = document.getElementById("date"); // get element of ID date
            date.value = "<%=date%>";
        </script>
    </body>
</html>

