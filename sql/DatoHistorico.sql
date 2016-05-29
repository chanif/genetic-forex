SELECT * FROM FOREX.DATOHISTORICO --WHERE ROWNUM < 10
ORDER BY FECHA ASC;

SELECT COUNT(*) FROM DATOHISTORICO;

SELECT DH.* 
FROM FOREX.DATOHISTORICO DH WHERE DH.FECHA>=TO_DATE('2008/07/10 09:16','YYYY/MM/DD HH24:MI')
ORDER BY DH.FECHA ASC;

SELECT DH.* 
FROM FOREX.DATOHISTORICO DH WHERE DH.FECHA IN (TO_DATE('2012/06/21 17:35','YYYY/MM/DD HH24:MI'), TO_DATE('2012/06/28 02:53','YYYY/MM/DD HH24:MI'))
ORDER BY DH.FECHA ASC;

SELECT *
FROM DATOHISTORICO DH WHERE DH.FECHA>=TO_DATE('2009/01/01 00:00', 'YYYY/MM/DD HH24:MI');

SELECT DH.* 
FROM FOREX.DATOHISTORICO DH WHERE AVERAGE_COMPARE IS NOT NULL
ORDER BY DH.FECHA ASC;

SELECT 
COUNT(*)
--DH1.* 
FROM DATOHISTORICO DH1
WHERE NOT EXISTS (SELECT * FROM DATOHISTORICO DH2
  WHERE  DH1.PAR=DH2.PAR AND DH1.MINUTOS=DH2.MINUTOS
  AND DH2.FECHA = (DH1.FECHA+1/1440)
  )
AND NOT ((TO_CHAR(DH1.FECHA, 'D')='5') AND (TO_CHAR(DH1.FECHA+1/24, 'HH24')=22) AND (TO_CHAR(DH1.FECHA+1/1440, 'MI')=59))
ORDER BY DH1.FECHA DESC;

SELECT 
TO_CHAR(DH1.FECHA, 'MM'), COUNT(*)
FROM DATOHISTORICO DH1
WHERE NOT EXISTS (SELECT * FROM DATOHISTORICO DH2
  WHERE  DH1.PAR=DH2.PAR AND DH1.MINUTOS=DH2.MINUTOS
  AND DH2.FECHA = (DH1.FECHA+1/1440)
  )
AND NOT ((TO_CHAR(DH1.FECHA, 'D')='5') AND (TO_CHAR(DH1.FECHA+1/24, 'HH24')=22) AND (TO_CHAR(DH1.FECHA+1/1440, 'MI')=59))
GROUP BY TO_CHAR(DH1.FECHA, 'MM')
ORDER BY TO_CHAR(DH1.FECHA, 'MM')
;
