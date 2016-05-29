SELECT * FROM INDIVIDUO ORDER BY ID DESC;
SELECT COUNT(*) FROM INDIVIDUO;
SELECT COUNT(*) FROM INDIVIDUO_BORRADO;

SELECT * FROM FOREX.INDIVIDUO WHERE ID IN ('1341573069043.12599');

SELECT * FROM FOREX.INDIVIDUO_BORRADO WHERE ID='1341573069043.12599';

SELECT COUNT(*) FROM FOREX.INDIVIDUO_BORRADO WHERE CAUSA_BORRADO='DUPLICADO_APERTURA';
SELECT * FROM FOREX.INDIVIDUO_BORRADO WHERE CAUSA_BORRADO='OPERACIONES_MINIMAS';

SELECT II.*
FROM FOREX.INDICADOR_INDIVIDUO II
WHERE II.ID_INDIVIDUO IN ('1341687718670.3603')
ORDER BY TIPO DESC, INTERVALO_INFERIOR, INTERVALO_SUPERIOR;

SELECT II.*--, II.INTERVALO_INFERIOR*100, II.INTERVALO_SUPERIOR*100 
FROM FOREX.INDICADOR_INDIVIDUO II WHERE II.ID_INDIVIDUO IN ('1338955830567.15925')
--AND TIPO='OPEN'
ORDER BY II.TIPO DESC, ID_INDICADOR ASC;

SELECT COUNT(*) FROM INDIVIDUO_BORRADO;
SELECT * FROM INDIVIDUO_BORRADO ORDER BY ID DESC;
SELECT * FROM INDICADOR_INDIVIDUO_BORRADO;

SELECT * FROM FOREX.INDIVIDUO WHERE CREATION_DATE IS NOT NULL ORDER BY ID DESC;

SELECT * FROM FOREX.INDICADOR;

SELECT * FROM FOREX.INDICADOR WHERE ID='ICHIMOKU_SIGNAL' AND TIPO='CLOSE';

SELECT * FROM FOREX.INDICADOR_INDIVIDUO
ORDER BY ID_INDIVIDUO,TIPO ASC;

SELECT * FROM FOREX.INDICADOR_INDIVIDUO
WHERE ID_INDICADOR='ICHIMOKU_SIGNAL' AND TIPO='CLOSE' AND ID_INDIVIDUO='1327755218940.22316'
;

SELECT COUNT(*) FROM INDICADOR_INDIVIDUO;
