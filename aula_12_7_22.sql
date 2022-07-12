select CategoryID,CategoryName,
avg((select sum(UnitPrice)/ count(*) from Products B where B.CategoryID = A.CategoryID group by B.CategoryID)) as Média
from Categories A
group by CategoryID;




select sum(UnitPrice)/ count(*) from Products B where CategoryID = 2

-----------------------------------------------------------------------------------------------------------------------------------------


drop view if exists Temp_V1;
create view Temp_V1 as
select OrderID, count(*) as Quantidade
from OrderDetails
group by OrderID;

select avg(Quantidade) from Temp_V1;
drop view if exists Temp_V1;

-------------------------------------------------------------------------------------------------------



drop table if exists Temp_V1;
create view Temp_V1 as
select OrderID, count(*) as Quantidade
from OrderDetails
group by OrderID;

select avg(Quantidade) from Temp_V1;
-- drop view if exists Temp_V1;

-----------------------------------------------------------------------------------------------------------



-- 5 melhores clientes da emprasa


drop view if exists Temp_v1;

create view Temp_v1 as
select sum(A.UnitPrice * A.Quantity) as 'Montante' 
from OrderDetails A
join Orders B using(OrderID)
group by B.CustomerID
Order by Montante desc limit 5;

select B.CustomerID, C.CompanyName,sum(A.UnitPrice * A.Quantity) as Montante 
from OrderDetails A
join Orders B using(OrderID)
join Customers C using (CustomerID)
group by C.CustomerID,C.CompanyName
having Montante in (select Montante from Temp_v1)
