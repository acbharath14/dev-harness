# Runbook: PR review prep

TASK: Prepare a pull request for human review.
REPO: <repo>
BRANCH: <branch>

CONSTRAINTS:
- The reviewer should need zero context beyond the PR description.
- No secrets, tokens, or credentials in the diff.

PROCESS:
1. Re-read the diff in full. Every hunk must be intentional.
2. Run the project's test command; note the result.
3. Write the PR description:
   - What changed (3–5 bullets).
   - Why (link the issue / decision).
   - How verified (test output, screenshots, URLs).
   - Anything the reviewer should look at closely.
4. Check: CI green on the branch before requesting review.
5. Update STATUS.md (move the item from "Next actions" to "Where things stand"
   once merged, not before).

VERIFY (paste back):
- PR URL.
- CI status on the branch.
- One-line summary a stranger could understand.
