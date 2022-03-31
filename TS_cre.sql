-- Fichier de creation de tables et domaines

------------------------
-- Creation des domaines
------------------------
CREATE DOMAIN Cuvee_id
  -- id_cuvee
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z0-9]{8}');

CREATE DOMAIN Responsable_id
  -- id_responsable
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN NoSerie_id
  -- id_no serie
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{8}');

CREATE DOMAIN Modele_equip_id
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN Capteur_id
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN Capteur_Type
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN NoRecette
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN Etape_id
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN Action_id
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN Mesure_id
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN UniteType
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN frequenceType
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN seuilType
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN Ingredient_id
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN nom_type
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN NoLot_type
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN Fournisseur_id
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE DOMAIN Adresse_type
  -- id_modele d'equipement
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');


---------------------
--Creation des tables
---------------------
CREATE TABLE Cuvee
  -- Répertoire des Cuvee.
(
  idCuvee     Cuvee_id       NOT NULL, -- identifiant unique de chaque cuvee
  Responsable Responsable_id NOT NULL, -- identifiant unique du responsable de la cuvee
  debut       TIMESTAMP      NOT NULL, -- date et heure du debut du processus
  fin         TIMESTAMP      NOT NULL, -- date et heure de la fin du processus

  CONSTRAINT Cuvee_cc0 PRIMARY KEY (idCuvee)
);

CREATE TABLE Equipement
  -- Répertoire des equipements.
(
  noSerieE    NoSerie_id    NOT NULL, -- Un numero de série attribué à un équipement pour le différencier
  description TEXT          NOT NULL, -- Description de l’équipement

  CONSTRAINT Equipement_cc0 PRIMARY KEY (noSerieE)
);

CREATE TABLE EquipementType
  -- Répertoire des types d'equipements.
(
  modele_equip Modele_equip_id NOT NULL, -- L’identifiant du modèle de l’équipement en question
  description  TEXT            NOT NULL, -- Description du type de l’équipement

  CONSTRAINT EquipementType_cc0 PRIMARY KEY (modele_equip)
);

CREATE TABLE Capteur
  -- Répertoire des capteurs.
(
  noSerieC    Capteur_id NOT NULL, --Un numero de série attribué à un capteur pour le différencier
  description TEXT       NOT NULL, -- Description du capteur

  CONSTRAINT Capteur_cc0 PRIMARY KEY (noSerieC)
);

CREATE TABLE CapteurType
  -- Répertoire des capteurs.
(
  noModele    Capteur_type NOT NULL, -- Un numero de série attribué à un type de capteur pour le différencier
  description TEXT         NOT NULL, -- Description du type de capteur

  CONSTRAINT CapteurType_cc0 PRIMARY KEY (noModele)
);

CREATE TABLE Recette
  -- Répertoire des capteurs.
(
  noSerieR NoRecette NOT NULL, -- Un numero de série attribué à une recette pour le différencier
  Auteur   TEXT      NOT NULL, -- Nom de l’auteur de la recette

  CONSTRAINT Recette_cc0 PRIMARY KEY (noSerieR)
);

CREATE TABLE Etape
  -- Répertoire des capteurs.
(
  idetape Etape_id NOT NULL, -- L’identifiant de l’étape en question
  description   TEXT      NOT NULL, -- Description de l’etape

  CONSTRAINT Etape_cc0 PRIMARY KEY (idetape)
);

CREATE TABLE EtapeCuvee
  -- Répertoire des Etape de la cuvee.
(
  id_etapecuvee Cuvee_id  NOT NULL, --Identifiant unique de l’étape de la cuvée
  debut         TIMESTAMP NOT NULL, -- Le temps de début de l’étape de la cuvée
  fin           TIMESTAMP NOT NULL, -- Le temps de fin de l’étape de la cuvée

  CONSTRAINT EtapeCuvee_cc0 PRIMARY KEY (id_etapecuvee)
);

CREATE TABLE S_etape
  -- Répertoire des sous etapes.
(
  id_setape   Etape_id NOT NULL, -- L’identifiant de la sous étape en question
  description TEXT     NOT NULL, -- Description de la sous étape

  CONSTRAINT S_etape_cc0 PRIMARY KEY (id_setape)
);

CREATE TABLE S_etapeCuvee
  -- Répertoire des sous etapse de la cuvee.
