Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Dec 2011 09:50:32 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:54352 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903667Ab1LAIuX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Dec 2011 09:50:23 +0100
Received: by ghrr19 with SMTP id r19so1901064ghr.36
        for <multiple recipients>; Thu, 01 Dec 2011 00:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xVPIZ0RCNWs7PtK+hpQUuO0u+kMc2Kiyuzh4yTUTZcI=;
        b=OuzBI246+Fc4+X9+uUtMm330EXkAhTVOfSNTVnykp3LSn711wSTnd8e4qVFOjdzou+
         639qV15TPR5KsaVz/3/FIVNd5cDrR4TRG8YiIkh8B7kORpz1cJiVq2+UzkKuWyUj26+c
         fACsPNF3TZydwnICWVd3mbs9lixmP0diL/PCw=
Received: by 10.101.6.3 with SMTP id j3mr1433164ani.49.1322729417587;
        Thu, 01 Dec 2011 00:50:17 -0800 (PST)
Received: from localhost.localdomain ([182.148.112.76])
        by mx.google.com with ESMTPS id x17sm13464994anj.18.2011.12.01.00.50.08
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Dec 2011 00:50:16 -0800 (PST)
From:   zhzhl555@gmail.com
To:     a.zummo@towertech.it, rtc-linux@googlegroups.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, keguang.zhang@gmail.com, wuzhangjin@gmail.com,
        r0bertz@gentoo.org, zhao zhang <zhzhl555@gmail.com>
Subject: [PATCH] MIPS: Add RTC support for loongson1B
Date:   Thu,  1 Dec 2011 16:44:38 +0800
Message-Id: <1322729078-6141-1-git-send-email-zhzhl555@gmail.com>
X-Mailer: git-send-email 1.7.0.4
X-archive-position: 32015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhzhl555@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 344

From: zhao zhang <zhzhl555@gmail.com>

V2: use new module_platform_driver macro.
thanks for Wolfram's advice.

This patch adds RTC support(TOY counter0) for loongson1B.
Signed-off-by: zhao zhang <zhzhl555@gmail.com>
---
 drivers/rtc/Kconfig    |   10 ++
 drivers/rtc/Makefile   |    1 +
 drivers/rtc/rtc-ls1x.c |  214 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-ls1x.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5a538fc..6f8c2d7 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1070,4 +1070,14 @@ config RTC_DRV_PUV3
 	  This drive can also be built as a module. If so, the module
 	  will be called rtc-puv3.
 
+config RTC_DRV_LOONGSON1
+	tristate "loongson1 RTC support"
+	depends on MACH_LOONGSON1
+	help
+	  This is a driver for the loongson1 on-chip Counter0 (Time-Of-Year
+	  counter) to be used as a RTC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ls1x.
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 6e69823..48153fe 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -109,3 +109,4 @@ obj-$(CONFIG_RTC_DRV_VT8500)	+= rtc-vt8500.o
 obj-$(CONFIG_RTC_DRV_WM831X)	+= rtc-wm831x.o
 obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
