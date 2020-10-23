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
#   /bin/bash is-everything-pushed.sh /Users/simon/repos
#

readonly folder=$1

if [ -z "$folder" ]; then
  echo "No folder provided, run it like this:";
  echo "  /bin/bash is-everything-pushed.sh [FOLDER]";
  exit
fi

if [ ! -d "$folder" ]; then
  printf "Cannot find [%s]\\n" "$folder"
  exit
fi

function is_git_repo {
  if [ -d .git ]; then
    return 0;
  elif git rev-parse --git-dir 2> /dev/null; then
    return 0;
  fi;

  return 1;
}

readonly repos_str="$(ls -d "$folder"/*/)"
readonly repo_paths="$(echo "$repos_str" | tr ";" "\\n")"

unpushed_changes=false

for folder_path in $repo_paths
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

