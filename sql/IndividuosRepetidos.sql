SELECT COUNT(*) FROM FOREX.INDIVIDUO_BORRADO WHERE CAUSA_BORRADO='DUPLICADO';
SELECT * FROM FOREX.INDIVIDUO_BORRADO WHERE CAUSA_BORRADO='DUPLICADO';
SELECT COUNT(*) FROM FOREX.INDIVIDUO_BORRADO WHERE CAUSA_BORRADO='DUPLICADO_APERTURA';
SELECT * FROM FOREX.INDIVIDUO_BORRADO WHERE CAUSA_BORRADO='DUPLICADO_APERTURA';

SELECT ID_INDIVIDUO_BASE, COUNT(*) FROM FOREX.INDIVIDUO_BORRADO 
WHERE CAUSA_BORRADO='DUPLICADO' GROUP BY ID_INDIVIDUO_BASE ORDER BY COUNT(*) DESC;

SELECT * FROM INDIVIDUOS_REPETIDOS
WHERE ID_INDIVIDUO1='1341766313059.988';

  SELECT IND.* FROM INDIVIDUO IND 
  WHERE IND.ID IN (SELECT OPERB.ID_INDIVIDUO FROM OPERACION_BASE OPERB)
  AND IND.ID = '1341766313059.988'
  ORDER BY ID DESC;

