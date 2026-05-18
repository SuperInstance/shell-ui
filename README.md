# ⌨️ Shell UI

Browser dashboard for the fleet — shell, filesystem, fleet health, background processes.

## Quick Start
```bash
# Check gateway is running
curl http://localhost:8410/api/v1/health
# If that fails, install the gateway first:
# git clone https://github.com/SuperInstance/terax-gateway.git

# Install this dashboard
bash install.sh
# Open http://localhost:8080
```

## Features
- **Shell** — Run commands, see output
- **Filesystem** — Browse files, read content
- **Fleet** — Service health, casting-call model selector
- **Processes** — List, view logs, kill background processes

## Browser
Open `index.html` directly (works without server if gateway CORS allows).
For full API proxy support: `bash install.sh` (installs nginx config or Python fallback).

## CORS
The gateway opens all origins. Opening `index.html` as `file://` works in most browsers.
If not, use the built-in server: `python3 -m http.server 8080`.
