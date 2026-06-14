#!/usr/bin/env bash
#
# Installs the Claude decision-logging system into the current repository.
#
# Usage:
#   cd /path/to/your-repo
#   /path/to/claude-decision-log/install.sh [--with-hook]
#
set -euo pipefail

# Where this script (and the templates) live.
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Where we're installing TO = wherever you ran the command.
DEST="$(pwd)"

echo "Installing decision logging into: $DEST"

# 1. Folders
mkdir -p "$DEST/docs" "$DEST/.claude/commands"

# 2. The log itself (don't clobber an existing one)
if [ -f "$DEST/docs/DECISIONS.md" ]; then
  echo "  • docs/DECISIONS.md already exists — leaving it untouched."
else
  cp "$SRC/templates/DECISIONS.md" "$DEST/docs/DECISIONS.md"
  echo "  • Created docs/DECISIONS.md"
fi

# 3. Slash commands
cp "$SRC/commands/log-decision.md" "$DEST/.claude/commands/log-decision.md"
cp "$SRC/commands/decisions.md"    "$DEST/.claude/commands/decisions.md"
echo "  • Installed /log-decision and /decisions commands"

# 4. The CLAUDE.md directive (append if missing, create if absent)
DIRECTIVE="$SRC/templates/CLAUDE-decision-logging.md"
if [ -f "$DEST/CLAUDE.md" ]; then
  if grep -q "Decision logging (always on)" "$DEST/CLAUDE.md"; then
    echo "  • CLAUDE.md already has the decision-logging directive — skipping."
  else
    printf '\n' >> "$DEST/CLAUDE.md"
    cat "$DIRECTIVE" >> "$DEST/CLAUDE.md"
    echo "  • Appended directive to existing CLAUDE.md"
  fi
else
  cp "$DIRECTIVE" "$DEST/CLAUDE.md"
  echo "  • Created CLAUDE.md with the directive"
fi

# 5. Optional pre-commit nudge
if [ "${1:-}" = "--with-hook" ]; then
  if [ -d "$DEST/.git" ]; then
    if [ -f "$DEST/.git/hooks/pre-commit" ]; then
      echo "  • A pre-commit hook already exists — NOT overwriting it."
      echo "    Merge in $SRC/hooks/pre-commit manually if you want the nudge."
    else
      cp "$SRC/hooks/pre-commit" "$DEST/.git/hooks/pre-commit"
      chmod +x "$DEST/.git/hooks/pre-commit"
      echo "  • Installed pre-commit nudge hook"
    fi
  else
    echo "  • --with-hook given but this isn't a git repo (no .git/) — skipped."
  fi
fi

echo ""
echo "Done. Next steps:"
echo "  1. Restart Claude Code (or open a fresh session) in this repo."
echo "  2. Run /help — you should see 'log-decision' and 'decisions'."
echo "  3. git add docs/DECISIONS.md .claude/commands CLAUDE.md && git commit -m 'Add decision logging'"
