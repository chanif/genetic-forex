DECLARE
  FECHA_OPERACION DATE;
  FECHA_INICIAL DATE;
  FECHA_MAX_HISTORIA DATE;
  FECHA_MAX_HIST_PROCESO DATE;
  REG_INDIVIDUO FOREX.INDIVIDUO%ROWTYPE;
  COUNT_DATE NUMBER;
  TIENE_OPER_MINIMAS NUMBER;
  REG_INDIVIDUO_OPERACION FOREX.OPERACION_BASE%ROWTYPE;
  DIAS_PROCESO NUMBER := 30;

  CURSOR C_INDIVIDUOS(FECHA_OPERACIONES IN DATE) IS
    SELECT IND.*
    FROM FOREX.INDIVIDUO IND WHERE IND.ID NOT IN (SELECT ID_INDIVIDUO FROM OPERACION_BASE
      WHERE FECHA_APERTURA BETWEEN FECHA_OPERACIONES AND FECHA_OPERACIONES+DIAS_PROCESO)
    --AND (IND.ID NOT IN (SELECT DISTINCT PRO.ID_INDIVIDUO FROM PROCESO PRO) OR (IND.ID='1341687718670.27852'))
    AND (IND.ID NOT IN (SELECT DISTINCT PRO.ID_INDIVIDUO FROM PROCESO PRO))
    AND IND.CREATION_DATE IS NOT NULL AND IND.CREATION_DATE BETWEEN TO_DATE('2012/06/07', 'YYYY/MM/DD') AND TO_DATE('2012/08/07', 'YYYY/MM/DD')
    ORDER BY IND.ID DESC;

  CURSOR C_INDIVIDUOS_OPERACION IS
    SELECT DISTINCT ID_INDIVIDUO FROM (
    SELECT OPERB2.ID_INDIVIDUO, OBTENER_FECHA_OPERACION(OPERB2.FECHA_APERTURA) FROM FOREX.OPERACION_BASE OPERB2 
    MINUS
    SELECT OPERB.ID_INDIVIDUO, OBTENER_FECHA_OPERACION(OPERB.FECHA_APERTURA) FROM FOREX.OPERACION_BASE OPERB
      INNER JOIN OPERACION OP ON OP.ID_INDIVIDUO=OPERB.ID_INDIVIDUO 
      WHERE OP.FECHA_APERTURA=OBTENER_FECHA_OPERACION(OPERB.FECHA_APERTURA));
BEGIN
  --DBMS_OUTPUT.PUT_LINE('RRQ -3');  
  FECHA_INICIAL := TO_DATE('2008/07/10 09:16','YYYY/MM/DD HH24:MI');
  FECHA_OPERACION := FECHA_INICIAL;
  FOR REG_INDIVIDUO IN C_INDIVIDUOS(FECHA_OPERACION) LOOP 
--    IF (REG_INDIVIDUO.ID='1341687718670.27852') THEN
--      FECHA_OPERACION := TO_DATE('2008/11/07 12:07','YYYY/MM/DD HH24:MI');
--    ELSE
--      FECHA_OPERACION := FECHA_INICIAL;
--    END IF;

    --SELECT TO_DATE(VALOR, 'YYYY/MM/DD HH24:MI') INTO FECHA_OPERACION FROM FOREX.PARAMETRO WHERE NOMBRE='INSERCION_OPERACIONES';
    SELECT MAX(FECHA) INTO FECHA_MAX_HISTORIA FROM FOREX.DATOHISTORICO;
    SELECT MAX(FECHA_HISTORICO) INTO FECHA_MAX_HIST_PROCESO FROM FOREX.PROCESO;
  
    --FECHA_MAX_HISTORIA := TO_DATE('2008/06/01 00:00','YYYY/MM/DD HH24:MI');
   TIENE_OPER_MINIMAS := 1;
    WHILE((FECHA_OPERACION < FECHA_MAX_HISTORIA) AND (TIENE_OPER_MINIMAS=1)) LOOP 
