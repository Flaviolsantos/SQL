-- encomendas para França

select * from Orders
where ShipCountry = 'France' or ShipCountry = 'Brasil' or ShipCountry = 'Germany' and ShipPostalCode = '1307'
-- where ShipCountry in ('France','Basil','Germany')
order by ShipCountry desc;



select A.OrderID, A.ProductID, B.ProductName, A.UnitPrice, A.Quantity, A.UnitPrice * A.Quantity as 'Total' 
from OrderDetails A
join Products B using (ProductID);

or


select A.OrderID, A.ProductID, B.ProductName, A.UnitPrice, A.Quantity, A.UnitPrice * A.Quantity as 'Total' 
from OrderDetails A,Products B
-- join Products B using (ProductID);
where A.ProductID = B.ProductID



-----------------------------------------

select C.CustomerID, C.CompanyName, A.OrderID, A.ProductID, B.ProductName, A.UnitPrice, A.Quantity, A.UnitPrice * A.Quantity as 'Total' 
from OrderDetails A, Products B, Customers C
-- join Products B using (ProductID);
where A.ProductID = B.ProductID

or


select C.CustomerID, C.CompanyName, A.OrderID, A.ProductID, B.ProductName, A.UnitPrice, A.Quantity, A.UnitPrice * A.Quantity as 'Total' 
from OrderDetails A
join Products B using (ProductID)
join Orders using(OrderID)
join Customers C using(CustomerID);

------------------------------------------------------

select distinct C.CustomerID, C.CompanyName, C.Phone as 'Total' 
from OrderDetails A
join Products B using (ProductID)
join Orders using(OrderID)
join Customers C using(CustomerID)
where A.ProductID = '11'
order by C.CustomerID;




select CustomerID, CompanyName, Phone from Customers where CustomerID in(
select c.CustomerID from OrderDetails A join Orders B using (OrderID) join Customers C using (CustomerID) where A.ProductID = '11');


---------------------------------------------------------------
select * from Employees;

-- EmployeesID,FirstName,LastName ,'Primeiro Nome do Chefe','Ultimo Nome do Chefe';


select A.EmployeeID , A.Firstname, A.LastName,  B.FirstName as 'Primeiro Nome do Chefe', B.LastName as 'Ultimo Nome do Chefe'
from Employees A 
left join Employees B on A.ReportsTo = B.EmployeeID;



id do funcionario
order
total

----------------------------------------------------------------



-- EmployeeID, FirstName, LastName,OrderID,ProductID,Montante

select EmployeeID,FirstName,LastName,OrderID,ProductID, OrderDetails.UnitPrice * OrderDetails.Quantity as 'Montante'
from Employees
join Orders using (EmployeeID)
join OrderDetails using (OrderID)
join Products using (ProductID)
order by EmployeeID,OrderID,OrderDetails.UnitPrice * OrderDetails.Quantity desc;



FUNÇOES DE GRUPO

max() , min() , count() sum() avg()

maximo,minimo,contar,sumar,media

-Sempre que entre o select e o from tiver uma funcao de grupo ,deves ter uma clausula group by que contem tudo o que nao for funçoes de grupo

EX:

select A.EmployeeID,A.FirstName,A.LastName,B.OrderID, sum(B.UnitPrice * B.Quantity) as 'Montante' 
from Orders
join Employees A using(EmployeeID)
join OrderDetails B using (OrderID)
group by A.EmployeeID,A.FirstName,A.LastName
order by A.EmployeeID;



------------------------------------------------------------------------------------------------
-- qual é a categoria com mais produtos e com menos?

select ProductID, ProductName, UnitPrice 
from Products;



-- 1 -- Qual o Produto mais caro? e o mais Barato?
select ProductName,UnitPrice from Products where UnitPrice =(
select  max(UnitPrice) from Products);

select ProductName,UnitPrice from Products where UnitPrice =(
select  min(UnitPrice) from Products);





select CategoryID,CategoryName, ProductID,ProductName,UnitPrice 
from Products 
join Categories using(CategoryID)
where UnitPrice in (
select  max(UnitPrice) from Products group by CategoryID)
order by CategoryID;

select CategoryID,CategoryName, ProductID,ProductName,UnitPrice 
from Products 
join Categories using(CategoryID)
where UnitPrice in (
select  min(UnitPrice) from Products group by CategoryID)
order by CategoryID;







-- 3 -- Quantos produtos temos em cada categoria

select CategoryID,count(ProductID) from Products 
group by CategoryID;

-- 4 -- qual é a categoria com mais produtos e com menos?

select CategoryID, count(*) as Total from Products 
group by CategoryID 
having count(*) = (select CategoryID, count(*) as Total from Products group by CategoryID order by Total desc limit 1);

select CategoryID, count(*) as Total from Products 
group by CategoryID 
having count(*) = (select CategoryID, count(*) as Total from Products group by CategoryID order by Total limit 1);

-----------------------------

or

select CategoryID, count(*) as Total from Products group by CategoryID 
having Total = (select count(*) as Total from Products group by CategoryID order by Total desc limit 1)
order by Total;

select CategoryID, count(*) as Total from Products group by CategoryID 
having Total = (select count(*) as Total from Products group by CategoryID order by Total limit 1)
order by Total;

--Sempre que quzer fazer uma comparaçao for uma funcao de grupo tenho que usar o having em vez de where

































