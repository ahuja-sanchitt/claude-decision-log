# Decision Log — project-wide

A running record of meaningful **project-wide / cross-cutting** choices made
while building this project (database, auth, shared dependencies, settings —
anything not owned by a single app), with the options considered and the
tradeoffs behind each. Read this instead of scrolling chat history.

- **Scope:** this top-level log holds only cross-cutting decisions. A decision
  that belongs to a single app is logged in that app's own `DECISIONS.md`
  (e.g. `ticket/DECISIONS.md`), modeled on this same format.
- **Numbering:** entries here are prefixed `GEN-001`, `GEN-002`, … Per-app logs
  use the app name uppercased as the prefix (e.g. `TICKET-001`). Each file
  numbers itself independently.
- **How to read:** newest decisions at the bottom. Entries are never edited or
  deleted. If a decision is reversed, the old entry's **Status** points to the
  newer entry that replaced it.

---

<!--
  TEMPLATE — copy this block for each new decision. Within a file, number
  entries sequentially using that file's prefix: GEN for this top-level log;
  the uppercased app name for a per-app log (e.g. TICKET-001).

## <PREFIX>-001 — <short title>

- **Date:** YYYY-MM-DD
- **Phase / area:**
- **Status:** Accepted   (or: Superseded by <PREFIX>-0XX)
- **Decision:** <one line>

**Options considered:**

| Option | Tradeoff |
| --- | --- |
| **<chosen>** ✅ | ... |
| <alternative> | ... |

**Why chosen:** <the actual reason>

---
-->
