-- Level 3: read the query plan, annotate it, then fix what it reveals.
-- Run with: sqlite3 portfolio.db < day5-sql/annotations-level3.sql

.print === 1. Lookup by primary key: expect SEARCH ... USING INTEGER PRIMARY KEY
EXPLAIN QUERY PLAN
SELECT * FROM student WHERE student_id = 2;

.print
.print === 2. Filter on an unindexed column: expect SCAN student
EXPLAIN QUERY PLAN
SELECT * FROM student WHERE cohort = '2026-A';

.print
.print === 3. Join on an indexed foreign key: expect SEARCH ... idx_score_course
EXPLAIN QUERY PLAN
SELECT c.code, AVG(sc.points)
FROM course c
JOIN score sc ON sc.course_id = c.course_id
GROUP BY c.course_id;

.print
.print === 4. Fix for query 2: add a covering index on the filtered column
CREATE INDEX IF NOT EXISTS idx_student_cohort ON student(cohort);

.print
.print === 5. Re-check the plan for query 2: the SCAN is now a SEARCH
EXPLAIN QUERY PLAN
SELECT * FROM student WHERE cohort = '2026-A';

.print
.print === 6. Aggregation without a supporting index: expect SCAN + temp B-tree
EXPLAIN QUERY PLAN
SELECT cohort, COUNT(*) FROM student GROUP BY cohort;
