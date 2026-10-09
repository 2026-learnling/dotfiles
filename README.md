# dotfiles

个人 Linux 配置仓库，使用 [GNU Stow](https://www.gnu.org/software/stow/) 管理软链接。

## 目录结构

```
dotfiles/
├── .mozilla/
│   └── firefox/
│       └── default-release/        # Firefox 极简风格配置（模板）
│           ├── chrome/
│           │   └── userChrome.css  # 单行布局 + 深色 + 直角地址栏
│           └── user.js             # UI缩放 + Bing + 隐私全家桶
├── scripts/
│   └── setup-firefox.sh            # Firefox 一键安装（自动找 profile）
└── README.md
```

## 已包含的配置

### Firefox（.mozilla/firefox/default-release/）

参考 [Bali10050/FirefoxCSS](https://github.com/Bali10050/FirefoxCSS) 与 unixchad 视频配置：

- **单行布局**：标签栏 + 导航栏合并成一行（34px），顶部空间减半
- **深色主题**：`firefox-compact-dark` + 全局 UI 缩放 80%
- **极简**：隐藏菜单/前进后退/地址栏图标/书签栏，地址栏直角无边框
- **键盘流**：配合 Tridactyl 使用（H/L 前进后退、Ctrl+W 关标签等）
- **Bing 默认引擎**：`browser.search.default.engineID = "bing"`
- **隐私全家桶**：遥测/实验/广告推荐/搜索建议/预取/定位/推送全部关闭

## 使用方法

### 前置条件

```bash
sudo pacman -S stow git firefox
```

### 安装 Firefox 配置

```bash
git clone https://github.com/<你的用户名>/dotfiles.git
cd dotfiles

# 方式一：stow 软链接（推荐，后续 git pull 自动同步）
stow -t ~ .mozilla
bash scripts/setup-firefox.sh

# 方式二：不装 stow，直接跑脚本（自动复制）
bash scripts/setup-firefox.sh
```

> **重要**：`setup-firefox.sh` 会自动定位你机器上的真实 profile（`xxxx.default-release`），并把模板复制过去 + 备份原配置。首次使用请先运行一次 Firefox 生成 profile。

### 安装后

1. 完全退出 Firefox 再重新打开
2. 安装扩展：**Tridactyl**（键盘操作）+ **uBlock Origin**（广告拦截）

## 还原

- 删除 `~/.mozilla/firefox/<profile>/chrome` 目录和 `user.js`
- 安装脚本会自动备份原配置到 `~/.mozilla/firefox/backup-<时间戳>/`

## 说明

- profile 目录名每台机器不同（随机生成），仓库中统一用 `default-release` 作为模板名，由脚本适配
- 其他软件的配置后续按同样模式添加到对应层级（如 `.config/xxx/`）

> AI生成
