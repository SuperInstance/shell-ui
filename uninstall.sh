#!/bin/bash
# Uninstall Shell UI — removes nginx config
set -euo pipefail
echo "[shell-ui] Uninstalling..."
sudo rm -f /etc/nginx/sites-enabled/shell-ui.conf
sudo rm -rf /var/www/shell-ui
nginx -t 2>/dev/null && nginx -s reload 2>/dev/null || true
echo "[shell-ui] Removed"
