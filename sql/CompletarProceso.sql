DECLARE
  FECHA_OPERACION DATE;
  FECHA_INICIAL DATE;  
  TIENE_OPER_MINIMAS NUMBER;
  REG_INDIVIDUO_OPERACION FOREX.OPERACION_BASE%ROWTYPE;

CURSOR C_INDIVIDUOS_OPERACION IS
  SELECT DISTINCT ID_INDIVIDUO FROM (
  SELECT OPERB2.ID_INDIVIDUO, OBTENER_FECHA_OPERACION(OPERB2.FECHA_APERTURA) FROM FOREX.OPERACION_BASE OPERB2 
  WHERE NOT EXISTS (SELECT 1 FROM OPERACION OP WHERE OP.ID_INDIVIDUO=OPERB2.ID_INDIVIDUO 
  AND OP.FECHA_APERTURA=OBTENER_FECHA_OPERACION(OPERB2.FECHA_APERTURA))
  AND NOT EXISTS (
    SELECT 1 FROM OPERACION_BASE OP2 WHERE OP2.ID_INDIVIDUO=OPERB2.ID_INDIVIDUO
    AND OPERB2.FECHA_APERTURA > OP2.FECHA_APERTURA AND OPERB2.FECHA_APERTURA <= OP2.FECHA_CIERRE
  )
  MINUS
  SELECT OPERB.ID_INDIVIDUO, OBTENER_FECHA_OPERACION(OPERB.FECHA_APERTURA) FROM FOREX.OPERACION_BASE OPERB
    INNER JOIN OPERACION OP ON OP.ID_INDIVIDUO=OPERB.ID_INDIVIDUO 
    WHERE OP.FECHA_APERTURA=OBTENER_FECHA_OPERACION(OPERB.FECHA_APERTURA));

BEGIN
    FOR REG_INDIVIDUO_OPERACION IN C_INDIVIDUOS_OPERACION LOOP
      
      INSERT INTO OPERACION(ID_INDIVIDUO, TAKE_PROFIT, STOP_LOSS, FECHA_APERTURA, FECHA_CIERRE, SPREAD, OPEN_PRICE, PIPS)
        SELECT OPCOM.ID_INDIVIDUO, OPCOM.TAKE_PROFIT, OPCOM.STOP_LOSS, 
          OBTENER_FECHA_OPERACION(OPCOM.FECHA_APERTURA), OBTENER_FECHA_OPERACION(OPCOM.FECHA_CIERRE), OPCOM.SPREAD, OPCOM.OPEN_PRICE, OPCOM.PIPS
        FROM OPERACIONES_COMPLETAS OPCOM
        WHERE NOT EXISTS (SELECT 1 FROM OPERACION OP WHERE OP.ID_INDIVIDUO=OPCOM.ID_INDIVIDUO 
          AND OP.FECHA_APERTURA=OBTENER_FECHA_OPERACION(OPCOM.FECHA_APERTURA))
          AND NOT EXISTS (
            SELECT 1 FROM OPERACION_BASE OP2 WHERE OP2.ID_INDIVIDUO=OPCOM.ID_INDIVIDUO
            AND OPCOM.FECHA_APERTURA > OP2.FECHA_APERTURA AND OPCOM.FECHA_APERTURA <= OP2.FECHA_CIERRE
            )
        AND OPCOM.ID_INDIVIDUO=REG_INDIVIDUO_OPERACION.ID_INDIVIDUO;
      COMMIT;
      SMART_DELETE(REG_INDIVIDUO_OPERACION.ID_INDIVIDUO, 'NO_OPERATIONS');
      COMMIT;
      SMART_DELETE_MINIMUM(REG_INDIVIDUO_OPERACION.ID_INDIVIDUO);
      COMMIT;    
  END LOOP;    

END;
/