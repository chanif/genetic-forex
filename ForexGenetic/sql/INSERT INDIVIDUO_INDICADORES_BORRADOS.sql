SELECT SYSDATE FROM DUAL;
/
DECLARE
BEGIN
  FOR i IN 1..10 LOOP
    INSERT INTO INDIVIDUO_INDICADORES_BORRADOS(ID, PARENT_ID_1, PARENT_ID_2, TAKE_PROFIT, STOP_LOSS, 
				  	LOTE, INITIAL_BALANCE, CREATION_DATE, TIPO_OPERACION,TIPO_INDIVIDUO,MONEDA,
				  	OPEN_INFERIOR_MA,OPEN_SUPERIOR_MA,OPEN_INFERIOR_MACD,OPEN_SUPERIOR_MACD,OPEN_INFERIOR_COMPARE,OPEN_SUPERIOR_COMPARE,OPEN_INFERIOR_ADX,OPEN_SUPERIOR_ADX,OPEN_INFERIOR_BOLLINGER,OPEN_SUPERIOR_BOLLINGER,OPEN_INFERIOR_ICHISIGNAL,OPEN_SUPERIOR_ICHISIGNAL,OPEN_INFERIOR_ICHITREND,OPEN_SUPERIOR_ICHITREND,OPEN_INFERIOR_MOMENTUM,OPEN_SUPERIOR_MOMENTUM,OPEN_INFERIOR_RSI,OPEN_SUPERIOR_RSI,OPEN_INFERIOR_SAR,OPEN_SUPERIOR_SAR,OPEN_INFERIOR_MA1200,OPEN_SUPERIOR_MA1200,OPEN_INFERIOR_MACD20X,OPEN_SUPERIOR_MACD20X,OPEN_INFERIOR_COMPARE1200,OPEN_SUPERIOR_COMPARE1200,OPEN_INFERIOR_ADX168,OPEN_SUPERIOR_ADX168,OPEN_INFERIOR_BOLLINGER240,OPEN_SUPERIOR_BOLLINGER240,OPEN_INFERIOR_ICHISIGNAL6,OPEN_SUPERIOR_ICHISIGNAL6,OPEN_INFERIOR_ICHITREND6,OPEN_SUPERIOR_ICHITREND6,OPEN_INFERIOR_MOMENTUM1200,OPEN_SUPERIOR_MOMENTUM1200,OPEN_INFERIOR_RSI84,OPEN_SUPERIOR_RSI84,OPEN_INFERIOR_SAR1200,OPEN_SUPERIOR_SAR1200, 
    				CLOSE_INFERIOR_MA,CLOSE_SUPERIOR_MA,CLOSE_INFERIOR_MACD,CLOSE_SUPERIOR_MACD,CLOSE_INFERIOR_COMPARE,CLOSE_SUPERIOR_COMPARE,CLOSE_INFERIOR_ADX,CLOSE_SUPERIOR_ADX,CLOSE_INFERIOR_BOLLINGER,CLOSE_SUPERIOR_BOLLINGER,CLOSE_INFERIOR_ICHISIGNAL,CLOSE_SUPERIOR_ICHISIGNAL,CLOSE_INFERIOR_ICHITREND,CLOSE_SUPERIOR_ICHITREND,CLOSE_INFERIOR_MOMENTUM,CLOSE_SUPERIOR_MOMENTUM,CLOSE_INFERIOR_RSI,CLOSE_SUPERIOR_RSI,CLOSE_INFERIOR_SAR,CLOSE_SUPERIOR_SAR,CLOSE_INFERIOR_MA1200,CLOSE_SUPERIOR_MA1200,CLOSE_INFERIOR_MACD20X,CLOSE_SUPERIOR_MACD20X,CLOSE_INFERIOR_COMPARE1200,CLOSE_SUPERIOR_COMPARE1200,CLOSE_INFERIOR_ADX168,CLOSE_SUPERIOR_ADX168,CLOSE_INFERIOR_BOLLINGER240,CLOSE_SUPERIOR_BOLLINGER240,CLOSE_INFERIOR_ICHISIGNAL6,CLOSE_SUPERIOR_ICHISIGNAL6,CLOSE_INFERIOR_ICHITREND6,CLOSE_SUPERIOR_ICHITREND6,CLOSE_INFERIOR_MOMENTUM1200,CLOSE_SUPERIOR_MOMENTUM1200,CLOSE_INFERIOR_RSI84,CLOSE_SUPERIOR_RSI84,CLOSE_INFERIOR_SAR1200,CLOSE_SUPERIOR_SAR1200)
      SELECT IND.ID, IND.PARENT_ID_1, IND.PARENT_ID_2, IND.TAKE_PROFIT, IND.STOP_LOSS, 
            IND.LOTE, IND.INITIAL_BALANCE, IND.CREATION_DATE, IND.TIPO_OPERACION, IND.TIPO_INDIVIDUO, IND.MONEDA,
            OPEN_II_MA.INTERVALO_INFERIOR OPEN_INFERIOR_MA, OPEN_II_MA.INTERVALO_SUPERIOR OPEN_SUPERIOR_MA,
            OPEN_II_MACD.INTERVALO_INFERIOR OPEN_INFERIOR_MACD, OPEN_II_MACD.INTERVALO_SUPERIOR OPEN_SUPERIOR_MACD,
            OPEN_II_COMPARE.INTERVALO_INFERIOR OPEN_INFERIOR_COMPARE, OPEN_II_COMPARE.INTERVALO_SUPERIOR OPEN_SUPERIOR_COMPARE,
            OPEN_II_ADX.INTERVALO_INFERIOR OPEN_INFERIOR_ADX, OPEN_II_ADX.INTERVALO_SUPERIOR OPEN_SUPERIOR_ADX,
            OPEN_II_BOLLINGER.INTERVALO_INFERIOR OPEN_INFERIOR_BOLLINGER, OPEN_II_BOLLINGER.INTERVALO_SUPERIOR OPEN_SUPERIOR_BOLLINGER,
            OPEN_II_ICHISIGNAL.INTERVALO_INFERIOR OPEN_INFERIOR_ICHISIGNAL, OPEN_II_ICHISIGNAL.INTERVALO_SUPERIOR OPEN_SUPERIOR_ICHISIGNAL,
            OPEN_II_ICHITREND.INTERVALO_INFERIOR OPEN_INFERIOR_ICHITREND, OPEN_II_ICHITREND.INTERVALO_SUPERIOR OPEN_SUPERIOR_ICHITREND,
            OPEN_II_MOMENTUM.INTERVALO_INFERIOR OPEN_INFERIOR_MOMENTUM, OPEN_II_MOMENTUM.INTERVALO_SUPERIOR OPEN_SUPERIOR_MOMENTUM,
            OPEN_II_RSI.INTERVALO_INFERIOR OPEN_INFERIOR_RSI, OPEN_II_RSI.INTERVALO_SUPERIOR OPEN_SUPERIOR_RSI,
            OPEN_II_SAR.INTERVALO_INFERIOR OPEN_INFERIOR_SAR, OPEN_II_SAR.INTERVALO_SUPERIOR OPEN_SUPERIOR_SAR,
            OPEN_II_MA1200.INTERVALO_INFERIOR OPEN_INFERIOR_MA1200, OPEN_II_MA1200.INTERVALO_SUPERIOR OPEN_SUPERIOR_MA1200,
            OPEN_II_MACD20X.INTERVALO_INFERIOR OPEN_INFERIOR_MACD20X, OPEN_II_MACD20X.INTERVALO_SUPERIOR OPEN_SUPERIOR_MACD20X,
            OPEN_II_COMPARE1200.INTERVALO_INFERIOR OPEN_INFERIOR_COMPARE1200, OPEN_II_COMPARE1200.INTERVALO_SUPERIOR OPEN_SUPERIOR_COMPARE1200,
            OPEN_II_ADX168.INTERVALO_INFERIOR OPEN_INFERIOR_ADX168, OPEN_II_ADX168.INTERVALO_SUPERIOR OPEN_SUPERIOR_ADX168,
            OPEN_II_BOLLINGER240.INTERVALO_INFERIOR OPEN_INFERIOR_BOLLINGER240, OPEN_II_BOLLINGER240.INTERVALO_SUPERIOR OPEN_SUPERIOR_BOLLINGER240,
            OPEN_II_ICHISIGNAL6.INTERVALO_INFERIOR OPEN_INFERIOR_ICHISIGNAL6, OPEN_II_ICHISIGNAL6.INTERVALO_SUPERIOR OPEN_SUPERIOR_ICHISIGNAL6,
            OPEN_II_ICHITREND6.INTERVALO_INFERIOR OPEN_INFERIOR_ICHITREND6, OPEN_II_ICHITREND6.INTERVALO_SUPERIOR OPEN_SUPERIOR_ICHITREND6,
            OPEN_II_MOMENTUM1200.INTERVALO_INFERIOR OPEN_INFERIOR_MOMENTUM1200, OPEN_II_MOMENTUM1200.INTERVALO_SUPERIOR OPEN_SUPERIOR_MOMENTUM1200,
            OPEN_II_RSI84.INTERVALO_INFERIOR OPEN_INFERIOR_RSI84, OPEN_II_RSI84.INTERVALO_SUPERIOR OPEN_SUPERIOR_RSI84,
            OPEN_II_SAR1200.INTERVALO_INFERIOR OPEN_INFERIOR_SAR1200, OPEN_II_SAR1200.INTERVALO_SUPERIOR OPEN_SUPERIOR_SAR1200,  
            CLOSE_II_MA.INTERVALO_INFERIOR CLOSE_INFERIOR_MA, CLOSE_II_MA.INTERVALO_SUPERIOR CLOSE_SUPERIOR_MA,
            CLOSE_II_MACD.INTERVALO_INFERIOR CLOSE_INFERIOR_MACD, CLOSE_II_MACD.INTERVALO_SUPERIOR CLOSE_SUPERIOR_MACD,
            CLOSE_II_COMPARE.INTERVALO_INFERIOR CLOSE_INFERIOR_COMPARE, CLOSE_II_COMPARE.INTERVALO_SUPERIOR CLOSE_SUPERIOR_COMPARE,
            CLOSE_II_ADX.INTERVALO_INFERIOR CLOSE_INFERIOR_ADX, CLOSE_II_ADX.INTERVALO_SUPERIOR CLOSE_SUPERIOR_ADX,
            CLOSE_II_BOLLINGER.INTERVALO_INFERIOR CLOSE_INFERIOR_BOLLINGER, CLOSE_II_BOLLINGER.INTERVALO_SUPERIOR CLOSE_SUPERIOR_BOLLINGER,
            CLOSE_II_ICHISIGNAL.INTERVALO_INFERIOR CLOSE_INFERIOR_ICHISIGNAL, CLOSE_II_ICHISIGNAL.INTERVALO_SUPERIOR CLOSE_SUPERIOR_ICHISIGNAL,
            CLOSE_II_ICHITREND.INTERVALO_INFERIOR CLOSE_INFERIOR_ICHITREND, CLOSE_II_ICHITREND.INTERVALO_SUPERIOR CLOSE_SUPERIOR_ICHITREND,
            CLOSE_II_MOMENTUM.INTERVALO_INFERIOR CLOSE_INFERIOR_MOMENTUM, CLOSE_II_MOMENTUM.INTERVALO_SUPERIOR CLOSE_SUPERIOR_MOMENTUM,
            CLOSE_II_RSI.INTERVALO_INFERIOR CLOSE_INFERIOR_RSI, CLOSE_II_RSI.INTERVALO_SUPERIOR CLOSE_SUPERIOR_RSI,
            CLOSE_II_SAR.INTERVALO_INFERIOR CLOSE_INFERIOR_SAR, CLOSE_II_SAR.INTERVALO_SUPERIOR CLOSE_SUPERIOR_SAR,
            CLOSE_II_MA1200.INTERVALO_INFERIOR CLOSE_INFERIOR_MA1200, CLOSE_II_MA1200.INTERVALO_SUPERIOR CLOSE_SUPERIOR_MA1200,
            CLOSE_II_MACD20X.INTERVALO_INFERIOR CLOSE_INFERIOR_MACD20X, CLOSE_II_MACD20X.INTERVALO_SUPERIOR CLOSE_SUPERIOR_MACD20X,
            CLOSE_II_COMPARE1200.INTERVALO_INFERIOR CLOSE_INFERIOR_COMPARE1200, CLOSE_II_COMPARE1200.INTERVALO_SUPERIOR CLOSE_SUPERIOR_COMPARE1200,
            CLOSE_II_ADX168.INTERVALO_INFERIOR CLOSE_INFERIOR_ADX168, CLOSE_II_ADX168.INTERVALO_SUPERIOR CLOSE_SUPERIOR_ADX168,
            CLOSE_II_BOLLINGER240.INTERVALO_INFERIOR CLOSE_INFERIOR_BOLLINGER240, CLOSE_II_BOLLINGER240.INTERVALO_SUPERIOR CLOSE_SUPERIOR_BOLLINGER240,
            CLOSE_II_ICHISIGNAL6.INTERVALO_INFERIOR CLOSE_INFERIOR_ICHISIGNAL6, CLOSE_II_ICHISIGNAL6.INTERVALO_SUPERIOR CLOSE_SUPERIOR_ICHISIGNAL6,
            CLOSE_II_ICHITREND6.INTERVALO_INFERIOR CLOSE_INFERIOR_ICHITREND6, CLOSE_II_ICHITREND6.INTERVALO_SUPERIOR CLOSE_SUPERIOR_ICHITREND6,
            CLOSE_II_MOMENTUM1200.INTERVALO_INFERIOR CLOSE_INFERIOR_MOMENTUM1200, CLOSE_II_MOMENTUM1200.INTERVALO_SUPERIOR CLOSE_SUPERIOR_MOMENTUM1200,
            CLOSE_II_RSI84.INTERVALO_INFERIOR CLOSE_INFERIOR_RSI84, CLOSE_II_RSI84.INTERVALO_SUPERIOR CLOSE_SUPERIOR_RSI84,
            CLOSE_II_SAR1200.INTERVALO_INFERIOR CLOSE_INFERIOR_SAR1200, CLOSE_II_SAR1200.INTERVALO_SUPERIOR CLOSE_SUPERIOR_SAR1200                  
            FROM INDIVIDUO_BORRADO IND
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_MA ON IND.ID=OPEN_II_MA.ID_INDIVIDUO AND OPEN_II_MA.ID_INDICADOR='MA' AND OPEN_II_MA.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_MACD ON IND.ID=OPEN_II_MACD.ID_INDIVIDUO AND OPEN_II_MACD.ID_INDICADOR='MACD' AND OPEN_II_MACD.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_COMPARE ON IND.ID=OPEN_II_COMPARE.ID_INDIVIDUO AND OPEN_II_COMPARE.ID_INDICADOR='COMPARE_MA' AND OPEN_II_COMPARE.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_ADX ON IND.ID=OPEN_II_ADX.ID_INDIVIDUO AND OPEN_II_ADX.ID_INDICADOR='ADX' AND OPEN_II_ADX.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_BOLLINGER ON IND.ID=OPEN_II_BOLLINGER.ID_INDIVIDUO AND OPEN_II_BOLLINGER.ID_INDICADOR='BOLLINGER' AND OPEN_II_BOLLINGER.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_ICHISIGNAL ON IND.ID=OPEN_II_ICHISIGNAL.ID_INDIVIDUO AND OPEN_II_ICHISIGNAL.ID_INDICADOR='ICHIMOKU_SIGNAL' AND OPEN_II_ICHISIGNAL.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_ICHITREND ON IND.ID=OPEN_II_ICHITREND.ID_INDIVIDUO AND OPEN_II_ICHITREND.ID_INDICADOR='ICHIMOKU_TREND' AND OPEN_II_ICHITREND.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_MOMENTUM ON IND.ID=OPEN_II_MOMENTUM.ID_INDIVIDUO AND OPEN_II_MOMENTUM.ID_INDICADOR='MOMENTUM' AND OPEN_II_MOMENTUM.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_RSI ON IND.ID=OPEN_II_RSI.ID_INDIVIDUO AND OPEN_II_RSI.ID_INDICADOR='RSI' AND OPEN_II_RSI.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_SAR ON IND.ID=OPEN_II_SAR.ID_INDIVIDUO AND OPEN_II_SAR.ID_INDICADOR='SAR' AND OPEN_II_SAR.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_MA1200 ON IND.ID=OPEN_II_MA1200.ID_INDIVIDUO AND OPEN_II_MA1200.ID_INDICADOR='MA1200' AND OPEN_II_MA1200.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_MACD20X ON IND.ID=OPEN_II_MACD20X.ID_INDIVIDUO AND OPEN_II_MACD20X.ID_INDICADOR='MACD20X' AND OPEN_II_MACD20X.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_COMPARE1200 ON IND.ID=OPEN_II_COMPARE1200.ID_INDIVIDUO AND OPEN_II_COMPARE1200.ID_INDICADOR='COMPARE_MA1200' AND OPEN_II_COMPARE1200.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_ADX168 ON IND.ID=OPEN_II_ADX168.ID_INDIVIDUO AND OPEN_II_ADX168.ID_INDICADOR='ADX168' AND OPEN_II_ADX168.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_BOLLINGER240 ON IND.ID=OPEN_II_BOLLINGER240.ID_INDIVIDUO AND OPEN_II_BOLLINGER240.ID_INDICADOR='BOLLINGER240' AND OPEN_II_BOLLINGER240.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_ICHISIGNAL6 ON IND.ID=OPEN_II_ICHISIGNAL6.ID_INDIVIDUO AND OPEN_II_ICHISIGNAL6.ID_INDICADOR='ICHIMOKU_SIGNAL6' AND OPEN_II_ICHISIGNAL6.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_ICHITREND6 ON IND.ID=OPEN_II_ICHITREND6.ID_INDIVIDUO AND OPEN_II_ICHITREND6.ID_INDICADOR='ICHIMOKU_TREND6' AND OPEN_II_ICHITREND6.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_MOMENTUM1200 ON IND.ID=OPEN_II_MOMENTUM1200.ID_INDIVIDUO AND OPEN_II_MOMENTUM1200.ID_INDICADOR='MOMENTUM1200' AND OPEN_II_MOMENTUM1200.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_RSI84 ON IND.ID=OPEN_II_RSI84.ID_INDIVIDUO AND OPEN_II_RSI84.ID_INDICADOR='RSI84' AND OPEN_II_RSI84.TIPO='OPEN'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO OPEN_II_SAR1200 ON IND.ID=OPEN_II_SAR1200.ID_INDIVIDUO AND OPEN_II_SAR1200.ID_INDICADOR='SAR1200' AND OPEN_II_SAR1200.TIPO='OPEN'                
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_MA ON IND.ID=CLOSE_II_MA.ID_INDIVIDUO AND CLOSE_II_MA.ID_INDICADOR='MA' AND CLOSE_II_MA.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_MACD ON IND.ID=CLOSE_II_MACD.ID_INDIVIDUO AND CLOSE_II_MACD.ID_INDICADOR='MACD' AND CLOSE_II_MACD.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_COMPARE ON IND.ID=CLOSE_II_COMPARE.ID_INDIVIDUO AND CLOSE_II_COMPARE.ID_INDICADOR='COMPARE_MA' AND CLOSE_II_COMPARE.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_ADX ON IND.ID=CLOSE_II_ADX.ID_INDIVIDUO AND CLOSE_II_ADX.ID_INDICADOR='ADX' AND CLOSE_II_ADX.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_BOLLINGER ON IND.ID=CLOSE_II_BOLLINGER.ID_INDIVIDUO AND CLOSE_II_BOLLINGER.ID_INDICADOR='BOLLINGER' AND CLOSE_II_BOLLINGER.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_ICHISIGNAL ON IND.ID=CLOSE_II_ICHISIGNAL.ID_INDIVIDUO AND CLOSE_II_ICHISIGNAL.ID_INDICADOR='ICHIMOKU_SIGNAL' AND CLOSE_II_ICHISIGNAL.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_ICHITREND ON IND.ID=CLOSE_II_ICHITREND.ID_INDIVIDUO AND CLOSE_II_ICHITREND.ID_INDICADOR='ICHIMOKU_TREND' AND CLOSE_II_ICHITREND.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_MOMENTUM ON IND.ID=CLOSE_II_MOMENTUM.ID_INDIVIDUO AND CLOSE_II_MOMENTUM.ID_INDICADOR='MOMENTUM' AND CLOSE_II_MOMENTUM.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_RSI ON IND.ID=CLOSE_II_RSI.ID_INDIVIDUO AND CLOSE_II_RSI.ID_INDICADOR='RSI' AND CLOSE_II_RSI.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_SAR ON IND.ID=CLOSE_II_SAR.ID_INDIVIDUO AND CLOSE_II_SAR.ID_INDICADOR='SAR' AND CLOSE_II_SAR.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_MA1200 ON IND.ID=CLOSE_II_MA1200.ID_INDIVIDUO AND CLOSE_II_MA1200.ID_INDICADOR='MA1200' AND CLOSE_II_MA1200.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_MACD20X ON IND.ID=CLOSE_II_MACD20X.ID_INDIVIDUO AND CLOSE_II_MACD20X.ID_INDICADOR='MACD20X' AND CLOSE_II_MACD20X.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_COMPARE1200 ON IND.ID=CLOSE_II_COMPARE1200.ID_INDIVIDUO AND CLOSE_II_COMPARE1200.ID_INDICADOR='COMPARE_MA1200' AND CLOSE_II_COMPARE1200.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_ADX168 ON IND.ID=CLOSE_II_ADX168.ID_INDIVIDUO AND CLOSE_II_ADX168.ID_INDICADOR='ADX168' AND CLOSE_II_ADX168.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_BOLLINGER240 ON IND.ID=CLOSE_II_BOLLINGER240.ID_INDIVIDUO AND CLOSE_II_BOLLINGER240.ID_INDICADOR='BOLLINGER240' AND CLOSE_II_BOLLINGER240.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_ICHISIGNAL6 ON IND.ID=CLOSE_II_ICHISIGNAL6.ID_INDIVIDUO AND CLOSE_II_ICHISIGNAL6.ID_INDICADOR='ICHIMOKU_SIGNAL6' AND CLOSE_II_ICHISIGNAL6.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_ICHITREND6 ON IND.ID=CLOSE_II_ICHITREND6.ID_INDIVIDUO AND CLOSE_II_ICHITREND6.ID_INDICADOR='ICHIMOKU_TREND6' AND CLOSE_II_ICHITREND6.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_MOMENTUM1200 ON IND.ID=CLOSE_II_MOMENTUM1200.ID_INDIVIDUO AND CLOSE_II_MOMENTUM1200.ID_INDICADOR='MOMENTUM1200' AND CLOSE_II_MOMENTUM1200.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_RSI84 ON IND.ID=CLOSE_II_RSI84.ID_INDIVIDUO AND CLOSE_II_RSI84.ID_INDICADOR='RSI84' AND CLOSE_II_RSI84.TIPO='CLOSE'
              INNER JOIN INDICADOR_INDIVIDUO_BORRADO CLOSE_II_SAR1200 ON IND.ID=CLOSE_II_SAR1200.ID_INDIVIDUO AND CLOSE_II_SAR1200.ID_INDICADOR='SAR1200' AND CLOSE_II_SAR1200.TIPO='CLOSE'    
            WHERE IND.TIPO_OPERACION IS NOT NULL --AND IND.TIPO_BORRADO='SIN_OPERACIONES'
            AND NOT EXISTS (SELECT INDINDIC.ID FROM INDIVIDUO_INDICADORES_BORRADOS INDINDIC WHERE INDINDIC.ID=IND.ID)
            AND ROWNUM<10;
      COMMIT;
    END LOOP;
END;
/
SELECT SYSDATE FROM DUAL;
/
SELECT COUNT(*) FROM INDIVIDUO_INDICADORES_BORRADOS;SELECT SYSDATE FROM DUAL;
/