---
description: Log a decision (and its tradeoffs) to docs/DECISIONS.md
argument-hint: [optional short description of the decision]
allowed-tools: Read, Edit
---

Record a decision in `docs/DECISIONS.md`.

If I gave a description after the command, use it: $ARGUMENTS
If I didn't, look back over our recent conversation and identify the most
recent decision we settled that isn't logged yet.

Then:

1. Read `docs/DECISIONS.md` and find the highest existing D-number.
2. Append a new entry with the next number, following the exact format and
   table style used in that file.
3. Capture the real options that were on the table, the genuine tradeoff of
   each, the option we chose, and the concrete reason — not a generic summary.
4. Never edit or delete earlier entries. If this decision reverses an earlier
   one, set the earlier entry's Status to "Superseded by D-0XX" and explain the
   change in the new entry.
5. Confirm back to me with the entry number and one-line title.
