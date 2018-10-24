#!/bin/bash

# The container name is an environment variable defined in /etc/environment
# This makes it a global variable, available to all users (including root)

# git user now owns parent directory in gitlab container
docker exec -ti $GITLAB_WEB_CONTAINER_NAME chown -R git:git /var/opt/gitlab/git-data/repository-import

# Runs the rake task that imports all bare git projects recursively.
# Projects are grouped based upon folders they reside in.
docker exec -ti $GITLAB_WEB_CONTAINER_NAME gitlab-rake gitlab:import:repos['/var/opt/gitlab/git-data/repository-import']

# More info about this process can be found here: https://docs.gitlab.com/ce/raketasks/import.html
