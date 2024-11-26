USE FINANCA
;

DECLARE @datamaxima AS DATETIME
SELECT @datamaxima = MAX([DATA]) FROM _fOrcamentoAgregado

SELECT * FROM _fOrcamentoAgregado
WHERE [DATA] = @datamaxima