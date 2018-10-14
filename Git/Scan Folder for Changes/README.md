# Scan Folder for Changes

`echo ""; find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(cd {} && gitstate=$((git status -s) 2>/dev/null) && if [[ ! -z "$gitstate" ]]; then echo "    "{}|tr -d './';fi )' \;; echo`