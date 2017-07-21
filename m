Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 18:56:35 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:37464 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993947AbdGUQ4XqQLZm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 18:56:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 47F841A4A6E;
        Fri, 21 Jul 2017 18:56:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 23AFF1A498D;
        Fri, 21 Jul 2017 18:56:18 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
Subject: [PATCH v3 2/8] MIPS: ranchu: Add Goldfish RTC driver
Date:   Fri, 21 Jul 2017 18:53:31 +0200
Message-Id: <1500656111-9520-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

Add device driver for a virtual Goldfish RTC clock.

The driver can be built only if CONFIG_MIPS and CONFIG_GOLDFISH are
set. The compatible string used by OS for binding the driver is
defined as "google,goldfish-rtc".

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 MAINTAINERS                |   1 +
 drivers/rtc/Kconfig        |   8 ++
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-goldfish.c | 233 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 drivers/rtc/rtc-goldfish.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 847da3f..768426d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ ANDROID GOLDFISH RTC DRIVER
 M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
+F:	drivers/rtc/rtc-goldfish.c
 
 ANDROID ION DRIVER
 M:	Laura Abbott <labbott@redhat.com>
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 72419ac..7cd27d3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1780,5 +1780,13 @@ config RTC_DRV_HID_SENSOR_TIME
 	  If this driver is compiled as a module, it will be named
 	  rtc-hid-sensor-time.
 
+config RTC_DRV_GOLDFISH
+	tristate "Goldfish Real Time Clock"
+	depends on MIPS && GOLDFISH || COMPILE_TEST
+	help
+	  Say yes to enable RTC driver for the Goldfish based virtual platform.
+
+	  Goldfish is a code name for the virtual platform developed by Google
+	  for Android emulation.
 
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index acd366b..d995d49 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -170,3 +170,4 @@ obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_XGENE)	+= rtc-xgene.o
 obj-$(CONFIG_RTC_DRV_ZYNQMP)	+= rtc-zynqmp.o
