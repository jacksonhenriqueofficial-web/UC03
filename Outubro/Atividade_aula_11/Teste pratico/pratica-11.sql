use sakila;
describe film;
create database if not exists lanchonete character set utf8mb4;
use lanchonete;
create table if not exists bairro (
	id 				int auto_increment primary key,
	nome_bairo 		varchar(100) not null,
	taxa_entrega 	decimal(6,2)
 );
create table if not exists endereco_cliente(
	id int auto_increment primary key,
    logradouro 		varchar(150) not null,
    numero 			int,
    complemento 	varchar(150)
);
create table if not exists produto(
	codigo 			int auto_increment primary key,
    nome_produto 	varchar(150) not null,
    preco 			decimal(6,2) not null
);
create table if not exists cliente(
	cliente_id 		int auto_increment primary key,
    nome 			varchar(100) not null,
    endereco_id 	int not null,
    bairro_id 		int not null,
    cpf char(14) 	unique not null,
    foreign key (endereco_id) references endereco_cliente(id),
    foreign key (bairro_id) references bairro(id)
);
create table if not exists telefone_cliente(
	id 				int auto_increment primary key,
	cliente_id 		int not null,
    telefone 		char(20),
    foreign key (cliente_id) references cliente(cliente_id)
);
create table pedido(
	codigo 			int auto_increment primary key,
    data 			date not null,
    cliente_id 		int not null,
    total_pedido 	decimal(6,2) not null,
    forma_pagamento varchar(60) not null,
    foreign key (cliente_id) references cliente(cliente_id)
);
create table item_pedido(
	codigo_pedido int not null, 
    codigo_produto int not null,
    quantidade int not null,
    foreign key (codigo_pedido) references pedido(codigo),
    foreign key (codigo_produto) references produto(codigo)
);