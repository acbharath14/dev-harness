#!/usr/bin/env bash
# repo-health.sh — exception report across managed repos.
# Surfaces only what needs a human. Run weekly via cron or on demand.
# Requires: gh CLI, authenticated.
set -u

REPOS="${REPOS:-acbharath14/enterprise-qa-automation-blueprint acbharath14/sidekick-rag-assistant acbharath14/contract-testing acbharath14/quality-gates acbharath14/linkshortenerproject}"

for r in $REPOS; do
  echo "### $r"
  echo "-- open PRs:"
  gh pr list --repo "$r" --limit 10 \
    --json number,title,headRefName \
    --jq '.[] | "  #\(.number) \(.title) [\(.headRefName)]"' 2>&1 | head -12
  echo "-- recent CI (main):"
  gh run list --repo "$r" --branch main --limit 3 \
    --json conclusion,name,createdAt \
    --jq '.[] | "  \(.conclusion) \(.name) \(.createdAt)"' 2>&1 | head -5
  echo ""
done
