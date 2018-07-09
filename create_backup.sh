#!/bin/bash
# Creates a backup of all the git projects that are inside of a Gitlab CONTAINER

# This section backs up the Gitlab *Configuration* which should be kept separate from the Database backup!
# Read here for more information: https://docs.gitlab.com/ce/raketasks/backup_restore.html#restore-for-omnibus-installations
# Or here: https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md#backups
echo $(date "Backup started on %s")
config_base=/location/of/gitlab/volume
config_backup_storage=$config_base/config_backup
web_backup_storage=/backup/location

echo "[CFG] Backing up to: $config_backup_storage"
tar -cf $config_backup_storage/$(date "+gitlab-config-%s.tar") -C $config_base config
# End Gitlab configuration backup

# Begin gitlab DB backup
# The container name is an environment variable defined in /etc/environment
# This makes it a global variable, available to all users (including root)
# Useful for running as a cron job
echo "[WEB] Backing up to: $web_backup_storage"
docker exec -ti -d $GITLAB_WEB_CONTAINER_NAME gitlab-rake gitlab:backup:create
