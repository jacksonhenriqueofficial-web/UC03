Create database if not exists embalagens character set utf8mb4;
USE embalagens;
CREATE TABLE unidade (
  id 			INT AUTO_INCREMENT PRIMARY KEY,
  nome   		VARCHAR(60) NOT NULL unique,
  telefone 		varchar(20) not null,
  cidade 		varchar(60) not null
);
CREATE TABLE resina (
  id 			INT AUTO_INCREMENT PRIMARY KEY,
  nome   		VARCHAR(60) NOT NULL unique
);
CREATE TABLE produto (
  id 			INT AUTO_INCREMENT PRIMARY KEY,
  nome   		VARCHAR(60) NOT NULL unique,
  preco 		DECIMAL(6,2) NOT NULL CHECK (preco > 0)
);
CREATE TABLE cliente (
  id 			INT AUTO_INCREMENT PRIMARY KEY,
  razao_social 	varchar(60) Not null,
  cnpj   		VARCHAR(14) NOT NULL unique,
  telefone 		varchar(20) null,
  cidade 		varchar(60) not null
);
CREATE TABLE expedir (
  numero        INT AUTO_INCREMENT PRIMARY KEY,
  data_hora     DATETIME NOT NULL,
  cliente_id    INT NOT NULL,
  unidade_id    INT NOT NULL,
  produto_id	INT NOT NULL,
  FOREIGN KEY (cliente_id)    REFERENCES cliente (id),
  FOREIGN KEY (unidade_id)    REFERENCES unidade (id),
  FOREIGN KEY (produto_id) 	  REFERENCES produto (id)
);
CREATE TABLE producao (
  numero        INT AUTO_INCREMENT PRIMARY KEY,
  data_hora     DATETIME NOT NULL,
  resina_id    	INT NOT NULL,
  unidade_id    INT NOT NULL,
  produto_id	INT NOT NULL,
  qtd 			INT NOT NULL,
  FOREIGN KEY (resina_id)     REFERENCES resina (id),
  FOREIGN KEY (unidade_id)    REFERENCES unidade (id),
  FOREIGN KEY (produto_id) 	  REFERENCES produto (id)
  );
  CREATE TABLE contem (
  resina_id    	INT NOT NULL,
  unidade_id    INT NOT NULL,
  qtd			INT NOT NULL,
  PRIMARY KEY (unidade_id),
  CONSTRAINT fk_unidade
  FOREIGN KEY (unidade_id)
	REFERENCES unidade (id)
    ON DELETE CASCADE,
  FOREIGN KEY (resina_id) 	  REFERENCES resina (id)
  );
