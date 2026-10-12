#!/usr/bin/env bash
# 按当前会话类型(X11 / Wayland)切换 Firefox 窗口控制按钮
#   - 两种桌面都保持同一套极简单行 CSD 外观（标签融入标题栏）
#   - 区别只在窗口控制按钮(最小化/最大化/关闭)是否显示：
#       X11   (普通桌面) : 显示 Firefox 自带按钮（嵌在 CSD 标题栏）
#       Wayland         : 隐藏按钮（unixchad 原版极简风格）
# 用法: bash scripts/firefox-session-mode.sh
#       或 XDG_SESSION_TYPE=wayland bash scripts/firefox-session-mode.sh  (测试用)
# 改完需完全退出 Firefox 再重开才生效。
set -euo pipefail

FF_HOME="${FF_HOME:-$HOME/.mozilla/firefox}"
PROFILES_INI="$FF_HOME/profiles.ini"
INSTALLS_INI="$FF_HOME/installs.ini"

# 找出"当前安装"实际使用的 profile（installs.ini 的 [Install*] Default=，兜底 profiles.ini）
ACTIVE=""
if [ -f "$INSTALLS_INI" ]; then
  ACTIVE=$(grep -rh '^Default=' "$INSTALLS_INI" | head -1 | cut -d= -f2-)
fi
if [ -z "$ACTIVE" ] && [ -f "$PROFILES_INI" ]; then
  ACTIVE=$(awk '/^\[Install/{f=1;next} f&&/^Default=/{print;exit}' "$PROFILES_INI" | cut -d= -f2-)
fi
if [ -z "$ACTIVE" ] && [ -f "$PROFILES_INI" ]; then
  ACTIVE=$(awk -F= '/^Default=1/{print $2}' "$PROFILES_INI" | head -1)
fi

if [ -z "$ACTIVE" ]; then
  echo "✗ 未找到 Firefox 激活 profile，请确认 $FF_HOME 下有 profiles.ini" >&2
  exit 1
fi

CSS="$FF_HOME/$ACTIVE/chrome/userChrome.css"
if [ ! -f "$CSS" ]; then
  echo "✗ 未找到 userChrome.css: $CSS" >&2
  echo "  请先运行 setup-firefox.sh 安装配置。" >&2
  exit 1
fi

SESSION="${XDG_SESSION_TYPE:-x11}"

# 仅修改 .titlebar-buttonbox-container 规则块内的 display 值，
# 不影响文件里其它（隐藏菜单/前进后退等）的 display 规则。
set_button_display() {
  if grep -q '^\.titlebar-buttonbox-container' "$CSS"; then
    sed -i '/^\.titlebar-buttonbox-container {/,/^}/ s/display: [^;]* !important;/display: '"$1"' !important;/' "$CSS"
  else
    printf '\n.titlebar-buttonbox-container {\n  display: %s !important;\n}\n' "$1" >> "$CSS"
  fi
}

if [ "$SESSION" = "wayland" ]; then
  set_button_display "none"     # 极简 CSD，无按钮（unixchad 原版）
  echo "✔ Wayland 模式 → 极简单行 CSD，隐藏窗口按钮（unixchad 风格）"
else
  set_button_display "-moz-box" # 极简单行 CSD，显示 Firefox 自带 min/max/close
  echo "✔ X11 模式 → 极简单行 CSD，显示最小化/最大化/关闭按钮"
fi
echo "  已更新: $CSS"
echo "  请完全退出 Firefox 后重开生效。"
