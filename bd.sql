-- Categories of products (e.g., main dishes, desserts)
CREATE TABLE categorie (
   id_categorie INT AUTO_INCREMENT,
   nom VARCHAR(50),
   couleur_css_hexadecimal varchar(10),
   PRIMARY KEY(id_categorie)
);

-- Subcategories of products (e.g., Ice Cream under Desserts)
CREATE TABLE sous_categorie (
   id_sous_categorie INT AUTO_INCREMENT,
   nom VARCHAR(50),
   id_categorie INT NOT NULL,
   couleur_css_hexadecimal varchar(10),
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
   couleur_css_hexadecimal varchar(10),
   id_sous_categorie INT NOT NULL,
   id_categorie INT NOT NULL,
   PRIMARY KEY(id_produit),
   FOREIGN KEY(id_sous_categorie) REFERENCES sous_categorie(id_sous_categorie),
   FOREIGN KEY(id_categorie) REFERENCES categorie(id_categorie)
);
CREATE TABLE user (
   id_user INT AUTO_INCREMENT,
   nom varchar(30),
   identifiant INT,
   PRIMARY KEY(id_user)
);
-- Orders (commande) placed by customers
CREATE TABLE commande (
   id_commande INT AUTO_INCREMENT,
   id_table_client INT NOT NULL,
   id_user INT NOT NULL,
   PRIMARY KEY(id_commande),
   UNIQUE(id_table_client),  
   FOREIGN KEY(id_table_client) REFERENCES table_client(id_table_client),
   Foreign KEY(id_user) REFERENCES user(id_user)
);




CREATE TABLE produits_supplements (
   id_produit INT,
   id_supplement INT,
   PRIMARY KEY(id_produit, id_supplement),
   FOREIGN KEY(id_produit) REFERENCES produit(id_produit),
   FOREIGN KEY(id_supplement) REFERENCES supplement(id_supplement)
);

CREATE TABLE commande_produit (
   id_produit INT,
   id_commande INT,
   quantity INT DEFAULT 1,  -- How many of the same product are ordered
   PRIMARY KEY(id_produit, id_commande),
   FOREIGN KEY(id_produit) REFERENCES produit(id_produit),
   FOREIGN KEY(id_commande) REFERENCES commande(id_commande)
);

CREATE TABLE commande_produit_supplement (
   id_commande INT,
   id_produit INT,
   id_supplement INT,
   PRIMARY KEY(id_commande, id_produit, id_supplement),
   FOREIGN KEY(id_commande) REFERENCES commande(id_commande),
   FOREIGN KEY(id_produit) REFERENCES produit(id_produit),
   FOREIGN KEY(id_supplement) REFERENCES supplement(id_supplement)
);
-- Comments about products
CREATE TABLE commentaire (
   id_commentaire INT AUTO_INCREMENT,
   contenu VARCHAR(100),
   id_produit INT NOT NULL,
   PRIMARY KEY(id_commentaire),
   UNIQUE(id_produit),
   FOREIGN KEY(id_produit) REFERENCES commande_produit(id_produit)
);



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






-- _____________________________________________________partie menu, waiter/serveur et table existente statique insertion___________________________________________
-- 1. Insert Categories
INSERT INTO categorie (nom) VALUES 
   ('Main Dishes'),
   ('Desserts'),
   ('Drinks');

-- 2. Insert Subcategories
INSERT INTO sous_categorie (nom, id_categorie) VALUES 
   ('Steak', 1),        -- Subcategory under 'Main Dishes'
   ('Pasta', 1),        -- Subcategory under 'Main Dishes'
   ('Ice Cream', 2),    -- Subcategory under 'Desserts'
   ('Cake', 2),         -- Subcategory under 'Desserts'
   ('Cocktails', 3),    -- Subcategory under 'Drinks'
   ('Soft Drinks', 3);  -- Subcategory under 'Drinks'

