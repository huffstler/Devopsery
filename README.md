# Devopsery
Scripts and stuff that I've used for the devops-y parts of my job. You might find them useful as well!

## [tag.sh](https://github.com/huffstler/Devopsery/blob/master/tag.sh)
(For use with gitlab and maven based java projects)

This is used in a deployment script to tag commits when they're promoted from snapshots to releases.

It determines the tag title from the pom version, and also adds any commit titles and messages between HEAD and the most recent tag into the release notes.

This script has a couple runtime dependencies as well as an environment dependency.

Runtime Deps:
- `git`
- `tr`
- `curl`
- `grep`
- `bash`

ENV Deps:
- `$PROJECT_VERSION` = Must be set before running this script. In my case, it's set by the script `set_vars.sh`

## [set_vars.sh](https://github.com/huffstler/Devopsery/blob/master/set_vars.sh)

Simply sets environment variables (pulled from the `pom.xml` for use later on in the build pipeline)

Depends on `maven` being available in the environment
