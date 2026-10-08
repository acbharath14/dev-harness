# Runbook: dependency bump

TASK: Update project dependencies safely.
REPO: <repo>
SCOPE: <all | named packages>

CONSTRAINTS:
- Pin versions in requirements/package files. No floating ranges for
  direct dependencies.
- On Intel Macs: keep known-good pins (document why in a comment).
- No secrets in dependency config.

PROCESS:
1. List current vs latest for each in-scope package.
2. Update one at a time (or in small groups for related packages).
3. Run the full test suite after each group.
4. If something breaks: bisect to the exact package, then decide —
   pin back and file an issue, or adapt the code.

VERIFY (paste back):
- Before/after version table.
- Test result after the bump (pass count).
- Any pins held back, with reason.
