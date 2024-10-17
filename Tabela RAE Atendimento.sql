USE HubDados
;

SELECT TOP (10) * FROM RAE.Atendimento --IdAtendimento, Centro Custo, Tipo Atendimento, Canal

SELECT TOP (10) * FROM RAE.Atendimento_AtividadeSala --IdAtendimento

SELECT TOP (10) * FROM RAE.Atendimento_ConteudoRelacionado --IdAtendimento

SELECT TOP (10) * FROM RAE.Atendimento_Ministrante --IdAtendimento, IdFuncionario

SELECT TOP (10) * FROM RAE.Atendimento_Produto --IdAtendimento


SELECT TOP (10) * FROM RAE.Acao --IdAcao, Centro Custo

SELECT TOP (10) * FROM RAE.Fornecedor --IdPessoa

SELECT TOP (10) * FROM RAE.Funcionario --IdFuncionario, IdPessoa


USE HubDados
;

SELECT A.IdAtendimento, A.Canal, A.CentroCusto, A.SituacaoAtendimento, A.DataFechamento, A.TipoAtendimento, C.IdFuncionario, E.IdPessoa, E.IdFuncionario, A.Ano FROM RAE.Atendimento A
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
/*LEFT JOIN RAE.Atendimento_Produto G
ON G.IdAtendimento = A.IdAtendimento*/
WHERE A.Ano = '2024' AND a.SituacaoAtendimento = 'Concluído' AND A.TipoAtendimento IN ('Individual', 'Consultoria Individual', 'Coletivo', 'Coletivo executado em Kit', 'Agendamento executado em Kit')
ORDER BY A.IdAtendimento DESC



/*SELECT SituacaoAtendimento, COUNT(SituacaoAtendimento) AS CONTAGEM FROM RAE.Atendimento
WHERE ANO = '2024' AND SituacaoAtendimento = 'Concluído'
GROUP BY SituacaoAtendimento
order by CONTAGEM asc*/