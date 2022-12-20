DELIMITER //

# Si velo deja en cours d'utilisation, message erreur
# Sinon creer une ligne historique pour le nouvel emprunt
# et associe le velo a aucune borne dans le cas où 
# l on ne rentre pas manuellement l emprunt

CREATE OR REPLACE TRIGGER `debut_emprunt`
BEFORE INSERT ON `emprunts`
FOR EACH ROW
BEGIN
    IF
        (EXISTS (SELECT date_fin_emprunt
     	FROM emprunts NATURAL JOIN historique
     	WHERE reference_velo = NEW.reference_velo
     	AND date_fin_emprunt IS NULL))

    THEN
	SIGNAL sqlstate '45000' set message_text = 'Velo deja en cours d utilisation';

    ELSE
	SET @depart = (SELECT numero_borne 
	    	      FROM velos 
		      WHERE velos.reference_velo = NEW.reference_velo); 

	IF (NEW.id_historique = -1) 
	THEN	
	    INSERT INTO historique(numero_borne_depart) VALUES (@depart);
	    SET NEW.id_historique = LAST_INSERT_ID();
	    UPDATE velos
	    SET numero_borne = NULL
	    WHERE reference_velo = NEW.reference_velo;
	ELSE	
	    IF ((select date_fin_emprunt 
	         from historique 
		 where id_historique = NEW.id_historique) IS NULL)
	    THEN	
	        UPDATE historique SET date_fin_emprunt = NOW() 
		where id_historique = NEW.id_historique;
	    END IF;
	END IF;
    END IF;
END;

//



# Fais MaJ sur le velos en fin d emprunt (kilometrage & borne)
CREATE OR REPLACE TRIGGER `fin_emprunt`
AFTER UPDATE ON `historique`
FOR EACH ROW
BEGIN
	UPDATE velos
	SET numero_borne = NEW.numero_borne_arrivee,
	kilometrage = kilometrage + NEW.distance_parcourue
	WHERE reference_velo in (
	SELECT reference_velo
	FROM historique NATURAL JOIN emprunts
	WHERE OLD.numero_borne_arrivee IS NULL
	AND OLD.date_fin_emprunt IS NULL
	AND OLD.distance_parcourue IS NULL
	AND numero_borne_arrivee = NEW.numero_borne_arrivee);
	
END;
   
//

# Signale que la borne où on met le velo est hors service (inutilisable)
CREATE OR REPLACE TRIGGER `borne_hors_service`
BEFORE UPDATE ON `velos`
FOR EACH ROW
BEGIN
	IF
	(EXISTS (SELECT numero_borne
	FROM bornes
	WHERE numero_borne = NEW.numero_borne
	AND etat_borne = 'hors service'))

	THEN
	SIGNAL sqlstate '45000' set message_text = 'Borne hors service';

	END IF;
END;

//

DELIMITER ;
