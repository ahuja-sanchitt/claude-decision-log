---
description: Log a decision (and its tradeoffs) to the right app's DECISIONS.md
argument-hint: [optional short description of the decision]
allowed-tools: Read, Edit, Write, Glob
---

Record a decision in the decision log for the app it affects.

If I gave a description after the command, use it: $ARGUMENTS
If I didn't, look back over our recent conversation and identify the most
recent decision we settled that isn't logged yet.

Then:

1. **Pick the target file.** Decisions live next to the code they touch:
   - A decision about a single app → that app's `<app>/DECISIONS.md`. (An app
     is a top-level package: has `apps.py` / `models.py` / `__init__.py`,
     already has a `DECISIONS.md`, or one I name.)
   - A decision spanning apps or project-wide (DB, auth, settings, shared deps)
     → the top-level `docs/DECISIONS.md`.
   - If the chosen app has no `DECISIONS.md` yet, create it modeled on the
     header and format of `docs/DECISIONS.md`, using the app name as its scope.
2. Read that file and find the highest existing entry number **in that file
   only**. Each file has its own prefix: the uppercased app name for a per-app
   log (e.g. `TICKET-`), `GEN-` for `docs/DECISIONS.md`.
3. Append a new entry with the next number, following the exact format and
   table style used in that file.
4. Capture the real options that were on the table, the genuine tradeoff of
   each, the option we chose, and the concrete reason — not a generic summary.
5. Never edit or delete earlier entries. If this decision reverses an earlier
   one, set that entry's Status to "Superseded by <PREFIX>-0XX" (in whichever
   file holds it) and explain the change in the new entry.
6. Confirm back to me with the prefixed entry id and one-line title.
