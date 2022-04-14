INSERT INTO Recette (noSerieR, Auteur) VALUES
('AABB','Émilien Lacours'),
('CCBB','Jean-Francois Létourneau');

INSERT INTO Cuvee (idCuvee, Responsable, debut, fin, idRecette) VALUES
('A3F45GRT', 'RAMB','2022-05-08','2022-11-16','AABB'),
('A4B48901', 'BTMB','2021-05-08','2021-12-16','CCBB');

INSERT INTO EquipementType (modele_equip, description) VALUES
('ABCD','visseur automatisé haute vitesse modèle 34DT'),
('CZBB','cuve à liquide de 200 litres modèle 450X');

INSERT INTO Etape (idetape, description, idRecette) VALUES
('DRFT','Houblonnage','AABB'),
('GGJK','Maturation','CCBB');

INSERT INTO EtapeCuvee (id_etapecuvee, debut, fin,idEtape,idCuvee) VALUES
('ZXCV4352','2022-06-11','2022-06-16','DRFT','A3F45GRT'),
('ABCD1234','2021-08-24','2021-09-25','GGJK','A4B48901');

INSERT INTO S_etape (id_setape,description,idEtape) VALUES
('UUBB','Introduction houblon cuves','DRFT'),
('UURF','Laisse liquide maturer','GGJK');

INSERT INTO S_etapeCuvee (id_setapecuvee,debut, fin,id_setape,idEtapeCuvee) VALUES
('DDDFRT56','2022-06-13','2022-06-14','UUBB','ZXCV4352'),
('XXXFRT56','2021-09-20','2021-09-21','UURF','ABCD1234');

INSERT INTO Equipement (noSerieE, description, idSousEtape, modeleEq) VALUES
('GCFGGTRT', 'visseur automatisé','DDDFRT56','ABCD'),
('ACBTHJKB', 'cuve à liquide','XXXFRT56','CZBB');

INSERT INTO CapteurType (noModele, description) VALUES
('ZZZA','capteur à haute pression modèle 50F'),
('EERT','capteur à haute température modèle AAF');

INSERT INTO Capteur (noSerieC, description,typeCapteur) VALUES
('ZZZZ','capteur a pression','ZZZA'),
('GGTT','capteur à température','EERT');

INSERT INTO Action (idAction, duree, debut,description,id_setape) VALUES
('EEEE', 1800,'2022-06-11','On introduit le houblon dans les cuves','UUBB'),
('BBBB', 86400,'2021-08-11','On laisse maturer le liquide dans les cuves','UURF');

INSERT INTO ActionCuvee (idActionCuvee, debut, fin,id_setapecuvee,idAction) VALUES
('OOOO','2022-06-11','2022-06-12','DDDFRT56','EEEE'),
('NNNN','2021-08-11','2021-08-12','XXXFRT56','BBBB');

INSERT INTO MesureType (idMesure, uniteMesure, description) VALUES
('JJJJ','OOOO','température'),
('UUUU','RRRR','pression');

INSERT INTO MesureRe (idMesure, frequence, seuilCible, intervalleAlerte,idMesureType) VALUES
('AAER','SSSS','GGGH',112.3,'JJJJ'),
('AAFD','TTTT','HHYY',260.2,'UUUU');

INSERT INTO Ingredient (idIngredient, nom) VALUES
('KLKL','Houblon'),
('RRRR','Mais');

INSERT INTO AlimentRe (idAliment, quantite) VALUES
('KLKL',30),
('RRRR',45);

INSERT INTO AutreRe (idAction, description) VALUES
('QQQQ','Ranger les sacs des ingrédients'),
('QRFL','Ranger les palettes de produits au bon endroit');

INSERT INTO MesureCu (idMesure, valeur) VALUES
('AAER',70.5),
('AAFD',125.3);

INSERT INTO Fournisseur (idFournisseur, adresse, nom) VALUES
('XXXX','LLLL','Jean-Paul Laroche'),
('CCCC','HHHH','Giselle Doudoune');

INSERT INTO Produit (idProduit, noLot, quantite, idIngredient,idFournisseur) VALUES
('SSSS','POIL',57.4,'KLKL','XXXX'),
('UYUY','WERT',80.3,'RRRR','CCCC');

INSERT INTO AlimentCu (idAliment, statut ) VALUES
('SSSS','à ajouter'),
('UYUY','ajouté');

INSERT INTO AutreCu (idAction, statut ) VALUES
('ZZWW','à executé'),
('MMMM','terminé');








