#!/usr/bin/env bash
# Install bombi:  curl -fsSL https://raw.githubusercontent.com/Mahlomola-Moses/bombi/main/install.sh | bash
set -euo pipefail
REPO_RAW="${BOMBI_SRC:-https://raw.githubusercontent.com/Mahlomola-Moses/bombi/main/bombi}"
DEST="${BOMBI_DEST:-$HOME/.local/bin}"
mkdir -p "$DEST"
if [ -f ./bombi ]; then cp ./bombi "$DEST/bombi"; else curl -fsSL "$REPO_RAW" -o "$DEST/bombi"; fi
chmod +x "$DEST/bombi"
echo "✓ bombi installed to $DEST/bombi"
case ":$PATH:" in
  *":$DEST:"*) ;;
  *) echo "! add this to ~/.zshrc or ~/.bashrc:"; echo "    export PATH=\"$DEST:\$PATH\"" ;;
esac
command -v uv >/dev/null || echo "! Spec Kit needs uv — https://docs.astral.sh/uv/"
echo; echo "  Next:  cd your-repo && bombi init"
