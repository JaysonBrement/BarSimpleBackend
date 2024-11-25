package com.example.model.newModel;

public class Produit {
    private int id;
    private String name;
    private double price;
    private String color;

    public Produit(int id, String name, double price, String color) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.color = color;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public String getColor() {
        return color;
    }
}

