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
public class Inquiry implements Serializable {
    
    private String inquiryID;
    private String inquiryCategory;
    private String inquirySubCategory;
    private String inquiryMessage;
    private String inquiryStatus;
    private String custID;
    private String userID;
    private String inquiryAnswer;

    public Inquiry() {}

    public Inquiry(String inquiryID, String userID, String inquiryAnswer) {
        this.inquiryID = inquiryID;
        this.userID = userID;
        this.inquiryAnswer = inquiryAnswer;
    }
    
    public Inquiry(String inquiryID, String custID, String inquiryCategory, String inquirySubCategory, String inquiryMessage, String inquiryStatus) {
        this.inquiryID = inquiryID;
        this.inquiryCategory = inquiryCategory;
        this.inquirySubCategory = inquirySubCategory;
        this.inquiryMessage = inquiryMessage;
        this.inquiryStatus = inquiryStatus;
        this.custID = custID;
    }

    public String getInquiryID() {
        return inquiryID;
    }

    public void setInquiryID(String inquiryID) {
        this.inquiryID = inquiryID;
    }

    public String getInquiryCategory() {
        return inquiryCategory;
    }

    public void setInquiryCategory(String inquiryCategory) {
        this.inquiryCategory = inquiryCategory;
    }

    public String getInquiryMessage() {
        return inquiryMessage;
    }

    public void setInquiryMessage(String inquiryMessage) {
        this.inquiryMessage = inquiryMessage;
    }

    public String getCustID() {
        return custID;
    }

    public void setCustID(String custID) {
        this.custID = custID;
    }

    public void setInquiryStatus(String inquiryStatus) {
        this.inquiryStatus = inquiryStatus;
    }

    public String getInquiryStatus() {
        return inquiryStatus;
    }

    public void setInquirySubCategory(String inquirySubCategory) {
        this.inquirySubCategory = inquirySubCategory;
    }

    public String getInquirySubCategory() {
        return inquirySubCategory;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getInquiryAnswer() {
        return inquiryAnswer;
    }

    public void setInquiryAnswer(String inquiryAnswer) {
        this.inquiryAnswer = inquiryAnswer;
    }
}
