SELECT --OPER.ID_INDIVIDUO,
  OPER.FECHA_CIERRE,
  ROUND(REGR_COUNT((OPER.PIPS), SYSDATE-OPER.FECHA_CIERRE)
    OVER (ORDER BY OPER.FECHA_CIERRE ASC),5) R_C,
  ROUND(REGR_R2((OPER.PIPS), SYSDATE-OPER.FECHA_CIERRE)
    OVER (ORDER BY OPER.FECHA_CIERRE ASC),5) R2
--  ROUND(REGR_SLOPE((OPER.PIPS), SYSDATE-OPER.FECHA_CIERRE),5) SLOPE,
--  ROUND(REGR_INTERCEPT((OPER.PIPS), SYSDATE-OPER.FECHA_CIERRE),5) INTERC
FROM OPERACION OPER
WHERE OPER.ID_INDIVIDUO='1463541693654.351' 
--GROUP BY OPER.ID_INDIVIDUO, OPER.FECHA_CIERRE
;

SELECT --OPER.ID_INDIVIDUO,
  ROUND(REGR_COUNT((OPER.PIPS), OPER.FECHA_CIERRE-SYSDATE),5) R_C,
  ROUND(REGR_R2((OPER.PIPS), OPER.FECHA_CIERRE-SYSDATE),5) R2,
  ROUND(REGR_SLOPE((OPER.PIPS), OPER.FECHA_CIERRE-SYSDATE),5) SLOPE,
  ROUND(REGR_INTERCEPT((OPER.PIPS), OPER.FECHA_CIERRE-SYSDATE),5) INTERC
FROM OPERACION OPER
WHERE OPER.ID_INDIVIDUO='1463541693654.351' 
--GROUP BY OPER.ID_INDIVIDUO, OPER.FECHA_CIERRE
;

SELECT OPER.ID_INDIVIDUO,
      ROUND(REGR_COUNT(SUM(OPER.PIPS), SYSDATE-TO_DATE('20161001', 'YYYYMMDD'))
      OVER (ORDER BY OPER.ID_INDIVIDUO),5) AS R_COUNT,
      ROUND(REGR_R2(SUM(OPER.PIPS), SYSDATE-TO_DATE('20161001', 'YYYYMMDD'))
      OVER (ORDER BY OPER.ID_INDIVIDUO),5) AS R2,
      ROUND(REGR_SLOPE(SUM(OPER.PIPS), SYSDATE-TO_DATE('20161001', 'YYYYMMDD'))
      OVER (ORDER BY OPER.ID_INDIVIDUO),5) AS PEND,
      ROUND(REGR_INTERCEPT(SUM(OPER.PIPS), SYSDATE-TO_DATE('20161001', 'YYYYMMDD'))
      OVER (ORDER BY OPER.ID_INDIVIDUO),5) AS INTER
      
--      ROUND(REGR_R2(SUM(OPER.PIPS), SYSDATE-TO_DATE('20161001', 'YYYYMMDD')),5) AS R2,
--      ROUND(REGR_SLOPE(SUM(OPER.PIPS), SYSDATE-TO_DATE('20161001', 'YYYYMMDD')),5) AS PENDIENTE,
--      ROUND(REGR_INTERCEPT(SUM(OPER.PIPS), SYSDATE-TO_DATE('20161001', 'YYYYMMDD')),5) AS INTERCEPCION
 FROM OPERACION OPER
WHERE OPER.ID_INDIVIDUO='1473885851533.361'     
GROUP BY OPER.ID_INDIVIDUO
--, SEMANAS.FECHA_SEMANA  HAVING SUM(TMP.PIPS)>=-1000
;

