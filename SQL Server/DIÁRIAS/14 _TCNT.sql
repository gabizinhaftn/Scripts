USE FINANCA; -- _TCNT

DECLARE @DATAHOJE DATETIME = GETDATE();

BEGIN TRANSACTION;

BEGIN TRY
    -- Removendo a tabela caso exista
    DROP TABLE IF EXISTS _TCNT;
    
    -- Criando e populando a nova tabela
    SELECT  
        A.IDCNT,
        CODIGOCONTRATO,
        CODCFO,
        DATACONTRATO,
        DATAINICIO,
        DATAFIM,
        CODSTACNT,
        VALORCONTRATO,
        CODVEN,
        NOME,
        CODDEPARTAMENTO,
        DT_CONTRATO,
        @DATAHOJE AS 'DATAATUALIZACAO'
    INTO dbo._TCNT 
    FROM HubDados.CorporeRM.TCNT A
    INNER JOIN HUBDADOS.CorporeRM.TCNTCOMPL B
    ON A.IDCNT = B.IDCNT
    WHERE YEAR(DATACONTRATO) IN ('2024', '2025');
    
    -- Commit da transação caso tudo esteja correto
    -- COMMIT;
    
    -- Exibir os dados inseridos
    SELECT * FROM _TCNT;

END TRY
BEGIN CATCH
    -- Caso ocorra algum erro, a transação é revertida
    ROLLBACK;
    PRINT 'Erro na execução. A transação foi revertida.';
END CATCH;