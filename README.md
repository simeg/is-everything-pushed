# is-everything-pushed
A bash script to make sure everything in your Git repository folder is pushed.

# Usage
```sh
$ sh is-everything-pushed.sh /path/to/repos/parent/folder
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

## Quick Usage
Clone the repo to your `/tmp` folder and run the script. Just make sure to
replace `[REPO FOLDER]` with an absolute path to your repo folder.
```sh
$ git clone git@github.com:simeg/is-everything-pushed.git /tmp/is-everything-pushed && /bin/bash /tmp/is-everything-pushed/is-everything-pushed.sh [REPO FOLDER]
```

