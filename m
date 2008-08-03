Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Aug 2008 18:42:49 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:19422 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20038521AbYHCRl5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Aug 2008 18:41:57 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KPhab-0004pW-01; Sun, 03 Aug 2008 19:41:53 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 797B51DA6F4; Sun,  3 Aug 2008 19:41:40 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] M48T35: new RTC driver
To:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org
cc:	a.zummo@towertech.it, ralf@linux-mips.org
Message-Id: <20080803174140.797B51DA6F4@solo.franken.de>
Date:	Sun,  3 Aug 2008 19:41:40 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

This driver replaces the broken ip27-rtc driver in drivers/char and
gives back RTC support for SGI IP27 machines.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 drivers/rtc/Kconfig      |   10 ++
 drivers/rtc/Makefile     |    1 +
 drivers/rtc/rtc-m48t35.c |  238 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 90ab738..725d9a5 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -405,6 +405,16 @@ config RTC_DRV_M48T86
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-m48t86.
 
+config RTC_DRV_M48T35
+	tristate "ST M48T35"
+	depends on SGI_IP27
+	help
+	  If you say Y here you will get support for the
+	  ST M48T35 RTC chip.
+
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-m48t35".
+
 config RTC_DRV_M48T59
 	tristate "ST M48T59"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 18622ef..7d10cc0 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_RTC_DRV_FM3130)	+= rtc-fm3130.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_M41T80)	+= rtc-m41t80.o
 obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
+obj-$(CONFIG_RTC_DRV_M48T35)	+= rtc-m48t35.o
 obj-$(CONFIG_RTC_DRV_M48T59)	+= rtc-m48t59.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
