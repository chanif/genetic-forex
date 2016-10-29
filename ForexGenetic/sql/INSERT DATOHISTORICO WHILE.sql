DECLARE
FECHA_BORRADO DATE;
FECHA_MAXIMA DATE;
BEGIN
  SELECT NVL(MAX(FECHA), TO_DATE('20080501', 'YYYYMMDD')) INTO FECHA_BORRADO FROM DATOHISTORICO;
  SELECT MAX(FECHA) INTO FECHA_MAXIMA FROM DH_TEMPORAL;
  WHILE (FECHA_BORRADO<=FECHA_MAXIMA) LOOP
    INSERT INTO DATOHISTORICO(PAR, MINUTOS, PAR_COMPARE, FECHA, OPEN, LOW, HIGH, CLOSE, VOLUME, SPREAD, AVERAGE, MACD_VALUE, MACD_SIGNAL, COMPARE_VALUE, AVERAGE_COMPARE, SAR, ADX_VALUE, ADX_PLUS, ADX_MINUS, RSI, BOLLINGER_UPPER, BOLLINGER_LOWER, MOMENTUM, ICHIMOKUTENKANSEN, ICHIMOKUKIJUNSEN, ICHIMOKUSENKOUSPANA, ICHIMOKUSENKOUSPANB, ICHIMOKUCHINKOUSPAN, MA1200, MACD20X_VALUE, MACD20X_SIGNAL, AVERAGE_COMPARE1200, SAR1200, ADX_VALUE168, ADX_PLUS168, ADX_MINUS168, RSI84, BOLLINGER_UPPER240, BOLLINGER_LOWER240, MOMENTUM1200, ICHIMOKUTENKANSEN6, ICHIMOKUKIJUNSEN6, ICHIMOKUSENKOUSPANA6, ICHIMOKUSENKOUSPANB6, ICHIMOKUCHINKOUSPAN6)
      SELECT PAR, MINUTOS, PAR_COMPARE, FECHA, OPEN, LOW, HIGH, CLOSE, VOLUME, SPREAD, AVERAGE, MACD_VALUE, MACD_SIGNAL, COMPARE_VALUE, AVERAGE_COMPARE, SAR, ADX_VALUE, ADX_PLUS, ADX_MINUS, RSI, BOLLINGER_UPPER, BOLLINGER_LOWER, MOMENTUM, ICHIMOKUTENKANSEN, ICHIMOKUKIJUNSEN, ICHIMOKUSENKOUSPANA, ICHIMOKUSENKOUSPANB, ICHIMOKUCHINKOUSPAN, MA1200, MACD20X_VALUE, MACD20X_SIGNAL, AVERAGE_COMPARE1200, SAR1200, ADX_VALUE168, ADX_PLUS168, ADX_MINUS168, RSI84, BOLLINGER_UPPER240, BOLLINGER_LOWER240, MOMENTUM1200, ICHIMOKUTENKANSEN6, ICHIMOKUKIJUNSEN6, ICHIMOKUSENKOUSPANA6, ICHIMOKUSENKOUSPANB6, ICHIMOKUCHINKOUSPAN6
      FROM DH_TEMPORAL DH WHERE FECHA>FECHA_BORRADO AND FECHA<FECHA_BORRADO + 3;
    COMMIT;
    FECHA_BORRADO := FECHA_BORRADO + 3;
  END LOOP;
END;