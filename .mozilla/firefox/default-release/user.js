// user.js (firefox) — Arch Linux 版
// 配置参考 unixchad 视频《修正firefox: tridactyl, user.js, userChrome.css》
// 与 Windows 版保持一致：单行布局 + 深色 + 隐私全家桶 + Bing 默认引擎

user_pref("layout.css.devPixelsPerPx", "0.80"); // 全局 UI 缩放 80%，顶栏更矮（视频核心）
// enable userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org"); // 深色紧凑主题
user_pref("browser.tabs.closeWindowWithLastTab", false); // 关闭最后一个标签不关窗口
user_pref("browser.newtab.privateAllowed", true);
user_pref("browser.search.region", "CN"); // 搜索区域保持 CN，避免区域默认逻辑覆盖
user_pref("browser.region.update.region", "CN");
user_pref("browser.search.default.engineID", "bing"); // 默认搜索引擎=Bing（新版引擎ID为 bing）
user_pref("browser.search.default.engineName", "Bing");
user_pref("browser.search.order.1", "bing");
user_pref("browser.urlbar.placeholderName", "Bing"); // 地址栏搜索提示
user_pref("browser.urlbar.placeholderName.private", "Bing");
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.toolbars.bookmarks.showOtherBookmarks", false);
user_pref("browser.toolbars.bookmarks.visibility", "never");
// 会话记录间隔加长，减少写盘
user_pref("browser.sessionstore.interval", 600000);
// 禁用全屏警告
user_pref("full-screen-api.warning.timeout", 0);
// telemetry 遥测关闭
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.pioneer-new-studies-available", false);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
// 广告/推荐关闭
user_pref("extensions.pocket.enabled", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.showWeather", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
// 自动填充关闭
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
// 隐私
user_pref("network.captive-portal-service.enabled", false);
user_pref("dom.security.https_only_mode_pbm", true);
user_pref("privacy.annotate_channels.strict_list.enabled", true);
user_pref("privacy.clearHistory.cache", false);
user_pref("privacy.clearHistory.cookiesAndStorage", false);
user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", false);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.fingerprintingProtection", true);
user_pref("privacy.globalprivacycontrol.enabled", true);
user_pref("privacy.query_stripping.enabled", true);
user_pref("privacy.query_stripping.enabled.pbmode", true);
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("privacy.trackingprotection.emailtracking.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
// 扩展存储迁移标记（tridactyl / uBlock）
user_pref("extensions.webextensions.ExtensionStorageIDB.migrated.addon@darkreader.org", true);
user_pref("extensions.webextensions.ExtensionStorageIDB.migrated.tridactyl.vim@cmcaine.co.uk", true);
user_pref("extensions.webextensions.ExtensionStorageIDB.migrated.uBlock0@raymondhill.net", true);

// ============================ 信息收集 / 遥测 / 数据外发 全面关闭 ============================

// --- 遥测主开关 ---
user_pref("toolkit.telemetry.enabled", false);                    // 遥测总开关
user_pref("toolkit.telemetry.unified", false);                    // 统一遥测
user_pref("toolkit.telemetry.archive.enabled", false);            // 遥测存档
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // 关机上报
user_pref("toolkit.telemetry.eventping.enabled", false);          // 事件上报
user_pref("toolkit.telemetry.newProfilePing.enabled", false);     // 新配置上报
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);  // 首次关机上报
user_pref("toolkit.telemetry.updatePing.enabled", false);         // 更新上报
user_pref("toolkit.telemetry.bhrPing.enabled", false);            // 后台阻塞上报
user_pref("toolkit.telemetry.coverage.enabled", false);           // 覆盖率统计
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);   // 首次运行策略上报
user_pref("toolkit.telemetry.pioneer-new-studies-available", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);   // 数据提交总开关
user_pref("datareporting.policy.dataSubmissionPolicyBypassNotification", true); // 跳过上报通知
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("browser.ping-centre.telemetry", false);                // 中心遥测
user_pref("browser.newtabpage.activity-stream.telemetry", false); // 新标签页遥测

// 2. 实验/远程研究（Nimbus / Shield / Normandy）
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);                    // 远程实验
user_pref("app.normandy.api_url", "");                       // 不拉取实验配置
user_pref("app.normandy.first_run", false);
user_pref("browser.discovery.enabled", false);               // 发现推荐内容

// 3) 新标签页：推荐内容与推送
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false); // 顶栏提示条
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.enabled", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.showWeather", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);   // 推荐扩展
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false); // 推荐功能
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr", false);
user_pref("browser.aboutwelcome.enabled", false);            // 欢迎引导页
user_pref("browser.messaging-system.whatsNewPanel.enabled", false); // 新功能面板

// 4. 崩溃报告（不上传、不弹窗）
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashreport.installed", false);
user_pref("toolkit.crashreporter.infoURL", "");

// 5. 搜索建议 / 地址栏联网
user_pref("browser.search.suggest.enabled", false);          // 搜索建议（输入即外发）
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.suggest.topsites", false);         // 热门站建议
user_pref("browser.urlbar.suggest.pocket", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);     // 快建议（含遥测）
user_pref("browser.urlbar.quicksuggest.dataCollection.enabled", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.speculativeConnect.enabled", false); // 地址栏预连接

// 6. 网络预测/预取/DNS（减少隐形请求）
user_pref("network.prefetch-next", false);                   // 链接预取
user_pref("network.dns.disablePrefetch", true);              // DNS 预取
user_pref("network.predictor.enabled", false);               // 网络预测
user_pref("network.predictor.enable-prefetch", false);
user_pref("network.http.speculative-parallel-limit", 0);     // 推测连接
user_pref("network.idle-connection-timeout", 30);
user_pref("browser.places.speculativeConnect.enabled", false); // 地址栏推测连接

// 7. 地理位置 / 区域检测
user_pref("geo.enabled", false);                             // 关闭定位
user_pref("geo.provider.use_corelocation", false);
user_pref("geo.provider.network.url", "");                   // 不请求定位服务
user_pref("browser.region.network.url", "");                  // 不自动检测区域
user_pref("browser.region.update.region", false);

// 8. 附加组件商店推荐 / 扩展发现
user_pref("extensions.htmlaboutaddons.discover.enabled", false); // 扩展发现页
user_pref("extensions.getAddons.cache.enabled", false);        // 扩展推荐缓存
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("extensions.webservice.discoverURL", "");

// 9. 其他杂项外发
user_pref("browser.send_pings", false);                       // 关闭引用 ping 跟踪
user_pref("browser.ping.events", false);
user_pref("browser.uitour.enabled", false);                  // 内嵌引导外拉
user_pref("browser.uitour.url", "");
user_pref("browser.shell.checkDefaultBrowser", false);       // 不自动检查默认浏览器
user_pref("dom.push.enabled", false);                        // Web 推送（服务端下发）
user_pref("dom.webnotifications.enabled", false);            // 网站通知
user_pref("devtools.onboarding.telemetry.logged", true);     // 开发者工具遥测
user_pref("devtools.telemetry.enabled", false);
user_pref("network.captive-portal-service.enabled", false);
user_pref("captivedetect.canonicalURL", "");                 // 去掉强制门户检测
user_pref("network.connectivity-service.enabled", false);    // 联网检测上报