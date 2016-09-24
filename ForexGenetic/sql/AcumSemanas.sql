SELECT * FROM PREVIO_TOFILESTRING OPER
WHERE OPER.ID_INDIVIDUO LIKE '1473885851533.421'
ORDER BY OPER.FECHA_SEMANA ASC;

SELECT * FROM PREVIO_TOFILESTRING OPER
--WHERE OPER.PIPS_SEMANA>0 AND OPER.PIPS_MES>0 AND OPER.PIPS_ANYO>0 AND OPER.PIPS_TOTALES>8000
ORDER BY OPER.FECHA_SEMANA DESC
;

SELECT PTFS.FECHA_SEMANA, ROUND(AVG(R2_SEMANA),5) R2_SEMANA, ROUND(AVG(R2_MES),5) R2_MES,
  ROUND(AVG(R2_ANYO),5) R2_ANYO, ROUND(AVG(R2_CONSOL),5) R2_CONSOL,
  ROUND(AVG(PENDIENTE_SEMANA),5) PENDIENTE_SEMANA, ROUND(AVG(PENDIENTE_MES),5) PENDIENTE_MES,
  ROUND(AVG(PENDIENTE_ANYO),5) PENDIENTE_ANYO, ROUND(AVG(PENDIENTE_CONSOL),5) PENDIENTE_CONSOL
FROM PREVIO_TOFILESTRING PTFS
  INNER JOIN PROCESO P ON PTFS.ID_INDIVIDUO=P.ID_INDIVIDUO AND P.FECHA_PROCESO>TRUNC(SYSDATE)
WHERE PTFS.R2_CONSOL IS NOT NULL
GROUP BY PTFS.FECHA_SEMANA
--ORDER BY PTFS.FECHA_SEMANA DESC
ORDER BY AVG(PTFS.R2_CONSOL) DESC
;

SELECT * FROM PREVIO_TOFILESTRING OPER
WHERE OPER.PIPS_TOTALES>0 AND OPER.R2_CONSOL BETWEEN 0.001 AND 0.9999
AND OPER.FECHA_SEMANA>=TO_DATE('2014/01/01 00:00', 'YYYY/MM/DD HH24:MI') 
--AND OPER.R2_CONSOL>0.5 AND OPER.R2_ANYO>0.5 AND OPER.R2_MES>0.5 AND OPER.R2_SEMANA>0.5
AND OPER.R_COUNT_CONSOL>10 
--AND OPER.PENDIENTE_CONSOL>0 AND OPER.PENDIENTE_ANYO>0 AND OPER.PENDIENTE_MES>0 AND OPER.PENDIENTE_SEMANA>0
ORDER BY OPER.R2_CONSOL DESC;

SELECT TO_CHAR(OPER.FECHA_SEMANA, 'YYYYMM') FE, 
  ROUND(AVG(OPER.PIPS_SEMANA)) PIPSS, ROUND(AVG(OPER.PIPS_MES)) PIPSM, 
  ROUND(AVG(OPER.PIPS_ANYO)) PIPSA, ROUND(AVG(OPER.PIPS_TOTALES)) PIPST 
FROM PREVIO_TOFILESTRING OPER
GROUP BY TO_CHAR(OPER.FECHA_SEMANA, 'YYYYMM')
ORDER BY TO_CHAR(OPER.FECHA_SEMANA, 'YYYYMM') DESC
;

SELECT OPER.FECHA_SEMANA-TO_DATE('20160901','YYYYMMDD') DIFF, OPER.* FROM OPERACION_X_SEMANA OPER
WHERE OPER.ID_INDIVIDUO LIKE '1473885851533.421'
ORDER BY OPER.FECHA_SEMANA ASC;

SELECT * FROM OPERACION_X_SEMANA OPER 
WHERE 
OPER.ID_INDIVIDUO LIKE '1473885851533.421'
AND 
FECHA_SEMANA>=TO_DATE('20120101', 'YYYYMMDD')
ORDER BY FECHA_SEMANA ASC
;

SELECT * FROM OPERACIONES_ACUM_SEMANA_MES OPER
WHERE OPER.ID_INDIVIDUO='1473885851533.421'
--AND FECHA_SEMANA>=TO_DATE('20160713', 'YYYYMMDD')
ORDER BY FECHA_SEMANA ASC
;

SELECT * FROM OPERACIONES_ACUM_SEMANA_ANYO OPER
WHERE OPER.ID_INDIVIDUO='1473885851533.421'
--AND FECHA_SEMANA>=TO_DATE('20150913', 'YYYYMMDD')
ORDER BY FECHA_SEMANA ASC
;

