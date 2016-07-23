SELECT OPER.ID_INDIVIDUO, COUNT(*), SUM(OPER.PIPS) 
FROM (SELECT * FROM FOREX.OPERACION OP 
        INNER JOIN INDIVIDUO IND 
          ON IND.ID=OP.ID_INDIVIDUO
      WHERE IND.LOTE>0 AND IND.INITIAL_BALANCE>0 AND TO_CHAR(OP.FECHA_APERTURA, 'YYYY')='2009'
      ) OPER
GROUP BY OPER.ID_INDIVIDUO 
--HAVING SUM(PIPS) > 0
ORDER BY SUM(OPER.PIPS) DESC
; 

SELECT OPER.ID_INDIVIDUO, TO_CHAR(OPER.FECHA_APERTURA, 'YYYY'), COUNT(*), SUM(OPER.PIPS)
 FROM FOREX.OPERACION OPER
WHERE OPER.ID_INDIVIDUO IN (
'1340921104809.105437'
)
GROUP BY OPER.ID_INDIVIDUO, TO_CHAR(OPER.FECHA_APERTURA, 'YYYY')
ORDER BY TO_CHAR(OPER.FECHA_APERTURA, 'YYYY') ASC
;
