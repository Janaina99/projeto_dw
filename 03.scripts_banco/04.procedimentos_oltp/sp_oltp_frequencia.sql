CREATE OR ALTER PROCEDURE SP_OLTP_FREQUENCIA(@DATA_CARGA DATETIME, @DATA_INICIAL DATETIME, @DATA_FINAL DATETIME)
AS
BEGIN
	DELETE FROM TB_AUX_FREQUENCIA
	WHERE @DATA_CARGA = DATA_CARGA

	INSERT INTO TB_AUX_FREQUENCIA
	SELECT @DATA_CARGA, ENTRADA, SAIDA, ID, DT_FREQUENCIA, CLIENTE_ID
	FROM TB_FREQUENCIA 
	WHERE @DATA_INICIAL <= DT_FREQUENCIA AND @DATA_FINAL >= DT_FREQUENCIA
END

-- TESTE

EXEC SP_OLTP_FREQUENCIA'20240316', '20230110', '20240110'

SELECT * FROM TB_FREQUENCIA
SELECT * FROM TB_AUX_FREQUENCIA