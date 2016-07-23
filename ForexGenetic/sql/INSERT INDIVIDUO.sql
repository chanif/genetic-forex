
Insert into INDIVIDUO
  (ID,PARENT_ID_1,PARENT_ID_2,TAKE_PROFIT,STOP_LOSS,LOTE,INITIAL_BALANCE,CREATION_DATE) 
values ((TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  null,null,'442','591','0,1','2000',SYSDATE);

Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('ADX',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  -777.8506,-199.77279,'OPEN');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('BOLLINGER',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  0.0011,0.0012,'OPEN');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('COMPARE_MA',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  0.00007,0.07000,'OPEN');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('ICHIMOKU_SIGNAL',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  null,null,'OPEN');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('ICHIMOKU_TREND',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  null,null,'OPEN');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('MA',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  -0.00886,-0.00027,'OPEN');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('MACD',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  NULL, NULL,'OPEN');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('MOMENTUM',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  NULL, NULL,'OPEN');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('RSI',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  NULL, NULL,'OPEN');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('SAR',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  NULL,NULL,'OPEN');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('ADX',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  NULL,NULL,'CLOSE');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('BOLLINGER',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  NULL,NULL,'CLOSE');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('COMPARE_MA',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  NULL,NULL,'CLOSE');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('ICHIMOKU_SIGNAL',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  null,null,'CLOSE');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('ICHIMOKU_TREND',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  null,null,'CLOSE');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('MA',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  NULL,NULL,'CLOSE');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('MACD',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  NULL,NULL,'CLOSE');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('MOMENTUM',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  NULL,NULL,'CLOSE');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('RSI',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  null,null,'CLOSE');
Insert into INDICADOR_INDIVIDUO (ID_INDICADOR,ID_INDIVIDUO,INTERVALO_INFERIOR,INTERVALO_SUPERIOR,TIPO) 
  values ('SAR',(TRUNC(SYSDATE) - TO_DATE('1970/01/01', 'YYYY/MM/DD'))*24*60*60*1000||'.26',
  null,null,'CLOSE');

COMMIT;