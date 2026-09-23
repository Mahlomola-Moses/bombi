#!/usr/bin/env bash
# Install bombi:
#   curl -fsSL https://raw.githubusercontent.com/Mahlomola-Moses/bombi/main/install.sh | bash
#
# Installs the CLI, then hands off to `bombi doctor --fix`, which detects your OS
# and shell and sets up PATH, Node, uv and Spec Kit for you.
set -euo pipefail

REPO_RAW="${BOMBI_SRC:-https://raw.githubusercontent.com/Mahlomola-Moses/bombi/main/bombi}"
DEST="${BOMBI_DEST:-$HOME/.local/bin}"

mkdir -p "$DEST"
if [ -f ./bombi ]; then
  cp ./bombi "$DEST/bombi"
else
  command -v curl >/dev/null || { echo "curl is required"; exit 1; }
  curl -fsSL "$REPO_RAW" -o "$DEST/bombi"
fi
chmod +x "$DEST/bombi"
echo "✓ bombi installed to $DEST/bombi"
echo

# Hand off — bombi knows how to repair its own environment
export PATH="$DEST:$PATH"
if [ -t 0 ]; then
  "$DEST/bombi" doctor --fix
else
  # piped from curl: stdin isn't a terminal, so prompts can't be answered
  echo "  Run this next to finish setup (PATH, node, uv, spec kit):"
  echo
  echo "      $DEST/bombi doctor --fix"
  echo
fi

echo "  Then:  cd your-repo && bombi init"
echo
