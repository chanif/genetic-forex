/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import forex.genetic.entities.Individuo;
import forex.genetic.util.jdbc.JDBCUtil;

/**
 *
 * @author ricardorq85
 */
public class OperacionSemanalDAO {

	protected Connection connection = null;

	public OperacionSemanalDAO(Connection connection) {
		this.connection = connection;
	}

	public int deleteOperacionesSemana(Individuo individuo, String tabla) throws SQLException {
		String sql = "DELETE FROM " + tabla + " OPER WHERE OPER.ID_INDIVIDUO IN ("
				+ " SELECT P.ID_INDIVIDUO FROM PROCESO P"
				+ " WHERE P.ID_INDIVIDUO=OPER.ID_INDIVIDUO AND P.FECHA_HISTORICO>OPER.FECHA_HISTORICO)"
				+ " AND ID_INDIVIDUO=?";
		PreparedStatement stmt = null;
		try {
			stmt = this.connection.prepareStatement(sql);
			stmt.setString(1, individuo.getId());
			return stmt.executeUpdate();
		} finally {
			JDBCUtil.close(stmt);
		}
	}

	public int insertOperacionesSemana(Individuo individuo) throws SQLException {
		String sql = "INSERT INTO OPERACION_X_SEMANA (ID_INDIVIDUO, FECHA_HISTORICO, PIPS, CANTIDAD, FECHA_SEMANA, R_COUNT, R2, PENDIENTE, INTERCEPCION) "
				+ " SELECT AC2.ID_INDIVIDUO, AC2.FECHA_HISTORICO,"
				+ "  AC2.PIPS PIPS, AC2.CANTIDAD, AC2.FECHA_SEMANA, AC2.R_COUNT, AC2.R2, AC2.PENDIENTE, AC2.INTERCEPCION"
				+ " FROM ("
				+ "   SELECT AC.ID_INDIVIDUO, AC.FECHA_SEMANA, AC.FECHA_CIERRE, AC.PIPS, AC.CANTIDAD, "
				+ "     AC.MAXFE, AC.FECHA_HISTORICO,"
				+ "     REGR_COUNT(AC.PIPS, AC.FECHA_CIERRE-AC.FECHA_HISTORICO) "
				+ "       OVER (PARTITION BY TRUNC((AC.FECHA_CIERRE),'IW') ORDER BY AC.FECHA_CIERRE ASC) R_COUNT,"
				+ "     ROUND(REGR_R2((AC.PIPS), AC.FECHA_CIERRE-AC.FECHA_HISTORICO) "
				+ "       OVER (PARTITION BY TRUNC((AC.FECHA_CIERRE),'IW') ORDER BY AC.FECHA_CIERRE ASC),5) R2,"
				+ "     ROUND(REGR_SLOPE(AC.PIPS, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)"
				+ "       OVER (PARTITION BY TRUNC((AC.FECHA_CIERRE),'IW') ORDER BY AC.FECHA_CIERRE ASC),5) PENDIENTE,"
				+ "     ROUND(REGR_INTERCEPT(AC.PIPS, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)"
				+ "       OVER (PARTITION BY TRUNC((AC.FECHA_CIERRE),'IW') ORDER BY AC.FECHA_CIERRE ASC),5) INTERCEPCION"
				+ "   FROM (SELECT OPER.ID_INDIVIDUO, TRUNC((OPER.FECHA_CIERRE),'IW') FECHA_SEMANA, OPER.FECHA_CIERRE, "
				+ "      SUM(OPER.PIPS) OVER (PARTITION BY TRUNC((OPER.FECHA_CIERRE),'IW') ORDER BY OPER.FECHA_CIERRE) PIPS,"
				+ "       COUNT(OPER.PIPS) OVER (PARTITION BY TRUNC((OPER.FECHA_CIERRE),'IW') ORDER BY OPER.FECHA_CIERRE) CANTIDAD,"
				+ "       MAX(OPER.FECHA_CIERRE) OVER (PARTITION BY TRUNC((OPER.FECHA_CIERRE),'IW')) MAXFE,"
				+ "       P.FECHA_HISTORICO"
				+ "     FROM OPERACION OPER"
				+ "     INNER JOIN PROCESO P ON P.ID_INDIVIDUO=OPER.ID_INDIVIDUO"
				+ "     WHERE OPER.FECHA_CIERRE IS NOT NULL AND OPER.ID_INDIVIDUO=?"
				+ "   ) AC) AC2"
				+ "   INNER JOIN INDIVIDUO IND ON IND.ID=AC2.ID_INDIVIDUO AND IND.TIPO_INDIVIDUO = 'INDICADORES'"
				+ "   WHERE NOT EXISTS (SELECT 1 FROM OPERACION_X_SEMANA OPC WHERE OPC.ID_INDIVIDUO=AC2.ID_INDIVIDUO)"
				+ "     AND AC2.MAXFE=AC2.FECHA_CIERRE";

		PreparedStatement stmt = null;
		try {
			stmt = this.connection.prepareStatement(sql);
			stmt.setString(1, individuo.getId());
			return stmt.executeUpdate();
		} finally {
			JDBCUtil.close(stmt);
		}
	}

