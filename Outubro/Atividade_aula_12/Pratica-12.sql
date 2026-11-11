DROP DATABASE IF EXISTS lanchonete;
CREATE DATABASE lanchonete;
USE lanchonete;
CREATE TABLE unidade (
  codigo   INT AUTO_INCREMENT PRIMARY KEY,
  nome     VARCHAR(60) NOT NULL,
  endereco VARCHAR(150) NULL
) COMMENT = 'Unidades da lanchonete';
CREATE TABLE cliente (
  codigo   INT AUTO_INCREMENT PRIMARY KEY,
  nome     VARCHAR(80) NOT NULL,
  telefone VARCHAR(15) UNIQUE
);
CREATE TABLE produto (
  codigo       INT AUTO_INCREMENT PRIMARY KEY,
  nome         VARCHAR(60) NOT NULL UNIQUE,
  preco_tabela DECIMAL(6,2) NOT NULL CHECK (preco_tabela > 0)
);
CREATE TABLE entregador (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nome   VARCHAR(60) NOT NULL
);
CREATE TABLE pedido (
  numero            INT AUTO_INCREMENT PRIMARY KEY,
  data_hora         DATETIME NOT NULL,
  cliente_codigo    INT NOT NULL,
  unidade_codigo    INT NOT NULL,
  entregador_codigo INT NULL,
  FOREIGN KEY (cliente_codigo)    REFERENCES cliente (codigo),
  FOREIGN KEY (unidade_codigo)    REFERENCES unidade (codigo),
  FOREIGN KEY (entregador_codigo) REFERENCES entregador (codigo)
);
CREATE TABLE estoque (
  unidade_codigo INT NOT NULL,
  produto_codigo INT NOT NULL,
  quantidade     INT NOT NULL CHECK (quantidade >= 0),
  PRIMARY KEY (unidade_codigo, produto_codigo),
  FOREIGN KEY (unidade_codigo) REFERENCES unidade (codigo),
  FOREIGN KEY (produto_codigo) REFERENCES produto (codigo)
);
ALTER TABLE produto ADD COLUMN disponivel BOOLEAN NOT NULL DEFAULT TRUE;
INSERT INTO unidade (nome, endereco) VALUES
  ('Motos universitárias', 'Av. Marcelo do Grau, 171'),
  ('País dos Rios', 'Rua Projeto A, 1A'),
  ('Hogwarts', 'Rua Harry Potter, 62442');
INSERT INTO cliente (nome, telefone) VALUES
  ('Monalisa', '91503-1911'),
  ('Quagmire', '91999-1948'),
  ('Hal Jordan', '93600-2814');
INSERT INTO produto (nome, preco_tabela) VALUES
  ('Açaí 300 ml', 12.00),
  ('Açaí 500 ml', 18.00),
  ('Tapioca de queijo', 13.00),
  ('Teste', 1.00);
INSERT INTO entregador (nome) VALUES ('Barry Allen'), ('Sponge bob'), ('Turbo'), ('Eobard Thawne'), ('Mercúrio'), ('Arraia-a-jato'), ('Sonic'), ('Morgoth');
select nome from entregador;