#!/bin/sh

## Basic Aegir bulk backup script.                                  
## Backup first! Isn't that ironic? :)                              
##                                                                  
## INSTRUCTIONS                           
##                                                                  
## If this file is named 'backup.sh', then run the                  
## script as the 'aegir' user by typing                             
## 'sh backup.sh' or simply './backup.sh' if the file               
## is already executable.                                          
##                                                                  
## Below are some variables that you may need to change           


# Aegir home directory. No trailing slash.
HOME="/var/aegir"

# Path to the Drush executable.
DRUSH="$HOME/drush/drush.php"

# Add debug information? 0 = no, 1 = yes
DEBUG=0

######################################################################
##                                                                  ##
##      You should not need to change anything below this line      ##
##                                                                  ##
######################################################################


# Do the backup
for site in `$DRUSH sa | egrep -v "(^@platform|^@server_|^@self$)"`; do
  CMD="$DRUSH @hostmaster hosting-task @$site backup"

  if [ "$DEBUG" -eq 1 ]; then
    echo -e "Attempting to backup $site...\n"
    $CMD -d
    echo -e "...done.\n"

  else
    $CMD
  fi
done

