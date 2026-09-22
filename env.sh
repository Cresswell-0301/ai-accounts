# ~/.ai-accounts/env.sh — per-account Claude Code / Codex launchers.
# Each account gets its own config dir; the DIRECTORY NAME is the account label,
# because neither CLI stamps an account id onto its usage records.
# Source this from ~/.zshrc.

AI_ACCOUNTS_ROOT="$HOME/.ai-accounts"

# VS Code bundles both CLIs at version-pinned paths that move on every update,
# so resolve the newest at call time rather than hardcoding.
_ai_claude_bin() {
  local d
  d=$(find "$HOME/.vscode/extensions" -maxdepth 1 -type d \
        -name 'anthropic.claude-code-*-darwin-arm64' 2>/dev/null | sort -V | tail -1)
  [ -n "$d" ] && printf '%s\n' "$d/resources/native-binary/claude"
}
_ai_codex_bin() {
  local d
  d=$(find "$HOME/.vscode/extensions" -maxdepth 1 -type d \
        -name 'openai.chatgpt-*-darwin-arm64' 2>/dev/null | sort -V | tail -1)
  [ -n "$d" ] && printf '%s\n' "$d/bin/macos-aarch64/codex"
}

claude-acct() {
  local acct="$1"; shift
  local dir="$AI_ACCOUNTS_ROOT/claude/$acct"
  [ -d "$dir" ] || { echo "no claude account '$acct' (expected $dir)" >&2; return 1; }
  local bin; bin=$(_ai_claude_bin)
  [ -n "$bin" ] || { echo "claude CLI not found under ~/.vscode/extensions" >&2; return 1; }
  CLAUDE_CONFIG_DIR="$dir" "$bin" "$@"
}

codex-acct() {
  local acct="$1"; shift
  local dir="$AI_ACCOUNTS_ROOT/codex/$acct"
  [ -d "$dir" ] || { echo "no codex account '$acct' (expected $dir)" >&2; return 1; }
  local bin; bin=$(_ai_codex_bin)
  [ -n "$bin" ] || { echo "codex CLI not found under ~/.vscode/extensions" >&2; return 1; }
  CODEX_HOME="$dir" "$bin" "$@"
}

# Claude Code accounts
claude-trimo()      { claude-acct trimo "$@"; }
claude-coreos()     { claude-acct coreos "$@"; }
claude-ytube3()     { claude-acct ytube3 "$@"; }
claude-nexjarvis9() { claude-acct nexjarvis9 "$@"; }

# Codex accounts
codex-trimo()    { codex-acct trimo "$@"; }
codex-nexxaflo() { codex-acct nexxaflo "$@"; }

# Which account is each profile actually logged into?
ai-whoami() { "$AI_ACCOUNTS_ROOT/bin/ai-usage" --whoami; }

PATH="$AI_ACCOUNTS_ROOT/bin:$PATH"