(
  id_setapecuvee Cuvee_id  NOT NULL, --Identifiant unique de la cuvée
  debut         TIMESTAMP NOT NULL, -- Le temps de début de l’étape de la cuvée
  fin           TIMESTAMP NOT NULL, -- Le temps de fin de l’étape de la cuvée

  CONSTRAINT S_etapeCuvee_cc0 PRIMARY KEY (id_setapecuvee)
);

CREATE TABLE Action
  -- Répertoire des actions.
(
  idAction    Action_id NOT NULL, -- Identifiant unique de l’action
  duree       TIMESTAMP NOT NULL, -- La durée de l’action
  debut       TIMESTAMP NOT NULL, -- Le temps de début de l'action
  description TEXT      NOT NULL, -- La description de l’action

  CONSTRAINT Action_cc0 PRIMARY KEY (idAction)
);

CREATE TABLE ActionCuvee
  -- Répertoire des actions de la cuvee.
(
  idActionCuvee Action_id  NOT NULL, --Identifiant pour une action dans une cuvée
  debut         TIMESTAMP NOT NULL, -- Le temps de début de l’action de la cuvée
  fin           TIMESTAMP NOT NULL, -- Le temps de fin de l’action de la cuvée

  CONSTRAINT Action_cc0 PRIMARY KEY (idActionCuvee)
);

CREATE TABLE MesureType
  -- Répertoire des types de mesure.
(
  idMesure    Mesure_id NOT NULL, --L’identifiant pour un type de mesure
  uniteMesure UniteType NOT NULL, -- L'unité correspondant au type de mesure
  description TEXT      NOT NULL, -- La description du type de mesure

  CONSTRAINT MesureType_cc0 PRIMARY KEY (idMesure)
);

CREATE TABLE MesureRe
  -- Répertoire des mesures.
(
  frequence        frequenceType NOT NULL, --La fréquence à laquelle on prend une mesure pour une recette
  seuilCible       seuilType     NOT NULL, -- Le seuil ciblé d’une mesure pour une recette
  intervalleAlerte FLOAT         NOT NULL, -- L’intervalle d’alerte d’une mesure pour une recette

  CONSTRAINT MesureRe_cc0 PRIMARY KEY (frequence)
);

CREATE TABLE AlimentRe
  -- Répertoire des mesures daliments.
(
  quantite FLOAT NOT NULL, --La quantité utilisée d’un aliment dans une recette

  CONSTRAINT AlimentRe_cc0 PRIMARY KEY (quantite)
);

CREATE TABLE AutreRe
  -- Répertoire des mesures autres.
(
  description TEXT NOT NULL, -- La description d’une autre action pour une recette

  CONSTRAINT AlimentRe_cc0 PRIMARY KEY (description)
);

CREATE TABLE MesureCu
  -- Répertoire des mesures.
(
  valeur FLOAT NOT NULL, --La valeur d’une mesure prise dans une cuvée

  CONSTRAINT MesureCu_cc0 PRIMARY KEY (valeur)
);

CREATE TABLE AlimentCu
  -- Répertoire des mesures.
(
  statut TEXT NOT NULL, --Le statut d’un aliment dans une cuvée

  CONSTRAINT AliementCu_cc0 PRIMARY KEY (statut)
);

CREATE TABLE AutreCu
  -- Répertoire des mesures.
(
  statut TEXT NOT NULL, --Le statut d’une autre action dans une cuvée

  CONSTRAINT AutreCu_cc0 PRIMARY KEY (statut)
);

CREATE TABLE Ingredient
  -- Répertoire des Ingredients.
(
  idIngredient Ingredient_id NOT NULL, --L’identifiant unique pour un ingrédient
  nom          nom_type      NOT NULL, -- Le nom de l’ingrédient

  CONSTRAINT Ingredient_cc0 PRIMARY KEY (idIngredient)
);

CREATE TABLE Produit
  -- Répertoire des produits.
(
  idProduit Ingredient_id NOT NULL, --L’identifiant unique pour un produit
  noLot     NoLot_type    NOT NULL, -- Le numéro de lot d’un produit
  quantite  FLOAT         NOT NULL, -- La quantité utilisé d’un produit

  CONSTRAINT Produit_cc0 PRIMARY KEY (idProduit)
);

CREATE TABLE Fournisseur
  -- Répertoire des fournisseurs.
(
  idFournisseur Fournisseur_id NOT NULL, --L’identifiant unique pour un produit
  adresse       Adresse_type   NOT NULL, -- Le numéro de lot d’un produit
  nom           Nom_type       NOT NULL, -- La quantité utilisé d’un produit

  CONSTRAINT Fournisseur_cc0 PRIMARY KEY (idFournisseur)
);
