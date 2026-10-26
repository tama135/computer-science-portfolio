# Computer Science Portfolio

This is a computer science portfolio with practical work in frontend development,
JavaScript, Python, Java, React, and SQL.

The four examples below are the ones worth reading. The complete inventory is in
[`APPENDIX.md`](APPENDIX.md), and the pre-publish audit is in
[`PRE-FLIGHT.md`](PRE-FLIGHT.md).

## What's here

| Day | Folder | Deliverable | Demonstrates |
|---|---|---|---|
| 1 | `day1-frontend/` | Semantic page, stylesheets, style guide | HTML structure, CSS/SCSS tokens and mixins, documented design system |
| 2 | `day2-javascript/` | Glossary, array filter, DOM event, form, quiz | JS fundamentals, DOM events, form handling, state |
| 3 | `day3-python-java/` | Python and Java exercises | Control flow, classification logic, boundary tests, OOP |
| 4 | `day4-java-react/` | Java stats, React components | Java practice, JSX, props, state, composition |
| 5 | `day5-sql/` | Schema, tiered queries, annotations, capstone | Normalisation, joins, aggregates, indexing, query plans |

## How to run

Needs `node`, `python3`, `javac`/`java`, `sqlite3`. From the repo root:

    ./tools/run-all.sh      # runs every JS, Python, Java and SQL file
    ./tools/preflight.sh    # full audit, writes PRE-FLIGHT.md

| File | Command |
|---|---|
| `day1-frontend/index.html` | `python3 -m http.server 8000`, then open `/day1-frontend/` |
| `day2-javascript/filter-courses.js` | `node day2-javascript/filter-courses.js` |
| `day2-javascript/flashcard-quiz.js` | `node day2-javascript/flashcard-quiz.js` |
| `day2-javascript/tip-button.html` | browser, via the local server |
| `day2-javascript/form.html` | browser, via the local server |
| `day3-python-java/scores_summary.py` | `python3 day3-python-java/scores_summary.py` |
| `day3-python-java/classify.py` | `python3 day3-python-java/classify.py` |
| `day3-python-java/course_catalog.py` | `python3 day3-python-java/course_catalog.py` |
| `day3-python-java/ScoreCategory.java` | `javac ScoreCategory.java && java ScoreCategory` |
| `day3-python-java/Course.java` | `javac Course.java && java Course` |
| `day4-java-react/ScoreStats.java` | `javac ScoreStats.java && java ScoreStats` |
| `day4-java-react/react/*.jsx` | needs a React toolchain (Vite) |
| `day5-sql/*.sql` | `sqlite3 portfolio.db < day5-sql/schema.sql`, then pipe the query files |

## Selected examples

### 1. Frontend — semantic page

`day1-frontend/index.html` — landmark elements, heading hierarchy, accessible markup.

**File:** `day1-frontend/index.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Computer Science Portfolio — Course Catalogue</title>
  <meta name="description" content="Course catalogue landing page built with semantic HTML and a token-driven stylesheet.">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <a class="skip-link" href="#main">Skip to content</a>

  <header class="site-header">
    <p class="brand">Computer Science Portfolio</p>
    <nav class="site-nav" aria-label="Primary">
      <ul>
        <li><a href="#courses" aria-current="page">Courses</a></li>
        <li><a href="#tracks">Tracks</a></li>
      </ul>
    </nav>
  </header>

  <main id="main">
    <section class="hero" aria-labelledby="hero-heading">
      <h1 id="hero-heading">Learn the stack, end to end</h1>
      <p class="lede">
        Five short tracks that take you from semantic markup to a normalised
        database, with a runnable example at every step.
      </p>
      <p><a class="button" href="#courses">Browse courses</a></p>
    </section>

    <section id="courses" aria-labelledby="courses-heading">
      <h2 id="courses-heading">Courses</h2>

      <ul class="card-grid">
        <li>
          <article class="card">
            <h3>Web Fundamentals</h3>
            <p class="code">WEB101 · 6 credits</p>
            <p>Structure, semantics, and a design system you can maintain.</p>
          </article>
        </li>
        <li>
          <article class="card">
            <h3>Data Structures</h3>
            <p class="code">CS201 · 8 credits</p>
            <p>Lists, maps, and the real cost of each choice you make.</p>
          </article>
        </li>
        <li>
          <article class="card">
            <h3>Databases</h3>
            <p class="code">DB210 · 6 credits</p>
            <p>Normalisation, joins, and query plans on a working schema.</p>
          </article>
        </li>
      </ul>
    </section>

    <section id="tracks" aria-labelledby="tracks-heading">
      <h2 id="tracks-heading">Tracks</h2>
      <dl class="track-list">
        <dt>Frontend</dt>
        <dd>Semantic HTML, token-driven CSS, and an SCSS partial structure.</dd>
        <dt>Scripting</dt>
        <dd>Array methods, DOM events, form validation, small state machines.</dd>
        <dt>Backend</dt>
        <dd>Python and Java exercises with explicit boundary tests.</dd>
      </dl>
    </section>
  </main>

  <footer class="site-footer">
    <p><small>Computer Science Portfolio</small></p>
  </footer>
</body>
</html>
```

