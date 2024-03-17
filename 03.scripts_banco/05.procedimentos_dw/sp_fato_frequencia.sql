CREATE OR ALTER PROCEDURE SP_FATO_FREQUENCIA(@DATA_CARGA DATETIME)
AS
BEGIN
	DECLARE @DT_FREQUENCIA DATE, @ENTRADA TIME, @SAIDA TIME, @COD_FREQUENCIA INT, @COD_CLIENTE INT
	DECLARE @ID_TEMPO BIGINT, @ID_CLIENTE INT, @ID_TURNO INT

	DECLARE C_FREQUENCIA CURSOR FOR
	SELECT ENTRADA, SAIDA, COD_FREQUENCIA, DATA_FREQUENCIA, COD_CLIENTE
	FROM TB_AUX_FREQUENCIA
	WHERE DATA_CARGA = @DATA_CARGA

	OPEN C_FREQUENCIA
	FETCH C_FREQUENCIA INTO @ENTRADA, @SAIDA, @COD_FREQUENCIA, @DT_FREQUENCIA, @COD_CLIENTE

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SELECT @ID_TEMPO = ID_TEMPO
		FROM DIM_TEMPO
		WHERE @DT_FREQUENCIA = DATA

		SELECT @ID_CLIENTE = ID_CLIENTE
		FROM DIM_CLIENTE
		WHERE @COD_CLIENTE = COD_CLIENTE

		IF @ENTRADA <= '12:00:00'
		BEGIN
			SELECT @ID_TURNO = ID_TURNO
			FROM DIM_TURNO
			WHERE NOME = 'MANHA'
		END
		ELSE IF @ENTRADA > '12:00:00' AND @ENTRADA <= '18:00:00'
		BEGIN
			SELECT @ID_TURNO = ID_TURNO
			FROM DIM_TURNO
			WHERE NOME = 'TARDE'
		END
		ELSE
		BEGIN 
			SELECT @ID_TURNO = ID_TURNO
			FROM DIM_TURNO
			WHERE NOME = 'NOITE'
		END

		IF EXISTS (SELECT ID_FREQUENCIA FROM FATO_FREQUENCIA WHERE COD_FREQUENCIA = @COD_FREQUENCIA)
		BEGIN
			UPDATE FATO_FREQUENCIA
			SET ENTRADA = @ENTRADA,
				SAIDA = @SAIDA,
				TURNO_ID = @ID_TURNO,
				DATA_FREQUENCIA = @ID_TEMPO,
				CLIENTE_ID = @ID_CLIENTE
			WHERE @COD_FREQUENCIA = COD_FREQUENCIA
		END
		ELSE
		BEGIN
			INSERT INTO FATO_FREQUENCIA
			VALUES(@COD_FREQUENCIA, @ENTRADA, @SAIDA, 1, @ID_TURNO, @ID_TEMPO, @ID_CLIENTE)
		END

		FETCH C_FREQUENCIA INTO @ENTRADA, @SAIDA, @COD_FREQUENCIA, @DT_FREQUENCIA, @COD_CLIENTE
	END
	
	CLOSE C_FREQUENCIA
	DEALLOCATE C_FREQUENCIA
END

EXEC SP_FATO_FREQUENCIA '20240316'

SELECT * FROM FATO_FREQUENCIA
SELECT * FROM TB_AUX_FREQUENCIA