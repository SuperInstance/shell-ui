#!/bin/bash
set -euo pipefail
echo "[shell-ui] Uninstalling..."
sudo rm -f /etc/nginx/sites-enabled/shell-ui.conf 2>/dev/null
sudo nginx -t && sudo nginx -s reload 2>/dev/null || true
kill $(cat /tmp/shell-ui.pid 2>/dev/null) 2>/dev/null || true
rm -f /tmp/shell-ui.pid
echo "[shell-ui] Stopped"
