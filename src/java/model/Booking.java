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
public class Booking implements Serializable {
    private String custID;
    private int ticketID;

    public Booking() {}

    public Booking(String custID, int ticketID) {
        this.custID = custID;
        this.ticketID = ticketID;
    }

    public void setCustID(String custID) {
        this.custID = custID;
    }

    public String getCustID() {
        return custID;
    }

    public void setTicketID(int ticketID) {
        this.ticketID = ticketID;
    }

    public int getTicketID() {
        return ticketID;
    }
}
