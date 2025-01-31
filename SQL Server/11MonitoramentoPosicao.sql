USE FINANCA
;

UPDATE dbo.MONITORAMENTO
SET Posição = 'Pedido de fornecimento – encerrado'
WHERE [Cod.Contrato] = 'SPB1.000306.24'
;

UPDATE dbo.Posicao
SET Posição = 'Pedido de fornecimento – encerrado'
WHERE [Cod.Contrato] = 'SPB1.000306.24'


/*INSERT INTO Posicao
VALUES ('SPB1.000306.24', '', 'Pedido de fornecimento – encerrado')*/