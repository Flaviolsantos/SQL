-- Total por Encomenda
select OrderID,sum(UnitPrice * Quantity) as 'Total' from OrderDetails
group by OrderID;



-- Total por Categoria
select A.CategoryID,sum(C.UnitPrice * C.Quantity) as 'Montante' from Categories A
join Products B using (CategoryID)
join OrderDetails C using(ProductID)
group by CategoryID;

-- Total por Funcionário

select A.EmployeeID,sum(C.UnitPrice * C.Quantity) as 'Montante' from Employees A
join Orders B using (EmployeeID)
join OrderDetails C using(OrderID)
group by EmployeeID;

-- Máximo de Linhas (apenas interessado na(s) encomenda(s) com o número máximo de linhas

drop view if exists maximo;
create view maximo as
select count(*) as 'Linhas' from OrderDetails
group by OrderID
order by count(*) desc limit 1;


select OrderID,count(*) as 'Linhas' from OrderDetails
group by OrderID
having Linhas = (select * from maximo);


-- Vendas por Ano

select extract(year from A.ShippedDate),sum(B.UnitPrice * B.Quantity) as 'Montante' from Orders A
join OrderDetails B using(OrderID)
group by extract(year from A.ShippedDate);



-- Top 3 (apenas interessado na(s) encomenda(s) com o número máximo de linhas


drop view if exists maximo;

create view maximo as
select count(*) as 'Linhas' from OrderDetails
group by OrderID
order by count(*) desc limit 3;


select OrderID,count(*) as 'Linhas' from OrderDetails
group by OrderID
having Linhas in (select Linhas from maximo);
