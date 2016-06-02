SELECT --COUNT(*) C
  IND.ID, (OPER_POS.CANTIDAD+OPER_NEG.CANTIDAD) CANTIDAD,
  ABS(OPER_POS.SUMA/OPER_NEG.SUMA) FACTOR_PIPS,  
  (OPER_POS.CANTIDAD/OPER_NEG.CANTIDAD) FACTOR_CANTIDAD
FROM INDIVIDUO IND
  INNER JOIN 
    (SELECT OPER1.ID_INDIVIDUO FROM OPERACION OPER1 
    WHERE OPER1.FECHA_APERTURA<TO_DATE('2012/08/15', 'YYYY/MM/DD')
    AND OPER1.FECHA_APERTURA>ADD_MONTHS(TO_DATE('2012/08/15', 'YYYY/MM/DD'),-3)
    HAVING COUNT(*)>20
    GROUP BY OPER1.ID_INDIVIDUO) CONTADOR_OPER 
      ON CONTADOR_OPER.ID_INDIVIDUO=IND.ID
  LEFT JOIN
    (SELECT P.ID_INDIVIDUO, SUM(P.PIPS) SUMA, COUNT(*) CANTIDAD FROM OPERACION P WHERE P.PIPS>0 GROUP BY P.ID_INDIVIDUO) OPER_POS 
      ON OPER_POS.ID_INDIVIDUO=IND.ID
  LEFT JOIN 
    (SELECT P.ID_INDIVIDUO, SUM(P.PIPS) SUMA, COUNT(*) CANTIDAD FROM OPERACION P WHERE P.PIPS<0 GROUP BY P.ID_INDIVIDUO) OPER_NEG 
      ON OPER_NEG.ID_INDIVIDUO=IND.ID
--WHERE ABS(SUM_POS/SUM_NEG)>2
--ORDER BY ABS(OPER_POS.SUMA/OPER_NEG.SUMA) DESC
;

SELECT IND.ID, (POS.CANTIDAD+NEG.CANTIDAD) CANTIDAD, 
  ABS(POS.SUMA/NEG.SUMA) FACTOR_PIPS, (POS.CANTIDAD/NEG.CANTIDAD) FACTOR_CANTIDAD
FROM INDIVIDUO IND
INNER JOIN (
SELECT ID_INDIVIDUO, COUNT(*) CANTIDAD, SUM(PIPS) SUMA FROM OPERACION OPER1 
    WHERE FECHA_APERTURA<TO_DATE('2012/08/15', 'YYYY/MM/DD')
    AND FECHA_APERTURA>ADD_MONTHS(TO_DATE('2012/08/15', 'YYYY/MM/DD'),-3)
    AND PIPS>0
    --HAVING COUNT(*)>20
    GROUP BY ID_INDIVIDUO    
) POS ON IND.ID=POS.ID_INDIVIDUO
INNER JOIN (
SELECT ID_INDIVIDUO, COUNT(*) CANTIDAD, SUM(PIPS) SUMA FROM OPERACION OPER1 
    WHERE FECHA_APERTURA<TO_DATE('2012/08/15', 'YYYY/MM/DD')
    AND FECHA_APERTURA>ADD_MONTHS(TO_DATE('2012/08/15', 'YYYY/MM/DD'),-3)
    AND PIPS<0
    --HAVING COUNT(*)>20
    GROUP BY ID_INDIVIDUO    
) NEG ON IND.ID=NEG.ID_INDIVIDUO
--WHERE ABS(POS.SUMA/NEG.SUMA)>2
    ;
