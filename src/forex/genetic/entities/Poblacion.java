/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.entities;

import forex.genetic.manager.PropertiesManager;
import forex.genetic.util.CollectionUtil;
import forex.genetic.util.Constants;
import forex.genetic.util.Constants.OperationType;
import java.io.Serializable;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Vector;

/**
 *
 * @author ricardorq85
 */
public class Poblacion implements Serializable {

    public static final long serialVersionUID = 201101251800L;
    private List<IndividuoEstrategia> individuos = new Vector<IndividuoEstrategia>();
    private OperationType operationType = null;
    private String pair = null;
    private int riskLevel = 0;
    private double dRiskLevel = Constants.MAX_RISK_LEVEL;

    public Poblacion() {
        this.operationType = PropertiesManager.getOperationType();
        this.pair = PropertiesManager.getPair();
        setRiskLevel(PropertiesManager.getRiskLevel() / dRiskLevel);
        if (riskLevel != 0) {
            setRiskLevel(riskLevel);
        }
    }

    public double getRiskLevel() {
        return dRiskLevel;
    }

    public void setRiskLevel(double riskLevel) {
        this.dRiskLevel = riskLevel;
    }

    public String getPair() {
        return pair;
    }

    public void setPair(String pair) {
        this.pair = pair;
    }

    public OperationType getOperationType() {
        return operationType;
    }

    public void setOperationType(OperationType operationType) {
        this.operationType = operationType;
    }

    public Poblacion getFirst() {
        return getFirst(1);
    }

    public Poblacion getByProcessedUntil(int processedUntil, int processedFrom) {
        Poblacion p = new Poblacion();
        for (int i = 0; i < this.getIndividuos().size(); i++) {
            IndividuoEstrategia individuoEstrategia = this.getIndividuos().get(i);
            corregirIndividuo(individuoEstrategia);
            individuoEstrategia.setFortaleza(null);
            individuoEstrategia.setListaFortaleza(null);
            individuoEstrategia.setProcessedUntil(0);
            individuoEstrategia.setProcessedFrom(0);
            individuoEstrategia.setOptimizedOpenIndicators(null);
            individuoEstrategia.setOptimizedCloseIndicators(null);
            individuoEstrategia.setOpenPoint(null);
            individuoEstrategia.setPrevOpenPoint(null);
            individuoEstrategia.setOpenOperationIndex(0);
            individuoEstrategia.setActiveOperation(false);
            p.getIndividuos().add(individuoEstrategia);
        }
        return p;
    }

    private void corregirIndividuo(IndividuoEstrategia ind) {
        if (ind.getTakeProfit() < PropertiesManager.getMinTP()
                || (ind.getTakeProfit() > PropertiesManager.getMaxTP())) {
            ind.setTakeProfit(PropertiesManager.getMinTP());
        }
        if (ind.getStopLoss() < PropertiesManager.getMinSL()
                || (ind.getStopLoss() > PropertiesManager.getMaxSL())) {
            ind.setStopLoss(PropertiesManager.getMaxSL());
        }
        if (ind.getLot() < PropertiesManager.getMinLot()
                || (ind.getLot() > PropertiesManager.getMaxLot())) {
            ind.setLot(PropertiesManager.getMinLot());
        }
    }

    public Poblacion getFirst(int cantidad) {
        Poblacion p = new Poblacion();
        p.setIndividuos(CollectionUtil.subList(this.getIndividuos(), 0, (cantidad < this.getIndividuos().size()) ? cantidad : this.getIndividuos().size()));

        return p;
    }

    public Poblacion getFirst(int cantidad, int fromIndex) {
        Poblacion p = new Poblacion();
        p.setIndividuos(CollectionUtil.subList(this.getIndividuos(), fromIndex,
                ((fromIndex + cantidad) < this.getIndividuos().size()) ? (fromIndex + cantidad) : this.getIndividuos().size()));

        return p;
    }

    public Poblacion getLast() {
        return getLast(1);
    }

    public Poblacion getLast(int cantidad) {
        Poblacion p = new Poblacion();
        //p.setIndividuos(this.getIndividuos().subList((cantidad < this.getIndividuos().size())
        //      ? (this.getIndividuos().size() - cantidad) : 0, this.getIndividuos().size()));
        p.setIndividuos(CollectionUtil.subList(this.getIndividuos(), (cantidad < this.getIndividuos().size())
                ? (this.getIndividuos().size() - cantidad) : 0, this.getIndividuos().size()));

        return p;
    }

    public void removeAll(List<IndividuoEstrategia> individuos) {
        this.individuos.removeAll(individuos);
    }

    public void addAll(Poblacion poblacion) {
        Set set = new HashSet<IndividuoEstrategia>(poblacion.getIndividuos());
        /*        for (IndividuoEstrategia individuoEstrategia : poblacion.getIndividuos()) {
        this.add(individuoEstrategia);
        }*/
        this.individuos.addAll(set);
    }

    public void add(IndividuoEstrategia ie) {
        if (!this.individuos.contains(ie)) {
            //if (this.individuos.size() < PropertiesManager.getPropertyInt(Constants.INDIVIDUOS)) {
            this.individuos.add(ie);
            //}
        }
    }

    public void addAll(Poblacion poblacion, Poblacion compare) {
        for (IndividuoEstrategia individuoEstrategia : poblacion.getIndividuos()) {
            this.add(individuoEstrategia, compare);
        }
    }

    public void add(IndividuoEstrategia ie, Poblacion compare) {
        if ((!this.individuos.contains(ie)) && (!compare.individuos.contains(ie))) {
            this.individuos.add(ie);
        }
    }

    public List<IndividuoEstrategia> getIndividuos() {
        return this.individuos;
    }

    public void setIndividuos(List<IndividuoEstrategia> individuos) {
        this.individuos = individuos;
        //this.addAllHistoricos(individuos);
    }

    public boolean equals(Poblacion p) {
        return (this.operationType.equals(p.operationType)
                && this.pair.equals(p.pair)
                && this.individuos.equals(p.individuos));
    }

    @Override
    public int hashCode() {
        return super.hashCode();
    }
}
