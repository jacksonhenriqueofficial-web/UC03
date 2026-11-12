USE lanchonete;

DROP TRIGGER IF EXISTS tg_item_baixa_estoque;
DELIMITER //
CREATE TRIGGER tg_item_baixa_estoque
AFTER INSERT ON item_pedido
FOR EACH ROW
BEGIN
    UPDATE estoque
       SET quantidade = quantidade - NEW.quantidade
     WHERE produto_codigo = NEW.produto_codigo
       AND unidade_codigo = (
           SELECT unidade_codigo
             FROM pedido
            WHERE numero = NEW.pedido_numero
       );
END //
DELIMITER ;

DROP TRIGGER IF EXISTS tg_produto_preco;
DROP TABLE IF EXISTS log_preco_produto;

CREATE TABLE log_preco_produto (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    produto_codigo  INT NOT NULL,
    preco_antigo    DECIMAL(6,2) NOT NULL,
    preco_novo      DECIMAL(6,2) NOT NULL,
    alterado_em     DATETIME NOT NULL,
    usuario         VARCHAR(100) NOT NULL,
    CONSTRAINT fk_log_preco_produto
        FOREIGN KEY (produto_codigo) REFERENCES produto (codigo)
);

DELIMITER //
CREATE TRIGGER tg_produto_preco
AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
    IF NEW.preco_tabela <> OLD.preco_tabela THEN
        INSERT INTO log_preco_produto
            (produto_codigo, preco_antigo, preco_novo, alterado_em, usuario)
        VALUES
            (NEW.codigo, OLD.preco_tabela, NEW.preco_tabela, NOW(), USER());
    END IF;
END //
DELIMITER ;

SHOW TRIGGERS;

INSERT INTO item_pedido (pedido_numero, produto_codigo, quantidade, preco_cobrado)
VALUES (11, 3, 2, 13.00);

SELECT quantidade AS estoque_restante
  FROM estoque
 WHERE unidade_codigo = 1 AND produto_codigo = 3;

-- Resultado esperado: o estoque da tapioca de queijo na unidade 1 passa de 10 para 8 unidades.

UPDATE produto
   SET disponivel = FALSE
 WHERE codigo = 6;

SELECT COUNT(*) AS linhas_no_log_do_produto_6
  FROM log_preco_produto
 WHERE produto_codigo = 6;

-- Resultado esperado: zero linha para o produto 6, pois preco_tabela nao mudou.
-- O produto de codigo 6 e o Suco de laranja, conforme os dados do arquivo-base.

INSERT INTO item_pedido (pedido_numero, produto_codigo, quantidade, preco_cobrado)
VALUES (11, 2, 20, 18.00);

SELECT quantidade AS estoque_atual
  FROM estoque
 WHERE unidade_codigo = 1 AND produto_codigo = 2;

-- Resultado esperado: a insercao e rejeitada pela restricao CHECK
(quantidade >= 0), pois ha somente 15 unidades em estoque. A operacao
nao deve deixar o estoque negativo nem inserir o item.

UPDATE produto SET preco_tabela = 9.00 WHERE codigo = 1;

UPDATE produto
   SET preco_tabela = preco_tabela
 WHERE codigo = 1;

SELECT
    l.id,
    p.codigo AS produto_codigo,
    p.nome AS produto,
    l.preco_antigo,
    l.preco_novo,
    l.alterado_em,
    l.usuario
FROM log_preco_produto AS l
INNER JOIN produto AS p
        ON p.codigo = l.produto_codigo
ORDER BY l.id;
