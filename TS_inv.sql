INSERT INTO recette (noserier, auteur) VALUES
('ABCD', 'Olivier');

INSERT INTO etape (idetape, description, idrecette) VALUES
('QWER', 'ma recette', 'ABCD');

INSERT INTO s_etape (id_setape, description, idetape) VALUES
('TYUI', 'une sous-etape', 'QWER');

INSERT INTO action (idaction, duree, debut, description, id_setape) VALUES
('OPAS', current_date::timestamp, current_date::timestamp, 'une action', 'TYUI');

INSERT INTO ingredient (idingredient, nom) VALUES
('DFGH', 'pomme');

INSERT INTO alimentactionre (idaliment, idaction) VALUES
('DFGH', 'OPAS');

INSERT INTO alimentre (idaliment, quantite) VALUES
('DFGH', 13);



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