#!/usr/bin/env bash
# Pre-publish audit. Writes PRE-FLIGHT.md.
cd "$(dirname "$0")/.."

echo "# Pre-flight audit"
echo
echo "Generated: $(date -u '+%Y-%m-%d %H:%M UTC')"
echo

echo "## 1. Empty files"
echo '```'
hits="$(find . -type f -empty -not -path './.git/*' -not -name '.gitignore')"
if [ -z "$hits" ]; then echo "OK - no empty files"; else echo "$hits"; fi
echo '```'
echo

echo "## 2. Credential scan"
echo '```'
grep -rniE '(pass(word|wd)|secret|api[_-]?key|bearer|token|BEGIN [A-Z ]*PRIVATE KEY)' \
  --include='*.md' --include='*.js' --include='*.jsx' --include='*.py' \
  --include='*.java' --include='*.sql' --include='*.html' --include='*.scss' \
  --include='*.css' --include='*.sh' . \
  | grep -v 'PRE-FLIGHT.md' || echo "no matches"
echo '```'
echo

echo "## 3. Machine-specific paths"
echo '```'
grep -rn '/workspaces/\|/Users/\|localhost:[0-9]' . --exclude-dir=.git --exclude='PRE-FLIGHT.md' || echo "no matches"
echo '```'
echo

echo "## 4. Ignored junk and large files"
echo '```'
find . \( -name '.DS_Store' -o -name 'node_modules' -o -size +1M \) \
  -not -path './.git/*' -not -path './node_modules/*' || true
echo '```'
echo

echo "## 5. Commit identity"
echo '```'
git log --format='%an <%ae>' | sort -u
echo '```'
echo

echo "## 6. Executable checks"
echo '```'
./tools/run-all.sh
echo '```'
