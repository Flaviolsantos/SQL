-- ex 1 - Quais os discos que temos dos The Rolling Stones ?

select titulo,bandas.nome from discos
join bandas using(idbandas)
where bandas.nome = 'The Rolling Stones';

-- 2 -Quais os disco que tem com o artista John Monis?
select titulo as Disco,artistas.nome as Artista from discos
join bandas using(idbandas)
join bandaartistas using(idbandas)
join artistas using(idartistas)
where artistas.nome = 'John Monis';

-- ex 3 Quais as bandas em que o John Chrystello participou?

select artistas.nome,bandas.nome from bandas
join bandaartistas using (idbandas)
join artistas using (idartistas)
where artistas.nome = 'John Chrystello';

-- ex 4 Quais os discos que tem de música Jazz ou Blues?
select titulo,generos.idgeneros from discos
join discosgeneros using (iddiscos)
join generos using (idgeneros)
where generos.desc = 'Jazz' or generos.desc = 'Blues';

-- or

select iddiscos from discosgeneros where idgeneros in (select idgeneros from generos
where generos.desc in ('Blues','Jazz'));


-- ex 5 Quais os discos que tem de bandas da Austrália?

select A.titulo as 'Disco',B.nome as 'Bandas',C.nome as 'País' from discos A
join bandas B using(idbandas)
join pais C using (idpais)
where C.nome = 'Austrália';

-- ex 6 Quais os discos que tem de bandas compostas apenas por mulheres?

select idbandas,C.nome as 'Banda',D.titulo as Disco from artistas A
join bandaartistas B using(idartistas)
join bandas C using  (idbandas)
join discos D using (idbandas)
where A.masculino <> 1 and idbandas not in (select idbandas from bandaartistas 
join artistas using (idartistas) where masculino <> 0 );

-- or

-- ---------------------------------
drop view if exists mulheres;
create view mulheres as
select a.idbandas, b.no0me, b.masculino from bandaartistas a
join artistas b using(idartistas)
where b.masculino = 1
;

drop view if exists somulheres;
create view somulheres as
select * from mulheres
where idbandas not in (select a.idbandas from bandaartistas a
join artistas b using(idartistas)
where b.masculino = 0)
;

select * from discos a
join somulheres b using (idbandas)
;
-- -------------------------------------------

select idbandas, iddiscos from discos A
join bandas B using (idbandas)
join bandaartistas C using(idbandas)
where C.idartistas in (select D.idartistas from artistas D
where D.masculino = '0')
having idbandas not in (select idbandas from discos A
join bandas B using (idbandas)
join bandaartistas C using(idbandas)
where C.idartistas in (select D.idartistas from artistas D
where D.masculino = '1'));

-- --------------------------------------


select A.idbandas, count(*) as socias from bandaartistas A
where A.idbandas in (
    select idbandas mulheres from bandaartistas
    join artistas using (idartistas)
    where masculino = 0
    group by idbandas
    having mulheres > 0
)
group by A.idbandas
having socias in (
    select count(*) mul from bandaartistas B
    join artistas c using (idartistas)
    where c.masculino = 0
    and B.idbandas = A.idbandas
    group by B.idbandas
    having mul > 0
);
-- -------------------------------------------------
SELECT A.titulo FROM discos A 
JOIN bandas B using(idbandas)
JOIN bandaartistas using(idbandas)
JOIN artistas using(idartistas)
WHERE B.idbandas in (SELECT C.idbandas FROM bandas C
JOIN bandaartistas using(idbandas)
JOIN artistas B using(idartistas)
GROUP BY C.idbandas
HAVING sum(B.masculino) = 0);


-- ex 7 Quais os disco que tem de artistas solo (apenas um elemento na banda)?

select B.nome,A.nome from bandaartistas C
join artistas A using (idartistas)
join bandas B using (idbandas)
group by C.idbandas
having count(C.idartistas) = 1


-- ex 8 Quais os discos que estão disponíveis em mais do que um formato? Por exemplo, “Em que formatos (78,45,33) tem o Dark All Day?”

