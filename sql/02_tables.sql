-- Table: port.por_geo_equipements_lineaires

-- DROP TABLE port.por_geo_equipements_lineaires;

CREATE TABLE port.por_geo_equipements_lineaires
(
  id serial NOT NULL,
  type character varying(50),
  diametre_m integer,
  geom geometry(MultiLineString,2056),
  CONSTRAINT por_geo_equipements_lineaires_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE port.por_geo_equipements_lineaires
  IS 'Equipements portuaires (lignes)';

-- Index: port.por_geo_equipements_lineaires_geom_149318868113

-- DROP INDEX port.por_geo_equipements_lineaires_geom_149318868113;

CREATE INDEX por_geo_equipements_lineaires_geom_149318868113
  ON port.por_geo_equipements_lineaires
  USING gist
  (geom);

-- Table: port.por_geo_equipements_ponctuels

-- DROP TABLE port.por_geo_equipements_ponctuels;

CREATE TABLE port.por_geo_equipements_ponctuels
(
  id serial NOT NULL,
  type character varying(50),
  geom geometry(Point,2056),
  CONSTRAINT por_geo_equipements_ponctuels_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE port.por_geo_equipements_ponctuels
  IS 'Equipements portuaires (points)';

-- Index: port.por_geo_equipements_ponctuels_geom_1493189692587

-- DROP INDEX port.por_geo_equipements_ponctuels_geom_1493189692587;

CREATE INDEX por_geo_equipements_ponctuels_geom_1493189692587
  ON port.por_geo_equipements_ponctuels
  USING gist
  (geom);
  
-- Table: port.por_geo_equipements_surfaciques

-- DROP TABLE port.por_geo_equipements_surfaciques;

CREATE TABLE port.por_geo_equipements_surfaciques
(
  id serial NOT NULL,
  type character varying(50),
  indication character varying(50),
  geom geometry(MultiPolygon,2056),
  CONSTRAINT por_geo_equipements_surfaciques_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE port.por_geo_equipements_surfaciques
  IS 'Equipements portuaires (surfaces)';

-- Index: port.por_geo_equipements_surfaciques_geom_146159173514

-- DROP INDEX port.por_geo_equipements_surfaciques_geom_146159173514;

CREATE INDEX por_geo_equipements_surfaciques_geom_146159173514
  ON port.por_geo_equipements_surfaciques
  USING gist
  (geom);
  
-- Table: port.por_geo_esatacades_labels

-- DROP TABLE port.por_geo_esatacades_labels;

CREATE TABLE port.por_geo_esatacades_labels
(
  id serial NOT NULL,
  nom character varying(50),
  geom geometry(Point,2056),
  CONSTRAINT por_geo_esatacades_labels_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE port.por_geo_esatacades_labels
  IS 'Labels pours les estacades (pontons)';

-- Index: port.por_geo_esatacades_labels_geom_149318868110

-- DROP INDEX port.por_geo_esatacades_labels_geom_149318868110;

CREATE INDEX por_geo_esatacades_labels_geom_149318868110
  ON port.por_geo_esatacades_labels
  USING gist
  (geom);



-- Table: port.por_geo_places_bateaux

-- DROP TABLE port.por_geo_places_bateaux;

CREATE TABLE port.por_geo_places_bateaux
(
  id serial NOT NULL,
  numero_place character varying(50),
  statut character varying(50),
  emplacement character varying(50),
  type character varying(50),
  geom geometry(MultiPolygon,2056),
  CONSTRAINT por_geo_places_bateaux_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE port.por_geo_places_bateaux
  IS 'Places de ports pour bateaux';

-- Index: port.por_geo_places_bateaux_geom_14615917353

-- DROP INDEX port.por_geo_places_bateaux_geom_14615917353;

CREATE INDEX por_geo_places_bateaux_geom_14615917353
  ON port.por_geo_places_bateaux
  USING gist
  (geom);

-- Table: port.por_geo_points_bathymetriques

-- DROP TABLE port.por_geo_points_bathymetriques;

CREATE TABLE port.por_geo_points_bathymetriques
(
  id serial NOT NULL,
  profondeur_m real,
  geom geometry(Point,2056),
  CONSTRAINT por_geo_points_bathymetriques_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE port.por_geo_points_bathymetriques
  IS 'Points bathymetriques (profondeur)';

-- Index: port.por_geo_points_bathymetriques_geom_14931886818

-- DROP INDEX port.por_geo_points_bathymetriques_geom_14931886818;

CREATE INDEX por_geo_points_bathymetriques_geom_14931886818
  ON port.por_geo_points_bathymetriques
  USING gist
  (geom);

-- Table: port.por_geo_sauvetage

-- DROP TABLE port.por_geo_sauvetage;

CREATE TABLE port.por_geo_sauvetage
(
  id serial NOT NULL,
  type character varying(200),
  geom geometry(MultiPolygon,2056),
  CONSTRAINT por_geo_sauvetage_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE port.por_geo_sauvetage
  IS 'Emplacements pour sauvetages';

-- Index: port.por_geo_sauvetage_geom_146159173521

-- DROP INDEX port.por_geo_sauvetage_geom_146159173521;

CREATE INDEX por_geo_sauvetage_geom_146159173521
  ON port.por_geo_sauvetage
  USING gist
  (geom);
  
-- Table: port.por_tbl_proprietaires

-- DROP TABLE port.por_tbl_proprietaires;

CREATE TABLE port.por_tbl_proprietaires
(
  id serial NOT NULL,
  nom character varying(255),
  prenom character varying(255),
  adresse character varying(255),
  npa integer,
  ville character varying(100),
  tel character varying(20),
  nom_prenom character varying(255),
  email character varying(255),
  CONSTRAINT por_tbl_proprietaires_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE port.por_tbl_proprietaires
  IS 'Table des propriétaires';

-- Table: port.por_tbl_bateaux

-- DROP TABLE port.por_tbl_bateaux;

CREATE TABLE port.por_tbl_bateaux
(
  id serial NOT NULL,
  id_proprietaire integer,
  statut character varying(50),
  no_place character varying(20),
  taxe_triple character varying(3),
  date_inscription date,
  date_renouvellement date,
  date_attribution date,
  date_resiliation date,
  embarcation character varying(100),
  immatriculation character varying(20),
  longueur real,
  largeur real,
  encombrement real,
  coefficient real,
  puissance_moteur real,
  surface_voile real,
  facture character varying(5),
  tirant_eau real,
  commentaire character varying(255),
  rabais_pourcentage integer DEFAULT 0,
  tarif_special integer DEFAULT 0,
  CONSTRAINT por_tbl_bateaux_pkey PRIMARY KEY (id),
  CONSTRAINT fk_id_proprietaire FOREIGN KEY (id_proprietaire)
      REFERENCES port.por_tbl_proprietaires (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE port.por_tbl_bateaux
  IS 'Table des bateaux';

-- Index: port.fki_id_proprietaire

-- DROP INDEX port.fki_id_proprietaire;

CREATE INDEX fki_id_proprietaire
  ON port.por_tbl_bateaux
  USING btree
  (id_proprietaire);
  
-- Table: port.por_tbl_evenements

-- DROP TABLE port.por_tbl_evenements;

CREATE TABLE port.por_tbl_evenements
(
  id serial NOT NULL,
  id_equipement integer,
  description character varying(255),
  localisation character varying(255),
  fournisseur character varying(100),
  cout integer,
  date_evenement date,
  budget integer,
  CONSTRAINT por_tbl_evenements_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE port.por_tbl_evenements
  OWNER TO sitnyon;

COMMENT ON TABLE port.por_tbl_evenements
  IS 'Table des évenements (travaux port)';
