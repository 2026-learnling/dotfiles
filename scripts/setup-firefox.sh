#!/usr/bin/env bash
# ============================================================
# dotfiles 安装脚本 — Firefox 极简风格
# 适用于 GNU Stow 风格仓库：.mozilla/firefox/default-release/
#
# 支持两种 Firefox 配置目录（自动检测）：
#   - ~/.mozilla/firefox          （默认路径）
#   - ~/.config/firefox           （XDG 模式）
#   - ~/.config/mozilla/firefox   （XDG 变体）
#
# 用法:
#   方法一（stow 软链接）:
#     sudo pacman -S stow
#     cd dotfiles
#     stow -t ~ .mozilla        # 软链接到 home（仅默认路径时推荐）
#     bash scripts/setup-firefox.sh   # 适配真实 profile 名
#
#   方法二（免 stow，脚本全自动，XDG 模式推荐用这个）:
#     cd dotfiles
#     bash scripts/setup-firefox.sh
# ============================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
DATE="$(date +%Y%m%d-%H%M%S)"

# ---- 自动检测 Firefox 配置根目录（多种常见路径） ----
FIREFOX_DIR=""
for candidate in "$HOME/.mozilla/firefox" "$HOME/.config/firefox" "$HOME/.config/mozilla/firefox"; do
  if [ -d "$candidate" ]; then
    FIREFOX_DIR="$candidate"
    echo "[✓] 检测到 Firefox 配置目录: $FIREFOX_DIR"
    break
  fi
done

if [ -z "$FIREFOX_DIR" ]; then
  echo "[!] 未找到 Firefox 配置目录（已检查 .mozilla/firefox 与 .config 下的路径）"
  echo "    请先运行一次 Firefox 生成配置目录后重试。"
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