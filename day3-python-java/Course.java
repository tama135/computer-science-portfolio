import java.util.ArrayList;
import java.util.List;

/** A course, its capacity, and who is enrolled on it. */
public class Course {

    private final String code;
    private final String title;
    private final int capacity;
    private final List<String> enrolled;

    public Course(String code, String title, int capacity, List<String> enrolled) {
        if (capacity < 1) throw new IllegalArgumentException("capacity must be positive");
        this.code = code;
        this.title = title;
        this.capacity = capacity;
        this.enrolled = new ArrayList<>(enrolled);
    }

    public boolean hasSpace() {
        return enrolled.size() < capacity;
    }

    public void enrol(String student) {
        if (!hasSpace()) throw new IllegalStateException(title + " is full");
        if (enrolled.contains(student)) throw new IllegalStateException(student + " already enrolled");
        enrolled.add(student);
    }

    public int seatsLeft() {
        return capacity - enrolled.size();
    }

    @Override
    public String toString() {
        return String.format("%s - %s (%d/%d filled, %d left)",
                code, title, enrolled.size(), capacity, seatsLeft());
    }

    public static void main(String[] args) {
        Course db = new Course("DB210", "Databases", 3, List.of("R. Patel"));

        db.enrol("S. Nakamura");
        System.out.println(db);

        System.out.println();
        System.out.println("guard checks");
        try {
            db.enrol("S. Nakamura");
            System.out.println("  duplicate -> accepted (bug)");
        } catch (IllegalStateException e) {
            System.out.println("  duplicate -> " + e.getMessage());
        }

        db.enrol("T. Bello");
        System.out.println("  after fill -> " + db);

        try {
            db.enrol("A. Okafor");
            System.out.println("  over capacity -> accepted (bug)");
        } catch (IllegalStateException e) {
            System.out.println("  over capacity -> " + e.getMessage());
        }
    }
}
