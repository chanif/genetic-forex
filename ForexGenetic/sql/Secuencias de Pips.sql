SELECT TFS.VIGENCIA1, TFS.VIGENCIA2, OPER.*
FROM OPERACION OPER
INNER JOIN TOFILESTRING_1D1S1M_2014 TFS
    ON OPER.ID_INDIVIDUO=TFS.ID_INDIVIDUO AND OPER.FECHA_APERTURA>=TFS.VIGENCIA1
      AND OPER.FECHA_APERTURA<TFS.VIGENCIA2
 WHERE 1=1 
    --AND OPER.ID_INDIVIDUO='1322537891442.119497'
     AND TO_CHAR(OPER.FECHA_APERTURA, 'YYYYMM')='201403' 
ORDER BY OPER.FECHA_APERTURA ASC
--ORDER BY (GANA.PIPS_DIA+GANA.PIPS_SEM+GANA.PIPS_MES)/3 DESC
--ORDER BY OPER.PIPS DESC
;

SELECT  TO_CHAR(OPER.FECHA_APERTURA, 'YYYYMM'), 
SUM(OPER.PIPS)
FROM OPERACION OPER
INNER JOIN TOFILESTRING_1D1S1M_2014 TFS
    ON OPER.ID_INDIVIDUO=TFS.ID_INDIVIDUO AND OPER.FECHA_APERTURA>=TFS.VIGENCIA1
      AND OPER.FECHA_APERTURA<TFS.VIGENCIA2
 WHERE 1=1 
    --AND OPER.ID_INDIVIDUO='1322537891442.119497'
     --AND TO_CHAR(OPER.FECHA_APERTURA, 'YYYYMM')<>'201403' 
GROUP BY TO_CHAR(OPER.FECHA_APERTURA, 'YYYYMM')
ORDER BY  TO_CHAR(OPER.FECHA_APERTURA, 'YYYYMM') ASC
;

SELECT TO_CHAR(X.VIGENCIA1, 'YYYYMMDD') MES, SUM(PIPS_OBTENIDOS), COUNT(*) FROM (
SELECT OPER.ID_INDIVIDUO, MIN(GANA.PD_MIN_FECHA2) MIN_FECHA, 
  TRUNC(MIN(GANA.PD_MIN_FECHA2)+1) VIGENCIA1, TRUNC(MIN(GANA.PD_MIN_FECHA2)+1)+1 VIGENCIA2, 
  SUM(OPER.PIPS) PIPS_OBTENIDOS, COUNT(*) CANTIDAD,
  AVG(GANA.PIPS_DIA+GANA.PIPS_SEM) PIPS_PROM
--OPER.*, GANA.* 
FROM OPERACION OPER
INNER JOIN (SELECT PD1.MIN_FECHA_F PD_MIN_FECHA2, PD1.PIPS_F PIPS_DIA, PS1.PIPS_F PIPS_SEM, PS1.*
    --,TO_DATE(TO_CHAR(ADD_MONTHS(PM1.MIN_FECHA_F,1), 'YYYYMM')||'01', 'YYYYMMDD') M
    --, PM1.* 
    FROM PDI_MVIEW_2014 PD1 INNER JOIN PSI_MVIEW_2014 PS1 
        ON PS1.ID_INDIVIDUO = PD1.ID_INDIVIDUO AND TO_CHAR(PS1.MIN_FECHA_F, 'WW')=TO_CHAR(PD1.MIN_FECHA1, 'WW')-1
      --INNER JOIN PMI_MVIEW_2014 PM1  ON PM1.ID_INDIVIDUO = PD1.ID_INDIVIDUO 
        --AND TO_CHAR(PM1.MIN_FECHA_F, 'MM')=TO_CHAR(PD1.MIN_FECHA_F, 'MM')-1
       -- AND TO_CHAR(PM1.MIN_FECHA_F, 'MM')=TO_CHAR(PS1.MIN_FECHA1, 'MM')-1
       -- AND TO_CHAR(PM1.MIN_FECHA_F, 'MM')=TO_CHAR(PS1.MIN_FECHA_F, 'MM')-1
      WHERE /*(SELECT SUM(OPER2.PIPS) 
            FROM OPERACION OPER2 WHERE OPER2.ID_INDIVIDUO = PD1.ID_INDIVIDUO 
              --AND TO_CHAR(OPER2.FECHA_APERTURA, 'YYYYMM')=TO_CHAR(PD1.MIN_FECHA_F, 'YYYYMM')
              AND OPER2.FECHA_APERTURA>=TO_DATE(TO_CHAR(ADD_MONTHS(PM1.MIN_FECHA_F,1), 'YYYYMM')||'01', 'YYYYMMDD')
              AND OPER2.FECHA_CIERRE<=PD1.MIN_FECHA_F
              GROUP BY OPER2.ID_INDIVIDUO)>0 
          AND*/ PS1.ID_INDIVIDUO NOT IN (
            SELECT OPER3.ID_INDIVIDUO FROM OPERACION OPER3 WHERE OPER3.ID_INDIVIDUO = PD1.ID_INDIVIDUO
              AND OPER3.FECHA_APERTURA<TRUNC(PD1.MIN_FECHA_F)+1
              AND (OPER3.FECHA_CIERRE IS NULL OR OPER3.FECHA_CIERRE>TRUNC(PD1.MIN_FECHA_F)+1)
            )              
          AND EXISTS (
            SELECT COUNT(*) FROM PMI_MVIEW_2014 PM2 
            WHERE PM2.ID_INDIVIDUO=PD1.ID_INDIVIDUO AND TO_CHAR(PM2.MIN_FECHA_F, 'MM')<TO_CHAR(PS1.MIN_FECHA_F, 'MM')
            )            
    ) GANA
    ON OPER.ID_INDIVIDUO=GANA.ID_INDIVIDUO AND OPER.FECHA_APERTURA>=GANA.PD_MIN_FECHA2+1
      AND OPER.FECHA_APERTURA<=GANA.PD_MIN_FECHA2+2
      --AND (TO_CHAR(OPER.FECHA_APERTURA, 'YYYY WW')=TO_CHAR(GANA.PD_MIN_FECHA2, 'YYYY WW'))
        --OR TO_CHAR(OPER.FECHA_APERTURA, 'YYYY WW')=TO_CHAR(GANA.PD_MIN_FECHA2, 'YYYY ')||(TO_CHAR(GANA.PD_MIN_FECHA2, 'WW')+1))
     WHERE 1=1 --OPER.ID_INDIVIDUO=1327920942225.432665
     AND TO_CHAR(OPER.FECHA_APERTURA, 'YYYYMM')='201401'
     --AND OPER.TAKE_PROFIT<OPER.STOP_LOSS
