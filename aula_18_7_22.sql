-- -------------------

select CustomerID,sum(UnitPrice * Quantity) as Montante from Customers
join Orders using (CustomerID)
join OrderDetails using (OrderID)
group by CustomerID
Order by Montante desc ;





drop procedure if exists top;

Delimiter $$
create procedure `top`(in numero int)
begin

drop view if exists topigual;
create view topigual as
select sum(UnitPrice * Quantity) as Montante 
from Customers
join Orders using (CustomerID)
join OrderDetails using (OrderID)
group by CustomerID
Order by Montante desc limit numero;

select CustomerID,sum(UnitPrice * Quantity) as Montante 
from Customers
join Orders using (CustomerID)
join OrderDetails using (OrderID)
having Montante in (select Montante from topigual);

end$$
DELIMITER ;

call top('3');


-- ex2 ----------------------------------------



drop procedure if exists funcoes;

Delimiter $$
create procedure `funcoes`(in _CustomerID varchar(50))
begin

select CustomerID,CompanyName,sum(Quantity * UnitPrice) as Montante, avg(Quantity* UnitPrice) as Media, max(Quantity* UnitPrice) as MAX , min(Quantity* UnitPrice) as MIN from Customers 
join Orders using (CustomerID)
join OrderDetails using (OrderID)
where CustomerID = _CustomerID
group by CustomerID;


end$$
DELIMITER ;

call funcoes('ANTON');

select CustomerID,CompanyName,sum(Quantity * UnitPrice) as Montante, avg(Quantity* UnitPrice) as Media, max(Quantity* UnitPrice) as MAX , min(Quantity* UnitPrice) as MIN from Customers 
join Orders using (CustomerID)
join OrderDetails using (OrderID)
where CustomerID = 'ANTON'
group by CustomerID;

-- ex 3 ------------------------------------------------------

drop procedure if exists categoria;

Delimiter $$
create procedure `categoria`(in _CategoryName varchar(50))
begin

select CustomerID,CompanyName,OrderID from Customers A
join Orders B using (CustomerID)
join OrderDetails using (OrderID)
join Products using (ProductID)
join Categories using (CategoryID)
where CategoryName = _CategoryName;

end$$
DELIMITER ;

call categoria('Seafood');






select CustomerID,CompanyName,OrderID from Customers A
join Orders B using (CustomerID)
join OrderDetails using (OrderID)
join Products using (ProductID)
join Categories using (CategoryID)
where CategoryName = 'Seafood'
