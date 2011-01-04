Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2011 21:31:16 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:48563 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491013Ab1ADU3M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jan 2011 21:29:12 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 8B8F745C01F;
        Tue,  4 Jan 2011 21:29:04 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id EDA121F0001;
        Tue,  4 Jan 2011 21:29:03 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v5 06/16] watchdog: add driver for the Atheros AR71XX/AR724X/AR913X SoCs
Date:   Tue,  4 Jan 2011 21:28:19 +0100
Message-Id: <1294172909-1309-7-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1294172909-1309-1-git-send-email-juhosg@openwrt.org>
References: <1294172909-1309-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A108C049158 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds a driver for the built-in hardware watchdog device
of the Atheros AR71XX/AR724X/AR913X SoCs.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
Changes since RFC: ---

Changes since v1:
    - rebased against 2.6.37-rc7

Changes since v2: ---

Changes since v3:
    - remove #ifdef CONFIG_WATCHDOG_NOWAYOUT for nowayout module-parameter.
    - add ath79_wdt_keepalive when doing un unexpected close of /dev/watchdog
      (the close is considered as communication with /dev/watchdog)
    - replace reboot_notifier with a platform shutdown.
    - add timeout module-parameter
    - rebased against 2.6.37-rc8

Changes since v4:
    - use __dev{init,exit,exit_p}
    - remove DRIVER_DESC definition and use its value directly in
      the MODULE_DESCRIPTION() macro
    - convert to use the clock API

 drivers/watchdog/Kconfig     |    7 +
 drivers/watchdog/Makefile    |    1 +
 drivers/watchdog/ath79_wdt.c |  305 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/ath79_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index a5ad77e..e4be010 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -836,6 +836,13 @@ config SBC_EPX_C3_WATCHDOG
 
 # MIPS Architecture
 
+config ATH79_WDT
+	tristate "Atheros AR71XX/AR724X/AR913X hardware watchdog"
+	depends on ATH79
+	help
+	  Hardware driver for the built-in watchdog timer on the Atheros
+	  AR71XX/AR724X/AR913X SoCs.
+
 config BCM47XX_WDT
 	tristate "Broadcom BCM47xx Watchdog Timer"
 	depends on BCM47XX
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 4b0ef38..01d9063 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
 # M68KNOMMU Architecture
 
 # MIPS Architecture
