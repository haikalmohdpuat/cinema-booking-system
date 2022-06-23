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

<%@page import="dao.MovieDAO"%>
<%@page import="model.Movie"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Movie Page</title>
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
                width: 65px;
            }
            
            .btn-inquiry {
                padding: 10px;
                background: #BF40BF;
                margin-bottom: 30px;
            }
            
            .btn-inquiry:hover {
                background: #800080;
            }
            
            .card-container {
                margin-top: -20px;
            }
            
            @media (max-width: 800px) {
                .card-container {
                    width: 400px;
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
                    <li><a href="admin-homepage.jsp"><i class="fa-solid fa-house"></i><span class="ml-2">Home</span></a></li>
                    <li class="active"><a href="#"><i class="fa-solid fa-film"></i><span class="ml-2">Movie</span></a></li>
                    <li><a href="admin-ticket.jsp"><i class="fa-solid fa-ticket"></i><span class="ml-2">Tickets</span></a></li>
                    <li><a href="admin-inquiry.jsp"><i class="fa-solid fa-question"></i><span class="ml-3">Inquiry</span></a></li>
                    <li><a href="admin-ticket.jsp"><i class="fa-solid fa-chart-column"></i><span class="ml-2">Statistic</span></a></li>
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
                <div class='flex-body'>
                    <div class="card-container">        
                        <%
                            List<Movie> movieList = new ArrayList<>();
                            movieList = MovieDAO.findAllMovies();

                            for(int i = 0; i < movieList.size(); i++) {
                                out.print("<form action='../MovieController' method='POST' id='my_form" + (i + 1) + "'></form>");
                            }
                        %>
                        <button type="button" onclick="window.location.href = 'admin-add-movie.jsp'; return false;" class="btn btn-info btn-sm btn-flex btn-inquiry" value="Add Movie"><b>Add Movie      </b><i class="fa-solid fa-plus"></i></button>
                        <br>
                        <div class="card-body">
                            <h5 class="card-header">Movie List</h5>
                                <table class="table table-striped table-dark">
                                    <thead class="thead-dark">
                                        <tr>
                                        <th scope="col">NO</th>
                                        <th scope="col">MOVIE CODE</th>
                                        <th scope="col">MOVIE NAME</th>
                                        <th scope="col">MOVIE DATE</th>
                                        <th scope="col">MOVIE TIME</th>
                                        <th scope="col" style="text-align: center;">ACTION</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                         if(movieList.size() > 0) {
                                            for(int i = 0; i < movieList.size(); i++) {
                                                out.print("<tr>");
                                                out.print("<td>");
                                                out.print("<input type='hidden' name='movieNo' form='my_form" + (i+1) + "' value='" + (i+1) + "'/>");
                                                out.print("<scope='row'>" + (i + 1) + "</td>");
                                                out.print("</td>"); 
                                                out.print("<td>");
                                                out.print("<input type='hidden' name='movieCode' form='my_form" + (i+1) + "' value='" + movieList.get(i).getMovieID() + "'/>");
                                                out.print(movieList.get(i).getMovieID());
                                                out.print("</td>");
                                                out.print("<td>");
                                                out.print("<input type='hidden' name='movieName' form='my_form" + (i+1) + "' value='" + movieList.get(i).getMovieName()+ "'/>");
                                                out.print(movieList.get(i).getMovieName());
                                                out.print("</td>");
                                                out.print("<td>");
                                                out.print("<input type='hidden' name='movieDate' form='my_form" + (i+1) + "' value='" + movieList.get(i).getMovieDate()+ "'/>");
                                                out.print(movieList.get(i).getMovieDate());
                                                out.print("</td>");
                                                out.print("<td>");
                                                
                                                //Generate time in 12H format
                                                String timePc = movieList.get(i).getMovieTime();
                                                int hourOfDay = Integer.parseInt(timePc.substring(0, 2));
                                                int minute = Integer.parseInt(timePc.substring(timePc.length() - 2));
                                                String currentTime = 
                                                (((hourOfDay % 12 == 0) ? "12" : ((hourOfDay % 12) > 9 ? 
                                                (hourOfDay % 12) : "0" + (hourOfDay % 12))) + ":"
                                                + ((minute > 9) ? minute : ("0" + minute)) + " "
                                                + ((hourOfDay >= 12) ? "PM" : "AM"));
                                                //End generating time in 12H format
                                                
                                                out.print("<input type='hidden' name='movieTime' form='my_form" + (i+1) + "' value='" + movieList.get(i).getMovieTime()+ "'/>");
                                                out.print(currentTime);
                                                out.print("</td>");
                                                out.print("<td>");
                                                out.print("<div class='modal-container'>");
                                                out.print("<button type='button' class='btn btn-info btn-sm btn-flex' data-toggle='modal' data-target='#exampleModal" + (i+1) +"'><b>Details</b></button>");
                                                out.print("<button type='submit' onclick=\"window.location.href = 'admin-update-movie.jsp?id="+ movieList.get(i).getMovieID() + "'; return false;\" class='btn btn-success btn-sm btn-flex btn-edit'><b>Edit</b></button>");
                                                out.print("<button type='submit' name='action' value='delete' form='my_form" + (i+1) + "' class='btn btn-danger btn-sm btn-flex'><b>Delete</b></button>");
                                                out.print("</div>");
                                                out.print("</td>");
                                                out.print("</tr>");
                                           }
                                         } else {
                                          out.print("<tr class='no-register'><td colspan='6'>No registered movie</td></tr>");
                                         }                                 
                                        %>                           
                                    </tbody>
                               </table>
                            </div>
                        </div>
                    </div>                      
                    <!--Modal Box-->
                    <%
                        for(int i = 0; i < movieList.size(); i++) {
                            out.print("<div  class='modal fade' id='exampleModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel" + (i+1) +"' aria-hidden='true'>");
                            out.print("<div class='modal-dialog' role='document'>");
                            out.print("<div class='modal-content'>");
                            out.print("<div class='modal-header'>");
                            out.print("<h5 class='modal-title' id='exampleModalLabel" + (i+1) +"'>Movie Details</h5>");
                            out.print("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                            out.print("<span aria-hidden='true'>&times;</span>");
                            out.print("</button>");
                            out.print("</div>");
                            out.print("<div class='modal-body'>");
                            out.print("<label><b>Movie ID</b></label>");
                            out.print("<input type='text' disabled placeholder='" + movieList.get(i).getMovieID()+ "'><br>");
                            out.print("<label><b>Movie Name</b></label>");
                            out.print("<input type='text' disabled placeholder='" + movieList.get(i).getMovieName()+ "'><br>");
                            out.print("<label><b>Movie Genre</b></label>");
                            out.print("<input type='text' disabled placeholder='" + movieList.get(i).getMovieGenre()+ "'><br>");
                            out.print("<label><b>Movie Language</b></label>");
                            out.print("<input type='text' disabled placeholder='" + movieList.get(i).getMovieLanguage()+ "'><br>");
                            out.print("<label><b>Movie Price</b></label>");
                            out.print("<input type='text' disabled placeholder='RM " + movieList.get(i).getMoviePrice()+ "'><br>");
                            out.print("<label><b>Movie Duration</b></label>");
                            out.print("<input type='text' disabled placeholder='" + movieList.get(i).getMovieDuration()+ " hours'><br>");
                            out.print("</div>");
                            out.print("<div class='modal-footer" + "'>");
                            out.print("<button type='button' class='btn btn-info' data-dismiss='modal'>Close</button>");
                            out.print("</div>");
                            out.print("</div>");
                            out.print("</div>");
                            out.print("</div>");
                        }
                    %>
            </div>
        </div>
    </body>
</html>
