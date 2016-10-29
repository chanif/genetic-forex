INSERT INTO PREVIO_TOFILESTRING(ID_INDIVIDUO, FECHA_SEMANA, PIPS_SEMANA, PIPS_MES, PIPS_ANYO, PIPS_TOTALES, TIPO_OPERACION, FECHA_HISTORICO,
					R_COUNT_SEMANA,R2_SEMANA,PENDIENTE_SEMANA,INTERCEPCION_SEMANA,R_COUNT_MES,R2_MES,PENDIENTE_MES,INTERCEPCION_MES,R_COUNT_ANYO,R2_ANYO,PENDIENTE_ANYO,INTERCEPCION_ANYO,
				 R_COUNT_CONSOL,R2_CONSOL,PENDIENTE_CONSOL,INTERCEPCION_CONSOL)
				 SELECT IND.ID ID_INDIVIDUO, SEMANAS.FECHA_SEMANA, OPER_SEMANA.PIPS PIPS_SEMANA, 
				   OPER_MES.PIPS PIPS_MES, OPER_ANYO.PIPS PIPS_ANYO, OPER.PIPS PIPS_TOTALES, IND.TIPO_OPERACION, 
				   OPER_MES.FECHA_HISTORICO, OPER_SEMANA.R_COUNT R_COUNT_SEMANA, OPER_SEMANA.R2 R2_SEMANA,  
				   OPER_SEMANA.PENDIENTE PENDIENTE_SEMANA, OPER_SEMANA.INTERCEPCION INTERCEPCION_SEMANA, 
				   OPER_MES.R_COUNT R_COUNT_MES, OPER_MES.R2 R2_MES, OPER_MES.PENDIENTE PENDIENTE_MES, 
				  OPER_MES.INTERCEPCION INTERCEPCION_MES, OPER_ANYO.R_COUNT R_COUNT_ANYO, OPER_ANYO.R2 R2_ANYO, 
				   OPER_ANYO.PENDIENTE PENDIENTE_ANYO, OPER_ANYO.INTERCEPCION INTERCEPCION_ANYO, OPER.R_COUNT R_COUNT_CONSOL, 
				  OPER.R2 R2_CONSOL, OPER.PENDIENTE PENDIENTE_CONSOL, OPER.INTERCEPCION INTERCEPCION_CONSOL
				 FROM SEMANAS
				   INNER JOIN INDIVIDUO IND ON IND.ID='1469622989774.12'
				   LEFT JOIN OPERACION_X_SEMANA OPER_SEMANA
				     ON SEMANAS.FECHA_SEMANA=OPER_SEMANA.FECHA_SEMANA+7 AND OPER_SEMANA.ID_INDIVIDUO=IND.ID
				   INNER JOIN OPERACIONES_ACUM_SEMANA_MES OPER_MES
				    ON OPER_MES.ID_INDIVIDUO=IND.ID AND OPER_MES.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7
				   INNER JOIN OPERACIONES_ACUM_SEMANA_ANYO OPER_ANYO
				  ON OPER_ANYO.ID_INDIVIDUO=IND.ID AND OPER_ANYO.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7
				   INNER JOIN OPERACIONES_ACUM_SEMANA_CONSOL OPER
				   ON OPER.ID_INDIVIDUO=IND.ID AND OPER.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7
				 WHERE NOT EXISTS (SELECT 1 FROM PREVIO_TOFILESTRING OPC WHERE OPC.ID_INDIVIDUO=OPER_MES.ID_INDIVIDUO)