#!/bin/bash

pidName='diaspora.pid'

backupPath='/backup/diaspora/db/'
backupName='diaspora_production_'

encryptId='<basically_email_address_of_key_owner_here>'

if test -s $pidName
then
    # Pid found, exit
    exit 1
else
    # Create pid
    echo $$ > diaspora.pid
    
    # Create name
    backupName=$backupPath$backupName$(date +%Y-%m-%d_%H_%M_%S).sql

    # Take mysql dump
    mysqldump -u root -p<password_here> diaspora_production > $backupName
    
    # Encrypt the dump file
    gpg -r $encryptId --out $backupName.secret --encrypt $backupName
    
    # Remove plain dump
    rm $backupName
    
fi

# Delete pid
rm $pidName

