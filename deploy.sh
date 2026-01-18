#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/QLore3/shvirtd-example-python.git"
APP_DIR="/opt/shvirtd-example-python"

# Пакеты
apt-get update -y
apt-get install -y git ca-certificates curl

# Клонирование/обновление
if [ -d "$APP_DIR/.git" ]; then
  git -C "$APP_DIR" pull --ff-only
else
  rm -rf "$APP_DIR"
  git clone "$REPO_URL" "$APP_DIR"
fi

cd "$APP_DIR"

# Запуск проекта целиком
docker compose pull || true
docker compose up -d

docker compose ps