### 2. Programming — Python classification

`day3-python-java/classify.py` — branch logic with explicit boundary handling.

**File:** `day3-python-java/classify.py`

```python
"""Classify a numeric score, with explicit boundary tests.

Run: python3 day3-python-java/classify.py
"""

FAIL, PASS, MERIT, DISTINCTION = "Fail", "Pass", "Merit", "Distinction"


def classify(score):
    """Band a score. Lower bound inclusive, upper bound exclusive.

    0-49 Fail, 50-69 Pass, 70-84 Merit, 85-100 Distinction.
    """
    if isinstance(score, bool) or not isinstance(score, (int, float)):
        raise TypeError(f"expected a number, got {type(score).__name__}")
    if score < 0 or score > 100:
        raise ValueError(f"score out of range: {score}")
    if score < 50:
        return FAIL
    if score < 70:
        return PASS
    if score < 85:
        return MERIT
    return DISTINCTION


def main():
    print("boundary table")
    for score in (0, 49, 50, 69, 70, 84, 85, 100):
        print(f"  {score:>3} -> {classify(score)}")

    print("\nout-of-range values")
    for bad in (-1, 101):
        try:
            classify(bad)
            print(f"  {bad:>3} -> no error (bug)")
        except ValueError as exc:
            print(f"  {bad:>3} -> {exc}")

    print("\nwrong type")
    try:
        classify("88")
    except TypeError as exc:
        print(f"  '88' -> {exc}")


if __name__ == "__main__":
    main()
```

### 3. React — component with props

`day4-java-react/react/CourseCard.jsx` — presentational component, props contract, JSX.

**File:** `day4-java-react/react/CourseCard.jsx`

```jsx
import React from 'react';

// Presentational: reads props, renders, raises events upward. Holds no state.
export default function CourseCard({ course, onEnrol }) {
  const { id, code, title, credits, seats } = course;
  const isFull = seats === 0;

  return (
    <article className="card" aria-labelledby={`title-${id}`}>
      <h2 id={`title-${id}`}>{title}</h2>
      <p className="meta">
        <span className="code">{code}</span>
        {' · '}
        {credits} credits
        {' · '}
        {isFull ? 'full' : `${seats} seats left`}
      </p>
      <button type="button" onClick={() => onEnrol(id)} disabled={isFull}>
        {isFull ? 'Full' : 'Enrol'}
      </button>
    </article>
  );
}
```

### 4. SQL — analytical query

`day5-sql/queries-level2.sql` — joins and aggregation against `day5-sql/schema.sql`.

**File:** `day5-sql/queries-level2.sql`

```sql
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
```

## Complete repository

**https://github.com/tama135/computer-science-portfolio**

Every file is browsable there. [`APPENDIX.md`](APPENDIX.md) lists them all.
## Notes

- Filenames are given in full wherever they are referenced.
- Everything runs from the repo root with relative paths.
- `README.md` and `APPENDIX.md` are generated. Rebuild them after edits with:
  `bash tools/build-readme.sh > README.md`
  and `bash tools/build-appendix.sh > APPENDIX.md`.
