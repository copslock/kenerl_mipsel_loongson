Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 20:46:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14481 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007270AbbEZSqLUnwvC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 20:46:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 00F5B4E277E21;
        Tue, 26 May 2015 19:46:03 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 26 May
 2015 19:45:01 +0100
Received: from laptop.hh.imgtec.org (10.100.200.175) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 26 May
 2015 19:45:00 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v2 6/7] clocksource: Add Pistachio clocksource-only driver
Date:   Tue, 26 May 2015 15:41:39 -0300
Message-ID: <1432665699-16154-1-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1432665548-16024-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432665548-16024-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.175]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

The Pistachio SoC provides four general purpose timers, and allow
to implement a clocksource driver.

This driver can be used as a replacement for the MIPS GIC and MIPS R4K
clocksources and sched clocks, which are clocked from the CPU clock.

Given the general purpose timers are clocked from an independent clock,
this new clocksource driver will be useful to introduce CPUFreq support
for Pistachio machines.

Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/clocksource/Kconfig          |   4 +
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/time-pistachio.c | 194 +++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 drivers/clocksource/time-pistachio.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 51d7865f..faa16ae 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -106,6 +106,10 @@ config CLKSRC_EFM32
 	  Support to use the timers of EFM32 SoCs as clock source and clock
 	  event device.
 
+config CLKSRC_PISTACHIO
+	bool
+	select CLKSRC_OF
+
 config ARM_ARCH_TIMER
 	bool
 	select CLKSRC_OF if OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5b85f6a..9415def 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
 obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
 obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
 obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o
+obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
 
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
new file mode 100644
index 0000000..d461bd1
--- /dev/null
+++ b/drivers/clocksource/time-pistachio.c
@@ -0,0 +1,194 @@
+/*
+ * Pistachio clocksource based on general-purpose timers
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/sched_clock.h>
+#include <linux/time.h>
+
+/* Top level reg */
+#define CR_TIMER_CTRL_CFG		0x00
+#define  TIMER_ME_GLOBAL		BIT(0)
+#define CR_TIMER_REV			0x10
+
+/* Timer specific registers */
+#define TIMER_CFG			0x20
+#define  TIMER_ME_LOCAL			BIT(0)
+#define TIMER_RELOAD_VALUE		0x24
+#define TIMER_CURRENT_VALUE		0x28
+#define TIMER_CURRENT_OVERFLOW_VALUE	0x2C
+#define TIMER_IRQ_STATUS		0x30
+#define TIMER_IRQ_CLEAR			0x34
+#define TIMER_IRQ_MASK			0x38
+
+#define PERIP_TIMER_CONTROL		0x90
+
+/* Timer specific configuration Values */
+#define RELOAD_VALUE	0xffffffff
+
+static void __iomem *timer_base;
+static DEFINE_RAW_SPINLOCK(lock);
+
+static inline u32 gpt_readl(u32 offset, u32 gpt_id)
+{
+	return readl(timer_base + 0x20 * gpt_id + offset);
+}
+
+static inline void gpt_writel(u32 value, u32 offset, u32 gpt_id)
+{
+	writel(value, timer_base + 0x20 * gpt_id + offset);
+}
+
+static cycle_t pistachio_clocksource_read_cycles(struct clocksource *cs)
+{
+	u32 counter, overflw;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&lock, flags);
+	overflw = gpt_readl(TIMER_CURRENT_OVERFLOW_VALUE, 0);
+	counter = gpt_readl(TIMER_CURRENT_VALUE, 0);
+	raw_spin_unlock_irqrestore(&lock, flags);
+
+	return ~(cycle_t)counter;
+}
+
+static u64 notrace pistachio_read_sched_clock(void)
+{
+	return pistachio_clocksource_read_cycles(NULL);
+}
+
+static void pistachio_clksrc_enable(int timeridx)
+{
+	u32 val;
+
+	/* Disable GPT local before loading reload value */
+	val = gpt_readl(TIMER_CFG, timeridx);
+	val &= ~TIMER_ME_LOCAL;
+	gpt_writel(val, TIMER_CFG, timeridx);
+
+	gpt_writel(RELOAD_VALUE, TIMER_RELOAD_VALUE, timeridx);
+
+	val = gpt_readl(TIMER_CFG, timeridx);
+	val |= TIMER_ME_LOCAL;
+	gpt_writel(val, TIMER_CFG, timeridx);
+}
+
+static void pistachio_clksrc_disable(int timeridx)
+{
+	u32 val;
+
+	/* Disable GPT local */
+	val = gpt_readl(TIMER_CFG, timeridx);
+	val &= ~TIMER_ME_LOCAL;
+	gpt_writel(val, TIMER_CFG, timeridx);
+}
+
+static int pistachio_clocksource_enable(struct clocksource *cs)
+{
+	pistachio_clksrc_enable(0);
+	return 0;
+}
+
+static void pistachio_clocksource_disable(struct clocksource *cs)
+{
+	pistachio_clksrc_disable(0);
+}
+
+/* Desirable clock source for pistachio platform */
+static struct clocksource pistachio_clocksource_gpt = {
+	.name		= "gptimer",
+	.rating		= 300,
+	.enable		= pistachio_clocksource_enable,
+	.disable	= pistachio_clocksource_disable,
+	.read		= pistachio_clocksource_read_cycles,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
+			  CLOCK_SOURCE_SUSPEND_NONSTOP,
+};
+
+static void __init pistachio_clksrc_of_init(struct device_node *node)
+{
+	struct clk *sys_clk, *fast_clk;
+	struct regmap *periph_regs;
+	unsigned long rate;
+	int ret;
+
+	timer_base = of_iomap(node, 0);
+	if (!timer_base) {
+		pr_err("cannot iomap\n");
+		return;
+	}
+
+	periph_regs = syscon_regmap_lookup_by_phandle(node, "img,cr-periph");
+	if (IS_ERR(periph_regs)) {
+		pr_err("cannot get peripheral regmap (%lu)\n",
+		       PTR_ERR(periph_regs));
+		return;
+	}
+
+	/* Switch to using the fast counter clock */
+	ret = regmap_update_bits(periph_regs, PERIP_TIMER_CONTROL,
+				 0xf, 0x0);
+	if (ret)
+		return;
+
+	sys_clk = of_clk_get_by_name(node, "sys");
+	if (IS_ERR(sys_clk)) {
+		pr_err("clock get failed (%lu)\n", PTR_ERR(sys_clk));
+		return;
+	}
+
+	fast_clk = of_clk_get_by_name(node, "fast");
+	if (IS_ERR(fast_clk)) {
+		pr_err("clock get failed (%lu)\n", PTR_ERR(fast_clk));
+		return;
+	}
+
+	ret = clk_prepare_enable(sys_clk);
+	if (ret < 0) {
+		pr_err("failed to enable clock (%d)\n", ret);
+		return;
+	}
+
+	ret = clk_prepare_enable(fast_clk);
+	if (ret < 0) {
+		pr_err("failed to enable clock (%d)\n", ret);
+		clk_disable_unprepare(sys_clk);
+		return;
+	}
+
+	rate = clk_get_rate(fast_clk);
+
+	/* Disable irq's for clocksource usage */
+	gpt_writel(0, TIMER_IRQ_MASK, 0);
+	gpt_writel(0, TIMER_IRQ_MASK, 1);
+	gpt_writel(0, TIMER_IRQ_MASK, 2);
+	gpt_writel(0, TIMER_IRQ_MASK, 3);
+
+	/* Enable timer block */
+	writel(TIMER_ME_GLOBAL, timer_base);
+
+	sched_clock_register(pistachio_read_sched_clock, 32, rate);
+	clocksource_register_hz(&pistachio_clocksource_gpt, rate);
+}
+CLOCKSOURCE_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
+		       pistachio_clksrc_of_init);
-- 
2.3.3
