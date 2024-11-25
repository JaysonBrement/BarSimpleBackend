package com.example;

import java.io.IOException;

import com.example.model.Commande;
import com.example.model.Produit;
import com.example.model.TableClient;

import javafx.application.Application;
import javafx.collections.ObservableList;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Dialog;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class App extends Application {

    private static Scene scene;
    ObservableList<TableClient> commandes ;
    private static App instance;
    public App(){
       commandes = TableClient.getAllTableClients();
    }



    public static App getInstance(){
        if(instance == null){
            instance = new App();
        }
        return instance;
    }




    @Override
    public void start(Stage stage) throws IOException {
        scene = new Scene(loadFXML("primary"), 640, 480);
        stage.setScene(scene);
        stage.show();

        showStartupDialog(stage);
    }

    private void showStartupDialog(Stage stage) {
        Dialog<String> dialog = new Dialog<>();
        dialog.initOwner(stage);  


        Label label = new Label("Identifiant:");
        TextField textField = new TextField();  

        VBox vbox = new VBox(10, label, textField);
        dialog.getDialogPane().setContent(vbox);

        ButtonType buttonTypeOk = ButtonType.OK;
        dialog.getDialogPane().getButtonTypes().add(buttonTypeOk);

        dialog.setResultConverter(dialogButton -> {
            if (dialogButton == buttonTypeOk) {
                return textField.getText();
            }
            return null;
        });

        dialog.showAndWait().ifPresent(response -> {
           
            System.out.println("Nom de l'utilisateur : " + response);
        });
    }

    static void setRoot(String fxml) throws IOException {
        scene.setRoot(loadFXML(fxml));
    }

    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }

    
    
    
    public static void setInstance(App instance) {
        App.instance = instance;
    }
    
    
    
    public static void main(String[] args) {
        // launch();
        // System.out.println("");
        // App instance = getInstance();
        // System.out.println(instance.commandes.size());
        
        // Conn.connect();
        ObservableList<TableClient> tableClients = TableClient.getAllTableClients();
    
            for (TableClient tableClient : tableClients) {
                System.out.println("TableClient ID: " + tableClient.getId());
    
                for (Commande commande : tableClient.getCommandes()) {
                    System.out.println("  Commande ID: " + commande.getId());
    
                    for (Produit produit : commande.getProduit()) {
                        System.out.println("    Produit: " + produit.getNom() + " | Price: " + produit.getPrix());
                    }
                }
                
            }
    }

    
    
}





