USE FINANCA; --LEFT JOIN TMOV + TCNT


SELECT IDCNT, IDMOV, CODLOCENTREGA, A.CODUSUARIO, A.CODCFO, NUMEROMOV, STATUS, DATAEMISSAO,  DT_CONTRATO, DATACONTRATO, VALORBRUTO, CODVEN1, Historico, CAMPOLIVRE1 FROM _TMOV A
LEFT JOIN _TCNT B
ON CONCAT(A.CODCFO, A.VALORBRUTO) = CONCAT(B.CODCFO, B.VALORCONTRATO) COLLATE SQL_Latin1_General_CP1_CI_AI
WHERE IDCNT IS NULL