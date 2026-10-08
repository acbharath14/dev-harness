# Runbook: new project

TASK: Spin up a new repo from the dev-harness templates.
NAME: <repo-name>
STACK: <python | node | other>

PROCESS:
1. Copy from dev-harness/templates/:
   - README.template.md → README.md (fill in)
   - AGENTS.template.md → AGENTS.md (fill in)
   - STATUS.template.md → STATUS.md (fill in "Where things stand")
   - ci-python.yml or ci-node.yml → keep as reference (workflow itself
     goes via GitHub web UI later)
   - LICENSE-MIT → LICENSE (fill in year/name)
2. Create the GitHub repo (public/private as decided), empty, no auto-init.
3. Add it to the GitHub App's repository selection if agent pushes are needed.
4. Push the skeleton. Verify the repo page renders.
5. Paste the CI workflow content via web UI; verify the first run.

VERIFY (paste back):
- Repo URL.
- Screenshot or statement that README renders correctly.
- CI run URL (green).
- STATUS.md "Next actions" seeded with the first real tasks.
