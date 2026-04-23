#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "客戶頁面確認圖同步並發佈"
echo
"$SCRIPT_DIR/sync_assets.sh"
echo
"$SCRIPT_DIR/publish.sh"
echo
echo "同步與發佈完成，按 Enter 關閉視窗"
read -r

