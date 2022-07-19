DROP PROCEDURE IF EXISTS SP_cursor1;
DELIMITER $$
CREATE PROCEDURE SP_cursor1 ()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE _Country VARCHAR(15);
	DECLARE _lista VARCHAR(4000);
	DECLARE _traco VARCHAR(3);
	 
	DECLARE cursor1 CURSOR FOR
	SELECT Distinct Country FROM Customers where Country is not null order by Country;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	set _lista = '';
	set _traco = '';

	OPEN cursor1;
		read_loop: LOOP
			FETCH cursor1 INTO _Country;
		IF done THEN
		LEAVE read_loop;
		END IF;
		set _lista = concat(_lista,_traco,_Country);
		set _traco = '-';
	END LOOP;
	CLOSE cursor1;
    select _lista;
END$$

CALL SP_cursor1();
