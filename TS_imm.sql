-- Obtenir la recette R d'une cuvée C
CREATE OR REPLACE FUNCTION ObtenirRecette
  (idC Cuvee_id)
  RETURNS norecette
LANGUAGE SQL AS
$$
    SELECT noserier
    FROM cuvee NATURAL JOIN recette
    WHERE idcuvee = idC
$$;

-- Obtenir tous les ingrédients pour chaque recette
CREATE OR REPLACE VIEW IngrRecette AS
    SELECT recette.noserier AS NoRecette, ingredient.nom AS Nom
FROM recette JOIN etape ON recette.noserier = etape.idrecette
             JOIN s_etape USING (idetape)
             JOIN action USING (id_setape)
             JOIN alimentactionre USING (idaction)
             JOIN alimentre USING (idaliment)
             JOIN ingredient ON alimentre.idaliment = ingredient.idingredient;

-- Obtenir tous les ingrédients pour une recette donnée
CREATE OR REPLACE FUNCTION ObtenirIngredients
  (idR norecette)
  RETURNS nom_type
LANGUAGE SQL AS
$$
    SELECT Nom
FROM IngrRecette
    WHERE NoRecette = idR;
$$;

-- Ajouter une nouvelle recette
CREATE OR REPLACE PROCEDURE CreerRecette
    (idR norecette, aut nom_type)
    LANGUAGE SQL AS
$$
    INSERT INTO recette (noserier, auteur) VALUES
    (idR, aut)
$$;

-- Ajouter une nouvelle étape
CREATE OR REPLACE PROCEDURE CreerEtape
    (idE etape_id, descr text, idR norecette)
    LANGUAGE SQL AS
$$
    INSERT INTO recetteetape (idetape, description, idrecette) VALUES
    (idE, descr, idR)
$$;

-- Ajouter une nouvelle étape de cuvée
CREATE OR REPLACE PROCEDURE CreerEtapeCuvée
    (idEC cuvee_id, _debut timestamp, _fin timestamp, idE etape_id, idC cuvee_id)
    LANGUAGE SQL AS
$$
    INSERT INTO etapecuvee (id_etapecuvee, debut, fin, idetape, idcuvee) VALUES
    (idEC, _debut, _fin, idE, idC)
$$;

-- Obtenir les mesures M pour un capteur C dans un équipement E
CREATE OR REPLACE FUNCTION ObtenirMesures
    (idCapt capteur_id)
    RETURNS DOUBLE PRECISION
LANGUAGE SQL AS
$$
    SELECT mesurecu.valeur
    FROM capteur JOIN capteurspourequipement USING (noseriec)
                 JOIN equipement USING (noseriee)
                 JOIN s_etapecuvee ON equipement.idsousetape = s_etapecuvee.id_setapecuvee
                 JOIN actioncuvee USING (id_setapecuvee)
                 JOIN mesureactioncu ON actioncuvee.idactioncuvee = mesureactioncu.idaction
                 JOIN mesurecu USING (idmesure)
    WHERE (capteur.noseriec = idCapt)
$$;

-- Obtenir le fournisseur F pour un ingrédient I
CREATE OR REPLACE FUNCTION ObtenirFournisseur
    (idIngr ingredient_id)
    RETURNS fournisseur_id
LANGUAGE SQL AS
$$
    SELECT fournisseur.idfournisseur
    FROM ingredient JOIN produit USING (idingredient)
                    JOIN fournisseur USING (idfournisseur)
    WHERE (ingredient.idingredient = idIngr)
$$;

-- Supprimer une recette
CREATE OR REPLACE PROCEDURE DeleteRecipe
    (idR norecette)
    LANGUAGE SQL AS
$$
    DELETE FROM recette
    WHERE noserier = idR
$$;

-- Obtenir les produits d'un fournisseur
CREATE OR REPLACE FUNCTION ObtenirProduits
    (idFour fournisseur_id)
    RETURNS ingredient_id
LANGUAGE SQL AS
$$
    SELECT produit.idProduit
    FROM produit JOIN fournisseur USING (idfournisseur)
    WHERE (idfournisseur = idFour)
$$;

-- Obtenir les sousetapes d'une etape
CREATE OR REPLACE FUNCTION ObtenirSousEtapes
    (idE etape_id)
    RETURNS etape_id
LANGUAGE SQL AS
$$
    SELECT S_etape.id_setape
    FROM etape JOIN s_etape USING (idetape)
    WHERE (idetape = idE)
$$;

-- Ajout d'un équipement
CREATE OR REPLACE PROCEDURE CreerEquipement
    (nSerie noserie_id, descr text, idSE cuvee_id, modele modele_equip_id)
    LANGUAGE SQL AS
$$
    INSERT INTO equipement (noseriee, description, idsousetape, modeleeq) VALUES
    (nSerie, descr, idSE, modele)
$$;

