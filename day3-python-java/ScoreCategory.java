/**
 * Maps a numeric score to a band using explicit boundaries.
 *
 * Boundary rule: each band is inclusive of its lower bound and exclusive of its
 * upper bound, except the top band, which is inclusive at 100.
 */
public final class ScoreCategory {

    public enum Band { FAIL, PASS, MERIT, DISTINCTION }

    private ScoreCategory() {
    }

    public static Band classify(int score) {
        if (score < 0 || score > 100) {
            throw new IllegalArgumentException("score out of range: " + score);
        }
        if (score < 50) return Band.FAIL;
        if (score < 70) return Band.PASS;
        if (score < 85) return Band.MERIT;
        return Band.DISTINCTION;
    }

    public static void main(String[] args) {
        System.out.println("boundary table");
        int[] boundaries = {0, 49, 50, 69, 70, 84, 85, 100};
        for (int score : boundaries) {
            System.out.printf("  %3d -> %s%n", score, classify(score));
        }

        System.out.println();
        System.out.println("out-of-range values");
        for (int bad : new int[] {-1, 101}) {
            try {
                classify(bad);
                System.out.printf("  %3d -> no exception (bug)%n", bad);
            } catch (IllegalArgumentException e) {
                System.out.printf("  %3d -> %s%n", bad, e.getMessage());
            }
        }
    }
}
