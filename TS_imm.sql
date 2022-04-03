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
    INSERT INTO etape (idetape, description, idrecette) VALUES
    (idE, descr, idR)
$$;

-- Obtenir le fabriquant F d'un équipement

-- Obtenir une mesure M pour un capteur C dans un équipement E

-- Obtenir le fournisseur F pour un ingrédient I

-- Obtenir toutes les actions A pour une sous-étape S.