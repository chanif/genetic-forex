/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.manager.indicator;

import forex.genetic.entities.DoubleInterval;
import forex.genetic.entities.Interval;
import forex.genetic.entities.Point;
import forex.genetic.entities.indicator.Indicator;
import forex.genetic.entities.indicator.IntervalIndicator;
import forex.genetic.entities.indicator.PeriodoAgrupador;
import forex.genetic.manager.EqualIntervalManager;
import java.util.Random;

/**
 *
 * @author ricardorq85
 */
public class PeriodoAgrupadorIndicatorManager extends IntervalIndicatorManager<PeriodoAgrupador> {

    private final int maximo;
    private final Random random = new Random();

    public PeriodoAgrupadorIndicatorManager(int minimo, int maximo, String name) {
        super();
        EqualIntervalManager intervManager = new EqualIntervalManager(name);
        intervManager.setMin(minimo);
        intervManager.setMax(maximo);
        this.setIntervalManager(intervManager);
        this.id = name;
        this.maximo = maximo;
    }

    @Override
    public PeriodoAgrupador getIndicatorInstance() {
        return new PeriodoAgrupador(this.id);
    }

    @Override
    public Indicator generate(PeriodoAgrupador indicator, Point point) {
        Interval interval;
        PeriodoAgrupador periodoAgrupador = getIndicatorInstance();
        double value = random.nextInt(maximo) + 1;
        interval = new DoubleInterval(this.id, value, value);
        periodoAgrupador.setInterval(interval);
        return periodoAgrupador;
    }

    @Override
    public double getValue(PeriodoAgrupador indicator, Point prevPoint, Point point) {
        return maximo;
    }

    @Override
    public Indicator mutate(PeriodoAgrupador obj) {
        IntervalIndicator intervalIndicator = (IntervalIndicator) super.mutate(obj);
        if ((intervalIndicator == null) || (intervalIndicator.getInterval() == null)
                || (intervalIndicator.getInterval().getLowInterval() == null)
                || (intervalIndicator.getInterval().getHighInterval() == null)) {
            return null;
        }
        return intervalIndicator;
    }

    @Override
    public Indicator crossover(PeriodoAgrupador obj1, PeriodoAgrupador obj2) {
        IntervalIndicator intervalIndicator = (IntervalIndicator) super.crossover(obj1, obj2);
        if ((intervalIndicator == null) || (intervalIndicator.getInterval() == null)
                || (intervalIndicator.getInterval().getLowInterval() == null)
                || (intervalIndicator.getInterval().getHighInterval() == null)) {
            return null;
        }
        return intervalIndicator;
    }

}
