SELECT --RES.FECHA_BASE FECHA_BASE,  
--TO_CHAR(RES.MIN_FECHA, 'YYYY/MM/DD HH24:')||FLOOR(TO_CHAR(RES.MIN_FECHA, 'MI')/5)*5 FE,
--TO_CHAR(RES.MIN_FECHA, 'YYYY/MM/DD')||' '||FLOOR(TO_CHAR(RES.MIN_FECHA, 'HH24')/2)||':'||FLOOR(TO_CHAR(RES.MIN_FECHA, 'MI')/59) GR,
    MIN(RES.FEAPERTURA) FEAPERTURA,
    MIN(RES.MIN_FECHA) MIN_FECHA,
    ROUND(SUM(RES.PRECIO_BASE_PROM)/COUNT(RES.PRECIO_BASE_PROM),5) PRECIO_BASE_PROM,
    ROUND(SUM(RES.VALOR_MAS_PROBABLE*RES.PROBABILIDAD)/SUM(RES.PROBABILIDAD),5) VALOR_MAS_PROBABLE,
    ROUND(AVG(RES.PROBABILIDAD),5) PROBABILIDAD,
    ROUND(SUM(RES.PIPS_MAS_PROBABLE*RES.PROBABILIDAD)/SUM(RES.PROBABILIDAD),5) PIPS_MAS_PROBABLE,
    SUM(CANTIDAD) CANTIDAD,
    ROUND(SUM(RES.PIPS_MAS_PROBABLE*RES.PROBABILIDAD)/SUM(RES.PROBABILIDAD)*AVG(RES.PROBABILIDAD),5) TP,
    ROUND(SUM(RES.PIPS_MAS_PROBABLE*RES.PROBABILIDAD)/SUM(RES.PROBABILIDAD)*(1+AVG(RES.PROBABILIDAD)),5) SL,    
    MIN(RES.VALOR_MAS_PROBABLE) MIN_PRECIO,
    MAX(RES.VALOR_MAS_PROBABLE) MAX_PRECIO,    
        (MAX(RES.VALOR_MAS_PROBABLE)-MIN(RES.VALOR_MAS_PROBABLE))*100000 DIFF_MM,
    COUNT(*) REG, 
   MAX(RES.MAX_FECHA) MAX_FECHA
