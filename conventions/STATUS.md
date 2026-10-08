# STATUS.md — format spec

`STATUS.md` is the durable memory for a project. It lives at repo root. It is the
*only* place project state lives — not in chat history, not in anyone's head.

## Format

```markdown
# STATUS — <project-name>
_Last updated: YYYY-MM-DD HH:MM TZ_

## Where things stand
<3–6 bullets. Facts only. Link PRs, CI runs, docs.>

## Next actions (ordered)
1. <concrete, verifiable step>
2. …

## Blocked on
- <blocker> — <owner> — <since YYYY-MM-DD>

## Decisions made
- YYYY-MM-DD: <decision> — <why, one line>

## Don't
<anti-patterns learned the hard way>
```

## Rules

1. **Updated at the end of every work session**, before context is lost. Stale status is worse than none — it misleads.
2. **"Next actions" must be verifiable.** A URL, a file, a test result. Never "look into X" — that's a wish, not an action.
3. **Blocked items name an owner and a date.** Ownerless blockers get deleted or assigned within one session.
4. **"Where things stand" links evidence.** PR numbers, CI run URLs, doc paths. Claims without links are rumors.
5. **"Don't" accumulates scar tissue.** Every painful lesson goes here in one line, so the next session doesn't re-learn it.

## Anti-patterns

- Status as narrative ("we've been working hard on…"). Facts only.
- Next actions without an owner when there's more than one contributor.
- Letting "Blocked on" grow without resolution — review it every session.
