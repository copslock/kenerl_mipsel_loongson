Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 16:49:05 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:40694 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdLHPrk1y05P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 16:47:40 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id D64A720391; Fri,  8 Dec 2017 16:47:34 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id A613D2073B;
        Fri,  8 Dec 2017 16:47:24 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v2 03/13] irqchip: Add a driver for the Microsemi Ocelot controller
Date:   Fri,  8 Dec 2017 16:46:08 +0100
Message-Id: <20171208154618.20105-4-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

The Microsemi Ocelot SoC has a pretty simple IRQ controller in its ICPU
block. Add a driver for it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/irqchip/Kconfig           |   5 ++
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-mscc-ocelot.c | 109 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/irqchip/irq-mscc-ocelot.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c70476b34a53..9605a872da1c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -286,6 +286,11 @@ config IRQ_MXS
 	select IRQ_DOMAIN
 	select STMP_DEVICE
 
+config MSCC_OCELOT_IRQ
+	bool
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
+
 config MVEBU_GICP
 	bool
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d2df34a54d38..dc549701782d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
 obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
 obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
 obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
+obj-$(CONFIG_MSCC_OCELOT_IRQ)		+= irq-mscc-ocelot.o
 obj-$(CONFIG_MVEBU_GICP)		+= irq-mvebu-gicp.o
 obj-$(CONFIG_MVEBU_ICU)			+= irq-mvebu-icu.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
new file mode 100644
index 000000000000..c2cf46758a59
--- /dev/null
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi Ocelot IRQ controller driver
+ *
+ * License: Dual MIT/GPL
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/interrupt.h>
+
+#define ICPU_CFG_INTR_INTR_STICKY	0x10
+#define ICPU_CFG_INTR_INTR_ENA		0x18
+#define ICPU_CFG_INTR_INTR_ENA_CLR	0x1c
+#define ICPU_CFG_INTR_INTR_ENA_SET	0x20
+#define ICPU_CFG_INTR_DST_INTR_IDENT(x)	(0x38 + 0x4 * (x))
+#define ICPU_CFG_INTR_INTR_TRIGGER(x)	(0x5c + 0x4 * (x))
+
+#define OCELOT_NR_IRQ 24
+
+static void ocelot_irq_unmask(struct irq_data *data)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct irq_chip_type *ct = irq_data_get_chip_type(data);
+	unsigned int mask = data->mask;
+	u32 val;
+
+	irq_gc_lock(gc);
+	val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(0)) |
+	      irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(1));
+	if ((val & mask) == 0)
+		irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_STICKY);
+
+	*ct->mask_cache &= ~mask;
+	irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_ENA_SET);
+	irq_gc_unlock(gc);
+}
+
+static void ocelot_irq_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_domain *d = irq_desc_get_handler_data(desc);
+	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, 0);
+	u32 reg = irq_reg_readl(gc, ICPU_CFG_INTR_DST_INTR_IDENT(0));
+
+	chained_irq_enter(chip, desc);
+
+	while (reg) {
+		u32 hwirq = __fls(reg);
+
+		generic_handle_irq(irq_find_mapping(d, hwirq));
+		reg &= ~(BIT(hwirq));
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int __init ocelot_irq_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	struct irq_domain *domain;
+	struct irq_chip_generic *gc;
+	int parent_irq, ret;
+
+	domain = irq_domain_add_linear(node, OCELOT_NR_IRQ,
+				       &irq_generic_chip_ops, NULL);
+	if (!domain) {
+		pr_err("%s: unable to add irq domain\n", node->name);
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(domain, OCELOT_NR_IRQ, 1,
+					     "icpu", handle_level_irq,
+					     0, 0, 0);
+	if (ret) {
+		pr_err("%s: unable to alloc irq domain gc\n", node->name);
+		return ret;
+	}
+
+	gc = irq_get_domain_generic_chip(domain, 0);
+	gc->reg_base = of_iomap(node, 0);
+	if (!gc->reg_base) {
+		pr_err("%s: unable to map resource\n", node->name);
+		return -ENOMEM;
+	}
+
+	gc->chip_types[0].regs.ack = ICPU_CFG_INTR_INTR_STICKY;
+	gc->chip_types[0].regs.mask = ICPU_CFG_INTR_INTR_ENA_CLR;
+	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
+	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
+	gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;
+
+	irq_reg_writel(gc, 0, ICPU_CFG_INTR_INTR_ENA); /* Mask all */
+	irq_reg_writel(gc, 0xffffffff, ICPU_CFG_INTR_INTR_STICKY); /* Ack pending */
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq)
+		return -EINVAL;
+
+	irq_set_chained_handler_and_data(parent_irq, ocelot_irq_handler,
+					 domain);
+
+	return 0;
+}
+IRQCHIP_DECLARE(ocelot_icpu, "mscc,ocelot-icpu-intr", ocelot_irq_init);
-- 
2.15.1
