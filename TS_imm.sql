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
    RETURNS idProduit
LANGUAGE SQL AS
$$
    SELECT produit.idProduit
    FROM produit JOIN fournisseur USING (idfournisseur)
    WHERE (fournisseur_id = idFour)
$$;

-- Obtenir les sousetapes d'une etape
CREATE OR REPLACE FUNCTION ObtenirSousEtapes
    (idE idetape)
    RETURNS id
LANGUAGE SQL AS
$$
    SELECT S_etape.s_etape
    FROM etape JOIN s_etape USING (idetape)
    WHERE (idetape = idE)
$$;
