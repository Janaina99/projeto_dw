-- Cria��o do esquema e uso do banco de dados
DROP DATABASE ACADEMIA;
CREATE DATABASE ACADEMIA;
USE ACADEMIA;


-- Tabelas


CREATE TABLE TB_CLIENTE (
    ID INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(45) NOT NULL,
    TELEFONE VARCHAR(12) NULL,
    SEXO VARCHAR(10) NULL,
    CPF VARCHAR(15) NULL,
    DT_NASCIMENTO DATE NOT NULL,
    EMAIL VARCHAR(45) NOT NULL,
    BAIRRO VARCHAR(45) NOT NULL,
    CIDADE VARCHAR(45) NOT NULL,
    ESTADO VARCHAR(3) NOT NULL,
    RUA VARCHAR(45) NOT NULL,
    CASA_NUMERO VARCHAR(6) NOT NULL
);

CREATE TABLE TB_UNIDADE (
    ID INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(45) NOT NULL,
    TELEFONE VARCHAR(12) NOT NULL,
    BAIRRO VARCHAR(45) NOT NULL,
    CIDADE VARCHAR(45) NOT NULL,
    ESTADO VARCHAR(3) NOT NULL,
    RUA VARCHAR(45) NOT NULL,
    NUMERO VARCHAR(6) NOT NULL
);

CREATE TABLE TB_MODALIDADE (
    ID INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(45) NOT NULL,
    QUANTIDADE_SEMANA INT NULL
);

CREATE TABLE TB_PLANO (
    ID INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(45) NOT NULL,
    VALOR_MENSAL FLOAT NOT NULL
);

CREATE TABLE TB_MATRICULA (
    ID INT PRIMARY KEY IDENTITY(1,1),
    DT_MATRICULA DATE NOT NULL,
    DT_VENCIMENTO DATE NOT NULL,
    CLIENTE_ID INT NOT NULL,
    UNIDADE_ID INT NOT NULL,
    MODALIDADE_ID INT NOT NULL,
    PLANO_ID INT NOT NULL,
    CONSTRAINT FK_MATRICULA_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES TB_CLIENTE (ID),
    CONSTRAINT FK_MATRICULA_UNIDADE FOREIGN KEY (UNIDADE_ID) REFERENCES TB_UNIDADE (ID),
    CONSTRAINT FK_MATRICULA_MODALIDADE FOREIGN KEY (MODALIDADE_ID) REFERENCES TB_MODALIDADE (ID),
    CONSTRAINT FK_MATRICULA_PLANO FOREIGN KEY (PLANO_ID) REFERENCES TB_PLANO (ID)
);

CREATE TABLE TB_PAGAMENTO (
    ID INT PRIMARY KEY IDENTITY(1,1),
	DT_PREVISTA DATE NOT NULL,
    DT_PAGAMENTO DATE NULL,
    VALOR_PAGO FLOAT NOT NULL,
    MATRICULA_ID INT NOT NULL,
    CONSTRAINT FK_PAGAMENTO_MATRICULA FOREIGN KEY (MATRICULA_ID) REFERENCES TB_MATRICULA (ID)
);

CREATE TABLE TB_FUNCIONARIO (
    ID INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(45) NOT NULL,
    EMAIL VARCHAR(45) NULL,
    TELEFONE VARCHAR(12) NOT NULL,
    CARGO VARCHAR(45) NOT NULL,
    SALARIO FLOAT NULL,
    DT_NASCIMENTO DATE NOT NULL,
    CPF VARCHAR(15) NOT NULL,
    DT_ADMISSAO DATE NOT NULL,
    DT_DEMISSAO DATE NULL,
    UNIDADE_ID INT NOT NULL,
    BAIRRO VARCHAR(45) NOT NULL,
    CIDADE VARCHAR(45) NOT NULL,
    ESTADO VARCHAR(3) NOT NULL,
    RUA VARCHAR(45) NOT NULL,
    NUMERO VARCHAR(6) NOT NULL,
    CONSTRAINT FK_FUNCIONARIO_UNIDADE FOREIGN KEY (UNIDADE_ID) REFERENCES TB_UNIDADE (ID)
);

CREATE TABLE TB_FREQUENCIA (
    ID INT PRIMARY KEY IDENTITY(1,1),
    DT_FREQUENCIA DATE NULL,
    ENTRADA DATETIME NULL,
    SAIDA DATETIME NULL,
    CLIENTE_ID INT NOT NULL,
    CONSTRAINT FK_FREQUENCIA_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES TB_CLIENTE (ID)
);

CREATE TABLE TB_EQUIPAMENTO (
    ID INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(45) NOT NULL,
    DESCRICAO VARCHAR(45) NULL,
    DT_AQUISICAO DATE NOT NULL,
    QUANTIDADE INT NOT NULL,
    UNIDADE_ID INT NOT NULL,
    CONSTRAINT FK_EQUIPAMENTO_UNIDADE FOREIGN KEY (UNIDADE_ID) REFERENCES TB_UNIDADE (ID)
);