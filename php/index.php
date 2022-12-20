<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="main.css" />
    </head>
    <body>
        <ul>
            <li><a class="active" href="#home">Page d'acceuil</a></li>
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn" onclick="myFunction('myDropdown')">Afficher une table</a>
                <div class="dropdown-content" id="myDropdown">
                <a href="affichage.php?action=communes">Communes</a>
                <a href="affichage.php?action=stations">Stations</a>
                <a href="affichage.php?action=distance">Distances entre stations</a>
                <a href="affichage.php?action=bornes">Bornes</a>
                <a href="affichage.php?action=velos">Vélos</a>
                <a href="affichage.php?action=adherents">Adhérents</a>
                <a href="affichage.php?action=abonnements">Abonnements</a>
                <a href="affichage.php?action=emprunts">Emprunts</a>
                <a href="affichage.php?action=historique_ab">Historique des abonnements</a>
                <a href="affichage.php?action=historique">Historique des emprunts</a>
                <a href="affichage.php?action=souscription">Souscription</a>
                </div>
            </li>
            <li class="dropdown">
            <li><a href="javascript:void(0)" class="dropbtn" onclick="myFunction('myDropdown2')">Mettre à jour une table</a>
                <div class="dropdown-content" id="myDropdown2">
                <a href="update.php?action=emprunts">emprunts</a>               
                </div>
            </li>
            <li><a class="active" href="statistique.php?action=stat">Afficher les statistiques</a></li>
        </ul>
    <h1>Gestion de location de vélos en libre-service</h1>
    <img src="logo_velo.png" height="460" width="660">
    <script>
    /* When the user clicks on the button, 
    toggle between hiding and showing the dropdown content */
    function myFunction(id) {
        document.getElementById(id).classList.toggle("show");
    }
    // Close the dropdown if the user clicks outside of it
    window.onmouseup = function(e) {
        var dropdown = document.querySelector(".dropdown-content.show");
        if (dropdown){
	dropdown.classList.remove("show");
        }		
    }
    </script>
    <?php
        //include "connect.php";
    ?>
    <footer><p>© 2021 <a href="https://github.com/Aymdi" target="_blank" rel="nofollow">Aymane LAMHAMDI</a>, <a href="https://github.com/Aymdi" target="_blank" rel="nofollow">Nicolas DO</a>, <a href="https://github.com/Aymdi" target="_blank" rel="nofollow">Othmane MANSOURI</a></p></footer>
    </body>
</html>
