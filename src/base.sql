# ============================================================
#   Nom de la base   :  Locations_velo
#   Nom du fichier   :  base.sql
#   Nom de SGBD      :  MySQL Version 8.0.27
# ============================================================


DROP DATABASE IF EXISTS Locations_velo;
CREATE DATABASE Locations_velo;
USE Locations_velo;

CREATE TABLE `communes`
(
	id_commune INT UNSIGNED AUTO_INCREMENT,
	code_postale INT NOT NULL,
	nom_commune VARCHAR(40) NOT NULL,
	PRIMARY KEY (id_commune)
);

CREATE TABLE `stations`
(
	numero_station INT AUTO_INCREMENT,
	adresse_station	CHAR(50) NOT NULL,
	id_commune INT UNSIGNED,
	PRIMARY KEY(numero_station)
);

CREATE TABLE `distance`
(
	numero_station_A INT NOT NULL,
	numero_station_B INT NOT NULL,
	distance INT,
	PRIMARY KEY(numero_station_A,numero_station_B)
);

CREATE TABLE `bornes`
(
	numero_borne INT AUTO_INCREMENT,
	etat_borne CHAR(50),
	numero_station INT NOT NULL,
	PRIMARY KEY (numero_borne)	
);

CREATE TABLE `emprunts`
(
	numero_adherent INT,
	reference_velo INT,
	id_historique INT DEFAULT -1,
	PRIMARY KEY (id_historique)
);

CREATE TABLE `historique`
(
	id_historique INT AUTO_INCREMENT,
	date_debut_emprunt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	date_fin_emprunt DATETIME,
	numero_borne_depart INT,
	numero_borne_arrivee INT,
	distance_parcourue INT,
	PRIMARY KEY (id_historique)
);



CREATE TABLE `velos`
(
	reference_velo INT,
	numero_borne INT UNIQUE,
	marque CHAR(50),
	kilometrage INT NOT NULL,
	etat CHAR(50),
	niveau_batterie INT NOT NULL,
	date_mise_en_service TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (reference_velo)
);

CREATE TABLE `adherents` 
(
	numero_adherent INT AUTO_INCREMENT,
	nom_adherent CHAR(50),
	prenom_adherent CHAR(50),
	adresse_adherent CHAR(100),
	commune_adherent CHAR(50),
	date_adhesion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (numero_adherent)
);


CREATE TABLE `abonnements`
(
	id_abonnement INT,
	type_abonnement CHAR(50),
	tarif INT NOT NULL,
	PRIMARY KEY (id_abonnement)	
);


CREATE TABLE `historique_ab`
(
	id_historique_ab INT AUTO_INCREMENT,
	date_debut_abo TIMESTAMP,
	date_fin_abo TIMESTAMP,
	PRIMARY KEY (id_historique_ab)	
);

CREATE TABLE `etre_souscrit` 
(
	numero_adherent INT,
	id_abonnement INT,
	id_historique_ab INT NOT NULL,
	PRIMARY KEY (id_historique_ab)
);

ALTER TABLE `stations`
ADD CONSTRAINT `fk1_stations` FOREIGN KEY (id_commune)
REFERENCES `communes`(id_commune) ON DELETE SET NULL;

ALTER TABLE `bornes`
ADD CONSTRAINT `fk1_bornes` FOREIGN KEY (numero_station)
REFERENCES `stations`(numero_station) ON DELETE CASCADE;  

ALTER TABLE `velos`
ADD CONSTRAINT `fk1_velos` FOREIGN KEY (numero_borne)
REFERENCES `bornes`(numero_borne) ON DELETE SET NULL;


ALTER TABLE `emprunts`
ADD CONSTRAINT `fk1_emprunts` FOREIGN KEY (numero_adherent)
REFERENCES `adherents`(numero_adherent) ON DELETE SET NULL;

ALTER TABLE `emprunts`
ADD CONSTRAINT `fk2_emprunts` FOREIGN KEY (reference_velo)
REFERENCES `velos`(reference_velo) ON DELETE SET NULL;

ALTER TABLE `emprunts`
ADD CONSTRAINT `fk3_emprunts` FOREIGN KEY (id_historique)
REFERENCES `historique`(id_historique) ON DELETE CASCADE;

ALTER TABLE `historique`
ADD CONSTRAINT `fk1_historique` FOREIGN KEY (numero_borne_depart)
REFERENCES `bornes`(numero_borne) ON DELETE SET NULL;

ALTER TABLE `historique`
ADD CONSTRAINT `fk2_historique` FOREIGN KEY (numero_borne_arrivee)
REFERENCES `bornes`(numero_borne) ON DELETE SET NULL; 


ALTER TABLE `distance`
ADD CONSTRAINT `fk1_distance` FOREIGN KEY (numero_station_A)
REFERENCES `stations`(numero_station) ON DELETE CASCADE;

ALTER TABLE `distance`
ADD CONSTRAINT `fk2_distance` FOREIGN KEY (numero_station_B)
REFERENCES `stations`(numero_station) ON DELETE CASCADE;


ALTER TABLE `etre_souscrit`
ADD CONSTRAINT `fk1_etre_souscrit` FOREIGN KEY (numero_adherent)
REFERENCES `adherents`(numero_adherent) ON DELETE SET NULL;

ALTER TABLE `etre_souscrit`
ADD CONSTRAINT `fk2_etre_souscrit` FOREIGN KEY (id_abonnement)
REFERENCES `abonnements`(id_abonnement) ON DELETE SET NULL;

ALTER TABLE `etre_souscrit`
ADD CONSTRAINT `fk3_etre_souscrit` FOREIGN KEY (id_historique_ab)
REFERENCES `historique_ab`(id_historique_ab) ON DELETE CASCADE;
