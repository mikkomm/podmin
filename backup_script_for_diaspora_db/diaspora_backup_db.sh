#!/bin/bash

pidName='diaspora.pid'

backupPath='/backup/diaspora/db/'
backupName='diaspora_production_'

if test -s $pidName
then
    # Pid found, exit
    exit 1
else
    # Create pid
    echo $$ > diaspora.pid

    # Take mysql dump
    mysqldump -u root -p<password_here> diaspora_production > $backupPath$backupName$(date +%Y-%m-%d_%H_%M_%S).sql
fi

# Delete pid
rm $pidName

