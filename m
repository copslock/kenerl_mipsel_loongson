Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 12:56:40 +0200 (CEST)
Received: from smtpbg340.qq.com ([14.17.44.35]:49435 "EHLO smtpbg340.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029965AbcERK4iaago1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 May 2016 12:56:38 +0200
X-QQ-mid: bizesmtp1t1463568952t321t013
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 18 May 2016 18:55:43 +0800 (CST)
X-QQ-SSF: 01100000002000F0FG80000A0000000
X-QQ-FEAT: p/Y2uUKTrsybZ2TEftX8nOsLCEbQ9iu3XpD/ASV2QN19lKZRlXnu6ai8twKpe
        V0jOOhms4H2uW+sLpvwehZK37+1oa3yYWRp5efSHphBtoCNiPZldJCR4zMsLbQtT9yIqmDE
        D+LjwrPIvh/ltODSXyOO1eg+fGxJvg3G/wgRNRJMpH8ezIv/sl5N1M9dlW99nzvwlo3kVrg
        iJ2DOq0Ef6pij1MPEonVeEp6HEPoyO0A+LvV6nchtO/9803bdFu/0DiLxRL0uDJtKCQgwJl
        VMsHDYr/deiO1GANFWA3aG6N1BSspNTdhLyQ==
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, Binbin Zhou <zhoubb@lemote.com>,
        Chunbo Cui <cuichboo@163.com>, Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 6/9] irqchip/ls1x-cpu: Move the CPU IRQ driver from arch/mips/loongson32/common/
Date:   Wed, 18 May 2016 18:53:40 +0800
Message-Id: <1463568820-25136-1-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.1
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

Signed-off-by: Chunbo Cui <cuichboo@163.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/irq_cpu.h   |   1 +
 arch/mips/loongson32/common/irq.c | 128 +-------------------
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-ls1x-cpu.c    | 242 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+), 127 deletions(-)
 create mode 100644 drivers/irqchip/irq-ls1x-cpu.c

diff --git a/arch/mips/include/asm/irq_cpu.h b/arch/mips/include/asm/irq_cpu.h
index 39a160b..a6ccd6f 100644
--- a/arch/mips/include/asm/irq_cpu.h
+++ b/arch/mips/include/asm/irq_cpu.h
@@ -16,6 +16,7 @@
 extern void mips_cpu_irq_init(void);
 extern void rm7k_cpu_irq_init(void);
 extern void rm9k_cpu_irq_init(void);
+extern void ls1x_cpu_irq_init(void);
 
 #ifdef CONFIG_IRQ_DOMAIN
 struct device_node;
diff --git a/arch/mips/loongson32/common/irq.c b/arch/mips/loongson32/common/irq.c
index f2520f2..8e67a8c 100644
--- a/arch/mips/loongson32/common/irq.c
+++ b/arch/mips/loongson32/common/irq.c
@@ -14,134 +14,8 @@
 #include <loongson1.h>
 #include <irq.h>
 
