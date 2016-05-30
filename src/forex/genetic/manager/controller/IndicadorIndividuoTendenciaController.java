/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.manager.controller;

import forex.genetic.manager.indicator.PeriodoAgrupadorIndicatorManager;
import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author USER
 */
public class IndicadorIndividuoTendenciaController extends IndicadorController {

    public IndicadorIndividuoTendenciaController() {
        super("INDICADOR_INDIVIDUO_TENDENCIAS");
    }

    @Override
    protected synchronized void load() {
        if (list == null) {
            list = Collections.synchronizedList(new ArrayList());
            list.add(new PeriodoAgrupadorIndicatorManager(1, 10, "AGRUPADOR_HORAS"));//0-Horas
            list.add(new PeriodoAgrupadorIndicatorManager(1, 60, "AGRUPADOR_MINUTOS"));//1-Minutos
            list.add(new PeriodoAgrupadorIndicatorManager(1, 1440 * 10, "RANGO_MINUTOS"));//2-Rango
            list.add(new PeriodoAgrupadorIndicatorManager(50, 1000, "MIN_PIPS_MOVEMENT"));//2-Movimiento minimos de pips
            list.add(new PeriodoAgrupadorIndicatorManager(0, 30, "MIN_CANTIDAD_INDIVIDUOS"));//2-Cantidad de individuos mínimos
        }
    }
}
