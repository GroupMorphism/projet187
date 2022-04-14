----------------------------
--         VUES           --
----------------------------
-- Vue entre les tables Recette et Étape
CREATE OR REPLACE VIEW RecetteEtape AS
    SELECT *
FROM recette JOIN etape ON recette.noserier = etape.idrecette;

-- Vue entre les tables Étape et Sous-Étape
CREATE OR REPLACE VIEW EtapeSousetape AS
    SELECT idetape, etape.description AS DescriptionEtape, id_setape, s_etape.description AS DescriptionSousEtape
FROM etape JOIN s_etape USING (idetape);

-- Vue entre les tables Sous-Étape et Action
CREATE OR REPLACE VIEW SousetapeAction AS
    SELECT idAction, action.description AS DescriptionAction, duree, debut,
           s_etape.id_setape, s_etape.description AS DescriptionSousEtape
FROM action JOIN s_etape USING (id_setape);

-- Vue entre toutes les vues d'un procédé
CREATE OR REPLACE VIEW Procede AS
    SELECT *
FROM RecetteEtape NATURAL JOIN EtapeSousetape
                  NATURAL JOIN SousetapeAction;


----------------------------
--        TRIGGERS        --
----------------------------

-- Trigger sur l'insertion d'une nouvelle étape
CREATE TRIGGER Inserer_Etape_tri
    INSTEAD OF INSERT ON RecetteEtape
    FOR EACH ROW EXECUTE PROCEDURE Inserer_Etape();

-- Trigger sur la suppression d'une recette
CREATE TRIGGER Supprimer_Etape_tri
    BEFORE DELETE ON recette
    FOR EACH ROW EXECUTE PROCEDURE Supprimer_Etape();

-- Trigger sur la suppression d'une recette
CREATE TRIGGER Supprimer_SEtape_tri
    BEFORE DELETE ON etape
    FOR EACH ROW EXECUTE PROCEDURE Supprimer_SEtape();

-- Trigger sur la suppression d'une recette
CREATE TRIGGER Supprimer_Action_tri
    BEFORE DELETE ON s_etape
    FOR EACH ROW EXECUTE PROCEDURE Supprimer_Action();

-- Trigger sur la suppresion d'une action
CREATE TRIGGER Supprimer_TypeActions_tri
    BEFORE DELETE ON action
    FOR EACH ROW EXECUTE PROCEDURE Supprimer_TypeAction();

-- Trigger sur la suppresion d'une mesure
CREATE TRIGGER Supprimer_MesureRe_tri
    BEFORE DELETE ON mesureactionre
    FOR EACH ROW EXECUTE PROCEDURE Supprimer_Mesure();

-- Trigger sur la suppresion d'une mesure
CREATE TRIGGER Supprimer_AlimentRe_tri
    BEFORE DELETE ON alimentactionre
    FOR EACH ROW EXECUTE PROCEDURE Supprimer_Aliment();

-- Trigger sur la suppresion d'une autre action
CREATE TRIGGER Supprimer_MesureRe_tri
    BEFORE DELETE ON autreactionre
    FOR EACH ROW EXECUTE PROCEDURE Supprimer_AutreAction();



----------------------------
--      FCT_TRIGGERS      --
----------------------------

-- Vérifier si l'id de recette existe
CREATE OR REPLACE FUNCTION Inserer_Etape ()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
$$
    BEGIN
       IF NOT EXISTS(
            SELECT * FROM recette
            WHERE recette.noserier = NEW.idrecette
           ) THEN
           RAISE EXCEPTION 'Id de recette non existente';
           RETURN NULL;
       END IF;
       INSERT INTO etape (idetape, description, idrecette) VALUES
        (NEW.idetape, NEW.description, NEW.idrecette);
       RETURN NEW;
    END;
$$;


-- Supprimer une étape
CREATE OR REPLACE FUNCTION Supprimer_Etape ()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
$$
    BEGIN
        IF New.noserier IS NULL THEN
            DELETE FROM etape
            WHERE Old.noserier = etape.idrecette;

            RETURN Old;
        END IF;
        RETURN Old;
    END;
$$;

-- Supprimer une sous-étape
CREATE OR REPLACE FUNCTION Supprimer_SEtape ()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
$$
    BEGIN
        IF New.idetape IS NULL THEN
            DELETE FROM s_etape
            WHERE Old.idetape = s_etape.idetape;

            RETURN Old;
        END IF;
        RETURN Old;
    END;
$$;

-- Supprimer une action
CREATE OR REPLACE FUNCTION Supprimer_Action ()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
$$
    BEGIN
        IF New.id_setape IS NULL THEN
            DELETE FROM action
            WHERE Old.id_setape = action.id_setape;

            RETURN Old;
        END IF;
        RETURN Old;
    END;
$$;

-- Supprimer un type d'action
CREATE OR REPLACE FUNCTION Supprimer_TypeAction ()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
$$
    BEGIN
        IF New.idaction IS NULL THEN
            DELETE FROM mesureactionre
            WHERE Old.idaction = mesureactionre.idaction;

            DELETE FROM alimentactionre
            WHERE Old.idaction = alimentactionre.idaction;

            DELETE FROM autreactionre
            WHERE Old.idaction = autreactionre.idaction;

            RETURN Old;

        END IF;
        RETURN Old;
    END;
$$;

-- Supprimer une mesure
CREATE OR REPLACE FUNCTION Supprimer_Mesure()
    RETURNS TRIGGER
    LANGUAGE  plpgsql AS
$$
    BEGIN
        IF New.idaction IS NULL THEN
            DELETE FROM mesurere
            WHERE Old.idmesure = mesurere.idmesure;

            RETURN Old;
        END IF;
        RETURN Old;
    END;
$$;

-- Supprimer un aliment
CREATE OR REPLACE FUNCTION Supprimer_Aliment()
    RETURNS TRIGGER
    LANGUAGE  plpgsql AS
$$
    BEGIN
        IF New.idaction IS NULL THEN
            DELETE FROM alimentre
            WHERE Old.idaliment = alimentre.idaliment;

            RETURN Old;
        END IF;
        RETURN Old;
    END;
$$

-- Supprimer un autre type d'action
CREATE OR REPLACE FUNCTION Supprimer_AutreAction()
    RETURNS TRIGGER
    LANGUAGE  plpgsql AS
$$
    BEGIN
        IF New.idaction IS NULL THEN
            DELETE FROM autreactionre
            WHERE Old.idautreact = autreactionre.idaction;

            RETURN Old;
        END IF;
        RETURN Old;
    END;
$$


-- Trigger sur l'insertion d'un équipement pour update table de jointure
-- Trigger sur l'insertion des types d'actions pour update les tables de jointures associées