-- View: port.por_vgeo_placement

-- DROP VIEW port.por_vgeo_placement;

CREATE OR REPLACE VIEW port.por_vgeo_placement AS 
 SELECT g.id,
    g.numero_place,
    g.statut,
    g.emplacement,
    g.type,
    foo.placement,
    g.geom
   FROM port.por_geo_places_bateaux g
     LEFT JOIN ( SELECT DISTINCT b.no_place,
            'occupé'::text AS placement
           FROM port.por_tbl_bateaux b
          WHERE b.statut::text = ANY (ARRAY['Placé'::text, 'En attente (Changement)'::text])) foo ON g.numero_place::text = foo.no_place::text
  ORDER BY g.id;

COMMENT ON VIEW port.por_vgeo_placement
  IS 'Visualisation des places pour gestion QGIS';
  
  
-- View: port.por_vtbl_bateaux_proprietaires

-- DROP VIEW port.por_vtbl_bateaux_proprietaires;

CREATE OR REPLACE VIEW port.por_vtbl_bateaux_proprietaires AS 
 SELECT b.id AS id_bateau,
    p.id AS id_proprietaire,
    p.nom,
    p.prenom,
    p.adresse,
    p.npa,
    p.ville,
    p.tel,
    p.email,
    b.taxe_triple,
    b.date_inscription,
    foo.no_attente,
    b.date_renouvellement,
    b.date_attribution,
    b.date_resiliation,
    b.embarcation,
    b.statut,
    b.no_place,
    b.immatriculation,
    b.longueur,
    b.largeur,
    b.encombrement,
    b.coefficient,
    b.puissance_moteur,
    b.surface_voile,
    b.facture,
    b.tirant_eau,
    b.commentaire,
    b.rabais_pourcentage,
    b.tarif_special
   FROM port.por_tbl_bateaux b
     LEFT JOIN port.por_tbl_proprietaires p ON b.id_proprietaire = p.id
     LEFT JOIN ( SELECT b_1.id AS id_bateau,
            b_1.id_proprietaire,
            row_number() OVER (ORDER BY b_1.date_inscription)::integer AS no_attente,
            p_1.nom,
            p_1.prenom,
            b_1.statut,
            b_1.date_inscription
           FROM port.por_tbl_bateaux b_1
             LEFT JOIN port.por_tbl_proprietaires p_1 ON b_1.id_proprietaire = p_1.id
          WHERE p_1.ville::text = 'Nyon'::text AND b_1.statut::text = 'En attente (Eau)'::text
        UNION
         SELECT b_1.id AS id_bateau,
            b_1.id_proprietaire,
            row_number() OVER (ORDER BY b_1.date_inscription)::integer AS no_attente,
            p_1.nom,
            p_1.prenom,
            b_1.statut,
            b_1.date_inscription
           FROM port.por_tbl_bateaux b_1
             LEFT JOIN port.por_tbl_proprietaires p_1 ON b_1.id_proprietaire = p_1.id
          WHERE p_1.ville::text = 'Nyon'::text AND b_1.statut::text = 'En attente (Support, étagère)'::text
        UNION
         SELECT b_1.id AS id_bateau,
            b_1.id_proprietaire,
            row_number() OVER (ORDER BY b_1.date_inscription)::integer AS no_attente,
            p_1.nom,
            p_1.prenom,
            b_1.statut,
            b_1.date_inscription
           FROM port.por_tbl_bateaux b_1
             LEFT JOIN port.por_tbl_proprietaires p_1 ON b_1.id_proprietaire = p_1.id
          WHERE p_1.ville::text = 'Nyon'::text AND b_1.statut::text = 'En attente (TP)'::text
        UNION
         SELECT b_1.id AS id_bateau,
            b_1.id_proprietaire,
            row_number() OVER (ORDER BY b_1.date_inscription)::integer AS no_attente,
            p_1.nom,
            p_1.prenom,
            b_1.statut,
            b_1.date_inscription
           FROM port.por_tbl_bateaux b_1
             LEFT JOIN port.por_tbl_proprietaires p_1 ON b_1.id_proprietaire = p_1.id
          WHERE p_1.ville::text = 'Nyon'::text AND b_1.statut::text = 'En attente (Changement)'::text
        UNION
         SELECT b_1.id AS id_bateau,
            b_1.id_proprietaire,
            row_number() OVER (ORDER BY b_1.date_inscription)::integer AS no_attente,
            p_1.nom,
            p_1.prenom,
            b_1.statut,
            b_1.date_inscription
           FROM port.por_tbl_bateaux b_1
             LEFT JOIN port.por_tbl_proprietaires p_1 ON b_1.id_proprietaire = p_1.id
          WHERE (p_1.ville::text <> 'Nyon'::text OR p_1.ville IS NULL) AND b_1.statut::text = 'En attente (Eau)'::text
        UNION
         SELECT b_1.id AS id_bateau,
            b_1.id_proprietaire,
            row_number() OVER (ORDER BY b_1.date_inscription)::integer AS no_attente,
            p_1.nom,
            p_1.prenom,
            b_1.statut,
            b_1.date_inscription
           FROM port.por_tbl_bateaux b_1
             LEFT JOIN port.por_tbl_proprietaires p_1 ON b_1.id_proprietaire = p_1.id
          WHERE (p_1.ville::text <> 'Nyon'::text OR p_1.ville IS NULL) AND b_1.statut::text = 'En attente (Support, étagère)'::text
        UNION
         SELECT b_1.id AS id_bateau,
            b_1.id_proprietaire,
            row_number() OVER (ORDER BY b_1.date_inscription)::integer AS no_attente,
            p_1.nom,
            p_1.prenom,
            b_1.statut,
            b_1.date_inscription
           FROM port.por_tbl_bateaux b_1
             LEFT JOIN port.por_tbl_proprietaires p_1 ON b_1.id_proprietaire = p_1.id
          WHERE (p_1.ville::text <> 'Nyon'::text OR p_1.ville IS NULL) AND b_1.statut::text = 'En attente (TP)'::text
        UNION
         SELECT b_1.id AS id_bateau,
            b_1.id_proprietaire,
            row_number() OVER (ORDER BY b_1.date_inscription)::integer AS no_attente,
            p_1.nom,
            p_1.prenom,
            b_1.statut,
            b_1.date_inscription
           FROM port.por_tbl_bateaux b_1
             LEFT JOIN port.por_tbl_proprietaires p_1 ON b_1.id_proprietaire = p_1.id
          WHERE (p_1.ville::text <> 'Nyon'::text OR p_1.ville IS NULL) AND b_1.statut::text = 'En attente (Changement)'::text) foo ON b.id = foo.id_bateau
  ORDER BY p.nom, p.prenom;

COMMENT ON VIEW port.por_vtbl_bateaux_proprietaires
  IS 'Liste complète des bateaux avec leur proprietaires';
