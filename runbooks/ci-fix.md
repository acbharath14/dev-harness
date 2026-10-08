# Runbook: CI fix

TASK: Diagnose and fix a failing CI run.
REPO: <repo>
RUN URL: <failing run URL>

CONSTRAINTS:
- Fix the cause, not the symptom. Disabling a test to make CI green is
  allowed only if the test is proven wrong — say so explicitly.
- No secrets in logs or config. Workflow files go via GitHub web UI
  (the API cannot push .github/workflows/).

PROCESS:
1. Read the failing log. Identify the FIRST failure (cascades lie).
2. Reproduce locally if possible (same OS / same versions as CI).
3. Fix. If the fix is "retry" (flaky infra), say so and re-run rather
   than changing code.
4. Push and watch the new run to green. Paste the green run URL.

VERIFY (paste back):
- Root cause in one sentence.
- The diff (or description) of the fix.
- Green CI run URL.
- If flaky: what makes it flaky and what would fix it properly.
