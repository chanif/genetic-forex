SELECT II.ID_INDICADOR, ROUND(AVG(II.INTERVALO_INFERIOR), 5) AVG_INF, ROUND(AVG(II.INTERVALO_SUPERIOR), 5) AVG_SUP
 --ROUND(AVG(IND.TAKE_PROFIT),0) TP, ROUND(AVG(IND.STOP_LOSS),0) SL, COUNT(*)
--COUNT(*) 
FROM INDICADOR_INDIVIDUO II 
WHERE 
 II.ID_INDICADOR='MACD' AND II.TIPO='OPEN' AND II.INTERVALO_INFERIOR IS NOT NULL AND II.INTERVALO_SUPERIOR IS NOT NULL
 AND II.ID_INDIVIDUO IN ('1329927210938.4697', '1329927210938.8085')
  --AND II.INTERVALO_INFERIOR >= -0.007
  --AND II.INTERVALO_SUPERIOR <= 0.00288 
  --AND OPER.FECHA_APERTURA BETWEEN TO_DATE('20140101', 'YYYYMMDD') AND TO_DATE('20150101', 'YYYYMMDD')
--ORDER BY OPER.FECHA_APERTURA ASC
  --AND ROWNUM<3
  AND II.ID_INDIVIDUO IN (
    SELECT OPER.ID_INDIVIDUO
    FROM OPERACION OPER
    WHERE OPER.PIPS >= 200
    AND (OPER.MAX_PIPS_RETROCESO >= 0)
  )
GROUP BY II.ID_INDICADOR
;

SELECT MIN(DH.AVERAGE-OPER.OPEN_PRICE) INTERVALO_INFERIOR, MAX(DH.AVERAGE-OPER.OPEN_PRICE) INTERVALO_SUPERIOR, 
  ROUND(AVG(DH.AVERAGE-OPER.OPEN_PRICE), 5) PROMEDIO,
  ROUND(AVG(OPER.TAKE_PROFIT)) TP, ROUND(AVG(OPER.STOP_LOSS)) SL,
  COUNT(*) REGISTROS
FROM DATOHISTORICO DH
INNER JOIN OPERACION_POSITIVAS OPER ON DH.FECHA=OPER.FECHA_APERTURA
WHERE DH.AVERAGE IS NOT NULL 
  AND OPER.PIPS >= 600
  AND (MAX_PIPS_RETROCESO >= -1000)
  AND OPER.FECHA_APERTURA BETWEEN TO_DATE('20140601', 'YYYYMMDD') AND TO_DATE('20140701', 'YYYYMMDD')
  --AND OPER.ID_INDIVIDUO IN ('1329927210938.4697', '1329927210938.8085')
--ORDER BY FECHA_APERTURA
;


SELECT MIN(DH.MACD_VALUE-DH.MACD_SIGNAL) INTERVALO_INFERIOR, MAX(DH.MACD_VALUE-DH.MACD_SIGNAL) INTERVALO_SUPERIOR, 
  ROUND(AVG(DH.MACD_VALUE-DH.MACD_SIGNAL), 5) PROMEDIO,
  ROUND(AVG(OPER.TAKE_PROFIT)) TP, ROUND(AVG(OPER.STOP_LOSS)) SL,
  COUNT(*) REGISTROS
FROM DATOHISTORICO DH
INNER JOIN OPERACION_POSITIVAS OPER ON DH.FECHA=OPER.FECHA_APERTURA
WHERE DH.MACD_VALUE IS NOT NULL AND DH.MACD_SIGNAL IS NOT NULL  
  AND OPER.PIPS >= 200
  AND (MAX_PIPS_RETROCESO >= -1000)
  AND OPER.FECHA_APERTURA > TO_DATE('20140101', 'YYYYMMDD') --AND TO_DATE('20150101', 'YYYYMMDD')
  --AND OPER.ID_INDIVIDUO IN ('1329927210938.4697', '1329927210938.8085')
--ORDER BY FECHA_APERTURA
;


SELECT OPER.*
FROM OPERACION OPER
WHERE OPER.PIPS >= 300
  AND (MAX_PIPS_RETROCESO >= -100)
--ORDER BY FECHA_APERTURA
;

