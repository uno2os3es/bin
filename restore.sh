#!/bin/bash
# recover_git. sh - Comprehensive Git recovery

echo "[INFO] Analyzing Git object database..."

# Find all reachable objects
echo "[INFO] Reachable objects:"
git rev-list --all --objects | wc -l

# Find unreachable objects
echo "[INFO] Unreachable objects:"
git fsck --no-reflog 2>&1 | grep -E "(dangling|unreachable)" | wc -l

# List dangling commits
echo "[INFO] Dangling commits:"
git fsck --no-reflog 2>&1 | grep "dangling commit" | awk '{print $3}' > /tmp/dangling_commits.txt
cat ~/tmp/dangling_commits.txt

# Create branches for each dangling commit
echo "[INFO] Creating recovery branches..."
count=0
while read sha; do
  branch_name="recovered-$count"
  git branch "$branch_name" "$sha" 2>/dev/null && echo "Created: $branch_name from $sha"
  count=$((count + 1))
done < ~/tmp/dangling_commits. txt

# Verify
echo "[INFO] Current branches:"
git branch -a

echo "[INFO] Recovery complete!"
