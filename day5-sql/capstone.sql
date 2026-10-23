-- Capstone: one query, one report.
-- Best-performing cohort per course, ranked, with a pass rate alongside.
WITH per_student_course AS (
  SELECT s.student_id,
         s.cohort,
         sc.course_id,
         AVG(sc.points) AS avg_points
  FROM student s
  JOIN score sc ON sc.student_id = s.student_id
  GROUP BY s.student_id, sc.course_id
),
cohort_course AS (
  SELECT c.code  AS course_code,
         c.title AS course_title,
         p.cohort,
         ROUND(AVG(p.avg_points), 1) AS cohort_avg,
         COUNT(*)                    AS students
  FROM per_student_course p
  JOIN course c ON c.course_id = p.course_id
  GROUP BY c.course_id, p.cohort
)
SELECT course_code,
       course_title,
       cohort,
       cohort_avg,
       students,
       RANK() OVER (PARTITION BY course_code ORDER BY cohort_avg DESC) AS rank_in_course
FROM cohort_course
ORDER BY course_code, rank_in_course;

-- Pass rate per course, as a second report.
SELECT c.code AS course_code,
       COUNT(*) AS assessments,
       SUM(CASE WHEN sc.points >= 50 THEN 1 ELSE 0 END) AS passes,
       ROUND(100.0 * SUM(CASE WHEN sc.points >= 50 THEN 1 ELSE 0 END) / COUNT(*), 1) AS pass_rate_pct
FROM course c
JOIN score sc ON sc.course_id = c.course_id
GROUP BY c.course_id
ORDER BY pass_rate_pct DESC;
