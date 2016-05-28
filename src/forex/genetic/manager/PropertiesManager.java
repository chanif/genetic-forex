/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.manager;

import forex.genetic.manager.io.FileProperties;
import forex.genetic.util.Constants;
import forex.genetic.util.Constants.FortalezaType;
import forex.genetic.util.Constants.OperationType;
import forex.genetic.util.LogUtil;

/**
 *
 * @author ricardorq85
 */
public class PropertiesManager {

    private static Thread t = null;
    private static boolean isBuy = false;
    private static double pipsFixer = 0;
    private static double pairFactor = 0;
    private static int defaultScaleRounding = 0;
    private static OperationType operationType = null;
    private static FortalezaType fortalezaType = null;
    private static String pair = null;
    private static String serialicePath = null;
    private static boolean isThread = true;
    private static int minTP = 0;
    private static int maxTP = 0;
    private static int minSL = 0;
    private static int maxSL = 0;
    private static double minLot = 0;
    private static double maxLot = 0;
    private static int minBalance = 0;
    private static int maxBalance = 0;
    private static int presentNumberPoblacion = 0;
    private static int lotScaleRounding = 0;
    private static double riskLevel = 0;
    private static String fileId = null;
    private static int minOperNumByPeriod = 0;

    public PropertiesManager() {
    }

    public static Thread load() {
        t = new Thread() {

            public void run() {
                FileProperties.load();
                LogUtil.logTime(FileProperties.propertiesString(), 1);
                operationType = getOwnOperationType();
                fortalezaType = getOwnFortalezaType();
                pair = PropertiesManager.getPropertyString(Constants.PAIR);
                isBuy = (operationType.equals(Constants.OperationType.Buy));
                pipsFixer = PropertiesManager.getPropertyDouble(Constants.PIPS_FIXER);
                pairFactor = PropertiesManager.getPropertyDouble(Constants.PAIR_FACTOR);
                defaultScaleRounding = PropertiesManager.getPropertyInt(Constants.DEFAULT_SCALE_ROUNDING);
                serialicePath = PropertiesManager.getPropertyString(Constants.SERIALICE_PATH);
                isThread = PropertiesManager.getPropertyBoolean(Constants.THREAD);
                minTP = PropertiesManager.getPropertyInt(Constants.MIN_TP);
                maxTP = PropertiesManager.getPropertyInt(Constants.MAX_TP);
                minSL = PropertiesManager.getPropertyInt(Constants.MIN_SL);
                maxSL = PropertiesManager.getPropertyInt(Constants.MAX_SL);
                minLot = PropertiesManager.getPropertyDouble(Constants.MIN_LOT);
                maxLot = PropertiesManager.getPropertyDouble(Constants.MAX_LOT);
                minBalance = PropertiesManager.getPropertyInt(Constants.MIN_BALANCE);
                maxBalance = PropertiesManager.getPropertyInt(Constants.MAX_BALANCE);
                lotScaleRounding = PropertiesManager.getPropertyInt(Constants.LOT_SCALE_ROUNDING);
                presentNumberPoblacion = PropertiesManager.getPropertyInt(Constants.PRESENT_NUMBER_POBLACION);
                fileId = PropertiesManager.getPropertyString(Constants.FILE_ID);
                riskLevel = PropertiesManager.getPropertyDouble(Constants.RISK_LEVEL);
                minOperNumByPeriod = PropertiesManager.getPropertyInt(Constants.MIN_OPER_NUM_BY_PERIOD);
            }
        };
        t.start();
        return t;
    }

    public static int getMinOperNumByPeriod() {
        return minOperNumByPeriod;
    }

    public static double getRiskLevel() {
        return riskLevel;
    }

    public static boolean isBuy() {
        return isBuy;
    }

    public static boolean isThread() {
        return isThread;
    }

    public static double getPipsFixer() {
        return pipsFixer;
    }

