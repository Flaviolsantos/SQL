-- Por categoria, quais produtos têm um preço acima da média

select A.CategoryID,A.ProductID,A.UnitPrice from Products A
where A.UnitPrice > (select avg(B.UnitPrice) from Products B where B.CategoryID = A.CategoryID) 
order by A.CategoryID;

-- Testar 
select CategoryID, avg(UnitPrice) from Products group by CategoryID;

select CategoryID, avg(UnitPrice) from Products where CategoryID = 1;

select * from Products where UnitPrice > 37.97916667 and CategoryID = 1;



--------------------------------------------------------

-- 1 - quem são os chefes de todos os funcionários
select B.EmployeeID, concat(B.FirstName, B.LastName) as 'Nome do Chefe', A.EmployeeID ,concat(A.Firstname,A.LastName) as 'Nome do Funcionario'
from Employees A 
left join Employees B on A.ReportsTo = B.EmployeeID;


-- 2 - quantas pessoas cada funcionário tem a seu cargo. 
select EmployeeID as 'ID do chefe', concat(FirstName,LastName) as 'Nome do Chefe',ReportsTo,count(*) as Total
from Employees 
group by ReportsTo
having ReportsTo = 2 or ReportsTo = 5 
