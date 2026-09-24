# ai-accounts

Local dashboard that tracks Claude Code and Codex usage across multiple accounts
on one machine. Runs as a loopback web app on http://127.0.0.1:8787.

- `bin/ai-usage` — the tool + dashboard (Python stdlib only)
- `bin/ai-login` — helper to sign an account into its own profile
- `env.sh` — `claude-<acct>` / `codex-<acct>` launchers
- `deploy/` — LaunchAgent to run the dashboard at login

Credentials live in the macOS Keychain (Claude) or per-profile `auth.json`
(Codex) and are **never** part of this repo — see `.gitignore`.
