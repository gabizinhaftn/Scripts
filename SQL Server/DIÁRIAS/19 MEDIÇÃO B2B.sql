USE HUBDADOS;

SELECT * FROM CorporeRM.TMOV WHERE CODTMV = '2.1.21' AND YEAR(DATAEMISSAO) = 2024 AND YEAR(DATAEMISSAO) = 2025 AND CAMPOLIVRE1 LIKE 'SJC0.001251.24'
SELECT * FROM CorporeRM.TMOVRATCCU WHERE IDMOV = '5115596'
SELECT DISTINCT RIGHT(CODCCUSTO,3) AS CODUNIDADE,NOME FROM CorporeRM.GCCUSTO WHERE LEN(CODCCUSTO) > 15 AND NOME LIKE 'SP -%'
ORDER BY CODUNIDADE