DROP PROCEDURE IF EXISTS NESTED_CURSOR;
DELIMITER $$
CREATE PROCEDURE `NESTED_CURSOR`()
BEGIN
   -- declarar 3 variaveis
    DECLARE done1 INT DEFAULT FALSE;
    DECLARE _LastName VARCHAR(20);
    DECLARE _EmployeeID INT(11);
   
   
   
   -- Declarar o Cursor1
    DECLARE cursor1 CURSOR FOR
    select distinct Employees.LastName, Employees.EmployeeID
    from EmployeeTerritories
    join Employees on Employees.EmployeeID = EmployeeTerritories.EmployeeID
    order by EmployeeID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done1 = TRUE;    
    
    -- iniciar o Cursor1
    
    OPEN cursor1;
    READ_LOOP1: LOOP
        
        -- vai buscar a linha com Last Name e ID de Employee
        FETCH cursor1 INTO _LastName, _EmployeeID;
        IF done1 THEN
            LEAVE READ_LOOP1;
        END IF;
        -- Fazer o que há a fazer aqui!
        SELECT _LastName, _EmployeeID;
       
       -- Dentro do Block2 esta o segundo cursor
       BLOCK2:
       
			BEGIN  
            -- declaradas as variaveis do cursor2
            DECLARE done2 INT DEFAULT FALSE;
            DECLARE _TerritoryID VARCHAR(20);  
            DECLARE _TerritoryDescription VARCHAR(50);  
            
            -- Declarar o Cursor2
            DECLARE cursor2 CURSOR FOR
            select Territories.TerritoryID, Territories.TerritoryDescription
            from EmployeeTerritories
            join Territories on Territories.TerritoryID = EmployeeTerritories.TerritoryID
            where EmployeeTerritories.EmployeeID = _EmployeeID
            order by Territories.TerritoryID;
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = TRUE;  
            
            -- iniciar o Cursos2
            OPEN cursor2;
            READ_LOOP2: LOOP
                FETCH cursor2 INTO _TerritoryID, _TerritoryDescription;
                IF done2 THEN
                    LEAVE READ_LOOP2;
                END IF;
                -- Fazer o que há a fazer aqui!
                SELECT _TerritoryID, _TerritoryDescription;
            END LOOP;
            
            CLOSE cursor2;      
        END BLOCK2;        
    
    
    
    END LOOP;
    CLOSE cursor1;

END$$
DELIMITER ;
CALL NESTED_CURSOR();
