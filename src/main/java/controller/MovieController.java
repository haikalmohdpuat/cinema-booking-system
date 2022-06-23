/*
Project    : CINEMA BOOKING SYSTEM @ CSE3999
Lecturer   : DR. NORAIDA BINTI HJ ALI
Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
 */
package controller;

import dao.MovieDAO;
import dao.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Movie;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class MovieController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action"); 
        
        switch (action) {
            case "add":
                addMovie(request, response);
                break;
            case "update":
                updateMovie(request, response);
                break;
            case "delete":
                deleteMovie(request, response);
                break;
        } 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(MovieController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(MovieController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void addMovie(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        
         PrintWriter out = response.getWriter();
         String id = request.getParameter("id");
         String name = request.getParameter("name");
         String genre = request.getParameter("genre");
         String date = request.getParameter("date");
         String time = request.getParameter("time");
         String language = request.getParameter("language");
         int duration = Integer.parseInt(request.getParameter("duration"));
         double price = Double.parseDouble(request.getParameter("price"));
            
         Movie movie = new Movie(id, name, genre, date, time, language, duration, price);
            
         int result = MovieDAO.add(movie);
            
         if (result>0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert(\"Success Add Movie\")");
                out.println("window.location.href = './Admin/admin-movie.jsp';");
                out.println("</script>");
         } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert(\"Failure in adding movie\")");
                out.println("window.location.href = './Admin/admin-movie.jsp';");
                out.println("</script>");
         }
    }

    private void updateMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        PrintWriter out = response.getWriter();        
        String movieID = request.getParameter("id");
        String movieName = request.getParameter("name");
        String movieGenre = request.getParameter("genre");
        String movieDate = request.getParameter("date");
        String movieTime = request.getParameter("time");
        String movieLanguage = request.getParameter("language");
        int movieDuration = Integer.parseInt(request.getParameter("duration"));
        Double moviePrice= Double.parseDouble(request.getParameter("price"));
           
        Movie movie = new Movie();
            
        movie.setMovieID(movieID);
        movie.setMovieName(movieName);
        movie.setMovieGenre(movieGenre);
        movie.setMovieDate(movieDate);
        movie.setMovieTime(movieTime);
        movie.setMovieLanguage(movieLanguage);
        movie.setMovieDuration(movieDuration);
        movie.setMoviePrice(moviePrice);
 
        int result  = MovieDAO.update(movie);
        int result2 = TicketDAO.update(movie); 
        if(result2 > 0)  {      
            if (result > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Success in updating Movie's Record\")");
                out.println("window.location.href = './Admin/admin-movie.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Failure in updating movie record\")");
                out.println("window.location.href = './Admin/admin-movie.jsp';");
                out.println("</script>");
            }
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Failure in updating ticket record\")");
            out.println("window.location.href = './Admin/admin-movie.jsp';");
            out.println("</script>");
        }
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter(); 
        String movieID = request.getParameter("movieCode");
        int status = 0;
        status = TicketDAO.findTicketIDByMovieID(movieID);

        if(status != 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"There are active tickets for this movie. Unable to delete the movie\")");
            out.println("window.location.href = './Admin/admin-movie.jsp';");
            out.println("</script>");
        } else {
            int result = MovieDAO.delete(movieID);
            if (result > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert(\"Success in deleting the movie\")");
                out.println("window.location.href = './Admin/admin-movie.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Failure in deleting Movie \")");
                out.println("window.location.href = './Admin/admin-movie.jsp';");
                out.println("</script>");
            } 
        } 
    }
}