+obj-$(CONFIG_RTC_DRV_LOONGSON1)	+= rtc-ls1x.o
diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
new file mode 100644
index 0000000..79db272
--- /dev/null
+++ b/drivers/rtc/rtc-ls1x.c
@@ -0,0 +1,214 @@
+/*
+ * Copyright (c) 2011 Zhao Zhang <zhzhl555@gmail.com>
+ *
+ * Derived from driver/rtc/rtc-au1xxx.c
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/rtc.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/io.h>
+#include <asm/mach-loongson1/loongson1.h>
+
+#define LS1X_RTC_REG_OFFSET	(LS1X_RTC_BASE + 0x20)
+#define LS1X_RTC_REGS(x) \
+		((void __iomem *)KSEG1ADDR(LS1X_RTC_REG_OFFSET + (x)))
+
+/*RTC programmable counters 0 and 1*/
+#define SYS_COUNTER_CNTRL		(LS1X_RTC_REGS(0x20))
+#define SYS_CNTRL_ERS			(1 << 23)
+#define SYS_CNTRL_RTS			(1 << 20)
+#define SYS_CNTRL_RM2			(1 << 19)
+#define SYS_CNTRL_RM1			(1 << 18)
+#define SYS_CNTRL_RM0			(1 << 17)
+#define SYS_CNTRL_RS			(1 << 16)
+#define SYS_CNTRL_BP			(1 << 14)
+#define SYS_CNTRL_REN			(1 << 13)
+#define SYS_CNTRL_BRT			(1 << 12)
+#define SYS_CNTRL_TEN			(1 << 11)
+#define SYS_CNTRL_BTT			(1 << 10)
+#define SYS_CNTRL_E0			(1 << 8)
+#define SYS_CNTRL_ETS			(1 << 7)
+#define SYS_CNTRL_32S			(1 << 5)
+#define SYS_CNTRL_TTS			(1 << 4)
+#define SYS_CNTRL_TM2			(1 << 3)
+#define SYS_CNTRL_TM1			(1 << 2)
+#define SYS_CNTRL_TM0			(1 << 1)
+#define SYS_CNTRL_TS			(1 << 0)
+
+/* Programmable Counter 0 Registers */
+#define SYS_TOYTRIM		(LS1X_RTC_REGS(0))
+#define SYS_TOYWRITE0		(LS1X_RTC_REGS(4))
+#define SYS_TOYWRITE1		(LS1X_RTC_REGS(8))
+#define SYS_TOYREAD0		(LS1X_RTC_REGS(0xC))
+#define SYS_TOYREAD1		(LS1X_RTC_REGS(0x10))
+#define SYS_TOYMATCH0		(LS1X_RTC_REGS(0x14))
+#define SYS_TOYMATCH1		(LS1X_RTC_REGS(0x18))
+#define SYS_TOYMATCH2		(LS1X_RTC_REGS(0x1C))
+
+/* Programmable Counter 1 Registers */
+#define SYS_RTCTRIM		(LS1X_RTC_REGS(0x40))
+#define SYS_RTCWRITE0		(LS1X_RTC_REGS(0x44))
+#define SYS_RTCREAD0		(LS1X_RTC_REGS(0x48))
+#define SYS_RTCMATCH0		(LS1X_RTC_REGS(0x4C))
+#define SYS_RTCMATCH1		(LS1X_RTC_REGS(0x50))
+#define SYS_RTCMATCH2		(LS1X_RTC_REGS(0x54))
+
+#define LS1X_SEC_OFFSET		(4)
+#define LS1X_MIN_OFFSET		(10)
+#define LS1X_HOUR_OFFSET	(16)
+#define LS1X_DAY_OFFSET		(21)
+#define LS1X_MONTH_OFFSET	(26)
+
+
+#define LS1X_SEC_MASK		(0x3f)
+#define LS1X_MIN_MASK		(0x3f)
+#define LS1X_HOUR_MASK		(0x1f)
+#define LS1X_DAY_MASK		(0x1f)
+#define LS1X_MONTH_MASK		(0x3f)
+#define LS1X_YEAR_MASK		(0xffffffff)
+
+#define ls1x_get_sec(t)		(((t) >> LS1X_SEC_OFFSET) & LS1X_SEC_MASK)
+#define ls1x_get_min(t)		(((t) >> LS1X_MIN_OFFSET) & LS1X_MIN_MASK)
+#define ls1x_get_hour(t)	(((t) >> LS1X_HOUR_OFFSET) & LS1X_HOUR_MASK)
+#define ls1x_get_day(t)		(((t) >> LS1X_DAY_OFFSET) & LS1X_DAY_MASK)
+#define ls1x_get_month(t)	(((t) >> LS1X_MONTH_OFFSET) & LS1X_MONTH_MASK)
+
+#define RTC_CNTR_OK (SYS_CNTRL_E0 | SYS_CNTRL_32S)
+
+static int ls1x_rtc_read_time(struct device *dev, struct rtc_time *rtm)
+{
+	unsigned long v, t;
+
+	v = readl(SYS_TOYREAD0);
+	t = readl(SYS_TOYREAD1);
+
+	memset(rtm, 0, sizeof(struct rtc_time));
+	t  = mktime((t & LS1X_YEAR_MASK), ls1x_get_month(v),
+			ls1x_get_day(v), ls1x_get_hour(v),
+			ls1x_get_min(v), ls1x_get_sec(v));
+	rtc_time_to_tm(t, rtm);
+
+	return rtc_valid_tm(rtm);
+}
+
+static int ls1x_rtc_set_time(struct device *dev, struct  rtc_time *rtm)
+{
+	unsigned long v, t, c;
+	int ret = -ETIMEDOUT;
+
+	v = ((rtm->tm_mon + 1)  << LS1X_MONTH_OFFSET)
+		| (rtm->tm_mday << LS1X_DAY_OFFSET)
+		| (rtm->tm_hour << LS1X_HOUR_OFFSET)
+		| (rtm->tm_min  << LS1X_MIN_OFFSET)
+		| (rtm->tm_sec  << LS1X_SEC_OFFSET);
+
+	writel(v, SYS_TOYWRITE0);
+	__asm__ volatile ("sync");
+	c = 0x10000;
+	/* add timeout check counter, for more safe */
+	while ((readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_TS) && --c)
+		usleep_range(1000, 3000);
+
+	if (!c) {
+		dev_err(dev, "set time timeout!\n");
+		goto err;
+	}
+
+	t = rtm->tm_year + 1900;
+	writel(t, SYS_TOYWRITE1);
+	__asm__ volatile ("sync");
+	c = 0x10000;
+	while ((readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_TS) && --c)
+		usleep_range(1000, 3000);
+
+	if (!c) {
+		dev_err(dev, "set time timeout!\n");
+		goto err;
+	}
+	return 0;
+err:
+	return ret;
+}
+
+static struct rtc_class_ops  ls1x_rtc_ops = {
+	.read_time	= ls1x_rtc_read_time,
+	.set_time	= ls1x_rtc_set_time,
+};
+
+static int __devinit ls1x_rtc_probe(struct platform_device *pdev)
+{
+	struct rtc_device *rtcdev;
+	unsigned long v;
+	int ret;
+
+	v = readl(SYS_COUNTER_CNTRL);
+	if (!(v & RTC_CNTR_OK)) {
+		dev_err(&pdev->dev, "rtc counters not working\n");
+		ret = -ENODEV;
+		goto err;
+	}
+	ret = -ETIMEDOUT;
+	/* set to 1 HZ if needed */
+	if (readl(SYS_TOYTRIM) != 32767) {
+		v = 0x100000;
+		while ((readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_TTS) && --v)
+			usleep_range(1000, 3000);
+
+		if (!v) {
+			dev_err(&pdev->dev, "time out\n");
+			goto err;
+		}
+		writel(32767, SYS_TOYTRIM);
+		__asm__ volatile("sync");
+	}
+	/* this loop coundn't be endless */
+	while (readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_TTS)
+		usleep_range(1000, 3000);
+
+	rtcdev = rtc_device_register("ls1x-rtc", &pdev->dev,
+					&ls1x_rtc_ops , THIS_MODULE);
+	if (IS_ERR(rtcdev)) {
+		ret = PTR_ERR(rtcdev);
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, rtcdev);
+	return 0;
+err:
+	return ret;
+}
+
+static int __devexit ls1x_rtc_remove(struct platform_device *pdev)
+{
+	struct rtc_device *rtcdev = platform_get_drvdata(pdev);
+
+	rtc_device_unregister(rtcdev);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver  ls1x_rtc_driver = {
+	.driver		= {
+		.name	= "ls1x-rtc",
+		.owner	= THIS_MODULE,
+	},
+	.remove		= __devexit_p(ls1x_rtc_remove),
+	.probe		= ls1x_rtc_probe,
+};
+
+module_platform_driver(ls1x_rtc_driver);
+
+MODULE_AUTHOR("zhao zhang <zhzhl555@gmail.com>");
+MODULE_LICENSE("GPL");
+
-- 
1.7.0.4
