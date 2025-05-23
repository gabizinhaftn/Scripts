USE HUBDADOS;
 
DROP TABLE IF EXISTS #TMOV, #TCNT
 
 
SELECT IDMOV, CODLOCENTREGA, CODUSUARIO, CODCFO, NUMEROMOV, STATUS, DATAEMISSAO, VALORBRUTO, CODVEN1, Historico, CAMPOLIVRE1 INTO #TMOV FROM CorporeRM.TMOV 
WHERE CODTMV = '2.2.14' AND YEAR(DATAEMISSAO) = '2025' AND STATUS <> 'C'
 
SELECT A.IDCNT, CODIGOCONTRATO, CODCFO, DATACONTRATO, DATAINICIO, DATAFIM, CODSTACNT, A.VALORCONTRATO, CODVEN, NOME, CODDEPARTAMENTO, B.DT_CONTRATO INTO #TCNT FROM CorporeRM.TCNT A
INNER JOIN CorporeRM.TCNTCOMPL B
ON A.IDCNT = B.IDCNT
WHERE YEAR(DATACONTRATO) IN ('2024', '2025')
 
SELECT IDCNT, IDMOV, CODLOCENTREGA, A.CODUSUARIO, A.CODCFO, NUMEROMOV, STATUS, DATAEMISSAO,  DT_CONTRATO, DATACONTRATO, VALORBRUTO, CODVEN1, Historico, CAMPOLIVRE1 FROM #TMOV A
LEFT JOIN #TCNT B
ON CONCAT(A.CODCFO, A.VALORBRUTO) = CONCAT(B.CODCFO, B.VALORCONTRATO) COLLATE SQL_Latin1_General_CP1_CI_AI