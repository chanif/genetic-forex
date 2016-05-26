/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.manager;

import forex.genetic.entities.Indicator;
import forex.genetic.entities.IndividuoEstrategia;
import forex.genetic.entities.Poblacion;
import java.util.List;
import java.util.Random;
import java.util.Vector;
import static forex.genetic.util.Constants.*;

/**
 *
 * @author ricardorq85
 */
public class MutationManager {

    private EspecificMutationManager especificMutationManager = EspecificMutationManager.getInstance();

    public Poblacion[] mutate(Poblacion poblacion, int percentValue) {
        Poblacion[] poblacionArray = new Poblacion[2];
        FuncionFortalezaManager fortalezaManager = new FuncionFortalezaManager();
        PoblacionManager poblacionManager = PoblacionManager.getInstance();
        Poblacion parentsPoblacion = new Poblacion();
        Poblacion mutatedPoblacion = new Poblacion();
        List<IndividuoEstrategia> parents = new Vector<IndividuoEstrategia>();
        List<IndividuoEstrategia> hijos = new Vector<IndividuoEstrategia>();

        Random random = new Random();
        List<IndividuoEstrategia> individuos = poblacion.getIndividuos();
        int size = individuos.size();
        int counter = 0;

        while (counter < percentValue) {
            int pos1 = random.nextInt(size);
            IndividuoEstrategia individuo1 = individuos.get(pos1);

            IndividuoEstrategia hijo = new IndividuoEstrategia(individuo1, null, IndividuoType.MUTATION);
            List<Indicator> openIndicators = new Vector<Indicator>(INDICATOR_NUMBER);
            List<Indicator> closeIndicators = new Vector<Indicator>(INDICATOR_NUMBER);
            for (int i = 0; i < individuo1.getOpenIndicators().size(); i++) {
                Indicator openIndicator = individuo1.getOpenIndicators().get(i);
                IndicatorManager indicatorManager = IndicatorManager.getInstance(i);
                if (random.nextDouble() < 0.3) {
                    openIndicators.add(null);
                } else {
                    if (openIndicator == null) {
                        openIndicators.add(null);
                    } else {
                        Indicator indHijo = indicatorManager.mutate(openIndicator);
                        openIndicators.add(indHijo);
                    }
                }
                Indicator closeIndicator = individuo1.getCloseIndicators().get(i);
                if (random.nextDouble() < 0.3) {
                    closeIndicators.add(null);
                } else {
                    if (closeIndicator == null) {
                        closeIndicators.add(null);
                    } else {
                        Indicator indHijo = indicatorManager.mutate(closeIndicator);
                        closeIndicators.add(indHijo);
                    }
                }
            }
            hijo.setOpenIndicators(openIndicators);
            hijo.setCloseIndicators(closeIndicators);

            double tp1 = individuo1.getTakeProfit();
            double tpHijo = especificMutationManager.mutate(tp1, MIN_TP, MAX_TP);
            hijo.setTakeProfit(tpHijo);

            double sl1 = individuo1.getStopLoss();
            double slHijo = especificMutationManager.mutate(sl1, MIN_SL, MAX_SL);
            hijo.setStopLoss(slHijo);

            int lot1 = individuo1.getLot();
            int lotHijo = especificMutationManager.mutate(lot1, MIN_LOT, MAX_LOT);
            hijo.setLot(lotHijo);

            if (!hijos.contains(hijo)) {
                parents.add(individuo1);
                hijos.add(hijo);
                fortalezaManager.calculateFortaleza(poblacionManager.getPoints(), hijo);
            }
            counter++;
        }
        parentsPoblacion.setIndividuos(parents);
        mutatedPoblacion.setIndividuos(hijos);
        poblacionArray[0] = parentsPoblacion;
        poblacionArray[1] = mutatedPoblacion;

        return poblacionArray;
    }
}