use sakila;

show tables;

select 
	actor_id as codigo,
	first_name as nome,
	last_name as sobrenome
from actor
where actor_id >= 5 
limit 5;
/*
	Operadores relacionais no SQL:
    O sinal de = ele não armazena variável, ele é o sinal de igualdade
    > maior que 
    < menor que 
    >= maior ou igual
    <= menor ou igual
    <> diferente
    
    Operadores lógicos:
    E passa a ser AND no SQL
    OU passa a ser OR no SQL
    NÃO passa a ser NOT no SQL
    
    Condicionais:
    SE passa a ser o IF
*/
Select distinct rental_duration as dias_de_locacao
From film
order by dias_de_locacao asc;

Select 
	title as Filme,
    length as Minutos,
    Length / 60 as horas,
(select first_name from actor limit 1) as ator
from film
WHERE film_id <= 5;
SELECT title, rating, rental_rate, length
from film
where rating = 'G' and rental_rate = 0.99 or length < 50;

SELECT title, rating, length 
from film
where rating = 'PG-13'
and length between 90 and 100
Order by length, title;  