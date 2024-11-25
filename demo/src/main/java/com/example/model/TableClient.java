package com.example.model;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TableClient{
    private int id;
    private ObservableList<Commande> commandes;

    // Constructor
    public TableClient(int id) {
        this.id = id;
        this.commandes = FXCollections.observableArrayList();
        loadCommandesFromDatabase(id); 
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for commandes
    public ObservableList<Commande> getCommandes() {
        return commandes;
    }

    public void setCommandes(ObservableList<Commande> commandes) {
        this.commandes = commandes;
    }


    private void loadCommandesFromDatabase(int tableClientId) {
        Conn connection = Conn.getInstance();
        Connection conn = connection.getConnection();
        String query = "SELECT c.id_commande FROM commande c "
                     + "WHERE c.Id_table_client = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, tableClientId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int commandeId = rs.getInt("id_commande");
                Commande commande = new Commande(commandeId);
                commandes.add(commande);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static ObservableList<TableClient> getAllTableClients() {
        ObservableList<TableClient> tableClients = FXCollections.observableArrayList();
        Conn connection = Conn.getInstance();
        Connection conn = connection.getConnection();
    
        String query = "SELECT table_client.Id_table_client FROM table_client INNER JOIN commande on table_client.id_table_client = commande.Id_table_client"; 
    
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
    
            while (rs.next()) {
                int tableClientId = rs.getInt("Id_table_client");
                TableClient tableClient = new TableClient(tableClientId);
                tableClients.add(tableClient);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return tableClients;
    }
}
