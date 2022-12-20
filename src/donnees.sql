# ============================================================
#   Nom de la base   :  Locations_velo
#   Nom du fichier   :  donnees.sql
#   Nom de SGBD      :  MySQL Version 8.0.27
# ============================================================

source supression.sql

INSERT INTO communes(code_postale, nom_commune) VALUES
(33440, 'Ambarès-et-Lagrave'),
(33810, 'Ambès'),
(33370, 'Artigues-près-Bordeaux'),
(33530, 'Bassens'),
(33130, 'Bègles'),
(33290, 'Blanquefort'),
(33270, 'Bouliac'),
(33110, 'Le Bouscat'),
(33520, 'Bruges'),
(33560, 'Carbon-Blanc'),
(33150, 'Cenon'),
(33320, 'Eysines'),
(33270, 'Floirac'),
(33170, 'Gradignan'),
(33185, 'Le Haillan'),
(33310, 'Lormont'),
(33127, 'Martignas-sur-Jalle'),
(33700, 'Mérignac'),
(33290, 'Parempuyre'),
(33600, 'Pessac'),
(33160, 'Saint-Aubin-de-Médoc'),
(33440, 'Saint-Louis-de-Montferrand'),
(33160, 'Saint-Médard-en-Jalles'),
(33440, 'Saint-Vincent-de-Paul'),
(33320, 'Le Taillan-Médoc'),
(33400, 'Talence'),
(33000, 'Bordeaux');

INSERT INTO stations (numero_station, adresse_station, id_commune)
 VALUES
 (1, '5 rue de la liberté', 1),
 (2, '8 avenue collegno', 2),
 (3, '3 rue de de la mort', 3),
 (4, '4 rue de paradis', 4),
 (5, '5 rue saint-louis', 5),
 (6, '8 avenue joyeuse', 6),
 (7, '3 rue de Marie', 7),
 (8, '4 rue de alos', 8),
 (9, '3 avenue bardanac', 7);

 INSERT INTO distance (numero_station_A, numero_station_B, distance)
 VALUES
 (1,2,10),
 (1,3,20),
 (1,4,20),
 (1,5,15),
 (1,6,20),
 (1,7,10),
 (1,8,10),
 (1,9,20),
 (2,3,16),
 (2,4,10),
 (2,5,24),
 (2,6,10),
 (2,7,23),
 (2,8,19),
 (2,9,10),
 (3,4,10),
 (3,5,10),
 (3,6,10),
 (3,7,10),
 (3,8,10),
 (3,9,10),
 (4,5,10),
 (4,6,10),
 (4,7,10),
 (4,8,10),
 (4,9,10),
 (5,6,10),
 (5,7,10),
 (5,8,10),
 (5,9,10),
 (6,7,10),
 (6,8,10),
 (6,9,10),
 (7,8,10),
 (7,9,10),
 (8,9,10);



INSERT INTO bornes (numero_borne, etat_borne, numero_station)
 VALUES
 (1, 'en service', 1),
 (2, 'hors service', 1),
 (3, 'en service', 1),
 (4, 'hors service', 2),
 (5, 'en service', 2),
 (6, 'en service', 3),
 (7, 'hors service', 3),
 (8, 'en service', 4),
 (9, 'en service', 4),
 (10, 'en service', 4),
 (11, 'en service', 5),
 (12, 'en service', 6),
 (13, 'en service', 7),

 (14, 'en service', 7),
 (15, 'hors service', 5),
 (16, 'hors service', 4),
 (17, 'en service', 8),
 (18, 'hors service', 3),
 (19, 'en service', 1),
 (20, 'en service', 1),
 (21, 'en service', 7),

 (22, 'en service', 9),
 (23, 'hors service', 9),
 (24, 'hors service', 9),
 (25, 'en service', 9),
 (26, 'en service', 9);



INSERT INTO velos (reference_velo, numero_borne, marque, kilometrage, etat, niveau_batterie, date_mise_en_service)
 VALUES
 (11,1,'Gazelle', 40, 'en service', 45, '2021-01-01 00:00:00'),
 (22,2,'Electra', 0, 'en service', 90, '2021-01-01 00:00:00'),
 (33,3,'Cube', 58, 'en service', 15, '2021-01-01 00:00:00'),
 (44,4,'Electra', 40, 'en service', 90, '2021-01-01 00:00:00'),
 (55,5,'Cube', 1, 'hors service', 12, '2021-01-01 00:00:00'),
 (66,6,'Gazelle', 40, 'en service', 90, '2021-01-01 00:00:00'),
 (77,7,'Gazelle', 12, 'en service', 10, '2021-01-01 00:00:00'),
 (88,8,'Gazelle', 40, 'hors service', 90, '2021-01-01 00:00:00'),
 (99,9,'Electra', 15, 'en service', 40, '2021-01-01 00:00:00');
 


