Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2013 18:14:47 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45912 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816206Ab3ALRO3Jw5g1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2013 18:14:29 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 9ECB38F6A;
        Sat, 12 Jan 2013 18:14:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kd+rRvRSs7DC; Sat, 12 Jan 2013 18:14:18 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id E31958F62;
        Sat, 12 Jan 2013 18:14:17 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     wim@iguana.be
Cc:     linux-watchdog@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 1/5] watchdog: bcm47xx_wdt.c: convert to watchdog core api
Date:   Sat, 12 Jan 2013 18:14:07 +0100
Message-Id: <1358010851-28077-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35407
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

Convert the bcm47xx_wdt.c driver to the new watchdog core api.

The nowayout parameter is now added unconditionally to the module.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/Kconfig       |    1 +
 drivers/watchdog/bcm47xx_wdt.c |  152 ++++++----------------------------------
 2 files changed, 23 insertions(+), 130 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7f809fd..e6eb363 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -971,6 +971,7 @@ config ATH79_WDT
 config BCM47XX_WDT
 	tristate "Broadcom BCM47xx Watchdog Timer"
 	depends on BCM47XX
+	select WATCHDOG_CORE
 	help
 	  Hardware driver for the Broadcom BCM47xx Watchdog Timer.
 
diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index bc0e91e..4c520d6 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -14,15 +14,12 @@
 
 #include <linux/bitops.h>
 #include <linux/errno.h>
-#include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/reboot.h>
 #include <linux/types.h>
-#include <linux/uaccess.h>
 #include <linux/watchdog.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
@@ -41,15 +38,11 @@ module_param(wdt_time, int, 0);
 MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="
 				__MODULE_STRING(WDT_DEFAULT_TIME) ")");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-#endif
 
-static unsigned long bcm47xx_wdt_busy;
-static char expect_release;
 static struct timer_list wdt_timer;
 static atomic_t ticks;
 
@@ -97,29 +90,31 @@ static void bcm47xx_timer_tick(unsigned long unused)
 	}
 }
 
-static inline void bcm47xx_wdt_pet(void)
+static int bcm47xx_wdt_keepalive(struct watchdog_device *wdd)
 {
 	atomic_set(&ticks, wdt_time);
+
+	return 0;
 }
 
-static void bcm47xx_wdt_start(void)
+static int bcm47xx_wdt_start(struct watchdog_device *wdd)
 {
 	bcm47xx_wdt_pet();
 	bcm47xx_timer_tick(0);
+
+	return 0;
 }
 
-static void bcm47xx_wdt_pause(void)
+static int bcm47xx_wdt_stop(struct watchdog_device *wdd)
 {
 	del_timer_sync(&wdt_timer);
 	bcm47xx_wdt_hw_stop();
-}
 
-static void bcm47xx_wdt_stop(void)
-{
-	bcm47xx_wdt_pause();
+	return 0;
 }
 
-static int bcm47xx_wdt_settimeout(int new_time)
+static int bcm47xx_wdt_set_timeout(struct watchdog_device *wdd,
+				   unsigned int new_time)
 {
 	if ((new_time <= 0) || (new_time > WDT_MAX_TIME))
 		return -EINVAL;
@@ -128,51 +123,6 @@ static int bcm47xx_wdt_settimeout(int new_time)
 	return 0;
 }
 
