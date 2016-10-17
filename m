Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 18:53:44 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:3396 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992240AbcJQQxKwTroz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 18:53:10 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id E7955F1B20860;
        Mon, 17 Oct 2016 17:52:59 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 17:53:03 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 17 Oct 2016 17:53:03 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <alistair@popple.id.au>, <mporter@kernel.crashing.org>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <paulus@samba.org>, <benh@kernel.crashing.org>
Subject: [Patch v5 01/12] microblaze: irqchip: Move intc driver to irqchip
Date:   Mon, 17 Oct 2016 17:52:45 +0100
Message-ID: <1476723176-39891-2-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

The Xilinx AXI Interrupt Controller IP block is used by the MIPS
based xilfpga platform and a few PowerPC based platforms.

Move the interrupt controller code out of arch/microblaze so that
it can be used by everyone

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V4 -> V5
Rebase to v4.9-rc1
Renamed back to irq-xilinx-intc.c

V3 -> V4
No change

V2 -> V3
No change here. Cleanup patches follow after this patch.
Its debatable to cleanup before/after move. Decided to place cleanup
after move to put history in new place.

V1 -> V2

Renamed irq-xilinx to irq-axi-intc
Renamed CONFIG_XILINX_INTC to CONFIG_XILINX_AXI_INTC
Patch is now without rename flag so as to facilitate review
---
 arch/microblaze/Kconfig           |   1 +
 arch/microblaze/kernel/Makefile   |   2 +-
 arch/microblaze/kernel/intc.c     | 196 --------------------------------------
 drivers/irqchip/Kconfig           |   4 +
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-xilinx-intc.c | 196 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 203 insertions(+), 197 deletions(-)
 delete mode 100644 arch/microblaze/kernel/intc.c
 create mode 100644 drivers/irqchip/irq-xilinx-intc.c

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 86f6572..85885a5 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -27,6 +27,7 @@ config MICROBLAZE
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_OPROFILE
 	select IRQ_DOMAIN
+	select XILINX_INTC
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index f08baca..e098381 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -15,7 +15,7 @@ endif
 extra-y := head.o vmlinux.lds
 
 obj-y += dma.o exceptions.o \
-	hw_exception_handler.o intc.o irq.o \
+	hw_exception_handler.o irq.o \
 	platform.o process.o prom.o ptrace.o \
 	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
 
