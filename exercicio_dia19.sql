DROP PROCEDURE IF EXISTS NESTED_CURSOR;
DELIMITER $$
CREATE PROCEDURE `NESTED_CURSOR`()
BEGIN
   -- declarar 3 variaveis
    DECLARE done1 INT DEFAULT FALSE;
    DECLARE _CustomerID VARCHAR(20);
   
   -- Declarar o Cursor1
    DECLARE cursor1 CURSOR FOR
    select distinct CustomerID
    from Orders
    order by EmployeeID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done1 = TRUE;    
    
    -- iniciar o Cursor1
    
    OPEN cursor1;
    READ_LOOP1: LOOP
        
        -- vai buscar a linha com Last Name e ID de Employee
        FETCH cursor1 INTO _CustomerID;
        IF done1 THEN
            LEAVE READ_LOOP1;
        END IF;
        -- Fazer o que há a fazer aqui!
        SELECT _CustomerID;
       
       -- Dentro do Block2 esta o segundo cursor
       BLOCK2:
       
			BEGIN  
            -- declaradas as variaveis do cursor2
            DECLARE done2 INT DEFAULT FALSE;
            DECLARE _OrderID int;  
            DECLARE _ProductID int;
            
            -- Declarar o Cursor2
            DECLARE cursor2 CURSOR FOR
            select A.OrderID,A.ProductID
            from OrderDetails A 
            where OrderID = _OrderID and ProductID = _ProductID
            order by OrderID;
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = TRUE;  
            
            -- iniciar o Cursos2
            OPEN cursor2;
            READ_LOOP2: LOOP
                FETCH cursor2 INTO  _OrderID ,_ProductID;
                IF done2 THEN
                    LEAVE READ_LOOP2;
                END IF;
                -- Fazer o que há a fazer aqui!
                SELECT _OrderID ,_ProductID;
            END LOOP;
            select CustomerID,A.OrderID,ProductID,UnitPrice,Quantity,Discount from OrderDetails A ,Orders B;
            CLOSE cursor2;      
        END BLOCK2;        
    
    
    
    END LOOP;
    CLOSE cursor1;

END$$
DELIMITER ;
CALL NESTED_CURSOR();
