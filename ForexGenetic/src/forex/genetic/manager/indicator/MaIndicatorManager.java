/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.manager.indicator;

import forex.genetic.entities.Interval;
import forex.genetic.entities.Point;
import forex.genetic.entities.indicator.Average;
import forex.genetic.entities.indicator.Indicator;

/**
 *
 * @author ricardorq85
 */
public class MaIndicatorManager extends IntervalIndicatorManager<Average> {

	public MaIndicatorManager(boolean priceDependence, boolean obligatory, String name) {
		super(priceDependence, obligatory, name);
	}

	public MaIndicatorManager() {
		super(true, false, "Ma");
		this.id = "MA";
	}

	/**
	 *
	 * @return
	 */
	@Override
	public Average getIndicatorInstance() {
		return new Average("Ma");
	}

	/**
	 *
	 * @param indicator
	 * @param point
	 * @return
	 */
	@Override
	public Indicator generate(Average indicator, Point point) {
		Interval interval = null;
		Average average = getIndicatorInstance();
		if (indicator != null) {
			average.setAverage(indicator.getAverage());
			interval = intervalManager.generate(indicator.getAverage(), point.getLow(), point.getHigh());
		} else {
			interval = intervalManager.generate(Double.NaN, Double.NaN, Double.NaN);
		}
		average.setInterval(interval);

		return average;
	}

	/**
	 *
	 * @param averageIndividuo
	 * @param iAverage
	 * @param currentPoint
	 * @param previousPoint
	 * @return
	 */
	@Override
	public boolean operate(Average averageIndividuo, Average iAverage, Point currentPoint, Point previousPoint) {
		return intervalManager.operate(averageIndividuo.getInterval(), iAverage.getAverage(), currentPoint);
	}

	/**
	 *
	 * @param averageIndividuo
	 * @param iAverage
	 * @param point
	 * @return
	 */
	@Override
	public Interval calculateInterval(Average averageIndividuo, Average iAverage, Point point) {
		return intervalManager.calculateInterval(averageIndividuo.getInterval(), iAverage.getAverage(), point);
	}

	/**
	 *
	 * @param indicator
	 * @param prevPoint
	 * @param point
	 * @return
	 */
	@Override
	public double getValue(Average indicator, Point prevPoint, Point point) {
		double value;
		value = indicator.getAverage();
		return value;
	}

	@Override
	public String[] queryRangoOperacionIndicador() {
		String[] s = new String[2];
		s[0] = " MIN(DH.AVERAGE-OPER.OPEN_PRICE) INF_" + this.id
				+ ",  MAX(DH.AVERAGE-OPER.OPEN_PRICE) SUP_" + this.id + ",  "
				+ " ROUND(AVG(DH.AVERAGE-OPER.OPEN_PRICE), 5) PROM_" + this.id + ", ";
		s[1] = " AND DH.AVERAGE IS NOT NULL ";
		return s;
	}

	@Override
	public String[] queryPorcentajeCumplimientoIndicador() {
		String[] s = new String[1];
		s[0] = " ((DH.AVERAGE-DH.LOW) BETWEEN ? AND ? " + "  OR (DH.AVERAGE-DH.HIGH) BETWEEN ? AND ?) ";
		return s;
	}
}
