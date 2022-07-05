select cursoformando.idcursos, cursos.nome, cursoformando.idformandos,formandos.idformandos, formandos.nome
from formandos

-- mostrar quen nao tem cursos --
left join cursoformando using(idformandos)
left join cursos using (idcursos)


-- juntar duas tabelas
where cursoformando.idcursos = cursos.idcursos
and cursoformando.idformandos = formandos.idformandos;



-- tres formas de listar entre um certo numero de valores

select * from formandos
where idformandos between 10 and 15


select * from formandos
where idformandos >=10 and idformandos <=15


select * from formandos
where idformandos in(10,11,12,13,14,15)



-- ID do formando Flavio Santos


select idformandos from formandos
where nome = 'Flávio Lourenço dos Santos';

select * from cursoformando
join cursos using(idcursos)
join formandos using(idformandos)
where idformandos =(select idformandos from formandos
where nome = 'Flávio Lourenço dos Santos');

---------------------------------------------------

-- ID do formando Flavio Santos

select idformandos from formandos
where nome = 'Flávio Lourenço dos Santos';

select idcursos from cursoformando
where idformandos = (select idformandos from formandos
where nome = 'Flávio Lourenço dos Santos');

-- lista das pessoas do curso do flavio
select idcursos, cursos.nome,idformandos, formandos.nome
from cursoformando  
join formandos using(idformandos)
join cursos using(idcursos)
where idcursos = (select idcursos from cursoformando
where idformandos = (select idformandos from formandos
where nome = 'Flávio Lourenço dos Santos'))

-- ordem do formando
order by formandos.nome;