    public static double getPairFactor() {
        return pairFactor;
    }

    public static String getFileId() {
        return fileId;
    }

    public static OperationType getOperationType() {
        return operationType;
    }

    public static FortalezaType getFortalezaType() {
        return fortalezaType;
    }

    public static int getDefaultScaleRounding() {
        return defaultScaleRounding;
    }

    public static String getPair() {
        return pair;
    }

    public static String getSerialicePath() {
        return serialicePath;
    }

    public static int getLotScaleRounding() {
        return lotScaleRounding;
    }

    public static int getMaxBalance() {
        return maxBalance;
    }

    public static double getMaxLot() {
        return maxLot;
    }

    public static int getMaxSL() {
        return maxSL;
    }

    public static int getMaxTP() {
        return maxTP;
    }

    public static int getMinBalance() {
        return minBalance;
    }

    public static double getMinLot() {
        return minLot;
    }

    public static int getMinSL() {
        return minSL;
    }

    public static int getMinTP() {
        return minTP;
    }

    public static int getPresentNumberPoblacion() {
        return presentNumberPoblacion;
    }

    private static OperationType getOwnOperationType() {
        OperationType ot = null;
        String s = getPropertyString(Constants.OPERATION_TYPE);
        if (s.contains("Sell")) {
            ot = OperationType.Sell;
        } else if (s.contains("Buy")) {
            ot = OperationType.Buy;
        }
        return ot;
    }

    public static FortalezaType getOwnFortalezaType() {
        FortalezaType t = null;
        String s = getPropertyString(Constants.FORTALEZA_TYPE);
        if (s.contains("Stable")) {
            t = Constants.FortalezaType.Stable;
        } else if (s.contains("Pips")) {
            t = Constants.FortalezaType.Pips;
        } else if (s.contains("Embudo")) {
            t = Constants.FortalezaType.Embudo;
        }
        return t;
    }

    public static int getPointsControl() {
        try {
            if (FileProperties.getProperties().isEmpty()) {
                t.join();
            }
        } catch (InterruptedException ex) {
            ex.printStackTrace();
        }
        int points = 1;
        String s = getPropertyString(Constants.POINTS_CONTROL);
        if (s.contains("Integer.MAX_VALUE")) {
            points = Integer.MAX_VALUE;
        } else if (s.contains("Integer.MAX_VALUE")) {
            points = Integer.MIN_VALUE;
        } else {
            points = getPropertyInt(Constants.POINTS_CONTROL);
        }
        return points;
    }

    public static String getPropertyString(String key) {
        try {
            if (FileProperties.getProperties().isEmpty()) {
                t.join();
            }
        } catch (InterruptedException ex) {
            ex.printStackTrace();
        }
        return FileProperties.getPropertyString(key);
    }

    public static int getPropertyInt(String key) {
        try {
            if (FileProperties.getProperties().isEmpty()) {
                t.join();
            }
        } catch (InterruptedException ex) {
            ex.printStackTrace();
        }
        return Integer.parseInt(FileProperties.getPropertyString(key));
    }

    public static long getPropertyLong(String key) {
        try {
            if (FileProperties.getProperties().isEmpty()) {
                t.join();
            }
        } catch (InterruptedException ex) {
            ex.printStackTrace();
        }
        return Long.parseLong(FileProperties.getPropertyString(key));
    }

    public static boolean getPropertyBoolean(String key) {
        try {
            if (FileProperties.getProperties().isEmpty()) {
                t.join();
            }
        } catch (InterruptedException ex) {
            ex.printStackTrace();
        }
        return Boolean.parseBoolean(FileProperties.getPropertyString(key));
    }

    public static double getPropertyDouble(String key) {
        try {
            if (FileProperties.getProperties().isEmpty()) {
                t.join();
            }
        } catch (InterruptedException ex) {
            ex.printStackTrace();
        }
        return Double.parseDouble(FileProperties.getPropertyString(key));
    }
}
