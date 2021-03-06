SELECT EOP.TIPO_OPERACION, FECHA_INICIAL, FECHA_FINAL, MIN(ID), MAX(ID), COUNT(*), MAX(FECHA)
FROM FOREX.ESTRATEGIA_OPERACION_PERIODO EOP
GROUP BY EOP.FECHA_INICIAL, EOP.FECHA_FINAL, EOP.TIPO_OPERACION
ORDER BY MAX(ID) DESC
;

SELECT EOP.ID, PIPS_TOTALES, PIPS_TOTALES_PARALELAS, CANTIDAD_PARALELAS, FECHA_INICIAL, FILTRO_PIPS_X_SEMANA, EOP.* 
FROM FOREX.ESTRATEGIA_OPERACION_PERIODO EOP --WHERE ID>=1421
ORDER BY EOP.ID DESC;

SELECT EOP.ID, EOP.PIPS_TOTALES, EOP.* FROM ESTRATEGIA_OPERACION_PERIODO EOP 
  INNER JOIN ESTRATEGIA_OPERACION_PERIODO PERI
    ON ( EOP.FILTRO_PIPS_X_SEMANA=PERI.FILTRO_PIPS_X_SEMANA AND EOP.FILTRO_PIPS_X_MES=PERI.FILTRO_PIPS_X_MES 
			AND EOP.FILTRO_PIPS_X_ANYO=PERI.FILTRO_PIPS_X_ANYO AND EOP.FILTRO_PIPS_TOTALES=PERI.FILTRO_PIPS_TOTALES)
WHERE PERI.ID IN (18443)
ORDER BY EOP.ID DESC;

SELECT MAX(ID), EOP.TIPO_OPERACION, EOP.FILTRO_PIPS_X_SEMANA FP_X_SEMANA, EOP.FILTRO_PIPS_X_MES, EOP.FILTRO_PIPS_X_ANYO, EOP.FILTRO_PIPS_TOTALES, 
  SUM(PIPS_TOTALES) PIPS, SUM(PIPS_TOTALES_PARALELAS) PIPS_PARAL,   
  SUM(EOP.PIPS_AGRUPADO_MINUTOS), SUM(EOP.PIPS_AGRUPADO_HORAS), SUM(EOP.PIPS_AGRUPADO_DIAS),
  SUM(ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2)) CANT
  FROM ESTRATEGIA_OPERACION_PERIODO EOP 
  WHERE EOP.TIPO_OPERACION = 'SELL'
GROUP BY EOP.TIPO_OPERACION, EOP.FILTRO_PIPS_X_SEMANA, EOP.FILTRO_PIPS_X_MES, EOP.FILTRO_PIPS_X_ANYO, EOP.FILTRO_PIPS_TOTALES
HAVING MAX(ID) >= 124701
--AND SUM(PIPS_TOTALES_PARALELAS) > 0
ORDER BY SUM(EOP.PIPS_TOTALES) DESC, SUM(EOP.PIPS_TOTALES_PARALELAS) DESC
--SUM(ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2)) ASC
;

SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE ID IN (40838,47873,92453,82034)
  --(24494,15521)
ORDER BY EOP.TIPO_OPERACION, EOP.ID DESC
;

SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0 
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
  ORDER BY EOP.PIPS_TOTALES DESC, EOP.PIPS_TOTALES_PARALELAS DESC;
SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0 
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
  --AND ID>143000
  ORDER BY EOP.PIPS_TOTALES_PARALELAS DESC, EOP.PIPS_TOTALES DESC;
SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
  --AND ID>143000
  ORDER BY (EOP.PIPS_TOTALES*0.7+EOP.PIPS_TOTALES_PARALELAS*0.3) DESC;

--TENER EN CUENTA ESTA MANERA DE FILTRAR POR CANTIDAD. ES MAS ESTABLE.
SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
  --AND ID>143000  
  AND CANTIDAD>0
  AND CANTIDAD_PARALELAS>CANTIDAD
  ORDER BY (EOP.CANTIDAD_PARALELAS/(EOP.CANTIDAD)) ASC;
SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
  --AND ID>143000  
  ORDER BY (EOP.PIPS_AGRUPADO_MINUTOS+EOP.PIPS_AGRUPADO_HORAS+EOP.PIPS_AGRUPADO_DIAS)/3 DESC;
SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999 AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
  --AND ID>143000
  ORDER BY (EOP.PIPS_TOTALES*0.4
    +EOP.PIPS_TOTALES_PARALELAS*0.2
    +EOP.PIPS_AGRUPADO_MINUTOS*0.15+EOP.PIPS_AGRUPADO_HORAS*0.15+EOP.PIPS_AGRUPADO_DIAS*0.1) DESC;
SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999 
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
  --AND ID>143000
  ORDER BY (EOP.PIPS_AGRUPADO_MINUTOS) DESC;
SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999 
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
  --AND ID>143000
  ORDER BY (EOP.PIPS_AGRUPADO_HORAS) DESC;
SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999 
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
  --AND ID>143000
  ORDER BY (EOP.PIPS_AGRUPADO_DIAS) DESC;
SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999 
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)  
  --AND ID>143000
ORDER BY ABS(EOP.PIPS_TOTALES-EOP.PIPS_TOTALES_PARALELAS) ASC;  
SELECT EOP.ID, PIPS_TOTALES PIPS, PIPS_TOTALES_PARALELAS PIPS_PARAL, ROUND(CANTIDAD_PARALELAS/(CANTIDAD+1),2) CANT, FILTRO_PIPS_X_SEMANA FILTR_SEM, EOP.* 
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE TIPO_OPERACION='SELL'
  AND ID BETWEEN 124701 AND 9999999 
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)  
  --AND ID>143000
ORDER BY CANTIDAD DESC; 

SELECT ESTRATEGIA_PERIODO, TO_CHAR(FECHA_APERTURA, 'YYYY'), SUM(PIPS), COUNT(*) FROM OPERACION_ESTRATEGIA_PERIODO 
WHERE ESTRATEGIA_PERIODO=148115
--AND TO_CHAR(FECHA_APERTURA,'YYYYMM')='201306'
--ORDER BY FECHA_APERTURA ASC
GROUP BY ESTRATEGIA_PERIODO, TO_CHAR(FECHA_APERTURA, 'YYYY')
ORDER BY TO_CHAR(FECHA_APERTURA, 'YYYY') ASC
;

SELECT * FROM ESTRATEGIA_OPERACION_PERIODO
WHERE ID=148115;

SELECT * FROM OPERACION_ESTRATEGIA_PERIODO
WHERE ESTRATEGIA_PERIODO=148115
ORDER BY FECHA_APERTURA ASC;

SELECT * FROM OPERACION_ESTRATEGIA_PERIODO OPER
WHERE OPER.FECHA_APERTURA BETWEEN TO_DATE('20160321', 'YYYYMMDD') AND TO_DATE('20160401', 'YYYYMMDD')
AND OPER.TIPO='SELL'
ORDER BY FECHA_APERTURA ASC;

SELECT FLOOR(FILTRO_PIPS_X_SEMANA/ 100) RANGO, FLOOR(FILTRO_PIPS_X_SEMANA/ 100)*100 R, 
  COUNT(*), SUM(PIPS_TOTALES), ROUND(AVG(PIPS_TOTALES))
FROM ESTRATEGIA_OPERACION_PERIODO EOP --WHERE ID>=1421
GROUP BY FLOOR(FILTRO_PIPS_X_SEMANA/ 100)
ORDER BY SUM(PIPS_TOTALES) DESC;

SELECT FLOOR(FILTRO_PIPS_X_MES/ 100) RANGO, FLOOR(FILTRO_PIPS_X_MES/ 100)*100 R, 
  COUNT(*), SUM(PIPS_TOTALES), ROUND(AVG(PIPS_TOTALES))
FROM ESTRATEGIA_OPERACION_PERIODO EOP --WHERE ID>=1421
GROUP BY FLOOR(FILTRO_PIPS_X_MES/ 100)
ORDER BY SUM(PIPS_TOTALES) DESC;

