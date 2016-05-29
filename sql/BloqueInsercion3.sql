DECLARE
  FECHA_INICIAL DATE;
  FECHA_MAX_HISTORIA DATE;
  REG_INDIVIDUO FOREX.INDIVIDUO%ROWTYPE;
  COUNT_DATE NUMBER;

  CURSOR C_INDIVIDUOS(FECHA_OPERACIONES IN DATE) IS
    SELECT IND.*
    FROM FOREX.INDIVIDUO IND WHERE IND.ID NOT IN (
      SELECT ID_INDIVIDUO FROM OPERACION_BASE WHERE FECHA_APERTURA=FECHA_OPERACIONES
    );
  
BEGIN
  FECHA_INICIAL := TO_DATE('2008/05/06 08:45','YYYY/MM/DD HH24:MI');
  SELECT MAX(FECHA) INTO FECHA_MAX_HISTORIA FROM DATOHISTORICO;
  --FECHA_MAX_HISTORIA := TO_DATE('2008/06/01 00:00','YYYY/MM/DD HH24:MI');
  
  WHILE(FECHA_INICIAL < FECHA_MAX_HISTORIA) LOOP 
    SELECT COUNT(*) INTO COUNT_DATE FROM FOREX.DATOHISTORICO WHERE FECHA=FECHA_INICIAL;
    
    IF(COUNT_DATE>0) THEN
      FOR REG_INDIVIDUO IN C_INDIVIDUOS(FECHA_INICIAL) LOOP
        INSERT INTO OPERACION_BASE(ID_INDIVIDUO, FECHA_APERTURA, FECHA_CIERRE) 
          SELECT V_OPERACIONES.ID, V_OPERACIONES.OPEN_FECHA, V_OPERACIONES.CLOSE_FECHA
          FROM V_OPERACIONES WHERE V_OPERACIONES.OPEN_FECHA=FECHA_INICIAL
          AND V_OPERACIONES.ID=REG_INDIVIDUO.ID
          AND NOT EXISTS (
            SELECT 1 FROM OPERACION_BASE OP WHERE OP.ID_INDIVIDUO=V_OPERACIONES.ID 
            AND OP.FECHA_APERTURA=V_OPERACIONES.OPEN_FECHA AND OP.FECHA_CIERRE=V_OPERACIONES.CLOSE_FECHA
            )
          AND NOT EXISTS (
            SELECT 1 FROM OPERACION_BASE OP2 WHERE OP2.ID_INDIVIDUO=V_OPERACIONES.ID 
            AND V_OPERACIONES.OPEN_FECHA > OP2.FECHA_APERTURA AND V_OPERACIONES.OPEN_FECHA <= OP2.FECHA_CIERRE
            );
        COMMIT;  
      END LOOP;
    END IF;
    FECHA_INICIAL := FECHA_INICIAL+0.001;
    
  END LOOP;

END;
/