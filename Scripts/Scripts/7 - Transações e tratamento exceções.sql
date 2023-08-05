

BEGIN TRAN TRANS001

	BEGIN TRY
		-- Gera uma divisão por zero
		SELECT 1/0;

		EXEC SP_001()
		EXEC SP_002()

		COMMIT TRAN TRANS001
	END TRY
	BEGIN CATCH
		-- Executa uma rotina de recuperação de erro
		ROLBACK TRAN TRANS001
		
	END CATCH;


