#!/bin/bash

# Fail if one command fails
set -e

# Run the script in non-interactive mode so that the installation does not prompt for input
export DEBIAN_FRONTEND=noninteractive

# Install required packages
apt-get update
apt-get install -y ca-certificates curl sqlite3 apache2-utils

# Setup Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install the Open WebUI Server
mkdir -p /etc/open-webui.d/

# Hardcoded admin credentials
PASSWD=$(htpasswd -bnBC 10 "" "mypassword" | tr -d ':\n')
USER="admin@demo.gs"

# Start container to initialize the DB
docker pull ghcr.io/open-webui/open-webui:ollama
docker run -d -p 80:8080 -v /etc/open-webui.d:/root/.open_web_ui -v /etc/open-webui.d:/app/backend/data --name openwebui ghcr.io/open-webui/open-webui:ollama

# Wait for the server to start (max 5 minutes)
timeout 300 bash -c 'until curl -s -o /dev/null -w "%{http_code}" http://localhost | grep -q "200"; do sleep 5; done' || true

docker stop openwebui
docker rm openwebui

# Create the database with the admin user
cat <<EOF > /etc/open-webui.d/webui.sql
PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
INSERT INTO auth (id, email, password, is_admin) VALUES ('488af2d3-dd38-4310-a549-6d8ad11ae69e', '${USER}', '${PASSWD}', 1);
INSERT INTO user (id, name, email, role, avatar, created_at, updated_at, last_login, openai_api_key, google_refresh_token, github_id) VALUES (
  '488af2d3-dd38-4310-a549-6d8ad11ae69e',
  'Admin User',
  '${USER}',
  'admin',
  'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAAAXNSR0IArs4c6QAABjFJREFUeF7tnGtsFFUUx/8z...',
  strftime('%s','now'),
  strftime('%s','now'),
  strftime('%s','now'),
  'null',
  'null',
  NULL
);
COMMIT;
EOF

sqlite3 /etc/open-webui.d/webui.db < /etc/open-webui.d/webui.sql

echo "✅ Admin user created. You can now start the container again."
