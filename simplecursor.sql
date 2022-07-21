DROP PROCEDURE IF EXISTS investimento;
DELIMITER $$
CREATE PROCEDURE investimento ()
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE _Unitprice int;
DECLARE _UnitsinStock int;
DECLARE _Discon int;
DECLARE _discontinued int;
DECLARE _continued int;
DECLARE _lista VARCHAR(4000); 
DECLARE _true VARCHAR(4000);
DECLARE _false VARCHAR(4000);
DECLARE _espaco VARCHAR(3);


 
DECLARE cursor1 CURSOR FOR
SELECT UnitPrice,UnitsInStock,Discontinued
FROM Products;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
set _discontinued = 0;
set _continued = 0;
set _lista = '';
set _true = 'Montante produtos correntes:';
set _false = 'Montante produtos descontinuados:';
set _espaco = ' ';

OPEN cursor1;
read_loop: LOOP
FETCH cursor1 INTO _Unitprice,_UnitsinStock,_Discon;
IF done THEN
LEAVE read_loop;
END IF;

if _Discon = 0 then
	set _continued = _continued + ( _Unitprice *_UnitsInStock );
else if _Discon = 1 then
	set _discontinued = _discontinued + (_UnitPrice*_UnitsInStock) ;

end if;
end if;
set _lista = concat ( _true,_continued,_espaco,_false,_discontinued);
END LOOP;
select _lista;
CLOSE cursor1;
END$$

CALL investimento();




