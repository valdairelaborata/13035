

BEGIN TRAN TRANS001

	BEGIN TRY
		-- Gera uma divis�o por zero
		SELECT 1/0;

		EXEC SP_001()
		EXEC SP_002()

		COMMIT TRAN TRANS001
	END TRY
	BEGIN CATCH
		-- Executa uma rotina de recupera��o de erro
		ROLBACK TRAN TRANS001
		
	END CATCH;


