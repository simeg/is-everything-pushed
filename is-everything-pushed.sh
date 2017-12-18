#!/usr/bin/env bash

# This scripts assumes you have all your Git repositories in the same
# parent-folder.
#
# .
# ├── repo-1
# ├── repo-2
# ├── repo-3
# ├── ...
# └── repo-N
#
### Usage
#
# First argument should be absolute path to the parent-folder

# Example:
#
#   sh is-everything-pushed.sh /Users/simon/repos
#

FOLDER=$1

if [ ! -d $1 ]; then
  echo "Cannot find $1, exiting"
  exit
fi

function is_git_repo {
  if [ -d .git ]; then
    return 0;
  else
    if git rev-parse --git-dir 2> /dev/null; then
      return 0;
    fi
  fi;

  return 1;
}

readonly REPOS_STR="$(ls -d $1/*/)"
readonly REPO_PATHS="$(echo $REPOS_STR | tr ";" "\n")"

for folder_path in $REPO_PATHS
do
  # Don't output pushd results
  pushd $folder_path > /dev/null;
  if is_git_repo > /dev/null; then
    if (git status | grep -c "Your branch is ahead") > /dev/null; then
      echo "Unpushed changes in" $folder_path;
    fi
  fi
done
