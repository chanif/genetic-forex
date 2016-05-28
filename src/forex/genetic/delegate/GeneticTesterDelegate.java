/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.delegate;

import forex.genetic.entities.IndividuoEstrategia;
import forex.genetic.manager.FuncionFortalezaManager;
import forex.genetic.manager.PoblacionManager;
import forex.genetic.manager.PropertiesManager;
import forex.genetic.manager.io.FileOutManager;
import forex.genetic.util.Constants;
import forex.genetic.util.LogUtil;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ricardorq85
 */
public class GeneticTesterDelegate extends GeneticDelegate {

    public GeneticTesterDelegate() {
        super();
    }

    public void process(IndividuoEstrategia individuoEstrategia) {
        FuncionFortalezaManager funcionFortalezaManager = new FuncionFortalezaManager();
        for (int poblacionIndex = PropertiesManager.getPropertyInt(Constants.INITIAL_POBLACION);
                poblacionIndex <= PropertiesManager.getPropertyInt(Constants.END_POBLACION) && !PropertiesManager.getPropertyBoolean(Constants.TERMINAR); poblacionIndex++) {
            LogUtil.logTime("Crear poblacion " + poblacionIndex, 1);
            PoblacionManager poblacionManager = new PoblacionManager();
            poblacionManager.load("" + poblacionIndex, false);
            LogUtil.logTime("Crear poblacion " + poblacionIndex + " Fecha = " + poblacionManager.getDateInterval(), 1);
            /** Se calcula la fortaleza de los individuos */
            LogUtil.logTime("Calcular fortaleza", 1);
            funcionFortalezaManager.calculateFortaleza(poblacionManager.getPoints(), individuoEstrategia,
                    (poblacionIndex == 1),
                    (poblacionIndex > 1), poblacionIndex);
            if ((poblacionIndex > individuoEstrategia.getProcessedUntil())) {
                individuoEstrategia.setProcessedUntil(poblacionIndex);
            }
            super.outIndividuo(individuoEstrategia);
            FileOutManager fileOutManager = new FileOutManager();
            try {
                fileOutManager.write(individuoEstrategia, poblacionManager.getDateInterval(), true, 0);
            } catch (IOException ex) {
                ex.printStackTrace();
            }

        }
    }
}
