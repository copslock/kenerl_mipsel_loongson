Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 11:04:25 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:57614 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491881Ab1CCKCc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Mar 2011 11:02:32 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH V3 05/10] MIPS: lantiq: add watchdog support
Date:   Thu,  3 Mar 2011 11:03:41 +0100
Message-Id: <1299146626-17428-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1299146626-17428-1-git-send-email-blogic@openwrt.org>
References: <1299146626-17428-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds the driver for the watchdog found inside the Lantiq SoC family.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-mips@linux-mips.org
Cc: linux-watchdog@vger.kernel.org
---
Changes in V2
* add comments to explain register access
* cleanup resource allocation
* cleanup clock handling
* whitespace fixes

Changes in V3
* whitespace
* change __iomem void to void __iomem
* typo fixes
* comment style
* fix exit path in init function

 drivers/watchdog/Kconfig      |    6 +
 drivers/watchdog/Makefile     |    1 +
 drivers/watchdog/lantiq_wdt.c |  235 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/lantiq_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2e2400e..c64f8c3 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -972,6 +972,12 @@ config BCM63XX_WDT
 	  To compile this driver as a loadable module, choose M here.
 	  The module will be called bcm63xx_wdt.
 
+config LANTIQ_WDT
+	tristate "Lantiq SoC watchdog"
+	depends on LANTIQ
+	help
+	  Hardware driver for the Lantiq SoC Watchdog Timer.
+
 # PARISC Architecture
 
 # POWERPC Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index dd77665..68299db 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
 obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
 obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
 octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
+obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
 
 # PARISC Architecture
 
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
new file mode 100644
index 0000000..d49ddaa
--- /dev/null
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -0,0 +1,235 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Based on EP93xx wdt driver
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <lantiq.h>
+
+/* Section 3.4 of the datasheet
+ * The password sequence protects the WDT control register from unintended
+ * write actions, which might cause malfunction of the WDT.
+ *
+ * essentially the following two magic passwords need to be written to allow
+ * io access to the wdt core
+ */
+#define LTQ_WDT_PW1		0x00BE0000
+#define LTQ_WDT_PW2		0x00DC0000
+
+#define LTQ_WDT_CR		0x03F0	/* watchdog control register */
+#define LTQ_WDT_SR		0x03F8	/* watchdog status register */
+
+#define LTQ_WDT_SR_EN		(0x1 << 31)	/* enable bit */
+#define LTQ_WDT_SR_PWD		(0x3 << 26)	/* turn on power */
+#define LTQ_WDT_SR_CLKDIV	(0x3 << 24)	/* turn on clock and set */
+						/* divider to 0x40000 */
+#define LTQ_WDT_DIVIDER		0x40000
+#define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bit */
+
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+static int ltq_wdt_ok_to_close;
+#endif
+
+static int ltq_wdt_timeout = 30;
+static void __iomem *ltq_wdt_membase;
+static unsigned long ltq_io_region_clk_rate;
+
+static void
+ltq_wdt_enable(unsigned int timeout)
+{
+	timeout = ((timeout * (ltq_io_region_clk_rate / LTQ_WDT_DIVIDER))
+		+ 0x1000);
+	if (timeout > LTQ_MAX_TIMEOUT)
+		timeout = LTQ_MAX_TIMEOUT;
+
+	/* write the first password magic */
+	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
+	/* write the second magic plus the configuration and new timeout */
+	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV |
+		LTQ_WDT_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
+}
+
+static void
+ltq_wdt_disable(void)
+{
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	ltq_wdt_ok_to_close = 0;
+#endif
+	/* write the first paswword magic */
+	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
+	/* write the second paswword magic with no config
+	 * this turns the watchdog off 
+	 */
+	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
+}
+
+static ssize_t
+ltq_wdt_write(struct file *file, const char __user *data,
+		size_t len, loff_t *ppos)
+{
+	size_t i;
+
+	if (!len)
+		return 0;
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	for (i = 0; i != len; i++) {
+		char c;
+
+		if (get_user(c, data + i))
+			return -EFAULT;
+		if (c == 'V')
+			ltq_wdt_ok_to_close = 1;
+	}
+#endif
+	ltq_wdt_enable(ltq_wdt_timeout);
+	return len;
+}
+
+static struct watchdog_info ident = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "ltq_wdt",
+};
+
+static long
+ltq_wdt_ioctl(struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	int ret = -ENOTTY;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
+				sizeof(ident)) ? -EFAULT : 0;
+		break;
+
+	case WDIOC_GETTIMEOUT:
+		ret = put_user(ltq_wdt_timeout, (int __user *)arg);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret = get_user(ltq_wdt_timeout, (int __user *)arg);
+		if (!ret)
+			ltq_wdt_enable(ltq_wdt_timeout);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		ltq_wdt_enable(ltq_wdt_timeout);
+		ret = 0;
+		break;
+	}
+	return ret;
+}
+
+static int
+ltq_wdt_open(struct inode *inode, struct file *file)
+{
+	ltq_wdt_enable(ltq_wdt_timeout);
+	return nonseekable_open(inode, file);
+}
+
+static int
+ltq_wdt_release(struct inode *inode, struct file *file)
+{
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	if (ltq_wdt_ok_to_close)
+		ltq_wdt_disable();
+	else
+#endif
+		pr_err("ltq_wdt: watchdog closed without warning\n");
+	return 0;
+}
+
+static const struct file_operations ltq_wdt_fops = {
+	.owner		= THIS_MODULE,
+	.write		= ltq_wdt_write,
+	.unlocked_ioctl	= ltq_wdt_ioctl,
+	.open		= ltq_wdt_open,
+	.release	= ltq_wdt_release,
+	.llseek		= no_llseek,
+};
+
+static struct miscdevice ltq_wdt_miscdev = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &ltq_wdt_fops,
+};
+
+static int
+ltq_wdt_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct clk *clk;
+
+	if (!res) {
+		dev_err(&pdev->dev, "cannot obtain I/O memory region");
+		return -ENOENT;
+	}
+	res = devm_request_mem_region(&pdev->dev, res->start,
+		resource_size(res), dev_name(&pdev->dev));
+	if (!res) {
+		dev_err(&pdev->dev, "cannot request I/O memory region");
+		return -EBUSY;
+	}
+	ltq_wdt_membase = devm_ioremap_nocache(&pdev->dev, res->start,
+		resource_size(res));
+	if (!ltq_wdt_membase) {
+		dev_err(&pdev->dev, "cannot remap I/O memory region\n");
+		return -ENOMEM;
+	}
+	/* we do not need to enable the clock as it is always running */
+	clk = clk_get(&pdev->dev, "io");
+	if (!clk)
+		BUG();
+	ltq_io_region_clk_rate = clk_get_rate(clk);
+	clk_put(clk);
+	return misc_register(&ltq_wdt_miscdev);
+}
+
+static int __exit
+ltq_wdt_remove(struct platform_device *dev)
+{
+	ltq_wdt_disable();
+	misc_deregister(&ltq_wdt_miscdev);
+	return 0;
+}
+
+static struct platform_driver ltq_wdt_driver = {
+	.probe = ltq_wdt_probe,
+	.remove = ltq_wdt_remove,
+	.driver = {
+		.name = "ltq_wdt",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init
+init_ltq_wdt(void)
+{
+	return platform_driver_probe(&ltq_wdt_driver, ltq_wdt_probe);
+}
+
+static void __exit
+exit_ltq_wdt(void)
+{
+	platform_driver_unregister(&ltq_wdt_driver);
+}
+
+module_init(init_ltq_wdt);
+module_exit(exit_ltq_wdt);
+
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("Lantiq Watchdog");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.7.2.3
