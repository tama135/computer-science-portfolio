-- Level 2: joins and aggregation.

-- 1. Every course with its instructor and how many students enrolled.
SELECT c.code,
       c.title,
       i.full_name          AS instructor,
       COUNT(e.student_id)  AS enrolled
FROM course c
JOIN instructor i ON i.instructor_id = c.instructor_id
LEFT JOIN enrolment e ON e.course_id = c.course_id
GROUP BY c.course_id
ORDER BY enrolled DESC, c.code;

-- 2. Per-student average across all assessments, highest first.
SELECT s.full_name,
       s.cohort,
       ROUND(AVG(sc.points), 1) AS avg_points,
       COUNT(*)                 AS assessments
FROM student s
JOIN score sc ON sc.student_id = s.student_id
GROUP BY s.student_id
ORDER BY avg_points DESC;

-- 3. Per-course average, only where at least two scores exist.
SELECT c.code,
       c.title,
       ROUND(AVG(sc.points), 1) AS avg_points,
       MIN(sc.points)           AS lowest,
       MAX(sc.points)           AS highest
FROM course c
JOIN score sc ON sc.course_id = c.course_id
GROUP BY c.course_id
HAVING COUNT(*) >= 2
ORDER BY avg_points DESC;

-- 4. Students enrolled in a course they have no score for yet.
SELECT s.full_name, c.code, c.title
FROM enrolment e
JOIN student s ON s.student_id = e.student_id
JOIN course  c ON c.course_id  = e.course_id
WHERE NOT EXISTS (
  SELECT 1 FROM score sc
  WHERE sc.student_id = e.student_id
    AND sc.course_id  = e.course_id
)
ORDER BY s.full_name, c.code;

-- 5. Cohort-level summary.
SELECT s.cohort,
       ROUND(AVG(sc.points), 1)     AS cohort_avg,
       COUNT(DISTINCT sc.course_id) AS courses_scored
FROM student s
JOIN score sc ON sc.student_id = s.student_id
GROUP BY s.cohort
ORDER BY cohort_avg DESC;
