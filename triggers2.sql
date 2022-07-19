-- Limpar os triggers

drop trigger  if exists faturas_after_insert;
drop trigger  if exists faturas_after_update;
drop trigger  if exists faturas_after_delete;
drop trigger  if exists faturas_before_insert;
drop trigger  if exists faturas_before_delete;




delimiter //
create trigger faturas_before_delete
before delete on Faturas
for each row
begin
	DECLARE mensagem VARCHAR(255);
	if old.ID in (5,10,15) then
			set mensagem = concat('Nao pode apagar os IDs 5/10/15');
			signal sqlstate '45000' set message_text = mensagem;
 
end if;


end;
//





delimiter //
create trigger faturas_before_insert
before insert on Faturas
for each row
begin
	DECLARE mensagem VARCHAR(255);

	if new.ID in (select ID from Faturas) then
			set mensagem = concat('O ID ',new.ID,' já existe. Criaria um registo duplicado.');
			signal sqlstate '45000' set message_text = mensagem;
 
end if;


end;
//



delimiter //
create trigger faturas_after_insert
after insert on Faturas
for each row
begin

if  new.ID is not null then
	Insert into Registos(DateTime,Action,ID,Nome,CodigoPostal,Saldo,UltimaFatura)
    value (now(),'Inserir(Antes)',new.ID,new.Nome,new.CodigoPostal,new.Saldo,new.UltimaFatura);
end if;


end;
//

delimiter //
create trigger faturas_after_update
after update on Faturas
for each row
begin
DECLARE novo_ID VARCHAR(255);
DECLARE novo_Nome VARCHAR(255);
DECLARE novo_CodigoPostal VARCHAR(255);
DECLARE novo_Saldo VARCHAR(255);
DECLARE novo_UltimaFatura VARCHAR(255);

-- para alterar o ID

    if new.ID <> old.ID then
		if new.ID in (select ID from Faturas) then
			set novo_ID = (select ID from Faturas where ID = new.ID);
            insert into Registos(DateTime,Action,ID,Nome,CodigoPostal,Saldo,UltimaFatura)
			value (now(),'Inserir(Antes)',new.ID,new.Nome,new.CodigoPostal,new.Saldo,new.UltimaFatura);
        end if;
	end if;

-- para alterar o Nome

    if new.Nome <> old.Nome then
		if new.Nome in (select Nome from Faturas) then
			set novo_Nome = (select Nome from Faturas where Nome = new.Nome);
            insert into Registos(DateTime,Action,ID,Nome,CodigoPostal,Saldo,UltimaFatura)
			value (now(),'Inserir(Depois)',new.ID,new.Nome,new.CodigoPostal,new.Saldo,new.UltimaFatura);
        end if;
	end if;


-- para alterar o Nome

    if new.Nome <> old.Nome then
		set novo_Nome = (select Nome from Faturas where Nome = new.Nome);
		insert into Registos(DateTime,Action,ID,Nome,CodigoPostal,Saldo,UltimaFatura)
		value (now(),'Inserir(Depois)',new.ID,new.Nome,new.CodigoPostal,new.Saldo,new.UltimaFatura);
	end if;


-- para alterar o CodigoPostal

    if new.CodigoPostal <> old.CodigoPostal then
		set novo_CodigoPostal = (select CodigoPostal from CodigoPostal where CodigoPostal = new.CodigoPostal);
            insert into Registos(DateTime,Action,ID,Nome,CodigoPostal,Saldo,UltimaFatura)
			value (now(),'Inserir(Depois)',new.ID,new.Nome,new.CodigoPostal,new.Saldo,new.UltimaFatura);
        end if;
        
        
        -- para alterar o Saldo

    if new.Saldo <> old.Saldo then
		set novo_Saldo = (select Saldo from Saldo where Saldo = new.Saldo);
            insert into Registos(DateTime,Action,ID,Nome,CodigoPostal,Saldo,UltimaFatura)
			value (now(),'Inserir(Depois)',new.ID,new.Nome,new.CodigoPostal,new.Saldo,new.UltimaFatura);
        end if;

        -- para alterar UltimaFatura

    if new.UltimaFatura <> old.UltimaFatura then
		set novo_UltimaFatura = (select UltimaFatura from UltimaFatura where UltimaFatura = new.UltimaFatura);
            insert into Registos(DateTime,Action,ID,Nome,CodigoPostal,Saldo,UltimaFatura)
			value (now(),'Inserir(Depois)',new.ID,new.Nome,new.CodigoPostal,new.Saldo,new.UltimaFatura);
        end if;
end;
//


delimiter //
create trigger faturas_after_delete
after delete on Faturas
for each row
begin

insert into Registos(DateTime,Action,ID,Nome,CodigoPostal,Saldo,UltimaFatura)
value (now(),'Delete',old.ID,old.Nome,old.CodigoPostal,old.Saldo,old.UltimaFatura);



end;
//


