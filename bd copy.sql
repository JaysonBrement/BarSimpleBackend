-- Categories of products (e.g., main dishes, desserts)
CREATE TABLE categorie (
   id_categorie INT AUTO_INCREMENT,
   nom VARCHAR(50),
   couleur_css_hexadecimal VARCHAR(10),
   PRIMARY KEY(id_categorie)
);

-- Subcategories of products (e.g., Ice Cream under Desserts)
CREATE TABLE sous_categorie (
   id_sous_categorie INT AUTO_INCREMENT,
   nom VARCHAR(50),
   id_categorie INT NOT NULL,
   couleur_css_hexadecimal VARCHAR(10),
   PRIMARY KEY(id_sous_categorie),
   FOREIGN KEY(id_categorie) REFERENCES categorie(id_categorie)
);

-- Supplements available for products (e.g., Chocolate Chips, Syrup)
CREATE TABLE supplement (
   id_supplement INT AUTO_INCREMENT,
   nom VARCHAR(30),
   prix DECIMAL(5,2),
   PRIMARY KEY(id_supplement)
);

-- Tables assigned to customers
CREATE TABLE table_client (
   id_table_client INT AUTO_INCREMENT,
   PRIMARY KEY(id_table_client)
);

-- Products on the menu
CREATE TABLE produit (
   id_produit INT AUTO_INCREMENT,
   nom VARCHAR(30),
   prix DECIMAL(6,2),
   couleur_css_hexadecimal VARCHAR(10),
   id_sous_categorie INT NOT NULL,
   id_categorie INT NOT NULL,
   PRIMARY KEY(id_produit),
   FOREIGN KEY(id_sous_categorie) REFERENCES sous_categorie(id_sous_categorie),
   FOREIGN KEY(id_categorie) REFERENCES categorie(id_categorie)
);

-- Users (e.g., Staff, Admin, or Customer)
CREATE TABLE user (
   id_user INT AUTO_INCREMENT,
   nom VARCHAR(30),
   identifiant INT,  -- Renamed for clarity
   PRIMARY KEY(id_user)
);

-- Orders (commande) placed by customers
CREATE TABLE commande (
   id_commande INT AUTO_INCREMENT,
   id_table_client INT NOT NULL,
   id_user INT NOT NULL,
   PRIMARY KEY(id_commande),
   FOREIGN KEY(id_table_client) REFERENCES table_client(id_table_client),
   FOREIGN KEY(id_user) REFERENCES user(id_user)
);


CREATE TABLE commande_produit_supplement (
   id_commande_produit INT,
   id_commande INT,
   id_produit INT,
   id_supplement INT,
   PRIMARY KEY(id_commande_produit),
   FOREIGN KEY(id_commande) REFERENCES commande(id_commande),
   FOREIGN KEY(id_produit) REFERENCES produit(id_produit),
   FOREIGN KEY(id_supplement) REFERENCES produit_supplement(id_supplement)
);

CREATE TABLE produit_supplement (
   id_produit INT,
   id_supplement INT
   FOREIGN KEY 
)






-- _____________________________________commande context___________________________________________________________
-- Trouver tout les suppléments pour un produit particulier dans un contexe commande
SELECT * FROM commande_produit_supplement WHERE id_commande = <id de la commande> AND id_produit = <id du produit>;


-- Trouver tout les produits avec leurs supplements pour une commande particulière

SELECT
    p.nom AS product_name,
    cp.quantity AS quantity,
    s.nom AS supplement_name,
    cp_supp.id_supplement AS supplement_id
FROM
    commande c
JOIN
    commande_produit cp ON c.id_commande = cp.id_commande
JOIN
    produit p ON cp.id_produit = p.id_produit
LEFT JOIN
    commande_produit_supplement cp_supp ON cp.id_commande = cp_supp.id_commande AND cp.id_produit = cp_supp.id_produit
LEFT JOIN
    supplement s ON cp_supp.id_supplement = s.id_supplement
WHERE
    c.id_commande = <id de la commande>;






-- Insert categories
INSERT INTO categorie (nom, couleur_css_hexadecimal) VALUES
('Main Dishes', '#FF5733'),
('Desserts', '#C70039');

-- Insert subcategories for "Main Dishes"
INSERT INTO sous_categorie (nom, id_categorie, couleur_css_hexadecimal) VALUES
('Pizza', 1, '#900C3F'),
('Pasta', 1, '#581845');

-- Insert subcategories for "Desserts"
INSERT INTO sous_categorie (nom, id_categorie, couleur_css_hexadecimal) VALUES
('Ice Cream', 2, '#F1C40F'),
('Cake', 2, '#8E44AD');

-- Insert products under "Pizza" (Main Dishes -> Pizza)
INSERT INTO produit (nom, prix, couleur_css_hexadecimal, id_sous_categorie, id_categorie) VALUES
('Margherita Pizza', 9.99, '#FFC300', 1, 1),
('Pepperoni Pizza', 11.99, '#FF5733', 1, 1);

-- Insert products under "Pasta" (Main Dishes -> Pasta)
INSERT INTO produit (nom, prix, couleur_css_hexadecimal, id_sous_categorie, id_categorie) VALUES
('Spaghetti Bolognese', 12.99, '#C0392B', 2, 1),
('Carbonara', 13.99, '#D35400', 2, 1);

-- Insert products under "Ice Cream" (Desserts -> Ice Cream)
INSERT INTO produit (nom, prix, couleur_css_hexadecimal, id_sous_categorie, id_categorie) VALUES
('Vanilla Ice Cream', 4.99, '#F39C12', 3, 2),
('Chocolate Ice Cream', 5.99, '#8E44AD', 3, 2);

-- Insert products under "Cake" (Desserts -> Cake)
INSERT INTO produit (nom, prix, couleur_css_hexadecimal, id_sous_categorie, id_categorie) VALUES
('Chocolate Cake', 6.99, '#9B59B6', 4, 2),
('Cheesecake', 7.99, '#2980B9', 4, 2);

-- Insert supplements
INSERT INTO supplement (nom, prix) VALUES
('Extra Cheese', 1.50),
('Olives', 1.00),
('Syrup', 0.75),
('Chocolate Chips', 1.20);

INSERT INTO user (nom, identifiant) VALUES ('John Doe', 1);
INSERT INTO table_client () VALUES ();  -- Auto-increment ID
