function backup(){
    echo "I'll perform backup"
    export PGPASSWORD=password;pg_dump -h testdb -f /tmp/dump.sql -U postgres opstree

    local exec_command="export PGPASSWORD=${DB_PASSWORD};pg_dump -h ${DB_HOST} -f ${BACKUP_FILE} -U ${BACKUP_USER} ${BACKUP_DB}"
    sh -c "$exec_command"
    if [ "$?" -ne "0" ]; then
        echo -n "Backup FAILED..!"
        exit 1
    else
        echo -e "\nBackup SuccessFull..!"
    fi
}

function restore(){
    echo "I'll perform restore"
}

function listBackups(){
   echo "I'll list backups"
}
