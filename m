Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 00:36:51 +0200 (CEST)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:35050
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993968AbdFZWeLFa3ut (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 00:34:11 +0200
Received: by mail-qt0-x241.google.com with SMTP id w12so1879646qta.2;
        Mon, 26 Jun 2017 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d4iiRrPd6NvKW2rlvSF0dobqh+FonxRWlMygCSfjyys=;
        b=GesRuIc6dMrq/CCAWU1ClUgtDypNVK62WqDaD46+T2Hq0saPS1VG5w2DjjsO+FWmF0
         y24F2OdJ6LbFTqB4S4Ipvt9NeHQiE/6vINawcrz/d1ldY+jokOVxI08kznU8IwgQgPIV
         63G/Ki6znIyPD+SHpQGDRY7S7TMkeKspLJmLpV9edQciSA9ESDolZYZjdjNCdaK/0gIa
         KFuTvjslvZ8gFO3RtGuq2C0GKDFEGwtY00vhQ2NUTOhuBqhPaU1Pz/SP6Ow1EPnQzG/k
         e0xJeTOL8KDYrEQCkJ72OQOt27E2wl6yIFZt592IJyBNCblWbAlTx8WemZTH+ebI7dzD
         vdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d4iiRrPd6NvKW2rlvSF0dobqh+FonxRWlMygCSfjyys=;
        b=V16HRLkXwWfuGiRHCXu8PY2Nlb1SNJfTXhFd2CEU1kb6RLuMGI7LcNNT8SnisY66WW
         Ms3T2Go8HNk4+opa2RM4gMvnVpbFxogDSQE6sEroNzz1AoddGhpnogol6NsLByfz7gd3
         BLjOlgCnLfT/PGAWsoj6OoqE9/TOdClWs/wPYAQWg1gbYmnj9VPaZGOSq5Xw7Aqfz25X
         rniR2HFWnRo2Fq7XmZoyRgxwyUpZrrnFPIVoejIaavNvkW/PsvUgk+XCwA/EDRUCs0aP
         l3cOmC63LVRimIFf14RqdlHKLMKstH2dUkhortyeseDRXwADlQI2zBOYciJDN2KWrDBV
         NNmA==
X-Gm-Message-State: AKS2vOxF0M1tr+tlkiwS+Q0fbGO6DbxwHGgECTPnN00f1jEQs40G7XNN
        Aaa13kxl/L/hhQ==
X-Received: by 10.237.62.201 with SMTP id o9mr3150861qtf.4.1498516445354;
        Mon, 26 Jun 2017 15:34:05 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id j65sm965542qkf.38.2017.06.26.15.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 15:34:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-mips@linux-mips.org (open list:BROADCOM BCM47XX MIPS ARCHITECTURE),
        linux-pm@vger.kernerl.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/4] rtc: brcmstb-waketimer: Add Broadcom STB wake-timer
Date:   Mon, 26 Jun 2017 15:32:47 -0700
Message-Id: <20170626223248.14199-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170626223248.14199-1-f.fainelli@gmail.com>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Brian Norris <computersforpeace@gmail.com>

This adds support for the Broadcom STB wake-timer which is a timer in
the chip's 27Mhz clock domain that offers the ability to wake the system
(wake-up source) from suspend states (S2, S3, S5). It is supported using
the rtc framework allowing us to configure alarms for system wake-up.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/rtc/Kconfig                 |  11 ++
 drivers/rtc/Makefile                |   1 +
 drivers/rtc/rtc-brcmstb-waketimer.c | 325 ++++++++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 drivers/rtc/rtc-brcmstb-waketimer.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8d3b95728326..8e1aa67fe533 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -197,6 +197,17 @@ config RTC_DRV_AC100
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ac100.
 
+config RTC_DRV_BRCMSTB
+	tristate "Broadcom STB wake-timer"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	default ARCH_BRCMSTB || BMIPS_GENERIC
+	help
+	  If you say yes here you get support for the wake-timer found on
+	  Broadcom STB SoCs (BCM7xxx).
+
+	  This driver can also be built as a module. If so, the module will
+	  be called rtc-brcmstb-waketimer.
+
 config RTC_DRV_AS3722
 	tristate "ams AS3722 RTC driver"
 	depends on MFD_AS3722
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 13857d2fce09..df89cac1f9ae 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
 obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
 obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
+obj-$(CONFIG_RTC_DRV_BRCMSTB)	+= rtc-brcmstb-waketimer.o
 obj-$(CONFIG_RTC_DRV_BQ32K)	+= rtc-bq32k.o
 obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
