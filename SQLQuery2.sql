select {columnas}
from {tablas}
inner join {mas tablas}
where {filtrar datos}
group by {agregar datos}
having {filtrar grupos}
order by {ordenar filas}

-- DQL - selcet query 
select *
from actores

select top 10 *
from Actores

select max(fecha_nac)
from Actores

select min(fecha_nac)
from Actores

select min (fecha_nac) MINIMO, max (fecha_nac) MAXIMO
from Actores

select distinct fecha_nac
from Actores

select distinct sexo
from Actores

select format (sum(recaudacion),'C0'),  sum (recaudacion)
from Peliculas

select * 
from Actores
WHERE sexo = 'M'

select * 
from Actores
where fecha_nac > '1942-07-13'

select * 
from Actores
--ESTRAMOS FILTRANDO POR FECHA DE NAC, BETWEEN (ENTRE)
where fecha_nac between '1942-07-13' and '1956-10-21'

select *
from Actores
-- "in" busca sobre una lista de datos, 
where fecha_nac	in ('1942-07-13','1949-06-22','1946-09-15')

select *
from Actores
-- "AND" buscando sobre el sexo femenino 
where nombre like '%H%' and sexo = 'F'

select *
from Actores
where fecha_nac like '1984%'

select *
from Actores
--usamos corchetes para buscar con una exprecion regular 
where nombre like '[AM]%'

select *
from Actores
--DATEPART-year, busca primero sobre el año, es mejor que usar like.  
where DATEPART (year, fecha_nac) = '1984' 

select DATEPART(year, GETDATE())
select DATEPART(month, GETDATE())
select DATEPART(day, GETDATE())

--resta dias a la fecha actual
select GETDATE() -31
--sumando 10 años con DATEADD (se puede usar para dias, meses y años )
select DATEADD(year, 10, GETDATE()) 
--restando 10 años con DATEADD (se puede usar para dias, meses y años )
select DATEADD(year, -10, GETDATE())
--buscamos la diferencia en dias entre dos fechas, usamos "DATEDIFF"
select DATEDIFF(day, '1995-01-03', '2023-11-25')

select *
from Actores
--DATEPART-year, busca primero sobre el año, es mejor que usar like.  
where DATEPART (year, fecha_nac) in ('1942','1949','1946')

--DATEPART= filtra sobre un dato especifico 
--DATEDIFF= busca la diferencia entre datos
--DATEADD= agrega o resta datos 

--tambien podemos usar el NOT para negar, y dar una respueta contraria de lo que se busca
--ejemplo not between, dario el resultado por fuera de betwenn

select case
			when clasificacion = 'R' then 'Violencia'
			when clasificacion = 'PG' then 'Apto todo publico'
			when clasificacion = 'PG-13' then 'Apto mayores 13 años'
			else 'Escenas XXX'
			end 'tipo'
from Peliculas

--con count le pedimos que cuente cuantos datos hay dentro de los parametros seleccionados 
select sexo, count (*) cantidad
from Actores
where DATEPART(year, fecha_nac) between '1980' and '1989'
group by sexo 

select año_estreno, count (*) cantidad
from peliculas 
group by año_estreno
--filtrando dentro de los  grupos
having count(*)>2
order by cantidad

/******** subconsultas *********/

select *
from peliculas 
where id_productora = 2001

select *, 
	(select distinct nombre from productoras where Productoras.id_productora = Peliculas.id_productora) productora  
from Peliculas
--subconsukta en where
where id_productora in (select id_productora from Productoras where nombre in ('20th Century Fox', 'Warner Bros.'))


select *, 
	--subconsulta en select 
	(select distinct nombre from productoras PRO where PRO.id_productora = PELIS.id_productora) productora ,
	(select nombre from directores DIRE where DIRE.id_director = PELIS.id_director) director
from Peliculas PELIS


--************* join implicito **********
select*
from peliculas, productoras, directores
where peliculas. id_productora = Productoras.id_productora and Peliculas.id_director=Directores.id_director

--*********** inner join ************

select {columnas}
	inner join {tabla}


--consultamos las coincidencias exactas 
select *
from peliculas PELIS
	inner join productoras PRO ON PELIS.id_productora = PRO.id_productora 
	inner join directores DIRE ON PELIS.id_director =	DIRE.id_director


	--consultamos sobre los null 
select *
from peliculas PELIS
	inner join productoras PRO ON PELIS.id_productora = PRO.id_productora 
	left join directores DIRE ON PELIS.id_director =	DIRE.id_director
where DIRE.nombre is null
	
/*1. LISTAR PLICULAS SIN DIRECTOR*/
-- primero pedimos todas las columnas, de la tabla peliculas + "left join" la tabla de directores, y buscamos las coincidencias teniendo en cuneta los null
-- y luego filtramos "where" los resultados nulos de esa busqueda.
select *
from peliculas PELIS
	left join directores DIRE ON PELIS.id_director = DIRE.id_director
where DIRE.id_director is null  

/*2.LISTAR PELICULAS SIN PRODUCTORAS*/
--En este caso nos devulve una respuesta vacia ya que todas las peliculas poseen una productora 
select *
from peliculas PELIS
		left join productoras PRO ON PELIS.id_productora = PRO.id_productora
where PRO.id_productora is null

/*3.LISTAR PELICULAS SIN ACTORES*/
--Al igual que en el caso anterior todas las peliculas poseen actores
select *
from peliculas PELIS, Actores ACTO
	left join Actuaciones ACTU ON ACTU.id_actor = ACTO.id_actor
where ACTO.id_actor is null 

/*4. LISTAR ACTORES SIN PAPELES*/
--En este ejercicio no estoy seguro si llegue al resultado correcto, se empezo a complicar
select *
from Actores ACTO	
	left join actuaciones ACTU ON ACTU.id_actor = ACTO.id_actor
	left join peliculas PELIS ON PELIS.id_pelicula = ACTU.id_pelicula
where ACTU.papel is null 

/*5.LISTAR CANTIDAD DE PELICULAS POR PRODUCTORA O RECAUDACION > $100.000.000*/

select recaudacion
from peliculas
 inner join Productoras PRO ON PRO.id_productora = peliculas.id_productora
 group by recaudacion 



 select año_estreno, count (*) cantidad
from peliculas 
group by año_estreno
--filtrando dentro de los  grupos
having count(*)>2
order by cantidad
	










