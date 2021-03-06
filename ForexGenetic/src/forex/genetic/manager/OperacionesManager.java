package forex.genetic.manager;

import forex.genetic.dao.DatoHistoricoDAO;
import forex.genetic.dao.OperacionesDAO;
import forex.genetic.entities.DoubleInterval;
import forex.genetic.entities.Individuo;
import forex.genetic.entities.Interval;
import forex.genetic.entities.Order;
import forex.genetic.entities.Point;
import forex.genetic.manager.controller.OperationController;
import forex.genetic.util.Constants;
import forex.genetic.util.Constants.OperationType;
import forex.genetic.util.LogUtil;
import forex.genetic.util.NumberUtil;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ricardorq85
 */
public class OperacionesManager {

    private Connection conn = null;
    private final OperationController operationController = new OperationController();

    /**
     *
     */
    public OperacionesManager() {
    }

    /**
     *
     * @param conn
     */
    public OperacionesManager(Connection conn) {
        this.conn = conn;
    }

    /**
     *
     * @param individuo
     * @return
     */
    public boolean hasMinimumCriterion(Individuo individuo) {
        boolean has = true;
        return has;
    }

    /**
     *
     * @param points
     * @param index
     * @param operacion
     * @return
     */
    public double calcularPips(List<Point> points, int index, Order operacion) {
        double pips = 0.0D;
        double stopLossPips = (operacion.getTipo().equals(Constants.OperationType.BUY))
                ? (operationController.calculateStopLossPrice(points, index, Constants.OperationType.BUY)
                - operacion.getOpenOperationValue()) * PropertiesManager.getPairFactor()
                : (-operationController.calculateStopLossPrice(points, index, Constants.OperationType.SELL)
                + operacion.getOpenOperationValue()) * PropertiesManager.getPairFactor();
        double takeProfitPips = (operacion.getTipo().equals(Constants.OperationType.BUY))
                ? (operationController.calculateTakePrice(points, index, Constants.OperationType.BUY)
                - operacion.getOpenOperationValue()) * PropertiesManager.getPairFactor()
                : (-operationController.calculateTakePrice(points, index, Constants.OperationType.SELL)
                + operacion.getOpenOperationValue()) * PropertiesManager.getPairFactor();

        if (stopLossPips < 0) {
            pips = stopLossPips;
        } else {
            pips = takeProfitPips;
        }

        return pips;
    }

    /**
     *
     * @param points
     * @param individuo
     * @return
     */
    public List<Order> calcularOperaciones(List<Point> points, Individuo individuo) {
        List<Order> ordenes = new ArrayList<>();
        double takeProfit = individuo.getTakeProfit();
        double stopLoss = individuo.getStopLoss();
        double lot = individuo.getLot();

        boolean hasMinimumCriterion = true;
        boolean activeOperation = (individuo.getFechaApertura() != null);
        Point openPoint;
        Order currentOrder = individuo.getCurrentOrder();
        double openOperationValue = (activeOperation) ? currentOrder.getOpenOperationValue() : 0.0D;
        for (int i = 1; (i < points.size() && hasMinimumCriterion); i++) {
            if (!activeOperation) {
                boolean operate = operationController.operateOpen(individuo, points, i);
                if (operate) {
                    //boolean operate2 = indicatorController.operateOpen(individuo, points, i);
                    openOperationValue = operationController.calculateOpenPrice(individuo, points, i);
                    individuo.setOpenOperationValue(openOperationValue);
                    operate = !Double.isNaN(openOperationValue);
                    if (operate) {
                        activeOperation = true;
                        openPoint = points.get(i);
                        currentOrder = new Order();
                        currentOrder.setOpenDate(openPoint.getDate());
                        currentOrder.setOpenOperationValue(openOperationValue);
                        currentOrder.setOpenSpread(openPoint.getSpread());
                        currentOrder.setLot(lot);
                        currentOrder.setTakeProfit(takeProfit);
                        currentOrder.setStopLoss(stopLoss);
                        currentOrder.setTipo(individuo.getTipoOperacion());
                        individuo.setCurrentOrder(currentOrder);
                    }
                }
            } else {
                Point closePoint = points.get(i);
                double pips = 0.0D;
                double stopLossPips = (individuo.isTipoBuy())
                        ? (operationController.calculateStopLossPrice(points, i, Constants.OperationType.BUY) - openOperationValue) * PropertiesManager.getPairFactor()
                        : (-operationController.calculateStopLossPrice(points, i, Constants.OperationType.SELL) + openOperationValue) * PropertiesManager.getPairFactor();
                double takeProfitPips = (individuo.isTipoBuy())
                        ? (operationController.calculateTakePrice(points, i, Constants.OperationType.BUY) - openOperationValue) * PropertiesManager.getPairFactor()
                        : (-operationController.calculateTakePrice(points, i, Constants.OperationType.SELL) + openOperationValue) * PropertiesManager.getPairFactor();
                stopLossPips = stopLossPips - (currentOrder.getOpenSpread());
                takeProfitPips = takeProfitPips - (currentOrder.getOpenSpread());
                boolean operate = (((takeProfitPips >= (takeProfit)) || (stopLossPips <= -(stopLoss))));
                if (!operate) {
                    operate = operationController.operateClose(individuo, points, i);
                    if (operate) {
                        pips = (individuo.isTipoBuy())
                                ? (operationController.calculateClosePrice(individuo, points, i) - openOperationValue) * PropertiesManager.getPairFactor()
                                : (-operationController.calculateClosePrice(individuo, points, i) + openOperationValue) * PropertiesManager.getPairFactor();
                        operate = !Double.isNaN(pips);
                        if (operate) {
                            //boolean operate2 = indicatorController.operateClose(individuo, points, i);
                            currentOrder.setCloseByTakeStop(false);
                            pips = (pips - currentOrder.getOpenSpread());
                        }
                    }
                } else {
                    currentOrder.setCloseByTakeStop(true);
                    if (takeProfitPips >= (takeProfit)) {
                        pips = (takeProfit);
                    } else if (stopLossPips <= -(stopLoss)) {
                        pips = -(stopLoss);
                    }
                }
                if (operate) {
                    activeOperation = false;
                    currentOrder.setCloseDate(closePoint.getDate());
                    currentOrder.setPips(pips);
                    ordenes.add(currentOrder);
                    currentOrder = null;
                    individuo.setCurrentOrder(null);
                }
            }
        }
        if (currentOrder != null) {
            ordenes.add(currentOrder);
        }
        return ordenes;
    }

