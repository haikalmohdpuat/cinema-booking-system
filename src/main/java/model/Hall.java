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
public class Hall implements Serializable {
    
    String hallID;
    String hallName;
    
    public Hall(String hallID) {
        this.hallID = hallID;
    }
    
    public Hall(String hallID, String hallName) {
        this.hallName = hallName;
    }

    public void setHallID(String hallID) {
        this.hallID = hallID;
    }

    public String getHallID() {
        return hallID;
    }   
    
    public String getHallName() {
        return hallName;
    }

    public void setHallName(String hallName) {
        this.hallName = hallName;
    }   
}
