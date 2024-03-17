CREATE OR ALTER PROCEDURE SP_OLTP_PAGAMENTO(@DATA_CARGA DATETIME, @DATA_INICIAL DATETIME, @DATA_FINAL DATETIME)
AS
BEGIN
	DELETE FROM TB_AUX_PAGAMENTO
	WHERE @DATA_CARGA = DATA_CARGA

	INSERT INTO TB_AUX_PAGAMENTO
	SELECT @DATA_CARGA, PA.VALOR_PAGO, PA.ID, PA.DT_PAGAMENTO, M.UNIDADE_ID, M.PLANO_ID, PA.DT_PREVISTA
	FROM TB_PAGAMENTO PA 
	INNER JOIN TB_MATRICULA M
	ON(PA.MATRICULA_ID = M.ID)
	WHERE @DATA_INICIAL <= PA.DT_PREVISTA AND @DATA_FINAL >= PA.DT_PREVISTA
END

-- TESTE

EXEC SP_OLTP_PAGAMENTO '20240316', '20230110', '20240110'

SELECT * FROM TB_PAGAMENTO
SELECT * FROM TB_AUX_PAGAMENTO