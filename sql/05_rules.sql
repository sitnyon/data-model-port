
-- Rule: upd_por_tbl_bateaux ON port_03.por_vtbl_bateaux_proprietaires

-- DROP RULE upd_por_tbl_bateaux ON port_03.por_vtbl_bateaux_proprietaires;

CREATE OR REPLACE RULE upd_por_tbl_bateaux AS
    ON UPDATE TO port_03.por_vtbl_bateaux_proprietaires DO INSTEAD  UPDATE port_03.por_tbl_bateaux SET statut = new.statut, no_place = new.no_place, taxe_triple = new.taxe_triple, date_inscription = new.date_inscription, date_renouvellement = new.date_renouvellement, date_attribution = new.date_attribution, date_resiliation = new.date_resiliation, embarcation = new.embarcation, immatriculation = new.immatriculation, longueur = new.longueur, largeur = new.largeur, encombrement = new.encombrement, coefficient = new.coefficient, puissance_moteur = new.puissance_moteur, surface_voile = new.surface_voile, facture = new.facture, tirant_eau = new.tirant_eau, commentaire = new.commentaire, rabais_pourcentage = new.rabais_pourcentage, tarif_special = new.tarif_special
  WHERE por_tbl_bateaux.id = new.id_bateau;
COMMENT ON RULE upd_por_tbl_bateaux ON port_03.por_vtbl_bateaux_proprietaires IS 'Règle de mise à jour de la table por_tbl_bateaux depuis la vue';

-- Rule: upd_por_tbl_proprietaires ON port_03.por_vtbl_bateaux_proprietaires

-- DROP RULE upd_por_tbl_proprietaires ON port_03.por_vtbl_bateaux_proprietaires;

CREATE OR REPLACE RULE upd_por_tbl_proprietaires AS
    ON UPDATE TO port_03.por_vtbl_bateaux_proprietaires DO INSTEAD  UPDATE port_03.por_tbl_proprietaires SET nom = new.nom, prenom = new.prenom, adresse = new.adresse, npa = new.npa, ville = new.ville, tel = new.tel
  WHERE por_tbl_proprietaires.id = new.id_proprietaire;
COMMENT ON RULE upd_por_tbl_proprietaires ON port_03.por_vtbl_bateaux_proprietaires IS 'Règle de mise à jour de la table por_tbl_proprietaires depuis la vue';
