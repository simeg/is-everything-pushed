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

readonly FOLDER=$1

if [ -z "$FOLDER" ]; then
  echo "No folder provided, run it like this:";
  echo "  /bin/bash ./is-everything-pushed.sh [FOLDER]";
  exit
fi

if [ ! -d "$FOLDER" ]; then
  printf "Cannot find [%s]\\n" "$FOLDER"
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

readonly REPOS_STR="$(ls -d "$FOLDER"/*/)"
readonly REPO_PATHS="$(echo "$REPOS_STR" | tr ";" "\\n")"

unpushed_changes=false

for folder_path in $REPO_PATHS
do
  # Make sure folder exist
  if [ ! -d "$folder_path" ]; then
    printf "Can't pushd to [%s]\\n" "$folder_path";
    exit;
  fi

  # Don't output pushd results
  # If pushd fails, exit
  pushd "$folder_path" > /dev/null ||
    (printf "Can't pushd to [%s]\\n" "$folder_path" && exit);

  if is_git_repo > /dev/null; then
    if (git status | grep -c "Your branch is ahead") > /dev/null; then
      unpushed_changes=true
      printf "🙈  Unpushed changes in\\t%s\\n" "$folder_path";
    fi
  fi
done

if ! $unpushed_changes; then
  echo "No unpushed changes! All is good 👌";
fi