GROUP BY OPER.ID_INDIVIDUO, GANA.PD_MIN_FECHA2
--GROUP BY TO_CHAR(OPER.FECHA_APERTURA, 'YYYYMM')
ORDER BY MIN(OPER.FECHA_APERTURA) ASC
--ORDER BY SUM(OPER.PIPS) ASC
--ORDER BY OPER.ID_INDIVIDUO ASC
) X
GROUP BY TO_CHAR(X.VIGENCIA1, 'YYYYMMDD')
ORDER BY TO_CHAR(X.VIGENCIA1, 'YYYYMMDD') ASC
;

SELECT PD1.*, PS1.*, PM1.*
  FROM PDI_MVIEW_2014 PD1 INNER JOIN PSI_MVIEW_2014 PS1 
        ON PS1.ID_INDIVIDUO = PD1.ID_INDIVIDUO AND TO_CHAR(PS1.MIN_FECHA_F, 'WW')=TO_CHAR(PD1.MIN_FECHA1, 'WW')-1
      INNER JOIN PMI_MVIEW_2014 PM1  ON PM1.ID_INDIVIDUO = PD1.ID_INDIVIDUO 
        AND TO_CHAR(PM1.MIN_FECHA_F, 'MM')=TO_CHAR(PD1.MIN_FECHA_F, 'MM')-1
        AND TO_CHAR(PM1.MIN_FECHA_F, 'MM')=TO_CHAR(PS1.MIN_FECHA1, 'MM')-1
        AND TO_CHAR(PM1.MIN_FECHA_F, 'MM')=TO_CHAR(PS1.MIN_FECHA_F, 'MM')-1
      WHERE (SELECT SUM(OPER2.PIPS) 
            FROM OPERACION OPER2 WHERE OPER2.ID_INDIVIDUO = PD1.ID_INDIVIDUO 
              AND OPER2.FECHA_APERTURA>=TO_DATE(TO_CHAR(ADD_MONTHS(PM1.MIN_FECHA_F,1), 'YYYYMM')||'01', 'YYYYMMDD')
              AND OPER2.FECHA_CIERRE<=PD1.MIN_FECHA_F
              GROUP BY OPER2.ID_INDIVIDUO)>0 
	  AND PD1.ID_INDIVIDUO NOT IN (
        SELECT OPER3.ID_INDIVIDUO FROM OPERACION OPER3 WHERE OPER3.ID_INDIVIDUO = PD1.ID_INDIVIDUO
          AND OPER3.FECHA_APERTURA<TRUNC(PD1.MIN_FECHA_F)+1
          AND (OPER3.FECHA_CIERRE IS NULL OR OPER3.FECHA_CIERRE>TRUNC(PD1.MIN_FECHA_F)+1)
        )
      AND PD1.ID_INDIVIDUO='1322537891442.119497'
  ORDER BY PD1.MIN_FECHA1 ASC