new file mode 100644
index 0000000..7add023
--- /dev/null
+++ b/drivers/rtc/rtc-m48t35.c
@@ -0,0 +1,238 @@
+/*
+ * Driver for the SGS-Thomson M48T35 Timekeeper RAM chip
+ *
+ * Copyright (C) 2000 Silicon Graphics, Inc.
+ * Written by Ulf Carlsson (ulfc@engr.sgi.com)
+ *
+ * Copyright (C) 2008 Thomas Bogendoerfer
+ *
+ * Based on code written by Paul Gortmaker.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <linux/bcd.h>
+
+#define DRV_VERSION		"1.0"
+
+struct m48t35_rtc {
+	u8	pad[0x7ff8];    /* starts at 0x7ff8 */
+	u8	control;
+	u8	sec;
+	u8	min;
+	u8	hour;
+	u8	day;
+	u8	date;
+	u8	month;
+	u8	year;
+};
+
+#define M48T35_RTC_SET		0x80
+#define M48T35_RTC_READ		0x40
+
+struct m48t35_priv {
+	struct rtc_device *rtc;
+	struct m48t35_rtc __iomem *reg;
+	size_t size;
+	unsigned long baseaddr;
+	spinlock_t lock;
+};
+
+static unsigned char days_in_mo[] = {
+	0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
+};
+
+static int m48t35_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct m48t35_priv *priv = dev_get_drvdata(dev);
+	u8 control;
+
+	/*
+	 * Only the values that we read from the RTC are set. We leave
+	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
+	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
+	 * by the RTC when initially set to a non-zero value.
+	 */
+	spin_lock_irq(&priv->lock);
+	control = readb(&priv->reg->control);
+	writeb(control | M48T35_RTC_READ, &priv->reg->control);
+	tm->tm_sec = readb(&priv->reg->sec);
+	tm->tm_min = readb(&priv->reg->min);
+	tm->tm_hour = readb(&priv->reg->hour);
+	tm->tm_mday = readb(&priv->reg->date);
+	tm->tm_mon = readb(&priv->reg->month);
+	tm->tm_year = readb(&priv->reg->year);
+	writeb(control, &priv->reg->control);
+	spin_unlock_irq(&priv->lock);
+
+	tm->tm_sec = BCD2BIN(tm->tm_sec);
+	tm->tm_min = BCD2BIN(tm->tm_min);
+	tm->tm_hour = BCD2BIN(tm->tm_hour);
+	tm->tm_mday = BCD2BIN(tm->tm_mday);
+	tm->tm_mon = BCD2BIN(tm->tm_mon);
+	tm->tm_year = BCD2BIN(tm->tm_year);
+
+	/*
+	 * Account for differences between how the RTC uses the values
+	 * and how they are defined in a struct rtc_time;
+	 */
+	tm->tm_year += 70;
+	if (tm->tm_year <= 69)
+		tm->tm_year += 100;
+
+	tm->tm_mon--;
+	return rtc_valid_tm(tm);
+}
+
+static int m48t35_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct m48t35_priv *priv = dev_get_drvdata(dev);
+	unsigned char mon, day, hrs, min, sec, leap_yr;
+	unsigned int yrs;
+	u8 control;
+
+	yrs = tm->tm_year + 1900;
+	mon = tm->tm_mon + 1;   /* tm_mon starts at zero */
+	day = tm->tm_mday;
+	hrs = tm->tm_hour;
+	min = tm->tm_min;
+	sec = tm->tm_sec;
+
+	if (yrs < 1970)
+		return -EINVAL;
+
+	leap_yr = ((!(yrs % 4) && (yrs % 100)) || !(yrs % 400));
+
+	if ((mon > 12) || (day == 0))
+		return -EINVAL;
+
+	if (day > (days_in_mo[mon] + ((mon == 2) && leap_yr)))
+		return -EINVAL;
+
+	if ((hrs >= 24) || (min >= 60) || (sec >= 60))
+		return -EINVAL;
+
+	yrs -= 1970;
+	if (yrs > 255)    /* They are unsigned */
+		return -EINVAL;
+
+	if (yrs > 169)
+		return -EINVAL;
+
+	if (yrs >= 100)
+		yrs -= 100;
+
+	sec = BIN2BCD(sec);
+	min = BIN2BCD(min);
+	hrs = BIN2BCD(hrs);
+	day = BIN2BCD(day);
+	mon = BIN2BCD(mon);
+	yrs = BIN2BCD(yrs);
+
+	spin_lock_irq(&priv->lock);
+	control = readb(&priv->reg->control);
+	writeb(control | M48T35_RTC_SET, &priv->reg->control);
+	writeb(yrs, &priv->reg->year);
+	writeb(mon, &priv->reg->month);
+	writeb(day, &priv->reg->date);
+	writeb(hrs, &priv->reg->hour);
+	writeb(min, &priv->reg->min);
+	writeb(sec, &priv->reg->sec);
+	writeb(control, &priv->reg->control);
+	spin_unlock_irq(&priv->lock);
+	return 0;
+}
+
+static const struct rtc_class_ops m48t35_ops = {
+	.read_time	= m48t35_read_time,
+	.set_time	= m48t35_set_time,
+};
+
+static int __devinit m48t35_probe(struct platform_device *pdev)
+{
+	struct rtc_device *rtc;
+	struct resource *res;
+	struct m48t35_priv *priv;
+	int ret = 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+	priv = kzalloc(sizeof *priv, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->size = res->end - res->start + 1;
+	if (!request_mem_region(res->start, priv->size, pdev->name)) {
+		ret = -EBUSY;
+		goto out;
+	}
+	priv->baseaddr = res->start;
+	priv->reg = (struct m48t35_rtc __iomem *)res->start;
+	if (!priv->reg) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	spin_lock_init(&priv->lock);
+	rtc = rtc_device_register("m48t35", &pdev->dev,
+				  &m48t35_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		ret = PTR_ERR(rtc);
+		goto out;
+	}
+	priv->rtc = rtc;
+	platform_set_drvdata(pdev, priv);
+	return 0;
+
+out:
+	if (priv->rtc)
+		rtc_device_unregister(priv->rtc);
+	if (priv->baseaddr)
+		release_mem_region(priv->baseaddr, priv->size);
+	kfree(priv);
+	return ret;
+}
+
+static int __devexit m48t35_remove(struct platform_device *pdev)
+{
+	struct m48t35_priv *priv = platform_get_drvdata(pdev);
+
+	rtc_device_unregister(priv->rtc);
+	release_mem_region(priv->baseaddr, priv->size);
+	kfree(priv);
+	return 0;
+}
+
+static struct platform_driver m48t35_platform_driver = {
+	.driver		= {
+		.name	= "rtc-m48t35",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= m48t35_probe,
+	.remove		= __devexit_p(m48t35_remove),
+};
+
+static int __init m48t35_init(void)
+{
+	return platform_driver_register(&m48t35_platform_driver);
+}
+
+static void __exit m48t35_exit(void)
+{
+	platform_driver_unregister(&m48t35_platform_driver);
+}
+
+MODULE_AUTHOR("Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
+MODULE_DESCRIPTION("M48T35 RTC driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("platform:rtc-m48t35");
+
+module_init(m48t35_init);
+module_exit(m48t35_exit);
