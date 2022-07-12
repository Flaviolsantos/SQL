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
