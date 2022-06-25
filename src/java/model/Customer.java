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
public class Customer implements Serializable {
    
    private String custID;
    private String custName;
    private String custEmail;
    private String custPassword;
    private int custBalance;
    private String custMobileNumber;
   
    public Customer() {}

    public Customer(String custID, String custName, String custEmail, String custPassword, int custBalance, String custMobileNumber) {
        this.custID = custID;
        this.custName = custName;
        this.custEmail = custEmail;
        this.custPassword = custPassword;
        this.custBalance = custBalance;
        this.custMobileNumber = custMobileNumber;
    }  

    public String getCustMobileNumber() {
        return custMobileNumber;
    }

    public void setCustMobileNumber(String custMobileNumber) {
        this.custMobileNumber = custMobileNumber;
    }
    
    public String getCustID() {
        return custID;
    }

    public void setCustID(String custID) {
        this.custID = custID;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public String getCustEmail() {
        return custEmail;
    }

    public void setCustEmail(String custEmail) {
        this.custEmail = custEmail;
    }

    public String getCustPassword() {
        return custPassword;
    }

    public void setCustPassword(String custPassword) {
        this.custPassword = custPassword;
    }

    public int getCustBalance() {
        return custBalance;
    }

    public void setCustBalance(int custBalance) {
        this.custBalance = custBalance;
    }  
}