-static int bcm47xx_wdt_open(struct inode *inode, struct file *file)
-{
-	if (test_and_set_bit(0, &bcm47xx_wdt_busy))
-		return -EBUSY;
-
-	bcm47xx_wdt_start();
-	return nonseekable_open(inode, file);
-}
-
-static int bcm47xx_wdt_release(struct inode *inode, struct file *file)
-{
-	if (expect_release == 42) {
-		bcm47xx_wdt_stop();
-	} else {
-		pr_crit("Unexpected close, not stopping watchdog!\n");
-		bcm47xx_wdt_start();
-	}
-
-	clear_bit(0, &bcm47xx_wdt_busy);
-	expect_release = 0;
-	return 0;
-}
-
-static ssize_t bcm47xx_wdt_write(struct file *file, const char __user *data,
-				size_t len, loff_t *ppos)
-{
-	if (len) {
-		if (!nowayout) {
-			size_t i;
-
-			expect_release = 0;
-
-			for (i = 0; i != len; i++) {
-				char c;
-				if (get_user(c, data + i))
-					return -EFAULT;
-				if (c == 'V')
-					expect_release = 42;
-			}
-		}
-		bcm47xx_wdt_pet();
-	}
-	return len;
-}
-
 static const struct watchdog_info bcm47xx_wdt_info = {
 	.identity	= DRV_NAME,
 	.options	= WDIOF_SETTIMEOUT |
@@ -180,80 +130,25 @@ static const struct watchdog_info bcm47xx_wdt_info = {
 				WDIOF_MAGICCLOSE,
 };
 
-static long bcm47xx_wdt_ioctl(struct file *file,
-					unsigned int cmd, unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-	int new_value, retval = -EINVAL;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user(argp, &bcm47xx_wdt_info,
-				sizeof(bcm47xx_wdt_info)) ? -EFAULT : 0;
-
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, p);
-
-	case WDIOC_SETOPTIONS:
-		if (get_user(new_value, p))
-			return -EFAULT;
-
-		if (new_value & WDIOS_DISABLECARD) {
-			bcm47xx_wdt_stop();
-			retval = 0;
-		}
-
-		if (new_value & WDIOS_ENABLECARD) {
-			bcm47xx_wdt_start();
-			retval = 0;
-		}
-
-		return retval;
-
-	case WDIOC_KEEPALIVE:
-		bcm47xx_wdt_pet();
-		return 0;
-
-	case WDIOC_SETTIMEOUT:
-		if (get_user(new_value, p))
-			return -EFAULT;
-
-		if (bcm47xx_wdt_settimeout(new_value))
-			return -EINVAL;
-
-		bcm47xx_wdt_pet();
-
-	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_time, p);
-
-	default:
-		return -ENOTTY;
-	}
-}
-
 static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
-	unsigned long code, void *unused)
+				  unsigned long code, void *unused)
 {
 	if (code == SYS_DOWN || code == SYS_HALT)
 		bcm47xx_wdt_stop();
 	return NOTIFY_DONE;
 }
 
-static const struct file_operations bcm47xx_wdt_fops = {
+static struct watchdog_ops bcm47xx_wdt_ops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.unlocked_ioctl	= bcm47xx_wdt_ioctl,
-	.open		= bcm47xx_wdt_open,
-	.release	= bcm47xx_wdt_release,
-	.write		= bcm47xx_wdt_write,
+	.start		= bcm47xx_wdt_start,
+	.stop		= bcm47xx_wdt_stop,
+	.ping		= bcm47xx_wdt_keepalive,
+	.set_timeout	= bcm47xx_wdt_set_timeout,
 };
 
-static struct miscdevice bcm47xx_wdt_miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= "watchdog",
-	.fops		= &bcm47xx_wdt_fops,
+static struct watchdog_device bcm47xx_wdt_wdd = {
+	.info		= &bcm47xx_wdt_info,
+	.ops		= &bcm47xx_wdt_ops,
 };
 
 static struct notifier_block bcm47xx_wdt_notifier = {
@@ -274,12 +169,13 @@ static int __init bcm47xx_wdt_init(void)
 		pr_info("wdt_time value must be 0 < wdt_time < %d, using %d\n",
 			(WDT_MAX_TIME + 1), wdt_time);
 	}
+	watchdog_set_nowayout(&bcm47xx_wdt_wdd, nowayout);
 
 	ret = register_reboot_notifier(&bcm47xx_wdt_notifier);
 	if (ret)
 		return ret;
 
-	ret = misc_register(&bcm47xx_wdt_miscdev);
+	ret = watchdog_register_device(&bcm47xx_wdt_wdd);
 	if (ret) {
 		unregister_reboot_notifier(&bcm47xx_wdt_notifier);
 		return ret;
@@ -292,10 +188,7 @@ static int __init bcm47xx_wdt_init(void)
 
 static void __exit bcm47xx_wdt_exit(void)
 {
-	if (!nowayout)
-		bcm47xx_wdt_stop();
-
-	misc_deregister(&bcm47xx_wdt_miscdev);
+	watchdog_unregister_device(&bcm47xx_wdt_wdd);
 
 	unregister_reboot_notifier(&bcm47xx_wdt_notifier);
 }
@@ -306,4 +199,3 @@ module_exit(bcm47xx_wdt_exit);
 MODULE_AUTHOR("Aleksandar Radovanovic");
 MODULE_DESCRIPTION("Watchdog driver for Broadcom BCM47xx");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.7.10.4
