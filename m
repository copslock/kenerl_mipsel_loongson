Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2011 19:14:35 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36146 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491140Ab1EKRO2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2011 19:14:28 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4BHFgZR003659;
        Wed, 11 May 2011 18:15:42 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4BHFfn0003656;
        Wed, 11 May 2011 18:15:41 +0100
Date:   Wed, 11 May 2011 18:15:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V6] MIPS: lantiq: add watchdog support
Message-ID: <20110511171541.GA32073@linux-mips.org>
References: <1304629223-30537-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1304629223-30537-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 05, 2011 at 11:00:23PM +0200, John Crispin wrote:

> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-mips@linux-mips.org
> Cc: linux-watchdog@vger.kernel.org

I've folded your privately sent followon patch to use test_and_set_bit and
clear_bit in ltq_wdt_open rsp. ltq_wdt_release as requested by Wim and have
queued the result for 2.6.40.

For your enjoyment I'm posting the resulting patch below.

Thanks,

  Ralf

Date:   Thu,  5 May 2011 23:00:23 +0200
From:   John Crispin <blogic@openwrt.org>

MIPS: Lantiq: Add watchdog support

This patch adds the driver for the watchdog found inside the Lantiq SoC family.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-mips@linux-mips.org
Cc: linux-watchdog@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/2327/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/watchdog/Kconfig      |    6 
 drivers/watchdog/Makefile     |    1 
 drivers/watchdog/lantiq_wdt.c |  261 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)

Index: linux-queue/drivers/watchdog/Kconfig
===================================================================
--- linux-queue.orig/drivers/watchdog/Kconfig
+++ linux-queue/drivers/watchdog/Kconfig
@@ -990,6 +990,12 @@ config BCM63XX_WDT
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
Index: linux-queue/drivers/watchdog/Makefile
===================================================================
--- linux-queue.orig/drivers/watchdog/Makefile
+++ linux-queue/drivers/watchdog/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
 obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
 obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
 octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
+obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
 
 # PARISC Architecture
 
Index: linux-queue/drivers/watchdog/lantiq_wdt.c
===================================================================
--- /dev/null
+++ linux-queue/drivers/watchdog/lantiq_wdt.c
@@ -0,0 +1,261 @@
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
+ * IO access to the WDT core
+ */
+#define LTQ_WDT_PW1		0x00BE0000
+#define LTQ_WDT_PW2		0x00DC0000
+
+#define LTQ_WDT_CR		0x0	/* watchdog control register */
+#define LTQ_WDT_SR		0x8	/* watchdog status register */
+
+#define LTQ_WDT_SR_EN		(0x1 << 31)	/* enable bit */
+#define LTQ_WDT_SR_PWD		(0x3 << 26)	/* turn on power */
+#define LTQ_WDT_SR_CLKDIV	(0x3 << 24)	/* turn on clock and set */
+						/* divider to 0x40000 */
+#define LTQ_WDT_DIVIDER		0x40000
+#define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bit */
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+
+static void __iomem *ltq_wdt_membase;
+static unsigned long ltq_io_region_clk_rate;
+
+static unsigned long ltq_wdt_bootstatus;
+static unsigned long ltq_wdt_in_use;
+static int ltq_wdt_timeout = 30;
+static int ltq_wdt_ok_to_close;
+
+static void
+ltq_wdt_enable(void)
+{
+	ltq_wdt_timeout = ltq_wdt_timeout *
+			(ltq_io_region_clk_rate / LTQ_WDT_DIVIDER) + 0x1000;
+	if (ltq_wdt_timeout > LTQ_MAX_TIMEOUT)
+		ltq_wdt_timeout = LTQ_MAX_TIMEOUT;
+
+	/* write the first password magic */
+	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
+	/* write the second magic plus the configuration and new timeout */
+	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV |
+		LTQ_WDT_PW2 | ltq_wdt_timeout, ltq_wdt_membase + LTQ_WDT_CR);
+}
+
+static void
+ltq_wdt_disable(void)
+{
+	/* write the first password magic */
+	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
+	/* write the second password magic with no config
+	 * this turns the watchdog off
+	 */
+	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
+}
+
+static ssize_t
+ltq_wdt_write(struct file *file, const char __user *data,
+		size_t len, loff_t *ppos)
+{
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			ltq_wdt_ok_to_close = 0;
+			for (i = 0; i != len; i++) {
+				char c;
+
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					ltq_wdt_ok_to_close = 1;
+				else
+					ltq_wdt_ok_to_close = 0;
+			}
+		}
+		ltq_wdt_enable();
+	}
+
+	return len;
+}
+
+static struct watchdog_info ident = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+			WDIOF_CARDRESET,
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
+	case WDIOC_GETBOOTSTATUS:
+		ret = put_user(ltq_wdt_bootstatus, (int __user *)arg);
+		break;
+
+	case WDIOC_GETSTATUS:
+		ret = put_user(0, (int __user *)arg);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret = get_user(ltq_wdt_timeout, (int __user *)arg);
+		if (!ret)
+			ltq_wdt_enable();
+		/* intentional drop through */
+	case WDIOC_GETTIMEOUT:
+		ret = put_user(ltq_wdt_timeout, (int __user *)arg);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		ltq_wdt_enable();
+		ret = 0;
+		break;
+	}
+	return ret;
+}
+
+static int
+ltq_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &ltq_wdt_in_use))
+		return -EBUSY;
+	ltq_wdt_in_use = 1;
+	ltq_wdt_enable();
+
+	return nonseekable_open(inode, file);
+}
+
+static int
+ltq_wdt_release(struct inode *inode, struct file *file)
+{
+	if (ltq_wdt_ok_to_close)
+		ltq_wdt_disable();
+	else
+		pr_err("ltq_wdt: watchdog closed without warning\n");
+	ltq_wdt_ok_to_close = 0;
+	clear_bit(0, &ltq_wdt_in_use);
+
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
+static int __init
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
+
+	/* we do not need to enable the clock as it is always running */
+	clk = clk_get(&pdev->dev, "io");
+	WARN_ON(!clk);
+	ltq_io_region_clk_rate = clk_get_rate(clk);
+	clk_put(clk);
+
+	if (ltq_reset_cause() == LTQ_RST_CAUSE_WDTRST)
+		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+
+	return misc_register(&ltq_wdt_miscdev);
+}
+
+static int __devexit
+ltq_wdt_remove(struct platform_device *pdev)
+{
+	misc_deregister(&ltq_wdt_miscdev);
+
+	if (ltq_wdt_membase)
+		iounmap(ltq_wdt_membase);
+
+	return 0;
+}
+
+
+static struct platform_driver ltq_wdt_driver = {
+	.remove = __devexit_p(ltq_wdt_remove),
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
+	return platform_driver_unregister(&ltq_wdt_driver);
+}
+
+module_init(init_ltq_wdt);
+module_exit(exit_ltq_wdt);
+
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
+
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("Lantiq SoC Watchdog");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
