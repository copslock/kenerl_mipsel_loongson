Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jan 2013 19:07:29 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41580 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833504Ab3A0SGrQf-UE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Jan 2013 19:06:47 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 02/10] MIPS: ralink: adds irq code
Date:   Sun, 27 Jan 2013 19:03:54 +0100
Message-Id: <1359309842-31925-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
References: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35570
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
Return-Path: <linux-mips-bounce@linux-mips.org>

All of the Ralink Wifi SoC currently supported by this series share the same
interrupt controller (INTC).

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/irq.c |  178 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 arch/mips/ralink/irq.c

diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
new file mode 100644
index 0000000..63df9b5
--- /dev/null
+++ b/arch/mips/ralink/irq.c
@@ -0,0 +1,178 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/io.h>
+#include <linux/bitops.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+
+#include "common.h"
+
+/* INTC register offsets */
+#define INTC_REG_STATUS0	0x00
+#define INTC_REG_STATUS1	0x04
+#define INTC_REG_TYPE		0x20
+#define INTC_REG_RAW_STATUS	0x30
+#define INTC_REG_ENABLE		0x34
+#define INTC_REG_DISABLE	0x38
+
+#define INTC_INT_GLOBAL		BIT(31)
+#define INTC_IRQ_COUNT		32
+
+#define RALINK_CPU_IRQ_INTC	(MIPS_CPU_IRQ_BASE + 2)
+#define RALINK_CPU_IRQ_FE	(MIPS_CPU_IRQ_BASE + 5)
+#define RALINK_CPU_IRQ_WIFI	(MIPS_CPU_IRQ_BASE + 6)
+#define RALINK_CPU_IRQ_COUNTER	(MIPS_CPU_IRQ_BASE + 7)
+
+/* we have a cascade of 8 irqs */
+#define RALINK_INTC_IRQ_BASE	8
+
+/* we have 32 SoC irqs */
+#define RALINK_INTC_IRQ_COUNT	32
+
+#define RALINK_INTC_IRQ_PERFC   (RALINK_INTC_IRQ_BASE + 9)
+
+static void __iomem *rt_intc_membase;
+
+static inline void rt_intc_w32(u32 val, unsigned reg)
+{
+	__raw_writel(val, rt_intc_membase + reg);
+}
+
+static inline u32 rt_intc_r32(unsigned reg)
+{
+	return __raw_readl(rt_intc_membase + reg);
+}
+
+static void ralink_intc_irq_unmask(struct irq_data *d)
+{
+	unsigned int irq = d->hwirq - RALINK_INTC_IRQ_BASE;
+
+	rt_intc_w32(1 << irq, INTC_REG_ENABLE);
+}
+
+static void ralink_intc_irq_mask(struct irq_data *d)
+{
+	unsigned int irq = d->hwirq - RALINK_INTC_IRQ_BASE;
+
+	rt_intc_w32(1 << irq, INTC_REG_DISABLE);
+}
+
+static struct irq_chip ralink_intc_irq_chip = {
+	.name		= "INTC",
+	.irq_unmask	= ralink_intc_irq_unmask,
+	.irq_mask	= ralink_intc_irq_mask,
+	.irq_mask_ack	= ralink_intc_irq_mask,
+};
+
+static struct irqaction ralink_intc_irqaction = {
+	.handler	= no_action,
+	.name		= "cascade [INTC]",
+};
+
+unsigned int __cpuinit get_c0_compare_int(void)
+{
+	return CP0_LEGACY_COMPARE_IRQ;
+}
+
+void ralink_intc_dispatch(void)
+{
+	u32 pending = rt_intc_r32(INTC_REG_STATUS0);
+
+	if (pending)
+		do_IRQ((int)(__ffs(pending) + RALINK_INTC_IRQ_BASE));
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned long pending;
+
+	pending = read_c0_status() & read_c0_cause() & ST0_IM;
+
+	if (pending & STATUSF_IP7)
+		do_IRQ(RALINK_CPU_IRQ_COUNTER);
+
+	else if (pending & STATUSF_IP5)
+		do_IRQ(RALINK_CPU_IRQ_FE);
+
+	else if (pending & STATUSF_IP6)
+		do_IRQ(RALINK_CPU_IRQ_WIFI);
+
+	else if (pending & STATUSF_IP2)
+		ralink_intc_dispatch();
+
+	else
+		spurious_interrupt();
+}
+
+static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(hw, &ralink_intc_irq_chip, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops irq_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = intc_map,
+};
+
+int __init intc_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct resource res;
+
+	mips_cpu_irq_init();
+
+	if (of_address_to_resource(node, 0, &res))
+		panic("Failed to get intc memory range");
+
+	if (request_mem_region(res.start, resource_size(&res),
+				res.name) < 0)
+		pr_err("Failed to request intc memory");
+
+	rt_intc_membase = ioremap_nocache(res.start,
+					resource_size(&res));
+	if (!rt_intc_membase)
+		panic("Failed to remap intc memory");
+
+	/* disable all interrupts */
+	rt_intc_w32(~0, INTC_REG_DISABLE);
+
+	/* route all INTC interrupts to MIPS HW0 interrupt */
+	rt_intc_w32(0, INTC_REG_TYPE);
+
+	setup_irq(RALINK_CPU_IRQ_INTC, &ralink_intc_irqaction);
+
+	irq_domain_add_linear(node,
+		RALINK_INTC_IRQ_BASE + RALINK_INTC_IRQ_COUNT,
+		&irq_domain_ops, 0);
+
+	rt_intc_w32(INTC_INT_GLOBAL, INTC_REG_ENABLE);
+
+	cp0_perfcount_irq = RALINK_INTC_IRQ_PERFC;
+
+	return 0;
+}
+
+static struct of_device_id __initdata of_irq_ids[] = {
+	{ .compatible = "ralink,rt305x-intc", .data = intc_of_init },
+	{},
+};
+
+void __init arch_init_irq(void)
+{
+	of_irq_init(of_irq_ids);
+}
+
-- 
1.7.10.4
