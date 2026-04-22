#!/bin/bash -l

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Sync Nix Theme with macOS
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.packageName Dotfiles
# @raycast.icon 🌓
# @raycast.needsConfirmation false
# @raycast.currentDirectoryPath ~/dotfiles
# @raycast.description Detect macOS appearance, sync theme.nix, and apply with nh darwin switch
# @raycast.author Dhwanil

set -euo pipefail

DOTFILES="$HOME/dotfiles"
THEME_FILE="$DOTFILES/theme.nix"
NOTIFY_TITLE="Nix Theme Sync"

notify() {
  local message="$1"
  osascript -e "display notification \"${message//\"/\\\"}\" with title \"$NOTIFY_TITLE\"" >/dev/null 2>&1 || true
}

askpass() {
  /usr/bin/osascript -e 'Tell application "System Events" to display dialog "darwin-rebuild needs your password:" default answer "" with hidden answer' -e 'text returned of result' 2>/dev/null
}

run_rebuild() {
  local tmpdir
  tmpdir=$(mktemp -d /tmp/nix-theme-sync.XXXXXX)

  # Create askpass helper that shows a macOS password dialog
  cat > "$tmpdir/askpass" << 'SCRIPT'
#!/bin/bash
/usr/bin/osascript -e 'Tell application "System Events" to display dialog "nh darwin switch needs your password:" default answer "" with hidden answer' -e 'text returned of result' 2>/dev/null
SCRIPT
  chmod 700 "$tmpdir/askpass"

  # Create a sudo wrapper that forces -A and caches credentials on first call
  cat > "$tmpdir/sudo" << WRAPPER
#!/bin/bash
export SUDO_ASKPASS="$tmpdir/askpass"
# Validate and cache credentials on first invocation
/usr/bin/sudo -A -v 2>/dev/null
/usr/bin/sudo "\$@"
WRAPPER
  chmod 700 "$tmpdir/sudo"

  # Put our wrapper first in PATH (inside the login shell so it survives profile reloads)
  /bin/bash -lc "export PATH='$tmpdir':\$PATH; nh darwin switch $DOTFILES"
  local rc=$?
  rm -rf "$tmpdir"
  return $rc
}

if [[ ! -f "$THEME_FILE" ]]; then
  echo "theme file not found: $THEME_FILE"
  notify "theme file not found"
  exit 1
fi

if defaults read -g AppleInterfaceStyle >/dev/null 2>&1; then
  MACOS_MODE="dark"
  TARGET_THEME="mocha"
else
  MACOS_MODE="light"
  TARGET_THEME="latte"
fi

CURRENT_THEME="$(tr -d '"[:space:]' < "$THEME_FILE")"

echo "macOS mode: $MACOS_MODE"
echo "current nix theme: $CURRENT_THEME"
echo "target nix theme: $TARGET_THEME"

if [[ "$CURRENT_THEME" != "$TARGET_THEME" ]]; then
  printf '"%s"\n' "$TARGET_THEME" > "$THEME_FILE"
  echo "theme updated"
  echo
  echo "macOS will prompt for your administrator password to apply the darwin switch."
  notify "Updated theme to $TARGET_THEME, waiting for admin approval"
  if run_rebuild; then
    echo
    echo "done"
    notify "Applied $TARGET_THEME successfully"
  else
    echo
    echo "rebuild failed"
    notify "Rebuild failed after switching to $TARGET_THEME"
    exit 1
  fi
else
  echo "no change needed; skipping rebuild"
  notify "Already synced to $TARGET_THEME"
fi