;

SELECT AVG(CANT) FROM (
SELECT TFS.VIGENCIA1, TFS.VIGENCIA2, COUNT(*) CANT, to_char(TFS.VIGENCIA1,'D') D FROM (
  SELECT TFS2.VIGENCIA1, TFS2.VIGENCIA2, IND.TAKE_PROFIT, COUNT(*) CANT
  FROM INDIVIDUO IND
  INNER JOIN TOFILESTRING_2D2S1M_2014 TFS2
    ON TFS2.ID_INDIVIDUO=IND.ID
  --WHERE TO_CHAR(TFS.VIGENCIA1, 'YYYYMMDD')='20140126'   
  GROUP BY TFS2.VIGENCIA1, TFS2.VIGENCIA2, IND.TAKE_PROFIT) TFS  
GROUP BY TFS.VIGENCIA1, TFS.VIGENCIA2
ORDER BY TFS.VIGENCIA1 ASC
--ORDER BY COUNT(*) DESC
)
;

SELECT TFS2.*
  FROM INDIVIDUO IND
  INNER JOIN TOFILESTRING_1D1S1M_2014 TFS2
    ON TFS2.ID_INDIVIDUO=IND.ID
  WHERE IND.ID='1322537891442.119497'
ORDER BY VIGENCIA1 ASC
;

SELECT TFS.*, IND.* FROM TOFILESTRING_2D2S1M_2014 TFS
INNER JOIN INDIVIDUO IND
  ON TFS.ID_INDIVIDUO=IND.ID
--WHERE TO_CHAR(TFS.VIGENCIA1, 'YYYYMMDD')='20140325' 
ORDER BY TFS.VIGENCIA1 ASC
;

SELECT SUM(OPER2.PIPS)
            FROM OPERACION OPER2 WHERE OPER2.ID_INDIVIDUO = '1322537891442.119497'
              --AND TO_CHAR(OPER2.FECHA_APERTURA, 'YYYYMM')='201404'
              AND OPER2.FECHA_APERTURA>=TO_DATE('2014/08/01', 'YYYY/MM/DD')
              AND OPER2.FECHA_CIERRE<=TO_DATE('2014/09/01', 'YYYY/MM/DD')
              --AND OPER2.FECHA_APERTURA<=TO_DATE('2014/09/01', 'YYYY/MM/DD')
GROUP BY OPER2.ID_INDIVIDUO
;

SELECT TFS2.VIGENCIA1, COUNT(*) CANT_TFS FROM TOFILESTRING_2D2S1M_2014 TFS2 GROUP BY TFS2.VIGENCIA1
ORDER BY TFS2.VIGENCIA1 ASC;

SELECT * FROM PDI_MVIEW_2014 PD1
WHERE PD1.ID_INDIVIDUO='1323052128041.62759'
;

SELECT * FROM PSI_MVIEW_2014 PS1
WHERE PS1.ID_INDIVIDUO='1323052128041.62759'
;

SELECT * FROM PMI_MVIEW_2014 PM1
--WHERE PM1.ID_INDIVIDUO='1323052128041.62759'
ORDER BY MIN_FECHA_F ASC
;

SELECT COUNT(*) FROM PDI_MVIEW;
SELECT COUNT(*) FROM PSI_VIEW;
SELECT COUNT(*) FROM PMI_VIEW;

SELECT * FROM MV_PIPS_DIARIOS_INDIVIDUO PDI;

--SELECT SUM(PROM) FROM (
SELECT OPER.*, TFS.* 
  --OPER.FECHA_APERTURA, ROUND(AVG(OPER.PIPS),2) PROM, SUM(OPER.PIPS), COUNT(*)
FROM OPERACION OPER
  INNER JOIN TOFILESTRING_2D2S1M_2014 TFS
    ON OPER.ID_INDIVIDUO=TFS.ID_INDIVIDUO
    AND OPER.FECHA_APERTURA BETWEEN TFS.VIGENCIA1 AND VIGENCIA2
--GROUP BY OPER.FECHA_APERTURA
WHERE TO_CHAR(OPER.FECHA_APERTURA, 'YYYYMM')='201401'
--AND OPER.ID_INDIVIDUO='1322537891442.119497'
ORDER BY OPER.FECHA_APERTURA
--)
;