/*      IF (FECHA_MAX_HIST_PROCESO <> FECHA_OPERACION) THEN
        DELETE FROM FOREX.PROCESO;
        COMMIT;
      END IF;
      */
      --DBMS_OUTPUT.PUT_LINE('RRQ -2 FECHA_OPERACION='||FECHA_OPERACION);
      
      SELECT COUNT(*) INTO COUNT_DATE FROM FOREX.DATOHISTORICO DH WHERE DH.FECHA BETWEEN FECHA_OPERACION AND FECHA_OPERACION+DIAS_PROCESO;
        --WHERE TO_CHAR(DH.FECHA,'YYYY/MM/DD HH24:MI')=TO_CHAR(FECHA_OPERACION,'YYYY/MM/DD HH24:MI');
      --DBMS_OUTPUT.PUT_LINE('RRQ -1 COUNT_DATE='||COUNT_DATE);
--      UPDATE FOREX.PARAMETRO SET VALOR=FECHA_OPERACION,FPARAMETRO=SYSDATE WHERE NOMBRE='INSERCION_OPERACIONES';
--      COMMIT;
  
      IF (COUNT_DATE>0) THEN
        INSERT INTO OPERACION_BASE(ID_INDIVIDUO, FECHA_APERTURA, FECHA_CIERRE) 
          SELECT V_OPERACIONES.ID, V_OPERACIONES.OPEN_FECHA, V_OPERACIONES.CLOSE_FECHA
          FROM V_OPERACIONES WHERE V_OPERACIONES.OPEN_FECHA BETWEEN FECHA_OPERACION AND FECHA_OPERACION+DIAS_PROCESO
          AND V_OPERACIONES.ID=REG_INDIVIDUO.ID
          AND NOT EXISTS (
            SELECT 1 FROM OPERACION_BASE OP WHERE OP.ID_INDIVIDUO=V_OPERACIONES.ID 
            AND OP.FECHA_APERTURA=V_OPERACIONES.OPEN_FECHA AND OP.FECHA_CIERRE=V_OPERACIONES.CLOSE_FECHA
            )
          AND NOT EXISTS (
            SELECT 1 FROM OPERACION_BASE OP2 WHERE OP2.ID_INDIVIDUO=V_OPERACIONES.ID 
            AND V_OPERACIONES.OPEN_FECHA > OP2.FECHA_APERTURA AND V_OPERACIONES.OPEN_FECHA <= OP2.FECHA_CIERRE
            );
            --DBMS_OUTPUT.PUT_LINE('RRQ 1');        
      END IF;

      INSERT INTO PROCESO(ID_INDIVIDUO, FECHA_HISTORICO, FECHA_PROCESO)
        VALUES (REG_INDIVIDUO.ID, FECHA_OPERACION, SYSDATE);      
      COMMIT;
      
      TIENE_OPER_MINIMAS := HAS_MINIMUM_OPERATIONS(REG_INDIVIDUO.ID, FECHA_INICIAL, FECHA_OPERACION);
      
      --SELECT NVL(MAX(FECHA_CIERRE),FECHA_OPERACION+(1/1440)) INTO FECHA_OPERACION FROM OPERACION_BASE WHERE ID_INDIVIDUO=REG_INDIVIDUO.ID;
      SELECT MAXIMUN_DATE(NVL(MAX(FECHA_CIERRE),FECHA_OPERACION+(DIAS_PROCESO)), FECHA_OPERACION+(DIAS_PROCESO)) INTO FECHA_OPERACION 
        FROM OPERACION_BASE WHERE ID_INDIVIDUO=REG_INDIVIDUO.ID;
      --DBMS_OUTPUT.PUT_LINE('RRQ 2 FECHA_OPERACION='||FECHA_OPERACION);
    END LOOP;
    
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
    END LOOP;
    SMART_DELETE(REG_INDIVIDUO.ID, 'NO_OPERATIONS');    
    COMMIT;
    SMART_DELETE_MINIMUM(REG_INDIVIDUO.ID, FECHA_INICIAL, FECHA_OPERACION);
    COMMIT;
  END LOOP;    

END;
/