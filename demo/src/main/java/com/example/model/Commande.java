package com.example.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

public class Commande {
    private int id;
    private ObservableList<Produit> produit;
    public Commande(int id) {
        this.id = id;
        this.produit = FXCollections.observableArrayList();
        loadProduitsFromDatabase(id);
    }

    
    public int getId() {
        return id;
    }


    public void setId(int id) {
        this.id = id;
    }


    public ObservableList<Produit> getProduit() {
        return produit;
    }


    public void setProduit(ObservableList<Produit> produit) {
        this.produit = produit;
    }


    private void loadProduitsFromDatabase(int commandeId) {
        Conn connection = Conn.getInstance();
        Connection conn = connection.getConnection();
        String query = "SELECT c.id_commande, p.id_produit, p.nom, p.prix "
                     + "FROM commande c "
                     + "INNER JOIN commande_produit cp ON c.id_commande = cp.id_commande "
                     + "INNER JOIN produit p ON cp.id_produit = p.id_Produit "
                     + "WHERE c.id_commande = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, commandeId); 
            ResultSet rs = stmt.executeQuery(); 

            while (rs.next()) {
                String nomProduit = rs.getString("nom");
                double prixProduit = rs.getDouble("prix");


                Produit produitItem = new Produit(nomProduit, prixProduit);
                produit.add(produitItem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ObservableList<Commande> getAllCommandes() {
        ObservableList<Commande> commandes = FXCollections.observableArrayList();
        Conn connection = Conn.getInstance();
        Connection conn = connection.getConnection();
    
        String query = "SELECT id_commande FROM commande";
    
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) { 
    

            while (rs.next()) {
                int commandeId = rs.getInt("id_commande");
    
                Commande commande = new Commande(commandeId);
    

                commandes.add(commande);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return commandes;
    }

    public static void getCommande(int id){
        Commande commande = new Commande(id);

 
        System.out.println("Commande ID: " + commande.getId());
        System.out.println("Produits:");


        for (Produit produit : commande.getProduit()) {
            System.out.println(produit);
        }
    }
    public static void getCommandes() {
        ObservableList<Commande> commandes = Commande.getAllCommandes();
    
        for (Commande commande : commandes) {
            System.out.println("Commande ID: " + commande.getId()); 
            System.out.println("Produits:");

            for (Produit produit : commande.getProduit()) {
                System.out.println(produit);
            }
    
            System.out.println();
        }
    }
}
    
    

