Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2012 09:17:34 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:45078 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903644Ab2ARIR3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2012 09:17:29 +0100
Received: by iaek3 with SMTP id k3so2936362iae.36
        for <multiple recipients>; Wed, 18 Jan 2012 00:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+iHo++QyNRacD9jZZIa7YgpJ+yaG/X4PHFCTZy2f/+Y=;
        b=pXzkXI1sHmgDo+qe5n89hwcV2zH8BEpqRHfI42qZDEEPyq5E5GZCJXr3RLFT4a4gZW
         G1qh1owWs398EZolwzkRZ7q/avGCylcEXBtidyfumaUzUgpXYnMQrOOSlVIhmZSIX3DB
         a56ccACgOzLHvR/YkO4Hnn8ldMWlzTLKEAdpA=
Received: by 10.50.87.132 with SMTP id ay4mr1270389igb.2.1326874643357;
        Wed, 18 Jan 2012 00:17:23 -0800 (PST)
Received: from localhost.localdomain ([182.148.112.76])
        by mx.google.com with ESMTPS id 5sm86504429ibe.8.2012.01.18.00.17.16
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Jan 2012 00:17:21 -0800 (PST)
From:   zhzhl555@gmail.com
To:     a.zummo@towertech.it, rtc-linux@googlegroups.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, keguang.zhang@gmail.com, wuzhangjin@gmail.com,
        r0bertz@gentoo.org, zhao zhang <zhzhl555@gmail.com>
Subject: [PATCH V3] MIPS: Add RTC support for loongson1B
Date:   Wed, 18 Jan 2012 16:17:04 +0800
Message-Id: <1326874624-17867-1-git-send-email-zhzhl555@gmail.com>
X-Mailer: git-send-email 1.7.0.4
X-archive-position: 32286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhzhl555@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: zhao zhang <zhzhl555@gmail.com>

This patch adds RTC support(TOY counter0) for loongson1B SOC

change log:
V3:Remove sync instruction.
V2:Use new module_platform_driver macro.
V1:Replace __raw_writel/__raw_readl with writel/readl.

Signed-off-by: zhao zhang <zhzhl555@gmail.com>
---
 drivers/rtc/Kconfig    |   10 +++
 drivers/rtc/Makefile   |    1 +
 drivers/rtc/rtc-ls1x.c |  211 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+), 0 deletions(-)
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
index 6e69823..6c9387a 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_ISL12022)	+= rtc-isl12022.o
 obj-$(CONFIG_RTC_DRV_JZ4740)	+= rtc-jz4740.o
 obj-$(CONFIG_RTC_DRV_LPC32XX)	+= rtc-lpc32xx.o
+obj-$(CONFIG_RTC_DRV_LOONGSON1)	+= rtc-ls1x.o
 obj-$(CONFIG_RTC_DRV_M41T80)	+= rtc-m41t80.o
 obj-$(CONFIG_RTC_DRV_M41T93)	+= rtc-m41t93.o
 obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
new file mode 100644
index 0000000..7305986
--- /dev/null
+++ b/drivers/rtc/rtc-ls1x.c
@@ -0,0 +1,211 @@
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
