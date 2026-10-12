# dotfiles

个人 Linux 配置仓库，使用 [GNU Stow](https://www.gnu.org/software/stow/) 管理软链接。

## 目录结构

```
dotfiles/
├── .mozilla/
│   └── firefox/
│       ├── default-release/        # Arch 版（unixchad 原版极简，窗口按钮由 WM 提供）
│       │   ├── chrome/
│       │   │   └── userChrome.css  # 单行布局 + 深色 + 直角地址栏
│       │   └── user.js             # UI缩放 + Bing + 隐私全家桶
│       └── ubuntu-default-release/ # Ubuntu/Debian 版（极简单行 + 显示窗口按钮）
│           ├── chrome/
│           │   └── userChrome.css
│           └── user.js
├── scripts/
│   ├── setup-firefox.sh            # Firefox 一键安装（按发行版自动选模板 + 找 profile）
│   └── firefox-session-mode.sh     # 按 X11/Wayland 切换窗口按钮
└── README.md
```

## 已包含的配置

### Firefox（两种发行版模板，二选一自动选用）

参考 [Bali10050/FirefoxCSS](https://github.com/Bali10050/FirefoxCSS) 与 unixchad 视频配置。
两种模板**外观完全一致**（单行极简 + 深色 + 全局 UI 缩放 80%），区别只在窗口控制按钮：

| 模板 | 适用 | 窗口控制按钮（最小/最大/关闭） |
|------|------|-------------------------------|
| `default-release/`      | **Arch** | 由桌面 WM 提供；CSD（标签融入标题栏）下隐藏（unixchad 原版） |
| `ubuntu-default-release/` | **Ubuntu / Debian** | 在 CSD 单行外观上**显示** Firefox 自带按钮（普通桌面需要） |

> 共用特性：
> - **单行布局**：标签栏 + 导航栏合并成一行（34px），顶部空间减半
> - **深色主题**：`firefox-compact-dark` + 全局 UI 缩放 80%
> - **极简**：隐藏菜单/前进后退/地址栏图标/书签栏，地址栏直角无边框
> - **键盘流**：配合 Tridactyl 使用（H/L 前进后退、Ctrl+W 关标签等）
> - **Bing 默认引擎**：`browser.search.default.engineID = "bing"`
> - **隐私全家桶**：遥测/实验/广告推荐/搜索建议/预取/定位/推送全部关闭

`setup-firefox.sh` 会读取 `/etc/os-release` 自动选用对应模板（Arch → `default-release`，
Debian/Ubuntu → `ubuntu-default-release`，未知发行版默认用 Ubuntu 版）。

## 使用方法

### 前置条件

```bash
# Arch
sudo pacman -S stow git firefox
# Ubuntu / Debian
sudo apt install stow git firefox
```

### 安装 Firefox 配置

```bash
git clone https://github.com/2026-learnling/dotfiles.git
cd dotfiles

# 方式一：stow 软链接（默认路径 ~/.mozilla/firefox 时推荐）
stow -t ~ .mozilla
bash scripts/setup-firefox.sh

# 方式二：不装 stow，直接跑脚本（自动检测路径 + 按发行版选模板，推荐）
bash scripts/setup-firefox.sh
```

> **路径自动检测**：脚本会自动识别以下任一 Firefox 配置根目录并安装：
> - `~/.mozilla/firefox`（默认）
> - `~/.config/firefox`（XDG 模式）
> - `~/.config/mozilla/firefox`（XDG 变体）
>
> 如果你机器的配置目录是 `~/.config/mozilla/firefox`，直接用**方式二**即可，无需 stow。

> **发行版自动选择**：脚本读取 `/etc/os-release`，Arch 用 `default-release` 模板，
> Debian/Ubuntu 用 `ubuntu-default-release` 模板（带窗口按钮）。

### Ubuntu / Wayland 用户：窗口按钮切换

`ubuntu-default-release` 默认在普通桌面（X11）显示窗口按钮。若你切换到 **Wayland**
想回到 unixchad 无按钮极简风格，运行：

```bash
bash scripts/firefox-session-mode.sh          # 按当前 $XDG_SESSION_TYPE 自动判断
# 测试: XDG_SESSION_TYPE=wayland bash scripts/firefox-session-mode.sh
```

改完**完全退出 Firefox 再重开**生效。脚本只切换 `.titlebar-buttonbox-container`
的显隐，不影响其它样式。

### 安装后

1. 完全退出 Firefox 再重新打开
2. 安装扩展：**Tridactyl**（键盘操作）+ **uBlock Origin**（广告拦截）

## 还原

- 删除 `~/.mozilla/firefox/<profile>/chrome` 目录和 `user.js`
- 安装脚本会自动备份原配置到 `~/.mozilla/firefox/backup-<时间戳>/`

## 说明

- profile 目录名每台机器不同（随机生成），仓库中统一用 `default-release`（Arch）与
  `ubuntu-default-release`（Ubuntu/Debian）作为模板名，由脚本按发行版适配
- 其他软件的配置后续按同样模式添加到对应层级（如 `.config/xxx/`）

> AI生成