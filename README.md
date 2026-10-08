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

## Layout

| Dir | What |
|---|---|
| `templates/` | README, AGENTS.md, STATUS.md, CI workflows, MIT license starters |
| `conventions/` | Format specs (how STATUS.md works) |
| `runbooks/` | Complete prompts: readme-upgrade, ci-fix, dependency-bump, new-project, pr-review-prep |
| `scripts/` | `ralph.sh` (agent loop), `repo-health.sh` (exception report) |
| `examples/` | Real STATUS.md from a live project |

## Status

Pilot project: `sidekick-rag-assistant` (see `examples/sidekick-STATUS.md`).
