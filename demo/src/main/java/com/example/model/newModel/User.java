package com.example.model.newModel;

public class User {
    private int id;
    private String name;
    private int identifier;

    public User(int id, String name, int identifier) {
        this.id = id;
        this.name = name;
        this.identifier = identifier;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getIdentifier() {
        return identifier;
    }
}
