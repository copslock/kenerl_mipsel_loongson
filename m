Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Dec 2010 11:25:20 +0100 (CET)
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:7624 "EHLO
        mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490958Ab0L3KZR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Dec 2010 11:25:17 +0100
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEABbsG01R8tUZ/2dsb2JhbACkOXS/UQ2CZoJXBA
Received: from 25.213-242-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.242.213.25])
  by relay.skynet.be with ESMTP; 30 Dec 2010 11:25:07 +0100
Received: from wim by infomag with local (Exim 4.69)
        (envelope-from <wim@infomag.iguana.be>)
        id 1PYFgx-00022G-04; Thu, 30 Dec 2010 11:25:07 +0100
Date:   Thu, 30 Dec 2010 11:25:06 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 06/16] watchdog: add driver for the Atheros
        AR71XX/AR724X/AR913X SoCs
Message-ID: <20101230102506.GA6521@infomag.iguana.be>
References: <1293560437-7967-1-git-send-email-juhosg@openwrt.org> <1293560437-7967-7-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1293560437-7967-7-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Gabor,

> This patch adds a driver for the built-in hardware watchdog device
> of the Atheros AR71XX/AR724X/AR913X SoCs.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org
> ---
> 
> Changes since RFC: ---
> 
> Changes since v1:
>     - rebased against 2.6.37-rc7
> 
> Changes since v2: ---

I adapted the code a little bit:
Changes since v3:
* remove #ifdef CONFIG_WATCHDOG_NOWAYOUT for nowayout module-parameter.
* add ath79_wdt_keepalive when doing un unexpected close of /dev/watchdog (the close is considered as communication with /dev/watchdog)
* replace reboot_notifier with a platform shutdown.

Attached the new patch. Can you test it?

PS: is there a reason why you don't add a module-parameter for wdt_timeout?

Kind regards,
Wim.

-----------------------------------------------------------------------------------------
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index de99bf9..2ff135d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -866,6 +866,13 @@ config SBC_EPX_C3_WATCHDOG
 
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
index cd77f54..9b6b33a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
 # M68KNOMMU Architecture
 
 # MIPS Architecture
+obj-$(CONFIG_ATH79_WDT) += ath79_wdt.o
 obj-$(CONFIG_BCM47XX_WDT) += bcm47xx_wdt.o
 obj-$(CONFIG_BCM63XX_WDT) += bcm63xx_wdt.o
 obj-$(CONFIG_RC32434_WDT) += rc32434_wdt.o
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
new file mode 100644
index 0000000..f8e027b
--- /dev/null
+++ b/drivers/watchdog/ath79_wdt.c
@@ -0,0 +1,274 @@
+/*
+ * Atheros AR71XX/AR724X/AR913X built-in hardware watchdog timer.
+ *
+ * Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
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
+
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+
+#define DRIVER_NAME	"ath79-wdt"
+#define DRIVER_DESC	"Atheros AR71XX/AR724X/AR913X hardware watchdog driver"
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
+static unsigned long wdt_flags;
+
+#define WDT_FLAGS_BUSY		0
+#define WDT_FLAGS_EXPECT_CLOSE	1
+
+static int wdt_timeout = WDT_TIMEOUT;
+static int boot_status;
+static int max_timeout;
+
+static inline void ath79_wdt_keepalive(void)
+{
+	ath79_reset_wr(AR71XX_RESET_REG_WDOG, ath79_ahb_freq * wdt_timeout);
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
+	wdt_timeout = val;
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
+		err = put_user(wdt_timeout, p);
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
+static int __init ath79_wdt_probe(struct platform_device *pdev)
+{
+	u32 ctrl;
+	int err;
+
+	max_timeout = (0xfffffffful / ath79_ahb_freq);
+	wdt_timeout = (max_timeout < WDT_TIMEOUT) ? max_timeout : WDT_TIMEOUT;
+
+	ctrl = ath79_reset_rr(AR71XX_RESET_REG_WDOG_CTRL);
+	boot_status = (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET : 0;
+
+	err = misc_register(&ath79_wdt_miscdev);
+	if (err) {
+		dev_err(&pdev->dev,
+			"unable to register misc device, err=%d\n", err);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	return err;
+}
+
+static int __exit ath79_wdt_remove(struct platform_device *pdev)
+{
+	misc_deregister(&ath79_wdt_miscdev);
+	return 0;
+}
+
+static void ath97_wdt_shutdown(struct platform_device *pdev)
+{
+	ath79_wdt_disable();
+}
+
+static struct platform_driver ath79_wdt_driver = {
+	.remove		= __exit_p(ath79_wdt_remove),
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
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org");
+MODULE_AUTHOR("Imre Kaloz <kaloz@openwrt.org");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
