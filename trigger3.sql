drop trigger  if exists frotas_before_insert;
drop trigger  if exists viaturas_before_insert;
drop trigger  if exists combustivel_before_insert;
drop trigger  if exists marcas_before_insert;


delimiter //
create trigger frotas_before_insert
before insert on frotas
for each row
begin
	DECLARE mensagem VARCHAR(255);
    Declare id_viatura varchar(255);
    
	if (select count(*) from frotas where idviaturas = new.idviaturas) > 0 then
	set mensagem = concat('O Id da Viatura ',new.idviaturas,' - ', id_viatura,' já existe.');
	signal sqlstate '45000' set message_text = mensagem;
        
	end if;
	if not exists (select new.idviaturas from frotas) in (select idviaturas from viaturas) then
		set mensagem = concat('Está a tentar inserir um idviatura ', new.idviaturas,' , mas ele não existe na tabelas viaturas.');
		signal sqlstate '45000' set message_text = mensagem;
    end if;
end;
//

delimiter //
create trigger viaturas_before_insert
before insert on viaturas
for each row
begin
	DECLARE mensagem VARCHAR(255);

	if new.idviaturas in (select idviaturas from viaturas) then
			set mensagem = concat('O IDviaturas ',new.idviaturas,' já existe. Criaria um registo duplicado.');
			signal sqlstate '45000' set message_text = mensagem;
	end if;
    

     if not exists (select idcombustivel from viaturas where idcombustivel = new.idcombustivel) not in (select idcombustivel from combustivel) then
		set mensagem = concat('Está a tentar inserir um idcombustivel ', new.idcombustivel,' , mas ele não existe na tabelas combustivel.');
		signal sqlstate '45000' set message_text = mensagem;
    end if;
    
     if not exists (select idmarcas from viaturas where idmarcas = new.idmarcas)  not in (select idmarcas from marcas) then
		set mensagem = concat('Está a tentar inserir um idmarca ', new.idmarcas,' , mas ele não existe na tabelas marcas.');
		signal sqlstate '45000' set message_text = mensagem;
    end if;



end;
//

delimiter //
create trigger combustivel_before_insert
before insert on combustivel
for each row
begin
	DECLARE mensagem VARCHAR(255);

	if new.idcombustivel in (select idcombustivel from combustivel) then
			set mensagem = concat('O IDcombustivel ',new.idcombustivel,' já existe. Criaria um registo duplicado.');
			signal sqlstate '45000' set message_text = mensagem;
 
end if;


end;
//

delimiter //
create trigger marcas_before_insert
before insert on marcas
for each row
begin
	DECLARE mensagem VARCHAR(255);

	if new.idmarcas in (select idmarcas from marcas) then
			set mensagem = concat('O ID ',new.idmarcas,' já existe. Criaria um registo duplicado.');
			signal sqlstate '45000' set message_text = mensagem;
 
end if;


end;
//
