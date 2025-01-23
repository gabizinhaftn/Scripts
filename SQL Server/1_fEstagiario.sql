USE FINANCA
;

DECLARE @HOJE DATETIME = GETDATE()
TRUNCATE TABLE _fEstagiario

INSERT INTO _fEstagiario (
    RE,
    NOME_FUNCIONARIO,
    SEXO,
	DATA_DE_NASCIMENTO,
    ADMISSAO,
    CODSECAO,
    ER,
	DATAATUALIZACAO)
	SELECT PFUNC.CHAPA, PFUNC.NOME, PPESSOA.SEXO, PPESSOA.DTNASCIMENTO, PFUNC.DATAADMISSAO, PFUNC.CODSECAO, PSECAO.DESCRICAO, @HOJE
	FROM HUBDADOS.CorporeRM.PFUNC PFUNC
	INNER JOIN HubDados.CorporeRM.PPESSOA PPESSOA
	ON PFUNC.CODPESSOA = PPESSOA.CODIGO
	INNER JOIN HubDados.CorporeRM.PSECAO PSECAO
	ON PFUNC.CODSECAO = PSECAO.CODIGO
	WHERE PFUNC.CODSITUACAO IN ('G', 'A') AND PFUNC.CODTIPO = 'T'
	ORDER BY NOME ASC

SELECT 
	RE 
	, NOME_FUNCIONARIO AS 'NOME'
	, SEXO
	,DATA_DE_NASCIMENTO AS 'DATA DE NASCIMENTO'
	, ADMISSAO AS 'ADMISSÃO'
	, CODSECAO AS 'CÓDIGO SEÇÃO'
	, ER AS 'ER/LUGAR'
	, DATAATUALIZACAO AS 'DATA ATUALIZAÇÃO'
	 FROM _fEstagiario
	 ORDER BY NOME ASC