CREATE OR REPLACE VIEW RecetteEtape AS
    SELECT *
FROM recette JOIN etape ON recette.noserier = etape.idrecette;

CREATE OR REPLACE VIEW EtapeSousetape AS
    SELECT idetape, etape.description AS DescriptionEtape, id_setape, s_etape.description AS DescriptionSousEtape
FROM etape JOIN s_etape USING (idetape);

CREATE OR REPLACE VIEW SousetapeAction AS
    SELECT idAction, action.description AS DescriptionAction, duree, debut,
           s_etape.id_setape, s_etape.description AS DescriptionSousEtape
FROM action JOIN s_etape USING (id_setape);


CREATE TRIGGER Inserer_Etape_tri
    INSTEAD OF INSERT ON RecetteEtape
    FOR EACH ROW EXECUTE PROCEDURE Inserer_Etape();

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
$$
