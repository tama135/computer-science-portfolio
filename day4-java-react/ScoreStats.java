import java.util.Arrays;

/** Descriptive statistics over an int array, with an even/odd median test. */
public class ScoreStats {

    private final int[] scores;

    public ScoreStats(int[] scores) {
        if (scores == null || scores.length == 0) {
            throw new IllegalArgumentException("need at least one score");
        }
        this.scores = scores.clone();
    }

    public double mean() {
        int sum = 0;
        for (int s : scores) sum += s;
        return (double) sum / scores.length;
    }

    public double median() {
        int[] sorted = scores.clone();
        Arrays.sort(sorted);
        int mid = sorted.length / 2;
        return sorted.length % 2 == 0
                ? (sorted[mid - 1] + sorted[mid]) / 2.0
                : sorted[mid];
    }

    public int range() {
        int min = scores[0];
        int max = scores[0];
        for (int s : scores) {
            min = Math.min(min, s);
            max = Math.max(max, s);
        }
        return max - min;
    }

    public static void main(String[] args) {
        ScoreStats odd = new ScoreStats(new int[] {72, 81, 90, 65, 54});
        System.out.printf("odd  n=%d mean=%.1f median=%.1f range=%d%n",
                odd.scores.length, odd.mean(), odd.median(), odd.range());

        ScoreStats even = new ScoreStats(new int[] {88, 91, 65, 70});
        System.out.printf("even n=%d mean=%.1f median=%.1f range=%d%n",
                even.scores.length, even.mean(), even.median(), even.range());

        System.out.println();
        System.out.println("guard checks");
        try {
            new ScoreStats(new int[0]);
            System.out.println("  empty -> accepted (bug)");
        } catch (IllegalArgumentException e) {
            System.out.println("  empty -> " + e.getMessage());
        }

        int[] source = {10, 20, 30};
        ScoreStats stats = new ScoreStats(source);
        source[0] = 999;
        System.out.printf("  defensive copy -> mean %.1f (expected 20.0)%n", stats.mean());
    }
}
