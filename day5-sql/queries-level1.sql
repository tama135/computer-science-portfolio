-- Level 1: single-table SELECT, WHERE, ORDER BY, LIMIT, aggregates.

-- 1. Every course, cheapest credits first.
SELECT code, title, credits
FROM course
ORDER BY credits ASC, code ASC;

-- 2. Course code and title where the title or code matches.
SELECT code, title
FROM course
WHERE title LIKE '%Data%' OR code LIKE 'CS%';

-- 3. The three most recent enrolment rows.
SELECT s.full_name, c.code, e.enrolled_on
FROM enrolment e
JOIN student s ON s.student_id = e.student_id
JOIN course  c ON c.course_id  = e.course_id
ORDER BY e.enrolled_on DESC
LIMIT 3;

-- 4. Headline counts.
SELECT (SELECT COUNT(*) FROM student)              AS students,
       (SELECT COUNT(DISTINCT cohort) FROM student) AS cohorts,
       (SELECT ROUND(AVG(credits), 1) FROM course)  AS avg_credits;

-- 5. Score distribution in 10-point buckets.
SELECT (points / 10) * 10 AS bucket,
       COUNT(*)           AS n
FROM score
GROUP BY bucket
ORDER BY bucket;
