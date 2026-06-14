---
description: Print a clean summary of the decision log
argument-hint: [optional keyword to filter by]
allowed-tools: Read
---

Read `docs/DECISIONS.md` and give me a concise summary of the decisions in it.

If I passed a keyword ($ARGUMENTS), only include decisions related to it.

Format the summary as:

**Active decisions**
- D-00X — <title>: <chosen option, in a few words>

**Superseded / changed**
- D-00X — <title>: <what it was> → replaced by D-0XX (<what it became>)

Keep each line to one sentence. Do not reproduce the full entries — this is a
table of contents, not the document. End with the total count of active
decisions. If `docs/DECISIONS.md` doesn't exist yet, tell me so and suggest I
run the installer or create it from the template.