    /**
     *
     * @param points
     * @param individuo
     */
    public void calcularCierreOperacion(List<Point> points, Individuo individuo) {
        double takeProfit = individuo.getTakeProfit();
        double stopLoss = individuo.getStopLoss();

        boolean activeOperation = (individuo.getFechaApertura() != null);
        Order currentOrder = individuo.getCurrentOrder();
        double openOperationValue = (activeOperation) ? currentOrder.getOpenOperationValue() : 0.0D;
        for (int i = 1; (i < points.size() && (currentOrder != null)); i++) {
            Point closePoint = points.get(i);
            double pips = 0.0D;
            boolean operate = currentOrder.isCloseImmediate();
            if (operate) {
                pips = (currentOrder.getTipo().equals(Constants.OperationType.BUY))
                        ? (operationController.calculateClosePrice(individuo, points, i) - openOperationValue) * PropertiesManager.getPairFactor()
                        : (-operationController.calculateClosePrice(individuo, points, i) + openOperationValue) * PropertiesManager.getPairFactor();
                currentOrder.setCloseByTakeStop(false);
                pips = (pips - currentOrder.getOpenSpread());
            } else {
                double stopLossPips = (currentOrder.getTipo().equals(Constants.OperationType.BUY))
                        ? (operationController.calculateStopLossPrice(points, i, Constants.OperationType.BUY) - openOperationValue) * PropertiesManager.getPairFactor()
                        : (-operationController.calculateStopLossPrice(points, i, Constants.OperationType.SELL) + openOperationValue) * PropertiesManager.getPairFactor();
                double takeProfitPips = (currentOrder.getTipo().equals(Constants.OperationType.BUY))
                        ? (operationController.calculateTakePrice(points, i, Constants.OperationType.BUY) - openOperationValue) * PropertiesManager.getPairFactor()
                        : (-operationController.calculateTakePrice(points, i, Constants.OperationType.SELL) + openOperationValue) * PropertiesManager.getPairFactor();
                stopLossPips = stopLossPips - (currentOrder.getOpenSpread());
                takeProfitPips = takeProfitPips - (currentOrder.getOpenSpread());
                operate = (((takeProfitPips >= (takeProfit)) || (stopLossPips <= -(stopLoss))));
                if (operate) {
                    currentOrder.setCloseByTakeStop(true);
                    if (takeProfitPips >= (takeProfit)) {
                        pips = (takeProfit);
                    } else if (stopLossPips <= -(stopLoss)) {
                        pips = -(stopLoss);
                    }
                }
            }
            if (operate) {
                activeOperation = false;
                currentOrder.setCloseDate(closePoint.getDate());
                currentOrder.setPips(pips);
                currentOrder = null;
                individuo.setCurrentOrder(null);
            }
        }
    }

    public double calculateOpenPrice(Point currentPoint) {
        return this.calculateOpenPrice(currentPoint, OperationType.SELL);
    }
    
