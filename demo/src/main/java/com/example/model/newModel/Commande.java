package com.example.model.newModel;

import java.util.List;

public class Commande {
    private int id;
    private TableClient tableClient;
    private User user;
    private List<Produit> products;
    private List<Supplement> supplements;

    public Commande(int id, TableClient tableClient, User user, List<Produit> products, List<Supplement> supplements) {
        this.id = id;
        this.tableClient = tableClient;
        this.user = user;
        this.products = products;
        this.supplements = supplements;
    }

    public int getId() {
        return id;
    }

    public TableClient getTableClient() {
        return tableClient;
    }

    public User getUser() {
        return user;
    }

    public List<Produit> getProducts() {
        return products;
    }

    public List<Supplement> getSupplements() {
        return supplements;
    }
}

