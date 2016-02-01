Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 23:40:05 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:51729 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012036AbcBAWjuurzIJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 23:39:50 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Mon, 1 Feb 2016
 15:39:43 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Mon, 01 Feb 2016
 15:43:33 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <rtc-linux@googlegroups.com>
Subject: [PATCH 2/2] rtc: rtc-pic32: Add PIC32 real time clock driver
Date:   Mon, 1 Feb 2016 15:43:22 -0700
Message-ID: <1454366606-10779-2-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1454366606-10779-1-git-send-email-joshua.henderson@microchip.com>
References: <1454366606-10779-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

This drivers adds support for the PIC32 real time clock and calendar
peripheral:
     - reading and setting time
     - alarms when connected to an IRQ

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 drivers/rtc/Kconfig     |   10 ++
 drivers/rtc/Makefile    |    1 +
 drivers/rtc/rtc-pic32.c |  450 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 461 insertions(+)
 create mode 100644 drivers/rtc/rtc-pic32.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 376322f..c8fc40e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1622,6 +1622,16 @@ config RTC_DRV_XGENE
 	  This driver can also be built as a module, if so, the module
 	  will be called "rtc-xgene".
 
+config RTC_DRV_PIC32
+	tristate "Microchip PIC32 RTC"
+	depends on MACH_PIC32
+	default y
+	help
+	   If you say yes here you get support for the PIC32 RTC module.
+
+	   This driver can also be built as a module. If so, the module
+	   will be called rtc-pic32
+
 comment "HID Sensor RTC drivers"
 
 config RTC_DRV_HID_SENSOR_TIME
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 62d61b2..20c9be5 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -162,3 +162,4 @@ obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_XGENE)	+= rtc-xgene.o
 obj-$(CONFIG_RTC_DRV_ZYNQMP)	+= rtc-zynqmp.o
