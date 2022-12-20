#Necessite l'execution de base.sql au préalable
source donnees.sql

SELECT reference_velo, numero_adherent, date_fin_emprunt FROM historique NATURAL JOIN emprunts WHERE date_fin_emprunt IS NULL;

\! echo "Tente dinserer un emprunt du velo 44 (deja en cours d utilisation)"
INSERT INTO emprunts (numero_adherent, reference_velo) VALUES (1, 44);

# print infos
\! echo "infos sur le velo 33"
SELECT * FROM velos WHERE reference_velo = 33;
\! echo "historique concernant le velo 33"
SELECT * FROM emprunts NATURAL JOIN historique WHERE reference_velo = 33;

# debut emprunt
\! echo "adherent 1 emprunte le velo 33"
INSERT INTO emprunts (numero_adherent, reference_velo) VALUES (1, 33);

# print infos
\! echo "infos sur le velo 33"
SELECT * FROM velos WHERE reference_velo = 33;
\! echo "historique concernant le velo 33"
SELECT * FROM emprunts NATURAL JOIN historique WHERE reference_velo = 33;

# fin emprunt
\! echo "le velo 33 est rendu à la borne 15 (hors service). 250 de distance parcourue."
UPDATE historique SET date_fin_emprunt = CURRENT_TIMESTAMP, numero_borne_arrivee = 15, distance_parcourue = 250 WHERE id_historique = (SELECT max(id_historique) FROM emprunts WHERE reference_velo = 33) AND date_fin_emprunt IS NULL AND numero_borne_arrivee IS NULL AND distance_parcourue IS NULL;

\! echo "le velo 33 est rendu à la borne 25. 250 de distance parcourue."
UPDATE historique SET date_fin_emprunt = CURRENT_TIMESTAMP, numero_borne_arrivee = 25, distance_parcourue = 250 WHERE id_historique = (SELECT max(id_historique) FROM emprunts WHERE reference_velo = 33) AND date_fin_emprunt IS NULL AND numero_borne_arrivee IS NULL AND distance_parcourue IS NULL;

# print infos
\! echo "infos sur le velo 33"
SELECT * FROM velos WHERE reference_velo = 33;
\! echo "historique concernant le velo 33"
SELECT * FROM emprunts NATURAL JOIN historique WHERE reference_velo = 33;
