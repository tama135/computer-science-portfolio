-- Normalised schema: instructors, courses, students, enrolments, scores.
-- Target: SQLite. Run with: sqlite3 portfolio.db < day5-sql/schema.sql
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS score;
DROP TABLE IF EXISTS enrolment;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS instructor;

CREATE TABLE instructor (
  instructor_id INTEGER PRIMARY KEY,
  full_name     TEXT NOT NULL,
  email         TEXT NOT NULL UNIQUE
);

CREATE TABLE course (
  course_id     INTEGER PRIMARY KEY,
  code          TEXT    NOT NULL UNIQUE,
  title         TEXT    NOT NULL,
  credits       INTEGER NOT NULL CHECK (credits BETWEEN 1 AND 12),
  instructor_id INTEGER NOT NULL REFERENCES instructor(instructor_id)
);

CREATE TABLE student (
  student_id INTEGER PRIMARY KEY,
  full_name  TEXT NOT NULL,
  cohort     TEXT NOT NULL,
  email      TEXT NOT NULL UNIQUE
);

CREATE TABLE enrolment (
  student_id  INTEGER NOT NULL REFERENCES student(student_id),
  course_id   INTEGER NOT NULL REFERENCES course(course_id),
  enrolled_on TEXT    NOT NULL DEFAULT (date('now')),
  PRIMARY KEY (student_id, course_id)
);

CREATE TABLE score (
  score_id    INTEGER PRIMARY KEY,
  student_id  INTEGER NOT NULL REFERENCES student(student_id),
  course_id   INTEGER NOT NULL REFERENCES course(course_id),
  assessment  TEXT    NOT NULL,
  points      INTEGER NOT NULL CHECK (points BETWEEN 0 AND 100),
  recorded_on TEXT    NOT NULL DEFAULT (date('now'))
);

CREATE INDEX idx_score_course  ON score(course_id);
CREATE INDEX idx_score_student ON score(student_id);
CREATE INDEX idx_enrol_course  ON enrolment(course_id);

INSERT INTO instructor (full_name, email) VALUES
  ('A. Okafor',    'a.okafor@example.com'),
  ('M. Lindqvist', 'm.lindqvist@example.com');

INSERT INTO course (code, title, credits, instructor_id) VALUES
  ('WEB101', 'Web Fundamentals', 6, 1),
  ('CS201',  'Data Structures',  8, 2),
  ('DB210',  'Databases',        6, 2);

INSERT INTO student (full_name, cohort, email) VALUES
  ('R. Patel',    '2026-A', 'r.patel@example.com'),
  ('S. Nakamura', '2026-A', 's.nakamura@example.com'),
  ('T. Bello',    '2026-B', 't.bello@example.com');

INSERT INTO enrolment (student_id, course_id) VALUES
  (1,1),(1,3),(2,1),(2,2),(3,3);

INSERT INTO score (student_id, course_id, assessment, points) VALUES
  (1,1,'Midterm',72),(1,1,'Final',81),
  (2,1,'Midterm',88),(2,1,'Final',91),
  (2,2,'Midterm',65),(2,2,'Final',70),
  (1,3,'Final',79),
  (3,3,'Final',54);
