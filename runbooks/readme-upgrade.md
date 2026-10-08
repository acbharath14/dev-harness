# Runbook: README upgrade

TASK: Rewrite README.md for first-time novice onboarding.
REPO: <repo>

CONSTRAINTS (standing rules — do not violate):
- Reflect ONLY current, verified behavior. No aspirational claims
  (no CI/Pages badges until live, no roadmaps presented as done).
- Written for a first-time novice tester: explain structure, what each
  part covers, how to adapt it to their own use case.
- No real credentials, secrets, or confidential data anywhere.

PROCESS:
1. Read the repo tree and the current README.
2. Verify every claimed behavior (run the tests / open the live URLs).
3. Rewrite. Keep it scannable: what it is, quickstart, structure map,
   how to adapt, how to extend, troubleshooting.
4. Update the repo's STATUS.md "Where things stand" with the README change.

VERIFY (paste back):
- The full new README.
- For each major claim: the evidence (test output line, live URL + HTTP code).
- Explicit list of anything you could NOT verify (goes in as "not yet"
  or is omitted — never asserted).