SELECT SUM(PIPS_TOTALES) FROM ESTRATEGIA_OPERACION_PERIODO EOP 
WHERE FILTRO_PIPS_X_MES BETWEEN 2901 AND 3000;

SELECT FLOOR(FILTRO_PIPS_X_ANYO/ 100) RANGO, FLOOR(FILTRO_PIPS_X_ANYO/ 100)*100 R, 
  COUNT(*), SUM(PIPS_TOTALES), ROUND(AVG(PIPS_TOTALES))
FROM ESTRATEGIA_OPERACION_PERIODO EOP --WHERE ID>=1421
GROUP BY FLOOR(FILTRO_PIPS_X_ANYO/ 100)
ORDER BY SUM(PIPS_TOTALES) DESC;

SELECT FLOOR(FILTRO_PIPS_TOTALES/ 100) RANGO, FLOOR(FILTRO_PIPS_TOTALES/ 100)*100 R, 
  COUNT(*), SUM(PIPS_TOTALES), ROUND(AVG(PIPS_TOTALES))
FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE ID>=1421
GROUP BY FLOOR(FILTRO_PIPS_TOTALES/ 100)
ORDER BY SUM(PIPS_TOTALES) DESC;

SELECT OPER.* FROM OPERACION OPER 
  INNER JOIN TMP_TOFILESTRING2 TFS ON TFS.ID_INDIVIDUO=OPER.ID_INDIVIDUO 
  AND OPER.FECHA_APERTURA BETWEEN VIGENCIA1 AND VIGENCIA2 
  WHERE OPER.FECHA_APERTURA>TO_DATE('2011/01/31 23:59', 'YYYY/MM/DD HH24:MI') AND OPER.FECHA_CIERRE IS NOT NULL 
  --AND OPER.ID_INDIVIDUO='1455148800000.2625'
  ORDER BY OPER.FECHA_APERTURA ASC, TFS.CRITERIO_ORDER1 DESC, TFS.CRITERIO_ORDER2 DESC;

SELECT OPER.* FROM OPERACION OPER 
  INNER JOIN TMP_TOFILESTRING2 TFS ON TFS.ID_INDIVIDUO=OPER.ID_INDIVIDUO 
  AND OPER.FECHA_APERTURA BETWEEN VIGENCIA1 AND VIGENCIA2 
  WHERE OPER.FECHA_APERTURA<TO_DATE('2012/06/01 00:00', 'YYYY/MM/DD HH24:MI') AND OPER.FECHA_CIERRE>TO_DATE('2012/06/01 00:00', 'YYYY/MM/DD HH24:MI')
  --AND OPER.ID_INDIVIDUO='1455148800000.2625'
  ORDER BY OPER.FECHA_APERTURA ASC, TFS.CRITERIO_ORDER1 DESC, TFS.CRITERIO_ORDER2 DESC;
     
SELECT TO_CHAR(FECHA_APERTURA, 'YYYY'), SUM(PIPS), COUNT(*) FROM OPERACION_ESTRATEGIA_PERIODO 
WHERE ESTRATEGIA_PERIODO=2930
--AND FECHA_APERTURA>TO_DATE('20130101', 'YYYYMMDD')
GROUP BY TO_CHAR(FECHA_APERTURA, 'YYYY')
ORDER BY TO_CHAR(FECHA_APERTURA, 'YYYY') ASC;

SELECT * FROM OPERACION_ESTRATEGIA_PERIODO WHERE ID_INDIVIDUO='1322089876887.48'
--AND FECHA_APERTURA>TO_DATE('20130101', 'YYYYMMDD')
ORDER BY ESTRATEGIA_PERIODO DESC
;

SELECT * FROM OPERACION_ESTRATEGIA_PERIODO WHERE ESTRATEGIA_PERIODO IN (150842, 150376)
ORDER BY FECHA_APERTURA ASC;

