select B.CustomerID,A.OrderID,Count(*) as 'N Encomendas' from Orders A
join Customers B using (CustomerID)
group by B.CustomerID;


-- quais os IDs dos clientes com menos de 30 encomendas

select C.CustomerID,A.Quantity from OrderDetails A
join Orders B using(OrderID)
join Customers C using (CustomerID)
having A.Quantity > 15
order by A.Quantity;




drop function if exists IDs;
DELIMITER $$
create function `IDs`(_CustomerID VARCHAR(32),_total int) RETURNS bool
BEGIN
DECLARE _numerodeID int;
set _numerodeID = (
	select count(*) from Orders
	where CustomerID = _CustomerID
	group by CustomerID

);

IF _numerodeID < _total then
	RETURN true;
ELSE
	RETURN false;
END IF;

END $$
DELIMITER ;


select IDs(IDs'CENTC',IDs);

-- função que recebe o orderid e devolve o total da encomenda

drop function if exists IDs;
DELIMITER $$
create function `IDs`(_OrderID VARCHAR(32),_total int) RETURNS bool
BEGIN
DECLARE _numerodeID int;
set _numerodeID = (
	select Orders.CustomerID,sum(UnitPrice * Quantity) as Montante
    from Orders 
    join OrderDetails on (Orders.OrderID)
	group by Orders.CustomerID order by Montante
);

IF _numerodeID = _total then
	RETURN true;
ELSE
	RETURN false;
END IF;

END $$
DELIMITER ;


-- Crie uma função chamada FC1 que recebe o nome de uma categoria de produto e devolve o número de produtos que a empresa tem nessa categoria.


drop function if exists FC1;
DELIMITER $$
Create function `FC1`(_CategoryID VARCHAR(32)) returns int
BEGIN
DECLARE _quantosprodutos int;
set _quantosprodutos = (
select sum(UnitsInStock) from Products
where CategoryID = _CategoryID
group by CategoryID
);

return _quantosprodutos;
END $$
DELIMITER ;

select FC1('2');

-- Crie uma função chamada FC2 que recebe o nome de uma cidade e devolve o número de clientes que a empresa tem nessa cidade.

drop function if exists FC2;
DELIMITER $$
Create function `FC2`(_City VARCHAR(32)) returns int
BEGIN
DECLARE _quantosclientes int;
set _quantosclientes = (
select count(CustomerID) from Customers
where City = _City
group by City
);

return _quantosclientes;
END $$
DELIMITER ;

select FC2('Buenos Aires');


--


drop function if exists discoformato;
DELIMITER $$
create function `discoformato`(_iddisco VARCHAR(32),_formato int) RETURNS bool
BEGIN
DECLARE _numeroformato int;
set _numeroformato = (

	select count(*) from discosformato
	where iddiscos = _iddisco and formato = _formato
	order by iddiscos

);

IF _numeroformato > 0 then
	RETURN 'S';
end if;
	RETURN 'N';

END $$
DELIMITER ;


select iddiscos,titulo,formato(iddisco,'33'),formato(iddisco,'45'),formato(iddisco,'78') 
from discos group by iddisco,titulo
