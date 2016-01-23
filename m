Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 13:58:06 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:16966 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008721AbcAWM6Ew0ynI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2016 13:58:04 +0100
Received: from localhost.localdomain (unknown [78.54.16.94])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 369F0A6264;
        Sat, 23 Jan 2016 13:56:19 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH v2 1/2] MIPS: ath79: irq: Move the MISC driver to drivers/irqchip
Date:   Sat, 23 Jan 2016 13:57:46 +0100
Message-Id: <1453553867-27003-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

The driver stays the same but the initialization changes a bit.
For OF boards we now get the memory map from the OF node and use
a linear mapping instead of the legacy mapping. For legacy boards
we still use a legacy mapping and just pass down all the parameters
from the board init code.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
Changelog:
v2: * Added the missing calls to chained_irq_enter/leave()
---
 arch/mips/ath79/irq.c                    | 163 +++-----------------------
 arch/mips/include/asm/mach-ath79/ath79.h |   3 +
 drivers/irqchip/Makefile                 |   1 +
 drivers/irqchip/irq-ath79-misc.c         | 189 +++++++++++++++++++++++++++++++
 4 files changed, 208 insertions(+), 148 deletions(-)
 create mode 100644 drivers/irqchip/irq-ath79-misc.c

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 511c065..05b4514 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -26,90 +26,6 @@
 #include "common.h"
 #include "machtypes.h"
 
