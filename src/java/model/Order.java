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
 * @author Muhammad Haikal Aiman Bin Mohd Puat S59419
 */
public class Order implements Serializable {
    
    public int foodID;
    public String foodDetails;
    public int foodQuantity;
    public int pricePerFood;

    public Order() {}

    public Order(int foodID, int foodQuantity) {
        this.foodID = foodID;
        this.foodQuantity = foodQuantity;
    }
    
    public Order(String foodDetails, int foodQuantity, int pricePerFood) {
        this.foodDetails = foodDetails;
        this.pricePerFood = pricePerFood;
        this.foodQuantity = foodQuantity;
    }
  
    public int getFoodID() {
        return foodID;
    }

    public void setFoodID(int foodID) {
        this.foodID = foodID;
    }

    public String getFoodDetails() {
        return foodDetails;
    }

    public void setFoodDetails(String foodDetails) {
        this.foodDetails = foodDetails;
    }

    public int getFoodQuantity() {
        return foodQuantity;
    }

    public void setFoodQuantity(int foodQuantity) {
        this.foodQuantity = foodQuantity;
    }

    public int getPricePerFood() {
        return pricePerFood;
    }

    public void setPricePerFood(int pricePerFood) {
        this.pricePerFood = pricePerFood;
    }
}
