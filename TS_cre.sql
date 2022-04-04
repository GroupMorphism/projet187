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
  VARCHAR(70);

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
CREATE TABLE Recette
  -- Répertoire des capteurs.
(
  noSerieR NoRecette NOT NULL, -- Un numero de série attribué à une recette pour le différencier
  Auteur   TEXT      NOT NULL, -- Nom de l’auteur de la recette

  CONSTRAINT Recette_cc0 PRIMARY KEY (noSerieR)
);

CREATE TABLE Cuvee
  -- Répertoire des Cuvee.
(
  idCuvee     Cuvee_id       NOT NULL, -- identifiant unique de chaque cuvee
  Responsable Responsable_id NOT NULL, -- identifiant unique du responsable de la cuvee
  debut       TIMESTAMP      NOT NULL, -- date et heure du debut du processus
  fin         TIMESTAMP      NOT NULL, -- date et heure de la fin du processus
  idRecette   NoRecette      NOT NULL, -- identifiant de la recette utilisée

  CONSTRAINT Cuvee_cc0 PRIMARY KEY (idCuvee),
  CONSTRAINT Cuvee_fc0 FOREIGN KEY (idRecette) REFERENCES Recette(noSerieR)
);


CREATE TABLE EquipementType
  -- Répertoire des types d'equipements.
(
  modele_equip Modele_equip_id NOT NULL, -- L’identifiant du modèle de l’équipement en question
  description  TEXT            NOT NULL, -- Description du type de l’équipement

  CONSTRAINT EquipementType_cc0 PRIMARY KEY (modele_equip)
);

CREATE TABLE CapteurType
  -- Répertoire des capteurs.
(
  noModele    Capteur_type NOT NULL, -- Un numero de série attribué à un type de capteur pour le différencier
  description TEXT         NOT NULL, -- Description du type de capteur

  CONSTRAINT CapteurType_cc0 PRIMARY KEY (noModele)
);

CREATE TABLE Capteur
  -- Répertoire des capteurs.
(
  noSerieC    Capteur_id   NOT NULL, -- Un numero de série attribué à un capteur pour le différencier
  description TEXT         NOT NULL, -- Description du capteur
  typeCapteur Capteur_Type NOT NULL, -- Le type de capteur utilisé

  CONSTRAINT Capteur_cc0 PRIMARY KEY (noSerieC),
  CONSTRAINT Capteur_fc0 FOREIGN KEY (typeCapteur) REFERENCES CapteurType(noModele)
);

CREATE TABLE Etape
  -- Répertoire des capteurs.
(
  idetape       Etape_id  NOT NULL, -- L’identifiant de l’étape en question
  description   TEXT      NOT NULL, -- Description de l’etape
  idRecette     NoRecette NOT NULL, -- Le numéro de la recette utilisé

  CONSTRAINT Etape_cc0 PRIMARY KEY (idetape),
  CONSTRAINT Etape_fc0 FOREIGN KEY (idRecette) REFERENCES Recette(noSerieR)
);

CREATE TABLE EtapeCuvee
  -- Répertoire des Etape de la cuvee.
(
  id_etapecuvee Cuvee_id  NOT NULL, --Identifiant unique de l’étape de la cuvée
  debut         TIMESTAMP NOT NULL, -- Le temps de début de l’étape de la cuvée
  fin           TIMESTAMP NOT NULL, -- Le temps de fin de l’étape de la cuvée
  idEtape       Etape_id  NOT NULL, -- L'identifiant du type d'étape
  idCuvee       Cuvee_id  NOT NULL, -- L'identifiant de la cuvée pour cette étape

  CONSTRAINT EtapeCuvee_cc0 PRIMARY KEY (id_etapecuvee),
  CONSTRAINT EtapeCuvee_fc0 FOREIGN KEY (idEtape) REFERENCES Etape(idetape),
  CONSTRAINT EtapeCuvee_fc1 FOREIGN KEY (idCuvee) REFERENCES Cuvee(idCuvee)
);

CREATE TABLE S_etape
  -- Répertoire des sous etapes.
