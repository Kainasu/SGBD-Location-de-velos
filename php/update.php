<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="main.css" />
    </head>
    <body>

      
      <select onChange="changeOptions(this)">
	<option value="" selected="selected">Selectionner une action</option>
	<option value="debut_emprunt">Debut emprunt</option>
	<option value="fin_emprunt">Fin emprunt</option>
	<option value="delete_emprunt">Supprimer dans l'historique</option>
      </select>
	
	<form class='className' method="POST" action="" name="debut_emprunt" id="debut_emprunt" style="display:none">
	  <input type="number" name="numero_adherent" placeholder="n°adhérent" />
	  <input type="number" name="reference_velo" placeholder="ref vélo" />
	  <!--<input type="number" name="numero_borne_depart" placeholder="borne d'emprunt" />-->
	  <input type="submit" value="OK" />
	</form>
	
	  <form class='className' method="POST" action="" name="fin_emprunt" id="fin_emprunt" style="display:none"> 
	    <!--<input type="number" name="numero_adherent_arrivee" placeholder="n°adhérent" />-->
	    <input type="number" name="reference_velo_arrivee" placeholder="ref vélo" />
	    <input type="number" name="numero_borne_arrivee" placeholder="borne d'arrivee" />
	    <input type="number" name="distance_parcourue" placeholder="distance parcourue" /> 
	    <input type="submit" value="OK" />
	  </form>

	  <form class='className' method="POST" action="" name="delete_emprunt" id="delete_historique" style="display:none">
	  <input type="number" name="id_historique" placeholder="id historique" />
	  <input type="submit" value="OK" />
	</form>

	  <script>
	    function changeOptions(selectEl) {
		let selectedValue = selectEl.options[selectEl.selectedIndex].value;
		let subForms = document.getElementsByClassName('className')
		for (let i = 0; i < subForms.length; i += 1) {
		    if (selectedValue === subForms[i].name) {
			subForms[i].setAttribute('style', 'display:block')
		    } else {
			subForms[i].setAttribute('style', 'display:none') 
		    }
		}
	    }
	  </script>

	  
<?php
 include "connect.php";
 if(isset($_GET['action']))
{
if ($_GET['action'] = "emprunts"){
    $table=$_GET['action'];
    //get results from database
    $result = mysqli_query($connection,"SELECT id_historique, numero_adherent, reference_velo, date_debut_emprunt, date_fin_emprunt, numero_borne_depart, numero_borne_arrivee, distance_parcourue  FROM emprunts natural join historique order by id_historique");
    $all_property = array();  //declare an array for saving property

    //showing property
    echo '<table class="data-table">
    <tr class="data-heading">';  //initialize table tag
    while ($property = mysqli_fetch_field($result)) {
        echo '<td>' . $property->name . '</td>';  //get field name for header
        array_Push($all_property, $property->name);  //save those to array
    }
        echo '</tr>'; //end tr tag

    //showing all data
    while ($row = mysqli_fetch_array($result)) {
        echo "<tr>";
        foreach ($all_property as $item) {
        echo '<td>' . $row[$item] . '</td>'; //get items using property value
        }
        echo '</tr>';
    }
    echo "</table>";
}

if (isset($_POST['numero_adherent']) AND isset($_POST['reference_velo'])){
$requete = mysqli_prepare($connection,"INSERT INTO emprunts(numero_adherent, reference_velo) VALUES (?, ?)");
mysqli_stmt_bind_param($requete, "ii", $_POST['numero_adherent'], $_POST['reference_velo']);
mysqli_stmt_execute($requete);
echo "<meta http-equiv='refresh' content='0'>";
}

if (isset($_POST['numero_borne_arrivee']) AND isset($_POST['reference_velo_arrivee']) and isset($_POST['distance_parcourue'])){
$requete = mysqli_prepare($connection,"UPDATE historique SET date_fin_emprunt = CURRENT_TIMESTAMP, numero_borne_arrivee = ?, distance_parcourue = ? where id_historique = (SELECT max(id_historique) FROM emprunts WHERE reference_velo = ?) AND date_fin_emprunt IS NULL AND numero_borne_arrivee IS NULL AND distance_parcourue IS NULL");
mysqli_stmt_bind_param($requete, "iii", $_POST['numero_borne_arrivee'], $_POST['distance_parcourue'], $_POST['reference_velo_arrivee']);
mysqli_stmt_execute($requete);
echo "<meta http-equiv='refresh' content='0'>";
}

if (isset($_POST['id_historique'])){
$requete = mysqli_prepare($connection,"DELETE FROM historique WHERE id_historique = ?");
mysqli_stmt_bind_param($requete, "i", $_POST['id_historique']);
mysqli_stmt_execute($requete);
echo "<meta http-equiv='refresh' content='0'>";
}

}


?>
<a type="submit" href="index.php?action=home">Retourner à la page d'acceuil</a>

</body>
</html>
