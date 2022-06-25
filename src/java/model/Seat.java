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
public class Seat implements Serializable {
    
    private String seatID;
    private String ticketID;
    private String hall_ID;

    public Seat() {}

    public Seat(String seatID, String ticketID, String hall_ID) {
        this.seatID = seatID;
        this.ticketID = ticketID;
        this.hall_ID = hall_ID;
    }
    
    public Seat(String seatID) {
        this.seatID = seatID;
    }

    public String getSeatID() {
        return seatID;
    }

    public void setSeatID(String seatID) {
        this.seatID = seatID;
    }

    public String getTicketID() {
        return ticketID;
    }

    public void setTicketID(String ticketID) {
        this.ticketID = ticketID;
    }

    public String getHall_ID() {
        return hall_ID;
    }

    public void setHall_ID(String hall_ID) {
        this.hall_ID = hall_ID;
    }    
}
