#!/usr/bin/env bash
# Executes every runnable deliverable. Non-zero exit means something is broken.
cd "$(dirname "$0")/.."
fail=0

echo "=== JavaScript ==="
for f in day2-javascript/*.js; do
  [ -e "$f" ] || continue
  echo "> node $f"
  node "$f" || fail=1
done

echo "=== Python ==="
for f in day3-python-java/*.py; do
  [ -e "$f" ] || continue
  echo "> python3 $f"
  python3 "$f" || fail=1
done

echo "=== Java ==="
for f in day3-python-java/*.java day4-java-react/*.java; do
  [ -e "$f" ] || continue
  cls="$(basename "$f" .java)"
  d="$(mktemp -d)"
  echo "> javac $f && java $cls"
  javac -d "$d" "$f" && java -cp "$d" "$cls" || fail=1
  rm -rf "$d"
done

echo "=== SQL ==="
db="$(mktemp -u).db"
sqlite3 "$db" < day5-sql/schema.sql || fail=1
for f in day5-sql/queries-level1.sql day5-sql/queries-level2.sql \
         day5-sql/annotations-level3.sql day5-sql/capstone.sql; do
  [ -e "$f" ] || continue
  echo "> sqlite3 < $f"
  sqlite3 "$db" < "$f" >/dev/null || fail=1
done
rm -f "$db"

echo "=== React (parse and import resolution) ==="
npx --yes esbuild day4-java-react/react/App.jsx \
  --bundle --jsx=transform --external:react --external:react-dom \
  --outfile=/dev/null || fail=1

echo
if [ "$fail" -eq 0 ]; then echo "ALL CHECKS PASSED"; else echo "SOME CHECKS FAILED"; fi
exit "$fail"
