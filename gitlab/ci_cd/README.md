# Gitlab CI/CD

I've put a nice example `.gitlab-ci.yml` file in here so that others can see how I do it.

Probably not the easiest way to do it, but it works and I'm _always_ open to suggestions to improve!

### Note

The `tag.sh` and `set_vars.sh` are _supposed_ to reside in a folder called `.ci`, but I have them in the root here because it's easier.


# tag.sh

Runs on master branch and tags releases. Includes the:
* Commit title
* Commit message
* Commit author
of each commit in the release notes for that release.

Creates the tag of the release based upon the version found in the pom.

# set_vars.sh

Sets environment variables used in the CI/CD pipeline. Uses grep to get:
* artifactID
* groupID
* version
from the pom of the project.
