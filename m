Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2015 23:38:51 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:43830 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013875AbbLNWiWgy0mo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Dec 2015 23:38:22 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Mon, 14 Dec 2015
 15:38:13 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Mon, 14 Dec 2015
 15:45:16 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 02/14] irqchip: irq-pic32-evic: Add support for PIC32 interrupt controller
Date:   Mon, 14 Dec 2015 15:42:04 -0700
Message-ID: <1450133093-7053-3-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

From: Cristian Birsan <cristian.birsan@microchip.com>

This adds support for the interrupt controller present on PIC32 class
devices.

The following features are supported:
 - DT properties for EVIC and for devices that use interrupt lines
 - Persistent and non-persistent interrupt handling
 - irqdomain support

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/irqchip/Makefile           |    1 +
 drivers/irqchip/irq-pic32-evic.c   |  321 ++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/pic32-evic.h |   19 +++
 3 files changed, 341 insertions(+)
 create mode 100644 drivers/irqchip/irq-pic32-evic.c
 create mode 100644 include/linux/irqchip/pic32-evic.h

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 177f78f..e3608fc 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -55,3 +55,4 @@ obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
 obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
 obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
 obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
+obj-$(CONFIG_MACH_PIC32)		+= irq-pic32-evic.o
diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
new file mode 100644
index 0000000..6a7747c
--- /dev/null
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -0,0 +1,321 @@
+/*
+ * Cristian Birsan <cristian.birsan@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/pic32-evic.h>
+
+#include <asm/irq.h>
+#include <asm/traps.h>
+
+#define CORE_TIMER_INTERRUPT 0
+#define EXTERNAL_INTERRUPT_0 3
+#define EXTERNAL_INTERRUPT_1 8
+#define EXTERNAL_INTERRUPT_2 13
+#define EXTERNAL_INTERRUPT_3 18
+#define EXTERNAL_INTERRUPT_4 23
+
+#define PRI_MASK	0x7	/* 3 bit priority mask */
+#define SUBPRI_MASK	0x3	/* 2 bit subpriority mask */
+#define INT_MASK	0x1F	/* 5 bit pri and subpri mask */
+#define NR_EXT_IRQS	5	/* 5 external interrupts sources */
+
+#define PIC32_INT_PRI(pri, subpri)	\
+	(((pri & PRI_MASK) << 2) | (subpri & SUBPRI_MASK))
+#define DEFAULT_PIC32_INT_PRI PIC32_INT_PRI(2, 0)
+
+static struct irq_domain *evic_irq_domain;
+static struct evic __iomem *evic_base;
+
+static unsigned int *evic_irq_prio;
+
+struct pic_reg {
+	u32 val; /* value register*/
+	u32 clr; /* clear register */
+	u32 set; /* set register */
+	u32 inv; /* inv register */
+} __packed;
+
+struct evic {
+	struct pic_reg intcon;
+	struct pic_reg priss;
+	struct pic_reg intstat;
+	struct pic_reg iptmr;
+	struct pic_reg ifs[6];
+	u32 reserved1[8];
+	struct pic_reg iec[6];
+	u32 reserved2[8];
+	struct pic_reg ipc[48];
+	u32 reserved3[64];
+	u32 off[191];
+} __packed;
+
+static int get_ext_irq_index(irq_hw_number_t hw);
+static void evic_set_ext_irq_polarity(int ext_irq, u32 type);
+
+#define BIT_REG_MASK(bit, reg, mask)		\
+	do {					\
+		reg = bit/32;			\
+		mask = 1 << (bit % 32);		\
+	} while (0)
+
+asmlinkage void __weak plat_irq_dispatch(void)
+{
+	unsigned int irq, hwirq;
+	u32 reg, mask;
+
+	hwirq = readl(&evic_base->intstat.val) & 0xFF;
+
+	/* Check if the interrupt was really triggered by hardware*/
+	BIT_REG_MASK(hwirq, reg, mask);
+	if (likely(readl(&evic_base->ifs[reg].val) &
+			readl(&evic_base->iec[reg].val) & mask)) {
+		irq = irq_linear_revmap(evic_irq_domain, hwirq);
+		do_IRQ(irq);
+	} else
+		spurious_interrupt();
+}
+
+/* mask off an interrupt */
+static inline void mask_pic32_irq(struct irq_data *irqd)
+{
+	u32 reg, mask;
+	unsigned int hwirq = irqd_to_hwirq(irqd);
+
+	BIT_REG_MASK(hwirq, reg, mask);
+	writel(mask, &evic_base->iec[reg].clr);
+}
+
+/* unmask an interrupt */
+static inline void unmask_pic32_irq(struct irq_data *irqd)
+{
+	u32 reg, mask;
+	unsigned int hwirq = irqd_to_hwirq(irqd);
+
+	BIT_REG_MASK(hwirq, reg, mask);
+	writel(mask, &evic_base->iec[reg].set);
+}
+
+/* acknowledge an interrupt */
+static void ack_pic32_irq(struct irq_data *irqd)
+{
+	u32 reg, mask;
+	unsigned int hwirq = irqd_to_hwirq(irqd);
+
+	BIT_REG_MASK(hwirq, reg, mask);
+	writel(mask, &evic_base->ifs[reg].clr);
+}
+
+/* mask off and acknowledge an interrupt */
+static inline void mask_ack_pic32_irq(struct irq_data *irqd)
+{
+	u32 reg, mask;
+	unsigned int hwirq = irqd_to_hwirq(irqd);
+
+	BIT_REG_MASK(hwirq, reg, mask);
+	writel(mask, &evic_base->iec[reg].clr);
+	writel(mask, &evic_base->ifs[reg].clr);
+}
+
+static int set_type_pic32_irq(struct irq_data *data, unsigned int flow_type)
+{
+	int index;
+
+	switch (flow_type) {
+
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_set_handler_locked(data, handle_edge_irq);
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_set_handler_locked(data, handle_fasteoi_irq);
+		break;
+
+	default:
+		pr_err("Invalid interrupt type !\n");
+		return -EINVAL;
+	}
+
+	/* set polarity for external interrupts only */
+	index = get_ext_irq_index(data->hwirq);
+	if (index >= 0)
+		evic_set_ext_irq_polarity(index, flow_type);
+
+	return IRQ_SET_MASK_OK;
+}
+
+static void pic32_bind_evic_interrupt(int irq, int set)
+{
+	writel(set, &evic_base->off[irq]);
+}
+
+int pic32_get_c0_compare_int(void)
+{
+	int virq;
+
+	virq = irq_create_mapping(evic_irq_domain, CORE_TIMER_INTERRUPT);
+	irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
+	return virq;
+}
+
+static struct irq_chip pic32_irq_chip = {
+	.name = "PIC32-EVIC",
+	.irq_ack = ack_pic32_irq,
+	.irq_mask = mask_pic32_irq,
+	.irq_mask_ack = mask_ack_pic32_irq,
+	.irq_unmask = unmask_pic32_irq,
+	.irq_eoi = ack_pic32_irq,
+	.irq_set_type = set_type_pic32_irq,
+	.irq_enable = unmask_pic32_irq,
+	.irq_disable = mask_pic32_irq,
+};
+
+static void evic_set_irq_priority(int irq, int priority)
+{
+	u32 reg, shift;
+
+	reg = irq / 4;
+	shift = (irq % 4) * 8;
+
+	/* set priority */
+	writel(INT_MASK << shift, &evic_base->ipc[reg].clr);
+	writel(priority << shift, &evic_base->ipc[reg].set);
+}
+
+static void evic_set_ext_irq_polarity(int ext_irq, u32 type)
+{
+	if (WARN_ON(ext_irq >= NR_EXT_IRQS))
+		return;
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		writel(1 << ext_irq, &evic_base->intcon.set);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		writel(1 << ext_irq, &evic_base->intcon.clr);
+		break;
+	default:
+		pr_err("Invalid external interrupt polarity !\n");
+	}
+}
+
+static int get_ext_irq_index(irq_hw_number_t hw)
+{
+	switch (hw) {
+	case EXTERNAL_INTERRUPT_0:
+		return 0;
+	case EXTERNAL_INTERRUPT_1:
+		return 1;
+	case EXTERNAL_INTERRUPT_2:
+		return 2;
+	case EXTERNAL_INTERRUPT_3:
+		return 3;
+	case EXTERNAL_INTERRUPT_4:
+		return 4;
+	default:
+		return -1;
+	}
+}
+
+static int evic_intc_map(struct irq_domain *irqd, unsigned int virq,
+			irq_hw_number_t hw)
+{
+	u32 reg, mask;
+
+	irq_set_chip(virq, &pic32_irq_chip);
+
+	BIT_REG_MASK(hw, reg, mask);
+
+	/* disable */
+	writel(mask, &evic_base->iec[reg].clr);
+
+	/* clear flag */
+	writel(mask, &evic_base->ifs[reg].clr);
+
+	evic_set_irq_priority(hw, evic_irq_prio[hw]);
+
+	return 0;
+}
+
+static int evic_irq_domain_xlate(struct irq_domain *d,
+				struct device_node *ctrlr,
+				const u32 *intspec,
+				unsigned int intsize,
+				irq_hw_number_t *out_hwirq,
+				unsigned int *out_type)
+{
+	/* Check for number of params */
+	if (WARN_ON(intsize < 2))
+		return -EINVAL;
+	if (WARN_ON(intspec[0] >= NR_IRQS))
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+
+	evic_irq_prio[*out_hwirq] = DEFAULT_PIC32_INT_PRI;
+
+	*out_type = intspec[1];
+
+	return 0;
+}
+
+static const struct irq_domain_ops evic_intc_irq_domain_ops = {
+		.map = evic_intc_map,
+		.xlate = evic_irq_domain_xlate,
+};
+
+#ifdef CONFIG_OF
+static int __init
+microchip_evic_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct resource res;
+
+	if (WARN_ON(!node))
+		return -ENODEV;
+
+	evic_irq_prio = kcalloc(NR_IRQS, sizeof(*evic_irq_prio),
+				GFP_KERNEL);
+	if (!evic_irq_prio)
+		return -ENOMEM;
+
+	evic_irq_prio[CORE_TIMER_INTERRUPT] = DEFAULT_PIC32_INT_PRI;
+
+	if (of_address_to_resource(node, 0, &res))
+		panic("Failed to get evic memory range");
+
+	if (request_mem_region(res.start, resource_size(&res),
+				res.name) == NULL)
+		panic("Failed to request evic memory");
+
+	evic_base = ioremap_nocache(res.start, resource_size(&res));
+	if (!evic_base)
+		panic("Failed to remap evic memory");
+
+	board_bind_eic_interrupt = &pic32_bind_evic_interrupt;
+
+	evic_irq_domain = irq_domain_add_linear(node, NR_IRQS,
+			&evic_intc_irq_domain_ops, NULL);
+	if (!evic_irq_domain)
+		panic("Failed to add linear irqdomain for EVIC");
+
+	irq_set_default_host(evic_irq_domain);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(microchip_evic, "microchip,pic32mzda-evic",
+		microchip_evic_of_init);
+#endif
diff --git a/include/linux/irqchip/pic32-evic.h b/include/linux/irqchip/pic32-evic.h
new file mode 100644
index 0000000..c514bae
--- /dev/null
+++ b/include/linux/irqchip/pic32-evic.h
@@ -0,0 +1,19 @@
+/*
+ * Joshua Henderson, <joshua.henderson@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ */
+#ifndef __LINUX_IRQCHIP_PIC32_EVIC_H
+#define __LINUX_IRQCHIP_PIC32_EVIC_H
+
+extern int pic32_get_c0_compare_int(void);
+
+#endif /* __LINUX_IRQCHIP_PIC32_EVIC_H */
-- 
1.7.9.5