    /**
     *
     * @param currentPoint
     * @return
     */
    public double calculateOpenPrice(Point currentPoint, OperationType tipoOperacion) {
        double price = Double.NaN;
        Interval currentInterval = new DoubleInterval(currentPoint.getLow(), currentPoint.getHigh());
        if (currentInterval != null) {
            Interval pointInterval = new DoubleInterval(currentPoint.getLow(), currentPoint.getHigh());
            DoubleInterval resultInterval = (DoubleInterval) IntervalManager.intersect(currentInterval, pointInterval);
            if (resultInterval != null) {
                price = (currentPoint.getOpen() <= resultInterval.getLowInterval())
                        ? resultInterval.getLowInterval() : (currentPoint.getOpen() >= resultInterval.getHighInterval())
                        ? resultInterval.getHighInterval() : (currentPoint.getClose() <= resultInterval.getLowInterval())
                        ? resultInterval.getHighInterval() : (currentPoint.getClose() >= resultInterval.getHighInterval())
                        ? resultInterval.getLowInterval() : (resultInterval.getLowInterval() + resultInterval.getHighInterval()) / 2;
                if (tipoOperacion.equals(OperationType.BUY)) {
                    price += PropertiesManager.getPipsFixer() / PropertiesManager.getPairFactor();
                } else {
                    price -= PropertiesManager.getPipsFixer() / PropertiesManager.getPairFactor();
                }
                price = NumberUtil.round(price);
            }
        }
        return price;
    }

    /**
     *
     * @param fechaMaximo
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public void procesarMaximosRetroceso(Date fechaMaximo) throws ClassNotFoundException, SQLException {
        OperacionesDAO operacionesDAO = new OperacionesDAO(conn);
        List<Individuo> individuos = operacionesDAO.consultarOperacionesIndividuoRetroceso(fechaMaximo);
        while ((individuos != null) && (!individuos.isEmpty())) {
            for (Individuo individuo : individuos) {
                if (individuo.getOpenIndicators() == null) {
                    individuo.setOpenIndicators(new ArrayList<>());
                }
                if (individuo.getCloseIndicators() == null) {
                    individuo.setCloseIndicators(new ArrayList<>());
                }
                LogUtil.logTime("Individuo="+individuo.getId()+";Orden="+individuo.getOrdenes().toString(), 1);
                this.procesarMaximosReproceso(individuo);
            }
            individuos = operacionesDAO.consultarOperacionesIndividuoRetroceso(fechaMaximo);
        }
    }

    /**
     *
     * @param individuo
     * @param fechaMaximo
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public void procesarMaximosRetroceso(Individuo individuo, Date fechaMaximo) throws ClassNotFoundException, SQLException {
        OperacionesDAO operacionesDAO = new OperacionesDAO(conn);
        individuo = operacionesDAO.consultarOperacionesIndividuoRetroceso(individuo, fechaMaximo);

        if (individuo.getOpenIndicators() == null) {
            individuo.setOpenIndicators(new ArrayList<>());
        }
        if (individuo.getCloseIndicators() == null) {
            individuo.setCloseIndicators(new ArrayList<>());
        }
        this.procesarMaximosReproceso(individuo);
    }

    /**
     *
     * @param individuo
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public void procesarMaximosReproceso(Individuo individuo) throws ClassNotFoundException, SQLException {
        DatoHistoricoDAO datoHistoricoDAO = new DatoHistoricoDAO(conn);
        OperacionesDAO operacionesDAO = new OperacionesDAO(conn);
        List<Order> ordenes = individuo.getOrdenes();
        for (Order currentOrder : ordenes) {
            if ((currentOrder != null) && (currentOrder.getOpenDate() != null) && (currentOrder.getCloseDate() != null)) {
                Point pointRetroceso = datoHistoricoDAO.consultarRetroceso(currentOrder);
                if (pointRetroceso != null) {
                    double valueRetroceso = ((currentOrder.getPips() > 0) ? pointRetroceso.getHigh() : pointRetroceso.getLow());
                    double pips = (currentOrder.getTipo().equals(Constants.OperationType.BUY))
                            ? (valueRetroceso - currentOrder.getOpenOperationValue()) * PropertiesManager.getPairFactor()
                            : (-valueRetroceso + currentOrder.getOpenOperationValue()) * PropertiesManager.getPairFactor();
                    pips = (pips - currentOrder.getOpenSpread());
                    currentOrder.setMaxPipsRetroceso(pips);
                    currentOrder.setMaxValueRetroceso(valueRetroceso);
                    currentOrder.setMaxFechaRetroceso(pointRetroceso.getDate());
                } else {
                    currentOrder.setMaxPipsRetroceso(0.0D);
                    currentOrder.setMaxValueRetroceso(0.0D);
                    currentOrder.setMaxFechaRetroceso(null);
                }
                operacionesDAO.updateMaximosReprocesoOperacion(individuo, currentOrder);
            }
        }
        conn.commit();
    }
}
