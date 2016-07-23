SELECT * FROM OPERACION_X_SEMANA OPER 
WHERE OPER.ID_INDIVIDUO='1461280102688.210'
--AND FECHA_SEMANA>=TO_DATE('20160713', 'YYYYMMDD')
ORDER BY FECHA_SEMANA DESC
;

SELECT * FROM OPERACIONES_ACUM_SEMANA_MES OPER
WHERE OPER.ID_INDIVIDUO='1461280102688.210'
--AND FECHA_SEMANA>=TO_DATE('20160713', 'YYYYMMDD')
ORDER BY FECHA_SEMANA DESC
;

SELECT * FROM OPERACIONES_ACUM_SEMANA_ANYO OPER
WHERE OPER.ID_INDIVIDUO='1461280102688.210'
--AND FECHA_SEMANA>=TO_DATE('20160713', 'YYYYMMDD')
ORDER BY FECHA_SEMANA DESC
;

SELECT * FROM OPERACIONES_ACUM_SEMANA_CONSOL OPER
WHERE OPER.ID_INDIVIDUO='1461280102688.210'
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

SELECT * FROM PREVIO_TOFILESTRING TFS ORDER BY TFS.FECHA_SEMANA DESC;

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
ORDER BY FECHA_SEMANA DESC
;

SELECT * FROM SEMANAS ORDER BY FECHA_SEMANA DESC;

SELECT * FROM OPERACION_X_SEMANA OPER
WHERE --OPER.ID_INDIVIDUO IN ('1453687605734.178', '1453044410021.4') AND 
OPER.FECHA_SEMANA>=TO_DATE('20160321', 'YYYYMMDD')
AND OPER.PIPS>0
AND OPER.TIPO_OPERACION='BUY'
ORDER BY OPER.FECHA_SEMANA ASC
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

SELECT OPER_SEMANA.ID_INDIVIDUO, SUM(OPER_SEMANA.PIPS), SUM(OPER.PIPS),
  SEMANAS.FECHA_SEMANA, SEMANAS.FECHA_SEMANA+7
  FROM SEMANAS
    LEFT JOIN OPERACION_X_SEMANA OPER_SEMANA 
		ON OPER_SEMANA.FECHA_SEMANA=(SEMANAS.FECHA_SEMANA-7)
    INNER JOIN OPERACIONES_ACUM_SEMANA_MES OPER_MES
      ON OPER_MES.ID_INDIVIDUO=OPER_SEMANA.ID_INDIVIDUO     
        AND OPER_MES.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7
    INNER JOIN OPERACIONES_ACUM_SEMANA_ANYO OPER_ANYO 
      ON OPER_ANYO.ID_INDIVIDUO=OPER_SEMANA.ID_INDIVIDUO     
        AND OPER_ANYO.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7
    INNER JOIN OPERACIONES_ACUM_SEMANA_CONSOL OPER
      ON OPER_SEMANA.ID_INDIVIDUO=OPER.ID_INDIVIDUO 
      AND OPER.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7
	INNER JOIN ESTRATEGIA_OPERACION_PERIODO PERI
		ON ( NVL(OPER_SEMANA.PIPS,0)>PERI.FILTRO_PIPS_X_SEMANA AND OPER_MES.PIPS>PERI.FILTRO_PIPS_X_MES 
			AND OPER_ANYO.PIPS>PERI.FILTRO_PIPS_X_ANYO AND OPER.PIPS>PERI.FILTRO_PIPS_TOTALES) 
			AND OPER_SEMANA.TIPO_OPERACION=PERI.TIPO_OPERACION
  WHERE 
  ( PERI.ID IN (92453)
  --( NVL(OPER_SEMANA.PIPS,0)>2000 AND OPER_MES.PIPS>1400 AND OPER_ANYO.PIPS>2800 AND OPER.PIPS>-3000) 
   )
  --AND SEMANAS.FECHA_SEMANA BETWEEN TO_DATE('20110101','YYYYMMDD') AND TO_DATE('20120101','YYYYMMDD')
  AND SEMANAS.FECHA_SEMANA > TO_DATE('20121220','YYYYMMDD')
  AND SEMANAS.FECHA_SEMANA < TO_DATE('20150210','YYYYMMDD')
  --AND OPER_SEMANA.ID_INDIVIDUO ='1453664590875.284'
  GROUP BY OPER_SEMANA.ID_INDIVIDUO, SEMANAS.FECHA_SEMANA;