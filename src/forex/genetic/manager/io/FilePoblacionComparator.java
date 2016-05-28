/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package forex.genetic.manager.io;

import forex.genetic.manager.PropertiesManager;
import java.io.File;
import java.util.Comparator;

/**
 *
 * @author ricardorq85
 */
public class FilePoblacionComparator implements Comparator<File> {

    public int compare(File o1, File o2) {
        int compare = 0;
        if ((o1.getName().contains(PropertiesManager.getPair()))
                && (!o2.getName().contains(PropertiesManager.getPair()))) {
            compare = 1;
        } else if ((o2.getName().contains(PropertiesManager.getPair()))
                && (!o1.getName().contains(PropertiesManager.getPair()))) {
            compare = -1;
        } else {
            compare = (Long.valueOf(o1.lastModified()).compareTo(Long.valueOf(o2.lastModified())));
        }
        return compare;
    }
}