+obj-$(CONFIG_RTC_DRV_PIC32)	+= rtc-pic32.o
diff --git a/drivers/rtc/rtc-pic32.c b/drivers/rtc/rtc-pic32.c
new file mode 100644
index 0000000..7c46ccb
--- /dev/null
+++ b/drivers/rtc/rtc-pic32.c
@@ -0,0 +1,450 @@
+/*
+ * PIC32 RTC driver
+ *
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2016 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+
+#include <asm/mach-pic32/pic32.h>
+
+#define DRIVER_NAME "pic32-rtc"
+
+#define PIC32_RTCCON		(0x00)
+#define PIC32_RTCCON_ON		BIT(15)
+#define PIC32_RTCCON_SIDL	BIT(13)
+#define PIC32_RTCCON_RTCCLKSEL	(3 << 9)
+#define PIC32_RTCCON_RTCCLKON	BIT(6)
+#define PIC32_RTCCON_RTCWREN	BIT(3)
+#define PIC32_RTCCON_RTCSYNC	BIT(2)
+#define PIC32_RTCCON_HALFSEC	BIT(1)
+#define PIC32_RTCCON_RTCOE	BIT(0)
+
+#define PIC32_RTCALRM		(0x10)
+#define PIC32_RTCALRM_ALRMEN	BIT(15)
+#define PIC32_RTCALRM_CHIME	BIT(14)
+#define PIC32_RTCALRM_PIV	BIT(13)
+#define PIC32_RTCALRM_ALARMSYNC	BIT(12)
+#define PIC32_RTCALRM_AMASK	(0x0F << 8)
+#define PIC32_RTCALRM_ARPT	(0xFF << 0)
+
+#define PIC32_RTCHOUR		0x23
+#define PIC32_RTCMIN		0x22
+#define PIC32_RTCSEC		0x21
+#define PIC32_RTCYEAR		0x33
+#define PIC32_RTCMON		0x32
+#define PIC32_RTCDAY		0x31
+
+#define PIC32_ALRMTIME		0x40
+#define PIC32_ALRMDATE		0x50
+
+#define PIC32_ALRMHOUR		0x43
+#define PIC32_ALRMMIN		0x42
+#define PIC32_ALRMSEC		0x41
+#define PIC32_ALRMYEAR		0x53
+#define PIC32_ALRMMON		0x52
+#define PIC32_ALRMDAY		0x51
+
+struct pic32_rtc_dev {
+	struct rtc_device	*rtc;
+	void __iomem		*reg_base;
+	struct clk		*clk;
+	spinlock_t		flags_lock;
+	spinlock_t		alarm_lock;
+	int			alarm_irq;
+	bool			alarm_clk_enabled;
+};
+
+static void pic32_rtc_alarm_clk_enable(struct pic32_rtc_dev *pdata,
+				bool enable)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->alarm_lock, flags);
+	if (enable) {
+		if (!pdata->alarm_clk_enabled) {
+			clk_enable(pdata->clk);
+			pdata->alarm_clk_enabled = true;
+		}
+	} else {
+		if (pdata->alarm_clk_enabled) {
+			clk_disable(pdata->clk);
+			pdata->alarm_clk_enabled = false;
+		}
+	}
+	spin_unlock_irqrestore(&pdata->alarm_lock, flags);
+}
+
+static irqreturn_t pic32_rtc_alarmirq(int irq, void *id)
+{
+	struct pic32_rtc_dev *pdata = (struct pic32_rtc_dev *)id;
+
+	clk_enable(pdata->clk);
+	rtc_update_irq(pdata->rtc, 1, RTC_AF | RTC_IRQF);
+	clk_disable(pdata->clk);
+
+	pic32_rtc_alarm_clk_enable(pdata, false);
+
+	return IRQ_HANDLED;
+}
+
+static int pic32_rtc_setaie(struct device *dev, unsigned int enabled)
+{
+	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
+	void __iomem *base = pdata->reg_base;
+
+	clk_enable(pdata->clk);
+
+	writel(PIC32_RTCALRM_ALRMEN,
+		base + (enabled ? PIC32_SET(PIC32_RTCALRM) :
+			PIC32_CLR(PIC32_RTCALRM)));
+
+	clk_disable(pdata->clk);
+
+	pic32_rtc_alarm_clk_enable(pdata, enabled);
+
+	return 0;
+}
+
+static int pic32_rtc_setfreq(struct device *dev, int freq)
+{
+	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
+	void __iomem *base = pdata->reg_base;
+	unsigned long flags;
+
+	clk_enable(pdata->clk);
+	spin_lock_irqsave(&pdata->flags_lock, flags);
+
+	writel(PIC32_RTCALRM_AMASK, base + PIC32_CLR(PIC32_RTCALRM));
+	writel(freq << 8, base + PIC32_SET(PIC32_RTCALRM));
+	writel(PIC32_RTCALRM_CHIME, base + PIC32_SET(PIC32_RTCALRM));
+
+	spin_unlock_irqrestore(&pdata->flags_lock, flags);
+	clk_disable(pdata->clk);
+
+	return 0;
+}
+
+static int pic32_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
+{
+	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
+	void __iomem *base = pdata->reg_base;
+	unsigned int have_retried = 0;
+
+	clk_enable(pdata->clk);
+retry_get_time:
+	rtc_tm->tm_hour = readb(base + PIC32_RTCHOUR);
+	rtc_tm->tm_min = readb(base + PIC32_RTCMIN);
+	rtc_tm->tm_mon  = readb(base + PIC32_RTCMON);
+	rtc_tm->tm_mday = readb(base + PIC32_RTCDAY);
+	rtc_tm->tm_year = readb(base + PIC32_RTCYEAR);
+	rtc_tm->tm_sec  = readb(base + PIC32_RTCSEC);
+
+	/*
+	 * The only way to work out whether the system was mid-update
+	 * when we read it is to check the second counter, and if it
+	 * is zero, then we re-try the entire read.
+	 */
+
+	if (rtc_tm->tm_sec == 0 && !have_retried) {
+		have_retried = 1;
+		goto retry_get_time;
+	}
+
+	rtc_tm->tm_sec = bcd2bin(rtc_tm->tm_sec);
+	rtc_tm->tm_min = bcd2bin(rtc_tm->tm_min);
+	rtc_tm->tm_hour = bcd2bin(rtc_tm->tm_hour);
+	rtc_tm->tm_mday = bcd2bin(rtc_tm->tm_mday);
+	rtc_tm->tm_mon = bcd2bin(rtc_tm->tm_mon);
+	rtc_tm->tm_year = bcd2bin(rtc_tm->tm_year);
+
+	rtc_tm->tm_year += 100;
+
+	dev_dbg(dev, "read time %04d.%02d.%02d %02d:%02d:%02d\n",
+		1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
+		rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
+
+	rtc_tm->tm_mon -= 1;
+
+	clk_disable(pdata->clk);
+	return rtc_valid_tm(rtc_tm);
+}
+
+static int pic32_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
+	void __iomem *base = pdata->reg_base;
+	int year = tm->tm_year - 100;
+
+	dev_dbg(dev, "set time %04d.%02d.%02d %02d:%02d:%02d\n",
+		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	if (year < 0 || year >= 100) {
+		dev_err(dev, "rtc only supports 100 years\n");
+		return -EINVAL;
+	}
+
+	clk_enable(pdata->clk);
+	writeb(bin2bcd(tm->tm_sec),  base + PIC32_RTCSEC);
+	writeb(bin2bcd(tm->tm_min),  base + PIC32_RTCMIN);
+	writeb(bin2bcd(tm->tm_hour), base + PIC32_RTCHOUR);
+	writeb(bin2bcd(tm->tm_mday), base + PIC32_RTCDAY);
+	writeb(bin2bcd(tm->tm_mon + 1), base + PIC32_RTCMON);
+	writeb(bin2bcd(year), base + PIC32_RTCYEAR);
+	clk_disable(pdata->clk);
+
+	return 0;
+}
+
+static int pic32_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
+	struct rtc_time *alm_tm = &alrm->time;
+	void __iomem *base = pdata->reg_base;
+	unsigned int alm_en;
+
+	clk_enable(pdata->clk);
+	alm_tm->tm_sec  = readb(base + PIC32_ALRMSEC);
+	alm_tm->tm_min  = readb(base + PIC32_ALRMMIN);
+	alm_tm->tm_hour = readb(base + PIC32_ALRMHOUR);
+	alm_tm->tm_mon  = readb(base + PIC32_ALRMMON);
+	alm_tm->tm_mday = readb(base + PIC32_ALRMDAY);
+	alm_tm->tm_year = readb(base + PIC32_ALRMYEAR);
+
+	alm_en = readb(base + PIC32_RTCALRM);
+
+	alrm->enabled = (alm_en & PIC32_RTCALRM_ALRMEN) ? 1 : 0;
+
+	dev_dbg(dev, "getalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
+		alm_en,
+		1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
+		alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+
+	alm_tm->tm_sec = bcd2bin(alm_tm->tm_sec);
+	alm_tm->tm_min = bcd2bin(alm_tm->tm_min);
+	alm_tm->tm_hour = bcd2bin(alm_tm->tm_hour);
+	alm_tm->tm_mday = bcd2bin(alm_tm->tm_mday);
+	alm_tm->tm_mon = bcd2bin(alm_tm->tm_mon);
+	alm_tm->tm_mon -= 1;
+	alm_tm->tm_year = bcd2bin(alm_tm->tm_year);
+
+	clk_disable(pdata->clk);
+	return 0;
+}
+
+static int pic32_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
+	struct rtc_time *tm = &alrm->time;
+	void __iomem *base = pdata->reg_base;
+
+	clk_enable(pdata->clk);
+	dev_dbg(dev, "setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
+		alrm->enabled,
+		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	writel(0x00, base + PIC32_ALRMTIME);
+	writel(0x00, base + PIC32_ALRMDATE);
+
+	if (tm->tm_sec < 60 && tm->tm_sec >= 0)
+		writeb(bin2bcd(tm->tm_sec), base + PIC32_ALRMSEC);
+
+	if (tm->tm_min < 60 && tm->tm_min >= 0)
+		writeb(bin2bcd(tm->tm_min), base + PIC32_ALRMMIN);
+
+	if (tm->tm_hour < 24 && tm->tm_hour >= 0)
+		writeb(bin2bcd(tm->tm_hour), base + PIC32_ALRMHOUR);
+
+	pic32_rtc_setaie(dev, alrm->enabled);
+
+	clk_disable(pdata->clk);
+	return 0;
+}
+
+static int pic32_rtc_proc(struct device *dev, struct seq_file *seq)
+{
+	struct pic32_rtc_dev *pdata = dev_get_drvdata(dev);
+	void __iomem *base = pdata->reg_base;
+	unsigned int repeat;
+
+	clk_enable(pdata->clk);
+
+	repeat = readw(base + PIC32_RTCALRM);
+	repeat &= PIC32_RTCALRM_ARPT;
+	seq_printf(seq, "periodic_IRQ\t: %s\n", repeat  ? "yes" : "no");
+
+	clk_disable(pdata->clk);
+	return 0;
+}
+
+static const struct rtc_class_ops pic32_rtcops = {
+	.read_time	  = pic32_rtc_gettime,
+	.set_time	  = pic32_rtc_settime,
+	.read_alarm	  = pic32_rtc_getalarm,
+	.set_alarm	  = pic32_rtc_setalarm,
+	.proc		  = pic32_rtc_proc,
+	.alarm_irq_enable = pic32_rtc_setaie,
+};
+
+static void pic32_rtc_enable(struct pic32_rtc_dev *pdata, int en)
+{
+	void __iomem *base = pdata->reg_base;
+
+	if (base == NULL)
+		return;
+
+	clk_enable(pdata->clk);
+	if (!en) {
+		writel(PIC32_RTCCON_ON, base + PIC32_CLR(PIC32_RTCCON));
+	} else {
+
+		pic32_syskey_unlock();
+
+		writel(PIC32_RTCCON_RTCWREN, base + PIC32_SET(PIC32_RTCCON));
+		writel(3 << 9, base + PIC32_CLR(PIC32_RTCCON));
+
+		if (!(readl(base + PIC32_RTCCON) & PIC32_RTCCON_ON))
+			writel(PIC32_RTCCON_ON, base + PIC32_SET(PIC32_RTCCON));
+	}
+	clk_disable(pdata->clk);
+}
+
+static int pic32_rtc_remove(struct platform_device *pdev)
+{
+	struct pic32_rtc_dev *pdata = platform_get_drvdata(pdev);
+
+	pic32_rtc_setaie(&pdev->dev, 0);
+	clk_unprepare(pdata->clk);
+	pdata->clk = NULL;
+
+	return 0;
+}
+
+static int pic32_rtc_probe(struct platform_device *pdev)
+{
+	struct pic32_rtc_dev *pdata;
+	struct rtc_time rtc_tm;
+	struct resource *res;
+	int ret;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pdata);
+
+	pdata->alarm_irq = platform_get_irq(pdev, 0);
+	if (pdata->alarm_irq < 0) {
+		dev_err(&pdev->dev, "no irq for alarm\n");
+		return pdata->alarm_irq;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pdata->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pdata->reg_base))
+		return PTR_ERR(pdata->reg_base);
+
+	pdata->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pdata->clk)) {
+		dev_err(&pdev->dev, "failed to find rtc clock source\n");
+		ret = PTR_ERR(pdata->clk);
+		pdata->clk = NULL;
+		return ret;
+	}
+
+	spin_lock_init(&pdata->flags_lock);
+	spin_lock_init(&pdata->alarm_lock);
+
+	clk_prepare_enable(pdata->clk);
+
+	pic32_rtc_enable(pdata, 1);
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+						 &pic32_rtcops,
+						 THIS_MODULE);
+	if (IS_ERR(pdata->rtc)) {
+		ret = PTR_ERR(pdata->rtc);
+		goto err_nortc;
+	}
+
+	pic32_rtc_gettime(&pdev->dev, &rtc_tm);
+
+	if (rtc_valid_tm(&rtc_tm)) {
+		rtc_tm.tm_year	= 100;
+		rtc_tm.tm_mon	= 0;
+		rtc_tm.tm_mday	= 1;
+		rtc_tm.tm_hour	= 0;
+		rtc_tm.tm_min	= 0;
+		rtc_tm.tm_sec	= 0;
+
+		pic32_rtc_settime(NULL, &rtc_tm);
+
+		dev_warn(&pdev->dev,
+			"warning: invalid RTC value so initializing it\n");
+	}
+
+	pdata->rtc->max_user_freq = 128;
+
+	pic32_rtc_setfreq(&pdev->dev, 1);
+	ret = devm_request_irq(&pdev->dev, pdata->alarm_irq,
+			pic32_rtc_alarmirq, 0,
+			dev_name(&pdev->dev), pdata);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"IRQ %d error %d\n", pdata->alarm_irq, ret);
+		goto err_nortc;
+	}
+
+	clk_disable(pdata->clk);
+
+	return 0;
+
+err_nortc:
+	pic32_rtc_enable(pdata, 0);
+	clk_disable_unprepare(pdata->clk);
+
+	return ret;
+}
+
+static const struct of_device_id pic32_rtc_dt_ids[] = {
+	{ .compatible = "microchip,pic32mzda-rtc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pic32_rtc_dt_ids);
+
+static struct platform_driver pic32_rtc_driver = {
+	.probe		= pic32_rtc_probe,
+	.remove		= pic32_rtc_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(pic32_rtc_dt_ids),
+	},
+};
+module_platform_driver(pic32_rtc_driver);
+
+MODULE_DESCRIPTION("Microchip PIC32 RTC Driver");
+MODULE_AUTHOR("Joshua Henderson <joshua.henderson@microchip.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.9.5
