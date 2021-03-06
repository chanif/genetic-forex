SELECT 
DH1.FECHA,DH2.FECHA,DH1.OPEN,DH2.OPEN,DH1.CLOSE,DH2.CLOSE,DH1.LOW,DH2.LOW,DH1.HIGH,DH2.HIGH
FROM DATOHISTORICO DH1, DATOHISTORICO DH2
WHERE DH1.FECHA < DH2.FECHA 
AND DH1.OPEN=DH2.OPEN AND DH1.CLOSE=DH2.CLOSE AND DH1.LOW=DH2.LOW AND DH1.HIGH=DH2.HIGH
AND DH1.FECHA NOT IN (
  SELECT DH4.FECHA
  FROM DATOHISTORICO DH3, DATOHISTORICO DH4
  WHERE DH3.FECHA < DH4.FECHA 
  AND DH3.OPEN=DH4.OPEN AND DH3.CLOSE=DH4.CLOSE AND DH3.LOW=DH4.LOW AND DH3.HIGH=DH4.HIGH)
AND DH1.FECHA=TO_DATE('&FECHA', 'YYYY/MM/DD HH24:MI')
ORDER BY DH1.FECHA, DH2.FECHA DESC
;

SELECT 
COUNT(*)
--dh1.fecha,dh2.fecha,dh1.open,dh2.open,dh1.close,dh2.close,dh1.low,dh2.low,dh1.high,dh2.high
FROM DATOHISTORICO DH1, DATOHISTORICO DH2
WHERE DH1.FECHA < DH2.FECHA 
AND DH1.OPEN=DH2.OPEN AND DH1.CLOSE=DH2.CLOSE AND DH1.LOW=DH2.LOW AND DH1.HIGH=DH2.HIGH
AND DH1.FECHA NOT IN (
  SELECT DH4.FECHA
  FROM DATOHISTORICO DH3, DATOHISTORICO DH4
  WHERE DH3.FECHA < DH4.FECHA 
  AND DH3.OPEN=DH4.OPEN AND DH3.CLOSE=DH4.CLOSE AND DH3.LOW=DH4.LOW AND DH3.HIGH=DH4.HIGH)
ORDER BY DH1.FECHA, DH2.FECHA
;

SELECT DH1.FECHA, COUNT(*)
FROM DATOHISTORICO DH1, DATOHISTORICO DH2
WHERE DH1.FECHA < DH2.FECHA 
AND DH1.OPEN=DH2.OPEN AND DH1.CLOSE=DH2.CLOSE AND DH1.LOW=DH2.LOW AND DH1.HIGH=DH2.HIGH
AND DH1.FECHA NOT IN (
  SELECT DH4.FECHA
  FROM DATOHISTORICO DH3, DATOHISTORICO DH4
  WHERE DH3.FECHA < DH4.FECHA 
  AND DH3.OPEN=DH4.OPEN AND DH3.CLOSE=DH4.CLOSE AND DH3.LOW=DH4.LOW AND DH3.HIGH=DH4.HIGH)
HAVING COUNT(*) > 1  
GROUP BY DH1.FECHA
ORDER BY 
--dh1.fecha
 COUNT(*) DESC
;

