Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 02:11:11 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:58961 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010701AbcANBKufzn39 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 02:10:50 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Wed, 13 Jan 2016
 18:10:48 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Wed, 13 Jan 2016
 18:18:35 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v5 02/14] irqchip: irq-pic32-evic: Add support for PIC32 interrupt controller
Date:   Wed, 13 Jan 2016 18:15:35 -0700
Message-ID: <1452734299-460-3-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51097
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
devices. It handles all internal and external interrupts. This controller
exists outside of the CPU core and is the arbitrator of all interrupts
(including interrupts from the CPU itself) before they are presented to
the CPU.

The following features are supported:
 - DT properties for EVIC and for devices/peripherals that use interrupt lines
 - Persistent and non-persistent interrupt handling
 - irqdomain and generic chip support
 - Configuration of external interrupt edge polarity

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Changes since v4:
	- Rearchitect (rewrite) to use generic chip
	- Be consistent with naming of functions, use pic32_ prefix
	- Move get_c0_compare_int() to platform where it belongs
	- Drop obsolete header
	- Add comments about the handler flow of the different interrupt types
	- Prevent external interrupts from being requested as level flow type
	- Simplify/optimize register access
	- Configure external interrupts from DT
	- Simplify plat_irq_dispatch() implementation
	- Change irq chip names to evic-*
	- Add EVIC_PIC32 config option and have platform select it
	- Support to configure core timer interrupt from DT
	- Use proper code comment formatting
Changes since v3:
	- Formatting and comment location
	- Move functions to remove need for forward declaration
Changes since v2:
	- Remove redundant irq_chip functions in interrupt driver
Changes since v1:
	- Remove configuring hardware priorities and just set a default
---
 drivers/irqchip/Kconfig          |    5 +
 drivers/irqchip/Makefile         |    1 +
 drivers/irqchip/irq-pic32-evic.c |  324 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+)
 create mode 100644 drivers/irqchip/irq-pic32-evic.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4d7294e..d5bafdd 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -117,6 +117,11 @@ config ORION_IRQCHIP
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
 
+config PIC32_EVIC
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config RENESAS_INTC_IRQPIN
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 177f78f..5278893 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -55,3 +55,4 @@ obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
 obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
 obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
 obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
+obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
new file mode 100644
index 0000000..e7155db
--- /dev/null
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -0,0 +1,324 @@
+/*
+ * Cristian Birsan <cristian.birsan@microchip.com>
+ * Joshua Henderson <joshua.henderson@microchip.com>
+ * Copyright (C) 2016 Microchip Technology Inc.  All rights reserved.
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
+#include <linux/irq.h>
+
+#include <asm/irq.h>
+#include <asm/traps.h>
+#include <asm/mach-pic32/pic32.h>
+
+#define REG_INTCON	0x0000
+#define REG_INTSTAT	0x0020
+#define REG_IFS_OFFSET	0x0040
+#define REG_IEC_OFFSET	0x00C0
+#define REG_IPC_OFFSET	0x0140
+#define REG_OFF_OFFSET	0x0540
+
+#define MAJPRI_MASK	0x07
+#define SUBPRI_MASK	0x03
+#define PRIORITY_MASK	0x1F
+
+#define PIC32_INT_PRI(pri, subpri)				\
+	((((pri) & MAJPRI_MASK) << 2) | ((subpri) & SUBPRI_MASK))
+
+struct evic_chip_data {
+	u32 irq_types[NR_IRQS];
+	u32 ext_irqs[8];
+};
+
+static struct irq_domain *evic_irq_domain;
+static void __iomem *evic_base;
+
+asmlinkage void __weak plat_irq_dispatch(void)
+{
+	unsigned int irq, hwirq;
+
+	hwirq = readl(evic_base + REG_INTSTAT) & 0xFF;
+	irq = irq_linear_revmap(evic_irq_domain, hwirq);
+	do_IRQ(irq);
+}
+
+static struct evic_chip_data *irqd_to_priv(struct irq_data *data)
+{
+	return (struct evic_chip_data *)data->domain->host_data;
+}
+
+static int pic32_set_ext_polarity(int bit, u32 type)
+{
+	/*
+	 * External interrupts can be either edge rising or edge falling,
+	 * but not both.
+	 */
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		writel(BIT(bit), evic_base + PIC32_SET(REG_INTCON));
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		writel(BIT(bit), evic_base + PIC32_CLR(REG_INTCON));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int pic32_set_type_edge(struct irq_data *data,
+			       unsigned int flow_type)
+{
+	struct evic_chip_data *priv = irqd_to_priv(data);
+	int ret;
+	int i;
+
+	if (!(flow_type & IRQ_TYPE_EDGE_BOTH))
+		return -EBADR;
+
+	/* set polarity for external interrupts only */
+	for (i = 0; i < ARRAY_SIZE(priv->ext_irqs); i++) {
+		if (priv->ext_irqs[i] == data->hwirq) {
+			ret = pic32_set_ext_polarity(i + 1, flow_type);
+			if (ret)
+				return ret;
+		}
+	}
+
+	irqd_set_trigger_type(data, flow_type);
+
+	return IRQ_SET_MASK_OK;
+}
+
+static void pic32_bind_evic_interrupt(int irq, int set)
+{
+	writel(set, evic_base + REG_OFF_OFFSET + irq * 4);
+}
+
+static void pic32_set_irq_priority(int irq, int priority)
+{
+	u32 reg, shift;
+
+	reg = irq / 4;
+	shift = (irq % 4) * 8;
+
+	writel(PRIORITY_MASK << shift,
+		evic_base + PIC32_CLR(REG_IPC_OFFSET + reg * 0x10));
+	writel(priority << shift,
+		evic_base + PIC32_SET(REG_IPC_OFFSET + reg * 0x10));
+}
+
+#define IRQ_REG_MASK(_hwirq, _reg, _mask)		       \
+	do {						       \
+		_reg = _hwirq / 32;			       \
+		_mask = 1 << (_hwirq % 32);		       \
+	} while (0)
+
+static int pic32_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				irq_hw_number_t hw)
+{
+	struct evic_chip_data *priv = d->host_data;
+	struct irq_data *data;
+	int ret;
+	u32 iecclr, ifsclr;
+	u32 reg, mask;
+
+	ret = irq_map_generic_chip(d, virq, hw);
+	if (ret)
+		return ret;
+
+	/*
+	 * Piggyback on xlate function to move to an alternate chip as necessary
+	 * at time of mapping instead of allowing the flow handler/chip to be
+	 * changed later. This requires all interrupts to be configured through
+	 * DT.
+	 */
+	if (priv->irq_types[hw] & IRQ_TYPE_SENSE_MASK) {
+		data = irq_domain_get_irq_data(d, virq);
+		irqd_set_trigger_type(data, priv->irq_types[hw]);
+		irq_setup_alt_chip(data, priv->irq_types[hw]);
+	}
+
+	IRQ_REG_MASK(hw, reg, mask);
+
+	iecclr = PIC32_CLR(REG_IEC_OFFSET + reg * 0x10);
+	ifsclr = PIC32_CLR(REG_IFS_OFFSET + reg * 0x10);
+
+	/* mask and clear flag */
+	writel(mask, evic_base + iecclr);
+	writel(mask, evic_base + ifsclr);
+
+	/* default priority is required */
+	pic32_set_irq_priority(hw, PIC32_INT_PRI(2, 0));
+
+	return ret;
+}
+
+int pic32_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+			   const u32 *intspec, unsigned int intsize,
+			   irq_hw_number_t *out_hwirq, unsigned int *out_type)
+{
+	struct evic_chip_data *priv = d->host_data;
+
+	if (WARN_ON(intsize < 2))
+		return -EINVAL;
+
+	if (WARN_ON(intspec[0] >= NR_IRQS))
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+
+	priv->irq_types[intspec[0]] = intspec[1] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static const struct irq_domain_ops pic32_irq_domain_ops = {
+	.map	= pic32_irq_domain_map,
+	.xlate	= pic32_irq_domain_xlate,
+};
+
+static void __init pic32_ext_irq_of_init(struct irq_domain *domain)
+{
+	struct device_node *node = irq_domain_get_of_node(domain);
+	struct evic_chip_data *priv = domain->host_data;
+	struct property *prop;
+	const __le32 *p;
+	u32 hwirq;
+	int i = 0;
+	const char *pname = "microchip,external-irqs";
+
+	of_property_for_each_u32(node, pname, prop, p, hwirq) {
+		if (i >= ARRAY_SIZE(priv->ext_irqs)) {
+			pr_warn("More than %d external irq, skip rest\n",
+				ARRAY_SIZE(priv->ext_irqs));
+			break;
+		}
+
+		priv->ext_irqs[i] = hwirq;
+		i++;
+	}
+}
+
+static int __init pic32_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	struct irq_chip_generic *gc;
+	struct evic_chip_data *priv;
+	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	int nchips, ret;
+	int i;
+
+	nchips = DIV_ROUND_UP(NR_IRQS, 32);
+
+	evic_base = of_iomap(node, 0);
+	if (!evic_base)
+		return -ENOMEM;
+
+	priv = kcalloc(nchips, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_iounmap;
+	}
+
+	evic_irq_domain = irq_domain_add_linear(node, nchips * 32,
+						&pic32_irq_domain_ops,
+						priv);
+	if (!evic_irq_domain) {
+		ret = -ENOMEM;
+		goto err_free_priv;
+	}
+
+	/*
+	 * The PIC32 EVIC has a linear list of irqs and the type of each
+	 * irq is determined by the hardware peripheral the EVIC is arbitrating.
+	 * These irq types are defined in the datasheet as "persistent" and
+	 * "non-persistent" which are mapped here to level and edge
+	 * respectively. To manage the different flow handler requirements of
+	 * each irq type, different chip_types are used.
+	 */
+	ret = irq_alloc_domain_generic_chips(evic_irq_domain, 32, 2,
+					     "evic-level", handle_level_irq,
+					     clr, 0, 0);
+	if (ret)
+		goto err_domain_remove;
+
+	board_bind_eic_interrupt = &pic32_bind_evic_interrupt;
+
+	for (i = 0; i < nchips; i++) {
+		u32 ifsclr = PIC32_CLR(REG_IFS_OFFSET + (i * 0x10));
+		u32 iec = REG_IEC_OFFSET + (i * 0x10);
+
+		gc = irq_get_domain_generic_chip(evic_irq_domain, i * 32);
+
+		gc->reg_base = evic_base;
+		gc->unused = 0;
+
+		/*
+		 * Level/persistent interrupts have a special requirement that
+		 * the condition generating the interrupt be cleared before the
+		 * interrupt flag (ifs) can be cleared. chip.irq_eoi is used to
+		 * complete the interrupt with an ack.
+		 */
+		gc->chip_types[0].type			= IRQ_TYPE_LEVEL_MASK;
+		gc->chip_types[0].handler		= handle_fasteoi_irq;
+		gc->chip_types[0].regs.ack		= ifsclr;
+		gc->chip_types[0].regs.mask		= iec;
+		gc->chip_types[0].chip.name		= "evic-level";
+		gc->chip_types[0].chip.irq_eoi		= irq_gc_ack_set_bit;
+		gc->chip_types[0].chip.irq_mask		= irq_gc_mask_clr_bit;
+		gc->chip_types[0].chip.irq_unmask	= irq_gc_mask_set_bit;
+		gc->chip_types[0].chip.flags		= IRQCHIP_SKIP_SET_WAKE;
+
+		/* Edge interrupts */
+		gc->chip_types[1].type			= IRQ_TYPE_EDGE_BOTH;
+		gc->chip_types[1].handler		= handle_edge_irq;
+		gc->chip_types[1].regs.ack		= ifsclr;
+		gc->chip_types[1].regs.mask		= iec;
+		gc->chip_types[1].chip.name		= "evic-edge";
+		gc->chip_types[1].chip.irq_ack		= irq_gc_ack_set_bit;
+		gc->chip_types[1].chip.irq_mask		= irq_gc_mask_clr_bit;
+		gc->chip_types[1].chip.irq_unmask	= irq_gc_mask_set_bit;
+		gc->chip_types[1].chip.irq_set_type	= pic32_set_type_edge;
+		gc->chip_types[1].chip.flags		= IRQCHIP_SKIP_SET_WAKE;
+
+		gc->private = &priv[i];
+	}
+
+	irq_set_default_host(evic_irq_domain);
+
+	/*
+	 * External interrupts have software configurable edge polarity. These
+	 * interrupts are defined in DT allowing polarity to be configured only
+	 * for these interrupts when requested.
+	 */
+	pic32_ext_irq_of_init(evic_irq_domain);
+
+	return 0;
+
+err_domain_remove:
+	irq_domain_remove(evic_irq_domain);
+
+err_free_priv:
+	kfree(priv);
+
+err_iounmap:
+	iounmap(evic_base);
+
+	return ret;
+}
+
+IRQCHIP_DECLARE(pic32_evic, "microchip,pic32mzda-evic", pic32_of_init);
-- 
1.7.9.5
