USE embalagens;

-- ETAPA 1: dados de teste (INSERT e UPDATE)

-- Inserção das 5 ordens de produção (Quadro 1)
INSERT INTO ordem_producao (data_ordem, qtd_planejada, qtd_boa, qtd_refugo, consumo_kg, unidade_codigo, produto_codigo) VALUES
  ('2026-11-03', 5000, 4800, 200,  60.00, 1, 1),
  ('2026-11-03', 5000, 4950,  50,  25.00, 1, 2),
  ('2026-11-04', 8000, 7650, 350, 160.00, 2, 3),
  ('2026-11-05', 3000, 2880, 120,  18.00, 3, 2),
  ('2026-11-05', 4000, 3900, 100,  48.00, 1, 1);

-- Inserção das 2 expedições de 06/11/2026 (Quadro 2)
INSERT INTO expedicao (numero, data_saida, unidade_codigo, cliente_cnpj) VALUES
  (1, '2026-11-06', 1, '11.111.111/0001-11'),
  (2, '2026-11-06', 2, '22.222.222/0001-22');

-- Inserção dos 3 itens das expedições (Quadro 2)
INSERT INTO item_expedicao (expedicao_numero, produto_codigo, quantidade, preco_cobrado) VALUES
  (1, 1, 2000, 0.45),
  (1, 2, 2000, 0.12),
  (2, 3, 5000, 0.65);

-- Atualização do preço de tabela do Pote 500 ml (código 1) para 0,48
UPDATE produto
SET preco_tabela = 0.48
WHERE codigo = 1;


-- ETAPA 2: consultas 1 a 5

-- Consulta 1: ordens com refugo acima de 100, do maior para o menor refugo
SELECT o.numero,
       o.data_ordem,
       u.nome AS unidade,
       p.nome AS produto,
       o.qtd_planejada,
       o.qtd_boa,
       o.qtd_refugo,
       o.consumo_kg
FROM ordem_producao o
INNER JOIN unidade u ON o.unidade_codigo = u.codigo
INNER JOIN produto p ON o.produto_codigo = p.codigo
WHERE o.qtd_refugo > 100
ORDER BY o.qtd_refugo DESC;

-- Consulta 2: total de refugo por produto, do maior para o menor
SELECT p.nome,
       SUM(o.qtd_refugo) AS total_refugo
FROM ordem_producao o
INNER JOIN produto p ON o.produto_codigo = p.codigo
GROUP BY p.codigo, p.nome
ORDER BY total_refugo DESC;

-- Consulta 3: unidades com mais de 5000 peças boas no total
SELECT u.nome,
       SUM(o.qtd_boa) AS total_pecas_boas
FROM ordem_producao o
INNER JOIN unidade u ON o.unidade_codigo = u.codigo
GROUP BY u.codigo, u.nome
HAVING SUM(o.qtd_boa) > 5000
ORDER BY total_pecas_boas DESC;

-- Consulta 4: cliente, unidade, produto, quantidade e valor (quantidade x preço cobrado) de cada item expedido
SELECT c.razao_social AS cliente,
       u.nome AS unidade,
       p.nome AS produto,
       ie.quantidade,
       (ie.quantidade * ie.preco_cobrado) AS valor
FROM item_expedicao ie
INNER JOIN expedicao e ON ie.expedicao_numero = e.numero
INNER JOIN cliente c ON e.cliente_cnpj = c.cnpj
INNER JOIN unidade u ON e.unidade_codigo = u.codigo
INNER JOIN produto p ON ie.produto_codigo = p.codigo;

-- Consulta 5: clientes sem nenhuma expedição
SELECT c.cnpj,
       c.razao_social,
       c.cidade,
       c.telefone
FROM cliente c
LEFT JOIN expedicao e ON c.cnpj = e.cliente_cnpj
WHERE e.numero IS NULL;


-- ETAPA 3: view, procedure e trigger

-- View que apresenta o total de refugo por produto, ordenado do maior para o menor
CREATE OR REPLACE VIEW vw_refugo_produto AS
SELECT p.nome,
       SUM(o.qtd_refugo) AS total_refugo
FROM ordem_producao o
INNER JOIN produto p ON o.produto_codigo = p.codigo
GROUP BY p.codigo, p.nome
ORDER BY total_refugo DESC;

-- Procedure que registra um item na expedição utilizando o preço de tabela atual do produto
DELIMITER $$
CREATE PROCEDURE sp_registrar_item (
  IN p_expedicao_numero INT,
  IN p_produto_codigo INT,
  IN p_quantidade INT
)
BEGIN
  DECLARE v_preco_tabela DECIMAL(8,2);

  SELECT preco_tabela INTO v_preco_tabela
  FROM produto
  WHERE codigo = p_produto_codigo;

  INSERT INTO item_expedicao (expedicao_numero, produto_codigo, quantidade, preco_cobrado)
  VALUES (p_expedicao_numero, p_produto_codigo, p_quantidade, v_preco_tabela);
END $$
DELIMITER ;

-- Teste da procedure: registra 5000 unidades do produto 4 na expedição 2 e confere o preço cobrado (0,08)
CALL sp_registrar_item(2, 4, 5000);
SELECT * FROM item_expedicao WHERE expedicao_numero = 2 AND produto_codigo = 4;

-- Trigger que desconta do estoque da unidade o consumo em kg da resina do produto após inserir uma ordem de produção
DELIMITER $$
CREATE TRIGGER tg_ordem_baixa_resina
AFTER INSERT ON ordem_producao
FOR EACH ROW
BEGIN
  DECLARE v_resina_codigo INT;

  SELECT resina_codigo INTO v_resina_codigo
  FROM produto
  WHERE codigo = NEW.produto_codigo;

  UPDATE estoque_resina
  SET quantidade_kg = quantidade_kg - NEW.consumo_kg
  WHERE unidade_codigo = NEW.unidade_codigo
    AND resina_codigo = v_resina_codigo;
END $$
DELIMITER ;

-- Teste da trigger: insere ordem de 09/11/2026 e confere a queda do estoque da resina 3 na unidade 2 (900 -> 880)
INSERT INTO ordem_producao (data_ordem, qtd_planejada, qtd_boa, qtd_refugo, consumo_kg, unidade_codigo, produto_codigo)
VALUES ('2026-11-09', 1000, 950, 50, 20.00, 2, 3);

SELECT * FROM estoque_resina WHERE unidade_codigo = 2 AND resina_codigo = 3;


-- ETAPA 4: privilégios dos perfis e SHOW GRANTS

-- Privilégios do operador (menor privilégio: lançar e ler ordens de produção; ler produtos)
GRANT SELECT, INSERT ON embalagens.ordem_producao TO 'emb_operador'@'localhost';
GRANT SELECT ON embalagens.produto TO 'emb_operador'@'localhost';

-- Privilégios do gerente (ler todo o banco; alterar a tabela produto)
GRANT SELECT ON embalagens.* TO 'emb_gerente'@'localhost';
GRANT UPDATE ON embalagens.produto TO 'emb_gerente'@'localhost';

FLUSH PRIVILEGES;

-- Conferência dos privilégios concedidos a cada usuário
SHOW GRANTS FOR 'emb_operador'@'localhost';
SHOW GRANTS FOR 'emb_gerente'@'localhost';
