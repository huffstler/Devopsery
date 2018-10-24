# Devopsery
Scripts and stuff that I've used for the devops-y parts of my job. You might find them useful as well!

#### Be warned

Some of these won't work out of the box. You'll have to change things around, or figure out how to use the functions yourself to get it working. These scripts are a nice backbone to get started from.

## Table of Contents (Or Content Table?)

| Script | Runtime Deps | ENV Deps | 
| ------ | ------------ | -------- |
| `cbu`    | `docker`,`tar`,`bash`,| N/A |
| `[tag.sh](1)` | `git`,`tr`,`curl`,`grep`,`bash` | `$PROJECT_VERSION` |
| `set_vars.sh` | `mvn`, `bash` | N/A |

(For use with Gitlab CI/CD and maven based java projects)

This is used in a deployment script to tag commits when they're promoted from snapshots to releases.

It determines the tag title from the pom version, and also adds any commit titles and messages between HEAD and the most recent tag into the release notes.

#### Issues: 

Currently having a little bit of an issue with this one, for some reason it will decide to not tag releases at seemingly random times. Co-worker seems to think it's an issue of mismatched single quotes. I'll have to investigate further.

