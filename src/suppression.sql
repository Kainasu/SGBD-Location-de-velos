# Suppression des donnees

DELETE FROM communes;
ALTER TABLE communes AUTO_INCREMENT = 1;

DELETE FROM stations;
ALTER TABLE stations AUTO_INCREMENT = 1;

DELETE FROM bornes;
ALTER TABLE bornes AUTO_INCREMENT = 1;

DELETE FROM distance;
DELETE FROM velos;
DELETE FROM adherents;
DELETE FROM emprunts;

DELETE FROM historique;
ALTER TABLE historique AUTO_INCREMENT = 1;

DELETE FROM abonnements;
DELETE FROM etre_souscrit;

DELETE FROM historique_ab;
ALTER TABLE historique_ab AUTO_INCREMENT = 1;
