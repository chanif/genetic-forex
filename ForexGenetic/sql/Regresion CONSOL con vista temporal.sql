--CREATE OR REPLACE VIEW TEMP_ACUM_SUM_CONSOL AS
SELECT OPER.ID_INDIVIDUO,
  TRUNC((OPER.FECHA_CIERRE),'IW') SEMANA, OPER.PIPS, OPER.FECHA_CIERRE, 
  ROUND(OPER.FECHA_CIERRE-TO_DATE('20160901','YYYYMMDD'),2) DIFF,
  COUNT(OPER.PIPS) OVER (
    ORDER BY TRUNC((OPER.FECHA_CIERRE),'IW') ASC 
    --RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW
    ) CANTIDAD,
  SUM(OPER.PIPS) OVER (
    ORDER BY TRUNC((OPER.FECHA_CIERRE),'IW') ASC 
    --RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW
    ) PIPS_ACUM,
  MIN(OPER.FECHA_CIERRE) OVER (
    ORDER BY TRUNC((OPER.FECHA_CIERRE),'IW') ASC --RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW
    ) MINFE,
  MAX(OPER.FECHA_CIERRE) OVER (PARTITION BY TRUNC((OPER.FECHA_CIERRE),'IW')) MAXFE
FROM OPERACION OPER
WHERE OPER.ID_INDIVIDUO='1461280102688.61';

SELECT * FROM (
  SELECT AC.SEMANA, AC.FECHA_CIERRE, AC.PIPS_ACUM, AC.MINFE, AC.MAXFE,
    REGR_COUNT(AC.PIPS_ACUM, AC.FECHA_CIERRE-TO_DATE('20160901','YYYYMMDD')) 
      OVER (
        ORDER BY TRUNC((AC.FECHA_CIERRE),'IW') ASC 
        --RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW
        ) RC,
    ROUND(REGR_R2((AC.PIPS_ACUM), AC.FECHA_CIERRE-TO_DATE('20160901','YYYYMMDD')) 
      OVER (
       ORDER BY TRUNC((AC.FECHA_CIERRE),'IW') ASC 
       --RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW
       ),5) R2,
    ROUND(REGR_SLOPE(AC.PIPS_ACUM, AC.FECHA_CIERRE-TO_DATE('20160901','YYYYMMDD'))
      OVER (
        ORDER BY TRUNC((AC.FECHA_CIERRE),'IW') ASC 
        --RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW
        ),5) SLOPE,
    ROUND(REGR_INTERCEPT(AC.PIPS_ACUM, AC.FECHA_CIERRE-TO_DATE('20160901','YYYYMMDD'))
      OVER (
        ORDER BY TRUNC((AC.FECHA_CIERRE),'IW') ASC 
        --RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW
        ),5) INTERCEP
  FROM TEMP_ACUM_SUM_CONSOL AC) AC2
WHERE AC2.MAXFE=AC2.FECHA_CIERRE
--AND AC2.FECHA_CIERRE>=TO_DATE('20110101','YYYY/MM/DD')
ORDER BY AC2.SEMANA ASC;


SELECT AC2.ID_INDIVIDUO, AC2.FECHA_SEMANA, AC2.PIPS PIPS, AC2.CANTIDAD, AC2.FECHA_HISTORICO,
  AC2.R_COUNT, AC2.R2, AC2.PENDIENTE, AC2.INTERCEPCION
FROM (
  SELECT AC.ID_INDIVIDUO, AC.FECHA_SEMANA, AC.FECHA_CIERRE, AC.PIPS, AC.CANTIDAD, AC.MAXFE, AC.FECHA_HISTORICO,
    REGR_COUNT(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)
      OVER (ORDER BY AC.FECHA_CIERRE ASC) R_COUNT,
    ROUND(REGR_R2(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)
      OVER (ORDER BY AC.FECHA_CIERRE ASC),5) R2,
    ROUND(REGR_SLOPE(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)
      OVER (ORDER BY AC.FECHA_CIERRE ASC),5) PENDIENTE,
    ROUND(REGR_INTERCEPT(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)
      OVER (ORDER BY AC.FECHA_CIERRE ASC),5) INTERCEPCION
  FROM (
    SELECT 
      MAX(OPER.ID_INDIVIDUO) OVER () ID_INDIVIDUO,
      SEMANAS.FECHA_SEMANA  FECHA_SEMANA, 
      NVL(OPER.FECHA_CIERRE,SEMANAS.FECHA_SEMANA) FECHA_CIERRE,
      NVL(SUM(OPER.PIPS) OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC),0) PIPS,
      NVL(SUM(OPER.PIPS) OVER (ORDER BY OPER.FECHA_CIERRE ASC),0) PIPS_REGR,
      COUNT(OPER.PIPS) OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC) CANTIDAD,
      COUNT(OPER.PIPS) OVER (ORDER BY OPER.FECHA_CIERRE ASC) CANTIDAD_REGR,
      NVL(MIN(OPER.FECHA_CIERRE) OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC),SEMANAS.FECHA_SEMANA-7) MINFE,
      NVL(MAX(OPER.FECHA_CIERRE) OVER (PARTITION BY SEMANAS.FECHA_SEMANA), SEMANAS.FECHA_SEMANA) MAXFE,
      MAX(P.FECHA_HISTORICO) OVER () FECHA_HISTORICO
    FROM SEMANAS 
    LEFT JOIN OPERACION OPER ON SEMANAS.FECHA_SEMANA=TRUNC((OPER.FECHA_CIERRE),'IW') 
      AND OPER.ID_INDIVIDUO='1461280102688.61' AND OPER.FECHA_CIERRE IS NOT NULL
    LEFT JOIN PROCESO P ON P.ID_INDIVIDUO=OPER.ID_INDIVIDUO
  ) AC ORDER BY AC.FECHA_SEMANA ASC) AC2
  INNER JOIN INDIVIDUO IND ON IND.ID=AC2.ID_INDIVIDUO AND IND.TIPO_INDIVIDUO = 'INDICADORES'
  WHERE 
    NOT EXISTS (SELECT 1 FROM OPERACIONES_ACUM_SEMANA_CONSOL OPC WHERE OPC.ID_INDIVIDUO=AC2.ID_INDIVIDUO)
    AND AC2.MAXFE=AC2.FECHA_CIERRE
    AND AC2.FECHA_SEMANA>=TO_DATE('2011/01/01', 'YYYY/MM/DD') AND AC2.PIPS>-3000
ORDER BY AC2.FECHA_SEMANA ASC
;
