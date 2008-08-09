Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Aug 2008 15:14:15 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:42203 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28583142AbYHIOOH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 9 Aug 2008 15:14:07 +0100
Received: (qmail 400 invoked from network); 9 Aug 2008 16:14:03 +0200
Received: from flagship.roarinelk.net (192.168.0.197)
  by fnoeppeil48.netpark.at with SMTP; 9 Aug 2008 16:14:03 +0200
Date:	Sat, 9 Aug 2008 16:14:02 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	rtc-linux@googlegroups.com, Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [RFC PATCH] Au1xxx on-chip counter-as-RTC driver
Message-ID: <20080809161402.15e24b2e@flagship.roarinelk.net>
Organization: Private
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

Here's a very simple patch which implements an RTC using
the TOY counter (counter0) on the Au1000 family of SoCs.

It works so far on the DB1200 board; however it takes up
to 5 seconds until the written value actually hits the
register, so the hardware clock is always off (the minimum
seems to be 3 seconds on the DB1200).  I'd like to get
some feedback on how to work around this "anomaly".

Patch applies on top of the Au1xxx update patches posted
here: http://marc.info/?l=linux-mips&m=121735077313715&w=2
and current -git.

Thanks!
	Manuel Lauss

--- 
From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] RTC: Au1000 On-Chip Counter0-as-RTC driver.

This simple driver uses Counter0 of the Au1xxx SoC as a
Real Time Clock.  Currently it only supports setting and
retrieving time.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/platform.c |    8 --
 arch/mips/au1000/pb1200/platform.c |    6 +
 drivers/rtc/Kconfig                |    9 ++
 drivers/rtc/Makefile               |    1 +
 drivers/rtc/rtc-au1xxx.c           |  188 ++++++++++++++++++++++++++++++++++++
 5 files changed, 204 insertions(+), 8 deletions(-)
 create mode 100644 drivers/rtc/rtc-au1xxx.c

diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index 9d12e6b..f29930e 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -616,14 +616,6 @@ static struct attribute_group db1x_pmattr_group = {
  */
 static int __init pm_init(void)
 {
-	/* init TOY to tick at 1Hz. No need to wait for access bits
-	 * since there's plenty of time between here and the first
-	 * suspend cycle.
-	 */
-	au_writel(32767, SYS_TOYTRIM);
-	au_writel(0, SYS_TOYWRITE);
-	au_sync();
-
 	db1x_pm_last_wakesrc = au_readl(SYS_WAKESRC);
 
 	au_writel(0, SYS_WAKESRC);
diff --git a/arch/mips/au1000/pb1200/platform.c b/arch/mips/au1000/pb1200/platform.c
index 9530329..1a5b160 100644
--- a/arch/mips/au1000/pb1200/platform.c
+++ b/arch/mips/au1000/pb1200/platform.c
@@ -152,7 +152,13 @@ static struct platform_device smc91c111_device = {
 	.resource	= smc91c111_resources
 };
 
+static struct platform_device rtc_device = {
+	.name	= "rtc-au1xxx",
+	.id	= -1,
+};
+
 static struct platform_device *board_platform_devices[] __initdata = {
+	&rtc_device,
 	&ide_device,
 	&smc91c111_device
 };
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 90ab738..8747a66 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -559,6 +559,15 @@ config RTC_DRV_AT91SAM9_GPBR
 	  will be used.  The default of zero is normally OK to use, but
 	  on some systems other software needs to use that register.
 
+config RTC_DRV_AU1XXX
+	tristate "Au1xxx TOY-as-RTC support"
+	depends on SOC_AU1X00
+	help
+	  This driver uses Au1000 on-chip Counter0 as a Real Time Clock.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-au1xxx.
+
 config RTC_DRV_BFIN
 	tristate "Blackfin On-Chip RTC"
 	depends on BLACKFIN
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 18622ef..6a33a18 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -20,6 +20,7 @@ rtc-core-$(CONFIG_RTC_INTF_SYSFS) += rtc-sysfs.o
 obj-$(CONFIG_RTC_DRV_AT32AP700X)+= rtc-at32ap700x.o
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
+obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
 obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
 obj-$(CONFIG_RTC_DRV_DS1216)	+= rtc-ds1216.o
diff --git a/drivers/rtc/rtc-au1xxx.c b/drivers/rtc/rtc-au1xxx.c
new file mode 100644
index 0000000..0b67832
--- /dev/null
+++ b/drivers/rtc/rtc-au1xxx.c
@@ -0,0 +1,188 @@
+/*
+ * Au1xxx On-Chip Counters Real Time Clock interface driver.
+ *
+ * Copyright (C) 2008 Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+/* All currently known (to me at least) Au1xxx chips have 2 counters with
+ * programmable dividers, fed by an external 32.768 kHz clocksource.
+ * Counter 0, which keeps counting during sleep/powerdown, is used here
+ * as a simple 1Hz counter which stores the current date as the time in
+ * seconds since the dawn of the UNIX epoch.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/rtc.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <asm/mach-au1x00/au1000.h>
+
+/* 32kHz clock enabled and detected */
+#define CNTR_OK (SYS_CNTRL_E0 | SYS_CNTRL_32S)
+
+struct au1xtoy_rtc {
+	struct rtc_device *rtc_dev;
+	spinlock_t lock;
+};
+
+static int au1xtoy_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct au1xtoy_rtc *rtc = platform_get_drvdata(pdev);
+	unsigned long t;
+
+	spin_lock_irq(&rtc->lock);
+
+	t = au_readl(SYS_TOYREAD);
+	rtc_time_to_tm(t, tm);
+
+	if (rtc_valid_tm(tm) < 0) {
+		dev_err(dev, "invalid date\n");
+		rtc_time_to_tm(0, tm);
+	}
+
+	spin_unlock_irq(&rtc->lock);
+
+	return 0;
+}
+
+static int au1xtoy_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct au1xtoy_rtc *rtc = platform_get_drvdata(pdev);
+	unsigned long t;
+
+	rtc_tm_to_time(tm, &t);
+
+	spin_lock_irq(&rtc->lock);
+
+	au_writel(t, SYS_TOYWRITE);
+	au_sync();
+
+	/* wait until the hardware again allows writes to the TOY counter */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
+		asm volatile ("nop");
+
+	spin_unlock_irq(&rtc->lock);
+
+	return 0;
+}
+
+static struct rtc_class_ops au1xtoy_rtc_ops = {
+	.read_time	= au1xtoy_rtc_read_time,
+	.set_time	= au1xtoy_rtc_set_time,
+};
+
+static int __devinit au1xtoy_rtc_probe(struct platform_device *pdev)
+{
+	struct au1xtoy_rtc *rtc;
+	unsigned long u, to;
+	int ret;
+
+	rtc = kzalloc(sizeof(struct au1xtoy_rtc), GFP_KERNEL);
+	if (unlikely(!rtc))
+		return -ENOMEM;
+
+	spin_lock_init(&rtc->lock);
+
+	/* In Firmware We Trust(TM): if the firmware has enabled the
+	 * counters and hardware says 32kHz clock is detected, then
+	 * we can consider the counters usable.
+	 */
+	u = au_readl(SYS_COUNTER_CNTRL);
+	if (!(u & CNTR_OK)) {
+		dev_err(&pdev->dev, "counters disabled by firmware\n");
+		ret = -ENODEV;
+		goto out_err;
+	}
+
+	ret = -ETIMEDOUT;
+
+	/* wait until hardware gives access to TRIM register */
+	to = 0x00100000;
+	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T0S) && to--)
+		asm volatile ("nop");
+
+	if (!to) {
+		/* timed out waiting for register access.  Counters may
+		 * be unusable, so bail out.
+		 */
+		dev_err(&pdev->dev, "timed out waiting for reg access\n");
+		goto out_err;
+	}
+
+	/* set 1Hz TOY tick rate */
+	au_writel(32767, SYS_TOYTRIM);
+	au_sync();
+
+	/* wait until the hardware allows writes to the TOY counter, so
+	 * that the first write succeeds immediately.
+	 */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
+		asm volatile ("nop");
+
+	rtc->rtc_dev = rtc_device_register("rtc-au1xxx", &pdev->dev,
+					   &au1xtoy_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc->rtc_dev)) {
+		ret = PTR_ERR(rtc->rtc_dev);
+		goto out_err;
+	}
+
+	platform_set_drvdata(pdev, rtc);
+
+	printk(KERN_INFO "Au1000 TOY-based Real Time Clock installed.\n");
+
+	return 0;
+
+out_err:
+	kfree(rtc);
+	return ret;
+}
+
+static int __devexit au1xtoy_rtc_remove(struct platform_device *pdev)
+{
+	struct au1xtoy_rtc *rtc = platform_get_drvdata(pdev);
+
+	if (likely(rtc->rtc_dev))
+		rtc_device_unregister(rtc->rtc_dev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	kfree(rtc);
+
+	return 0;
+}
+
+static struct platform_driver au1xtoy_rtc_platform_driver = {
+	.driver		= {
+		.name	= "rtc-au1xxx",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= au1xtoy_rtc_probe,
+	.remove		= __devexit_p(au1xtoy_rtc_remove),
+};
+
+static int __init au1xtoy_rtc_init(void)
+{
+	return platform_driver_register(&au1xtoy_rtc_platform_driver);
+}
+
+static void __exit au1xtoy_rtc_exit(void)
+{
+	platform_driver_unregister(&au1xtoy_rtc_platform_driver);
+}
+
+module_init(au1xtoy_rtc_init);
+module_exit(au1xtoy_rtc_exit);
+
+MODULE_DESCRIPTION("Au1xxx On-Chip counter RTC driver");
+MODULE_AUTHOR("Manuel Lauss");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:rtc-au1xxx");
-- 
1.5.6.4
