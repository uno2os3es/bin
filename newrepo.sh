#!/usr/bin/env bash
set -euo pipefail

# Repo name = current directory name
repo_dir="$(pwd)"
repo_name="$(basename "$repo_dir")"

echo "Repository name: $repo_name"

# Initialize git if needed
if [ ! -d ".git" ]; then
    git init
fi

# Ensure branch is main
current_branch="$(git symbolic-ref --short HEAD 2>/dev/null || true)"
if [ -z "$current_branch" ]; then
    git checkout -b main
elif [ "$current_branch" != "main" ]; then
    git branch -M main
fi

# Copy .gitignore from home directory if it exists
if [ -f "$HOME/.gitignore" ]; then
    cp -f "$HOME/.gitignore" ./.gitignore
    echo ".gitignore copied from \$HOME"
else
    echo "Warning: \$HOME/.gitignore not found"
fi

# Create GitHub repo if it does not exist
if ! gh repo view "$repo_name" >/dev/null 2>&1; then
    gh repo create "$repo_name" --source=. --remote=origin --public --push=false
fi

# Stage everything
git add -A

# Commit with current date & time
if ! git diff --cached --quiet; then
    commit_msg="$(date '+%Y-%m-%d %H:%M:%S')"
    git commit -m "$commit_msg"
else
    echo "Nothing to commit"
fi

# Push
git push -u origin main

echo "Done. Repository pushed to GitHub."
