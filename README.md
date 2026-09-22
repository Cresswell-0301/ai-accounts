# AI Accounts

Local helpers for keeping Claude Code and Codex accounts in separate profile
directories and viewing their usage in one dashboard.

## Safety

Profile directories contain live credentials and private account data. They are
intentionally excluded from Git by `.gitignore`; this repository only tracks the
reusable scripts and shell setup.

## Setup

1. Source `env.sh` from your shell configuration.
2. Create a profile directory, for example:

   ```sh
   mkdir -p ~/.ai-accounts/claude/work
   mkdir -p ~/.ai-accounts/codex/work
   ```

3. Sign in with `ai-login <claude|codex> <profile> [expected-email]`.
4. Run `ai-usage --whoami`, `ai-usage --limits`, or start the local dashboard:

   ```sh
   ai-usage --serve --open
   ```

The dashboard binds to `127.0.0.1` and is not exposed publicly.
