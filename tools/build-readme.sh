#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

REPO_URL="$(git remote get-url origin 2>/dev/null \
  | sed -e 's#^git@github.com:#https://github.com/#' -e 's#\.git$##')"
[ -n "$REPO_URL" ] || { echo "No git remote 'origin'." >&2; exit 1; }

show () { printf '\n**File:** `%s`\n\n```%s\n' "$2" "$1"; cat "$2"; printf '```\n\n'; }

cat <<'HEAD'
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
HEAD

echo
echo '`day1-frontend/index.html` — landmark elements, heading hierarchy, accessible markup.'
show html day1-frontend/index.html

cat <<'HEAD'
### 2. Programming — Python classification
HEAD
echo
echo '`day3-python-java/classify.py` — branch logic with explicit boundary handling.'
show python day3-python-java/classify.py

cat <<'HEAD'
### 3. React — component with props
HEAD
echo
echo '`day4-java-react/react/CourseCard.jsx` — presentational component, props contract, JSX.'
show jsx day4-java-react/react/CourseCard.jsx

cat <<'HEAD'
### 4. SQL — analytical query
HEAD
echo
echo '`day5-sql/queries-level2.sql` — joins and aggregation against `day5-sql/schema.sql`.'
show sql day5-sql/queries-level2.sql

cat <<'HEAD'
## Complete repository
HEAD
echo
echo "**$REPO_URL**"
echo
echo 'Every file is browsable there. [`APPENDIX.md`](APPENDIX.md) lists them all.'

cat <<'HEAD'
## Notes

- Filenames are given in full wherever they are referenced.
- Everything runs from the repo root with relative paths.
- `README.md` and `APPENDIX.md` are generated. Rebuild them after edits with:
  `bash tools/build-readme.sh > README.md`
  and `bash tools/build-appendix.sh > APPENDIX.md`.
HEAD
