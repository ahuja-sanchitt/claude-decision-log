---
description: Print a clean summary of the decision logs (all apps, or one)
argument-hint: [optional app name or keyword to filter by]
allowed-tools: Read, Glob
---

Summarise the project's decision logs. There is a top-level `docs/DECISIONS.md`
(cross-cutting decisions, `GEN-` prefix) plus one `DECISIONS.md` co-located
inside each app (e.g. `ticket/DECISIONS.md`, prefix `TICKET-`). Use Glob to find
every `**/DECISIONS.md`.

Scope based on $ARGUMENTS:

- No argument → summarise all logs.
- Argument matches an app that has a log (or `general` / `gen` / `docs`) → only
  that log.
- Otherwise treat it as a keyword and include only decisions related to it,
  across all logs.

Format the summary grouped by log:

**<app name or "Project-wide"> (`<PREFIX>`)**

_Active_
- `<PREFIX>-00X` — <title>: <chosen option, in a few words>

_Superseded / changed_
- `<PREFIX>-00X` — <title>: <what it was> → replaced by `<PREFIX>-0XX` (<what it became>)

Keep each line to one sentence. Do not reproduce the full entries — this is a
table of contents, not the document. Omit a group's empty sections. End with the
total count of active decisions across the logs you included. If no `DECISIONS.md`
files exist yet, tell me so and suggest I run the installer or create one from
the template.
