SELECT TEN.FECHA_BASE, --TO_CHAR(TEN.FECHA_TENDENCIA, 'YYYY/MM/DD HH24') HORA,   
        ROUND(SUM(TEN.PRECIO_BASE)/COUNT(TEN.PRECIO_BASE),5) PRECIO_BASE,  
        ROUND(SUM(TEN.PRECIO_BASE)/COUNT(TEN.PRECIO_BASE)-
              (SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)-STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000),5)*100000 DIFF_MIN,
        ROUND((SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)+STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000-
              SUM(TEN.PRECIO_BASE_PROM)/COUNT(TEN.PRECIO_BASE_PROM)),5)*100000 DIFF_MAX,              
        ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)-STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000,5) MIN_PRECIO, 
        ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)+STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000,5) MAX_PRECIO, 
        ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD),5) VALOR_MAS_PROBABLE,  
        ROUND(SUM(TEN.PIPS*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD),5) PIPS_MAS_PROBABLE,  
        COUNT(TEN.ID_INDIVIDUO) CANTIDAD,
        ROUND(SUM(TEN.PIPS)/COUNT(TEN.PIPS),5) PIPS_PROMEDIO,  
        ROUND(STDDEV(TEN.PIPS*TEN.PROBABILIDAD),5) DESVIACION, 
        ROUND(SUM(TEN.PROBABILIDAD)/COUNT(TEN.PROBABILIDAD),5) PROMEDIO_PROB, 
        MIN(TEN.FECHA_TENDENCIA) MIN_FECHA, MAX(TEN.FECHA_TENDENCIA) MAX_FECHA,       
        MIN(TEN.PRECIO_CALCULADO) MIN_PRECIO_IND, MAX(TEN.PRECIO_CALCULADO) MAX_PRECIO_IND,       
        (MAX(TEN.PRECIO_CALCULADO)-MIN(TEN.PRECIO_CALCULADO))*10000 DIFF, (MAX(TEN.PRECIO_CALCULADO)-MIN(TEN.PRECIO_CALCULADO))*10000*0.5 DIFF_MID
    FROM (
      SELECT TEN4.FECHA_BASE, 
        (SELECT PRECIO_BASE FROM TENDENCIA WHERE FECHA_BASE=TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI') AND ROWNUM<2) PRECIO_BASE, 
       TEN4.PRECIO_BASE PRECIO_BASE_PROM, TEN4.FECHA_TENDENCIA, TEN4.PRECIO_CALCULADO, TEN4.PROBABILIDAD, TEN4.ID_INDIVIDUO, TEN4.PIPS
      FROM TENDENCIA TEN4
        WHERE 
          TEN4.FECHA_BASE<=TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI')
          AND TEN4.FECHA_TENDENCIA>=TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI')
          AND (TEN4.FECHA_CIERRE IS NULL OR TEN4.FECHA_CIERRE>TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI'))
        ) TEN
  GROUP BY FECHA_BASE  ORDER BY FECHA_BASE DESC
;

SELECT ROUND(SUM(TEN.PRECIO_BASE)/COUNT(TEN.PRECIO_BASE),5) PRECIO_BASE,  
      ROUND(SUM(TEN.PRECIO_BASE_PROM)/COUNT(TEN.PRECIO_BASE_PROM),5) PRECIO_BASE_PROM, 
      ROUND(SUM(TEN.PRECIO_BASE)/COUNT(TEN.PRECIO_BASE)-
              (SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)-STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000),5)*100000 DIFF_MIN,
      ROUND(-SUM(TEN.PRECIO_BASE)/COUNT(TEN.PRECIO_BASE)+
              (SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)+STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000),5)*100000 DIFF_MAX,
      ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)-STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000,5) MIN_PRECIO, 
      ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)+STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000,5) MAX_PRECIO, 
      ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD),5) VALOR_MAS_PROBABLE, 
      ROUND(SUM(TEN.PIPS*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD),5) PIPS_MAS_PROBABLE, 
      COUNT(*) CANTIDAD,
      ROUND(STDDEV(TEN.PIPS*TEN.PROBABILIDAD),5) DESVIACION, 
      ROUND(SUM(TEN.PROBABILIDAD)/COUNT(TEN.PROBABILIDAD),5) PROMEDIO_PROB,       
      MIN(TEN.FECHA_TENDENCIA) MIN_FECHA, MAX(TEN.FECHA_TENDENCIA) MAX_FECHA
    FROM ( 
      SELECT TEN4.FECHA_BASE, 
        (SELECT PRECIO_BASE FROM TENDENCIA WHERE FECHA_BASE=TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI') AND ROWNUM<2) PRECIO_BASE, 
       TEN4.PRECIO_BASE PRECIO_BASE_PROM, TEN4.FECHA_TENDENCIA, TEN4.PRECIO_CALCULADO, TEN4.PROBABILIDAD, TEN4.ID_INDIVIDUO, TEN4.PIPS
      FROM TENDENCIA TEN4 
     /* INNER JOIN (SELECT TEN2.ID_INDIVIDUO, TEN2.FECHA_APERTURA, MAX(TEN2.FECHA_BASE) FECHA_BASE 
        FROM TENDENCIA TEN2 
          WHERE (TEN2.FECHA_CIERRE IS NULL OR TEN2.FECHA_CIERRE>TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI')) 
          AND TEN2.FECHA_BASE<TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI')
        GROUP BY TEN2.ID_INDIVIDUO, TEN2.FECHA_APERTURA 
      ) TEN3 ON TEN4.ID_INDIVIDUO=TEN3.ID_INDIVIDUO 
        AND TEN4.FECHA_APERTURA=TEN3.FECHA_APERTURA 
        AND TEN4.FECHA_BASE=TEN3.FECHA_BASE*/
        WHERE TEN4.FECHA_TENDENCIA>=TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI')
        AND TEN4.FECHA_BASE<=TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI')
        AND (TEN4.FECHA_CIERRE IS NULL OR TEN4.FECHA_CIERRE>TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI')) 
        --AND TEN4.PROBABILIDAD>0.6
        ) TEN
    --WHERE TEN.FECHA_TENDENCIA>=TO_DATE('2012/07/27 20:33', 'YYYY/MM/DD HH24:MI')
    ;

SELECT 
--      TO_CHAR(TEN.FECHA_TENDENCIA, 'YYYY/MM/DD HH24') ||':00' FECHA_TENDENCIA,
      ROUND(SUM(TEN.PRECIO_BASE)/COUNT(TEN.PRECIO_BASE),5) PRECIO_BASE,  
      ROUND(SUM(TEN.PRECIO_BASE)/COUNT(TEN.PRECIO_BASE)-
              (SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)-STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000),5)*100000 DIFF_MIN,
      ROUND(-SUM(TEN.PRECIO_BASE)/COUNT(TEN.PRECIO_BASE)+
              (SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)+STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000),5)*100000 DIFF_MAX,      
      ROUND(MIN(TEN.PRECIO_CALCULADO),5) MIN_PRECIO_IND, ROUND(MAX(TEN.PRECIO_CALCULADO),5) MAX_PRECIO_IND,
      ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)-STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000,5) MIN_PRECIO, 
      ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)+STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000,5) MAX_PRECIO, 
      ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD),5) VALOR_MAS_PROBABLE, 
      ROUND((SUM(TEN.PRECIO_BASE)/COUNT(TEN.PRECIO_BASE)-SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD))*100000,5) PIPS_MAS_PROBABLE,
      SUM(CANTIDAD) CANTIDAD,
      ROUND(STDDEV(TEN.PIPS*TEN.PROBABILIDAD),5) DESVIACION, 
      ROUND(SUM(TEN.PROBABILIDAD)/COUNT(TEN.PROBABILIDAD),5) PROMEDIO_PROB,             
      MIN(TEN.FECHA_TENDENCIA) MIN_FECHA, MAX(TEN.FECHA_TENDENCIA) MAX_FECHA     
    FROM (
      SELECT (SELECT T.PRECIO_BASE FROM TENDENCIA T WHERE T.FECHA_BASE=TO_DATE('2011/07/01 00:01', 'YYYY/MM/DD HH24:MI') AND ROWNUM<2) PRECIO_BASE, 
        MIN(TEN4.FECHA_TENDENCIA) FECHA_TENDENCIA, 
        SUM(TEN4.PRECIO_CALCULADO*TEN4.PROBABILIDAD)/SUM(TEN4.PROBABILIDAD) PRECIO_CALCULADO, 
        SUM(TEN4.PRECIO_BASE*TEN4.PROBABILIDAD)/SUM(TEN4.PROBABILIDAD) PRECIO_BASE_PROM,
        AVG(TEN4.PROBABILIDAD) PROBABILIDAD, 
        SUM(TEN4.PIPS*TEN4.PROBABILIDAD)/SUM(TEN4.PROBABILIDAD) PIPS,
        SUM((TEN4.FECHA_BASE-TEN4.FECHA_APERTURA)*TEN4.PROBABILIDAD)/SUM(TEN4.PROBABILIDAD) DURACION,
        COUNT(*) CANTIDAD
        FROM TENDENCIA TEN4 
          INNER JOIN (SELECT TO_DATE('2011/07/01 00:01', 'YYYY/MM/DD HH24:MI') FECHA_PROCESO FROM DUAL) FP 
          ON TEN4.FECHA_BASE=FP.FECHA_PROCESO 
          AND (TEN4.FECHA_CIERRE IS NULL OR TEN4.FECHA_CIERRE>FP.FECHA_PROCESO)
          AND TEN4.FECHA_TENDENCIA>=FP.FECHA_PROCESO 
          --AND TEN4.FECHA_APERTURA=FP.FECHA_PROCESO-1/24/60
          AND TEN4.FECHA_TENDENCIA<=FP.FECHA_PROCESO+1
        GROUP BY 
        TO_CHAR(TEN4.FECHA_TENDENCIA, 'YYYY/MM/DD HH24')
        ,TO_CHAR(TEN4.FECHA_APERTURA, 'YYYY/MM/DD HH24')
        --TO_CHAR(TEN4.FECHA_APERTURA, 'YYYY/MM/DD HH24')
        --TO_CHAR(TEN4.FECHA_BASE, 'YYYY/MM/DD') 

        ) TEN
--        GROUP BY TO_CHAR(TEN.FECHA_TENDENCIA, 'YYYY/MM/DD HH24')
--        ORDER BY TO_CHAR(TEN.FECHA_TENDENCIA, 'YYYY/MM/DD HH24') ASC
    ;