+obj-$(CONFIG_RTC_DRV_GOLDFISH)	+= rtc-goldfish.o
diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
new file mode 100644
index 0000000..aa13062
--- /dev/null
+++ b/drivers/rtc/rtc-goldfish.c
@@ -0,0 +1,233 @@
+/* drivers/rtc/rtc-goldfish.c
+ *
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (C) 2017 Imagination Technologies Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+#define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
+					/*   and update TIMER_TIME_HIGH  */
+#define TIMER_TIME_HIGH	0x04	/* get high bits of time at last */
+					/*   TIMER_TIME_LOW read         */
+#define TIMER_ALARM_LOW	0x08	/* set low bits of alarm and     */
+					/*   activate it                 */
+#define TIMER_ALARM_HIGH	0x0c	/* set high bits of next alarm   */
+#define TIMER_IRQ_ENABLED	0x10
+#define TIMER_CLEAR_ALARM	0x14
+#define TIMER_ALARM_STATUS	0x18
+#define TIMER_CLEAR_INTERRUPT	0x1c
+
+struct goldfish_rtc {
+	void __iomem *base;
+	u32 irq;
+	struct rtc_device *rtc;
+};
+
+static int goldfish_rtc_read_alarm(struct device *dev,
+		struct rtc_wkalrm *alrm)
+{
+	u64 rtc_alarm;
+	u64 rtc_alarm_low;
+	u64 rtc_alarm_high;
+	void __iomem *base;
+	struct goldfish_rtc *rtcdrv;
+
+	rtcdrv = dev_get_drvdata(dev);
+	base = rtcdrv->base;
+
+	rtc_alarm_low = readl(base + TIMER_ALARM_LOW);
+	rtc_alarm_high = readl(base + TIMER_ALARM_HIGH);
+	rtc_alarm = (rtc_alarm_high << 32) | rtc_alarm_low;
+
+	do_div(rtc_alarm, NSEC_PER_SEC);
+	memset(alrm, 0, sizeof(struct rtc_wkalrm));
+
+	rtc_time_to_tm(rtc_alarm, &(alrm->time));
+
+	if (readl(base + TIMER_ALARM_STATUS))
+		alrm->enabled = 1;
+	else
+		alrm->enabled = 0;
+
+	return 0;
+}
+
+static int goldfish_rtc_set_alarm(struct device *dev,
+		struct rtc_wkalrm *alrm)
+{
+	struct goldfish_rtc *rtcdrv;
+	unsigned long rtc_alarm;
+	u64 rtc_status_reg;
+	void __iomem *base;
+	int ret = 0;
+
+	rtcdrv = dev_get_drvdata(dev);
+	base = rtcdrv->base;
+
+	if (alrm->enabled) {
+		ret = rtc_tm_to_time(&(alrm->time), &rtc_alarm);
+		if (ret != 0)
+			return ret;
+
+		rtc_alarm *= NSEC_PER_SEC;
+		writel((rtc_alarm >> 32), base + TIMER_ALARM_HIGH);
+		writel(rtc_alarm, base + TIMER_ALARM_LOW);
+	} else {
+		/*
+		 * if this function was called with enabled=0
+		 * then it could mean that the application is
+		 * trying to cancel an ongoing alarm
+		 */
+		rtc_status_reg = readl(base + TIMER_ALARM_STATUS);
+		if (rtc_status_reg)
+			writel(1, base + TIMER_CLEAR_ALARM);
+	}
+
+	return ret;
+}
+
+static int goldfish_rtc_alarm_irq_enable(struct device *dev,
+		unsigned int enabled)
+{
+	void __iomem *base;
+	struct goldfish_rtc *rtcdrv;
+
+	rtcdrv = dev_get_drvdata(dev);
+	base = rtcdrv->base;
+
+	if (enabled)
+		writel(1, base + TIMER_IRQ_ENABLED);
+	else
+		writel(0, base + TIMER_IRQ_ENABLED);
+
+	return 0;
+
+}
+
+static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
+{
+	struct goldfish_rtc *rtcdrv = dev_id;
+	void __iomem *base = rtcdrv->base;
+
+	writel(1, base + TIMER_CLEAR_INTERRUPT);
+
+	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
+
+	return IRQ_HANDLED;
+}
+
+static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct goldfish_rtc *rtcdrv;
+	void __iomem *base;
+	u64 time_high;
+	u64 time_low;
+	u64 time;
+
+	rtcdrv = dev_get_drvdata(dev);
+	base = rtcdrv->base;
+
+	time_low = readl(base + TIMER_TIME_LOW);
+	time_high = readl(base + TIMER_TIME_HIGH);
+	time = (time_high << 32) | time_low;
+
+	do_div(time, NSEC_PER_SEC);
+
+	rtc_time_to_tm(time, tm);
+
+	return 0;
+}
+
+static int goldfish_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct goldfish_rtc *rtcdrv;
+	void __iomem *base;
+	unsigned long now;
+	int ret;
+
+	rtcdrv = dev_get_drvdata(dev);
+	base = rtcdrv->base;
+
+	ret = rtc_tm_to_time(tm, &now);
+	if (ret == 0) {
+		now *= NSEC_PER_SEC;
+		writel((now >> 32), base + TIMER_TIME_HIGH);
+		writel(now, base + TIMER_TIME_LOW);
+	}
+
+	return ret;
+}
+
+static const struct rtc_class_ops goldfish_rtc_ops = {
+	.read_time	= goldfish_rtc_read_time,
+	.set_time	= goldfish_rtc_set_time,
+	.read_alarm	= goldfish_rtc_read_alarm,
+	.set_alarm	= goldfish_rtc_set_alarm,
+	.alarm_irq_enable = goldfish_rtc_alarm_irq_enable
+};
+
+static int goldfish_rtc_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+	struct goldfish_rtc *rtcdrv;
+	int err;
+
+	rtcdrv = devm_kzalloc(&pdev->dev, sizeof(*rtcdrv), GFP_KERNEL);
+	if (rtcdrv == NULL)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, rtcdrv);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (r == NULL)
+		return -ENODEV;
+
+	rtcdrv->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(rtcdrv->base))
+		return -ENODEV;
+
+	rtcdrv->irq = platform_get_irq(pdev, 0);
+	if (rtcdrv->irq < 0)
+		return -ENODEV;
+
+	rtcdrv->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+					&goldfish_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtcdrv->rtc))
+		return PTR_ERR(rtcdrv->rtc);
+
+	err = devm_request_irq(&pdev->dev, rtcdrv->irq, goldfish_rtc_interrupt,
+		0, pdev->name, rtcdrv);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct of_device_id goldfish_rtc_of_match[] = {
+	{ .compatible = "google,goldfish-rtc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, goldfish_rtc_of_match);
+
+static struct platform_driver goldfish_rtc = {
+	.probe = goldfish_rtc_probe,
+	.driver = {
+		.name = "goldfish_rtc",
+		.of_match_table = goldfish_rtc_of_match,
+	}
+};
+
+module_platform_driver(goldfish_rtc);
-- 
2.7.4
