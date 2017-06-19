Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:50:02 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58786 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992036AbdFSPtwRbmVH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:49:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 881AA1A46B7;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 622FF1A46A9;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 02/10] MIPS: ranchu: Add Goldfish RTC driver
Date:   Mon, 19 Jun 2017 17:49:32 +0200
Message-Id: <1497887380-13718-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58610
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Add device driver for a virtual Goldfish RTC clock.

The driver can be build only if CONFIG_MIPS and CONFIG_GOLDFISH
are set. The device tree key used by OS for binding the driver is
defined as "google,goldfish-rtc".

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 MAINTAINERS                |   1 +
 drivers/rtc/Kconfig        |   6 ++
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-goldfish.c | 149 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)
 create mode 100644 drivers/rtc/rtc-goldfish.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 519cdef..26a1267 100644
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
index 8d3b957..510c5b7 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1753,5 +1753,11 @@ config RTC_DRV_HID_SENSOR_TIME
 	  If this driver is compiled as a module, it will be named
 	  rtc-hid-sensor-time.
 
+config RTC_DRV_GOLDFISH
+	tristate "Goldfish Real Time Clock"
+	depends on MIPS
+	depends on GOLDFISH
+	help
+	  Say yes here to build support for the Goldfish RTC.
 
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 13857d2..dfc38f5 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -168,3 +168,4 @@ obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_XGENE)	+= rtc-xgene.o
 obj-$(CONFIG_RTC_DRV_ZYNQMP)	+= rtc-zynqmp.o
+obj-$(CONFIG_RTC_DRV_GOLDFISH)	+= rtc-goldfish.o
diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
new file mode 100644
index 0000000..658b723
--- /dev/null
+++ b/drivers/rtc/rtc-goldfish.c
@@ -0,0 +1,149 @@
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
+enum {
+	TIMER_TIME_LOW          = 0x00,	/* get low bits of current time  */
+					/*   and update TIMER_TIME_HIGH  */
+	TIMER_TIME_HIGH         = 0x04,	/* get high bits of time at last */
+					/*   TIMER_TIME_LOW read         */
+	TIMER_ALARM_LOW         = 0x08, /* set low bits of alarm and     */
+					/*   activate it                 */
+	TIMER_ALARM_HIGH        = 0x0c, /* set high bits of next alarm   */
+	TIMER_CLEAR_INTERRUPT   = 0x10,
+	TIMER_CLEAR_ALARM       = 0x14
+};
+
+struct goldfish_rtc {
+	void __iomem *base;
+	uint32_t irq;
+	struct rtc_device *rtc;
+};
+
+static irqreturn_t
+goldfish_rtc_interrupt(int irq, void *dev_id)
+{
+	struct goldfish_rtc	*qrtc = dev_id;
+	unsigned long		events = 0;
+	void __iomem *base = qrtc->base;
+
+	writel(1, base + TIMER_CLEAR_INTERRUPT);
+	events = RTC_IRQF | RTC_AF;
+
+	rtc_update_irq(qrtc->rtc, 1, events);
+
+	return IRQ_HANDLED;
+}
+
+static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	uint64_t time;
+	uint64_t time_low;
+	uint64_t time_high;
+	uint64_t time_high_prev;
+	struct goldfish_rtc *qrtc =
+			platform_get_drvdata(to_platform_device(dev));
+	void __iomem *base = qrtc->base;
+
+	time_high = readl(base + TIMER_TIME_HIGH);
+	do {
+		time_high_prev = time_high;
+		time_low = readl(base + TIMER_TIME_LOW);
+		time_high = readl(base + TIMER_TIME_HIGH);
+	} while (time_high != time_high_prev);
+	time = ((int64_t)time_high << 32) | time_low;
+
+	do_div(time, NSEC_PER_SEC);
+
+	rtc_time_to_tm(time, tm);
+	return 0;
+}
+
+static const struct rtc_class_ops goldfish_rtc_ops = {
+	.read_time	= goldfish_rtc_read_time,
+};
+
+static int goldfish_rtc_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *r;
+	struct goldfish_rtc *qrtc;
+	unsigned long rtc_dev_len;
+	unsigned long rtc_dev_addr;
+
+	qrtc = devm_kzalloc(&pdev->dev, sizeof(*qrtc), GFP_KERNEL);
+	if (qrtc == NULL) {
+		ret = -ENOMEM;
+		goto error;
+	}
+	platform_set_drvdata(pdev, qrtc);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		ret = -ENODEV;
+		goto error;
+	}
+
+	rtc_dev_addr = r->start;
+	rtc_dev_len = resource_size(r);
+	qrtc->base = devm_ioremap(&pdev->dev, rtc_dev_addr, rtc_dev_len);
+	if (IS_ERR(qrtc->base)) {
+		ret = -ENODEV;
+		goto error;
+	}
+
+	qrtc->irq = platform_get_irq(pdev, 0);
+	if (qrtc->irq < 0) {
+		ret = -ENODEV;
+		goto error;
+	}
+
+	qrtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+					&goldfish_rtc_ops, THIS_MODULE);
+	if (IS_ERR(qrtc->rtc)) {
+		ret = PTR_ERR(qrtc->rtc);
+		goto error;
+	}
+
+	ret = devm_request_irq(&pdev->dev, qrtc->irq, goldfish_rtc_interrupt,
+		0, pdev->name, qrtc);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	return ret;
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
