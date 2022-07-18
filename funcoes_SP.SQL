-- FUNÇÔES COM STORED PROCEDURE




-- FUNCAO PARA MONTANTE DE UM CERTO EMPLOYEE

drop function if exists montemp;
DELIMITER $$
Create function `montemp`(_EmployeeID int) returns int
BEGIN
DECLARE _montante int;
set _montante = (
select sum(UnitPrice * Quantity) 
from Employees
join Orders using(EmployeeID)
join OrderDetails using (OrderID)
where EmployeeID = _EmployeeID
group by EmployeeID
);

return _montante;
END $$
DELIMITER ;


-- FUNCAO PARA MONTANTE DE UM CERTO CLIENTE

drop function if exists montcus;
DELIMITER $$
Create function `montcus`(_CustomerID varchar(40)) returns int
BEGIN
DECLARE _montante int;
set _montante = (
select sum(UnitPrice * Quantity)
from Customers
join Orders using (CustomerID)
join OrderDetails using (OrderID)
where CustomerID = _CustomerID
group by CustomerID
);

return _montante;
END $$
DELIMITER ;



-- Stored Procedure para mostrar EmployeeID,LastName,Montante,CustomerID,CompanyName,Montante ,% para um determinado cliente

drop procedure if exists SP3;

Delimiter $$
create procedure `SP3`(in _CustomerID varchar(40))
begin

select EmployeeID,LastName,montemp(EmployeeID) as Montante,CustomerID,CompanyName,sum(montcus(CustomerID)) as Montante , montemp(EmployeeID) / sum(montcus(CustomerID)) as '%' from Customers
join Orders using(CustomerID)
join Employees using (EmployeeID)
where CustomerID = _CustomerID
group by EmployeeID
Order by EmployeeID;
end$$
DELIMITER ;

call SP3 ('QUEEN');
