/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.factory;

import forex.genetic.manager.controller.GeneticController;
import forex.genetic.manager.controller.GeneticIndividuoController;
import forex.genetic.manager.controller.GeneticIndividuoTendenciaController;
import forex.genetic.manager.controller.IndicadorController;
import forex.genetic.manager.controller.IndicadorIndividuoController;
import forex.genetic.manager.controller.IndicadorIndividuoTendenciaController;

/**
 *
 * @author USER
 */
public class ControllerFactory {

    public enum ControllerType {

        Individuo,
        IndividuoTendencia;
    }

    public static IndicadorController createIndicadorController(ControllerType type) {
        if (type == null) {
            return null;
        }
        if (ControllerType.Individuo.equals(type)) {
            return new IndicadorIndividuoController();
        } else if (ControllerType.IndividuoTendencia.equals(type)) {
            return new IndicadorIndividuoTendenciaController();
        } else {
            return null;
        }
    }

    public static GeneticController createGeneticController(ControllerType type) {
        if (type == null) {
            return null;
        }
        if (ControllerType.Individuo.equals(type)) {
            return new GeneticIndividuoController();
        } else if (ControllerType.IndividuoTendencia.equals(type)) {
            return new GeneticIndividuoTendenciaController();
        } else {
            return null;
        }
    }
}