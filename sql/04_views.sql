-- View: port_03.por_vgeo_placement

-- DROP VIEW port_03.por_vgeo_placement;

CREATE OR REPLACE VIEW port_03.por_vgeo_placement AS 
 SELECT g.id,
    g.numero_place,
    g.statut,
    g.emplacement,
    g.type,
    foo.placement,
    g.geom
   FROM port_03.por_geo_places_bateaux g
     LEFT JOIN ( SELECT DISTINCT b.no_place,
            'occup�'::text AS placement
           FROM port_03.por_tbl_bateaux b
          WHERE b.statut::text = ANY (ARRAY['Plac�'::text, 'En attente (Changement)'::text])) foo ON g.numero_place::text = foo.no_place::text
  ORDER BY g.id;

COMMENT ON VIEW port_03.por_vgeo_placement
  IS 'Visualisation des places pour gestion QGIS';
  
  
-- View: port_03.por_vtbl_bateaux_proprietaires

-- DROP VIEW port_03.por_vtbl_bateaux_proprietaires;

CREATE OR REPLACE VIEW port_03.por_vtbl_bateaux_proprietaires AS 
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
   FROM port_03.por_tbl_bateaux b
     LEFT JOIN port_03.por_tbl_proprietaires p ON b.id_proprietaire = p.id
     LEFT JOIN ( SELECT b_1.id_proprietaire,
            row_number() OVER (ORDER BY b_1.date_inscription)::integer AS no_attente,
            p_1.nom,
            p_1.prenom,
            b_1.statut,
            b_1.date_inscription
           FROM port_03.por_tbl_bateaux b_1
             LEFT JOIN port_03.por_tbl_proprietaires p_1 ON b_1.id_proprietaire = p_1.id
          WHERE (b_1.statut::text <> ALL (ARRAY['Plac�'::character varying::text, 'R�sili�'::character varying::text])) AND p_1.ville::text = 'Nyon'::text
        UNION
         SELECT b_1.id_proprietaire,
            row_number() OVER (ORDER BY b_1.date_inscription)::integer AS no_attente,
            p_1.nom,
            p_1.prenom,
            b_1.statut,
            b_1.date_inscription
           FROM port_03.por_tbl_bateaux b_1
             LEFT JOIN port_03.por_tbl_proprietaires p_1 ON b_1.id_proprietaire = p_1.id
          WHERE (b_1.statut::text <> ALL (ARRAY['Plac�'::character varying::text, 'R�sili�'::character varying::text])) AND (p_1.ville::text <> 'Nyon'::text OR p_1.ville IS NULL)) foo ON p.id = foo.id_proprietaire
  ORDER BY p.nom, p.prenom;

COMMENT ON VIEW port_03.por_vtbl_bateaux_proprietaires
  IS 'Liste compl�te des bateaux avec leur proprietaires';