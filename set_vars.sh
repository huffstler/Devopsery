#!/bin/bash

# For java projects that use maven.

# Pulls the specified information from the projects pom.
get_pom_info() {
    mvn "$MVN_CLI_OPT" help:evaluate -Dexpression="$1" | grep -Ev '(^\[|Download\w+:)'
}

GROUP_ID=$(get_pom_info "project.groupId");
ARTIFACT_ID=$(get_pom_info "project.artifactId");
PROJECT_VERSION=$(get_pom_info "project.version");

# These env variables are used elsewhere in the CI/CD pipeline.
export GROUP_ID
export ARTIFACT_ID
export PROJECT_VERSION
