#!/bin/bash
source /scripts/postgresqlBackup.sh
source /etc/backup/db.properties

case $1 in
  backup)
    backup
    /scripts/resticEntrypoint.sh backup ${BACKUP_BASE} ${BACKUP_FILE}
    ;;
  restore)
    /scripts/resticEntrypoint.sh restore $2 ${BACKUP_BASE}
    restore
    ;;
  listBackups)
    /scripts/resticEntrypoint.sh list
    ;;
  *)
    echo -n "Please give valid input"
    exit 1
    ;;
esac
