/* Prática 18 – Lanchonete – o estoque e o log de preços
   Salve este arquivo como pratica-18.sql antes de começar. */
USE lanchonete;

-- passos 4 a 6: a trigger do estoque
DROP TRIGGER IF EXISTS tg_item_baixa_estoque;
DELIMITER $$
CREATE TRIGGER tg_item_baixa_estoque AFTER INSERT ON item_pedido
FOR EACH ROW
BEGIN
  -- a baixa: UPDATE estoque ... - NEW.quantidade
  -- só o produto do item: NEW.produto_codigo
  -- a unidade vem do pedido: (SELECT unidade_codigo FROM pedido ...)
END $$
DELIMITER ;

-- passos 7 a 9: o log e a trigger de auditoria
CREATE TABLE log_preco_produto (
	id 					int auto_increment primary key,
    produto_codigo 		int 		 not null,
    preco_antigo		decimal(4,2) not null,
    preco_novo			decimal(4,2) not null,
    usuario 			varchar(100) not null,
    alterado_em 		datetime 	 not null,
    foreign key (produto_codigo) references produto (codigo)
);
DROP TRIGGER IF EXISTS tg_produto_preco;
DELIMITER $$
CREATE TRIGGER tg_produto_preco AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
  if old.preco_tabela <> new.preco_tabela then
  insert into tg_produto_preco
	(
	preco_antigo, preco_novo, usuario, alterado_em
	)
  values 
	(
	old.preco_tabela, new.preco_tabela, current_user(), now()
	);
  end if;
END $$
DELIMITER ;

-- passo 10: os testes do quadro 1


-- passo 11: a ocorrência (pronta; não altere)
UPDATE produto SET preco_tabela = 9.00 WHERE codigo = 1;

-- passo 12: o que o log registrou (SELECT com JOIN)
