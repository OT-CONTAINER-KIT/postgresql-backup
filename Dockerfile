From opstree/restic:0.2

LABEL VERSION=0.1 \
      ARCH=AMD64 \
      MAINTAINER="Sandeep Rawat" \
      DESCRIPTION="PostgreSQL Backup - docker image created by Opstree Solutions"
USER root
RUN apk add --no-cache mysql-client

COPY scripts/postgresqlBackup.sh /scripts/
RUN chown -R backup:backup /etc/backup/
COPY scripts/postgresqlBackupEntrypoint.sh /postgresqlBackupEntrypoint.sh
RUN chown -R backup:backup /postgresqlBackupEntrypoint.sh

USER backup

ENTRYPOINT ["/bin/bash", "/postgresqlBackupEntrypoint.sh"]
