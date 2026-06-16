# claude-decision-log

A tiny, zero-dependency way to make **Claude Code** keep a running log of the
decisions you make while building a project — what the options were, what you
picked, and *why* — so you never have to scroll back through chat to remember.

When you build with Claude Code, choices fly by as quick yes/no answers. The
code survives in your commits, but the *reasoning* disappears. This drops a
`docs/DECISIONS.md` into your repo and tells Claude Code to write to it
automatically, the moment each decision is made.

## What you get

- **Per-app decision logs** — each app (package) keeps its own append-only
  `<app>/DECISIONS.md` right next to its code, plus a top-level
  `docs/DECISIONS.md` for project-wide / cross-cutting choices. One giant file
  never builds up.
- **Automatic logging** — a directive in `CLAUDE.md` so Claude records each
  decision (with tradeoffs) in the right app's log as it happens.
- **`/log-decision`** — a slash command to manually log or backfill one.
- **`/decisions`** — a slash command that summarises the logs (all apps, or
  one).
- **Optional pre-commit nudge** — reminds you if you changed an app without
  recording a decision for it. Never blocks your commit.

## Install

There are two folders involved: **this tool** (which you clone once) and **your
project** (where the logging actually goes). You install *from* the tool folder
*into* your project.

**Step 1 — Clone this tool once.** Put it anywhere; your Desktop is fine:

```bash
git clone https://github.com/ahuja-sanchitt/claude-decision-log.git
```

**Step 2 — Go into the project you want logging in:**

```bash
cd ~/Desktop/my-project
```

**Step 3 — Run the installer from there** (the `--with-hook` flag also adds the
optional commit reminder):

```bash
~/Desktop/claude-decision-log/install.sh --with-hook
```

That's it for the install. The script tells you exactly what it created.

**Step 4 — Restart Claude Code** in your project so it loads the new commands
and `CLAUDE.md`. Run `/help` and confirm `log-decision` and `decisions` appear.

### Worked example

Tool cloned to `~/Desktop/claude-decision-log`, project at `~/Desktop/my-project`:

```bash
cd ~/Desktop/my-project
~/Desktop/claude-decision-log/install.sh --with-hook
```

To add it to a *second* project later, you don't re-clone — just run the same
installer from inside that other project:

```bash
cd ~/Desktop/another-project
~/Desktop/claude-decision-log/install.sh --with-hook
```

### Windows

Run the steps above in **Git Bash** (ships with Git for Windows), not
PowerShell — PowerShell can't execute `.sh` files. In Git Bash, `~/Desktop/...`
works just like on macOS/Linux. If you'd rather not use Git Bash, see manual
install below.

### Manual install (no script)

Copy `templates/DECISIONS.md` into your project's `docs/` folder, copy both
files from `commands/` into your project's `.claude/commands/` folder, and paste
the contents of `templates/CLAUDE-decision-logging.md` into your project's
`CLAUDE.md` (create one if it doesn't exist).

## How it works

Claude Code reads `CLAUDE.md` and `.claude/commands/` at the start of every
session. The directive tells it to append a decision to the right log whenever a
non-trivial decision is settled. Note this is *guidance*, not enforced
configuration — it catches the large majority of decisions, and `/log-decision`
is there to backfill anything that slips through.

## Per-app logs

Decisions live next to the code they affect. A choice about a single app is
logged in that app's own `<app>/DECISIONS.md`; a choice that spans apps or is
project-wide (database, auth, settings, shared dependencies) goes in the
top-level `docs/DECISIONS.md`.

Each file numbers its entries independently with its own prefix — the app name
uppercased for a per-app log, `GEN` for the project-wide one:

```
ticket/DECISIONS.md     → TICKET-001, TICKET-002, …
customer/DECISIONS.md   → CUSTOMER-001, …
docs/DECISIONS.md        → GEN-001, …   (cross-cutting)
```

Only `docs/DECISIONS.md` is created at install time. An app's log is created
automatically the first time a decision in that app gets recorded, so apps you
add later need no extra setup.

> **Note:** in long auto-accept runs Claude settles many choices without a pause,
> so some may not be logged in the moment — use `/log-decision` to backfill.

## Commands

| Command | What it does |
| --- | --- |
| `/log-decision [note]` | Logs the latest (or described) decision, with its tradeoffs, in the right app's log. |
| `/decisions [app or keyword]` | Summarises the logs — all apps, one app, or filtered by keyword. |

## The append-only rule

Entries are never edited or deleted. When you reverse a past decision, a **new**
entry is added and the old one is marked `Superseded by <PREFIX>-0XX` (e.g.
`Superseded by TICKET-014`). That way the log
shows not just what you're doing now, but what you used to do and why you
changed — which is exactly the trail you want months later (or in an interview).

## Example entry

```markdown
## TICKET-003 — Reranking model for retrieval

- **Date:** 2026-06-14
- **Phase / area:** Phase 3 — retrieval quality
- **Status:** Accepted
- **Decision:** Use a cross-encoder reranker over the top-20 hybrid results.

**Options considered:**

| Option | Tradeoff |
| --- | --- |
| **Cross-encoder rerank** ✅ | Big relevance gain; adds ~150ms per query. |
| Vector scores only | Fast and simple, but noisier top results. |

**Why chosen:** Quality mattered more than latency for this demo, and reranking
is a strong thing to be able to explain.
```

## License

MIT
