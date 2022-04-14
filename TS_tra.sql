-------------------------------
--  Routines de mise-à-jour  --
-------------------------------

CREATE OR REPLACE PROCEDURE ModifierValeurMesure
    (idM mesure_id, val double precision)
    LANGUAGE SQL AS
$$
    UPDATE mesurecu
        SET valeur = val
        WHERE idmesure = idM
$$;

CREATE OR REPLACE PROCEDURE ChangerQuantiteMesure
    (idAl ingredient_id, val double precision)
    LANGUAGE SQL AS
$$
    UPDATE alimentre
        SET quantite = val
        WHERE idaliment = idAl
$$;

CREATE OR REPLACE PROCEDURE ModifierDureeAction
    (idAct action_id, val double precision)
    LANGUAGE SQL AS
$$
    UPDATE action
        SET duree = val
        WHERE idaction = idAct
$$;

CREATE OR REPLACE PROCEDURE ModifierResponsableCuvee
    (idCuv action_id, _responsable responsable_id)
    LANGUAGE SQL AS
$$
    UPDATE cuvee
        SET responsable = _responsable
        WHERE idcuvee = idCuv
$$;

CREATE OR REPLACE PROCEDURE ModifierAdresseFournisseur
    (idFou fournisseur_id, adr adresse_type)
    LANGUAGE SQL AS
$$
    UPDATE fournisseur
        SET adresse = adr
        WHERE idfournisseur = idFou
$$;