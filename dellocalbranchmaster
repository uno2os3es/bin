#!/data/data/com.termux/files/usr/bin/bash
git checkout master
git branch | grep -v "master" | xargs git branch -D
git branch -r | grep -v "master" | sed 's/origin\///' | xargs -n 1 git push origin --delete
git fetch --prune
