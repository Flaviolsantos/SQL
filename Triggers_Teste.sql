drop trigger  if exists viaturas_before_insert;
drop trigger  if exists combustivel_before_insert;
drop trigger  if exists marcas_before_insert;
drop trigger  if exists frotas_before_insert;

delimiter //
create trigger viaturas_before_insert
before insert on viaturas
for each row
begin
DECLARE _mensagem VARCHAR(255);

	if new.idviaturas in (select idviaturas from viaturas) then
		set _mensagem = concat('O IDviaturas ',new.idviaturas,' já existe. Criaria um registo duplicado.');
		signal sqlstate '45000' set message_text = _mensagem;
	end if;
	if new.idcombustivel not in (select idcombustivel from combustivel) then
		set _mensagem = concat('Está a inserir um idcombustivel ', new.idcombustivel,' , mas não existe na tabelas combustivel.');
		signal sqlstate '45000' set message_text = _mensagem;
	end if;
	if new.idmarcas not in (select idmarcas from marcas) then
		set _mensagem = concat('Está a inserir um idmarca ', new.idmarcas,' , mas não existe na tabelas marcas.');
		signal sqlstate '45000' set message_text = _mensagem;
	end if;
end;
//

delimiter //
create trigger combustivel_before_insert
before insert on combustivel
for each row
begin
DECLARE _mensagem VARCHAR(255);

	if new.idcombustivel in (select idcombustivel from combustivel) then
		set _mensagem = concat('O idcombustivel ',new.idcombustivel,' já existe. Criaria um registo duplicado.');
		signal sqlstate '45000' set message_text = _mensagem;
	end if;
end;
//

delimiter //
create trigger marcas_before_insert
before insert on marcas
for each row
begin
DECLARE _mensagem VARCHAR(255);

	if new.idmarcas in (select idmarcas from marcas) then
		set _mensagem = concat('O ID ',new.idmarcas,' já existe. Criaria um registo duplicado.');
		signal sqlstate '45000' set message_text = _mensagem;
	end if;
end;
//

delimiter //
create trigger frotas_before_insert
before insert on frotas
for each row
begin
DECLARE _mensagem VARCHAR(255);
Declare _idviatura varchar(255);

	if (select count(*) from frotas where idviaturas = new.idviaturas and idfrotas = new.idfrotas) > 0 then
		set _mensagem = concat('O Id da Viatura ',new.idviaturas,' -  já existe.');
		signal sqlstate '45000' set message_text = _mensagem;
	end if;
		if new.idviaturas not in (select idviaturas from viaturas) then
		set _mensagem = concat('O ID ',new.idviaturas,' já existe. Criaria um registo duplicado.');
		signal sqlstate '45000' set message_text = _mensagem;
	end if;
end;
//
