# dev-harness

The outer harness for building software with AI agents across many projects without babysitting every step.

**Problem:** N projects, every task re-decided from scratch — README structure, CI setup, PR checklists, "is this done?" — leading to decision fatigue.

**Solution:** Convert repeated decisions into one-time designs.
- `templates/` — new projects start from a skeleton, not a blank page.
- `conventions/` — durable-memory formats (`STATUS.md`) so state lives in files, not heads.
- `runbooks/` — paste-ready prompts for recurring tasks. Done twice → write it down. Third time → paste, don't re-explain.
- `scripts/` — the Ralph loop and repo health checks.

**Principles:** enforce, don't instruct · replace trust with evidence · files are the memory · boring over clever.

## 5-minute start

1. New project? Copy `templates/` → new repo, follow `runbooks/new-project.md`.
2. Existing project? Drop in `templates/STATUS.template.md`, fill it, keep it current.
3. Recurring task? Check `runbooks/` first. Not there? Do it once, then write the runbook.

## How to use the runbooks

Each file in `runbooks/` is a **complete prompt designed to be pasted into an AI assistant** (Claude, ChatGPT, Copilot, etc.). They are not documentation to read — they are instructions to execute.

**To use one:**

1. Open the runbook file (e.g. `runbooks/ci-fix.md`).
2. Fill in the `<placeholders>` at the top (repo name, URLs, etc.).
3. Paste the entire file into your AI assistant as the task prompt.
4. The assistant follows the PROCESS steps and returns the VERIFY items.

**Example** — fixing a broken CI run:

```
# Copy runbooks/ci-fix.md, fill in:
REPO: my-org/my-app
RUN URL: https://github.com/my-org/my-app/actions/runs/12345

# Paste the whole thing into your AI assistant.
# It will diagnose, fix, push, and report back with:
# - Root cause in one sentence
# - The diff of the fix
# - Green CI run URL
```

**Available runbooks:**

| Runbook | When to use |
|---|---|
| `new-project.md` | Scaffolding a new repo from templates |
| `readme-upgrade.md` | Rewriting a README for novice onboarding |
| `ci-fix.md` | Diagnosing and fixing a failing CI run |
| `dependency-bump.md` | Updating dependencies safely |
| `pr-review-prep.md` | Preparing a PR for review |

**Writing your own:** when you do something twice, write it down using the same format — TASK, placeholders, CONSTRAINTS, PROCESS (numbered steps), VERIFY (what to paste back). The third time, you paste instead of re-explaining.

## Scripts

### `scripts/ralph.sh` — autonomous agent loop

Runs an AI agent repeatedly with the same prompt until it reports completion. Each iteration starts with fresh context; the files are the memory.

**When to use:** long multi-step tasks where you want the agent to keep going without babysitting — e.g. "migrate all tests to the new framework" or "fix every lint error."

**Usage:**

```bash
./scripts/ralph.sh PROMPT.md --done "ALL TASKS DONE" --max 20 --agent "claude -p"
```

| Flag | Default | Meaning |
|---|---|---|
| `PROMPT.md` | (required) | File containing the task prompt, repeated each iteration |
| `--done` | `"ALL TASKS DONE"` | Completion promise — loop exits when agent output contains this string |
| `--max` | `20` | Maximum iterations before giving up |
| `--agent` | `"claude -p"` | Agent command (must accept the prompt as an argument) |

**How it works:**
1. Reads the prompt file once.
2. Runs the agent with the prompt, captures output.
3. If output contains the `--done` string → exits 0 (success).
4. Otherwise repeats with a fresh agent invocation, up to `--max` times.
5. Exits 1 if max iterations reached without the completion promise.

**Writing a good PROMPT.md:** the prompt must instruct the agent to (a) check what's already done by reading the repo state, (b) do the next unit of work, and (c) print the exact `--done` string only when everything is complete. Without (a), iterations redo work. Without (c), the loop never exits.

### `scripts/repo-health.sh` — portfolio exception report

One-page status across all your repos: open PRs and recent CI results on `main`. Surfaces only what needs a human.

**When to use:** weekly review, or on demand before a planning session. Run it, read the exceptions, ignore the rest.

**Usage:**

```bash
# Uses the default repo list, or override:
REPOS="my-org/app1 my-org/app2" ./scripts/repo-health.sh
```

**Prerequisites:** [GitHub CLI](https://cli.github.com/) installed and authenticated (`gh auth login`).

**Output per repo:**
- Open PRs (number, title, branch)
- Last 3 CI runs on `main` (conclusion, workflow name, timestamp)

**Customizing:** set the `REPOS` environment variable to a space-separated list of `owner/repo` slugs. To run weekly automatically, add a cron entry:

```bash
# Weekly Monday 9am health check
0 9 * * 1 /path/to/dev-harness/scripts/repo-health.sh
```

## Worked example: scaffolding a new project

Starting a new Python API from zero:

```bash
# 1. Create the empty repo on GitHub (no README, no .gitignore)

# 2. Copy the skeleton
cp dev-harness/templates/README.template.md my-api/README.md
cp dev-harness/templates/AGENTS.template.md my-api/AGENTS.md
cp dev-harness/templates/STATUS.template.md my-api/STATUS.md
cp dev-harness/templates/LICENSE-MIT my-api/LICENSE
cp dev-harness/templates/ci-python.yml /tmp/ci-reference.yml  # for later

# 3. Fill in the placeholders (project name, description, etc.)

# 4. Push
cd my-api && git init && git add -A && git commit -m "scaffold from dev-harness"
git remote add origin git@github.com:my-org/my-api.git
git push -u origin main

# 5. Add the CI workflow via GitHub web UI
#    (paste the content of /tmp/ci-reference.yml into .github/workflows/ci.yml)

# 6. Seed STATUS.md "Next actions" with the first real tasks
```

Or paste `runbooks/new-project.md` (filled in) into your AI assistant and let it do steps 2–6.

## Layout

| Dir | What |
|---|---|
| `templates/` | README, AGENTS.md, STATUS.md, CI workflows, MIT license starters |
| `conventions/` | Format specs (how STATUS.md works) |
| `runbooks/` | Paste-ready AI prompts: readme-upgrade, ci-fix, dependency-bump, new-project, pr-review-prep |
| `scripts/` | `ralph.sh` (autonomous agent loop), `repo-health.sh` (portfolio exception report) |
| `examples/` | Real STATUS.md from a live project |

## Status

Pilot project: `sidekick-rag-assistant` (see `examples/sidekick-STATUS.md`).
