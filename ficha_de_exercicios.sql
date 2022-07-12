-- ex 1

select CategoryName, Description from Categories
order by CategoryName;

-- ex 2

select ContactName,CompanyName,ContactTitle,Phone from Customers
order by Phone;

-- ex3 

select concat(FirstName,' ',LastName) as Nome, HireDate from Employees
Order by  HireDate desc;

-- ex 4

select OrderID,OrderDate,ShippedDate,CustomerID,Freight from Orders
order by Freight desc;

-- ex 5 

select CompanyName,Fax,Phone,HomePage,Country from Suppliers
order by Country desc,CompanyName;

-- ex 6

select CompanyName,CompanyName from Customers
where City = 'Buenos Aires';

-- ex 7

select ProductName,UnitPrice,QuantityPerUnit from Products
where UnitsInStock = 0 or UnitsInStock = null;

-- ex 8

select OrderDate,ShippedDate,CustomerID,Freight from Orders
where OrderDate = '1997-05-19';

-- ex 9
select FirstName,LastName,Country from Employees
where Country <> 'USA';

-- ex 10
select EmployeeID,OrderID,CustomerID,RequiredDate,ShippedDate from Orders
where ShippedDate > RequiredDate;

-- ex 11

select City,CompanyName,ContactName from Customers
where City like 'A%' or City like 'B%';

-- ex 12

select * from Orders
where Freight > 500;

-- ex 13
select ProductName,UnitsInStock,UnitsOnOrder,ReorderLevel from Products
where ReorderLevel <> 0;

-- ex 14

select CompanyName,ContactName,Fax from Customers
where Fax <> 0 or Fax <> null;

-- ex 15

select FirstName,LastName,ReportsTo from Employees
where ReportsTo is null;

-- ex 16

select CompanyName,ContactName,Fax from Customers
where Fax <> 0 or Fax <> null
Order by CompanyName;

-- ex 17
select City,CompanyName,ContactName from Customers
where City like 'A%' or City like 'B%'
order by ContactName desc;

-- ex 18
select FirstName,LastName,BirthDate from Employees
where BirthDate like '195%';

-- ex 19

select ProductName,SupplierID from Products
where 
