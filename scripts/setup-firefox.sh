#!/usr/bin/env bash
# ============================================================
# dotfiles 安装脚本 — Firefox 极简风格
# 适用于 GNU Stow 风格仓库：.mozilla/firefox/default-release/
#
# 用法:
#   方法一（推荐，stow）:
#     sudo pacman -S stow
#     cd dotfiles
#     stow -t ~ .mozilla        # 软链接到 home
#     bash scripts/setup-firefox.sh   # 适配真实 profile 名
#
#   方法二（免 stow，脚本全自动）:
#     cd dotfiles
#     bash scripts/setup-firefox.sh
# ============================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
FIREFOX_DIR="$HOME/.mozilla/firefox"
DATE="$(date +%Y%m%d-%H%M%S)"

echo "=============================================="
echo "  Firefox 极简风格 安装脚本"
echo "=============================================="

# 1) 检查 Firefox
if ! command -v firefox >/dev/null 2>&1 && ! command -v firefox-bin >/dev/null 2>&1; then
  echo "[!] 未检测到 Firefox，请先安装:"
  echo "    sudo pacman -S firefox   # 或 yay -S firefox-bin"
  exit 1
fi

# 2) 检查配置目录
if [ ! -d "$FIREFOX_DIR" ]; then
  echo "[!] 未找到 $FIREFOX_DIR，请先运行一次 Firefox 再执行本脚本。"
  exit 1
fi

# 3) 定位实际 profile
PROFILE=""
for p in "$FIREFOX_DIR"/*.default-release "$FIREFOX_DIR"/*.default; do
  if [ -d "$p" ]; then
    PROFILE="$p"
    break
  fi
done
if [ -z "$PROFILE" ]; then
  echo "[!] 未找到 Firefox profile，请先运行一次 Firefox。"
  exit 1
fi
echo "[✓] 目标 profile: $PROFILE"

# 4) 定位仓库中的配置模板
TEMPLATE="$REPO_ROOT/.mozilla/firefox/default-release"
if [ ! -f "$TEMPLATE/chrome/userChrome.css" ] || [ ! -f "$TEMPLATE/user.js" ]; then
  echo "[!] 仓库中未找到配置模板: $TEMPLATE"
  exit 1
fi

# 5) 备份
BACKUP_DIR="$FIREFOX_DIR/backup-$DATE"
mkdir -p "$BACKUP_DIR"
[ -f "$PROFILE/user.js" ] && cp "$PROFILE/user.js" "$BACKUP_DIR/user.js.bak"
[ -d "$PROFILE/chrome" ] && cp -r "$PROFILE/chrome" "$BACKUP_DIR/chrome.bak"
echo "[✓] 已备份原配置到: $BACKUP_DIR"

# 6) 安装
mkdir -p "$PROFILE/chrome"
cp "$TEMPLATE/chrome/userChrome.css" "$PROFILE/chrome/userChrome.css"
cp "$TEMPLATE/user.js" "$PROFILE/user.js"
echo "[✓] 已写入 userChrome.css 与 user.js"

echo ""
echo "=============================================="
echo "  安装完成！"
echo "=============================================="
echo "  [1] 完全退出 Firefox（不是关窗口）"
echo "  [2] 重新打开，即可看到效果"
echo ""
echo "  建议安装扩展（配合键盘流）:"
echo "    - Tridactyl: 键盘操作浏览器"
echo "    - uBlock Origin: 广告拦截"
echo ""
echo "  还原方法: 删除 chrome 目录和 user.js，或从备份恢复:"
echo "    $BACKUP_DIR"
echo "=============================================="