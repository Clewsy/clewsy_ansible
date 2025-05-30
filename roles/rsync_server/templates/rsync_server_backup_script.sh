#!/bin/bash
# rsync backup script generated by ansible rsync_server role.

SYNC_NAME={{ item.name }}
SYNC_SOURCE={{ item.source }}
SYNC_DEST={{ item.dest }}
SYNC_SSH_PORT={{ item.ssh_port | default('22')}}
SYNC_LOGFILE={{ rsync_server_logfile }}

# Check for sudo.
if [[ "${EUID}" != 0 ]]; then printf "%b" "Must be run as root.  Quitting\n" && exit 1; fi

# Log header.
printf "%b" "---------------------------------------------------------\n" >> ${SYNC_LOGFILE}
printf "%b" "---------- Job Name : ${SYNC_NAME}\n" >> ${SYNC_LOGFILE}
printf "%b" "---------- Job Started : $(date +%Y-%m-%d\ %T)\n" >> ${SYNC_LOGFILE}

rsync   --verbose \
        --archive \
        --delete \
        --acls \
        --human-readable \
        --progress \
        --log-file=${SYNC_LOGFILE} \
        --rsync-path="sudo rsync" \
        -e "ssh -p ${SYNC_SSH_PORT} -o StrictHostKeyChecking=no" \
        ${SYNC_SOURCE} ${SYNC_DEST}

# Log tail.
printf "%b" "---------- Job Completed : $(date +%Y-%m-%d\ %T)\n" >> ${SYNC_LOGFILE}
printf "%b" "---------------------------------------------------------\n" >> ${SYNC_LOGFILE}
