function backup(){
    echo "I'll perform backup"
    local exec_command="export PGPASSWORD=${DB_PASSWORD};pg_dump -h ${DB_HOST} -f ${BACKUP_BASE}/${BACKUP_FILE} -U ${BACKUP_USER} ${BACKUP_DB}"
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
    local exec_command="export PGPASSWORD=${DB_PASSWORD};psql -h ${DB_HOST} -U ${BACKUP_USER} ${BACKUP_DB} -f ${BACKUP_BASE}/${BACKUP_FILE}"
    sh -c "$exec_command"
    if [ "$?" -ne "0" ]; then
        echo -n "Backup FAILED..!"
        exit 1
    else
        echo -e "\nBackup SuccessFull..!"
    fi
}