(
  id_setape   Etape_id NOT NULL, -- L’identifiant de la sous étape en question
  description TEXT     NOT NULL, -- Description de la sous étape
  idEtape     Etape_id NOT NULL, -- L'indentifiant de l'étape utilisant cette sous-étape

  CONSTRAINT S_etape_cc0 PRIMARY KEY (id_setape),
  CONSTRAINT S_etape_fc1 FOREIGN KEY (idEtape) REFERENCES Etape(idetape)
);

CREATE TABLE S_etapeCuvee
  -- Répertoire des sous etapse de la cuvee.
(
  id_setapecuvee Cuvee_id  NOT NULL, --Identifiant unique de la cuvée
  debut          TIMESTAMP NOT NULL, -- Le temps de début de l’étape de la cuvée
  fin            TIMESTAMP NOT NULL, -- Le temps de fin de l’étape de la
  id_setape      Etape_id  NOT NULL, -- Le type d'étape appliqué
  idEtapeCuvee   Cuvee_id  NOT NULL, -- L'étape qui utilise cette sous-étape

  CONSTRAINT S_etapeCuvee_cc0 PRIMARY KEY (id_setapecuvee),
  CONSTRAINT S_etapeCuvee_fc0 FOREIGN KEY (id_setape) REFERENCES S_etape(id_setape),
  CONSTRAINT S_etapeCuvee_fc1 FOREIGN KEY (idEtapeCuvee) REFERENCES EtapeCuvee(id_etapecuvee)
);

CREATE TABLE Equipement
  -- Répertoire des equipements.
(
  noSerieE    NoSerie_id       NOT NULL, -- Un numero de série attribué à un équipement pour le différencier
  description TEXT             NOT NULL, -- Description de l’équipement
  idSousEtape Cuvee_id         NOT NULL, -- Identifiant de la sous-étape où l'équipement est utilisé
  modeleEq    Modele_equip_id  NOT NULL, -- Numéro du modèle de l'équipement utilisé

  CONSTRAINT Equipement_cc0 PRIMARY KEY (noSerieE),
  CONSTRAINT Equipement_fc0 FOREIGN KEY (idSousEtape) REFERENCES S_etapeCuvee(id_setapecuvee),
  CONSTRAINT Equipement_fc1 FOREIGN KEY (modeleEq) REFERENCES EquipementType(modele_equip)
);

CREATE TABLE CapteursPourEquipement
(
    noSerieE   NoSerie_id     NOT NULL, -- Le numéro de série de l'équipement
    noSerieC   Capteur_id     NOT NULL, -- Le numéro de série du capteur

    CONSTRAINT CapteursPourEquipement_fc0 FOREIGN KEY (noSerieE) REFERENCES Equipement(noSerieE),
    CONSTRAINT CapteursPourEquipement_fc1 FOREIGN KEY (noSerieC) REFERENCES Capteur(noSerieC)
);

CREATE TABLE Action
  -- Répertoire des actions.
(
  idAction    Action_id NOT NULL, -- Identifiant unique de l’action
  duree       TIMESTAMP NOT NULL, -- La durée de l’action
  debut       TIMESTAMP NOT NULL, -- Le temps de début de l'action
  description TEXT      NOT NULL, -- La description de l’action
  id_setape   Etape_id  NOT NULL, -- La sous-étape utilisant cette action

  CONSTRAINT Action_cc0 PRIMARY KEY (idAction),
  CONSTRAINT Action_fc0 FOREIGN KEY (id_setape) REFERENCES S_etape(id_setape)
);

CREATE TABLE ActionCuvee
  -- Répertoire des actions de la cuvee.
