#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
urls2bookmarks.py — 把纯文本网址库转成 Firefox 书签 HTML

用法:
    python urls2bookmarks.py <urls.txt> [bookmarks.html]

输入文件格式 (每行一条):
    GitHub<TAB>https://github.com/2026-learnling/dotfiles
    百度<TAB>https://www.baidu.com
    名称<TAB>网址
  也可以每行只写一个网址（则网址同时作为名称），或"名称 网址"（空格分隔）。

输出:
    bookmarks.html（Netscape 书签格式，Firefox 可直接导入）

导入方法（二选一）:
  1. 地址栏输入 about:import → 从 HTML 文件导入
  2. 书签库 Ctrl+Shift+O → 导入和备份 → 从 HTML 文件导入

然后可在 Tridactyl 里用 :t 关键词 / :o 关键词 模糊搜索打开。
"""

import os
import re
import sys
from datetime import datetime

ADD_DATE = str(int(datetime.now().timestamp()))


def html_escape(s: str) -> str:
    """HTML 转义，避免破坏书签文件结构。"""
    return (
        s.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace('"', "&quot;")
    )


def line_to_entry(line: str):
    """解析一行，返回 (name, url)。无法解析时返回 ('', '')。"""
    line = line.strip()
    if not line or line.startswith("#"):
        return "", ""
    # 1) Tab 分隔：名称<TAB>网址
    if "\t" in line:
        name, url = line.split("\t", 1)
        return name.strip(), url.strip()
    # 2) 整行就是一个网址
    m = re.match(r"^https?://\S+", line)
    if m:
        return line, m.group(0)
    # 3) 空格分隔：名称 网址
    parts = line.split(None, 1)
    if len(parts) == 2:
        return parts[0], parts[1]
    # 4) 兜底：整行既当名又当网址
    return line, line


def build_html(entries):
    """生成 Netscape 书签 HTML。"""
    lines = [
        "<!DOCTYPE NETSCAPE-Bookmark-file-1>",
        "<!-- This is an automatically generated file. -->",
        '<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">',
        "<TITLE>Bookmarks</TITLE>",
        "<H1>Bookmarks</H1>",
        "<DL><p>",
    ]
    for name, url in entries:
        if not url:
            continue
        lines.append(
            f'    <DT><A HREF="{html_escape(url)}" ADD_DATE="{ADD_DATE}">{html_escape(name)}</A>'
        )
    lines.append("</DL><p>")
    return "\n".join(lines) + "\n"


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    src = sys.argv[1]
    if len(sys.argv) > 2:
        dst = sys.argv[2]
    else:
        dst = os.path.join(os.path.dirname(os.path.abspath(src)), "bookmarks.html")

    if not os.path.isfile(src):
        print(f"[!] 输入文件不存在: {src}")
        sys.exit(1)

    entries = []
    with open(src, "r", encoding="utf-8-sig") as f:
        for line in f:
            name, url = line_to_entry(line)
            if url:
                entries.append((name, url))

    html = build_html(entries)
    with open(dst, "w", encoding="utf-8") as f:
        f.write(html)

    print(f"[✓] 已生成: {dst}")
    print(f"    共 {len(entries)} 条书签")


if __name__ == "__main__":
    main()