diff --git a/arch/microblaze/kernel/intc.c b/arch/microblaze/kernel/intc.c
deleted file mode 100644
index 90bec7d..0000000
--- a/arch/microblaze/kernel/intc.c
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * Copyright (C) 2007-2013 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2012-2013 Xilinx, Inc.
- * Copyright (C) 2007-2009 PetaLogix
- * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/irqdomain.h>
-#include <linux/irq.h>
-#include <linux/irqchip.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
-#include <linux/bug.h>
-
-static void __iomem *intc_baseaddr;
-
-/* No one else should require these constants, so define them locally here. */
-#define ISR 0x00			/* Interrupt Status Register */
-#define IPR 0x04			/* Interrupt Pending Register */
-#define IER 0x08			/* Interrupt Enable Register */
-#define IAR 0x0c			/* Interrupt Acknowledge Register */
-#define SIE 0x10			/* Set Interrupt Enable bits */
-#define CIE 0x14			/* Clear Interrupt Enable bits */
-#define IVR 0x18			/* Interrupt Vector Register */
-#define MER 0x1c			/* Master Enable Register */
-
-#define MER_ME (1<<0)
-#define MER_HIE (1<<1)
-
-static unsigned int (*read_fn)(void __iomem *);
-static void (*write_fn)(u32, void __iomem *);
-
-static void intc_write32(u32 val, void __iomem *addr)
-{
-	iowrite32(val, addr);
-}
-
-static unsigned int intc_read32(void __iomem *addr)
-{
-	return ioread32(addr);
-}
-
-static void intc_write32_be(u32 val, void __iomem *addr)
-{
-	iowrite32be(val, addr);
-}
-
-static unsigned int intc_read32_be(void __iomem *addr)
-{
-	return ioread32be(addr);
-}
-
-static void intc_enable_or_unmask(struct irq_data *d)
-{
-	unsigned long mask = 1 << d->hwirq;
-
-	pr_debug("enable_or_unmask: %ld\n", d->hwirq);
-
-	/* ack level irqs because they can't be acked during
-	 * ack function since the handle_level_irq function
-	 * acks the irq before calling the interrupt handler
-	 */
-	if (irqd_is_level_type(d))
-		write_fn(mask, intc_baseaddr + IAR);
-
-	write_fn(mask, intc_baseaddr + SIE);
-}
-
-static void intc_disable_or_mask(struct irq_data *d)
-{
-	pr_debug("disable: %ld\n", d->hwirq);
-	write_fn(1 << d->hwirq, intc_baseaddr + CIE);
-}
-
-static void intc_ack(struct irq_data *d)
-{
-	pr_debug("ack: %ld\n", d->hwirq);
-	write_fn(1 << d->hwirq, intc_baseaddr + IAR);
-}
-
-static void intc_mask_ack(struct irq_data *d)
-{
-	unsigned long mask = 1 << d->hwirq;
-
-	pr_debug("disable_and_ack: %ld\n", d->hwirq);
-	write_fn(mask, intc_baseaddr + CIE);
-	write_fn(mask, intc_baseaddr + IAR);
-}
-
-static struct irq_chip intc_dev = {
-	.name = "Xilinx INTC",
-	.irq_unmask = intc_enable_or_unmask,
-	.irq_mask = intc_disable_or_mask,
-	.irq_ack = intc_ack,
-	.irq_mask_ack = intc_mask_ack,
-};
-
-static struct irq_domain *root_domain;
-
-unsigned int get_irq(void)
-{
-	unsigned int hwirq, irq = -1;
-
-	hwirq = read_fn(intc_baseaddr + IVR);
-	if (hwirq != -1U)
-		irq = irq_find_mapping(root_domain, hwirq);
-
-	pr_debug("get_irq: hwirq=%d, irq=%d\n", hwirq, irq);
-
-	return irq;
-}
-
-static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
-{
-	u32 intr_mask = (u32)d->host_data;
-
-	if (intr_mask & (1 << hw)) {
-		irq_set_chip_and_handler_name(irq, &intc_dev,
-						handle_edge_irq, "edge");
-		irq_clear_status_flags(irq, IRQ_LEVEL);
-	} else {
-		irq_set_chip_and_handler_name(irq, &intc_dev,
-						handle_level_irq, "level");
-		irq_set_status_flags(irq, IRQ_LEVEL);
-	}
-	return 0;
-}
-
-static const struct irq_domain_ops xintc_irq_domain_ops = {
-	.xlate = irq_domain_xlate_onetwocell,
-	.map = xintc_map,
-};
-
-static int __init xilinx_intc_of_init(struct device_node *intc,
-					     struct device_node *parent)
-{
-	u32 nr_irq, intr_mask;
-	int ret;
-
-	intc_baseaddr = of_iomap(intc, 0);
-	BUG_ON(!intc_baseaddr);
-
-	ret = of_property_read_u32(intc, "xlnx,num-intr-inputs", &nr_irq);
-	if (ret < 0) {
-		pr_err("%s: unable to read xlnx,num-intr-inputs\n", __func__);
-		return ret;
-	}
-
-	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", &intr_mask);
-	if (ret < 0) {
-		pr_err("%s: unable to read xlnx,kind-of-intr\n", __func__);
-		return ret;
-	}
-
-	if (intr_mask >> nr_irq)
-		pr_warn("%s: mismatch in kind-of-intr param\n", __func__);
-
-	pr_info("%s: num_irq=%d, edge=0x%x\n",
-		intc->full_name, nr_irq, intr_mask);
-
-	write_fn = intc_write32;
-	read_fn = intc_read32;
-
-	/*
-	 * Disable all external interrupts until they are
-	 * explicity requested.
-	 */
-	write_fn(0, intc_baseaddr + IER);
-
-	/* Acknowledge any pending interrupts just in case. */
-	write_fn(0xffffffff, intc_baseaddr + IAR);
-
-	/* Turn on the Master Enable. */
-	write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
-	if (!(read_fn(intc_baseaddr + MER) & (MER_HIE | MER_ME))) {
-		write_fn = intc_write32_be;
-		read_fn = intc_read32_be;
-		write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
-	}
-
-	/* Yeah, okay, casting the intr_mask to a void* is butt-ugly, but I'm
-	 * lazy and Michal can clean it up to something nicer when he tests
-	 * and commits this patch.  ~~gcl */
-	root_domain = irq_domain_add_linear(intc, nr_irq, &xintc_irq_domain_ops,
-							(void *)intr_mask);
-
-	irq_set_default_host(root_domain);
-
-	return 0;
-}
-
-IRQCHIP_DECLARE(xilinx_intc, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 82b0b5d..0842cbc 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -211,6 +211,10 @@ config XTENSA_MX
 	bool
 	select IRQ_DOMAIN
 
+config XILINX_INTC
+	bool
+	select IRQ_DOMAIN
+
 config IRQ_CROSSBAR
 	bool
 	help
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e4dbfc8..0e55d94 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
 obj-$(CONFIG_TS4800_IRQ)		+= irq-ts4800.o
 obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
 obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
+obj-$(CONFIG_XILINX_INTC)		+= irq-xilinx-intc.o
 obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
 obj-$(CONFIG_SOC_VF610)			+= irq-vf610-mscm-ir.o
 obj-$(CONFIG_BCM6345_L1_IRQ)		+= irq-bcm6345-l1.o
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
new file mode 100644
index 0000000..90bec7d
--- /dev/null
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -0,0 +1,196 @@
+/*
+ * Copyright (C) 2007-2013 Michal Simek <monstr@monstr.eu>
+ * Copyright (C) 2012-2013 Xilinx, Inc.
+ * Copyright (C) 2007-2009 PetaLogix
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/bug.h>
+
+static void __iomem *intc_baseaddr;
+
+/* No one else should require these constants, so define them locally here. */
+#define ISR 0x00			/* Interrupt Status Register */
+#define IPR 0x04			/* Interrupt Pending Register */
+#define IER 0x08			/* Interrupt Enable Register */
+#define IAR 0x0c			/* Interrupt Acknowledge Register */
+#define SIE 0x10			/* Set Interrupt Enable bits */
+#define CIE 0x14			/* Clear Interrupt Enable bits */
+#define IVR 0x18			/* Interrupt Vector Register */
+#define MER 0x1c			/* Master Enable Register */
+
+#define MER_ME (1<<0)
+#define MER_HIE (1<<1)
+
+static unsigned int (*read_fn)(void __iomem *);
+static void (*write_fn)(u32, void __iomem *);
+
+static void intc_write32(u32 val, void __iomem *addr)
+{
+	iowrite32(val, addr);
+}
+
+static unsigned int intc_read32(void __iomem *addr)
+{
+	return ioread32(addr);
+}
+
+static void intc_write32_be(u32 val, void __iomem *addr)
+{
+	iowrite32be(val, addr);
+}
+
+static unsigned int intc_read32_be(void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+static void intc_enable_or_unmask(struct irq_data *d)
+{
+	unsigned long mask = 1 << d->hwirq;
+
+	pr_debug("enable_or_unmask: %ld\n", d->hwirq);
+
+	/* ack level irqs because they can't be acked during
+	 * ack function since the handle_level_irq function
+	 * acks the irq before calling the interrupt handler
+	 */
+	if (irqd_is_level_type(d))
+		write_fn(mask, intc_baseaddr + IAR);
+
+	write_fn(mask, intc_baseaddr + SIE);
+}
+
+static void intc_disable_or_mask(struct irq_data *d)
+{
+	pr_debug("disable: %ld\n", d->hwirq);
+	write_fn(1 << d->hwirq, intc_baseaddr + CIE);
+}
+
+static void intc_ack(struct irq_data *d)
+{
+	pr_debug("ack: %ld\n", d->hwirq);
+	write_fn(1 << d->hwirq, intc_baseaddr + IAR);
+}
+
+static void intc_mask_ack(struct irq_data *d)
+{
+	unsigned long mask = 1 << d->hwirq;
+
+	pr_debug("disable_and_ack: %ld\n", d->hwirq);
+	write_fn(mask, intc_baseaddr + CIE);
+	write_fn(mask, intc_baseaddr + IAR);
+}
+
+static struct irq_chip intc_dev = {
+	.name = "Xilinx INTC",
+	.irq_unmask = intc_enable_or_unmask,
+	.irq_mask = intc_disable_or_mask,
+	.irq_ack = intc_ack,
+	.irq_mask_ack = intc_mask_ack,
+};
+
+static struct irq_domain *root_domain;
+
+unsigned int get_irq(void)
+{
+	unsigned int hwirq, irq = -1;
+
+	hwirq = read_fn(intc_baseaddr + IVR);
+	if (hwirq != -1U)
+		irq = irq_find_mapping(root_domain, hwirq);
+
+	pr_debug("get_irq: hwirq=%d, irq=%d\n", hwirq, irq);
+
+	return irq;
+}
+
+static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	u32 intr_mask = (u32)d->host_data;
+
+	if (intr_mask & (1 << hw)) {
+		irq_set_chip_and_handler_name(irq, &intc_dev,
+						handle_edge_irq, "edge");
+		irq_clear_status_flags(irq, IRQ_LEVEL);
+	} else {
+		irq_set_chip_and_handler_name(irq, &intc_dev,
+						handle_level_irq, "level");
+		irq_set_status_flags(irq, IRQ_LEVEL);
+	}
+	return 0;
+}
+
+static const struct irq_domain_ops xintc_irq_domain_ops = {
+	.xlate = irq_domain_xlate_onetwocell,
+	.map = xintc_map,
+};
+
+static int __init xilinx_intc_of_init(struct device_node *intc,
+					     struct device_node *parent)
+{
+	u32 nr_irq, intr_mask;
+	int ret;
+
+	intc_baseaddr = of_iomap(intc, 0);
+	BUG_ON(!intc_baseaddr);
+
+	ret = of_property_read_u32(intc, "xlnx,num-intr-inputs", &nr_irq);
+	if (ret < 0) {
+		pr_err("%s: unable to read xlnx,num-intr-inputs\n", __func__);
+		return ret;
+	}
+
+	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", &intr_mask);
+	if (ret < 0) {
+		pr_err("%s: unable to read xlnx,kind-of-intr\n", __func__);
+		return ret;
+	}
+
+	if (intr_mask >> nr_irq)
+		pr_warn("%s: mismatch in kind-of-intr param\n", __func__);
+
+	pr_info("%s: num_irq=%d, edge=0x%x\n",
+		intc->full_name, nr_irq, intr_mask);
+
+	write_fn = intc_write32;
+	read_fn = intc_read32;
+
+	/*
+	 * Disable all external interrupts until they are
+	 * explicity requested.
+	 */
+	write_fn(0, intc_baseaddr + IER);
+
+	/* Acknowledge any pending interrupts just in case. */
+	write_fn(0xffffffff, intc_baseaddr + IAR);
+
+	/* Turn on the Master Enable. */
+	write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
+	if (!(read_fn(intc_baseaddr + MER) & (MER_HIE | MER_ME))) {
+		write_fn = intc_write32_be;
+		read_fn = intc_read32_be;
+		write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
+	}
+
+	/* Yeah, okay, casting the intr_mask to a void* is butt-ugly, but I'm
+	 * lazy and Michal can clean it up to something nicer when he tests
+	 * and commits this patch.  ~~gcl */
+	root_domain = irq_domain_add_linear(intc, nr_irq, &xintc_irq_domain_ops,
+							(void *)intr_mask);
+
+	irq_set_default_host(root_domain);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(xilinx_intc, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
-- 
1.9.1
