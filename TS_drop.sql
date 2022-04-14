-- Tables
DROP TABLE Action CASCADE;
DROP TABLE ActionCuvee CASCADE;
DROP TABLE AlimentCu CASCADE;
DROP TABLE AlimentRe CASCADE;
DROP TABLE AutreCu CASCADE;
DROP TABLE AutreRe CASCADE;
DROP TABLE Capteur CASCADE;
DROP TABLE CapteurType CASCADE;
DROP TABLE Cuvee CASCADE;
DROP TABLE EquipementType CASCADE;
DROP TABLE Equipement CASCADE;
DROP TABLE Etape CASCADE;
DROP TABLE EtapeCuvee CASCADE;
DROP TABLE Fournisseur CASCADE;
DROP TABLE Ingredient CASCADE;
DROP TABLE MesureCu CASCADE;
DROP TABLE MesureRe CASCADE;
DROP TABLE MesureType CASCADE;
DROP TABLE Produit CASCADE;
DROP TABLE Recette CASCADE;
DROP TABLE S_etape CASCADE;
DROP TABLE s_etapecuvee CASCADE;

-- Tables de jointures
DROP TABLE CapteursPourEquipement CASCADE;
DROP TABLE MesureActionRe CASCADE;
DROP TABLE AlimentActionRe CASCADE;
DROP TABLE AutreActionRe CASCADE;
DROP TABLE MesureActionCu CASCADE;
DROP TABLE AlimentActionCu CASCADE;
DROP TABLE AutreActionCu CASCADE;

-- Types
DROP DOMAIN Action_id CASCADE;
DROP DOMAIN Adresse_type CASCADE;
DROP DOMAIN capteur_id CASCADE;
DROP DOMAIN capteur_type CASCADE;
DROP DOMAIN cuvee_id CASCADE;
DROP DOMAIN etape_id CASCADE;
DROP DOMAIN fournisseur_id CASCADE;
DROP DOMAIN frequencetype CASCADE;
DROP DOMAIN ingredient_id CASCADE;
DROP DOMAIN mesure_id CASCADE;
DROP DOMAIN modele_equip_id CASCADE;
DROP DOMAIN nolot_type CASCADE;
DROP DOMAIN nom_type CASCADE;
DROP DOMAIN norecette CASCADE;
DROP DOMAIN noserie_id CASCADE;
DROP DOMAIN responsable_id CASCADE;
DROP DOMAIN seuiltype CASCADE;
DROP DOMAIN unitetype CASCADE;