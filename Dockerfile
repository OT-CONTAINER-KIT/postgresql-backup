From opstree/restic:0.2

LABEL VERSION=0.1 \
      ARCH=AMD64 \
      MAINTAINER="Sandeep Rawat" \
      DESCRIPTION="PostgreSQL Backup - docker image created by Opstree Solutions"

USER root

RUN apk add postgresql-client
COPY scripts/ /scripts/
RUN chown -R backup:backup /scripts/
USER backup

ENTRYPOINT ["/bin/bash", "/scripts/postgresqlBackupEntrypoint.sh"]
