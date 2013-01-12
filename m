Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2013 18:15:26 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45930 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823015Ab3ALROeib7TE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2013 18:14:34 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 5007D8F61;
        Sat, 12 Jan 2013 18:14:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fFzfDbJETiMY; Sat, 12 Jan 2013 18:14:26 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 3111B8F65;
        Sat, 12 Jan 2013 18:14:18 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     wim@iguana.be
Cc:     linux-watchdog@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 2/5] watchdog: bcm47xx_wdt.c: use platform device
Date:   Sat, 12 Jan 2013 18:14:08 +0100
Message-Id: <1358010851-28077-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Instead of accessing the function to set the watchdog timer directly,
register a platform driver the platform could register to use this
watchdog driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/bcm47xx_wdt.c |  156 ++++++++++++++++++++--------------------
 include/linux/bcm47xx_wdt.h    |    9 +++
 2 files changed, 87 insertions(+), 78 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 4c520d6..cf1191b 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2008 Aleksandar Radovanovic <biblbroks@sezampro.rs>
  *  Copyright (C) 2009 Matthieu CASTET <castet.matthieu@free.fr>
+ *  Copyright (C) 2012 Hauke Mehrtens <hauke@hauke-m.de>
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -12,19 +13,19 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bcm47xx_wdt.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
-#include <linux/ssb/ssb_embedded.h>
-#include <asm/mach-bcm47xx/bcm47xx.h>
 
 #define DRV_NAME		"bcm47xx_wdt"
 
@@ -43,48 +44,19 @@ MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static struct timer_list wdt_timer;
-static atomic_t ticks;
-
-static inline void bcm47xx_wdt_hw_start(void)
+static inline struct bcm47xx_wdt *bcm47xx_wdt_get(struct watchdog_device *wdd)
 {
-	/* this is 2,5s on 100Mhz clock  and 2s on 133 Mhz */
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 0xfffffff);
-		break;
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		bcma_chipco_watchdog_timer_set(&bcm47xx_bus.bcma.bus.drv_cc,
-					       0xfffffff);
-		break;
-#endif
-	}
+	return container_of(wdd, struct bcm47xx_wdt, wdd);
 }
 
-static inline int bcm47xx_wdt_hw_stop(void)
+static void bcm47xx_timer_tick(unsigned long data)
 {
-	switch (bcm47xx_bus_type) {
-#ifdef CONFIG_BCM47XX_SSB
-	case BCM47XX_BUS_TYPE_SSB:
-		return ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 0);
-#endif
-#ifdef CONFIG_BCM47XX_BCMA
-	case BCM47XX_BUS_TYPE_BCMA:
-		bcma_chipco_watchdog_timer_set(&bcm47xx_bus.bcma.bus.drv_cc, 0);
-		return 0;
-#endif
-	}
-	return -EINVAL;
-}
+	struct bcm47xx_wdt *wdt = (struct bcm47xx_wdt *)data;
+	u32 next_tick = min(wdt->wdd.timeout * 1000, wdt->max_timer_ms);
 
