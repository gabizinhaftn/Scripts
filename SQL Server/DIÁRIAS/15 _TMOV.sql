USE FINANCA; -- _TMOV

DECLARE @DATAHOJE DATETIME = GETDATE();

BEGIN TRANSACTION;

BEGIN TRY
    -- Removendo a tabela caso exista
    DROP TABLE IF EXISTS _TMOV;
    
    -- Criando e populando a nova tabela
    SELECT  
        IDMOV,
        CODLOCENTREGA,
        CODUSUARIO,
        CODCFO,
        NUMEROMOV,
        STATUS,
        DATAEMISSAO,
        VALORBRUTO,
        CODVEN1,
        HISTORICO,
        CAMPOLIVRE1,
        @DATAHOJE AS 'DATAATUALIZACAO'
    INTO dbo._TMOV 
    FROM HubDados.CorporeRM.TMOV
    WHERE CODTMV = '2.2.14' 
        AND YEAR(DATAEMISSAO) = '2025' 
        AND STATUS <> 'C';
    
    -- Commit da transação caso tudo esteja correto
    --COMMIT;
    
    -- Exibir os dados inseridos
    SELECT * FROM _TMOV;

END TRY
BEGIN CATCH
    -- Caso ocorra algum erro, a transação é revertida
    ROLLBACK;
    PRINT 'Erro na execução. A transação foi revertida.';
END CATCH;
