package com.example.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conn {
    private static final String URL = "jdbc:mysql://localhost:3306/Bar";
    private static final String USER = "root"; 
    private static final String PASSWORD = "test"; 
    private static Conn instance;  
    private Connection connection; 

    private Conn() {
        try {
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connection established successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Conn getInstance() {
        if (instance == null) {
            instance = new Conn();
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
}