-#define LS1X_INTC_REG(n, x) \
-		((void __iomem *)KSEG1ADDR(LS1X_INT_REG_BASE + (n * 0x18) + (x)))
-
-#define LS1X_INTC_INTISR(n)		LS1X_INTC_REG(n, 0x0)
-#define LS1X_INTC_INTIEN(n)		LS1X_INTC_REG(n, 0x4)
-#define LS1X_INTC_INTSET(n)		LS1X_INTC_REG(n, 0x8)
-#define LS1X_INTC_INTCLR(n)		LS1X_INTC_REG(n, 0xc)
-#define LS1X_INTC_INTPOL(n)		LS1X_INTC_REG(n, 0x10)
-#define LS1X_INTC_INTEDGE(n)		LS1X_INTC_REG(n, 0x14)
-
-static void ls1x_irq_ack(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
-			| (1 << bit), LS1X_INTC_INTCLR(n));
-}
-
-static void ls1x_irq_mask(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
-			& ~(1 << bit), LS1X_INTC_INTIEN(n));
-}
-
-static void ls1x_irq_mask_ack(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
-			& ~(1 << bit), LS1X_INTC_INTIEN(n));
-	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
-			| (1 << bit), LS1X_INTC_INTCLR(n));
-}
-
-static void ls1x_irq_unmask(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
-			| (1 << bit), LS1X_INTC_INTIEN(n));
-}
-
-static struct irq_chip ls1x_irq_chip = {
-	.name		= "LS1X-INTC",
-	.irq_ack	= ls1x_irq_ack,
-	.irq_mask	= ls1x_irq_mask,
-	.irq_mask_ack	= ls1x_irq_mask_ack,
-	.irq_unmask	= ls1x_irq_unmask,
-};
-
-static void ls1x_irq_dispatch(int n)
-{
-	u32 int_status, irq;
-
-	/* Get pending sources, masked by current enables */
-	int_status = __raw_readl(LS1X_INTC_INTISR(n)) &
-			__raw_readl(LS1X_INTC_INTIEN(n));
-
-	if (int_status) {
-		irq = LS1X_IRQ(n, __ffs(int_status));
-		do_IRQ(irq);
-	}
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending;
-
-	pending = read_c0_cause() & read_c0_status() & ST0_IM;
-
-	if (pending & CAUSEF_IP7)
-		do_IRQ(TIMER_IRQ);
-	else if (pending & CAUSEF_IP2)
-		ls1x_irq_dispatch(0); /* INT0 */
-	else if (pending & CAUSEF_IP3)
-		ls1x_irq_dispatch(1); /* INT1 */
-	else if (pending & CAUSEF_IP4)
-		ls1x_irq_dispatch(2); /* INT2 */
-	else if (pending & CAUSEF_IP5)
-		ls1x_irq_dispatch(3); /* INT3 */
-	else if (pending & CAUSEF_IP6)
-		ls1x_irq_dispatch(4); /* INT4 */
-	else
-		spurious_interrupt();
-
-}
-
-struct irqaction cascade_irqaction = {
-	.handler = no_action,
-	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
-};
-
-static void __init ls1x_irq_init(int base)
-{
-	int n;
-
-	/* Disable interrupts and clear pending,
-	 * setup all IRQs as high level triggered
-	 */
-	for (n = 0; n < 4; n++) {
-		__raw_writel(0x0, LS1X_INTC_INTIEN(n));
-		__raw_writel(0xffffffff, LS1X_INTC_INTCLR(n));
-		__raw_writel(0xffffffff, LS1X_INTC_INTPOL(n));
-		/* set DMA0, DMA1 and DMA2 to edge trigger */
-		__raw_writel(n ? 0x0 : 0xe000, LS1X_INTC_INTEDGE(n));
-	}
-
-
-	for (n = base; n < LS1X_IRQS; n++) {
-		irq_set_chip_and_handler(n, &ls1x_irq_chip,
-					 handle_level_irq);
-	}
-
-	setup_irq(INT0_IRQ, &cascade_irqaction);
-	setup_irq(INT1_IRQ, &cascade_irqaction);
-	setup_irq(INT2_IRQ, &cascade_irqaction);
-	setup_irq(INT3_IRQ, &cascade_irqaction);
-}
-
 void __init arch_init_irq(void)
 {
 	mips_cpu_irq_init();
-	ls1x_irq_init(LS1X_IRQ_BASE);
+	ls1x_cpu_irq_init();
 }
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b03cfcb..ae53eb9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
+obj-$(CONFIG_MACH_LOONGSON32)		+= irq-ls1x-cpu.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
 obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
