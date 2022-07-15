
-- LIMPAR OS TRIGGERS


drop trigger  if exists meses_before_insert;
drop trigger  if exists meses_before_update;
drop trigger  if exists meses_before_delete;
drop trigger  if exists dias_before_insert;
drop trigger  if exists dias_before_update;





-- MESES_BEFORE_INSERT -- tabela meses antes de inserir valores

delimiter //
create trigger meses_before_insert
before insert on meses
for each row
begin
	DECLARE mensagem VARCHAR(255);
    DECLARE nome_do_mes VARCHAR(255);
    -- Verificar se o número do mês é nulo
	if new.mes is null then
		signal sqlstate '45000' set message_text = 'O número do mês não pode ser nulo.';
	end if;
    -- Verificar se o nome do mês é nulo
	if new.nome is null then
		signal sqlstate '45000' set message_text = 'O nome do mês não pode ser nulo.';
	end if;
    -- Verificar se o mês é entre 1 e 12
	if new.mes < 1 OR new.mes > 12 then
		signal sqlstate '45000' set message_text = 'O número do mês deve ser entre 1 e 12.';
	end if;
    -- Verificar se o mês já existe
	if (select count(*) from meses where mes = new.mes) > 0 then
		set nome_do_mes = (select nome from meses where mes = new.mes);
		set mensagem = concat('O mês ',new.mes,' - ', nome_do_mes,' já existe.');
		signal sqlstate '45000' set message_text = mensagem;
	end if;
    -- Verificar se o nome do mês é válido
	if new.nome not in ('Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro') then
		set mensagem = concat('O nome que inseriu:"',new.nome,'" não é válido');
        signal sqlstate '45000' set message_text = mensagem;
	end if;
end;
//





-- MESES_BEFORE_UPDATE -- tabela meses antes de fazer update



delimiter //
create trigger meses_before_update
before update on meses
for each row
begin
	DECLARE mensagem VARCHAR(255);
    DECLARE nome_do_mes VARCHAR(255);
    DECLARE registos INT;
    -- Verificar se o número do mês é nulo
	if new.mes is null then
		signal sqlstate '45000' set message_text = 'O número do mês não pode ser nulo.';
	end if;
    -- Verificar se o nome do mês é nulo
	if new.nome is null then
		signal sqlstate '45000' set message_text = 'O nome do mês não pode ser nulo.';
	end if;
    -- Verificar se o mês é entre 1 e 12
	if new.mes < 1 OR new.mes > 12 then
		signal sqlstate '45000' set message_text = 'O número do mês deve ser entre 1 e 12.';
	end if;
    -- Verificar se o nome do mês é válido
	if new.nome not in ('Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro') then
		set mensagem = concat('O nome que inseriu:"',new.nome,'" não é válido');
        signal sqlstate '45000' set message_text = mensagem;
	end if;
    -- Verificar se o mês já existe
    if new.mes <> old.mes then
		if new.mes in (select mes from meses) then
			set nome_do_mes = (select nome from meses where mes = new.mes);
			set mensagem = concat('O mês ',new.mes,' - ', nome_do_mes,' já existe. Criaria um registo duplicado.');
			signal sqlstate '45000' set message_text = mensagem;
		end if;
	end if;
end;
//





-- MESES_BEFORE_DELETE -- tabela meses antes de apagar qualquer valor


delimiter //
create trigger meses_before_delete
before delete on meses
for each row
begin
	DECLARE mensagem VARCHAR(255);
    DECLARE registos VARCHAR(255);
    set registos = (select count(*) from dias where mes = old.mes);
	if (registos > 0) then
		set mensagem = concat('Há ', registos, 'registo na tabela dias para o mês ',old.mes,' e por isso não pode ser eliminado.');
		signal sqlstate '45000' set message_text = mensagem;
	end if;
end;
//




-- DIAS_BEFORE_INSERT -- tabela dias antes de inserir qualquer valor



delimiter //
create trigger dias_before_insert
before insert on dias
for each row
begin
	DECLARE mensagem VARCHAR(255);
    DECLARE onome VARCHAR(255);
    -- Verificar se o número do mês é nulo
	if new.mes is null then
		signal sqlstate '45000' set message_text = 'O número do mês não pode ser nulo.';
	end if;
    -- Verificar se o número de dias é nulo
	if new.numdias is null then
		signal sqlstate '45000' set message_text = 'O número de dias não pode ser nulo.';
	end if;
	set onome = (select nome from meses where mes = new.mes);
    if onome is null then
		set mensagem = concat('Está a tentar inserir um registo para o mês ', new.mes,' , mas ele não existe na tabelas meses.');
		signal sqlstate '45000' set message_text = mensagem;
    end if;
	case
    when new.mes IN (1,3,5,7,8,10,12) then
		if new.numdias <> '31' then
			set mensagem = concat(onome, ' tem 31 dias!');
			signal sqlstate '45000' set message_text = mensagem;
		end if;
    when new.mes IN (4,6,9,11) then
		if new.numdias <> '30' then
			set mensagem = concat(onome, ' tem 30 dias!');
			signal sqlstate '45000' set message_text = mensagem;
		end if;
    when new.mes IN (2) then
		if new.numdias < '28' OR new.numdias > '29' then
			set mensagem = concat(onome, ' tem 28 ou 29 dias!');
			signal sqlstate '45000' set message_text = mensagem;
		end if;
	end case;
end;
//



-- DIAS_BEFORE_UPDATE -- TABELA DIAS ANTES DE FAZER UPDATE


delimiter //
create trigger dias_before_update
before update on dias
for each row
begin
	DECLARE mensagem VARCHAR(255);
    DECLARE onome VARCHAR(255);
    set onome = null;
    -- Verificar se o número do mês é nulo
	if new.mes is null then
		signal sqlstate '45000' set message_text = 'O número do mês não pode ser nulo.';
	end if;
    -- Verificar se o número de dias é nulo
	if new.numdias is null then
		signal sqlstate '45000' set message_text = 'O número de dias não pode ser nulo.';
	end if;
	set onome = (select nome from meses where mes = new.mes);
    if onome is null then
		set mensagem = concat('Está a tentar inserir um registo para o mês ', new.mes,' , mas ele não existe na tabelas meses.');
		signal sqlstate '45000' set message_text = mensagem;
    end if;
	case
    when new.mes IN (1,3,5,7,8,10,12) then
		if new.numdias <> '31' then
			set mensagem = concat(onome, ' tem 31 dias!');
			signal sqlstate '45000' set message_text = mensagem;
		end if;
    when new.mes IN (4,6,9,11) then
		if new.numdias <> '30' then
			set mensagem = concat(onome, ' tem 30 dias!');
			signal sqlstate '45000' set message_text = mensagem;
		end if;
    when new.mes IN (2) then
		if new.numdias < '28' OR new.numdias > '29' then
			set mensagem = concat(onome, ' tem 28 ou 29 dias!');
			signal sqlstate '45000' set message_text = mensagem;
		end if;
	end case;
end;
//

