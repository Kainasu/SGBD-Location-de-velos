<?php
//A changer en fonction de vos configurations
$Host    = "127.0.0.1";
$user    = "root";
$pass    = "";
$db_name = "Locations_velo";

//create connection
$connection = mysqli_connect($Host, $user, $pass, $db_name);

//test if connection failed
if(mysqli_connect_errno()){
    die("connection failed: "
        . mysqli_connect_error()
        . " (" . mysqli_connect_errno()
        . ")");
}
?>