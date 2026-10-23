# Pre-flight audit

Generated: 2026-10-23 21:44 UTC

## 1. Empty files
```
OK - no empty files
```

## 2. Credential scan
```
./day1-frontend/STYLE-GUIDE.md:5:1. **Tokens first.** No raw hex, no magic pixel values in components. If a value
./day1-frontend/STYLE-GUIDE.md:6:   is not in `_tokens.scss`, add it there before you use it.
./day1-frontend/STYLE-GUIDE.md:15:| Token | Value | Use |
./day1-frontend/STYLE-GUIDE.md:50:| `_tokens.scss` | Colour, type, space, breakpoints, token emitter. |
./day1-frontend/STYLE-GUIDE.md:61:1. Add any new values to `_tokens.scss`.
./day1-frontend/styles.scss:3:@use "tokens" as t;
./day1-frontend/styles.scss:7:  @include t.emit-tokens;
./day1-frontend/styles.css:1:/* Compiled from styles.scss. Token values mirror _tokens.scss. */
./day1-frontend/_tokens.scss:1:// Design tokens. Single source of truth for colour, type, space, breakpoints.
./day1-frontend/_tokens.scss:35:@mixin emit-tokens {
./day1-frontend/index.html:7:  <meta name="description" content="Course catalogue landing page built with semantic HTML and a token-driven stylesheet.">
./day1-frontend/index.html:66:        <dd>Semantic HTML, token-driven CSS, and an SCSS partial structure.</dd>
./day1-frontend/_mixins.scss:2:@use "tokens" as t;
./tools/preflight.sh:19:grep -rniE '(pass(word|wd)|secret|api[_-]?key|bearer|token|BEGIN [A-Z ]*PRIVATE KEY)' \
./tools/build-readme.sh:26:| 1 | `day1-frontend/` | Semantic page, stylesheets, style guide | HTML structure, CSS/SCSS tokens and mixins, documented design system |
```

## 3. Machine-specific paths
```
./tools/preflight.sh:29:grep -rn '/workspaces/\|/Users/\|localhost:[0-9]' . --exclude-dir=.git --exclude='PRE-FLIGHT.md' || echo "no matches"
```

## 4. Ignored junk and large files
```
```

## 5. Commit identity
```
tama135 <48179858+tama135@users.noreply.github.com>
```

## 6. Executable checks
```
=== JavaScript ===
> node day2-javascript/filter-courses.js
Open courses:
SEC300 — Applied Security (8 cr, 2 seats)
DB210 — Databases (6 cr, 7 seats)
WEB101 — Web Fundamentals (6 cr, 12 seats)
JS110 — Scripting Basics (4 cr, 3 seats)

Codes grouped by level:
  intro     WEB101, JS110
  core      CS201, DB210
  advanced  SEC300

Total credits still open: 24
Courses with 2 or more seats: 4
> node day2-javascript/flashcard-quiz.js
2/5 correct — What does Array.prototype.filter return?
3/5 wrong   — Which operator compares without coercion?
4/5 correct — What is a closure?
5/5 wrong   — What does event delegation replace?
5/5 wrong   — Name the falsy values.

score: 2/5
missed: 3
=== Python ===
> python3 day3-python-java/classify.py
boundary table
    0 -> Fail
   49 -> Fail
   50 -> Pass
   69 -> Pass
   70 -> Merit
   84 -> Merit
   85 -> Distinction
  100 -> Distinction

out-of-range values
   -1 -> score out of range: -1
  101 -> score out of range: 101

wrong type
  '88' -> expected a number, got str
> python3 day3-python-java/course_catalog.py
catalogue
  WEB101  Web Fundamentals     1/30
  CS201   Data Structures      0/25
  DB210   Databases            2/3

guard checks
  duplicate enrol    R. Patel is already on WEB101
  fill to capacity   accepted
  over capacity      DB210 is full
  bad credits        XX1: credits must be 1-12, got 40
> python3 day3-python-java/scores_summary.py
      n: 10
   mean: 75.1
 median: 76.5
    low: 47
   high: 100
  range: 53
  bands: Distinction=4, Fail=1, Merit=2, Pass=3

band boundaries
    0 -> Fail
   49 -> Fail
   50 -> Pass
   69 -> Pass
   70 -> Merit
   84 -> Merit
   85 -> Distinction
  100 -> Distinction
=== Java ===
> javac day3-python-java/Course.java && java Course
DB210 - Databases (2/3 filled, 1 left)

guard checks
  duplicate -> S. Nakamura already enrolled
  after fill -> DB210 - Databases (3/3 filled, 0 left)
  over capacity -> Databases is full
> javac day3-python-java/ScoreCategory.java && java ScoreCategory
boundary table
    0 -> FAIL
   49 -> FAIL
   50 -> PASS
   69 -> PASS
   70 -> MERIT
   84 -> MERIT
   85 -> DISTINCTION
  100 -> DISTINCTION

out-of-range values
   -1 -> score out of range: -1
  101 -> score out of range: 101
> javac day4-java-react/ScoreStats.java && java ScoreStats
odd  n=5 mean=72.4 median=72.0 range=36
even n=4 mean=78.5 median=79.0 range=26

guard checks
  empty -> need at least one score
  defensive copy -> mean 20.0 (expected 20.0)
=== SQL ===
> sqlite3 < day5-sql/queries-level1.sql
> sqlite3 < day5-sql/queries-level2.sql
> sqlite3 < day5-sql/annotations-level3.sql
> sqlite3 < day5-sql/capstone.sql
=== React (parse and import resolution) ===

ALL CHECKS PASSED
```
