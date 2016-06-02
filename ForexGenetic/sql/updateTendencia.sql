/*UPDATE TENDENCIA TEN SET TEN.FECHA_APERTURA=
(
  SELECT OPER.FECHA_APERTURA FROM OPERACION OPER WHERE TEN.ID_INDIVIDUO=OPER.ID_INDIVIDUO
  AND OPER.FECHA_APERTURA<=TEN.FECHA_BASE AND OPER.FECHA_CIERRE>TEN.FECHA_BASE
), TEN.OPEN_PRICE =
(
SELECT OPER.OPEN_PRICE FROM OPERACION OPER WHERE TEN.ID_INDIVIDUO=OPER.ID_INDIVIDUO
AND OPER.FECHA_APERTURA<=TEN.FECHA_BASE AND OPER.FECHA_CIERRE>TEN.FECHA_BASE
)
;
COMMIT;
*/

UPDATE TENDENCIA TEN SET TEN.FECHA_APERTURA=
(
  SELECT OPER.FECHA_APERTURA FROM OPERACION OPER WHERE TEN.ID_INDIVIDUO=OPER.ID_INDIVIDUO
  AND OPER.FECHA_APERTURA<=TEN.FECHA_BASE AND OPER.FECHA_CIERRE IS NULL
), TEN.OPEN_PRICE =
(
SELECT OPER.OPEN_PRICE FROM OPERACION OPER WHERE TEN.ID_INDIVIDUO=OPER.ID_INDIVIDUO
AND OPER.FECHA_APERTURA<=TEN.FECHA_BASE AND OPER.FECHA_CIERRE IS NULL
)
;
COMMIT;

/*
SELECT TEN.ID_INDIVIDUO,OPER.FECHA_APERTURA, oper.open_price, TEN.FECHA_BASE FROM TENDENCIA TEN
  INNER JOIN OPERACION OPER ON TEN.ID_INDIVIDUO=OPER.ID_INDIVIDUO
WHERE OPER.FECHA_APERTURA<=TEN.FECHA_BASE AND OPER.FECHA_CIERRE>TEN.FECHA_BASE;
*/