SELECT OPER_MES.ID_INDIVIDUO, SEMANAS.FECHA_SEMANA, 
				OPER_SEMANA.PIPS PIPS_SEMANA, OPER_MES.PIPS PIPS_MES, OPER_ANYO.PIPS PIPS_ANYO, OPER.PIPS PIPS_TOTALES, OPER_SEMANA.TIPO_OPERACION, OPER_SEMANA.FECHA_HISTORICO,
        OPER_SEMANA.R_COUNT R_COUNT_SEMANA, OPER_SEMANA.R2 R2_SEMANA, OPER_SEMANA.PENDIENTE PENDIENTE_SEMANA, OPER_SEMANA.INTERCEPCION INTERCEPCION_SEMANA,
        OPER_MES.R_COUNT R_COUNT_MES, OPER_MES.R2 R2_MES, OPER_MES.PENDIENTE PENDIENTE_MES, OPER_MES.INTERCEPCION INTERCEPCION_MES,
        OPER_ANYO.R_COUNT R_COUNT_ANYO, OPER_ANYO.R2 R2_ANYO, OPER_ANYO.PENDIENTE PENDIENTE_ANYO, OPER_ANYO.INTERCEPCION INTERCEPCION_ANYO,
        OPER.R_COUNT R_COUNT_CONSOL, OPER.R2 R2_CONSOL, OPER.PENDIENTE PENDIENTE_CONSOL, OPER.INTERCEPCION INTERCEPCION_CONSOL
				FROM SEMANAS 
				LEFT JOIN OPERACION_X_SEMANA OPER_SEMANA 
				ON SEMANAS.FECHA_SEMANA=OPER_SEMANA.FECHA_SEMANA+7
				INNER JOIN OPERACIONES_ACUM_SEMANA_MES OPER_MES 
				ON OPER_MES.ID_INDIVIDUO=OPER_SEMANA.ID_INDIVIDUO 
				AND OPER_MES.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7   
				INNER JOIN OPERACIONES_ACUM_SEMANA_ANYO OPER_ANYO 
				ON OPER_ANYO.ID_INDIVIDUO=OPER_SEMANA.ID_INDIVIDUO 
				AND OPER_ANYO.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7 
				INNER JOIN OPERACIONES_ACUM_SEMANA_CONSOL OPER 
				ON OPER.ID_INDIVIDUO=OPER_SEMANA.ID_INDIVIDUO
				AND OPER.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7
				WHERE --NOT EXISTS (SELECT 1 FROM PREVIO_TOFILESTRING OPC WHERE OPC.ID_INDIVIDUO=OPER_MES.ID_INDIVIDUO)  AND
				OPER_MES.ID_INDIVIDUO='1463541693654.351'
ORDER BY SEMANAS.FECHA_SEMANA ASC
--ORDER BY OPER.R_COUNT ASC
;

SELECT TMP.ID_INDIVIDUO, SEMANAS.FECHA_SEMANA, SUM(TMP.PIPS) PIPS, SUM(TMP.CANTIDAD) CANTIDAD,
   MAX(P.FECHA_HISTORICO) FECHA_HISTORICO,
       ROUND(REGR_COUNT(SUM(TMP.PIPS), MAX(P.FECHA_HISTORICO)-SEMANAS.FECHA_SEMANA)
        OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC),5) AS R_COUNT,
      ROUND(REGR_R2(SUM(TMP.PIPS), MAX(P.FECHA_HISTORICO)-SEMANAS.FECHA_SEMANA)
        OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC),5) AS R2,
      ROUND(REGR_SLOPE(SUM(TMP.PIPS), MAX(P.FECHA_HISTORICO)-SEMANAS.FECHA_SEMANA)
        OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC),5) AS PENDIENTE,
      ROUND(REGR_INTERCEPT(SUM(TMP.PIPS), MAX(P.FECHA_HISTORICO)-SEMANAS.FECHA_SEMANA)
        OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC),5) AS INTERCEPCION
 FROM SEMANAS   INNER JOIN OPERACION_X_SEMANA TMP
 ON TMP.FECHA_SEMANA>=ADD_MONTHS(SEMANAS.FECHA_SEMANA,-120)
 AND TMP.FECHA_SEMANA<=SEMANAS.FECHA_SEMANA
 INNER JOIN PROCESO P ON P.ID_INDIVIDUO=TMP.ID_INDIVIDUO  WHERE TMP.ID_INDIVIDUO='1463541693654.351' AND
-- NOT EXISTS (SELECT 1 FROM OPERACIONES_ACUM_SEMANA_MES OPC WHERE OPC.ID_INDIVIDUO=TMP.ID_INDIVIDUO) AND
 SEMANAS.FECHA_SEMANA>=TO_DATE('20110101','YYYYMMDD')
 GROUP BY TMP.ID_INDIVIDUO, SEMANAS.FECHA_SEMANA  HAVING SUM(TMP.PIPS)>=-3000
ORDER BY SEMANAS.FECHA_SEMANA ASC;

SELECT OPER.ID_INDIVIDUO, IND.TIPO_OPERACION, MAX(P.FECHA_HISTORICO) FECHA_HISTORICO,
				 SUM(OPER.PIPS) PIPS, COUNT(*) CANTIDAD, TRUNC(MIN(FECHA_CIERRE),'IW'),
        ROUND(REGR_COUNT(SUM(OPER.PIPS), MAX(P.FECHA_HISTORICO)-TRUNC(MIN(FECHA_CIERRE),'IW'))
          OVER (ORDER BY TRUNC(MIN(FECHA_CIERRE),'IW') ASC),5) AS R_COUNT,
        ROUND(REGR_R2(SUM(OPER.PIPS), MAX(P.FECHA_HISTORICO)-TRUNC(MIN(FECHA_CIERRE),'IW'))
          OVER (ORDER BY TRUNC(MIN(FECHA_CIERRE),'IW') ASC),5) AS R2,
        ROUND(REGR_SLOPE(SUM(OPER.PIPS), MAX(P.FECHA_HISTORICO)-TRUNC(MIN(FECHA_CIERRE),'IW'))
          OVER (ORDER BY TRUNC(MIN(FECHA_CIERRE),'IW') ASC),5) AS PENDIENTE,
        ROUND(REGR_INTERCEPT(SUM(OPER.PIPS), MAX(P.FECHA_HISTORICO)-TRUNC(MIN(FECHA_CIERRE),'IW')) 
          OVER (ORDER BY TRUNC(MIN(FECHA_CIERRE),'IW') ASC),5) AS INTERCEPCION
				 FROM OPERACION OPER
				 INNER JOIN INDIVIDUO IND ON IND.ID=OPER.ID_INDIVIDUO
				 INNER JOIN PROCESO P ON P.ID_INDIVIDUO=OPER.ID_INDIVIDUO
         WHERE OPER.FECHA_CIERRE IS NOT NULL