(
  idActionCuvee  Action_id NOT NULL, --Identifiant pour une action dans une cuvée
  debut          TIMESTAMP NOT NULL, -- Le temps de début de l’action de la cuvée
  fin            TIMESTAMP NOT NULL, -- Le temps de fin de l’action de la cuvée
  id_setapecuvee Cuvee_id  NOT NULL, -- La sous-étape ayant utilisée cette action
  idAction       Action_id NOT NULL, -- Le type d'action

  CONSTRAINT ActionCuvee_cc0 PRIMARY KEY (idActionCuvee),
  CONSTRAINT ActionCuvee_fc0 FOREIGN KEY (id_setapecuvee) REFERENCES S_etapeCuvee(id_setapecuvee),
  CONSTRAINT ActionCuvee_fc1 FOREIGN KEY (idAction) REFERENCES Action(idAction)
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
  idMesure         Mesure_id     NOT NULL, -- L'identifiant de cette mesure
  frequence        frequenceType NOT NULL, --La fréquence à laquelle on prend une mesure pour une recette
  seuilCible       seuilType     NOT NULL, -- Le seuil ciblé d’une mesure pour une recette
  intervalleAlerte FLOAT         NOT NULL, -- L’intervalle d’alerte d’une mesure pour une recette
  idMesureType     Mesure_id     NOT NULL, -- Le type de cette mesure

  CONSTRAINT MesureRe_cc0 PRIMARY KEY (idMesure),
  CONSTRAINT MesureRe_fc0 FOREIGN KEY (idMesureType) REFERENCES MesureType(idMesure)
);

CREATE TABLE Ingredient
  -- Répertoire des Ingredients.
(
  idIngredient Ingredient_id NOT NULL, --L’identifiant unique pour un ingrédient
  nom          nom_type      NOT NULL, -- Le nom de l’ingrédient

  CONSTRAINT Ingredient_cc0 PRIMARY KEY (idIngredient)
);

CREATE TABLE AlimentRe
  -- Répertoire des mesures d'aliments.
(
  idAliment   Ingredient_id  NOT NULL, -- L'identifiant de l'aliment utilisé
  quantite    FLOAT          NOT NULL, --La quantité utilisée d’un aliment dans une recette

  CONSTRAINT AlimentRe_cc0 PRIMARY KEY (idAliment),
  CONSTRAINT AlimentRe_fc0 FOREIGN KEY (idAliment) REFERENCES Ingredient(idIngredient)
);

CREATE TABLE AutreRe
  -- Répertoire des mesures autres.
(
  idAction     Action_id   NOT NULL, -- L'identifiant de cette action
  description  TEXT        NOT NULL, -- La description d’une autre action pour une recette

  CONSTRAINT AutreRe_cc0 PRIMARY KEY (idAction)
);

CREATE TABLE MesureCu
  -- Répertoire des mesures.
(
  idMesure   Mesure_id  NOT NULL, -- L'identifiant de cette mesure
  valeur     FLOAT      NOT NULL, -- La valeur d’une mesure prise dans une cuvée

  CONSTRAINT MesureCu_cc0 PRIMARY KEY (idMesure)
);

CREATE TABLE Fournisseur
  -- Répertoire des fournisseurs.
(
  idFournisseur Fournisseur_id NOT NULL, --L’identifiant unique pour un produit
  adresse       Adresse_type   NOT NULL, -- Le numéro de lot d’un produit
  nom           Nom_type       NOT NULL, -- La quantité utilisé d’un produit

  CONSTRAINT Fournisseur_cc0 PRIMARY KEY (idFournisseur)
);

CREATE TABLE Produit
  -- Répertoire des produits.
(
  idProduit     Ingredient_id  NOT NULL, -- L’identifiant unique pour un produit
  noLot         NoLot_type     NOT NULL, -- Le numéro de lot d’un produit
  quantite      FLOAT          NOT NULL, -- La quantité utilisé d’un produit
  idIngredient  Ingredient_id  NOT NULL, -- L'identifiant de l'ingrédient utilisé pour ce produit
  idFournisseur Fournisseur_id NOT NULL, -- L'identifiant du fournisseur pour ce produit

  CONSTRAINT Produit_cc0 PRIMARY KEY (idProduit),
  CONSTRAINT Produit_fc0 FOREIGN KEY (idIngredient) REFERENCES Ingredient(idIngredient),
  CONSTRAINT Produit_fc1 FOREIGN KEY (idFournisseur) REFERENCES Fournisseur(idFournisseur)
);

