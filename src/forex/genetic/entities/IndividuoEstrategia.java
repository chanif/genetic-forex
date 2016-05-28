/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.entities;

import java.util.Vector;
import forex.genetic.manager.PropertiesManager;
import java.util.Collections;
import forex.genetic.entities.indicator.Indicator;
import forex.genetic.manager.IndividuoManager;
import forex.genetic.util.Constants;
import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import static forex.genetic.util.Constants.*;

/**
 *
 * @author ricardorq85
 */
public class IndividuoEstrategia implements Comparable<IndividuoEstrategia>, Serializable {

    private String id = "0";
    private String fileId = null;
    private int processedUntil = 0;
    private int processedFrom = 0;
    private int generacion = -1;
    private IndividuoEstrategia parent1 = null;
    private IndividuoEstrategia parent2 = null;
    private String idParent1 = null;
    private String idParent2 = null;
    private IndividuoType individuoType = IndividuoType.INITIAL;
    private int takeProfit = 0;
    private int stopLoss = 0;
    private double lot = 0;
    private int initialBalance = 0;
    private List<? extends Indicator> openIndicators = null;
    private List<? extends Indicator> closeIndicators = null;
    private Fortaleza fortaleza = null;
    private List<Fortaleza> listaFortaleza = new ArrayList<Fortaleza>();
    private double openOperationValue = 0.0D;
    private double openSpread = 0.0D;
    private int openPoblacionIndex = 1;
    private int openOperationIndex = 0;
    private boolean activeOperation = false;
    private Date creationDate = null;
    public static final long serialVersionUID = 201101251800L;

    public IndividuoEstrategia() {
        this(0, null, null, IndividuoType.INITIAL);
    }

    public IndividuoEstrategia(IndividuoEstrategia parent1) {
        this(0, parent1, null, IndividuoType.INITIAL);
    }

