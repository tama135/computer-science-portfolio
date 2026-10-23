#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "# Appendix — complete file inventory"
echo
echo "Every deliverable in the repository. Generated $(date -u '+%Y-%m-%d')."

current=""
find . -type f -not -path './.git/*' -not -path './tools/*' \
  -not -name 'README.md' -not -name 'APPENDIX.md' -not -name 'PRE-FLIGHT.md' \
  -not -name '.gitignore' -print | sort | while read -r f; do
    rel="${f#./}"
    dir="$(dirname "$rel")"
    if [ "$dir" != "$current" ]; then
      printf '\n## `%s/`\n\n' "$dir"
      current="$dir"
    fi
    printf -- '- `%s` — %s bytes\n' "$rel" "$(wc -c < "$f" | tr -d ' ')"
  done

echo
echo '---'
echo
echo 'Back to [README](README.md).'
