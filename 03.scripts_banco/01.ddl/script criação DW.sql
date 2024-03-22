USE ACADEMIA

-- DIMENS�ES


CREATE TABLE DIM_TEMPO (
	ID_TEMPO BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	NIVEL VARCHAR(8) NOT NULL CHECK (NIVEL IN ('DIA','MES','ANO')),
	DATA DATETIME NULL,
	DIA INT NULL,
	NOME_DIA VARCHAR(20) NULL,
	FIM_SEMANA VARCHAR(3) NULL CHECK (FIM_SEMANA IN ('SIM','NAO')),
	MES INT NULL,
	NOME_MES VARCHAR(15) NULL,
	TRIMESTRE INT NULL,
	NOME_TRIMESTRE VARCHAR(45) NULL,
	SEMESTRE INT NULL,
	NOME_SEMESTRE VARCHAR(45) NULL,
	ANO INT NOT NULL
);

CREATE TABLE DIM_CLIENTE (
    ID_CLIENTE INT PRIMARY KEY IDENTITY(1,1),
	COD_CLIENTE INT NOT NULL,
    NOME VARCHAR(45) NOT NULL,
    CPF VARCHAR(15) NOT NULL,
    DT_NASCIMENTO DATE NOT NULL,
    BAIRRO VARCHAR(45) NOT NULL,
    CIDADE VARCHAR(45) NOT NULL,
    ESTADO VARCHAR(3) NOT NULL
);

CREATE TABLE DIM_UNIDADE (
    ID_UNIDADE INT PRIMARY KEY IDENTITY(1,1),
	COD_UNIDADE INT NOT NULL,
    NOME VARCHAR(45) NOT NULL,
    BAIRRO VARCHAR(45) NOT NULL,
    CIDADE VARCHAR(45) NOT NULL,
    ESTADO VARCHAR(3) NOT NULL
);

CREATE TABLE DIM_MODALIDADE (
    ID_MODALIDADE INT PRIMARY KEY IDENTITY(1,1),
	COD_MODALIDADE INT NOT NULL,
    NOME VARCHAR(45) NOT NULL
);

CREATE TABLE DIM_PLANO (
    ID_PLANO INT PRIMARY KEY IDENTITY(1,1),
	COD_PLANO INT NOT NULL,
    NOME VARCHAR(45) NOT NULL,
    VALOR NUMERIC(10,2) NOT NULL,
	DT_INICIO DATETIME NOT NULL,
	DT_FIM DATETIME NULL,
	FL_CORRENTE VARCHAR(3) NOT NULL CHECK (FL_CORRENTE IN ('SIM','NAO'))
);

CREATE TABLE DIM_STATUS (
    ID_STATUS INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(10) NOT NULL CHECK (NOME IN ('EM ATRASO','PAGO'))
);

INSERT INTO DIM_STATUS
VALUES	('EM ATRASO'),
		('PAGO')

CREATE TABLE DIM_TURNO (
    ID_TURNO INT PRIMARY KEY IDENTITY(1,1),
    NOME VARCHAR(10) NOT NULL CHECK (NOME IN ('MANHA','TARDE','NOITE'))
);

INSERT INTO DIM_TURNO
VALUES('MANHA'), 
	  ('TARDE'),
	  ('NOITE')


-- FATOS

CREATE TABLE FATO_MATRICULA (
    ID_MATRICULA INT PRIMARY KEY IDENTITY(1,1),
	COD_MATRICULA INT NOT NULL,
	QUANTIDADE INT NOT NULL,
    CLIENTE_ID INT NOT NULL,
    UNIDADE_ID INT NOT NULL,
    MODALIDADE_ID INT NOT NULL,
    PLANO_ID INT NOT NULL,
	DATA_MATRICULA BIGINT NOT NULL,
	DATA_VENCIMENTO BIGINT NOT NULL,
    CONSTRAINT FK_FATO_MATRICULA_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES DIM_CLIENTE (ID_CLIENTE),
    CONSTRAINT FK_FATO_MATRICULA_UNIDADE FOREIGN KEY (UNIDADE_ID) REFERENCES DIM_UNIDADE (ID_UNIDADE),
    CONSTRAINT FK_FATO_MATRICULA_MODALIDADE FOREIGN KEY (MODALIDADE_ID) REFERENCES DIM_MODALIDADE (ID_MODALIDADE),
    CONSTRAINT FK_FATO_MATRICULA_PLANO FOREIGN KEY (PLANO_ID) REFERENCES DIM_PLANO (ID_PLANO),
	CONSTRAINT FK_FATO_MATRICULA_DATA_MATRICULA FOREIGN KEY (DATA_MATRICULA) REFERENCES DIM_TEMPO (ID_TEMPO),
	CONSTRAINT FK_FATO_MATRICULA_DATA_VECIMENTO FOREIGN KEY (DATA_VENCIMENTO) REFERENCES DIM_TEMPO (ID_TEMPO)
);

CREATE TABLE FATO_PAGAMENTO (
    ID_PAGAMENTO INT PRIMARY KEY IDENTITY(1,1),
	COD_PAGAMENTO INT NOT NULL,
    VALOR NUMERIC(10,2) NOT NULL,
	QUANTIDADE INT NOT NULL,
	STATUS_ID INT NULL,
    UNIDADE_ID INT NOT NULL,
	PLANO_ID INT NOT NULL,
	DATA_PREVISTA BIGINT NOT NULL,
	DATA_PAGAMENTO BIGINT NULL,
	CONSTRAINT FK_FATO_PAGAMENTO_STATUS FOREIGN KEY (STATUS_ID) REFERENCES DIM_STATUS (ID_STATUS),
    CONSTRAINT FK_FATO_PAGAMENTO_UNIDADE FOREIGN KEY (UNIDADE_ID) REFERENCES DIM_UNIDADE (ID_UNIDADE),
	CONSTRAINT FK_FATO_PAGAMENTO_PLANO FOREIGN KEY (PLANO_ID) REFERENCES DIM_PLANO (ID_PLANO),
	CONSTRAINT FK_FATO_PAGAMENTO_DATA_PREVISTA FOREIGN KEY (DATA_PREVISTA) REFERENCES DIM_TEMPO (ID_TEMPO),
	CONSTRAINT FK_FATO_PAGAMENTO_DATA_PAGAMENTO FOREIGN KEY (DATA_PAGAMENTO) REFERENCES DIM_TEMPO (ID_TEMPO)
);

CREATE TABLE FATO_FREQUENCIA (
    ID_FREQUENCIA INT PRIMARY KEY IDENTITY(1,1),
	COD_FREQUENCIA INT NOT NULL,
    ENTRADA TIME NOT NULL,
    SAIDA TIME NOT NULL,
	QUANTIDADE INT NOT NULL,
	TURNO_ID INT NOT NULL,
	DATA_FREQUENCIA BIGINT NOT NULL,
	CLIENTE_ID INT NOT NULL,
	CONSTRAINT FK_FATO_FREQUENCIA_TURNO FOREIGN KEY (TURNO_ID) REFERENCES DIM_TURNO (ID_TURNO),
	CONSTRAINT FK_FATO_FREQUENCIA_TEMPO FOREIGN KEY (DATA_FREQUENCIA) REFERENCES DIM_TEMPO (ID_TEMPO),
    CONSTRAINT FK_FATO_FREQUENCIA_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES DIM_CLIENTE (ID_CLIENTE)
);