diff --git a/drivers/irqchip/irq-ls1x-cpu.c b/drivers/irqchip/irq-ls1x-cpu.c
new file mode 100644
index 0000000..0df984b
--- /dev/null
+++ b/drivers/irqchip/irq-ls1x-cpu.c
@@ -0,0 +1,242 @@
+/*
+ * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2016 Binbin Zhou <zhoubb@lemote.com>
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <asm/irq_cpu.h>
+
+#include <loongson1.h>
+#include <irq.h>
+
+#define LS1X_INTC_REG(n, x) \
+		((void __iomem *)KSEG1ADDR(LS1X_INT_REG_BASE + (n * 0x18) + (x)))
+
+#define LS1X_INTC_INTISR(n)		LS1X_INTC_REG(n, 0x0)
+#define LS1X_INTC_INTIEN(n)		LS1X_INTC_REG(n, 0x4)
+#define LS1X_INTC_INTSET(n)		LS1X_INTC_REG(n, 0x8)
+#define LS1X_INTC_INTCLR(n)		LS1X_INTC_REG(n, 0xc)
+#define LS1X_INTC_INTPOL(n)		LS1X_INTC_REG(n, 0x10)
+#define LS1X_INTC_INTEDGE(n)		LS1X_INTC_REG(n, 0x14)
+
+static void ls1x_irq_ack(struct irq_data *d)
+{
+	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
+
+	ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n))
+			| (1 << bit), LS1X_INTC_INTCLR(n));
+}
+
+static void ls1x_irq_mask(struct irq_data *d)
+{
+	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
+
+	ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
+			& ~(1 << bit), LS1X_INTC_INTIEN(n));
+}
+
+static void ls1x_irq_mask_ack(struct irq_data *d)
+{
+	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
+
+	ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
+			& ~(1 << bit), LS1X_INTC_INTIEN(n));
+	ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n))
+			| (1 << bit), LS1X_INTC_INTCLR(n));
+}
+
+static void ls1x_irq_unmask(struct irq_data *d)
+{
+	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
+
+	ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
+			| (1 << bit), LS1X_INTC_INTIEN(n));
+}
+
+static void ls1x_irq_edge_type(struct irq_data *data, unsigned int flow_type)
+{
+	unsigned int bit = (data->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (data->irq - LS1X_IRQ_BASE) >> 5;
+
+	if (flow_type & IRQ_TYPE_EDGE_RISING)
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n)) | (1 << bit),
+				LS1X_INTC_INTPOL(n));
+	else
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n)) & ~(1 << bit),
+				LS1X_INTC_INTPOL(n));
+
+	ls1x_writel(ls1x_readl(LS1X_INTC_INTEDGE(n)) | (1 << bit),
+			LS1X_INTC_INTEDGE(n));
+	ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n)) | (1 << bit),
+			LS1X_INTC_INTIEN(n));
+
+	irq_set_handler_locked(data, handle_edge_irq);
+}
+
+static void ls1x_irq_level_type(struct irq_data *data, unsigned int flow_type)
+{
+	unsigned int bit = (data->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (data->irq - LS1X_IRQ_BASE) >> 5;
+
+	if (flow_type & IRQ_TYPE_LEVEL_HIGH)
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n)) | (1 << bit),
+				LS1X_INTC_INTPOL(n));
+	else if (flow_type & IRQ_TYPE_LEVEL_LOW)
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n)) & ~(1 << bit),
+				LS1X_INTC_INTPOL(n));
+
+	ls1x_writel(ls1x_readl(LS1X_INTC_INTEDGE(n)) & ~(1 << bit),
+			LS1X_INTC_INTEDGE(n));
+	ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n)) | (1 << bit),
+			LS1X_INTC_INTIEN(n));
+
+	irq_set_handler_locked(data, handle_level_irq);
+}
+
+static int ls1x_irq_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	unsigned int bit = (data->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (data->irq - LS1X_IRQ_BASE) >> 5;
+
+	if ((flow_type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
+		pr_info("ls1x irq don't support both rising and falling\n");
+		return -1;
+	}
+
+	ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n)) | (1 << bit),
+			LS1X_INTC_INTCLR(n));
+
+	if (flow_type & IRQ_TYPE_EDGE_BOTH)
+		ls1x_irq_edge_type(data, flow_type);
+	else if (flow_type && IRQ_TYPE_LEVEL_MASK)
+		ls1x_irq_level_type(data, flow_type);
+
+	return IRQ_SET_MASK_OK;
+}
+
+static struct irq_chip ls1x_cpu_irq_chip = {
+	.name		= "LS1X-INTC",
+	.irq_ack	= ls1x_irq_ack,
+	.irq_mask	= ls1x_irq_mask,
+	.irq_mask_ack	= ls1x_irq_mask_ack,
+	.irq_unmask	= ls1x_irq_unmask,
+	.irq_set_type	= ls1x_irq_set_type,
+};
+
+static void ls1x_irq_dispatch(int n)
+{
+	u32 int_status, irq;
+
+	/* Get pending sources, masked by current enables */
+	int_status = ls1x_readl(LS1X_INTC_INTISR(n)) &
+			ls1x_readl(LS1X_INTC_INTIEN(n));
+
+	if (int_status) {
+		irq = LS1X_IRQ(n, __ffs(int_status));
+		do_IRQ(irq);
+	}
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending;
+
+	pending = read_c0_cause() & read_c0_status() & ST0_IM;
+
+	if (pending & CAUSEF_IP7)
+		do_IRQ(TIMER_IRQ);
+	else if (pending & CAUSEF_IP2)
+		ls1x_irq_dispatch(0); /* INT0 */
+	else if (pending & CAUSEF_IP3)
+		ls1x_irq_dispatch(1); /* INT1 */
+	else if (pending & CAUSEF_IP4)
+		ls1x_irq_dispatch(2); /* INT2 */
+	else if (pending & CAUSEF_IP5)
+		ls1x_irq_dispatch(3); /* INT3 */
+	else if (pending & CAUSEF_IP6)
+		ls1x_irq_dispatch(4); /* INT4 */
+	else
+		spurious_interrupt();
+
+}
+
+struct irqaction cascade_irqaction = {
+	.handler = no_action,
+	.name = "cascade",
+	.flags = IRQF_NO_THREAD,
+};
+
+static int ls1x_cpu_intc_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hw)
+{
+	int n;
+
+	/*
+	 * Disable interrupts and clear pending,
+	 * setup all IRQs as high level triggered
+	 */
+	for (n = 0; n < 4; n++) {
+		ls1x_writel(0x0, LS1X_INTC_INTIEN(n));
+		ls1x_writel(0xffffffff, LS1X_INTC_INTCLR(n));
+		ls1x_writel(0xffffffff, LS1X_INTC_INTPOL(n));
+		/* set DMA0, DMA1 and DMA2 to edge trigger */
+		ls1x_writel(n ? 0x0 : 0xe000, LS1X_INTC_INTEDGE(n));
+	}
+
+
+	for (n = LS1X_IRQ_BASE; n < LS1X_IRQS; n++) {
+		irq_set_chip_and_handler(n, &ls1x_cpu_irq_chip,
+					 handle_level_irq);
+	}
+
+	setup_irq(INT0_IRQ, &cascade_irqaction);
+	setup_irq(INT1_IRQ, &cascade_irqaction);
+	setup_irq(INT2_IRQ, &cascade_irqaction);
+	setup_irq(INT3_IRQ, &cascade_irqaction);
+	setup_irq(INT4_IRQ, &cascade_irqaction);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ls1x_cpu_intc_domain_ops = {
+	.map = ls1x_cpu_intc_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static void __init __ls1x_irq_init(struct device_node *of_node)
+{
+	struct irq_domain *domain;
+
+	domain = irq_domain_add_legacy(of_node, LS1X_IRQS, LS1X_IRQ_BASE, 0,
+				       &ls1x_cpu_intc_domain_ops, NULL);
+	if (!domain)
+		panic("Failed to add irqdomain for MIPS CPU");
+}
+
+void __init ls1x_cpu_irq_init(void)
+{
+	__ls1x_irq_init(NULL);
+}
+
+static int __init ls1x_cpu_irq_of_init(
+	struct device_node *node, struct device_node *parent)
+
+{
+	__ls1x_irq_init(node);
+	return 0;
+}
+
+IRQCHIP_DECLARE(ls1x_cpu_intc, "loongson-1A cpu-irq-intc",
+		ls1x_cpu_irq_of_init);
-- 
1.9.1
