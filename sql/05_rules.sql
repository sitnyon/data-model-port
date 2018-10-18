
-- Rule: upd_por_tbl_bateaux ON port.por_vtbl_bateaux_proprietaires

-- DROP RULE upd_por_tbl_bateaux ON port.por_vtbl_bateaux_proprietaires;

CREATE OR REPLACE RULE upd_por_tbl_bateaux AS
    ON UPDATE TO port.por_vtbl_bateaux_proprietaires DO INSTEAD  UPDATE port.por_tbl_bateaux SET statut = new.statut, no_place = new.no_place, taxe_triple = new.taxe_triple, date_inscription = new.date_inscription, date_renouvellement = new.date_renouvellement, date_attribution = new.date_attribution, date_resiliation = new.date_resiliation, embarcation = new.embarcation, immatriculation = new.immatriculation, longueur = new.longueur, largeur = new.largeur, encombrement = new.encombrement, coefficient = new.coefficient, puissance_moteur = new.puissance_moteur, surface_voile = new.surface_voile, facture = new.facture, tirant_eau = new.tirant_eau, commentaire = new.commentaire, rabais_pourcentage = new.rabais_pourcentage, tarif_special = new.tarif_special
  WHERE por_tbl_bateaux.id = new.id_bateau;
COMMENT ON RULE upd_por_tbl_bateaux ON port.por_vtbl_bateaux_proprietaires IS 'Règle de mise à jour de la table por_tbl_bateaux depuis la vue';

-- Rule: upd_por_tbl_proprietaires ON port.por_vtbl_bateaux_proprietaires

-- DROP RULE upd_por_tbl_proprietaires ON port.por_vtbl_bateaux_proprietaires;

CREATE OR REPLACE RULE upd_por_tbl_proprietaires AS
    ON UPDATE TO port.por_vtbl_bateaux_proprietaires DO INSTEAD  UPDATE port.por_tbl_proprietaires SET nom = new.nom, prenom = new.prenom, adresse = new.adresse, npa = new.npa, ville = new.ville, tel = new.tel
  WHERE por_tbl_proprietaires.id = new.id_proprietaire;
COMMENT ON RULE upd_por_tbl_proprietaires ON port.por_vtbl_bateaux_proprietaires IS 'Règle de mise à jour de la table por_tbl_proprietaires depuis la vue';

-- Rule: upd_por_geo_places_bateaux ON port.por_vgeo_placement

-- DROP RULE upd_por_geo_places_bateaux ON port.por_vgeo_placement;

CREATE OR REPLACE RULE upd_por_geo_places_bateaux AS
    ON UPDATE TO port.por_vgeo_placement DO INSTEAD  UPDATE port.por_geo_places_bateaux SET numero_place = new.numero_place, statut = new.statut, emplacement = new.emplacement, type = new.type, geom = new.geom
  WHERE por_geo_places_bateaux.id = new.id;
COMMENT ON RULE upd_por_geo_places_bateaux ON port.por_vgeo_placement IS 'Règle de mise à jour de la table por_geo_places_bateaux depuis la vue';


-- Rule: ins_por_geo_places_bateaux ON port.por_vgeo_placement

-- DROP RULE ins_por_geo_places_bateaux ON port.por_vgeo_placement;

CREATE OR REPLACE RULE ins_por_geo_places_bateaux AS
    ON INSERT TO port.por_vgeo_placement DO INSTEAD  INSERT INTO port.por_geo_places_bateaux (numero_place, statut, emplacement, type, geom)
  VALUES (new.numero_place, new.statut, new.emplacement, new.type, new.geom)
  RETURNING NULL::integer AS id,
    por_geo_places_bateaux.numero_place,
    por_geo_places_bateaux.statut,
    por_geo_places_bateaux.emplacement,
    por_geo_places_bateaux.type,
    0::text AS placement,
    por_geo_places_bateaux.geom;
COMMENT ON RULE ins_por_geo_places_bateaux ON port.por_vgeo_placement IS 'Règle d''insert de la table por_geo_places_bateaux depuis la vue';



-- Rule: del_por_geo_places_bateaux ON port.por_vgeo_placement

-- DROP RULE del_por_geo_places_bateaux ON port.por_vgeo_placement;

CREATE OR REPLACE RULE del_por_geo_places_bateaux AS
    ON DELETE TO port.por_vgeo_placement DO INSTEAD  DELETE FROM port.por_geo_places_bateaux
  WHERE por_geo_places_bateaux.id = old.id;
COMMENT ON RULE del_por_geo_places_bateaux ON port.por_vgeo_placement IS 'Règle de delete de la table por_geo_places_bateaux depuis la vue';
