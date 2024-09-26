USE FINANCA
;

WITH TOTAL AS (
SELECT * FROM DBO.FatoFechamento
)
, SELECAO_CONTA_SERVICO AS (
SELECT TIPO, CONTA_FECHAMENTO, UNIFICAVALOR,[DATA] FROM TOTAL
WHERE YEAR([DATA]) = '2024'
)
,TABELA_DINAMICA_SELECAO AS (
SELECT CONTA_FECHAMENTO
	, DATA
	, TIPO
	, CASE WHEN MONTH([DATA]) = '1' THEN [UNIFICAVALOR] ELSE NULL END AS 'JANEIRO'
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
	FROM SELECAO_CONTA_SERVICO
)
, TABELA_DINAMICA AS (
SELECT CONTA_FECHAMENTO
	, TIPO
	,SUM([JANEIRO]) AS 'SOMAJANEIRO'
	,SUM(FEVEREIRO) AS 'SOMAFEVEREIRO'
	,SUM(MARÇO) AS 'SOMAMARÇO'
	,SUM(ABRIL) AS 'SOMAABRIL'
	,SUM(MAIO) AS 'SOMAMAIO'
	,SUM(JUNHO) AS 'SOMAJUNHO'
	,SUM(JULHO) AS 'SOMAJULHO'
	,SUM(AGOSTO) AS 'SOMAAGOSTO'
	,SUM(SETEMBRO) AS 'SOMASETEMBRO'
	,SUM(OUTUBRO) AS 'SOMAOUTUBRO'
	,SUM(NOVEMBRO) AS 'SOMANOVEMBRO'
	,SUM(DEZEMBRO) AS 'SOMADEZEMBRO'
	,Case When TIPO Like 'Receita' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS 'ReceitaDespesa'
FROM TABELA_DINAMICA_SELECAO
GROUP BY TIPO, CONTA_FECHAMENTO
)

SELECT CONTA_FECHAMENTO, ReceitaDespesa, SOMAJANEIRO, SOMAFEVEREIRO, SOMAMARÇO, SOMAABRIL, SOMAMAIO, SOMAJUNHO, SOMAJULHO, SOMAAGOSTO, SOMASETEMBRO, SOMAOUTUBRO, SOMANOVEMBRO, SOMADEZEMBRO
FROM TABELA_DINAMICA
WHERE ReceitaDespesa = 0