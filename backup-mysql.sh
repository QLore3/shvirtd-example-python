#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="/opt/backup"
CNF="/opt/backup-secrets/mysql.cnf"

NETWORK="shvirtd-example-python_backend"

DB_NAME="example"
TS="$(date +'%Y-%m-%d_%H-%M-%S')"
OUT="${BACKUP_DIR}/${DB_NAME}_${TS}.sql"

mkdir -p "${BACKUP_DIR}"

docker run --rm \
  --network "${NETWORK}" \
  -v "${CNF}:/root/.my.cnf:ro" \
  --entrypoint mysqldump \
  mysql:8 \
  --databases "${DB_NAME}" > "${OUT}"

gzip -f "${OUT}"
