
drop function if exists FC1;
DELIMITER $$
Create function `FC1`(_EmployeeID int,_CustomerID varchar(45),_Ano int) returns int
BEGIN
DECLARE _montante int;
set _montante = (
select sum(Quantity * UnitPrice) as Montante from Employees
join Orders using(EmployeeID)
join OrderDetails using (OrderID)
where EmployeeID = _EmployeeID and CustomerID = _CustomerID and Extract(year from ShippedDate) = _Ano
group by EmployeeID,CustomerID,Extract(year from ShippedDate)
);

return _montante;
END $$
DELIMITER ;

select FC1 ('1','SAVEA','1997') ;


select EmployeeID,CustomerID,Extract(year from ShippedDate) as Ano,sum(Quantity * UnitPrice) as Montante from Employees
join Orders using(EmployeeID)
join OrderDetails using (OrderID)
group by EmployeeID,CustomerID,Ano;

-- ------------------------------------------------------------------------
-- Relatorio mostra o melhor ano para cada employee

drop view if exists maxmontante;
create view maxmontante as
select EmployeeID,Extract(year from ShippedDate) as Ano,sum(Quantity * UnitPrice) as Montante from Employees
join Orders using (EmployeeID)
join OrderDetails using (OrderID)
group by EmployeeID, Ano;


select EmployeeID,LastName,Extract(year from ShippedDate) as Ano,sum(Quantity * UnitPrice) as Montante from Employees
join Orders using (EmployeeID)
join OrderDetails using (OrderID)
group by EmployeeID,Ano
having Montante in (select max(Montante) from maxmontante group by EmployeeID);