SELECT OPER.*
FROM OPERACIONES_ACUM_SEMANA_CONSOL OPER
WHERE OPER.ID_INDIVIDUO='1473885851533.421'
--AND FECHA_SEMANA>=TO_DATE('20160713', 'YYYYMMDD')
ORDER BY FECHA_SEMANA ASC
;

SELECT * FROM TMP_TOFILESTRING2 
ORDER BY VIGENCIA1 DESC, CRITERIO_ORDER1 DESC;

SELECT OPER.FECHA_SEMANA, OPER.ID_INDIVIDUO FROM
  OPERACIONES_ACUM_SEMANA_CONSOL OPER
  INNER JOIN 
  (SELECT FECHA_SEMANA, MAX(PIPS) PIPS FROM OPERACIONES_ACUM_SEMANA_CONSOL
  WHERE FECHA_SEMANA>=TO_DATE('20140101', 'YYYYMMDD')
  GROUP BY FECHA_SEMANA
--ORDER BY FECHA_SEMANA ASC
  ) TMP ON OPER.FECHA_SEMANA=TMP.FECHA_SEMANA AND OPER.PIPS=TMP.PIPS
;

SELECT 'SEMANA', count(*), MAX(FECHA_SEMANA), AVG(PIPS) FROM OPERACION_X_SEMANA SEM
--WHERE SEM.PIPS>0
;
UNION ALL
SELECT 'MES', COUNT(*), MAX(FECHA_SEMANA), AVG(PIPS) FROM OPERACIONES_ACUM_SEMANA_MES OPER
--WHERE OPER.PIPS>-1000
;
UNION ALL
SELECT 'ANYO', COUNT(*), MAX(FECHA_SEMANA), AVG(PIPS) FROM OPERACIONES_ACUM_SEMANA_ANYO OPER
--WHERE OPER.PIPS>-2000
;
SELECT 'CONSOL', COUNT(*), MAX(FECHA_SEMANA), AVG(PIPS) FROM OPERACIONES_ACUM_SEMANA_CONSOL OPER
--WHERE OPER.PIPS>-3000
;

SELECT * FROM OPERACION_X_SEMANA OPER
ORDER BY FECHA_SEMANA DESC
;
SELECT * FROM OPERACIONES_ACUM_SEMANA_MES OPER
ORDER BY FECHA_SEMANA DESC
;
SELECT * FROM OPERACIONES_ACUM_SEMANA_ANYO OPER
ORDER BY FECHA_SEMANA DESC
;
SELECT * FROM OPERACIONES_ACUM_SEMANA_CONSOL OPER
ORDER BY PIPS DESC
;
SELECT * FROM PREVIO_TOFILESTRING TFS 
ORDER BY TFS.FECHA_SEMANA DESC;

SELECT * FROM SEMANAS ORDER BY FECHA_SEMANA ASC;

SELECT * FROM OPERACION_X_SEMANA OPER
WHERE --OPER.ID_INDIVIDUO IN ('1453687605734.178', '1453044410021.4') AND 
OPER.FECHA_SEMANA<=TO_DATE('20160401', 'YYYYMMDD')
AND OPER.PIPS>0
AND OPER.TIPO_OPERACION='SELL'
ORDER BY OPER.FECHA_SEMANA DESC
--ORDER BY OPER.PIPS DESC
;

SELECT * FROM OPERACIONES_ACUM_SEMANA_MES OPER
WHERE --OPER.ID_INDIVIDUO='1460948821579.426' AND 
OPER.FECHA_SEMANA>=TO_DATE('20160321', 'YYYYMMDD')
AND OPER.PIPS>0
ORDER BY OPER.FECHA_SEMANA ASC
;

SELECT * FROM OPERACIONES_ACUM_SEMANA_ANYO OPER
WHERE --OPER.ID_INDIVIDUO='1460948821579.426' AND 
OPER.FECHA_SEMANA>=TO_DATE('20160321', 'YYYYMMDD')
AND OPER.PIPS>0
ORDER BY OPER.FECHA_SEMANA ASC
;

SELECT * FROM OPERACIONES_ACUM_SEMANA_CONSOL OPER
WHERE --OPER.ID_INDIVIDUO='1460948821579.426' AND 
OPER.FECHA_SEMANA>=TO_DATE('20160321', 'YYYYMMDD')
AND OPER.PIPS>0
ORDER BY OPER.FECHA_SEMANA ASC
;

