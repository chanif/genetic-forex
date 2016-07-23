create or replace PROCEDURE SMART_DELETE
(
  ID_IND_BORRAR IN VARCHAR2  
, TIPO_BORRADO IN VARCHAR2  
, ID_IND_PADRE IN VARCHAR2  
) AS 
BEGIN
  INSERT INTO INDIVIDUO_BORRADO(ID, PARENT_ID_1, PARENT_ID_2, TAKE_PROFIT, STOP_LOSS, LOTE, INITIAL_BALANCE, CREATION_DATE, TIPO_BORRADO, FECHA_BORRADO, ID_INDIVIDUO_PADRE, MONEDA)
    SELECT IND.ID, IND.PARENT_ID_1, IND.PARENT_ID_2, IND.TAKE_PROFIT, IND.STOP_LOSS, IND.LOTE, IND.INITIAL_BALANCE, IND.CREATION_DATE, TIPO_BORRADO, SYSDATE, ID_IND_PADRE, MONEDA
    FROM INDIVIDUO IND WHERE IND.ID=ID_IND_BORRAR;

  INSERT INTO INDICADOR_INDIVIDUO_BORRADO(ID_INDICADOR, ID_INDIVIDUO, INTERVALO_INFERIOR, INTERVALO_SUPERIOR, TIPO)
    SELECT ID_INDICADOR, ID_INDIVIDUO, INTERVALO_INFERIOR, INTERVALO_SUPERIOR, TIPO
    FROM INDICADOR_INDIVIDUO WHERE ID_INDIVIDUO=ID_IND_BORRAR;
  
  DELETE FROM INDICADOR_INDIVIDUO WHERE ID_INDIVIDUO=ID_IND_BORRAR;
  --DELETE FROM INDICADOR_INDIVIDUO_TENDENCIAS WHERE ID_INDIVIDUO=ID_IND_BORRAR;
  DELETE FROM OPERACION_ESTRATEGIA_PERIODO WHERE ID_INDIVIDUO=ID_IND_BORRAR;
  
  DELETE FROM OPERACION_X_SEMANA WHERE ID_INDIVIDUO=ID_IND_BORRAR;
  DELETE FROM OPERACIONES_ACUM_SEMANA_MES WHERE ID_INDIVIDUO=ID_IND_BORRAR;  
  DELETE FROM OPERACIONES_ACUM_SEMANA_ANYO WHERE ID_INDIVIDUO=ID_IND_BORRAR;
  DELETE FROM OPERACIONES_ACUM_SEMANA_CONSOL WHERE ID_INDIVIDUO=ID_IND_BORRAR;
  DELETE FROM PREVIO_TOFILESTRING WHERE ID_INDIVIDUO=ID_IND_BORRAR;  
  
  DELETE FROM INDIVIDUO WHERE ID=ID_IND_BORRAR;  
  
  COMMIT;  
END SMART_DELETE;