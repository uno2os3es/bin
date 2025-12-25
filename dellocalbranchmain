#!/data/data/com.termux/files/usr/bin/bash
git checkout main
git branch | grep -v "main" | xargs git branch -D
git branch -r | grep -v "main" | sed 's/origin\///' | xargs -n 1 git push origin --delete
git fetch --prune
