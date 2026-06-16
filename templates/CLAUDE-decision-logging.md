## Decision logging (always on, per app)

Whenever you ask me to choose between options, or you make a non-trivial
implementation/architecture/dependency choice on your own, record it **in the
same turn the decision is settled** — do not wait to be asked and do not batch
them up.

**Which file to log to.** Decisions live next to the code they affect:

- If the decision concerns a single app (a top-level package — recognised by
  `apps.py` / `models.py` / `__init__.py`, by already having a `DECISIONS.md`,
  or one I name), log it to that app's own `<app>/DECISIONS.md`.
- If it spans multiple apps or is project-wide (database, auth, settings,
  shared dependencies, tooling), log it to the top-level `docs/DECISIONS.md`.
- If the chosen app has no `DECISIONS.md` yet, create one — modeled on the
  header and format of `docs/DECISIONS.md`, with the app name as its scope.

**Numbering.** Each file numbers its entries independently with its own prefix:
the uppercased app name for a per-app log (`TICKET-001`, `CUSTOMER-002`, …) and
`GEN-001`, `GEN-002`, … for `docs/DECISIONS.md`. Find the highest existing
number in the **target file only** and use the next one — never scan other
files to compute it.

For each decision, append one entry using the exact format already in that
file. Capture:

- a one-line statement of the decision
- every option that was on the table, each with its real tradeoff (cost, speed,
  complexity, lock-in, explainability — whatever actually applied)
- which option we chose and the concrete reason we chose it
- the build phase / file it relates to

Rules:

- **Never edit or delete a past entry.** If we later reverse a decision, add a
  NEW entry (in whichever file owns it) and set the old one's status to
  `Superseded by <PREFIX>-0XX`. The point is to keep the full trail of why we
  changed our mind.
- A decision that touches several apps is logged **once** — in the owning app,
  or in `docs/DECISIONS.md` if it's genuinely cross-cutting — and may reference
  a related entry in another file by its prefixed id (e.g. "see `USER-004`").
- If a choice was trivial (naming, formatting), skip it — only log things a
  future reader (or an interviewer) would ask "why did you do it that way?"
  about.
- After logging, mention in one line where you recorded it, e.g.
  "Logged as TICKET-007."
