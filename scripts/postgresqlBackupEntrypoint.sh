#!/bin/bash
source /scripts/postgresqlBackup.sh

case $1 in
  backup)
    backup
    ;;
  restore)
    restore
    ;;
  getBackupID)
    listBackups
    ;;
  *)
    echo -n "Please give valid input"
    exit 1
    ;;
esac
