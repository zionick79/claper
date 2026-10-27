#!/bin/sh
# Backup giornaliero del database Claper (conserva gli ultimi 14).
# Cron: 30 3 * * * /home/ubuntu/claper/deploy/oracle/backup.sh
set -e
DIR=/home/ubuntu/backups
mkdir -p "$DIR"
cd /home/ubuntu/claper
docker compose -f deploy/oracle/compose.yml --env-file deploy/oracle/.env exec -T db \
  pg_dump -U claper -d claper | gzip > "$DIR/claper-$(date +%F).sql.gz"
ls -1t "$DIR"/claper-*.sql.gz | tail -n +15 | xargs -r rm --