INSERT INTO adherents (numero_adherent, nom_adherent, prenom_adherent, adresse_adherent, commune_adherent, date_adhesion)
 VALUES
 (1, 'APALI', 'Julien', '5 avenue Collegno', 'Talence', '2021-01-01 00:00:00'),
 (2, 'MADOUMA','Pierre', '6 avenue Pessac', 'Pessac', '2021-02-01 00:00:00'),
 (3, 'RICHARD', 'Nicolas', '7 avenue Laposte', 'Merignac', '2021-03-01 00:00:00'),
 (4, 'PETIT', 'Sylvain', '8 avenue Collegno', 'Talence', '2021-04-01 00:00:00'),
 (5, 'GRAND', 'Simon', '9 avenue raha', 'Etranger', '2021-05-01 00:00:00'),
 (6, 'HUET', 'Sylvain', '10 avenue Collegno', 'Talence', '2021-06-01 00:00:00'),
 (7, 'MOREL', 'Christophe', '11 avenue Cenon', 'Cenon', '2021-03-01 00:00:00'),
 (8, 'DUBOIS', 'Edgar', '5 avenue Collegno', 'Talence', '2021-04-01 00:00:00'),
 (9, 'DUSEL', 'Lucas', '5 avenue Collegno', 'Talence', '2021-05-01 00:00:00'),
 (10, 'BERNARD', 'Samuel', '2 avenue Collegno', 'Talence', '2021-03-01 00:00:00'),
 (11, 'LAPOIRE', 'Cedrine', '3 avenue Collegno', 'Talence', '2021-04-01 00:00:00'),
 (12, 'NOEL', 'Maxime', '1 avenue Collegno', 'Talence', '2021-05-01 00:00:00'),
 (13, 'LEROY', 'Minime', '1 avenue Collegno', 'Talence', '2021-03-01 00:00:00');


INSERT INTO abonnements (id_abonnement, type_abonnement, tarif)
 VALUES
 (1, 'VBASIQUE', 5),
 (2, 'VPLUS', 7),
 (3, 'VMAX', 10);


INSERT INTO historique_ab (date_debut_abo, date_fin_abo)
 VALUES
 ('2021-01-01 00:00:00', '2022-01-01 00:00:00'),
 ('2021-02-01 00:00:00', '2021-03-01 00:00:00'),
 ('2021-03-01 00:00:00', '2021-04-01 00:00:00'),
 ('2021-04-01 00:00:00', '2021-08-01 00:00:00'),
 ('2021-05-01 00:00:00', '2021-06-01 00:00:00'),
 ('2021-06-01 00:00:00', '2021-08-01 00:00:00'),
 ('2021-03-01 00:00:00', '2021-04-01 00:00:00'),
 ('2021-04-01 00:00:00', '2021-08-01 00:00:00'),
 ('2021-05-01 00:00:00', '2021-06-01 00:00:00'),
 ('2021-03-01 00:00:00', '2021-04-01 00:00:00'),
 ('2021-04-01 00:00:00', '2021-08-01 00:00:00'),
 ('2021-05-01 00:00:00', '2021-06-01 00:00:00'),
 ('2021-03-01 00:00:00', '2021-04-01 00:00:00');

INSERT INTO historique (date_debut_emprunt, date_fin_emprunt, numero_borne_depart, numero_borne_arrivee, distance_parcourue)
 VALUES
 ('2021-01-01 12:00:00', '2021-01-01 12:30:00', 2, 3, 10), 
 ('2021-01-01 12:00:00', '2021-01-01 12:30:00', 2, 4, 10), 
 ('2021-01-01 12:35:00', '2021-01-01 13:05:00', 4, 5, 20),
 ('2021-01-01 13:10:00', '2021-01-01 13:40:00', 3, 6, 6),
 ('2021-01-01 13:45:00', '2021-01-01 13:15:00', 1, 2, 13),
 ('2021-01-01 18:00:00', '2021-01-01 18:15:00', 1, 1, 3),
 
 ('2021-02-01 11:00:00', '2021-02-01 12:00:00', 1, 2, 20),
 ('2021-02-01 13:00:00', '2021-02-01 15:00:00', 2, 3, 40),
 
 ('2021-11-30 15:00:00', '2021-11-30 18:00:00', 2, 3, 15),
 
 ('2021-04-10 10:00:00', '2021-04-10 11:00:00', 2, 5, 9),
 ('2021-04-10 12:00:00', '2021-04-10 15:00:00', 3, 4, 10),
 ('2021-04-10 16:00:00', '2021-04-10 18:00:00', 5, 4, 10);


INSERT INTO emprunts (numero_adherent, reference_velo, id_historique) VALUES
 (11, 11, 1),
 (13, 11, 2),
 (12, 11, 3),
 (11, 22, 4),
 (13, 11, 5),
 (11, 22, 6),
 (2,  33, 7),
 (2,  11, 8),
 (3,  22, 9),
 (5,  33, 10),
 (4,  11, 11),
 (4,  11, 12);

INSERT INTO emprunts(numero_adherent, reference_velo) VALUES (1, 44);
 

INSERT INTO etre_souscrit (numero_adherent, id_abonnement, id_historique_ab)
 VALUES
 (1, 1, 1),
 (2, 1, 8),
 (3, 2, 3),
 (4, 1, 4),
 (5, 2, 5),
 (6, 2, 7),
 (7, 2, 6),
 (8, 1, 2),
 (9, 1, 9),
 (10, 1, 10),
 (11, 2, 11),
 (12, 2, 13),
 (13, 1, 12);
 