	public synchronized int insertSemanas(Individuo individuo) throws SQLException {
		String sql = "INSERT INTO SEMANAS(FECHA_SEMANA) SELECT DISTINCT SEM.FECHA_SEMANA+7"
				+ " FROM OPERACION_X_SEMANA SEM WHERE SEM.ID_INDIVIDUO=?"
				+ " AND SEM.FECHA_SEMANA+7 NOT IN(SELECT S.FECHA_SEMANA FROM SEMANAS S)";

		PreparedStatement stmt = null;
		try {
			stmt = this.connection.prepareStatement(sql);
			stmt.setString(1, individuo.getId());
			return stmt.executeUpdate();
		} finally {
			JDBCUtil.close(stmt);
		}
	}

	public int insertOperacionesSemanaAcumuladas(Individuo individuo, String tabla, int pipsMinimos,
			int mesesRetroceso) throws SQLException {
		String sql = "INSERT INTO " + tabla + " (ID_INDIVIDUO, FECHA_SEMANA, PIPS, CANTIDAD, FECHA_HISTORICO, R_COUNT, R2, PENDIENTE, INTERCEPCION)"
				+ " SELECT AC2.ID_INDIVIDUO, AC2.FECHA_SEMANA, AC2.PIPS PIPS, AC2.CANTIDAD, AC2.FECHA_HISTORICO,"
				+ "   AC2.R_COUNT, AC2.R2, AC2.PENDIENTE, AC2.INTERCEPCION"
				+ " FROM (SELECT AC.ID_INDIVIDUO, AC.FECHA_SEMANA, AC.FECHA_CIERRE, AC.PIPS, AC.CANTIDAD, AC.MAXFE, AC.FECHA_HISTORICO,"
				+ "     REGR_COUNT(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)"
				+ "       OVER (ORDER BY AC.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '"+ mesesRetroceso +"' MONTH PRECEDING AND CURRENT ROW) R_COUNT,"
				+ "     ROUND(REGR_R2(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)"
				+ "       OVER (ORDER BY AC.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '"+ mesesRetroceso +"' MONTH PRECEDING AND CURRENT ROW),5) R2,"
				+ "     ROUND(REGR_SLOPE(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)"
				+ "       OVER (ORDER BY AC.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '"+ mesesRetroceso +"' MONTH PRECEDING AND CURRENT ROW),5) PENDIENTE,"
				+ "     ROUND(REGR_INTERCEPT(AC.PIPS_REGR, AC.FECHA_CIERRE-AC.FECHA_HISTORICO)"
				+ "       OVER (ORDER BY AC.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '"+ mesesRetroceso +"' MONTH PRECEDING AND CURRENT ROW),5) INTERCEPCION"
				+ "   FROM ( SELECT MAX(OPER.ID_INDIVIDUO) OVER () ID_INDIVIDUO, SEMANAS.FECHA_SEMANA  FECHA_SEMANA, "
				+ "       NVL(OPER.FECHA_CIERRE,SEMANAS.FECHA_SEMANA) FECHA_CIERRE,"
				+ "       NVL(SUM(OPER.PIPS) OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC RANGE BETWEEN INTERVAL '"+ mesesRetroceso +"' MONTH PRECEDING AND CURRENT ROW),0) PIPS,"
				+ "       NVL(SUM(OPER.PIPS) OVER (ORDER BY OPER.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '"+ mesesRetroceso +"' MONTH PRECEDING AND CURRENT ROW),0) PIPS_REGR,"
				+ "       COUNT(OPER.PIPS) OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC RANGE BETWEEN INTERVAL '"+ mesesRetroceso +"' MONTH PRECEDING AND CURRENT ROW) CANTIDAD,"
				+ "       COUNT(OPER.PIPS) OVER (ORDER BY OPER.FECHA_CIERRE ASC RANGE BETWEEN INTERVAL '"+ mesesRetroceso +"' MONTH PRECEDING AND CURRENT ROW) CANTIDAD_REGR,"
				+ "       NVL(MIN(OPER.FECHA_CIERRE) OVER (ORDER BY SEMANAS.FECHA_SEMANA ASC RANGE BETWEEN INTERVAL '"+ mesesRetroceso +"' MONTH PRECEDING AND CURRENT ROW),SEMANAS.FECHA_SEMANA-7) MINFE,"
				+ "       NVL(MAX(OPER.FECHA_CIERRE) OVER (PARTITION BY SEMANAS.FECHA_SEMANA), SEMANAS.FECHA_SEMANA) MAXFE,"
				+ "       MAX(P.FECHA_HISTORICO) OVER () FECHA_HISTORICO"
				+ "     FROM SEMANAS "
				+ "     LEFT JOIN OPERACION OPER ON SEMANAS.FECHA_SEMANA=TRUNC((OPER.FECHA_CIERRE),'IW') "
				+ "       AND OPER.ID_INDIVIDUO=? AND OPER.FECHA_CIERRE IS NOT NULL"
				+ "     LEFT JOIN PROCESO P ON P.ID_INDIVIDUO=OPER.ID_INDIVIDUO"
				+ "   ) AC ORDER BY AC.FECHA_SEMANA ASC) AC2"
				+ "   INNER JOIN INDIVIDUO IND ON IND.ID=AC2.ID_INDIVIDUO AND IND.TIPO_INDIVIDUO = 'INDICADORES'"
				+ "   WHERE NOT EXISTS (SELECT 1 FROM " + tabla + " OPC WHERE OPC.ID_INDIVIDUO=AC2.ID_INDIVIDUO)"
				+ "     AND AC2.MAXFE=AC2.FECHA_CIERRE"
				+ "     AND AC2.FECHA_SEMANA>=TO_DATE('2012/01/01', 'YYYY/MM/DD') AND AC2.PIPS>? ";

		PreparedStatement stmt = null;
		try {
			stmt = this.connection.prepareStatement(sql);			
			stmt.setString(1, individuo.getId());
			stmt.setInt(2, pipsMinimos);
			return stmt.executeUpdate();
		} finally {
			JDBCUtil.close(stmt);
		}
	}

