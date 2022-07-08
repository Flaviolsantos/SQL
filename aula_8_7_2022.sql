
-- Quais são os 5 melhores clientes da empresa? Nota: pode eventualmente ser mais de 5 se dois ou mais tiverem comprado o mesmo montante. 

select Customers.CustomerID as Cliente , Customers.ContactName as Nome ,UnitPrice * Quantity as Total from Customers
join Orders using(CustomerID)
join OrderDetails using (OrderID)
group by OrderID
order by Total desc limit 5 ;

-- Qual é o funcionário que mais vende?

select Orders.EmployeeID as Funcionario, count(*) as Total
from Orders
group by Orders.EmployeeID
order by Total desc limit 1;

-- Quantos Clientes temos em cada pais
select Customers.Country as Pais, count(*) as Total
from Customers
group by Country;

-- Prepare um relatório que mostre o valor da mercadoria que cada transportadora transportou.

select Orders.ShipVia as Transportadora, OrderDetails.UnitPrice * OrderDetails.Quantity as 'Valor de Mercadoria'
from Orders
join OrderDetails using(OrderID)
group by ShipVia;

-- Prepare um relatório que mostre quais as regiões a cargo de cada funcionário

select  EmployeeID, concat(FirstName,' ',LastName) as Nome, RegionID,RegionDescription
from Region
join Territories using (RegionID)
join EmployeeTerritories using(TerritoryID)
join Employees using (EmployeeID)
group by EmployeeID, concat(FirstName,' ',LastName);

-- Para cada categoria apresente o número de produtos, o valor do produto mais caro, o valor do produto mais barato e a média do custo dos produtos em cada categoria.
select CategoryID,CategoryName,count(*) as 'Numero de Produtos',max(UnitPrice) as 'Valor mais Caro', min(UnitPrice) as 'Valor mais barato',avg(UnitPrice) as 'Média do valor'
from Products
join Categories using (CategoryID)
group by CategoryID
-----------------------------------------------------------------------------------------------------------------------------


-- 1 - quem são os chefes de todos os funcionários
select B.EmployeeID, concat(B.FirstName, B.LastName) as 'Nome do Chefe', A.EmployeeID ,concat(A.Firstname,A.LastName) as 'Nome do Funcionario'
from Employees A 
left join Employees B on A.ReportsTo = B.EmployeeID;


-- 2 - quantas pessoas cada funcionário tem a seu cargo. 
select EmployeeID as 'ID do chefe', concat(FirstName,LastName) as 'Nome do Chefe',ReportsTo,count(*) as Total
from Employees 
group by ReportsTo
having ReportsTo = 2 or ReportsTo = 5 ;


-- 3 - Prepare um relatório que mostre as vendas por encomenda para cada cliente

select Customers.CustomerID as Cliente , Customers.ContactName as Nome, Orders.OrderID as 'NºEncomenda', UnitPrice * Quantity as Total from Customers
join Orders using(CustomerID)
join OrderDetails using (OrderID)
group by Customers.CustomerID
order by Total;



-- 4 - Prepare um relatório que mostre as vendas por cliente. Ordene pelas vendas

select Customers.CustomerID as Cliente , Customers.ContactName as Nome from Customers
