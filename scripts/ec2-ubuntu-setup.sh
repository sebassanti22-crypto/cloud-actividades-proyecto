#!/usr/bin/env bash
# Script para Ubuntu 22.04 LTS en EC2 (t2.micro/t3.micro)
# Ejecutar como ubuntu:  bash ec2-ubuntu-setup.sh <GITHUB_USER> <REPO_NAME>

set -euo pipefail

GH_USER="${1:-your-user}"
REPO="${2:-cloud-actividades-proyecto}"
APP_DIR="/opt/${REPO}"

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y nginx git curl build-essential

# Instalar Node con NVM (recomendado)
if ! command -v nvm >/dev/null 2>&1; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi
nvm install 18
nvm use 18
node -v
npm -v

# Clonar proyecto
sudo mkdir -p "$APP_DIR"
sudo chown -R "$USER":"$USER" "$APP_DIR"
cd "$APP_DIR"
if [ ! -d ".git" ]; then
  git clone "https://github.com/${GH_USER}/${REPO}.git" .
fi

# Instalar dependencias
npm install

# Crear servicio systemd
SERVICE_FILE="/etc/systemd/system/cloudapp.service"
sudo bash -c "cat > $SERVICE_FILE" <<'UNIT'
[Unit]
Description=CloudApp Node Service
After=network.target

[Service]
Type=simple
Environment=PORT=3000
WorkingDirectory=/opt/REPO_NAME
ExecStart=/bin/bash -lc 'source ~/.nvm/nvm.sh && nvm use 18 && node src/server.js'
Restart=always
User=ubuntu
Group=ubuntu

[Install]
WantedBy=multi-user.target
UNIT

# Reemplazar REPO_NAME por repo real
sudo sed -i "s|REPO_NAME|${REPO}|g" "$SERVICE_FILE"

sudo systemctl daemon-reload
sudo systemctl enable cloudapp
sudo systemctl restart cloudapp
sudo systemctl status cloudapp --no-pager

# Configurar Nginx como reverse proxy
NGINX_FILE="/etc/nginx/sites-available/cloudapp"
sudo bash -c "cat > $NGINX_FILE" <<'NGINX'
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  server_name _;

  location / {
    proxy_pass http://127.0.0.1:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
  }
}
NGINX

sudo ln -sf "$NGINX_FILE" /etc/nginx/sites-enabled/cloudapp
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx

echo "Listo. Visita http://<IP-PUBLICA-EC2>/"