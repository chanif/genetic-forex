SELECT AC2.ID_INDIVIDUO, AC2.FECHA_SEMANA, AC2.PIPS PIPS, AC2.CANTIDAD, AC2.FECHA_HISTORICO,
  AC2.R_COUNT, AC2.R2, AC2.PENDIENTE, AC2.INTERCEPCION
FROM (SELECT AC.ID_INDIVIDUO, AC.FECHA_SEMANA, AC.FECHA_CIERRE, AC.PIPS, AC.CANTIDAD, AC.MAXFE, AC.FECHA_HISTORICO,
    REGR_COUNT(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)
      OVER (ORDER BY AC.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW) R_COUNT,
    ROUND(REGR_R2(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)
      OVER (ORDER BY AC.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW),5) R2,
    ROUND(REGR_SLOPE(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)
      OVER (ORDER BY AC.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW),5) PENDIENTE,
    ROUND(REGR_INTERCEPT(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)
      OVER (ORDER BY AC.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW),5) INTERCEPCION
  FROM (SELECT MAX(OPER.ID_INDIVIDUO) OVER () ID_INDIVIDUO, SEMANAS.FECHA_SEMANA  FECHA_SEMANA, 
      NVL(OPER.FECHA_CIERRE,SEMANAS.FECHA_SEMANA) FECHA_CIERRE,
      NVL(SUM(OPER.PIPS) OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW),0) PIPS,
      NVL(SUM(OPER.PIPS) OVER (ORDER BY OPER.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW),0) PIPS_REGR,
      COUNT(OPER.PIPS) OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW) CANTIDAD,
      COUNT(OPER.PIPS) OVER (ORDER BY OPER.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW) CANTIDAD_REGR,
      NVL(MIN(OPER.FECHA_CIERRE) OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC RANGE BETWEEN INTERVAL '1' YEAR PRECEDING AND CURRENT ROW),SEMANAS.FECHA_SEMANA-7) MINFE,
      NVL(MAX(OPER.FECHA_CIERRE) OVER (PARTITION BY SEMANAS.FECHA_SEMANA), SEMANAS.FECHA_SEMANA) MAXFE,
      MAX(P.FECHA_HISTORICO) OVER () FECHA_HISTORICO
    FROM SEMANAS 
    LEFT JOIN OPERACION OPER ON SEMANAS.FECHA_SEMANA=TRUNC((OPER.FECHA_CIERRE),'IW') 
      AND OPER.ID_INDIVIDUO='1461280102688.61' AND OPER.FECHA_CIERRE IS NOT NULL
    LEFT JOIN PROCESO P ON P.ID_INDIVIDUO=OPER.ID_INDIVIDUO
  ) AC ORDER BY AC.FECHA_SEMANA ASC) AC2
  INNER JOIN INDIVIDUO IND ON IND.ID=AC2.ID_INDIVIDUO AND IND.TIPO_INDIVIDUO = 'INDICADORES'
  WHERE --NOT EXISTS (SELECT 1 FROM OPERACIONES_ACUM_SEMANA_ANYO OPC WHERE OPC.ID_INDIVIDUO=AC2.ID_INDIVIDUO)
    --AND 
    AC2.MAXFE=AC2.FECHA_CIERRE
    AND AC2.FECHA_SEMANA>=TO_DATE('2011/01/01', 'YYYY/MM/DD') AND AC2.PIPS>-1000
ORDER BY AC2.FECHA_SEMANA ASC
;

