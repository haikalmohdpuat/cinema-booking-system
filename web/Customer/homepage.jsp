<%-- 
    Document   : homepage
    Created on : 22 Apr 2022, 9:57:36 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="dao.MovieDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Movie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.Serializable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="bootstrap.jsp"/>
<jsp:include page="customer-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Homepage</title>
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
            
            .card-container {
                width: 1150px;
            }
            
            @media (max-width: 800px) {
                .card-container {
                    width: 400px;
                }
                
                #nav_home {
                    border-radius: 0%;
                }
            }
        </style>
    </head>
    <body>
    <div class='flex-body'>
        <div class="card-container mt-5">        
        <%
            List<Movie> movieList = new ArrayList<>();

            //Retrieve list of current movies from table movie in database
            movieList = MovieDAO.findAllMovies();
            for(int i = 0; i < movieList.size(); i++) {
                out.print("<form action='../BookingController' method='POST' id='my_form" + (i + 1) + "'></form>");
            }
        %>
                <div class="card-body">
                    <h5 class="card-header">Movie List</h5>
                        <table class="table table-striped table-dark w-auto">
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
                                        
                                        String time = movieList.get(i).getMovieTime();
                                        int hourOfDay = Integer.parseInt(time.substring(0, 2));
                                        int minute = Integer.parseInt(time.substring(time.length() - 2));
                                        String currentTime = 
                                        
                                        //Check if the hour produce remainder of 0 if divided by 12...if yes then hour is 12
                                        //If not check if the remainder is more than 9 when divided by 12 
                                        (((hourOfDay % 12 == 0) ? "12" : ((hourOfDay % 12) > 9 ? 
                                        
                                        //If yes(more than 9) then, hour value in 12H format is the remainder when hour is divided by 12
                                        //If not(less or equal 9( then, hour value in 12H format is the remainder when hour is divided by 12 plus "0" upfront
                                        (hourOfDay % 12) : "0" + (hourOfDay % 12))) + ":"
                                        
                                        //Check if minute are more than 9
                                        //If yes than to be printed minute value is current minute value
                                        //Else the value will be current minute value plus "0" upfront
                                        + ((minute > 9) ? minute : ("0" + minute)) + " "
                                        
                                        //Check if hour is more than 12
                                        //If yes then PM or else AM
                                        + ((hourOfDay >= 12) ? "PM" : "AM"));                                       
                                                  
                                        out.print("<input type='hidden' name='movieTime' form='my_form" + (i+1) + "' value='" + movieList.get(i).getMovieTime()+ "'/>");
                                        out.print(currentTime);
                                        out.print("</td>");
                                        out.print("<td>");
                                        out.print("<div class='modal-container'>");
                                        out.print("<button type='button' class='btn btn-info btn-sm btn-flex' data-toggle='modal' data-target='#exampleModal" + (i+1) +"'><b>Details</b></button>");
                                        out.print("<button type='submit' name='action' value='createForm' form='my_form" + (i+1) + "' class='btn btn-success btn-sm btn-flex'><b>Book</b></button>");
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
                    out.print("<input type='text' disabled placeholder='" + movieList.get(i).getMoviePrice()+ "'><br>");
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
    </body>
</html>