-- 3. Insert Supplements
INSERT INTO supplement (nom, prix) VALUES 
   ('Chocolate Chips', 0.50),
   ('Syrup', 0.30),
   ('Whipped Cream', 0.40),
   ('Cheese', 1.00);

-- 4. Insert Products
INSERT INTO produit (nom, prix, couleur_css_hexadecimal, id_sous_categorie, id_categorie) VALUES 
   ('Grilled Steak', 15.99, '#8B4513', 1, 1),  -- Main Dishes > Steak
   ('Spaghetti', 12.50, '#FF6347', 2, 1),      -- Main Dishes > Pasta
   ('Vanilla Ice Cream', 4.99, '#F5F5DC', 3, 2), -- Desserts > Ice Cream
   ('Chocolate Cake', 6.99, '#8B4513', 4, 2),    -- Desserts > Cake
   ('Mojito', 7.50, '#228B22', 5, 3),            -- Drinks > Cocktails
   ('Lemonade', 3.50, '#FFFF00', 6, 3);           -- Drinks > Soft Drinks

-- 5. Insert Users (barman or waiter)
INSERT INTO user ( identifiant) VALUES
   (101),  -- Barman
   (102);  -- Waiter

-- 6. Insert Tables
INSERT INTO table_client (id_table_client) VALUES 
   (1),
   (2),
   (3),
   (4),
   (5);



-- ___________________________logic métier___________________________________
-- example scénario, une commande est passé :

-- Une commande est placé à la table 1, le serveur 2 s'en occupe 
INSERT INTO commande (id_table_client, id_user)
VALUES (1, 2);  -- Table 1, serveur (id 2)

-- la commande est passé, chaque produit à associé à la commande via la table commande_produit, le champ quantité donne..................................... la quantité
-- ici, a la commande est associé un steak grillé attaché à la commande 1 avec une quantité de 1.
INSERT INTO commande_produit (id_produit, id_commande, quantity)
VALUES (1, 1, 1);  -- steak grillé (id 1), commande id 1, Quantity 1
-- même chose pour une glace
INSERT INTO commande_produit (id_produit, id_commande, quantity)
VALUES (3, 1, 1);  -- Vanilla Ice Cream (id 3), Order id 1, Quantity 1

-- Un produit donné peut avoir un supplement ou pas, chaque produit dans le contexte commande doit être tracké par rapport à ses supplements
-- La table commande_produit_supplement permet cela.
INSERT INTO commande_produit_supplement (id_commande, id_produit, id_supplement)
VALUES (1, 3, 1);  -- Order id 1, Vanilla Ice Cream (id 3), Supplement (Chocolate Chips, id 1)
-- ici on lie la glace à la vanille (id_3), à la commande 1 , avec le supplement 1 (id_1)

-- ici on récupère toute les commandes passé avec leur table correspondantes, leur serveur associé, leurs produit contenue et les supplément associé aux produits.
SELECT 
    commande.id_commande,
    commande.id_table_client,
    table_client.id_table_client AS table_number,
    user.id_user AS user_id,
    user.identifiant AS user_name,
    produit.id_produit,
    produit.nom AS product_name,
    commande_produit.quantity AS product_quantity,
    supplement.id_supplement,
    supplement.nom AS supplement_name,
    supplement.prix AS supplement_price
FROM 
    commande
JOIN 
    table_client ON commande.id_table_client = table_client.id_table_client
JOIN 
    user ON commande.id_user = user.id_user
JOIN 
    commande_produit ON commande.id_commande = commande_produit.id_commande
JOIN 
    produit ON commande_produit.id_produit = produit.id_produit
LEFT JOIN 
    commande_produit_supplement ON commande_produit.id_commande = commande_produit_supplement.id_commande 
    AND commande_produit.id_produit = commande_produit_supplement.id_produit
LEFT JOIN 
    supplement ON commande_produit_supplement.id_supplement = supplement.id_supplement
ORDER BY 
    commande.id_commande, produit.id_produit;

    
INSERT INTO user (nom, identifiant) 
VALUES ('John Doe', 101); 