new file mode 100644
index 000000000000..5dea6d0627d8
--- /dev/null
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -0,0 +1,325 @@
+/*
+ * Copyright © 2014-2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irqreturn.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_wakeup.h>
+#include <linux/reboot.h>
+#include <linux/rtc.h>
+#include <linux/stat.h>
+#include <linux/suspend.h>
+
+struct brcmstb_waketmr {
+	struct rtc_device *rtc;
+	struct device *dev;
+	void __iomem *base;
+	int irq;
+	struct notifier_block reboot_notifier;
+	struct clk *clk;
+	u32 rate;
+};
+
+#define BRCMSTB_WKTMR_EVENT		0x00
+#define BRCMSTB_WKTMR_COUNTER		0x04
+#define BRCMSTB_WKTMR_ALARM		0x08
+#define BRCMSTB_WKTMR_PRESCALER		0x0C
+#define BRCMSTB_WKTMR_PRESCALER_VAL	0x10
+
+#define BRCMSTB_WKTMR_DEFAULT_FREQ	27000000
+
+static inline void brcmstb_waketmr_clear_alarm(struct brcmstb_waketmr *timer)
+{
+	writel_relaxed(1, timer->base + BRCMSTB_WKTMR_EVENT);
+	(void)readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
+}
+
+static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
+				      unsigned int secs)
+{
+	brcmstb_waketmr_clear_alarm(timer);
+
+	writel_relaxed(secs + 1, timer->base + BRCMSTB_WKTMR_ALARM);
+}
+
+static irqreturn_t brcmstb_waketmr_irq(int irq, void *data)
+{
+	struct brcmstb_waketmr *timer = data;
+
+	pm_wakeup_event(timer->dev, 0);
+
+	return IRQ_HANDLED;
+}
+
+struct wktmr_time {
+	u32 sec;
+	u32 pre;
+};
+
+static void wktmr_read(struct brcmstb_waketmr *timer,
+		       struct wktmr_time *t)
+{
+	u32 tmp;
+
+	do {
+		t->sec = readl_relaxed(timer->base + BRCMSTB_WKTMR_COUNTER);
+		tmp = readl_relaxed(timer->base + BRCMSTB_WKTMR_PRESCALER_VAL);
+	} while (tmp >= timer->rate);
+
+	t->pre = timer->rate - tmp;
+}
+
+static int brcmstb_waketmr_prepare_suspend(struct brcmstb_waketmr *timer)
+{
+	struct device *dev = timer->dev;
+	int ret = 0;
+
+	if (device_may_wakeup(dev)) {
+		ret = enable_irq_wake(timer->irq);
+		if (ret) {
+			dev_err(dev, "failed to enable wake-up interrupt\n");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+/* If enabled as a wakeup-source, arm the timer when powering off */
+static int brcmstb_waketmr_reboot(struct notifier_block *nb,
+		unsigned long action, void *data)
+{
+	struct brcmstb_waketmr *timer;
+
+	timer = container_of(nb, struct brcmstb_waketmr, reboot_notifier);
+
+	/* Set timer for cold boot */
+	if (action == SYS_POWER_OFF)
+		brcmstb_waketmr_prepare_suspend(timer);
+
+	return NOTIFY_DONE;
+}
+
+static int brcmstb_waketmr_gettime(struct device *dev,
+				   struct rtc_time *tm)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+	struct wktmr_time now;
+
+	wktmr_read(timer, &now);
+
+	rtc_time_to_tm(now.sec, tm);
+
+	return 0;
+}
+
+static int brcmstb_waketmr_settime(struct device *dev,
+				   struct rtc_time *tm)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+	unsigned long sec;
+	int ret;
+
+	rtc_tm_to_time(tm, &sec);
+
+	writel_relaxed(sec, timer->base + BRCMSTB_WKTMR_COUNTER);
+
+	return 0;
+}
+
+static int brcmstb_waketmr_getalarm(struct device *dev,
+				    struct rtc_wkalrm *alarm)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+	unsigned long sec;
+	u32 reg;
+
+	sec = readl_relaxed(timer->base + BRCMSTB_WKTMR_ALARM);
+	if (sec != 0) {
+		/* Alarm is enabled */
+		alarm->enabled = 1;
+		rtc_time_to_tm(sec, &alarm->time);
+	}
+
+	reg = readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
+	alarm->pending = !!(reg & 1);
+
+	return 0;
+}
+
+static int brcmstb_waketmr_setalarm(struct device *dev,
+				     struct rtc_wkalrm *alarm)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+	unsigned long sec;
+
+	if (alarm->enabled)
+		rtc_tm_to_time(&alarm->time, &sec);
+	else
+		sec = 0;
+
+	brcmstb_waketmr_set_alarm(timer, sec);
+
+	return 0;
+}
+
+/*
+ * Does not do much but keep the RTC class happy. We always support
+ * alarms.
+ */
+static int brcmstb_waketmr_alarm_enable(struct device *dev,
+					unsigned int enabled)
+{
+	return 0;
+}
+
+static const struct rtc_class_ops brcmstb_waketmr_ops = {
+	.read_time	= brcmstb_waketmr_gettime,
+	.set_time	= brcmstb_waketmr_settime,
+	.read_alarm	= brcmstb_waketmr_getalarm,
+	.set_alarm	= brcmstb_waketmr_setalarm,
+	.alarm_irq_enable = brcmstb_waketmr_alarm_enable,
+};
+
+static int brcmstb_waketmr_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct brcmstb_waketmr *timer;
+	struct resource *res;
+	int ret;
+
+	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
+	if (!timer)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, timer);
+	timer->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	timer->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(timer->base))
+		return PTR_ERR(timer->base);
+
+	/*
+	 * Set wakeup capability before requesting wakeup interrupt, so we can
+	 * process boot-time "wakeups" (e.g., from S5 soft-off)
+	 */
+	device_set_wakeup_capable(dev, true);
+	device_wakeup_enable(dev);
+
+	timer->irq = platform_get_irq(pdev, 0);
+	if (timer->irq < 0)
+		return -ENODEV;
+
+	timer->clk = devm_clk_get(dev, NULL);
+	if (!IS_ERR(timer->clk)) {
+		ret = clk_prepare_enable(timer->clk);
+		if (ret)
+			return ret;
+		timer->rate = clk_get_rate(timer->clk);
+		if (!timer->rate)
+			timer->rate = BRCMSTB_WKTMR_DEFAULT_FREQ;
+	} else {
+		timer->rate = BRCMSTB_WKTMR_DEFAULT_FREQ;
+		timer->clk = NULL;
+	}
+
+	ret = devm_request_irq(dev, timer->irq, brcmstb_waketmr_irq, 0,
+			       "brcmstb-waketimer", timer);
+	if (ret < 0)
+		return ret;
+
+	timer->reboot_notifier.notifier_call = brcmstb_waketmr_reboot;
+	register_reboot_notifier(&timer->reboot_notifier);
+
+	timer->rtc = rtc_device_register("brcmstb-waketmr", dev,
+					 &brcmstb_waketmr_ops, THIS_MODULE);
+	if (IS_ERR(timer->rtc)) {
+		dev_err(dev, "unable to register device\n");
+		unregister_reboot_notifier(&timer->reboot_notifier);
+		return PTR_ERR(timer->rtc);
+	}
+
+	dev_info(dev, "registered, with irq %d\n", timer->irq);
+
+	return ret;
+}
+
+static int brcmstb_waketmr_remove(struct platform_device *pdev)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(&pdev->dev);
+
+	unregister_reboot_notifier(&timer->reboot_notifier);
+	rtc_device_unregister(timer->rtc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int brcmstb_waketmr_suspend(struct device *dev)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+
+	return brcmstb_waketmr_prepare_suspend(timer);
+}
+
+static int brcmstb_waketmr_resume(struct device *dev)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+	int ret;
+
+	if (!device_may_wakeup(dev))
+		return 0;
+
+	ret = disable_irq_wake(timer->irq);
+
+	brcmstb_waketmr_clear_alarm(timer);
+
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(brcmstb_waketmr_pm_ops,
+			 brcmstb_waketmr_suspend, brcmstb_waketmr_resume);
+
+static const struct of_device_id brcmstb_waketmr_of_match[] = {
+	{ .compatible = "brcm,brcmstb-waketimer" },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver brcmstb_waketmr_driver = {
+	.probe			= brcmstb_waketmr_probe,
+	.remove			= brcmstb_waketmr_remove,
+	.driver = {
+		.name		= "brcmstb-waketimer",
+		.pm		= &brcmstb_waketmr_pm_ops,
+		.of_match_table	= of_match_ptr(brcmstb_waketmr_of_match),
+	}
+};
+module_platform_driver(brcmstb_waketmr_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Brian Norris");
+MODULE_AUTHOR("Markus Mayer");
+MODULE_DESCRIPTION("Wake-up timer driver for STB chips");
-- 
2.9.3
