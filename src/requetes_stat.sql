# moyenne du nombre d’usagers par vélo par jour

select DATE_JOUR, avg(NB_USAGER) as MOY_USAGER_PAR_VELO 
    from 
    (
        select reference_velo, count(id_historique) as NB_USAGER, DATE(date_debut_emprunt) as DATE_JOUR
        from emprunts natural join historique 
        group by DATE_JOUR, reference_velo
    ) as SUB
group by DATE_JOUR
;

# moyenne des distances parcourues par les vélos sur une semaine

set @variable_date = '2021-01-01';

select @variable_date as DATE_DEBUT_SEMAINE, avg(DISTANCE) as MOY_DISTANCES_PARCOURUES 
    from 
    (
        select reference_velo, sum(distance_parcourue) as DISTANCE
        from emprunts natural join historique 
        where date_debut_emprunt between @variable_date and  @variable_date + INTERVAL 7 DAY
        group by reference_velo
    ) as SUB
;

# classement des stations par nombre de places disponibles par commune


select nom_commune, stations.numero_station, count(numero_borne) as NB_PLACES_DISPONIBLES 
    from stations natural join bornes natural join communes where numero_borne in 
    (
    select numero_borne from bornes 
    except
    select numero_borne from bornes where etat_borne = "hors service"
    except
    select numero_borne from velos
    )
group by nom_commune, stations.numero_station
order by NB_PLACES_DISPONIBLES desc
;

# classement des vélos les plus chargés par station
select numero_station, reference_velo, niveau_batterie from velos natural join stations natural join bornes
order by numero_station asc, niveau_batterie desc
;
