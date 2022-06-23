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
public class Ticket implements Serializable {
    
    private String ticketID;
    private String movieID;
    private String custID;
    private String ticketDate;
    private String ticketTime;
    private String ticketType;

    public Ticket() {}
    
    public Ticket(String ticketID) {
        this.ticketID = ticketID;
    }
    
    public Ticket(String ticketID, String movieID, String custID, String ticketDate, String ticketTime, String ticketType) {
        
        this.ticketID = ticketID;
        this.movieID = movieID;
        this.custID = custID;
        this.ticketDate = ticketDate;
        this.ticketType = ticketType;
        this.ticketTime = ticketTime;
    }
    
    public Ticket(String movieID, String custID, String ticketDate, String ticketTime, String ticketType) {
        this.movieID = movieID;
        this.custID = custID;
        this.ticketDate = ticketDate;
        this.ticketType = ticketType;
        this.ticketTime = ticketTime;
    }

    public void setTicketID(String ticketID) {
        this.ticketID = ticketID;
    }

    public String getTicketID() {
        return ticketID;
    }
    
    public String getMovieID() {
        return movieID;
    }

    public void setMovieID(String movieID) {
        this.movieID = movieID;
    }

    public String getCustID() {
        return custID;
    }

    public void setCustID(String custID) {
        this.custID = custID;
    }

    public String getTicketDate() {
        return ticketDate;
    }

    public void setTicketDate(String ticketDate) {
        this.ticketDate = ticketDate;
    }

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public void setTicketTime(String ticketTime) {
        this.ticketTime = ticketTime;
    }

    public String getTicketTime() {
        return ticketTime;
    }
}