    public IndividuoEstrategia(int generacion, IndividuoEstrategia parent1, IndividuoEstrategia parent2, IndividuoType individuoType) {
        setFileId(PropertiesManager.getPropertyString(Constants.FILE_ID));
        setId(IndividuoManager.nextId());
        setGeneracion(generacion);
        setParent1(parent1);
        setParent2(parent2);
        setIndividuoType(individuoType);
        setCreationDate(new Date());
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public double getOpenSpread() {
        return openSpread;
    }

    public void setOpenSpread(double openSpread) {
        this.openSpread = openSpread;
    }

    public boolean isActiveOperation() {
        return activeOperation;
    }

    public void setActiveOperation(boolean activeOperation) {
        this.activeOperation = activeOperation;
    }

    public int getOpenOperationIndex() {
        return openOperationIndex;
    }

    public void setOpenOperationIndex(int openOperationIndex) {
        this.openOperationIndex = openOperationIndex;
    }

    public double getOpenOperationValue() {
        return openOperationValue;
    }

    public void setOpenOperationValue(double openOperationValue) {
        this.openOperationValue = openOperationValue;
    }

    public int getOpenPoblacionIndex() {
        return openPoblacionIndex;
    }

    public void setOpenPoblacionIndex(int openPoblacionIndex) {
        this.openPoblacionIndex = openPoblacionIndex;
    }

    public int getProcessedFrom() {
        return processedFrom;
    }

    public void setProcessedFrom(int processedFrom) {
        this.processedFrom = processedFrom;
    }

    public int getProcessedUntil() {
        return processedUntil;
    }

    public void setProcessedUntil(int processedUntil) {
        this.processedUntil = processedUntil;
    }

    public IndividuoType getIndividuoType() {
        return individuoType;
    }

    public void setIndividuoType(IndividuoType individuoType) {
        this.individuoType = individuoType;
    }

    public IndividuoEstrategia getParent1() {
        return parent1;
    }

    public void setParent1(IndividuoEstrategia parent1) {
        this.idParent1 = (parent1 == null) ? null : parent1.id;
    }

    public IndividuoEstrategia getParent2() {
        return parent2;
    }

    public void setParent2(IndividuoEstrategia parent2) {
        this.idParent2 = (parent2 == null) ? null : parent2.id;
    }

    public Fortaleza getFortaleza() {
        return fortaleza;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setFortaleza(Fortaleza fortaleza) {
        this.fortaleza = fortaleza;
    }

    public List<? extends Indicator> getOpenIndicators() {
        return openIndicators;
    }

    public void setOpenIndicators(List<? extends Indicator> openIndicators) {
        this.openIndicators = openIndicators;
    }

    public List<? extends Indicator> getCloseIndicators() {
        return closeIndicators;
    }

    public void setCloseIndicators(List<? extends Indicator> closeIndicators) {
        this.closeIndicators = closeIndicators;
    }

    public int getInitialBalance() {
        return initialBalance;
    }

    public void setInitialBalance(int initialBalance) {
        this.initialBalance = initialBalance;
    }

    public int getStopLoss() {
        return stopLoss;
    }

    public void setStopLoss(int stopLoss) {
        this.stopLoss = stopLoss;
    }

    public int getTakeProfit() {
        return takeProfit;
    }

    public void setTakeProfit(int takeProfit) {
        this.takeProfit = takeProfit;
    }

    public double getLot() {
        return lot;
    }

    public void setLot(double lot) {
        this.lot = lot;
    }

    public int getGeneracion() {
        return generacion;
    }

    public void setGeneracion(int generacion) {
        this.generacion = generacion;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public String getIdParent1() {
        return idParent1;
    }

    public void setIdParent1(String idParent1) {
        this.idParent1 = idParent1;
    }

    public String getIdParent2() {
        return idParent2;
    }

    public void setIdParent2(String idParent2) {
        this.idParent2 = idParent2;
    }

    public List<Fortaleza> getListaFortaleza() {
        return listaFortaleza;
    }

    public void setListaFortaleza(List<Fortaleza> listaFortaleza) {
        if (listaFortaleza == null) {
            this.listaFortaleza = new Vector<Fortaleza>();
        } else {
            this.listaFortaleza = listaFortaleza;
        }
    }

    public int compareTo(IndividuoEstrategia o) {
        int compare = 0;
        if ((this.fortaleza == null) && (o.fortaleza == null)) {
            compare = 0;
        } else if (this.fortaleza == null) {
            compare = 1;
        } else if (o.fortaleza == null) {
            compare = -1;
        } else {
            if (this.equals(o)) {
                compare = 0;
            } else {
                compare = this.fortaleza.compareTo(o.fortaleza) * PropertiesManager.getPropertyInt(Constants.PRESENT_NUMBER_POBLACION);
                for (int i = this.listaFortaleza.size() - 2; (i >= (this.listaFortaleza.size() - PropertiesManager.getPropertyInt(Constants.PRESENT_NUMBER_POBLACION))) && (i >= 0); i--) {
                    Fortaleza f = this.listaFortaleza.get(i);
                    Fortaleza fo = o.listaFortaleza.get(i);
                    if ((f == null) && (fo == null)) {
                        compare += 0;
                    } else if (f == null) {
                        compare = 1;
                    } else if (fo == null) {
                        compare = -1;
                    } else {
                        compare += f.compareTo(fo) * (PropertiesManager.getPropertyInt(Constants.PRESENT_NUMBER_POBLACION) - (this.listaFortaleza.size() - i - 1));
                    }
                }
            }
        }
        return (Integer.valueOf(compare).compareTo(Integer.valueOf(0)));
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof IndividuoEstrategia) {
            IndividuoEstrategia objIndividuo = (IndividuoEstrategia) obj;
            return (this.getId().equals(objIndividuo.getId()))
                    || (!((this.openIndicators != null && objIndividuo.openIndicators == null)
                    && (this.openIndicators == null && objIndividuo.openIndicators != null)
                    && this.openIndicators.equals(objIndividuo.openIndicators))
                    && !((this.closeIndicators != null && objIndividuo.closeIndicators == null)
                    && (this.closeIndicators == null && objIndividuo.closeIndicators != null)
                    && this.closeIndicators.equals(objIndividuo.closeIndicators))
                    && (this.takeProfit == objIndividuo.takeProfit)
                    && (this.stopLoss == objIndividuo.stopLoss));
        } else {
            return false;
        }
    }

    public boolean equalsReal(Object obj) {
        if (obj instanceof IndividuoEstrategia) {
            IndividuoEstrategia objIndividuo = (IndividuoEstrategia) obj;
            return ((this.openIndicators.equals(objIndividuo.openIndicators)
                    && Collections.frequency(this.openIndicators, null) != this.openIndicators.size())
                    || (this.closeIndicators.equals(objIndividuo.closeIndicators)
                    && Collections.frequency(this.closeIndicators, null) != this.closeIndicators.size())
                    || ((Math.abs((objIndividuo.takeProfit - this.takeProfit) / new Double(this.takeProfit)) < 0.02)
                    && (Math.abs((objIndividuo.stopLoss - this.stopLoss) / new Double(this.stopLoss)) < 0.02)));
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        return (this.getId().hashCode());
    }

    @Override
    public String toString() {
        StringBuilder buffer = new StringBuilder();
        buffer.append(" Id=" + (this.id));
        buffer.append(" Generacion=" + (this.generacion) + ";");
        buffer.append(" ProcessedFrom=" + (this.processedFrom));
        buffer.append(" ProcessedUntil=" + (this.processedUntil));
        buffer.append("; IndividuoType=" + (this.individuoType) + ";");
        buffer.append("\n\t");
        buffer.append(((this.fortaleza == null) ? 0.0 : this.fortaleza.toString()));
        buffer.append("\n\t");
        if (idParent1 != null) {
            buffer.append("; Padre 1=" + idParent1);
        }
        if (idParent2 != null) {
            buffer.append("; Padre 2=" + idParent2);
        }
        buffer.append("; CreationDate=" + this.creationDate);
        buffer.append("; TakeProfit=" + this.takeProfit);
        buffer.append("; Stoploss=" + this.stopLoss);
        buffer.append("; Lot=" + this.lot);
        buffer.append("; Initial Balance=" + this.initialBalance);
        buffer.append("\n\t");
        buffer.append("; Open Indicadores=" + (this.openIndicators));
        buffer.append("\n\t");
        buffer.append("; Close Indicadores=" + (this.closeIndicators));

        return buffer.toString();
    }

    public String toFileString(Interval<Date> dateInterval) {
        StringBuilder buffer = new StringBuilder();
        buffer.append("ProcessedFrom&Until=" + (this.processedFrom) + "-" + (this.processedUntil) + "/" + PropertiesManager.getPropertyInt(Constants.END_POBLACION) + ",");
        buffer.append("EstrategiaId=" + (this.id) + ",");
        buffer.append("Active=" + (this.fortaleza.getValue() > 1.0) + ",");
        buffer.append("Pair=" + PropertiesManager.getPropertyString(Constants.PAIR) + ",");
        buffer.append("Operation=" + PropertiesManager.getOperationType() + ",");

        DateFormat format = new SimpleDateFormat("yyyy.MM.dd HH:mm");
        buffer.append("VigenciaLower=" + format.format(dateInterval.getHighInterval()) + ",");
        long vigDias = PropertiesManager.getPropertyLong(Constants.VIGENCIA);
        long vigMillis = (vigDias * 24 * 60 * 60 * 1000);
        Date vigencia = new Date(dateInterval.getHighInterval().getTime() + vigMillis);
        buffer.append("VigenciaHigher=" + (format.format(vigencia)) + ",");

        buffer.append("TakeProfit=" + this.takeProfit + ",");
        buffer.append("StopLoss=" + this.stopLoss + ",");
        buffer.append("Lote=" + this.lot + ",");
        buffer.append("MaxConsecutiveLostOperationsNumber=" + this.fortaleza.getMaxConsecutiveLostOperationsNumber() + ",");
        buffer.append("MaxConsecutiveWonOperationsNumber=" + this.fortaleza.getMaxConsecutiveWonOperationsNumber() + ",");
        buffer.append("MinConsecutiveLostOperationsNumber=" + this.fortaleza.getMinConsecutiveLostOperationsNumber() + ",");
        buffer.append("MinConsecutiveWonOperationsNumber=" + this.fortaleza.getMinConsecutiveWonOperationsNumber() + ",");
        buffer.append("AverageConsecutiveLostOperationsNumber=" + Math.round(this.fortaleza.getAverageConsecutiveLostOperationsNumber()) + ",");
        buffer.append("AverageConsecutiveWonOperationsNumber=" + Math.round(this.fortaleza.getAverageConsecutiveWonOperationsNumber()) + ",");
        for (Indicator indicator : this.openIndicators) {
            if (indicator != null) {
                buffer.append(indicator.toFileString("open"));
            } else {
                buffer.append("null");
            }
            buffer.append(",");
        }
        for (Indicator indicator : this.closeIndicators) {
            if (indicator != null) {
                buffer.append(indicator.toFileString("close"));
            } else {
                buffer.append("null");
            }
            buffer.append(",");
        }
        return buffer.toString();
    }
}
