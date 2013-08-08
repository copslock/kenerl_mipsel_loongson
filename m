Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 13:15:20 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54738 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865305Ab3HHLPPJFfSu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 13:15:15 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/2] MIPS: ralink: add support for systick timer found on newer ralink SoC
Date:   Thu,  8 Aug 2013 13:08:06 +0200
Message-Id: <1375960087-31084-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Newer Ralink SoC (MT7620x and RT5350) have a 50KHz clock that runs independent
of the SoC master clock. If we want to automatic frequency scaling to work we
need to use the systick timer as the clock source.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Kconfig       |    7 ++
 arch/mips/ralink/Makefile      |    2 +
 arch/mips/ralink/cevt-rt3352.c |  145 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 arch/mips/ralink/cevt-rt3352.c

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 026e823..c528d0c 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -1,5 +1,12 @@
 if RALINK
 
+config CLKEVT_RT3352
+	bool
+	depends on SOC_RT305X || SOC_MT7620
+	default y
+	select CLKSRC_OF
+	select CLKSRC_MMIO
+
 choice
 	prompt "Ralink SoC selection"
 	default SOC_RT305X
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index e37e0ec..98ae349 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -8,6 +8,8 @@
 
 obj-y := prom.o of.o reset.o clk.o irq.o timer.o
 
+obj-$(CONFIG_CLKEVT_RT3352) += cevt-rt3352.o
+
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
 obj-$(CONFIG_SOC_RT3883) += rt3883.o
diff --git a/arch/mips/ralink/cevt-rt3352.c b/arch/mips/ralink/cevt-rt3352.c
new file mode 100644
index 0000000..cc17566
--- /dev/null
+++ b/arch/mips/ralink/cevt-rt3352.c
@@ -0,0 +1,145 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 by John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/reset.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#define SYSTICK_FREQ		(50 * 1000)
+
+#define SYSTICK_CONFIG		0x00
+#define SYSTICK_COMPARE		0x04
+#define SYSTICK_COUNT		0x08
+
+/* route systick irq to mips irq 7 instead of the r4k-timer */
+#define CFG_EXT_STK_EN		0x2
+/* enable the counter */
+#define CFG_CNT_EN		0x1
+
+struct systick_device {
+	void __iomem *membase;
+	struct clock_event_device dev;
+	int irq_requested;
+	int freq_scale;
+};
+
+static void systick_set_clock_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt);
+
+static int systick_next_event(unsigned long delta,
+				struct clock_event_device *evt)
+{
+	struct systick_device *sdev;
+	u32 count;
+
+	sdev = container_of(evt, struct systick_device, dev);
+	count = ioread32(sdev->membase + SYSTICK_COUNT);
+	count = (count + delta) % SYSTICK_FREQ;
+	iowrite32(count + delta, sdev->membase + SYSTICK_COMPARE);
+
+	return 0;
+}
+
+static void systick_event_handler(struct clock_event_device *dev)
+{
+	/* noting to do here */
+}
+
+static irqreturn_t systick_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *dev = (struct clock_event_device *) dev_id;
+
+	dev->event_handler(dev);
+
+	return IRQ_HANDLED;
+}
+
+static struct systick_device systick = {
+	.dev = {
+		/*
+		 * cevt-r4k uses 300, make sure systick
+		 * gets used if available
+		 */
+		.rating		= 310,
+		.features	= CLOCK_EVT_FEAT_ONESHOT,
+		.set_next_event	= systick_next_event,
+		.set_mode	= systick_set_clock_mode,
+		.event_handler	= systick_event_handler,
+	},
+};
+
+static struct irqaction systick_irqaction = {
+	.handler = systick_interrupt,
+	.flags = IRQF_PERCPU | IRQF_TIMER,
+	.dev_id = &systick.dev,
+};
+
+static void systick_set_clock_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	struct systick_device *sdev;
+
+	sdev = container_of(evt, struct systick_device, dev);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_ONESHOT:
+		if (!sdev->irq_requested)
+			setup_irq(systick.dev.irq, &systick_irqaction);
+		sdev->irq_requested = 1;
+		iowrite32(CFG_EXT_STK_EN | CFG_CNT_EN,
+				systick.membase + SYSTICK_CONFIG);
+		break;
+
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		if (sdev->irq_requested)
+			free_irq(systick.dev.irq, &systick_irqaction);
+		sdev->irq_requested = 0;
+		iowrite32(0, systick.membase + SYSTICK_CONFIG);
+		break;
+
+	default:
+		pr_err("%s: Unhandeled mips clock_mode\n", systick.dev.name);
+		break;
+	}
+}
+
+static void __init ralink_systick_init(struct device_node *np)
+{
+	systick.membase = of_iomap(np, 0);
+	if (!systick.membase)
+		return;
+
+	systick_irqaction.name = np->name;
+	systick.dev.name = np->name;
+	clockevents_calc_mult_shift(&systick.dev, SYSTICK_FREQ, 60);
+	systick.dev.max_delta_ns = clockevent_delta2ns(0x7fff, &systick.dev);
+	systick.dev.min_delta_ns = clockevent_delta2ns(0x3, &systick.dev);
+	systick.dev.irq = irq_of_parse_and_map(np, 0);
+	if (!systick.dev.irq) {
+		pr_err("%s: request_irq failed", np->name);
+		return;
+	}
+
+	clocksource_mmio_init(systick.membase + SYSTICK_COUNT, np->name,
+			SYSTICK_FREQ, 301, 16, clocksource_mmio_readl_up);
+
+	clockevents_register_device(&systick.dev);
+
+	pr_info("%s: runing - mult: %d, shift: %d\n",
+			np->name, systick.dev.mult, systick.dev.shift);
+}
+
+CLOCKSOURCE_OF_DECLARE(systick, "ralink,cevt-systick", ralink_systick_init);
-- 
1.7.10.4
