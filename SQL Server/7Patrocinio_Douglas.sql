USE HubDados
GO
 
DECLARE @DATAINICIO DATE = '2023-11-01'
DECLARE @DATAFIM DATE = '2025-02-06'
;
 
WITH TMOV AS (
    SELECT IDMOV, DATAEMISSAO, CODTMV, CODCFO
    FROM CorporeRM.TMOV WITH (NOLOCK)
    WHERE [DATAEMISSAO] BETWEEN @DATAINICIO AND @DATAFIM
    AND CODTMV IN ('2.1.07','2.1.13','2.1.14','2.2.14')
),
ITMMOV AS (
    SELECT IDMOV, IDPRD
    FROM CorporeRM.TITMMOV WITH (NOLOCK)
),
DESCR_MOV AS (
    SELECT CODTMV, DESCMOV
    FROM [FINANCA].[dbo].[descricao_CODTMV] WITH (NOLOCK)
),
TPRD AS (
    SELECT IDPRD, NOMEFANTASIA
    FROM CorporeRM.TPRD WITH (NOLOCK)
),
FLAN AS (
    SELECT IDMOV, IDLAN, NUMERODOCUMENTO, DATAVENCIMENTO, DATABAIXA, DESCSTATUSLCTO, CODDEPARTAMENTO, CODCXA, VALORORIGINAL, VALOROP6, VALORBAIXADO, CODCFO, Descricao_Tipo_Pagamento, HISTORICO, DESCSTATUSCNAB
    FROM CorporeRM.FLAN WITH (NOLOCK)
),
FLANBAIXA AS (
    SELECT IDLAN, CODEVENTOBAIXA
    FROM CorporeRM.FLANBAIXA WITH (NOLOCK)
),
FCFO AS (
    SELECT CODCFO, CGCCFO, NOMEFANTASIA
    FROM CorporeRM.FCFO WITH (NOLOCK)
)
 
SELECT DISTINCT
    E.NUMERODOCUMENTO,
    CONVERT(VARCHAR(10), A.DATAEMISSAO, 103) AS 'DATA EMISSAO',
    CONVERT(VARCHAR(10), E.DATAVENCIMENTO, 103) AS 'DATA VENCIMENTO',
    CONVERT(VARCHAR(10), E.DATABAIXA, 103) AS 'DATA BAIXA',
    E.DESCSTATUSLCTO AS 'STATUS LANCAMENTO',
    E.CODDEPARTAMENTO,
    E.CODCXA,
    FORMAT(E.VALORORIGINAL, 'C', 'PT-BR') AS 'VALOR ORIGINAL',
    FORMAT(E.VALOROP6, 'C', 'PT-BR') AS 'ABATIMENTO',
    FORMAT(E.VALORBAIXADO, 'C', 'PT-BR') AS 'VALOR BAIXADO',
    H.CGCCFO AS 'CNPJ_CLIENTE',
    H.NOMEFANTASIA AS 'NOME FANTASIA CLIENTE',
    G.NOMEFANTASIA,
    E.Descricao_Tipo_Pagamento AS 'TIPO PAGAMENTO',
    E.HISTORICO,
    F.CODEVENTOBAIXA,
    C.DESCMOV,
    D.NOMEFANTASIA AS 'ITEM DE VENDA',
    E.DESCSTATUSCNAB AS 'STATUS CNAB'
FROM TMOV A
LEFT JOIN ITMMOV B ON A.IDMOV = B.IDMOV
INNER JOIN DESCR_MOV C ON A.CODTMV = C.CODTMV
INNER JOIN TPRD D ON B.IDPRD = D.IDPRD
LEFT JOIN FLAN E ON A.IDMOV = E.IDMOV
LEFT JOIN FLANBAIXA F ON E.IDLAN = F.IDLAN
LEFT JOIN FCFO G ON G.CODCFO = E.CODCFO
LEFT JOIN FCFO H ON H.CODCFO = A.CODCFO
WHERE B.IDPRD IN ('70651')  -- FEIRA PATROCINIO
ORDER BY E.NUMERODOCUMENTO DESC;
 