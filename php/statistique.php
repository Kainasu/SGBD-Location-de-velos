<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="main.css" />
    </head>
    <body>
        <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']) ?>" method="post">
            <div>
                <label for="request_selection">statistique à afficher:</label>
                <select name="request_selection" id="request_selection">
                    <option value="" selected="selected">--- Choisissez une statistique ---</option>
                    <option value="req1">Moyenne du nombre d’usagers par vélo par jour</option>
                    <option value="req2">Moyenne des distances parcourues par les vélos sur une semaine</option>
                    <option value="req3">Classement des stations par nombre de places disponibles par commune</option>
                    <option value="req4">Classement des vélos les plus chargés par station</option>
                </select>
            </div>
            <div>
                <button type="submit">Afficher </button>
            </div>
        </form>
    <?php
        include "connect.php";
        $requestNumber = filter_input(INPUT_POST, 'request_selection', FILTER_SANITIZE_STRING);
        if ($requestNumber)
        {
            $request="";
            switch ($requestNumber) 
            {
                case "req1":
                    $request = "select DATE_JOUR, avg(NB_USAGER) as MOY_USAGER_PAR_VELO 
                    from 
                    (
                        select reference_velo, count(id_historique) as NB_USAGER, DATE(date_debut_emprunt) as DATE_JOUR
                        from emprunts natural join historique 
                        group by DATE_JOUR, reference_velo
                    ) as SUB
                group by DATE_JOUR
                ;";
                    break;
                case "req2":
                    $request = "select '2021-01-01' as DATE_DEBUT_SEMAINE, avg(DISTANCE) as MOY_DISTANCES_PARCOURUES 
                        from 
                        (
                            select reference_velo, sum(distance_parcourue) as DISTANCE
                            from emprunts natural join historique 
                            where date_debut_emprunt between '2021-01-01' and  '2021-01-01' + INTERVAL 7 DAY
                            group by reference_velo
                        ) as SUB
                    ;";
                    break;
                case "req3":
                    $request = "select nom_commune, stations.numero_station, count(numero_borne) as NB_PLACES_DISPONIBLES 
                    from stations natural join bornes natural join communes where numero_borne in 
                    (
                    select numero_borne from bornes 
                    except
                    select numero_borne from bornes where etat_borne = 'hors service'
                    except
                    select numero_borne from velos
                    )
                group by nom_commune, stations.numero_station
                order by NB_PLACES_DISPONIBLES desc
                ;";
                    break;
                case "req4":
                    $request = "select numero_station, reference_velo, niveau_batterie from velos natural join stations natural join bornes
                    order by numero_station asc, niveau_batterie desc
                    ;";
                    break;
            }

            //get results from database
            $result = mysqli_query($connection, $request);
            $all_property = array();  //declare an array for saving property

            //showing property
            echo '<table class="data-table">
            <tr class="data-heading">';  //initialize table tag
            while ($property = mysqli_fetch_field($result)) 
            {
                echo '<td>' . $property->name . '</td>';  //get field name for header
                array_Push($all_property, $property->name);  //save those to array
            }
            echo '</tr>'; //end tr tag

            //showing all data
            while ($row = mysqli_fetch_array($result)) 
            {
                echo "<tr>";
                foreach ($all_property as $item) 
                {
                    echo '<td>' . $row[$item] . '</td>'; //get items using property value
                }
                echo '</tr>';
            }   
            echo "</table>";
        }

    ?>
    <a type="submit" href="index.php?action=home">Retourner à la page d'acceuil</a>
    </body>
</html>
