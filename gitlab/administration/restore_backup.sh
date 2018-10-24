#!/bin/bash

web_location=/storage/location/for/db/backups
config_base=/storage/location/for/config/backups

# Grabs the most recent backup from the backup storage location (defined above)
web_backup_file=$(ls -t $web_location | head -1 | grep -oE "([0-9]+[_,\.])+")

# Following command removes trailing character from the variable
# ie: foo_ -> foo
web_backup_file=${web_backup_file::-1}
echo "[WEB] Most recent backup: $web_backup_file"

# Same thing happens here, just less involved.
config_backup_file=$(ls -t $config_base/config_backup | head -1)
echo "[CFG] Most recent backup: $config_backup_file"

# The container name is an environment variable defined in /etc/environment
# This makes it a global variable, available to all users (including root)
echo "[WEB] Stopping Unicorn and Sidekiq to import backup data"
docker exec -ti $GITLAB_WEB_CONTAINER_NAME gitlab-ctl stop unicorn
docker exec -ti $GITLAB_WEB_CONTAINER_NAME gitlab-ctl stop sidekiq
docker exec -ti $GITLAB_WEB_CONTAINER_NAME gitlab-ctl status

echo "[WEB] Importing backup data from: $web_location/$web_backup_file"
docker exec -ti $GITLAB_WEB_CONTAINER_NAME gitlab-rake gitlab:backup:restore BACKUP=$web_backup_file force=yes

echo "[CFG] Importing backup data from: $config_base/config_backup/$config_backup_file"
tar -xvf $config_base/config_backup/$config_backup_file -C $config_base

echo "restarting gitlab web instance."
docker exec -ti $GITLAB_WEB_CONTAINER_NAME gitlab-ctl restart

echo "Checking to make sure import was successful"
docker exec -ti $GITLAB_WEB_CONTAINER_NAME gitlab-rake gitlab:check SANITIZE=true