FROM 
( 
SELECT --TEN.FECHA_BASE, 
    --TEN.TIPO_CALCULO,
    MIN(TEN.FEAPERTURA) FEAPERTURA,
    MIN(TEN.FECHA_TENDENCIA) MIN_FECHA, MAX(TEN.FECHA_TENDENCIA) MAX_FECHA,  
        ROUND(SUM(TEN.PRECIO_BASE_PROM)/COUNT(TEN.PRECIO_BASE_PROM),5) PRECIO_BASE_PROM,  
        ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)-STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000,5) MIN_PRECIO,  
        ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)+STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000,5) MAX_PRECIO,  
        (ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)-STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000,5) - 
        ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD)+STDDEV(TEN.PIPS*TEN.PROBABILIDAD)/100000,5))*100000 DIFF_MM,  
        ROUND(SUM(TEN.PRECIO_CALCULADO*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD),5) VALOR_MAS_PROBABLE,
        ROUND(SUM(TEN.PIPS*TEN.PROBABILIDAD)/SUM(TEN.PROBABILIDAD),5) PIPS_MAS_PROBABLE,  
        ROUND(AVG(TEN.PROBABILIDAD),5) PROBABILIDAD, 
        SUM(CANTIDAD) CANTIDAD, COUNT(*) REGISTROS 
    FROM (
      SELECT 
--      
        --TEN4.FECHA_BASE FECHA_BASE,
        --TEN4.TIPO_CALCULO,
        MIN(TEN4.FECHA_APERTURA) FEAPERTURA,
        MIN(TEN4.FECHA_TENDENCIA) FECHA_TENDENCIA,
        SUM(TEN4.PRECIO_CALCULADO*TEN4.PROBABILIDAD)/SUM(TEN4.PROBABILIDAD) PRECIO_CALCULADO,
        SUM(TEN4.PRECIO_BASE*TEN4.PROBABILIDAD)/SUM(TEN4.PROBABILIDAD) PRECIO_BASE_PROM,        
        AVG(TEN4.PROBABILIDAD) PROBABILIDAD,
        COUNT(*) CANTIDAD,
        SUM(TEN4.PIPS*TEN4.PROBABILIDAD)/SUM(TEN4.PROBABILIDAD) PIPS
        FROM TENDENCIA TEN4
        /*(SELECT ((T.PROBABILIDAD)/(TO_DATE('2012/06/06 15:42', 'YYYY/MM/DD HH24:MI')-T.FECHA_BASE+1)) PROBABILIDAD2, 
          T.FECHA_BASE, T.TIPO_CALCULO, T.FECHA_APERTURA, T.FECHA_TENDENCIA, T.PRECIO_CALCULADO,
          T.PRECIO_BASE, T.TIPO_TENDENCIA, T.FECHA_CIERRE, T.PIPS, T.PROBABILIDAD PROBABILIDAD,
          T.PROBABILIDAD_POSITIVOS, T.PROBABILIDAD_NEGATIVOS
          FROM TENDENCIA T) TEN4*/
             INNER JOIN (--SELECT DISTINCT T.FECHA_BASE FECHA_PROCESO FROM TENDENCIA T WHERE
             --T.FECHA_BASE=
              SELECT TO_DATE(
                 '2010/11/09 23:13'
                , 'YYYY/MM/DD HH24:MI')
                FECHA_PROCESO FROM DUAL
             ) FP
          ON TEN4.FECHA_BASE=FP.FECHA_PROCESO --AND TEN4.FECHA_BASE>FP.FECHA_PROCESO-1/24
          AND (TEN4.FECHA_CIERRE IS NULL OR TEN4.FECHA_CIERRE>FP.FECHA_PROCESO)
          --AND TEN4.FECHA_APERTURA>=FECHA_PROCESO-1.5 --TO_DATE('2011/02/08 17:21', 'YYYY/MM/DD HH24:MI')
          AND TEN4.FECHA_TENDENCIA>=FP.FECHA_PROCESO
          AND ((TEN4.FECHA_TENDENCIA<=FP.FECHA_PROCESO+(3987/1440))
               --OR (TO_CHAR(FP.FECHA_PROCESO, 'D')>4 AND (TEN4.FECHA_TENDENCIA<=FP.FECHA_PROCESO+(9101/1440)+2))
               )
          AND TEN4.FECHA_APERTURA>FP.FECHA_PROCESO-60
      --AND TEN4.TIPO_CALCULO=1
      --AND ((TEN4.TIPO_CALCULO=1 AND TEN4.PROBABILIDAD_POSITIVOS>TEN4.PROBABILIDAD_NEGATIVOS)
        --OR (TEN4.TIPO_CALCULO=-1 AND TEN4.PROBABILIDAD_POSITIVOS<TEN4.PROBABILIDAD_NEGATIVOS))
       GROUP BY
        --FP.FECHA_PROCESO,
        --TEN4.FECHA_BASE, 
        --TO_CHAR(TEN4.FECHA_TENDENCIA, 'YYYY/MM/DD HH24:MI'),
        TO_CHAR(TEN4.FECHA_TENDENCIA, 'YYYY/MM/DD')||' '||FLOOR(TO_CHAR(TEN4.FECHA_TENDENCIA, 'HH24')/9)||':'||FLOOR(TO_CHAR(TEN4.FECHA_TENDENCIA, 'MI')/34),
        --TEN4.TIPO_CALCULO, 
        --TO_CHAR(TEN4.FECHA_APERTURA, 'YYYY/MM/DD HH24:MI')
        TO_CHAR(TEN4.FECHA_APERTURA, 'YYYY/MM/DD')||' '||FLOOR(TO_CHAR(TEN4.FECHA_APERTURA, 'HH24')/7)||':'||FLOOR(TO_CHAR(TEN4.FECHA_APERTURA, 'MI')/4)
--        ORDER BY TEN4.FECHA_BASE ASC
--ORDER BY TO_CHAR(TEN4.FECHA_TENDENCIA, 'YYYY/MM/DD HH24:MI') DESC
--ORDER BY TO_CHAR(TEN4.FECHA_APERTURA, 'YYYY/MM/DD')||' '||FLOOR(TO_CHAR(TEN4.FECHA_APERTURA, 'HH24')/1)||':'||FLOOR(TO_CHAR(TEN4.FECHA_APERTURA, 'MI')/1)

        ) TEN 
GROUP BY --TEN.FECHA_BASE, 
--TEN.TIPO_CALCULO,
TO_CHAR(TEN.FECHA_TENDENCIA, 'YYYY/MM/DD HH24:MI')--||FLOOR(TO_CHAR(TEN.FECHA_TENDENCIA, 'MI')/5)
--HAVING AVG(TEN.PROBABILIDAD)>0.50
--HAVING SUM(CANTIDAD)>0
--AND COUNT(*)>1 
--ORDER BY TO_CHAR(TEN.FECHA_TENDENCIA, 'YYYY/MM/DD HH24:MI') ASC
) RES
GROUP BY --RES.FECHA_BASE
1,
TO_CHAR(RES.MIN_FECHA, 'YYYY/MM/DD')||' '||FLOOR(TO_CHAR(RES.MIN_FECHA, 'HH24')/6)||':'||FLOOR(TO_CHAR(RES.MIN_FECHA, 'MI')/3)
HAVING ABS((SUM(RES.PIPS_MAS_PROBABLE*RES.PROBABILIDAD)/SUM(RES.PROBABILIDAD))*AVG(RES.PROBABILIDAD))>446
  AND SUM(CANTIDAD)>0
--AND AVG(RES.PROBABILIDAD)>0.50
--AND SUM(RES.PIPS_MAS_PROBABLE*RES.PROBABILIDAD)/SUM(RES.PROBABILIDAD)<0
--  AND ABS(ROUND(SUM(RES.PIPS_MAS_PROBABLE*RES.PROBABILIDAD)/SUM(RES.PROBABILIDAD),5))>150
ORDER BY --RES.FECHA_BASE DESC
ABS(ROUND((SUM(RES.PIPS_MAS_PROBABLE*RES.PROBABILIDAD)/SUM(RES.PROBABILIDAD))*AVG(RES.PROBABILIDAD),5)) DESC
;

select TO_DATE('2010/01/15 05:40'
                , 'YYYY/MM/DD HH24:MI') ini, TO_DATE(
                 '2010/01/15 05:40'
                , 'YYYY/MM/DD HH24:MI')+(3987/1440) fin  from dual;