+obj-$(CONFIG_ATH79_WDT) += ath79_wdt.o
 obj-$(CONFIG_BCM47XX_WDT) += bcm47xx_wdt.o
 obj-$(CONFIG_BCM63XX_WDT) += bcm63xx_wdt.o
 obj-$(CONFIG_RC32434_WDT) += rc32434_wdt.o
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
new file mode 100644
index 0000000..725c84b
--- /dev/null
+++ b/drivers/watchdog/ath79_wdt.c
@@ -0,0 +1,305 @@
+/*
+ * Atheros AR71XX/AR724X/AR913X built-in hardware watchdog timer.
+ *
+ * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ * This driver was based on: drivers/watchdog/ixp4xx_wdt.c
+ *	Author: Deepak Saxena <dsaxena@plexity.net>
+ *	Copyright 2004 (c) MontaVista, Software, Inc.
+ *
+ * which again was based on sa1100 driver,
+ *	Copyright (C) 2000 Oleg Drokin <green@crimea.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+
+#define DRIVER_NAME	"ath79-wdt"
+
+#define WDT_TIMEOUT	15	/* seconds */
+
+#define WDOG_CTRL_LAST_RESET	BIT(31)
+#define WDOG_CTRL_ACTION_MASK	3
+#define WDOG_CTRL_ACTION_NONE	0	/* no action */
+#define WDOG_CTRL_ACTION_GPI	1	/* general purpose interrupt */
+#define WDOG_CTRL_ACTION_NMI	2	/* NMI */
+#define WDOG_CTRL_ACTION_FCR	3	/* full chip reset */
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+			   "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int timeout = WDT_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
+			  "(default=" __MODULE_STRING(WDT_TIMEOUT) "s)");
+
+static unsigned long wdt_flags;
+
+#define WDT_FLAGS_BUSY		0
+#define WDT_FLAGS_EXPECT_CLOSE	1
+
+static struct clk *wdt_clk;
+static unsigned long wdt_freq;
+static int boot_status;
+static int max_timeout;
+
+static inline void ath79_wdt_keepalive(void)
+{
+	ath79_reset_wr(AR71XX_RESET_REG_WDOG, wdt_freq * timeout);
+}
+
+static inline void ath79_wdt_enable(void)
+{
+	ath79_wdt_keepalive();
+	ath79_reset_wr(AR71XX_RESET_REG_WDOG_CTRL, WDOG_CTRL_ACTION_FCR);
+}
+
+static inline void ath79_wdt_disable(void)
+{
+	ath79_reset_wr(AR71XX_RESET_REG_WDOG_CTRL, WDOG_CTRL_ACTION_NONE);
+}
+
+static int ath79_wdt_set_timeout(int val)
+{
+	if (val < 1 || val > max_timeout)
+		return -EINVAL;
+
+	timeout = val;
+	ath79_wdt_keepalive();
+
+	return 0;
+}
+
+static int ath79_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(WDT_FLAGS_BUSY, &wdt_flags))
+		return -EBUSY;
+
+	clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
+	ath79_wdt_enable();
+
+	return nonseekable_open(inode, file);
+}
+
+static int ath79_wdt_release(struct inode *inode, struct file *file)
+{
+	if (test_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags))
+		ath79_wdt_disable();
+	else {
+		pr_crit(DRIVER_NAME ": device closed unexpectedly, "
+			"watchdog timer will not stop!\n");
+		ath79_wdt_keepalive();
+	}
+
+	clear_bit(WDT_FLAGS_BUSY, &wdt_flags);
+	clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
+
+	return 0;
+}
+
+static ssize_t ath79_wdt_write(struct file *file, const char *data,
+				size_t len, loff_t *ppos)
+{
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
+
+			for (i = 0; i != len; i++) {
+				char c;
+
+				if (get_user(c, data + i))
+					return -EFAULT;
+
+				if (c == 'V')
+					set_bit(WDT_FLAGS_EXPECT_CLOSE,
+						&wdt_flags);
+			}
+		}
+
+		ath79_wdt_keepalive();
+	}
+
+	return len;
+}
+
+static const struct watchdog_info ath79_wdt_info = {
+	.options		= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+				  WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
+	.firmware_version	= 0,
+	.identity		= "ATH79 watchdog",
+};
+
+static long ath79_wdt_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	int err;
+	int t;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		err = copy_to_user(argp, &ath79_wdt_info,
+				   sizeof(ath79_wdt_info)) ? -EFAULT : 0;
+		break;
+
+	case WDIOC_GETSTATUS:
+		err = put_user(0, p);
+		break;
+
+	case WDIOC_GETBOOTSTATUS:
+		err = put_user(boot_status, p);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		ath79_wdt_keepalive();
+		err = 0;
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		err = get_user(t, p);
+		if (err)
+			break;
+
+		err = ath79_wdt_set_timeout(t);
+		if (err)
+			break;
+
+		/* fallthrough */
+	case WDIOC_GETTIMEOUT:
+		err = put_user(timeout, p);
+		break;
+
+	default:
+		err = -ENOTTY;
+		break;
+	}
+
+	return err;
+}
+
+static const struct file_operations ath79_wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= ath79_wdt_write,
+	.unlocked_ioctl	= ath79_wdt_ioctl,
+	.open		= ath79_wdt_open,
+	.release	= ath79_wdt_release,
+};
+
+static struct miscdevice ath79_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &ath79_wdt_fops,
+};
+
+static int __devinit ath79_wdt_probe(struct platform_device *pdev)
+{
+	u32 ctrl;
+	int err;
+
+	wdt_clk = clk_get(&pdev->dev, "wdt");
+	if (IS_ERR(wdt_clk))
+		return PTR_ERR(wdt_clk);
+
+	err = clk_enable(wdt_clk);
+	if (err)
+		goto err_clk_put;
+
+	wdt_freq = clk_get_rate(wdt_clk);
+	if (!wdt_freq) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	max_timeout = (0xfffffffful / wdt_freq);
+	if (timeout < 1 || timeout > max_timeout) {
+		timeout = max_timeout;
+		dev_info(&pdev->dev,
+			"timeout value must be 0 < timeout < %d, using %d\n",
+			max_timeout, timeout);
+	}
+
+	ctrl = ath79_reset_rr(AR71XX_RESET_REG_WDOG_CTRL);
+	boot_status = (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET : 0;
+
+	err = misc_register(&ath79_wdt_miscdev);
+	if (err) {
+		dev_err(&pdev->dev,
+			"unable to register misc device, err=%d\n", err);
+		goto err_clk_disable;
+	}
+
+	return 0;
+
+err_clk_disable:
+	clk_disable(wdt_clk);
+err_clk_put:
+	clk_put(wdt_clk);
+	return err;
+}
+
+static int __devexit ath79_wdt_remove(struct platform_device *pdev)
+{
+	misc_deregister(&ath79_wdt_miscdev);
+	clk_disable(wdt_clk);
+	clk_put(wdt_clk);
+	return 0;
+}
+
+static void ath97_wdt_shutdown(struct platform_device *pdev)
+{
+	ath79_wdt_disable();
+}
+
+static struct platform_driver ath79_wdt_driver = {
+	.remove		= __devexit_p(ath79_wdt_remove),
+	.shutdown	= ath97_wdt_shutdown,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init ath79_wdt_init(void)
+{
+	return platform_driver_probe(&ath79_wdt_driver, ath79_wdt_probe);
+}
+module_init(ath79_wdt_init);
+
+static void __exit ath79_wdt_exit(void)
+{
+	platform_driver_unregister(&ath79_wdt_driver);
+}
+module_exit(ath79_wdt_exit);
+
+MODULE_DESCRIPTION("Atheros AR71XX/AR724X/AR913X hardware watchdog driver");
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org");
+MODULE_AUTHOR("Imre Kaloz <kaloz@openwrt.org");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.7.2.1