CREATE TABLE AlimentCu
  -- Répertoire des mesures.
(
  idAliment  Ingredient_id   NOT NULL, -- L'identifiant de l'aliment
  statut     TEXT            NOT NULL, -- Le statut d’un aliment dans une cuvée

  CONSTRAINT AlimentCu_cc0 PRIMARY KEY (idAliment),
  CONSTRAINT AlimentCu_fc0 FOREIGN KEY (idAliment) REFERENCES Produit(idProduit)
);

CREATE TABLE AutreCu
  -- Répertoire des mesures.
(
  idAction   Action_id   NOT NULL, -- L'identifiant de cette action
  statut     TEXT        NOT NULL, -- Le statut d’une autre action dans une cuvée

  CONSTRAINT AutreCu_cc0 PRIMARY KEY (idAction)
);

---------------------------
-- Tables de jointures
---------------------------
CREATE TABLE MesureActionRe
(
    idMesure   Mesure_id   NOT NULL, -- Identifiant de la mesure
    idAction   Action_id   NOT NULL, -- Identifiant de l'action qui prend cette mesure

    CONSTRAINT MesureActionRe_fc0 FOREIGN KEY (idMesure) REFERENCES MesureRe(idMesure),
    CONSTRAINT MesureActionRe_fc1 FOREIGN KEY (idAction) REFERENCES Action(idAction)
);

CREATE TABLE AlimentActionRe
(
    idAliment  Ingredient_id  NOT NULL, -- Identifiant de l'aliment
    idAction   Action_id      NOT NULL, -- Identifiant de l'action qui utilise cet aliment

    CONSTRAINT AlimentActionRe_fc0 FOREIGN KEY (idAliment) REFERENCES AlimentRe(idAliment),
    CONSTRAINT AlimentActionRe_fc1 FOREIGN KEY (idAction) REFERENCES Action(idAction)
);

CREATE TABLE AutreActionRe
(
    idAutreAct  Action_id   NOT NULL, -- Identifiant d'un type d'action
    idAction    Action_id   NOT NULL, -- Identifiant de l'action qui utilise ce type d'Action

    CONSTRAINT AutreActionRe_fc0 FOREIGN KEY (idAutreAct) REFERENCES AutreRe(idAction),
    CONSTRAINT AutreActionRe_fc1 FOREIGN KEY (idAction) REFERENCES Action(idAction)
);

CREATE TABLE MesureActionCu
(
    idMesure   Mesure_id   NOT NULL, -- Identifiant de la mesure
    idAction   Action_id   NOT NULL, -- Identifiant de l'action qui prend cette mesure

    CONSTRAINT MesureActionCu_fc0 FOREIGN KEY (idMesure) REFERENCES MesureCu(idMesure),
    CONSTRAINT MesureActionCu_fc1 FOREIGN KEY (idAction) REFERENCES ActionCuvee(idActionCuvee)
);

CREATE TABLE AlimentActionCu
(
    idAliment  Ingredient_id  NOT NULL, -- Identifiant de l'aliment
    idAction   Action_id      NOT NULL, -- Identifiant de l'action qui utilise cet aliment

    CONSTRAINT AlimentActionCu_fc0 FOREIGN KEY (idAliment) REFERENCES AlimentCu(idAliment),
    CONSTRAINT AlimentActionCu_fc1 FOREIGN KEY (idAction) REFERENCES ActionCuvee(idActionCuvee)
);

CREATE TABLE AutreActionCu
(
    idAutreAct  Action_id   NOT NULL, -- Identifiant d'un type d'action
    idAction    Action_id   NOT NULL, -- Identifiant de l'action qui utilise ce type d'Action

    CONSTRAINT AutreActionCu_fc0 FOREIGN KEY (idAutreAct) REFERENCES AutreCu(idAction),
    CONSTRAINT AutreActionCu_fc1 FOREIGN KEY (idAction) REFERENCES ActionCuvee(idActionCuvee)
);