-static void bcm47xx_timer_tick(unsigned long unused)
-{
-	if (!atomic_dec_and_test(&ticks)) {
-		bcm47xx_wdt_hw_start();
-		mod_timer(&wdt_timer, jiffies + HZ);
+	if (!atomic_dec_and_test(&wdt->soft_ticks)) {
+		wdt->timer_set_ms(wdt, next_tick);
+		mod_timer(&wdt->soft_timer, jiffies + HZ);
 	} else {
 		pr_crit("Watchdog will fire soon!!!\n");
 	}
@@ -92,23 +64,29 @@ static void bcm47xx_timer_tick(unsigned long unused)
 
 static int bcm47xx_wdt_keepalive(struct watchdog_device *wdd)
 {
-	atomic_set(&ticks, wdt_time);
+	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
+
+	atomic_set(&wdt->soft_ticks, wdd->timeout);
 
 	return 0;
 }
 
 static int bcm47xx_wdt_start(struct watchdog_device *wdd)
 {
-	bcm47xx_wdt_pet();
-	bcm47xx_timer_tick(0);
+	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
+
+	bcm47xx_wdt_keepalive(wdd);
+	bcm47xx_timer_tick((unsigned long)wdt);
 
 	return 0;
 }
 
 static int bcm47xx_wdt_stop(struct watchdog_device *wdd)
 {
-	del_timer_sync(&wdt_timer);
-	bcm47xx_wdt_hw_stop();
+	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
+
+	del_timer_sync(&wdt->soft_timer);
+	wdt->timer_set(wdt, 0);
 
 	return 0;
 }
@@ -116,10 +94,13 @@ static int bcm47xx_wdt_stop(struct watchdog_device *wdd)
 static int bcm47xx_wdt_set_timeout(struct watchdog_device *wdd,
 				   unsigned int new_time)
 {
-	if ((new_time <= 0) || (new_time > WDT_MAX_TIME))
+	if (new_time < 1 || new_time > WDT_MAX_TIME) {
+		pr_warn("timeout value must be 1<=x<=%d, using %d\n",
+			WDT_MAX_TIME, new_time);
 		return -EINVAL;
+	}
 
-	wdt_time = new_time;
+	wdd->timeout = new_time;
 	return 0;
 }
 
@@ -133,8 +114,11 @@ static const struct watchdog_info bcm47xx_wdt_info = {
 static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
 				  unsigned long code, void *unused)
 {
+	struct bcm47xx_wdt *wdt;
+
+	wdt = container_of(this, struct bcm47xx_wdt, notifier);
 	if (code == SYS_DOWN || code == SYS_HALT)
-		bcm47xx_wdt_stop();
+		wdt->wdd.ops->stop(&wdt->wdd);
 	return NOTIFY_DONE;
 }
 
@@ -146,56 +130,72 @@ static struct watchdog_ops bcm47xx_wdt_ops = {
 	.set_timeout	= bcm47xx_wdt_set_timeout,
 };
 
-static struct watchdog_device bcm47xx_wdt_wdd = {
-	.info		= &bcm47xx_wdt_info,
-	.ops		= &bcm47xx_wdt_ops,
-};
-
-static struct notifier_block bcm47xx_wdt_notifier = {
-	.notifier_call = bcm47xx_wdt_notify_sys,
-};
-
-static int __init bcm47xx_wdt_init(void)
+static int __devinit bcm47xx_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct bcm47xx_wdt *wdt = dev_get_platdata(&pdev->dev);
 
-	if (bcm47xx_wdt_hw_stop() < 0)
-		return -ENODEV;
+	if (!wdt)
+		return -ENXIO;
 
-	setup_timer(&wdt_timer, bcm47xx_timer_tick, 0L);
+	setup_timer(&wdt->soft_timer, bcm47xx_timer_tick,
+		    (long unsigned int)wdt);
 
-	if (bcm47xx_wdt_settimeout(wdt_time)) {
-		bcm47xx_wdt_settimeout(WDT_DEFAULT_TIME);
-		pr_info("wdt_time value must be 0 < wdt_time < %d, using %d\n",
-			(WDT_MAX_TIME + 1), wdt_time);
-	}
-	watchdog_set_nowayout(&bcm47xx_wdt_wdd, nowayout);
+	wdt->wdd.ops = &bcm47xx_wdt_ops;
+	wdt->wdd.info = &bcm47xx_wdt_info;
+	wdt->wdd.timeout = WDT_DEFAULT_TIME;
+	ret = wdt->wdd.ops->set_timeout(&wdt->wdd, timeout);
+	if (ret)
+		goto err_timer;
+	watchdog_set_nowayout(&wdt->wdd, nowayout);
+
+	wdt->notifier.notifier_call = &bcm47xx_wdt_notify_sys;
 
-	ret = register_reboot_notifier(&bcm47xx_wdt_notifier);
+	ret = register_reboot_notifier(&wdt->notifier);
 	if (ret)
-		return ret;
+		goto err_timer;
 
-	ret = watchdog_register_device(&bcm47xx_wdt_wdd);
-	if (ret) {
-		unregister_reboot_notifier(&bcm47xx_wdt_notifier);
-		return ret;
-	}
+	ret = watchdog_register_device(&wdt->wdd);
+	if (ret)
+		goto err_notifier;
 
 	pr_info("BCM47xx Watchdog Timer enabled (%d seconds%s)\n",
 		wdt_time, nowayout ? ", nowayout" : "");
 	return 0;
+
+err_notifier:
+	unregister_reboot_notifier(&wdt->notifier);
+err_timer:
+	del_timer_sync(&wdt->soft_timer);
+
+	return ret;
 }
 
-static void __exit bcm47xx_wdt_exit(void)
+static int __devexit bcm47xx_wdt_remove(struct platform_device *pdev)
 {
-	watchdog_unregister_device(&bcm47xx_wdt_wdd);
+	struct bcm47xx_wdt *wdt = dev_get_platdata(&pdev->dev);
+
+	if (!wdt)
+		return -ENXIO;
+
+	watchdog_unregister_device(&wdt->wdd);
+	unregister_reboot_notifier(&wdt->notifier);
 
-	unregister_reboot_notifier(&bcm47xx_wdt_notifier);
+	return 0;
 }
 
-module_init(bcm47xx_wdt_init);
-module_exit(bcm47xx_wdt_exit);
+static struct platform_driver bcm47xx_wdt_driver = {
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "bcm47xx-wdt",
+	},
+	.probe		= bcm47xx_wdt_probe,
+	.remove		= __devexit_p(bcm47xx_wdt_remove),
+};
+
+module_platform_driver(bcm47xx_wdt_driver);
 
 MODULE_AUTHOR("Aleksandar Radovanovic");
+MODULE_AUTHOR("Hauke Mehrtens <hauke@hauke-m.de>");
 MODULE_DESCRIPTION("Watchdog driver for Broadcom BCM47xx");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/bcm47xx_wdt.h b/include/linux/bcm47xx_wdt.h
index e5dfc25..b708786 100644
--- a/include/linux/bcm47xx_wdt.h
+++ b/include/linux/bcm47xx_wdt.h
@@ -1,7 +1,10 @@
 #ifndef LINUX_BCM47XX_WDT_H_
 #define LINUX_BCM47XX_WDT_H_
 
+#include <linux/notifier.h>
+#include <linux/timer.h>
 #include <linux/types.h>
+#include <linux/watchdog.h>
 
 
 struct bcm47xx_wdt {
@@ -10,6 +13,12 @@ struct bcm47xx_wdt {
 	u32 max_timer_ms;
 
 	void *driver_data;
+
+	struct watchdog_device wdd;
+	struct notifier_block notifier;
+
+	struct timer_list soft_timer;
+	atomic_t soft_ticks;
 };
 
 static inline void *bcm47xx_wdt_get_drvdata(struct bcm47xx_wdt *wdt)
-- 
1.7.10.4
