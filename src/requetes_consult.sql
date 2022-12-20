# ==============
# Consultations
# ==============

# Informations sur les velos 

SELECT * FROM velos;

# Informations sur les stations 

SELECT numero_station, adresse_station, code_postale, nom_commune
FROM stations NATURAL JOIN communes;

# Informations sur les adherents 

SELECT * FROM adherents;

# Liste de velos par stations 

SELECT numero_station, numero_borne, reference_velo
FROM velos NATURAL JOIN bornes
ORDER BY numero_station ASC;

# Liste des velos en cours d utilisation 

select reference_velo, marque, date_mise_en_service , numero_adherent, date_debut_emprunt
from velos natural join emprunts natural join historique
where date_fin_emprunt IS NULL;

# Liste des stations dans une commune donnée 

set @commune = 1;
select numero_station, adresse_station, code_postale, nom_commune
from stations natural join communes
where id_commune = @commune;

# Liste des adherents qui ont emprunté au moins deux velos differents pour un jour donné 

# '2021-04-10'
set @jour = '2021-01-01'; 
select CAST(date_debut_emprunt AS DATE) as jour, numero_adherent, nom_adherent, prenom_adherent, count(*) as Nb_velo_emprunte
from adherents natural join emprunts natural join historique
where CAST(date_debut_emprunt AS DATE) = @jour
group by jour, numero_adherent, nom_adherent, prenom_adherent
having count(*) >=2;






