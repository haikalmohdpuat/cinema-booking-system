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
public class Payment implements Serializable {
    
    private int paymentID;
    private int paymentAmount;
    private int currentBalance;
    private String paymentStatus;
    private String custID;
    private String ticketID;

    public Payment() {}

    public Payment(int paymentID, String custID, String ticketID, String paymentStatus, int paymentAmount, int currentBalance) {
        this.paymentID = paymentID;
        this.custID = custID;
        this.paymentStatus = paymentStatus;
        this.paymentAmount = paymentAmount;
        this.ticketID = ticketID;
        this.currentBalance = currentBalance;
    }
    
    public Payment(String custID, String ticketID, String paymentStatus, int paymentAmount, int currentBalance) {
        this.custID = custID;
        this.paymentStatus = paymentStatus;
        this.paymentAmount = paymentAmount;
        this.ticketID = ticketID;
        this.currentBalance = currentBalance;
    }

    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public int getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(int paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public String getTicketID() {
        return ticketID;
    }

    public void setTicketID(String ticketID) {
        this.ticketID = ticketID;
    }

    public void setCustID(String custID) {
        this.custID = custID;
    }

    public String getCustID() {
        return custID;
    }

    public void setCurrentBalance(int currentBalance) {
        this.currentBalance = currentBalance;
    }

    public int getCurrentBalance() {
        return currentBalance;
    } 
}
