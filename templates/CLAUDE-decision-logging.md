## Decision logging (always on)

Whenever you ask me to choose between options, or you make a non-trivial
implementation/architecture/dependency choice on your own, record it in
`docs/DECISIONS.md` **in the same turn the decision is settled** — do not wait
to be asked and do not batch them up.

For each decision, append one entry using the exact format already in
`docs/DECISIONS.md`. Capture:

- a one-line statement of the decision
- every option that was on the table, each with its real tradeoff (cost, speed,
  complexity, lock-in, explainability — whatever actually applied)
- which option we chose and the concrete reason we chose it
- the build phase / file it relates to

Rules:

- Number entries sequentially: D-001, D-002, ...
- **Never edit or delete a past entry.** If we later reverse a decision, add a
  NEW entry and set the old one's status to `Superseded by D-0XX`. The point is
  to keep the full trail of why we changed our mind.
- If a choice was trivial (naming, formatting), skip it — only log things a
  future reader (or an interviewer) would ask "why did you do it that way?"
  about.
- After logging, mention in one line that you've recorded it, e.g.
  "Logged as D-007."
