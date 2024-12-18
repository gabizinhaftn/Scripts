USE FINANCA;

DECLARE @CSO AS FLOAT =  59038279.50 
DECLARE @CSN AS FLOAT =  2257329.73 
DECLARE @CONVENIOS AS FLOAT =  12111.00
DECLARE @CONTRATO AS FLOAT =  99280.00 


SELECT CONTA_FECHAMENTO, [DATA], TIPO,  
CASE WHEN MONTH([DATA]) = '1' THEN [UNIFICAVALOR] ELSE NULL END AS 'JANEIRO'
	, CASE WHEN MONTH([DATA]) = '2' THEN [UNIFICAVALOR] ELSE NULL END AS 'FEVEREIRO'
	, CASE WHEN MONTH([DATA]) = '3' THEN [UNIFICAVALOR] ELSE NULL END AS 'MARÇO'
	, CASE WHEN MONTH([DATA]) = '4' THEN [UNIFICAVALOR] ELSE NULL END AS 'ABRIL'
	, CASE WHEN MONTH([DATA]) = '5' THEN [UNIFICAVALOR] ELSE NULL END AS 'MAIO'
	, CASE WHEN MONTH([DATA]) = '6' THEN [UNIFICAVALOR] ELSE NULL END AS 'JUNHO'
	, CASE WHEN MONTH([DATA]) = '7' THEN [UNIFICAVALOR] ELSE NULL END AS 'JULHO'
	, CASE WHEN MONTH([DATA]) = '8' THEN [UNIFICAVALOR] ELSE NULL END AS 'AGOSTO'
	, CASE WHEN MONTH([DATA]) = '9' THEN [UNIFICAVALOR] ELSE NULL END AS 'SETEMBRO'
	, CASE WHEN MONTH([DATA]) = '10' THEN [UNIFICAVALOR] ELSE NULL END AS 'OUTUBRO'
	, CASE WHEN MONTH([DATA]) = '11' THEN [UNIFICAVALOR] ELSE NULL END AS 'NOVEMBRO'
	, CASE WHEN MONTH([DATA]) = '12' THEN [UNIFICAVALOR] ELSE NULL END AS 'DEZEMBRO'
	INTO #TOTAL 
	FROM DBO.FatoFechamento
	WHERE YEAR([DATA]) = '2024'



SELECT CASE WHEN GROUPING(CONTA_FECHAMENTO) = 1 THEN 'TOTAL' ELSE CONTA_FECHAMENTO END CONTA_FECHAMENTO
	, TIPO
	,FORMAT (SUM([JANEIRO]), 'C', 'PT-BR') AS 'SOMAJANEIRO' 
	,FORMAT (SUM(FEVEREIRO), 'C', 'PT-BR') AS 'SOMAFEVEREIRO'
	,FORMAT (SUM(MARÇO), 'C', 'PT-BR') AS 'SOMAMARÇO'
	,FORMAT (SUM(ABRIL), 'C', 'PT-BR') AS 'SOMAABRIL'
	,FORMAT (SUM(MAIO), 'C', 'PT-BR') AS 'SOMAMAIO'
	,FORMAT (SUM(JUNHO), 'C', 'PT-BR') AS 'SOMAJUNHO'
	,FORMAT (SUM(JULHO), 'C', 'PT-BR') AS 'SOMAJULHO'
	,FORMAT (SUM(AGOSTO), 'C', 'PT-BR') AS 'SOMAAGOSTO'
	,FORMAT (SUM(SETEMBRO), 'C', 'PT-BR') AS 'SOMASETEMBRO'
	,FORMAT (SUM(OUTUBRO), 'C', 'PT-BR') AS 'SOMAOUTUBRO'
	,FORMAT (SUM(NOVEMBRO), 'C', 'PT-BR') AS 'SOMANOVEMBRO'
	,FORMAT (SUM(DEZEMBRO), 'C', 'PT-BR') AS 'SOMADEZEMBRO'
	,Case When TIPO Like 'Receita' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS 'ReceitaDespesa'
INTO #TBDIN
FROM #TOTAL
GROUP BY ROLLUP (CONTA_FECHAMENTO), TIPO 


SELECT CONTA_FECHAMENTO, ReceitaDespesa, SOMAJANEIRO, SOMAFEVEREIRO, SOMAMARÇO, SOMAABRIL, SOMAMAIO, SOMAJUNHO, SOMAJULHO, SOMAAGOSTO, SOMASETEMBRO, SOMAOUTUBRO, SOMANOVEMBRO, SOMADEZEMBRO
FROM #TBDIN
WHERE ReceitaDespesa = 0


SELECT CONTA_FECHAMENTO, ReceitaDespesa, SOMAJANEIRO, SOMAFEVEREIRO, SOMAMARÇO, SOMAABRIL, SOMAMAIO, SOMAJUNHO, SOMAJULHO, SOMAAGOSTO, SOMASETEMBRO, SOMAOUTUBRO, SOMANOVEMBRO, SOMADEZEMBRO
FROM #TBDIN
WHERE ReceitaDespesa = 1









DROP TABLE #TOTAL, #TBDIN

