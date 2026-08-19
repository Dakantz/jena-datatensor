package pl.edu.pw.mini.jena.datatensor;

import java.time.Instant;
import java.util.HashMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TimingUtil {

  private static final Logger log = LoggerFactory.getLogger(TimingUtil.class);
  private static TimingUtil instance;

  public static TimingUtil timer() {
    if (instance == null) {
      instance = new TimingUtil();
    }
    return instance;
  }

  private TimingUtil() {}

  private HashMap<String, Long> startTimes = new HashMap<>();
  private static long currentNanos() {
    return System.nanoTime();
  }
  public void startTimer(String label) {
    log.info(String.join("", "--TIMING (", label, ") START--"));
    startTimes.put(label, currentNanos());
  }

  public void stopTimer(String label) {
    var endTime = currentNanos();
    var difference = endTime - startTimes.get(label);
    log.info(String.join("", "--TIMING (", label,
                         ") END: ", String.valueOf(difference), "  ns--"));
  }
}