-- Ajout d'un équipement type
CREATE OR REPLACE PROCEDURE CreerTypeEquipement
    (modele modele_equip_id, descr text)
    LANGUAGE SQL AS
$$
    INSERT INTO equipementtype (modele_equip, description) VALUES
    (modele, descr)
$$;

-- Ajout d'un capteur
CREATE OR REPLACE PROCEDURE CreerCapteur
    (noserie capteur_id, descr text, typeC capteur_type)
    LANGUAGE SQL AS
$$
    INSERT INTO capteur (noseriec, description, typecapteur) VALUES
    (noserie, descr, typeC)
$$;

-- Ajout d'un capteur type
CREATE OR REPLACE PROCEDURE CreerTypeCapteur
    (modele capteur_type, descr text)
    LANGUAGE SQL AS
$$
    INSERT INTO capteurtype (nomodele, description) VALUES
    (modele, descr)
$$;

-- Ajout d'une sous-étape
CREATE OR REPLACE PROCEDURE CreerSousEtape
    (idSE etape_id, descr text, idE etape_id)
    LANGUAGE SQL AS
$$
    INSERT INTO s_etape (id_setape, description, idetape) VALUES
    (idSE, descr, idE)
$$;

-- Ajout d'une sous-étape cuvée
CREATE OR REPLACE PROCEDURE CreerSousEtapeCuvée
    (idSEC cuvee_id, _debut timestamp, _fin timestamp, idSE etape_id, idEC cuvee_id)
    LANGUAGE SQL AS
$$
    INSERT INTO s_etapecuvee (id_setapecuvee, debut, fin, id_setape, idetapecuvee) VALUES
    (idSEC, _debut, _fin, idSE, idEC)
$$;

-- Ajout d'une action
CREATE OR REPLACE PROCEDURE CreerAction
    (idA action_id, _duree timestamp, _debut timestamp, descr text, idSE etape_id)
    LANGUAGE SQL AS
$$
    INSERT INTO action (idaction, duree, debut, description, id_setape) VALUES
    (idA, _duree, _debut, descr, idSE)
$$;

-- Ajout d'une actionCuvée
CREATE OR REPLACE PROCEDURE CreerActionCuvee
    (idAC action_id, _debut timestamp, _fin timestamp, idSEC cuvee_id, idA action_id)
    LANGUAGE SQL AS
$$
    INSERT INTO actioncuvee (idactioncuvee, debut, fin, id_setapecuvee, idaction) VALUES
    (idAC, _debut, _fin, idSEC, idA)
$$;

-- Ajout d'une mesureRe
CREATE OR REPLACE PROCEDURE CreerMesureRecette
    (idM mesure_id, freq frequencetype, seuil seuiltype, intervalleAl double precision, idMtype mesure_id)
    LANGUAGE SQL AS
$$
    INSERT INTO mesurere (idmesure, frequence, seuilcible, intervallealerte, idmesuretype) VALUES
    (idM, freq, seuil, intervalleAl, idMtype)
$$;

-- Ajout d'une mesureCu
CREATE OR REPLACE PROCEDURE CreerMesureCuvée
    (idM mesure_id, val double precision)
    LANGUAGE SQL AS
$$
    INSERT INTO mesurecu (idmesure, valeur) VALUES
    (idM, val)
$$;

-- Ajout d'une mesure type
CREATE OR REPLACE PROCEDURE CreerTypeMesure
    (idM mesure_id, unite unitetype, descr text)
    LANGUAGE SQL AS
$$
    INSERT INTO mesuretype (idmesure, unitemesure, description) VALUES
    (idM, unite, descr)
$$;

-- Ajout d'un ingrédient
CREATE OR REPLACE PROCEDURE CreerTypeMesure
    (idIngr ingredient_id, _nom nom_type)
    LANGUAGE SQL AS
$$
    INSERT INTO ingredient (idingredient, nom) VALUES
    (idIngr, _nom)
$$;

-- Ajout d'un fournisseur
CREATE OR REPLACE PROCEDURE CreerFournisseur
    (idFou fournisseur_id, _adresse adresse_type, _nom nom_type)
    LANGUAGE SQL AS
$$
    INSERT INTO fournisseur (idfournisseur, adresse, nom) VALUES
    (idFou, _adresse, _nom)
$$;

-- Ajout d'un alimentRe
CREATE OR REPLACE PROCEDURE CreerAlimentRecette
    (idAl fournisseur_id, _quantite double precision)
    LANGUAGE SQL AS
$$
    INSERT INTO alimentre (idaliment, quantite) VALUES
    (idAl, _quantite)
$$;

-- Ajout d'un alimentCu
CREATE OR REPLACE PROCEDURE CreerAlimentCuvee
    (idAl fournisseur_id, _statut text)
    LANGUAGE SQL AS
$$
    INSERT INTO alimentcu (idaliment, statut) VALUES
    (idAl, _statut)
$$;

--MISE À JOUR
-- Changer une mesure
