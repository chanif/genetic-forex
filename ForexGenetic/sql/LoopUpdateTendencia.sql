DECLARE
BEGIN

  FOR COUNTER IN 1..1000 LOOP
    UPDATE TENDENCIA T SET PIPS_REALES=
    (SELECT PIPS FROM OPERACION OP
      WHERE OP.ID_INDIVIDUO=T.ID_INDIVIDUO AND OP.FECHA_APERTURA=T.FECHA_APERTURA AND PIPS IS NOT NULL)
    WHERE PIPS_REALES IS NULL AND ROWNUM<20000;
    COMMIT;
    --dbms_output.put_line(COUNTER);
  END LOOP;
  
END;
/

SELECT count(*) FROM TENDENCIA WHERE PIPS_REALES IS NULL;
