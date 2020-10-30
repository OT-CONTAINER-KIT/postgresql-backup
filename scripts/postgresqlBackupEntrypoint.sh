#!/bin/bash
source /scripts/postgresqlBackup.sh

case $1 in
  backup)
    backup
    ;;
  restore)
    restore
    ;;
  listBackups)
    listBackups
    ;;
  *)
    echo -n "Please give valid input"
    exit 1
    ;;
esac
