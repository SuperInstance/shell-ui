#!/bin/bash
# Shell UI — portable install (nginx optional, Python fallback)
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
echo "[shell-ui] Installing..."

# Try nginx first
if command -v nginx &>/dev/null; then
  sudo mkdir -p /var/www/shell-ui
  sudo cp "$DIR/index.html" /var/www/shell-ui/
  sudo tee /etc/nginx/sites-enabled/shell-ui.conf > /dev/null << 'NGINX'
server {
    listen 8080; root /var/www/shell-ui; index index.html;
    location / { try_files $uri $uri/ /index.html; }
    location /api/ { proxy_pass http://localhost:8410; proxy_set_header Host $host; }
}
NGINX
  sudo nginx -t && sudo nginx -s reload 2>/dev/null || true
  echo "[shell-ui] nginx serving on :8080"
else
  # Fallback: Python HTTP server
  echo "[shell-ui] Starting Python HTTP server on :8080..."
  nohup python3 -m http.server 8080 --directory "$DIR" > /tmp/shell-ui.log 2>&1 &
  PID=$!
  echo $PID > /tmp/shell-ui.pid
  echo "[shell-ui] Python server PID $PID (http://localhost:8080)"
  echo "[shell-ui] NOTE: API proxy requires nginx or manual CORS config"
fi
