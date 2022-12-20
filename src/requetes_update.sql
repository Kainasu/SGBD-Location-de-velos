# ================================
# 1. Exemples de requetes d insersion
# ================================

source supression.sql

# ajouter une nouvelle commune dans la relation `communes`
INSERT INTO communes(id_commune, code_postale, nom_commune) VALUES (10, 33400, 'Talence')
;
# ou
INSERT INTO communes(code_postale, nom_commune) VALUES (33400, 'Pessac')
;

# ajouter une nouvelle station dans la relation `stations`
INSERT INTO stations(numero_station, adresse_station, id_commune) VALUES (10, '3 avenue bardanac', 10)
;
# ou
INSERT INTO stations(adresse_station, id_commune) VALUES ('15 cours de la liberation', 11)
;

# ajouter une distance entre deux stations dans la relation `distance`
INSERT INTO distance (numero_station_A, numero_station_B, distance) VALUES (10, 11, 100)
;

# ajouter une nouvelle borne à une station dans la relation `bornes`
INSERT INTO bornes (numero_borne, etat_borne, numero_station) VALUES (5, 'en service', 11)
;
#ou
INSERT INTO bornes (etat_borne, numero_station) VALUES ('en service', 10)
;

# ajouter un vélo dans la relation `velos` 
INSERT INTO velos (reference_velo, numero_borne, marque, kilometrage, etat, niveau_batterie, date_mise_en_service)
VALUES (19, 6, 'nakamura', 1000, 'en service', 99, '2020-12-20 16:50:00')
;

# ajouter un adherent dans la relation `adherents`
INSERT INTO adherents (numero_adherent, nom_adherent, prenom_adherent, adresse_adherent, commune_adherent, date_adhesion)
VALUES (777, 'Dupont', 'Tom', '5 avenue Collegno', 'Talence', '2021-05-24 11:30:00')
;

# ajouter un nouvel abonnement dans la relation `abonnements`
INSERT INTO abonnements (id_abonnement, type_abonnement, tarif) VALUES (501, 'ABVELO-BASIQUE', 3)
;
INSERT INTO abonnements (id_abonnement, type_abonnement, tarif) VALUES (502, 'ABVELO-PLUS', 5)
;
INSERT INTO abonnements (id_abonnement, type_abonnement, tarif) VALUES (503, 'ABVELO-MAX', 8)
;

# ajouter un nouvel historique dabonnement dans la relation `historique_ab`
INSERT INTO historique_ab (id_historique_ab, date_debut_abo, date_fin_abo) 
VALUES (333, '2021-05-24 11:30:00', '2021-06-24 16:00:00')
;
#ou
INSERT INTO historique_ab (date_debut_abo, date_fin_abo) VALUES ('2021-05-24 11:30:00', '2021-06-24 16:00:00')
;

# ajouter un nouvel historique sur les emprunts dans la relation `historique`
INSERT INTO historique (id_historique, date_debut_emprunt, date_fin_emprunt, numero_borne_depart, numero_borne_arrivee, distance_parcourue)
VALUES (70, '2021-01-01 12:00:00', '2021-01-01 12:30:00', 6, NULL , 40)
;
#ou
INSERT INTO historique (date_debut_emprunt, date_fin_emprunt, numero_borne_depart, numero_borne_arrivee, distance_parcourue)
VALUES ('2021-02-02 17:30:00', '2021-02-02 18:30:00', 5, 6, 30)
;

# ajouter un nouvel emprunt dans la relation `emprunts`
INSERT INTO emprunts (numero_adherent, reference_velo, id_historique) VALUES (777, 19, 70)
;
#ou (emprunt en cours)
INSERT INTO emprunts (numero_adherent, reference_velo) VALUES (777, 19);

# ajouter une nouvelle souscription dans la relation `etre_souscrit`
INSERT INTO etre_souscrit (numero_adherent, id_abonnement, id_historique_ab) VALUES (777, 502, 333)
;

# ==================================
# 2. Exemples de requetes de suppression 
# ==================================


# supprimer les souscriptions de ladherent numero 777
DELETE FROM etre_souscrit where numero_adherent = 777
;

# supprimer les emprunts du vélo 19
DELETE FROM emprunts where reference_velo = 19
;
# supprimer les emprunts de ladherent 777
DELETE FROM emprunts where numero_adherent = 777
;


# supprimer l historique des emprunts qui depassent deux ans
DELETE FROM historique where DATE(date_fin_emprunt) < CURRENT_DATE() - INTERVAL 2 YEAR
;

# supprimer l historique des emprunts dont la distance est inferieure à 2 
DELETE FROM historique where distance_parcourue < 2
;


# supprimer les abonnements du type 'ABVELO-PLUS'
DELETE FROM abonnements where type_abonnement = 'ABVELO-PLUS'
;

# supprimer les adherents qui ont pour commune 'Talence'
DELETE FROM adherents where commune_adherent = 'Talence'
;

# supprimer les velos qui ont un etat 'hors service'
DELETE FROM velos where etat = 'hors service'
;

# supprimer les bornes de la station '10'
DELETE FROM bornes where numero_station = 10
;

# supprimer les stations de la commune 'Talence'
DELETE FROM stations where id_commune in 
(select id_commune from communes where nom_commune = 'Talence')
;

# ======================================
# 3. Exemples de requetes de mise à jour
# ======================================


# Mettre a jour le tarif de l abonnement du type 'ABVELO-MAX' à 5
UPDATE abonnements SET tarif = 5 where type_abonnement = 'ABVELO-MAX'
;


# Mettre à jour la borne_arrivee d un emprunts dans l historique
UPDATE historique SET numero_borne_arrivee = 5 where id_historique = 70
;
#ou rendu d un velo emprunté
UPDATE historique
SET date_fin_emprunt = CURRENT_TIMESTAMP, numero_borne_arrivee = 5, distance_parcourue = 1000
where id_historique = (SELECT max(id_historique)
      		      FROM emprunts
		      WHERE reference_velo = 19)		      
AND date_fin_emprunt IS NULL
AND numero_borne_arrivee IS NULL
AND distance_parcourue IS NULL
;

# Mettre à jour l etat des velos de la station 6
UPDATE velos SET etat = "en service" where numero_borne in
(select numero_borne from `bornes` where numero_station = 6)
;

