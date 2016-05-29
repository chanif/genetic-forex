/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.entities;

import forex.genetic.manager.indicator.IndicatorManager;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ricardorq85
 */
public class LearningParametrosIndividuo implements Serializable {

    public static final long serialVersionUID = 201205270933L;
    private boolean takeProfit = false;
    private boolean stopLoss = false;
    private boolean lot = false;
    private boolean initialBalance = false;
    private List<Boolean> openIndicators = null;
    private List<Boolean> closeIndicators = null;

    public LearningParametrosIndividuo() {
        this.openIndicators = new ArrayList<Boolean>(IndicatorManager.getIndicatorNumber());
        this.closeIndicators = new ArrayList<Boolean>(IndicatorManager.getIndicatorNumber());
    }

    public List<Boolean> getCloseIndicators() {
        return closeIndicators;
    }

    public void setCloseIndicators(List<Boolean> closeIndicators) {
        this.closeIndicators = closeIndicators;
    }

    public boolean isInitialBalance() {
        return initialBalance;
    }

    public void setInitialBalance(boolean initialBalance) {
        this.initialBalance = initialBalance;
    }

    public boolean isLot() {
        return lot;
    }

    public void setLot(boolean lot) {
        this.lot = lot;
    }

    public List<Boolean> getOpenIndicators() {
        return openIndicators;
    }

    public void setOpenIndicators(List<Boolean> openIndicators) {
        this.openIndicators = openIndicators;
    }

    public boolean isStopLoss() {
        return stopLoss;
    }

    public void setStopLoss(boolean stopLoss) {
        this.stopLoss = stopLoss;
    }

    public boolean isTakeProfit() {
        return takeProfit;
    }

    public void setTakeProfit(boolean takeProfit) {
        this.takeProfit = takeProfit;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final LearningParametrosIndividuo other = (LearningParametrosIndividuo) obj;
        if (this.takeProfit != other.takeProfit) {
            return false;
        }
        if (this.stopLoss != other.stopLoss) {
            return false;
        }
        if (this.lot != other.lot) {
            return false;
        }
        if (this.initialBalance != other.initialBalance) {
            return false;
        }
        if (this.openIndicators != other.openIndicators && (this.openIndicators == null || !this.openIndicators.equals(other.openIndicators))) {
            return false;
        }
        if (this.closeIndicators != other.closeIndicators && (this.closeIndicators == null || !this.closeIndicators.equals(other.closeIndicators))) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 37 * hash + (this.takeProfit ? 1 : 0);
        hash = 37 * hash + (this.stopLoss ? 1 : 0);
        hash = 37 * hash + (this.lot ? 1 : 0);
        hash = 37 * hash + (this.initialBalance ? 1 : 0);
        hash = 37 * hash + (this.openIndicators != null ? this.openIndicators.hashCode() : 0);
        hash = 37 * hash + (this.closeIndicators != null ? this.closeIndicators.hashCode() : 0);
        return hash;
    }

    @Override
    public String toString() {
        return "LearningParametrosIndividuo{" + "takeProfit=" + takeProfit + ", stopLoss=" + stopLoss + ", lot=" + lot + ", initialBalance=" + initialBalance + ", openIndicators=" + openIndicators + ", closeIndicators=" + closeIndicators + '}';
    }
}
