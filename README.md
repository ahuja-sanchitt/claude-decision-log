# claude-decision-log

A tiny, zero-dependency way to make **Claude Code** keep a running log of the
decisions you make while building a project — what the options were, what you
picked, and *why* — so you never have to scroll back through chat to remember.

When you build with Claude Code, choices fly by as quick yes/no answers. The
code survives in your commits, but the *reasoning* disappears. This drops a
`docs/DECISIONS.md` into your repo and tells Claude Code to write to it
automatically, the moment each decision is made.

## What you get

- **`docs/DECISIONS.md`** — an append-only decision log living in your repo.
- **Automatic logging** — a directive in `CLAUDE.md` so Claude records each
  decision (with tradeoffs) as it happens.
- **`/log-decision`** — a slash command to manually log or backfill one.
- **`/decisions`** — a slash command that prints a clean summary of the log.
- **Optional pre-commit nudge** — reminds you if you've gone several commits
  without recording anything. Never blocks your commit.

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
session. The directive tells it to append to `docs/DECISIONS.md` whenever a
non-trivial decision is settled. Note this is *guidance*, not enforced
configuration — it catches the large majority of decisions, and `/log-decision`
is there to backfill anything that slips through.

## Commands

| Command | What it does |
| --- | --- |
| `/log-decision [note]` | Logs the latest (or described) decision with its tradeoffs. |
| `/decisions [keyword]` | Prints a summary / table of contents of the log. |

## The append-only rule

Entries are never edited or deleted. When you reverse a past decision, a **new**
entry is added and the old one is marked `Superseded by D-0XX`. That way the log
shows not just what you're doing now, but what you used to do and why you
changed — which is exactly the trail you want months later (or in an interview).

## Example entry

```markdown
## D-003 — Reranking model for retrieval

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
