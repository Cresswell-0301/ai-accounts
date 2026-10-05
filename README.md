# ai-accounts

Local dashboard that tracks Claude Code and Codex usage across multiple accounts
on one machine. Runs as a web app on http://127.0.0.1:8787.

- `bin/ai-usage` — the tool + dashboard (Python stdlib only)
- `bin/ai-login` — helper to sign an account into its own profile
- `env.sh` — `claude-<acct>` / `codex-<acct>` launchers
- `deploy/` — LaunchAgent to run the dashboard at login

Credentials live in the macOS Keychain (Claude) or per-profile `auth.json`
(Codex) and are **never** part of this repo — see `.gitignore`.

## Sharing it on your WiFi

The LaunchAgent starts it with `--host 0.0.0.0`, so colleagues on the same network
can **view** it at `http://<hostname>.local:8787` (the Bonjour name survives the
IP changing when you switch networks; the raw IP does not).

- **View-only for everyone else.** Every control (add / remove / sign in /
  submit code / suggestion checkboxes) is accepted only from `127.0.0.1`; a
  request from any other address is refused. Do the controls on the host Mac.
- **http and https both work on the one port.** The server looks at the first byte
  of each connection (`0x16` = TLS) and answers either. `https://` shows a
  one-time "connection is not private" page because the certificate is
  self-signed — choose Advanced → Proceed. Without this, a browser that
  upgrades to `https://` hit a hard `ERR_SSL_PROTOCOL_ERROR` with nothing to click.
- The certificate and key are generated on first start into `tls/` (gitignored,
  key mode 600). Delete that folder to regenerate.
- The host Mac must be awake and on the same network as the viewer.
