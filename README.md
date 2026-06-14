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

```bash
git clone https://github.com/ahuja-sanchitt/claude-decision-log.git
cd /path/to/your-project
/path/to/claude-decision-log/install.sh         
/path/to/claude-decision-log/install.sh --with-hook
```

Then **restart Claude Code** in your project (commands and `CLAUDE.md` load at
session start). Run `/help` to confirm `log-decision` and `decisions` appear.

> Prefer to do it by hand? Copy `templates/DECISIONS.md` to `docs/`, copy the
> two files in `commands/` to `.claude/commands/`, and paste
> `templates/CLAUDE-decision-logging.md` into your `CLAUDE.md`.

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