SELECT FECHA_APERTURA, PIPS FROM OPERACION_ESTRATEGIA_PERIODO WHERE ESTRATEGIA_PERIODO=150376
MINUS
SELECT FECHA_APERTURA, PIPS FROM OPERACION_ESTRATEGIA_PERIODO WHERE ESTRATEGIA_PERIODO=150842;

SELECT TO_CHAR(FECHA_APERTURA, 'YYYYMM') MES, SUM(PIPS) PIPS, COUNT(*) CANT 
FROM OPERACION_ESTRATEGIA_PERIODO WHERE ESTRATEGIA_PERIODO=4165
--AND FECHA_APERTURA BETWEEN TO_DATE('20130101', 'YYYYMMDD') AND TO_DATE('20140101', 'YYYYMMDD')
GROUP BY TO_CHAR(FECHA_APERTURA, 'YYYYMM')
ORDER BY TO_CHAR(FECHA_APERTURA, 'YYYYMM') ASC
;

SELECT ROWNUM, ID, PIPS_TOTALES, EOP.* FROM ESTRATEGIA_OPERACION_PERIODO EOP 
ORDER BY EOP.PIPS_TOTALES DESC;

--UPDATE ESTRATEGIA_OPERACION_PERIODO EOP SET EOP.FILTRO_PIPS_TOTALES=-1+-1*EOP.FILTRO_PIPS_TOTALES
--where EOP.FILTRO_PIPS_TOTALES=0;
--WHERE EOP.FILTRO_PIPS_X_MES=400 AND EOP.FILTRO_PIPS_X_ANYO=2600 AND EOP.FILTRO_PIPS_TOTALES=1000;
--DELETE FROM ESTRATEGIA_OPERACION_PERIODO  WHERE ID =42953;

SELECT TO_CHAR(FECHA_APERTURA, 'YYYYMM') F, SUM(PIPS), COUNT(*) FROM OPERACION_ESTRATEGIA_PERIODO 
WHERE ESTRATEGIA_PERIODO=43742
GROUP BY TO_CHAR(FECHA_APERTURA, 'YYYYMM')
ORDER BY TO_CHAR(FECHA_APERTURA, 'YYYYMM') ASC
;

SELECT MAX(TO_CHAR(FECHA_APERTURA, 'YYYYMMDD')) MAX_DATE, SUM(PIPS), COUNT(*) FROM OPERACION_ESTRATEGIA_PERIODO
WHERE ESTRATEGIA_PERIODO=42955
AND TO_CHAR(FECHA_APERTURA, 'YYYYMM')<'201402'
ORDER BY TO_CHAR(FECHA_APERTURA, 'YYYYMM') ASC
;

SELECT * FROM TMP_TOFILESTRING2 
--WHERE ID_INDIVIDUO='1455148800000.2625'
;
   
SELECT EOP.* FROM 
  (SELECT ROWNUM, E.* FROM ESTRATEGIA_OPERACION_PERIODO E ORDER BY FECHA DESC) EOP
WHERE ROWNUM=1;

SELECT EST_OPER_PERIODO_TRG_SEQ.nextval NEXT_ID FROM dual;


SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'ESTRATEGIA_OPERACION_PERIODO';

SELECT * FROM ESTRATEGIA_OPERACION_PERIODO 
WHERE FILTRO_PIPS_X_MES=5000 
--AND FILTRO_PIPS_X_ANYO=9800 AND FILTRO_PIPS_TOTALES=6500 
;

SELECT *
FROM ESTRATEGIA_OPERACION_PERIODO
WHERE FILTRO_PIPS_X_MES>4000 AND CANTIDAD<>0
AND PIPS_TOTALES>0
ORDER BY FILTRO_PIPS_X_MES DESC
;

SELECT MIN(ID), MAX(ID) FROM FOREX.ESTRATEGIA_OPERACION_PERIODO WHERE FECHA_INICIAL>TO_DATE('2012', 'YYYY');

