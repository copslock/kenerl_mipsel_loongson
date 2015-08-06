Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 13:22:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56993 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011293AbbHFLWjuMtof (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 13:22:39 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2382099102EA0;
        Thu,  6 Aug 2015 12:22:31 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 6 Aug
 2015 12:22:33 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 6 Aug 2015 12:22:32 +0100
From:   Govindraj Raja <govindraj.raja@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        "Govindraj Raja" <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>
Subject: [PATCH v5 6/7] clocksource: Add Pistachio clocksource-only driver
Date:   Thu, 6 Aug 2015 12:22:18 +0100
Message-ID: <1438860138-31718-1-git-send-email-govindraj.raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: govindraj.raja@imgtec.com
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

From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

The Pistachio SoC provides four general purpose timers, and allow
to implement a clocksource driver.

This driver can be used as a replacement for the MIPS GIC and MIPS R4K
clocksources and sched clocks, which are clocked from the CPU clock.

Given the general purpose timers are clocked from an independent clock,
this new clocksource driver will be useful to introduce CPUFreq support
for Pistachio machines.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
---

changes from v4
----------------
Fixes comments from Daniel as dicussed in below thread:
http://patchwork.linux-mips.org/patch/10784/


 drivers/clocksource/Kconfig          |   5 +
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/time-pistachio.c | 216 +++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 drivers/clocksource/time-pistachio.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4e57730..e642825 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -111,6 +111,11 @@ config CLKSRC_LPC32XX
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 
+config CLKSRC_PISTACHIO
+	bool
+	default y if MACH_PISTACHIO
+	select CLKSRC_OF
+
 config CLKSRC_STM32
 	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
 	depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index f228354..066337e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
 obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
 obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
 obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o
+obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
 
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
new file mode 100644
index 0000000..a2e3c5d
--- /dev/null
+++ b/drivers/clocksource/time-pistachio.c
@@ -0,0 +1,216 @@
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
+#define TIMER_ME_GLOBAL			BIT(0)
+#define CR_TIMER_REV			0x10
+
+/* Timer specific registers */
+#define TIMER_CFG			0x20
+#define TIMER_ME_LOCAL			BIT(0)
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
+#define RELOAD_VALUE			0xffffffff
+
+struct pistachio_clocksource {
+	void __iomem *base;
+	raw_spinlock_t lock;
+	struct clocksource cs;
+};
+
+struct pistachio_clocksource pcs_gpt;
+
+#define to_pistachio_clocksource(cs)	\
+	container_of(cs, struct pistachio_clocksource, cs)
+
+static inline u32 gpt_readl(void __iomem *base, u32 offset, u32 gpt_id)
+{
+	return readl(base + 0x20 * gpt_id + offset);
+}
+
+static inline void gpt_writel(void __iomem *base, u32 value, u32 offset,
+		u32 gpt_id)
+{
+	writel(value, base + 0x20 * gpt_id + offset);
+}
+
+static cycle_t pistachio_clocksource_read_cycles(struct clocksource *cs)
+{
+	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
+	u32 counter, overflw;
+	unsigned long flags;
+
+	/* The counter value is only refreshed after the overflow value is read.
+	 * And they must be read in strict order, hence raw spin lock added.
+	 */
+
+	raw_spin_lock_irqsave(&pcs->lock, flags);
+	overflw = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
+	counter = gpt_readl(pcs->base, TIMER_CURRENT_VALUE, 0);
+	raw_spin_unlock_irqrestore(&pcs->lock, flags);
+
+	return ~(cycle_t)counter;
+}
+
+static u64 notrace pistachio_read_sched_clock(void)
+{
+	return pistachio_clocksource_read_cycles(&pcs_gpt.cs);
+}
+
+static void pistachio_clksrc_set_mode(struct clocksource *cs, int timeridx,
+			int enable)
+{
+	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
+	u32 val;
+
+	val = gpt_readl(pcs->base, TIMER_CFG, timeridx);
+	if (enable)
+		val |= TIMER_ME_LOCAL;
+	else
+		val &= ~TIMER_ME_LOCAL;
+
+	gpt_writel(pcs->base, val, TIMER_CFG, timeridx);
+}
+
+static void pistachio_clksrc_enable(struct clocksource *cs, int timeridx)
+{
+	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
+
+	/* Disable GPT local before loading reload value */
+	pistachio_clksrc_set_mode(cs, timeridx, false);
+	gpt_writel(pcs->base, RELOAD_VALUE, TIMER_RELOAD_VALUE, timeridx);
+	pistachio_clksrc_set_mode(cs, timeridx, true);
+}
+
+static void pistachio_clksrc_disable(struct clocksource *cs, int timeridx)
+{
+	/* Disable GPT local */
+	pistachio_clksrc_set_mode(cs, timeridx, false);
+}
+
+static int pistachio_clocksource_enable(struct clocksource *cs)
+{
+	pistachio_clksrc_enable(cs, 0);
+	return 0;
+}
+
+static void pistachio_clocksource_disable(struct clocksource *cs)
+{
+	pistachio_clksrc_disable(cs, 0);
+}
+
+/* Desirable clock source for pistachio platform */
+struct pistachio_clocksource pcs_gpt = {
+	.cs =	{
+		.name		= "gptimer",
+		.rating		= 300,
+		.enable		= pistachio_clocksource_enable,
+		.disable	= pistachio_clocksource_disable,
+		.read		= pistachio_clocksource_read_cycles,
+		.mask		= CLOCKSOURCE_MASK(32),
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
+				  CLOCK_SOURCE_SUSPEND_NONSTOP,
+		},
+};
+
+static void __init pistachio_clksrc_of_init(struct device_node *node)
+{
+	struct clk *sys_clk, *fast_clk;
+	struct regmap *periph_regs;
+	unsigned long rate;
+	int ret;
+
+	pcs_gpt.base = of_iomap(node, 0);
+	if (!pcs_gpt.base) {
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
+	gpt_writel(&pcs_gpt.base, 0, TIMER_IRQ_MASK, 0);
+	gpt_writel(&pcs_gpt.base, 0, TIMER_IRQ_MASK, 1);
+	gpt_writel(&pcs_gpt.base, 0, TIMER_IRQ_MASK, 2);
+	gpt_writel(&pcs_gpt.base, 0, TIMER_IRQ_MASK, 3);
+
+	/* Enable timer block */
+	writel(TIMER_ME_GLOBAL, pcs_gpt.base);
+
+	raw_spin_lock_init(&pcs_gpt.lock);
+	sched_clock_register(pistachio_read_sched_clock, 32, rate);
+	clocksource_register_hz(&pcs_gpt.cs, rate);
+}
+CLOCKSOURCE_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
+		       pistachio_clksrc_of_init);
-- 
1.9.1
