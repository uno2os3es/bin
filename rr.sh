# List by date
git fsck --no-reflog 2>&1 | grep "dangling commit" | while read line; do
  sha=$(echo $line | awk '{print $3}')
  date=$(git log -1 --format=%ai $sha 2>/dev/null)
  echo "$date - $sha"
done | sort -r | head -1