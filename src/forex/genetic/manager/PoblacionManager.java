/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.manager;

import forex.genetic.util.Constants;
import forex.genetic.entities.DateInterval;
import forex.genetic.manager.indicator.IndicatorManager;
import forex.genetic.entities.indicator.Indicator;
import forex.genetic.entities.IndividuoEstrategia;
import forex.genetic.entities.Learning;
import forex.genetic.entities.Poblacion;
import forex.genetic.entities.Point;
import forex.genetic.util.NumberUtil;
import java.util.Random;
import java.util.List;
import java.util.Vector;

/**
 *
 * @author ricardorq85
 */
public class PoblacionManager {

    private List<Point> points = null;
    private Poblacion poblacion = new Poblacion();
    private DateInterval dateInterval = new DateInterval();

    public PoblacionManager() {
    }

    public void load(String poblacionId) {
        this.load(poblacionId, false);
    }

    public void load(String poblacionId, boolean poblar) {
        this.generatePoints(poblacionId);
        if ((poblar) && (!this.points.isEmpty())) {
            this.generatePoblacionInicial();
        }
    }

    private void generatePoints(String poblacionId) {
        this.points = BasePointManagerFile.process(poblacionId);
        if ((this.points != null) && (!(this.points.isEmpty()))) {
            this.dateInterval.setLowInterval(this.points.get(0).getDate());
            this.dateInterval.setHighInterval(this.points.get(this.points.size() - 1).getDate());
        }
    }

    private void generatePoblacionInicial() {
        poblacion = new Poblacion();
        int initialIndividuos = PropertiesManager.getPropertyInt(Constants.INITIAL_INDIVIDUOS);
        List<IndividuoEstrategia> individuos = new Vector<IndividuoEstrategia>(initialIndividuos);
        IndividuoEstrategia individuo = null;
        Indicator openIndicator = null;
        Indicator closeIndicator = null;

        Random random = new Random();
        int counter = 0;
        Learning learning = LearningManager.learning;
        int minTP = PropertiesManager.getMinTP();
        int maxTP = PropertiesManager.getMaxTP();
        int minSL = PropertiesManager.getMinSL();
        int maxSL = PropertiesManager.getMaxSL();
        if (learning != null) {
            if (learning.getTakeProfitInterval() != null) {
                if (learning.getTakeProfitInterval().getLowInterval() != Integer.MAX_VALUE) {
                    minTP = Math.max(minTP, learning.getTakeProfitInterval().getLowInterval());
                }
                if (learning.getTakeProfitInterval().getHighInterval() != Integer.MIN_VALUE) {
                    maxTP = Math.min(maxTP, learning.getTakeProfitInterval().getHighInterval());
                }
            }
            if (learning.getStopLossInterval() != null) {
                if (learning.getStopLossInterval().getLowInterval() != Integer.MAX_VALUE) {
                    minSL = Math.max(minSL, learning.getStopLossInterval().getLowInterval());
                }
                if (learning.getStopLossInterval().getHighInterval() != Integer.MIN_VALUE) {
                    maxSL = Math.min(maxSL, learning.getStopLossInterval().getHighInterval());
                }
            }
        }
        double minLot = PropertiesManager.getMinLot();
        double maxLot = PropertiesManager.getMaxLot();
        int minBalance = PropertiesManager.getMinBalance();
        int maxBalance = PropertiesManager.getMaxBalance();
        int lotScaleRounding = PropertiesManager.getLotScaleRounding();
        while (counter < initialIndividuos) {
            individuo = new IndividuoEstrategia();

            List<Indicator> openIndicators = null;
            List<Indicator> closeIndicators = null;

            int position = random.nextInt(points.size());
            Point point = points.get(position);
            openIndicators = new Vector<Indicator>(IndicatorManager.getIndicatorNumber());
            closeIndicators = new Vector<Indicator>(IndicatorManager.getIndicatorNumber());
            for (int i = 0; i < IndicatorManager.getIndicatorNumber(); i++) {
                IndicatorManager indicatorManager = IndicatorManager.getInstance(i);
                List<? extends Indicator> indicators = point.getIndicators();
                if (!indicatorManager.isObligatory() && (random.nextDouble() < 0.1)) {
                    openIndicator = null;
                } else if (random.nextDouble() < 0.2) {
                    openIndicator = indicatorManager.generate(null, point);
                } else {
                    openIndicator = indicatorManager.generate(indicators.get(i), point);
                }
                if (!indicatorManager.isObligatory() && (random.nextDouble() < 0.1)) {
                    closeIndicator = null;
                } else if (random.nextDouble() < 0.2) {
                    closeIndicator = indicatorManager.generate(null, point);
                } else {
                    closeIndicator = indicatorManager.generate(indicators.get(i), point);
                }
                openIndicators.add(openIndicator);
                closeIndicators.add(closeIndicator);
            }

            individuo.setOpenIndicators(openIndicators);
            individuo.setCloseIndicators(closeIndicators);
            try {
                individuo.setTakeProfit(minTP + random.nextInt(maxTP - minTP));
                individuo.setStopLoss(minSL + random.nextInt(maxSL - minSL));
                individuo.setLot(NumberUtil.round(minLot + random.nextDouble() * (maxLot - minLot), lotScaleRounding));
                individuo.setInitialBalance(minBalance + random.nextInt(maxBalance - minBalance));
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (!individuos.contains(individuo)) {
                individuos.add(individuo);
            }
            counter++;
        }
        poblacion.setIndividuos(individuos);
    }

    public Poblacion getPoblacion() {
        return poblacion;
    }

    public void setPoblacion(Poblacion poblacion) {
        this.poblacion = poblacion;
    }

    public List<Point> getPoints() {
        return points;
    }

    public void setPoints(List<Point> points) {
        this.points = points;
    }

    public DateInterval getDateInterval() {
        return dateInterval;
    }

    public void setDateInterval(DateInterval dateInterval) {
        this.dateInterval = dateInterval;
    }

    @Override
    protected void finalize() throws Throwable {
        super.finalize();
    }
}
