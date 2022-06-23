/*
Project    : CINEMA BOOKING SYSTEM @ CSE3999
Lecturer   : DR. NORAIDA BINTI HJ ALI
Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
 */
package model;

import java.io.Serializable;

/**
 *
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class Movie implements Serializable {
     
     private String movieID;
     private String movieName;
     private String movieGenre;
     private String movieDate;
     private String movieTime;
     private String movieLanguage;
     private int movieDuration;
     private double moviePrice;

    public Movie() {
    }

    public Movie(String movieID, String movieName, String movieGenre, String movieDate, String movieTime, String movieLanguage, int movieDuration, double moviePrice) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.movieGenre = movieGenre;
        this.movieLanguage = movieLanguage;
        this.movieDate = movieDate;
        this.movieTime = movieTime;
        this.movieDuration = movieDuration;
        this.moviePrice = moviePrice;
    }
     
    public String getMovieID() {
        return movieID;
    }

    public void setMovieID(String movieID) {
        this.movieID = movieID;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getMovieGenre() {
        return movieGenre;
    }

    public void setMovieGenre(String movieGenre) {
        this.movieGenre = movieGenre;
    }

    public String getMovieLanguage() {
        return movieLanguage;
    }

    public void setMovieLanguage(String movieLanguage) {
        this.movieLanguage = movieLanguage;
    }

    public void setMovieDate(String movieDate) {
        this.movieDate = movieDate;
    }

    public String getMovieDate() {
        return movieDate;
    }

    public void setMovieTime(String movieTime) {
        this.movieTime = movieTime;
    }

    public String getMovieTime() {
        return movieTime;
    }

    public int getMovieDuration() {
        return movieDuration;
    }

    public void setMovieDuration(int movieDuration) {
        this.movieDuration = movieDuration;
    }

    public double getMoviePrice() {
        return moviePrice;
    }

    public void setMoviePrice(double moviePrice) {
        this.moviePrice = moviePrice;
    } 
}
