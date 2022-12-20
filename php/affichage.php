<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="main.css" />
    </head>
    <body>
    <div class="box"> 
<?php
    include "connect.php";
    if(isset($_GET['action']))
{
    $table=$_GET['action'];
    //get results from database
    $result = mysqli_query($connection,"SELECT * FROM $table");
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
?>
<a type="submit" href="index.php?action=home">Retourner à la page d'acceuil</a>
</div>
</body>
</html>