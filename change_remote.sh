#!/bin/bash

# Sets the remote origin to a new url. (Swaps $a to $b)
a="FOO"
b="BAR"

# Usage can be something like the following
# cd to directory that holds all the git projects.
# cd /home/user/dev
# for proj in ./*
# do
# cd $proj
# ./change_remote.sh
# cd ../
# done

ORIGINAL=$(git remote -v | grep "origin" | awk '{print $2}'| head -1)

NEW=$(echo "$ORIGINAL" | awk '{ gsub("$a","$b",$1); print $1 }')

git remote set-url origin "$NEW"

echo "Changed remote from
$ORIGINAL
to
$NEW
"

git remote -v
