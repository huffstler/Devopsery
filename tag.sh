#!/bin/bash
set -u

group_commit_msgs() {

    PREV_TAG=$(git describe --abbrev=0 --tags)

    RESULT=$(git log --format='@%an% h<br>Title: %s<br>Body: %b<br><br>' "$PREV_TAG"...HEAD | tr -d '\n')

    printf '%s' "$RESULT"
}

generate_json () {
cat <<EOF
{
    "ref": "$CI_COMMIT_REF_NAME",
    "tag_name": "$PROJECT_VERSION",
    "target": "$CI_COMMIT_SHA",
    "message": "Release version: $PROJECT_VERSION",
    "release_description": "$(group_commit_msgs)"
}
EOF
}

if grep -q "SNAPSHOT" <(echo "$PROJECT_VERSION");
then
    echo "Snapshot version. Not tagging."
else
    curl \
        -H "Content-Type:application/json" \
        -H "PRIVATE-TOKEN:$TAG_TOKEN" \
        --data "$(generate_json)" \
        "https://gitlab.example.net/api/v4/projects/$CI_PROJECT_ID/repository/tags"
fi

set +u
