SELECT ID_INDIVIDUO, FECHA_HISTORICO, COUNT(*), MAX(FECHA_PROCESO) ,
'DELETE FROM PROCESO WHERE ID_INDIVIDUO='''||ID_INDIVIDUO||
  ''' AND FECHA_HISTORICO=TO_DATE('''||FECHA_HISTORICO||''',''YYYY/MM/DD HH24:MI'')'||
  ' AND TO_CHAR(FECHA_PROCESO,''YYYY/MM/DD HH24:MI'')='''||MAX(FECHA_PROCESO)||''';' SR
FROM PROCESO
GROUP BY ID_INDIVIDUO, FECHA_HISTORICO
HAVING COUNT(*)>1
ORDER BY FECHA_HISTORICO DESC;

SELECT P.*, TO_CHAR(P.FECHA_PROCESO, 'YYYY/MM/DD HH24:MI') FROM FOREX.PROCESO P
WHERE ID_INDIVIDUO IN ('1343965743765.433')
AND FECHA_HISTORICO=TO_DATE('2012/08/15 00:06','YYYY/MM/DD HH24:MI')
 AND TO_CHAR(P.FECHA_PROCESO, 'YYYY/MM/DD HH24:MI')='2013/02/06 16:22'
 ;


