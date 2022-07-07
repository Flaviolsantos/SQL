-- Por categoria, quais produtos têm um preço acima da média

select A.CategoryID,A.ProductID,A.UnitPrice from Products A
where A.UnitPrice > (select avg(B.UnitPrice) from Products B where B.CategoryID = A.CategoryID) 
order by A.CategoryID;

-- Testar 
select CategoryID, avg(UnitPrice) from Products group by CategoryID;

select CategoryID, avg(UnitPrice) from Products where CategoryID = 1;

select * from Products where UnitPrice > 37.97916667 and CategoryID = 1;