-static void __init ath79_misc_intc_domain_init(
-	struct device_node *node, int irq);
-
-static void ath79_misc_irq_handler(struct irq_desc *desc)
-{
-	struct irq_domain *domain = irq_desc_get_handler_data(desc);
-	void __iomem *base = domain->host_data;
-	u32 pending;
-
-	pending = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS) &
-		  __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
-
-	if (!pending) {
-		spurious_interrupt();
-		return;
-	}
-
-	while (pending) {
-		int bit = __ffs(pending);
-
-		generic_handle_irq(irq_linear_revmap(domain, bit));
-		pending &= ~BIT(bit);
-	}
-}
-
-static void ar71xx_misc_irq_unmask(struct irq_data *d)
-{
-	void __iomem *base = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->hwirq;
-	u32 t;
-
-	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
-	__raw_writel(t | (1 << irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
-
-	/* flush write */
-	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
-}
-
-static void ar71xx_misc_irq_mask(struct irq_data *d)
-{
-	void __iomem *base = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->hwirq;
-	u32 t;
-
-	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
-	__raw_writel(t & ~(1 << irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
-
-	/* flush write */
-	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
-}
-
-static void ar724x_misc_irq_ack(struct irq_data *d)
-{
-	void __iomem *base = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->hwirq;
-	u32 t;
-
-	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
-	__raw_writel(t & ~(1 << irq), base + AR71XX_RESET_REG_MISC_INT_STATUS);
-
-	/* flush write */
-	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
-}
-
-static struct irq_chip ath79_misc_irq_chip = {
-	.name		= "MISC",
-	.irq_unmask	= ar71xx_misc_irq_unmask,
-	.irq_mask	= ar71xx_misc_irq_mask,
-};
-
-static void __init ath79_misc_irq_init(void)
-{
-	if (soc_is_ar71xx() || soc_is_ar913x())
-		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
-	else if (soc_is_ar724x() ||
-		 soc_is_ar933x() ||
-		 soc_is_ar934x() ||
-		 soc_is_qca955x())
-		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
-	else
-		BUG();
-
-	ath79_misc_intc_domain_init(NULL, ATH79_CPU_IRQ(6));
-}
 
 static void ar934x_ip2_irq_dispatch(struct irq_desc *desc)
 {
@@ -248,69 +164,6 @@ asmlinkage void plat_irq_dispatch(void)
 	}
 }
 
-static int misc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
-{
-	irq_set_chip_and_handler(irq, &ath79_misc_irq_chip, handle_level_irq);
-	irq_set_chip_data(irq, d->host_data);
-	return 0;
-}
-
-static const struct irq_domain_ops misc_irq_domain_ops = {
-	.xlate = irq_domain_xlate_onecell,
-	.map = misc_map,
-};
-
-static void __init ath79_misc_intc_domain_init(
-	struct device_node *node, int irq)
-{
-	void __iomem *base = ath79_reset_base;
-	struct irq_domain *domain;
-
-	domain = irq_domain_add_legacy(node, ATH79_MISC_IRQ_COUNT,
-			ATH79_MISC_IRQ_BASE, 0, &misc_irq_domain_ops, base);
-	if (!domain)
-		panic("Failed to add MISC irqdomain");
-
-	/* Disable and clear all interrupts */
-	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
-	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
-
-	irq_set_chained_handler_and_data(irq, ath79_misc_irq_handler, domain);
-}
-
-static int __init ath79_misc_intc_of_init(
-	struct device_node *node, struct device_node *parent)
-{
-	int irq;
-
-	irq = irq_of_parse_and_map(node, 0);
-	if (!irq)
-		panic("Failed to get MISC IRQ");
-
-	ath79_misc_intc_domain_init(node, irq);
-	return 0;
-}
-
-static int __init ar7100_misc_intc_of_init(
-	struct device_node *node, struct device_node *parent)
-{
-	ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
-	return ath79_misc_intc_of_init(node, parent);
-}
-
-IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
-		ar7100_misc_intc_of_init);
-
-static int __init ar7240_misc_intc_of_init(
-	struct device_node *node, struct device_node *parent)
-{
-	ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
-	return ath79_misc_intc_of_init(node, parent);
-}
-
-IRQCHIP_DECLARE(ar7240_misc_intc, "qca,ar7240-misc-intc",
-		ar7240_misc_intc_of_init);
-
 static int __init ar79_cpu_intc_of_init(
 	struct device_node *node, struct device_node *parent)
 {
@@ -348,6 +201,8 @@ IRQCHIP_DECLARE(ar79_cpu_intc, "qca,ar7100-cpu-intc",
 
 void __init arch_init_irq(void)
 {
+	bool misc_is_ar71xx;
+
 	if (mips_machtype == ATH79_MACH_GENERIC_OF) {
 		irqchip_init();
 		return;
@@ -362,7 +217,19 @@ void __init arch_init_irq(void)
 	}
 
 	mips_cpu_irq_init();
-	ath79_misc_irq_init();
+
+	if (soc_is_ar71xx() || soc_is_ar913x())
+		misc_is_ar71xx = true;
+	else if (soc_is_ar724x() ||
+		 soc_is_ar933x() ||
+		 soc_is_ar934x() ||
+		 soc_is_qca955x())
+		misc_is_ar71xx = false;
+	else
+		BUG();
+	ath79_misc_irq_init(
+		ath79_reset_base + AR71XX_RESET_REG_MISC_INT_STATUS,
+		ATH79_CPU_IRQ(6), ATH79_MISC_IRQ_BASE, misc_is_ar71xx);
 
 	if (soc_is_ar934x())
 		ar934x_ip2_irq_init();
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
index 2b34872..22a2f56 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -144,4 +144,7 @@ static inline u32 ath79_reset_rr(unsigned reg)
 void ath79_device_reset_set(u32 mask);
 void ath79_device_reset_clear(u32 mask);
 
+void ath79_misc_irq_init(void __iomem *regs, int irq,
+			int irq_base, bool is_ar71xx);
+
 #endif /* __ASM_MACH_ATH79_H */
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 177f78f..a8f9075 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
+obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
new file mode 100644
index 0000000..aa72907
--- /dev/null
+++ b/drivers/irqchip/irq-ath79-misc.c
@@ -0,0 +1,189 @@
+/*
+ *  Atheros AR71xx/AR724x/AR913x MISC interrupt controller
+ *
+ *  Copyright (C) 2015 Alban Bedel <albeu@free.fr>
+ *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define AR71XX_RESET_REG_MISC_INT_STATUS	0
+#define AR71XX_RESET_REG_MISC_INT_ENABLE	4
+
+#define ATH79_MISC_IRQ_COUNT			32
+
+static void ath79_misc_irq_handler(struct irq_desc *desc)
+{
+	struct irq_domain *domain = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	void __iomem *base = domain->host_data;
+	u32 pending;
+
+	chained_irq_enter(chip, desc);
+
+	pending = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS) &
+		  __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+
+	if (!pending) {
+		spurious_interrupt();
+		chained_irq_exit(chip, desc);
+		return;
+	}
+
+	while (pending) {
+		int bit = __ffs(pending);
+
+		generic_handle_irq(irq_linear_revmap(domain, bit));
+		pending &= ~BIT(bit);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void ar71xx_misc_irq_unmask(struct irq_data *d)
+{
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->hwirq;
+	u32 t;
+
+	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+	__raw_writel(t | BIT(irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+
+	/* flush write */
+	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+}
+
+static void ar71xx_misc_irq_mask(struct irq_data *d)
+{
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->hwirq;
+	u32 t;
+
+	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+	__raw_writel(t & ~BIT(irq), base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+
+	/* flush write */
+	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+}
+
+static void ar724x_misc_irq_ack(struct irq_data *d)
+{
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->hwirq;
+	u32 t;
+
+	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
+	__raw_writel(t & ~BIT(irq), base + AR71XX_RESET_REG_MISC_INT_STATUS);
+
+	/* flush write */
+	__raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
+}
+
+static struct irq_chip ath79_misc_irq_chip = {
+	.name		= "MISC",
+	.irq_unmask	= ar71xx_misc_irq_unmask,
+	.irq_mask	= ar71xx_misc_irq_mask,
+};
+
+static int misc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &ath79_misc_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, d->host_data);
+	return 0;
+}
+
+static const struct irq_domain_ops misc_irq_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = misc_map,
+};
+
+static void __init ath79_misc_intc_domain_init(
+	struct irq_domain *domain, int irq)
+{
+	void __iomem *base = domain->host_data;
+
+	/* Disable and clear all interrupts */
+	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
+
+	irq_set_chained_handler_and_data(irq, ath79_misc_irq_handler, domain);
+}
+
+static int __init ath79_misc_intc_of_init(
+	struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	void __iomem *base;
+	int irq;
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (!irq) {
+		pr_err("Failed to get MISC IRQ\n");
+		return -EINVAL;
+	}
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("Failed to get MISC IRQ registers\n");
+		return -ENOMEM;
+	}
+
+	domain = irq_domain_add_linear(node, ATH79_MISC_IRQ_COUNT,
+				&misc_irq_domain_ops, base);
+	if (!domain) {
+		pr_err("Failed to add MISC irqdomain\n");
+		return -EINVAL;
+	}
+
+	ath79_misc_intc_domain_init(domain, irq);
+	return 0;
+}
+
+static int __init ar7100_misc_intc_of_init(
+	struct device_node *node, struct device_node *parent)
+{
+	ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
+	return ath79_misc_intc_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
+		ar7100_misc_intc_of_init);
+
+static int __init ar7240_misc_intc_of_init(
+	struct device_node *node, struct device_node *parent)
+{
+	ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
+	return ath79_misc_intc_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(ar7240_misc_intc, "qca,ar7240-misc-intc",
+		ar7240_misc_intc_of_init);
+
+void __init ath79_misc_irq_init(void __iomem *regs, int irq,
+				int irq_base, bool is_ar71xx)
+{
+	struct irq_domain *domain;
+
+	if (is_ar71xx)
+		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
+	else
+		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
+
+	domain = irq_domain_add_legacy(NULL, ATH79_MISC_IRQ_COUNT,
+			irq_base, 0, &misc_irq_domain_ops, regs);
+	if (!domain)
+		panic("Failed to create MISC irqdomain");
+
+	ath79_misc_intc_domain_init(domain, irq);
+}
-- 
2.0.0
