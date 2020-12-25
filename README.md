# `is-everything-pushed` ![CI](https://github.com/simeg/is-everything-pushed/workflows/CI/badge.svg)
A bash script to make sure everything in your Git repository folder is pushed.

# Usage
```sh
$ sh ./is-everything-pushed.sh /path/to/repos/parent/folder
```

This scripts assumes you have all your Git repositories in the same
parent-folder.

```sh
.
├── repo-1
├── repo-2
├── repo-3
└── ...
```

## Example Output
When you have unpushed changes:
```sh
🙈  Unpushed changes in	/Users/simon/repos/dotfiles/
🙈  Unpushed changes in	/Users/simon/repos/lazy-reading/
```

When you don't have any unpushed changes:
```sh
No unpushed changes! All is good 👌
```

## Quick Usage
`curl` the script and execute it. Just make sure to
replace `[REPO FOLDER]` with an absolute path to your repo folder.
```sh
$ /bin/bash <(curl -s https://raw.githubusercontent.com/simeg/is-everything-pushed/master/is-everything-pushed.sh) [REPO FOLDER]
```
