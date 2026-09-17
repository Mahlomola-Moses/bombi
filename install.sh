#!/usr/bin/env bash
# Install bombi.  curl -fsSL <your-url>/install.sh | bash
set -euo pipefail
REPO_RAW="${BOMBI_SRC:-https://raw.githubusercontent.com/omnitech-labs/bombi/main/bombi}"
DEST="${BOMBI_DEST:-$HOME/.local/bin}"
mkdir -p "$DEST"
if [ -f ./bombi ]; then cp ./bombi "$DEST/bombi"; else curl -fsSL "$REPO_RAW" -o "$DEST/bombi"; fi
chmod +x "$DEST/bombi"
echo "✓ bombi installed to $DEST/bombi"
case ":$PATH:" in
  *":$DEST:"*) ;;
  *) echo "! add to your shell profile:"; echo "    export PATH=\"$DEST:\$PATH\"" ;;
esac
command -v uv >/dev/null || echo "! spec kit needs uv — see https://docs.astral.sh/uv/"
echo
echo "  Next:  cd your-repo && bombi init"
