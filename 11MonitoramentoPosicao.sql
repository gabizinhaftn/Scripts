USE FINANCA
;

UPDATE dbo.MONITORAMENTO
SET Posição = 'Pedido de fornecimento – encerrado'
WHERE [Cod.Contrato] = 'SPA4.000074.24'
;

UPDATE dbo.Posicao
SET Posição = 'Pedido de fornecimento – encerrado'
WHERE [Cod.Contrato] = 'SPA4.000074.24'

/*INSERT INTO Posicao
VALUES ('SPA4.000074.24', '', 'Pedido de fornecimento – encerrado')*/