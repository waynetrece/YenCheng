#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$repo_dir"

branch="$(git branch --show-current)"
if [[ -z "$branch" ]]; then
  echo "無法判斷目前分支"
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  git add README.md flow.html index.html images incoming .gitignore

  if ! git diff --cached --quiet; then
    commit_message="${*:-Update client page review site $(date '+%Y-%m-%d %H:%M')}"
    git commit -m "$commit_message"
  fi
fi

git push origin "$branch"

echo "已推送到 origin/$branch"

