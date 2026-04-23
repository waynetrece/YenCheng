#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_dir="$repo_dir/incoming"
archive_root="$source_dir/archive"
target_dir="$repo_dir/images"
timestamp="$(date '+%Y%m%d-%H%M%S')"
archive_dir="$archive_root/$timestamp"

mkdir -p "$source_dir" "$archive_root" "$target_dir"

files=()
while IFS= read -r -d '' file; do
  files+=("$file")
done < <(find "$source_dir" -maxdepth 1 -type f \( \
  -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' -o -iname '*.gif' \
\) -print0 | sort -z)

if [[ "${#files[@]}" -eq 0 ]]; then
  echo "incoming/ 沒有可同步的圖片檔"
  exit 0
fi

mkdir -p "$archive_dir"

copied_count=0
for file in "${files[@]}"; do
  name="$(basename "$file")"
  cp -f "$file" "$target_dir/$name"
  mv "$file" "$archive_dir/$name"
  echo "已同步: $name"
  copied_count=$((copied_count + 1))
done

echo
echo "同步完成，共 $copied_count 個檔案"
echo "原始檔已封存到: $archive_dir"

