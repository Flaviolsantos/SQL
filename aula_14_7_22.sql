-- Funçao que recebe o OrderID e devolve o total da encomenda

-- Funçao que recebe o CustomerID e devolve o montante que aquele cliente comprou

-- X - Funçao que recebe o nome de uma cidade e devolve os IDs e nomes dos funcionarios que moram nessa cidade

-- Funçao receo Customer ID e o EmployeeID e devolve o montante que este funcionário vendeu aquele cliente

-- Função recebe o nome do pais e uma valor boleano[1,0].Se o valor for 1 devolve as vendas feitas naquele pais
-- se o valor for 0 devolve as vendas feitas em todos os paises exceto que foi passado para a funcao

-- funcao que recebe o CustomerID e devolve o Grupo Comercial do cliente O grupo Comercial é baseado nas vendas

	select Orders.CustomerID,sum(UnitPrice * Quantity) as Montante
    from Orders 
    join OrderDetails on (Orders.OrderID)
	group by Orders.CustomerID order by Montante
    
    
    Total de vendas ;
    < 10000 = Grupo F
    < 20000 = Grupo E
    < 30000 = Grupo D
    < 40000 = Grupo C
    < 50000 = Grupo B
	>= 50000 = Grupo A