	public int insertOperacionesSemanaPrevio(Individuo individuo) throws SQLException {
		String sql = "INSERT INTO PREVIO_TOFILESTRING(ID_INDIVIDUO, FECHA_SEMANA, PIPS_SEMANA, PIPS_MES, PIPS_ANYO, PIPS_TOTALES, TIPO_OPERACION, FECHA_HISTORICO,"
				+ "	R_COUNT_SEMANA,R2_SEMANA,PENDIENTE_SEMANA,INTERCEPCION_SEMANA,R_COUNT_MES,R2_MES,PENDIENTE_MES,INTERCEPCION_MES,R_COUNT_ANYO,R2_ANYO,PENDIENTE_ANYO,INTERCEPCION_ANYO,"
				+ " R_COUNT_CONSOL,R2_CONSOL,PENDIENTE_CONSOL,INTERCEPCION_CONSOL)"
				+ " SELECT IND.ID ID_INDIVIDUO, SEMANAS.FECHA_SEMANA, OPER_SEMANA.PIPS PIPS_SEMANA, "
				+ "   OPER_MES.PIPS PIPS_MES, OPER_ANYO.PIPS PIPS_ANYO, OPER.PIPS PIPS_TOTALES, IND.TIPO_OPERACION, "
				+ "   OPER_MES.FECHA_HISTORICO, OPER_SEMANA.R_COUNT R_COUNT_SEMANA, OPER_SEMANA.R2 R2_SEMANA,  "
				+ "   OPER_SEMANA.PENDIENTE PENDIENTE_SEMANA, OPER_SEMANA.INTERCEPCION INTERCEPCION_SEMANA, "
				+ "   OPER_MES.R_COUNT R_COUNT_MES, OPER_MES.R2 R2_MES, OPER_MES.PENDIENTE PENDIENTE_MES, "
				+ "  OPER_MES.INTERCEPCION INTERCEPCION_MES, OPER_ANYO.R_COUNT R_COUNT_ANYO, OPER_ANYO.R2 R2_ANYO, "
				+ "   OPER_ANYO.PENDIENTE PENDIENTE_ANYO, OPER_ANYO.INTERCEPCION INTERCEPCION_ANYO, OPER.R_COUNT R_COUNT_CONSOL, "
				+ "  OPER.R2 R2_CONSOL, OPER.PENDIENTE PENDIENTE_CONSOL, OPER.INTERCEPCION INTERCEPCION_CONSOL"
				+ " FROM SEMANAS"
				+ "   INNER JOIN INDIVIDUO IND ON IND.ID=?"
				+ "   LEFT JOIN OPERACION_X_SEMANA OPER_SEMANA"
				+ "     ON SEMANAS.FECHA_SEMANA=OPER_SEMANA.FECHA_SEMANA+7 AND OPER_SEMANA.ID_INDIVIDUO=IND.ID"
				+ "   INNER JOIN OPERACIONES_ACUM_SEMANA_MES OPER_MES"
				+ "    ON OPER_MES.ID_INDIVIDUO=IND.ID AND OPER_MES.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7"
				+ "   INNER JOIN OPERACIONES_ACUM_SEMANA_ANYO OPER_ANYO"
				+ "  ON OPER_ANYO.ID_INDIVIDUO=IND.ID AND OPER_ANYO.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7"
				+ "   INNER JOIN OPERACIONES_ACUM_SEMANA_CONSOL OPER"
				+ "   ON OPER.ID_INDIVIDUO=IND.ID AND OPER.FECHA_SEMANA=SEMANAS.FECHA_SEMANA-7"
				+ " WHERE NOT EXISTS (SELECT 1 FROM PREVIO_TOFILESTRING OPC WHERE OPC.ID_INDIVIDUO=OPER_MES.ID_INDIVIDUO)";

		PreparedStatement stmt = null;
		try {
			stmt = this.connection.prepareStatement(sql);
			stmt.setString(1, individuo.getId());
			return stmt.executeUpdate();
		} finally {
			JDBCUtil.close(stmt);
		}
	}

}
