USE HubDados
;

SELECT TOP (10) * FROM RAE.Atendimento --IdAtendimento, IdLocalAtendimento, Centro Custo, Tipo Atendimento, Canal

SELECT TOP (10) * FROM RAE.Atendimento_AtividadeSala --IdAtendimento

SELECT TOP (10) * FROM RAE.Atendimento_ConteudoRelacionado --IdAtendimento

SELECT TOP (10) * FROM RAE.Atendimento_Ministrante --IdAtendimento, IdFuncionario

SELECT TOP (10) * FROM RAE.Atendimento_Produto --IdAtendimento


SELECT TOP (10) * FROM RAE.Acao --IdAcao, Centro Custo

SELECT TOP (10) * FROM RAE.Fornecedor --IdPessoa

SELECT TOP (10) * FROM RAE.Funcionario --IdFuncionario, IdPessoa


USE HubDados
;

SELECT TOP (100) A.IdAtendimento, A.Canal, A.CentroCusto, C.IdFuncionario, E.IdPessoa, E.IdFuncionario FROM RAE.Atendimento A
LEFT JOIN RAE.Atendimento_AtividadeSala B
ON B.IdAtendimento = A.IdCanal
LEFT JOIN RAE.Atendimento_Ministrante C
ON C.IdAtendimento = A.IdAtendimento
LEFT JOIN RAE.Acao D 
ON D.CentroCusto = A.CentroCusto COLLATE Latin1_General_CI_AS
LEFT JOIN RAE.Funcionario E
ON C.IdFuncionario = E.IdFuncionario
LEFT JOIN RAE.Fornecedor F
ON F.IdPessoa = E.IdPessoa

SELECT CENTROCUSTO, COUNT(CENTROCUSTO) AS CONTAGEM FROM RAE.Acao
GROUP BY CentroCusto