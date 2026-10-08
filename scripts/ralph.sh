#!/usr/bin/env bash
# ralph.sh — repeat an agent session until the completion promise appears.
# Same prompt, fresh context per iteration. The files are the memory.
#
# Usage: ./ralph.sh PROMPT.md --done "ALL TASKS DONE" --max 20 --agent "claude -p"
set -u

PROMPT_FILE="$1"; shift
DONE="ALL TASKS DONE"; MAX=20; AGENT="claude -p"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --done)  DONE="$2";  shift 2;;
    --max)   MAX="$2";   shift 2;;
    --agent) AGENT="$2"; shift 2;;
    *) echo "unknown arg: $1"; exit 1;;
  esac
done

PROMPT="$(cat "$PROMPT_FILE")"

for ((i=1; i<=MAX; i++)); do
  echo "=== ralph iteration $i/$MAX ==="
  OUT="$($AGENT "$PROMPT" 2>&1)"
  echo "$OUT" | tail -20
  if echo "$OUT" | grep -q "$DONE"; then
    echo "=== completion promise detected after $i iterations ==="
    exit 0
  fi
done

echo "=== max iterations reached without completion promise ==="
exit 1
