USE HUBDADOS;

SELECT  A.IDCNT, A.CODIGOCONTRATO, B.IDPRD, FORMAT(B.PRECOFATURAMENTO, 'C', 'PT-BR') AS 'PREÇO FATURAMENTO', FORMAT(A.VALORCONTRATO, 'C', 'PT-BR') AS 'VALOR CONTRATO' FROM CorporeRM.TCNT A
INNER JOIN CorporeRM.TITMCNT B
ON A.IDCNT = B.IDCNT
LEFT JOIN CorporeRM.TITMCNTADITIVO C
ON A.IDCNT = C.IDCNT
WHERE A.CODIGOCONTRATO LIKE '%ITV0.000350.25%'
ORDER BY IDPRD ASC

SELECT B.IDMOV, IDPRD, FORMAT(A.PRECOUNITARIO, 'C', 'PT-BR') AS 'VALOR', FORMAT(A.QUANTIDADE, '#,0', 'PT-BR') AS 'QUANTIDADE', FORMAT(SUM(A.PRECOUNITARIO * A.QUANTIDADE), 'C', 'PT-BR') AS 'VALOR TOTAL', B.DATAEMISSAO FROM CorporeRM.TITMMOV A
INNER JOIN CorporeRM.TMOV B
ON A.IDMOV = B.IDMOV
WHERE B.IDMOV = '5202130'
GROUP BY GROUPING SETS((B.IDMOV, IDPRD, A.PRECOUNITARIO, A.QUANTIDADE, B.DATAEMISSAO), (B.IDMOV))
ORDER BY CASE WHEN IDPRD IS NULL THEN 1 ELSE 0 END, IDPRD ASC

SELECT DISTINCT A.IDMOV, A.NUMEROMOV, B.NOMEFANTASIA, B.NOME FROM CorporeRM.TMOV A
INNER JOIN CorporeRM.FCFO B
ON A.CODCFO = B.CODCFO COLLATE Latin1_General_CI_AI
WHERE A.IDMOV = '5187202'
ORDER BY A.IDMOV ASC

/*SELECT IDCNT, FORMAT(VALOR, 'C', 'PT-BR') AS 'VALOR' FROM CorporeRM.TITMCNTADITIVO
WHERE IDCNT = '90064123'*/