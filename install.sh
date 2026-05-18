#!/bin/bash
# Install Shell UI — browser fleet dashboard
# Standalone: serves pure HTML; needs gateway for API calls
set -euo pipefail

echo "[shell-ui] Installing..."

mkdir -p /var/www/shell-ui

# Source from repo or local
if [ -f /tmp/shell-ui/index.html ]; then
  cp /tmp/shell-ui/index.html /var/www/shell-ui/
elif [ -f /home/ubuntu/.openclaw/workspace/repos/shell-ui/index.html ]; then
  cp /home/ubuntu/.openclaw/workspace/repos/shell-ui/index.html /var/www/shell-ui/
elif [ -d /tmp/terax-ai/www ]; then
  cp /tmp/terax-ai/www/index.html /var/www/shell-ui/
else
  echo "[shell-ui] No source found. Clone: https://github.com/SuperInstance/shell-ui.git"
  exit 1
fi

sudo tee /etc/nginx/sites-enabled/shell-ui.conf > /dev/null << 'NGINX'
server {
    listen 8080;
    root /var/www/shell-ui;
    index index.html;
    location / {
        try_files $uri $uri/ /index.html;
    }
    location /api/ {
        proxy_pass http://localhost:8410;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
NGINX

nginx -t 2>/dev/null && nginx -s reload 2>/dev/null || echo "[shell-ui] nginx reload skipped"
echo "[shell-ui] Serving on port 8080"
