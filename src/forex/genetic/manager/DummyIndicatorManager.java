/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.manager;

import forex.genetic.entities.Interval;
import forex.genetic.manager.indicator.IndicatorManager;
import forex.genetic.entities.Indicator;
import forex.genetic.entities.Point;

/**
 *
 * @author ricardorq85
 */
public class DummyIndicatorManager extends IndicatorManager<Object> {

    public DummyIndicatorManager(boolean priceDependence) {
        super(priceDependence);
    }

    public Indicator generate(Object indicator, Point point) {
        return null;
    }

    public boolean operate(Object objIndividuo, Object obj, Point point) {
        return true;
    }

    public Indicator crossover(Object obj1, Object obj2) {
        return null;
    }

    public Indicator mutate(Object obj) {
        return null;
    }

    @Override
    public Interval calculateInterval(Object individuo, Object indicator, Point point) {
        throw new UnsupportedOperationException("Not supported.");
    }
}