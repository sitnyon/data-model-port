-- Function: port_03.set_encombrement()

-- DROP FUNCTION port_03.set_encombrement();

CREATE OR REPLACE FUNCTION port_03.set_encombrement()
  RETURNS trigger AS
$BODY$BEGIN

    SELECT INTO new.encombrement round(new.largeur::numeric * new.longueur::numeric,2);

    RETURN new;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

COMMENT ON FUNCTION port_03.set_encombrement() IS 'Calcule l''encombrement du bateau (largeur*longueur) et la met dans "encombrement"';


-- Function: port_03.set_nom_prenom()

-- DROP FUNCTION port_03.set_nom_prenom();

CREATE OR REPLACE FUNCTION port_03.set_nom_prenom()
  RETURNS trigger AS
$BODY$BEGIN

    SELECT INTO new.nom_prenom
	CASE
		WHEN new.nom IS NOT NULL and new.prenom IS NULL THEN new.nom
		WHEN new.nom IS NOT NULL and new.prenom IS NOT NULL THEN new.nom || ' ' || new.prenom
		ELSE NULL
	END;

    RETURN new;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

COMMENT ON FUNCTION port_03.set_nom_prenom() IS 'Défini le nom et prenom';


-- Trigger: tr_por_bateaux_encombrement on port_03.por_tbl_bateaux

-- DROP TRIGGER tr_por_bateaux_encombrement ON port_03.por_tbl_bateaux;

CREATE TRIGGER tr_por_bateaux_encombrement
  BEFORE INSERT OR UPDATE OF longueur, largeur
  ON port_03.por_tbl_bateaux
  FOR EACH ROW
  EXECUTE PROCEDURE port_03.set_encombrement();
  
  
  -- Trigger: tr_por_proprietaire_nom_premom on port_03.por_tbl_proprietaires

-- DROP TRIGGER tr_por_proprietaire_nom_premom ON port_03.por_tbl_proprietaires;

CREATE TRIGGER tr_por_proprietaire_nom_premom
  BEFORE INSERT OR UPDATE OF nom
  ON port_03.por_tbl_proprietaires
  FOR EACH ROW
  EXECUTE PROCEDURE port_03.set_nom_prenom();