--				 AND NOT EXISTS (SELECT 1 FROM OPERACION_X_SEMANA OPC WHERE OPC.ID_INDIVIDUO=OPER.ID_INDIVIDUO)
				 AND IND.TIPO_INDIVIDUO = 'INDICADORES' AND OPER.ID_INDIVIDUO='1463541693654.351'
				 GROUP BY OPER.ID_INDIVIDUO, IND.TIPO_OPERACION, TRUNC(FECHA_CIERRE,'IW');
        
SELECT TMP.ID_INDIVIDUO, TMP.FECHA_SEMANA, SYSDATE-TMP.FECHA_SEMANA FE,
  SUM(TMP.PIPS),
  ROUND(REGR_COUNT(SUM(TMP.PIPS), SYSDATE-TMP.FECHA_SEMANA)
    OVER (ORDER BY TMP.FECHA_SEMANA ASC),5) AS RCOUNT,
  ROUND(REGR_R2(SUM(TMP.PIPS), SYSDATE-TMP.FECHA_SEMANA)
    OVER (ORDER BY TMP.FECHA_SEMANA ASC),5) AS R2,
  ROUND(REGR_SLOPE(SUM(TMP.PIPS), SYSDATE-TMP.FECHA_SEMANA)
    OVER (ORDER BY TMP.FECHA_SEMANA ASC),7) AS SLOPE,
  ROUND(REGR_INTERCEPT(SUM(TMP.PIPS), SYSDATE-TMP.FECHA_SEMANA) 
    OVER (ORDER BY TMP.FECHA_SEMANA ASC),5) AS INTERC
FROM OPERACIONES_ACUM_SEMANA_CONSOL TMP
WHERE TMP.ID_INDIVIDUO='1462061850021.263'
--AND TMP.FECHA_SEMANA=TO_DATE('20160909','YYYYMMDD')
GROUP BY TMP.ID_INDIVIDUO, TMP.FECHA_SEMANA
--HAVING SUM(TMP.PIPS)>=-1000 
ORDER BY TMP.FECHA_SEMANA DESC
;

SELECT TMP.ID_INDIVIDUO, SEMANAS.FECHA_SEMANA, ROUND(SYSDATE-SEMANAS.FECHA_SEMANA) DIAS,
SUM(TMP.PIPS) PIPS, SUM(TMP.CANTIDAD) CANTIDAD,
 MAX(P.FECHA_HISTORICO) FECHA_HISTORICO, 
   ROUND(REGR_COUNT(SUM(TMP.PIPS), SYSDATE-SEMANAS.FECHA_SEMANA)
    OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC),5) AS RCOUNT,
  ROUND(REGR_R2(SUM(TMP.PIPS), SYSDATE-SEMANAS.FECHA_SEMANA)
    OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC),5) AS R2,
  ROUND(REGR_SLOPE(SUM(TMP.PIPS), SYSDATE-SEMANAS.FECHA_SEMANA)
    OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC),5) AS SLOPE,
  ROUND(REGR_INTERCEPT(SUM(TMP.PIPS), SYSDATE-SEMANAS.FECHA_SEMANA) 
    OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC),5) AS INTERC
 FROM SEMANAS  INNER JOIN OPERACION_X_SEMANA TMP
 ON TMP.FECHA_SEMANA>=ADD_MONTHS(SEMANAS.FECHA_SEMANA,-120)
 AND TMP.FECHA_SEMANA<=SEMANAS.FECHA_SEMANA
 INNER JOIN PROCESO P ON P.ID_INDIVIDUO=TMP.ID_INDIVIDUO 
 WHERE TMP.ID_INDIVIDUO='1462061850021.263' AND
 --NOT EXISTS (SELECT 1 FROM OPERACIONES_ACUM_SEMANA_MES OPC WHERE OPC.ID_INDIVIDUO=TMP.ID_INDIVIDUO)
 SEMANAS.FECHA_SEMANA>=TO_DATE('20110101','YYYYMMDD')
 GROUP BY TMP.ID_INDIVIDUO, SEMANAS.FECHA_SEMANA HAVING SUM(TMP.PIPS)>=-1000
ORDER BY SEMANAS.FECHA_SEMANA asc
; 

