-- totas opções do joins(exemplos da imagem)


-- resgistos comuns a ambas
select * from Cursos A
inner join Disciplinas B using (ID);

-- registos que estao nos cursos e os registos comuns a ambas
select * from Cursos
left join Disciplinas using (ID);


-- registos que estao nas disciplinas e os registos comuns a ambas
select * from Cursos
Right join Disciplinas using (ID);


-- registos em que aparece apenas os cursos e exclui as em comum
select * from Cursos A
Left join Disciplinas B using (ID)
where B.DisciplinasNome is null;



-- registos em que aparece apenas o as disciplinas e exclui as em comum
select * from Cursos A
Right join Disciplinas B using (ID)
where A.nome is null;


-- registos em que aparece apenas o as disciplinas e exclui as em comum
select * from Cursos A
Right join Disciplinas B using (ID)
where A.nome is null;


-- registos em que aparece ambas e exclui as em comum

select * from Cursos A
LEFT JOIN Disciplinas B using(ID)
where A.nome is null or B.DisciplinasNome is null
Union
select * from Cursos A
Right JOIN Disciplinas B using (ID)
where A.nome is null or B.DisciplinasNome is null;

-- ambas as tabelas
select * from Cursos A
LEFT JOIN Disciplinas B using(ID)
Union
select * from Cursos A
Right JOIN Disciplinas B using (ID)