SELECT COUNT(*) FROM FOREX.OPERACION_ESTRATEGIA_PERIODO WHERE ESTRATEGIA_PERIODO IN (
  SELECT ID FROM FOREX.ESTRATEGIA_OPERACION_PERIODO WHERE FECHA_INICIAL>TO_DATE('2012', 'YYYY')
);
SELECT COUNT(*) FROM FOREX.ESTRATEGIA_OPERACION_PERIODO WHERE ID>=142147086;
SELECT COUNT(*) FROM FOREX.ESTRATEGIA_OPERACION_PERIODO WHERE CANTIDAD=0;

--DELETE FROM ESTRATEGIA_OPERACION_PERIODO WHERE FECHA_INICIAL>TO_DATE('2012', 'YYYY');
SELECT DISTINCT FECHA_INICIAL FROM ESTRATEGIA_OPERACION_PERIODO EOP ORDER BY FECHA_INICIAL ASC;

SELECT FILTRO_PIPS_X_SEMANA, FILTRO_PIPS_X_MES, FILTRO_PIPS_X_ANYO, FILTRO_PIPS_TOTALES, 
  SUM(EOP.PIPS_TOTALES), SUM(EOP.PIPS_TOTALES_PARALELAS)
FROM ESTRATEGIA_OPERACION_PERIODO EOP 
WHERE FECHA_INICIAL<TO_DATE('2012', 'YYYY') AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
--AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
GROUP BY FILTRO_PIPS_X_SEMANA, FILTRO_PIPS_X_MES, FILTRO_PIPS_X_ANYO, FILTRO_PIPS_TOTALES
ORDER BY SUM(EOP.PIPS_TOTALES) DESC, SUM(EOP.PIPS_TOTALES_PARALELAS) DESC;

SELECT FECHA_INICIAL, COUNT(*), SUM(PIPS_TOTALES), SUM(PIPS_TOTALES_PARALELAS) FROM ESTRATEGIA_OPERACION_PERIODO EOP
GROUP BY FECHA_INICIAL
ORDER BY SUM(PIPS_TOTALES) DESC, SUM(PIPS_TOTALES_PARALELAS) DESC
;

UPDATE ESTRATEGIA_OPERACION_PERIODO SET FECHA_FINAL=TO_DATE('20150202 02:41','YYYYMMDD HH24:MI')
WHERE FECHA_FINAL=TO_DATE('20151231 23:59','YYYYMMDD HH24:MI')
--WHERE FECHA_INICIAL=TO_DATE('2011/12/31 23:59', 'YYYY/MM/DD HH24:MI')
;

SELECT COUNT(*) FROM TMP_TOFILESTRING2;

SELECT * FROM (
  SELECT ' OR ( OPER_SEMANA.PIPS>'||FILTRO_PIPS_X_SEMANA||' AND OPER_MES.PIPS>'||FILTRO_PIPS_X_MES ||' AND OPER_ANYO.PIPS>'||FILTRO_PIPS_X_ANYO ||' AND OPER.PIPS>'||FILTRO_PIPS_TOTALES||')'
  FROM ESTRATEGIA_OPERACION_PERIODO EOP WHERE ID>=1421
  AND PIPS_TOTALES_PARALELAS>0 AND PIPS_TOTALES>0
  AND (EOP.PIPS_AGRUPADO_MINUTOS>0 AND EOP.PIPS_AGRUPADO_HORAS>0 AND EOP.PIPS_AGRUPADO_DIAS>0)
  --AND ID>143000
  ORDER BY EOP.PIPS_TOTALES DESC, EOP.PIPS_TOTALES_PARALELAS DESC)
WHERE ROWNUM<6;

SELECT * FROM SEMANAS
ORDER BY FECHA_SEMANA DESC;

SELECT * FROM OPERACION_ESTRATEGIA_PERIODO EOPSELL
  INNER JOIN OPERACION_ESTRATEGIA_PERIODO EOPSELL
    ON EOPSELL.ESTRATEGIA_PERIODO=EOPSELL.ESTRATEGIA_PERIODO AND EOPSELL.TIPO='SELL'
  WHERE EOPSELL.TIPO='SELL'
;