DROP PROCEDURE IF EXISTS NESTED_CURSOR;
DELIMITER $$
CREATE PROCEDURE `NESTED_CURSOR`( _ProdructID int)
BEGIN
   -- declarar 3 variaveis
    DECLARE done1 INT DEFAULT FALSE;
    DECLARE _ProductID int;
    DECLARE _ProductName varchar(50);
    DECLARE _StockValue varchar(50);
   
   -- Declarar o Cursor1
    DECLARE cursor1 CURSOR FOR
    select distinct ProductID,ProductName,sum(UnitsInStock * UnitPrice)
    from Products
    where ProductID = _ProdructID
    group by ProductID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done1 = TRUE;    
    
    -- iniciar o Cursor1
    
    OPEN cursor1;
    READ_LOOP1: LOOP
        
        -- vai buscar a linha com Last Name e ID de Employee
        FETCH cursor1 INTO _ProductID, _ProductName,_StockValue;
        IF done1 THEN
            LEAVE READ_LOOP1;
        END IF;
        -- Fazer o que há a fazer aqui!
        SELECT _ProductID, _ProductName,_StockValue;
       
       -- Dentro do Block2 esta o segundo cursor
       BLOCK2:
       
			BEGIN  
            -- declaradas as variaveis do cursor2
            DECLARE done2 INT DEFAULT FALSE;
            DECLARE _CategoryID int;  
            DECLARE _Name VARCHAR(50);  
            DECLARE _StockValor VARCHAR(50); 
            
            
            -- Declarar o Cursor2
            DECLARE cursor2 CURSOR FOR
            select CategoryID,CategoryName,sum(UnitsInStock * UnitPrice)
            from Categories
            join Products using (CategoryID)
            group by CategoryID;
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = TRUE;  
            
            -- iniciar o Cursos2
            OPEN cursor2;
            READ_LOOP2: LOOP
                FETCH cursor2 INTO _CategoryID, _Name,_StockValor;
                Fetch cursor1 into _ProductID, _ProductName,_StockValue;
                IF done2 THEN
                    LEAVE READ_LOOP2;
                END IF;
                -- Fazer o que há a fazer aqui!
               
            END LOOP;
             SELECT _ProductID, _ProductName,_StockValue,_CategoryID, _Name,_StockValor;
            CLOSE cursor2;      
        END BLOCK2;        
    END LOOP;
    CLOSE cursor1;
	
END$$
DELIMITER ;
CALL NESTED_CURSOR(1);