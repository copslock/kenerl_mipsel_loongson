Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 14:46:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37565 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010256AbbGHMqRty93u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jul 2015 14:46:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t68CkDLD008272;
        Wed, 8 Jul 2015 14:46:13 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t68Ck8DT008271;
        Wed, 8 Jul 2015 14:46:08 +0200
Date:   Wed, 8 Jul 2015 14:46:08 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH] MIPS, IRQCHIP: Move i8259 irqchip driver to drivers/irqchip.
Message-ID: <20150708124608.GS18167@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

 arch/mips/Kconfig           |   4 -
 arch/mips/kernel/Makefile   |   1 -
 arch/mips/kernel/i8259.c    | 384 --------------------------------------------
 drivers/irqchip/Kconfig     |   4 +
 drivers/irqchip/Makefile    |   1 +
 drivers/irqchip/irq-i8259.c | 383 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 388 insertions(+), 389 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b0a121b..f2ae53a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1071,10 +1071,6 @@ config HOTPLUG_CPU
 config SYS_SUPPORTS_HOTPLUG_CPU
 	bool
 
-config I8259
-	bool
-	select IRQ_DOMAIN
-
 config MIPS_BONITO64
 	bool
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 3f5cf8a..3156c8d 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -61,7 +61,6 @@ obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o
 obj-$(CONFIG_MIPS_VPE_APSP_API_CMP) += rtlx-cmp.o
 obj-$(CONFIG_MIPS_VPE_APSP_API_MT) += rtlx-mt.o
 
-obj-$(CONFIG_I8259)		+= i8259.o
 obj-$(CONFIG_IRQ_CPU_RM7K)	+= irq-rm7000.o
 obj-$(CONFIG_MIPS_MSC)		+= irq-msc01.o
 obj-$(CONFIG_IRQ_TXX9)		+= irq_txx9.o
diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
deleted file mode 100644
index 74f6752..0000000
--- a/arch/mips/kernel/i8259.c
+++ /dev/null
@@ -1,384 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Code to handle x86 style IRQs plus some generic interrupt stuff.
- *
- * Copyright (C) 1992 Linus Torvalds
- * Copyright (C) 1994 - 2000 Ralf Baechle
- */
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/irqdomain.h>
-#include <linux/kernel.h>
-#include <linux/of_irq.h>
-#include <linux/spinlock.h>
-#include <linux/syscore_ops.h>
-#include <linux/irq.h>
-
-#include <asm/i8259.h>
-#include <asm/io.h>
-
-#include "../../drivers/irqchip/irqchip.h"
-
-/*
- * This is the 'legacy' 8259A Programmable Interrupt Controller,
- * present in the majority of PC/AT boxes.
- * plus some generic x86 specific things if generic specifics makes
- * any sense at all.
- * this file should become arch/i386/kernel/irq.c when the old irq.c
- * moves to arch independent land
- */
-
-static int i8259A_auto_eoi = -1;
-DEFINE_RAW_SPINLOCK(i8259A_lock);
-static void disable_8259A_irq(struct irq_data *d);
-static void enable_8259A_irq(struct irq_data *d);
-static void mask_and_ack_8259A(struct irq_data *d);
-static void init_8259A(int auto_eoi);
-
-static struct irq_chip i8259A_chip = {
-	.name			= "XT-PIC",
-	.irq_mask		= disable_8259A_irq,
-	.irq_disable		= disable_8259A_irq,
-	.irq_unmask		= enable_8259A_irq,
-	.irq_mask_ack		= mask_and_ack_8259A,
-};
-
-/*
- * 8259A PIC functions to handle ISA devices:
- */
-
-/*
- * This contains the irq mask for both 8259A irq controllers,
- */
-static unsigned int cached_irq_mask = 0xffff;
-
-#define cached_master_mask	(cached_irq_mask)
-#define cached_slave_mask	(cached_irq_mask >> 8)
-
-static void disable_8259A_irq(struct irq_data *d)
-{
-	unsigned int mask, irq = d->irq - I8259A_IRQ_BASE;
-	unsigned long flags;
-
-	mask = 1 << irq;
-	raw_spin_lock_irqsave(&i8259A_lock, flags);
-	cached_irq_mask |= mask;
-	if (irq & 8)
-		outb(cached_slave_mask, PIC_SLAVE_IMR);
-	else
-		outb(cached_master_mask, PIC_MASTER_IMR);
-	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
-}
-
-static void enable_8259A_irq(struct irq_data *d)
-{
-	unsigned int mask, irq = d->irq - I8259A_IRQ_BASE;
-	unsigned long flags;
-
-	mask = ~(1 << irq);
-	raw_spin_lock_irqsave(&i8259A_lock, flags);
-	cached_irq_mask &= mask;
-	if (irq & 8)
-		outb(cached_slave_mask, PIC_SLAVE_IMR);
-	else
-		outb(cached_master_mask, PIC_MASTER_IMR);
-	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
-}
-
-int i8259A_irq_pending(unsigned int irq)
-{
-	unsigned int mask;
-	unsigned long flags;
-	int ret;
-
-	irq -= I8259A_IRQ_BASE;
-	mask = 1 << irq;
-	raw_spin_lock_irqsave(&i8259A_lock, flags);
-	if (irq < 8)
-		ret = inb(PIC_MASTER_CMD) & mask;
-	else
-		ret = inb(PIC_SLAVE_CMD) & (mask >> 8);
-	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
-
-	return ret;
-}
-
-void make_8259A_irq(unsigned int irq)
-{
-	disable_irq_nosync(irq);
-	irq_set_chip_and_handler(irq, &i8259A_chip, handle_level_irq);
-	enable_irq(irq);
-}
-
-/*
- * This function assumes to be called rarely. Switching between
- * 8259A registers is slow.
- * This has to be protected by the irq controller spinlock
- * before being called.
- */
-static inline int i8259A_irq_real(unsigned int irq)
-{
-	int value;
-	int irqmask = 1 << irq;
-
-	if (irq < 8) {
-		outb(0x0B, PIC_MASTER_CMD);	/* ISR register */
-		value = inb(PIC_MASTER_CMD) & irqmask;
-		outb(0x0A, PIC_MASTER_CMD);	/* back to the IRR register */
-		return value;
-	}
-	outb(0x0B, PIC_SLAVE_CMD);	/* ISR register */
-	value = inb(PIC_SLAVE_CMD) & (irqmask >> 8);
-	outb(0x0A, PIC_SLAVE_CMD);	/* back to the IRR register */
-	return value;
-}
-
-/*
- * Careful! The 8259A is a fragile beast, it pretty
- * much _has_ to be done exactly like this (mask it
- * first, _then_ send the EOI, and the order of EOI
- * to the two 8259s is important!
- */
-static void mask_and_ack_8259A(struct irq_data *d)
-{
-	unsigned int irqmask, irq = d->irq - I8259A_IRQ_BASE;
-	unsigned long flags;
-
-	irqmask = 1 << irq;
-	raw_spin_lock_irqsave(&i8259A_lock, flags);
-	/*
-	 * Lightweight spurious IRQ detection. We do not want
-	 * to overdo spurious IRQ handling - it's usually a sign
-	 * of hardware problems, so we only do the checks we can
-	 * do without slowing down good hardware unnecessarily.
-	 *
-	 * Note that IRQ7 and IRQ15 (the two spurious IRQs
-	 * usually resulting from the 8259A-1|2 PICs) occur
-	 * even if the IRQ is masked in the 8259A. Thus we
-	 * can check spurious 8259A IRQs without doing the
-	 * quite slow i8259A_irq_real() call for every IRQ.
-	 * This does not cover 100% of spurious interrupts,
-	 * but should be enough to warn the user that there
-	 * is something bad going on ...
-	 */
-	if (cached_irq_mask & irqmask)
-		goto spurious_8259A_irq;
-	cached_irq_mask |= irqmask;
-
-handle_real_irq:
-	if (irq & 8) {
-		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
-		outb(cached_slave_mask, PIC_SLAVE_IMR);
-		outb(0x60+(irq&7), PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
-		outb(0x60+PIC_CASCADE_IR, PIC_MASTER_CMD); /* 'Specific EOI' to master-IRQ2 */
-	} else {
-		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
-		outb(cached_master_mask, PIC_MASTER_IMR);
-		outb(0x60+irq, PIC_MASTER_CMD); /* 'Specific EOI to master */
-	}
-	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
-	return;
-
-spurious_8259A_irq:
-	/*
-	 * this is the slow path - should happen rarely.
-	 */
-	if (i8259A_irq_real(irq))
-		/*
-		 * oops, the IRQ _is_ in service according to the
-		 * 8259A - not spurious, go handle it.
-		 */
-		goto handle_real_irq;
-
-	{
-		static int spurious_irq_mask;
-		/*
-		 * At this point we can be sure the IRQ is spurious,
-		 * lets ACK and report it. [once per IRQ]
-		 */
-		if (!(spurious_irq_mask & irqmask)) {
-			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);
-			spurious_irq_mask |= irqmask;
-		}
-		atomic_inc(&irq_err_count);
-		/*
-		 * Theoretically we do not have to handle this IRQ,
-		 * but in Linux this does not cause problems and is
-		 * simpler for us.
-		 */
-		goto handle_real_irq;
-	}
-}
-
-static void i8259A_resume(void)
-{
-	if (i8259A_auto_eoi >= 0)
-		init_8259A(i8259A_auto_eoi);
-}
-
-static void i8259A_shutdown(void)
-{
-	/* Put the i8259A into a quiescent state that
-	 * the kernel initialization code can get it
-	 * out of.
-	 */
-	if (i8259A_auto_eoi >= 0) {
-		outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
-		outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
-	}
-}
-
-static struct syscore_ops i8259_syscore_ops = {
-	.resume = i8259A_resume,
-	.shutdown = i8259A_shutdown,
-};
-
-static int __init i8259A_init_sysfs(void)
-{
-	register_syscore_ops(&i8259_syscore_ops);
-	return 0;
-}
-
-device_initcall(i8259A_init_sysfs);
-
-static void init_8259A(int auto_eoi)
-{
-	unsigned long flags;
-
-	i8259A_auto_eoi = auto_eoi;
-
-	raw_spin_lock_irqsave(&i8259A_lock, flags);
-
-	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
-	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
-
-	/*
-	 * outb_p - this has to work on a wide range of PC hardware.
-	 */
-	outb_p(0x11, PIC_MASTER_CMD);	/* ICW1: select 8259A-1 init */
-	outb_p(I8259A_IRQ_BASE + 0, PIC_MASTER_IMR);	/* ICW2: 8259A-1 IR0 mapped to I8259A_IRQ_BASE + 0x00 */
-	outb_p(1U << PIC_CASCADE_IR, PIC_MASTER_IMR);	/* 8259A-1 (the master) has a slave on IR2 */
-	if (auto_eoi)	/* master does Auto EOI */
-		outb_p(MASTER_ICW4_DEFAULT | PIC_ICW4_AEOI, PIC_MASTER_IMR);
-	else		/* master expects normal EOI */
-		outb_p(MASTER_ICW4_DEFAULT, PIC_MASTER_IMR);
-
-	outb_p(0x11, PIC_SLAVE_CMD);	/* ICW1: select 8259A-2 init */
-	outb_p(I8259A_IRQ_BASE + 8, PIC_SLAVE_IMR);	/* ICW2: 8259A-2 IR0 mapped to I8259A_IRQ_BASE + 0x08 */
-	outb_p(PIC_CASCADE_IR, PIC_SLAVE_IMR);	/* 8259A-2 is a slave on master's IR2 */
-	outb_p(SLAVE_ICW4_DEFAULT, PIC_SLAVE_IMR); /* (slave's support for AEOI in flat mode is to be investigated) */
-	if (auto_eoi)
-		/*
-		 * In AEOI mode we just have to mask the interrupt
-		 * when acking.
-		 */
-		i8259A_chip.irq_mask_ack = disable_8259A_irq;
-	else
-		i8259A_chip.irq_mask_ack = mask_and_ack_8259A;
-
-	udelay(100);		/* wait for 8259A to initialize */
-
-	outb(cached_master_mask, PIC_MASTER_IMR); /* restore master IRQ mask */
-	outb(cached_slave_mask, PIC_SLAVE_IMR);	  /* restore slave IRQ mask */
-
-	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
-}
-
-/*
- * IRQ2 is cascade interrupt to second interrupt controller
- */
-static struct irqaction irq2 = {
-	.handler = no_action,
-	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
-};
-
-static struct resource pic1_io_resource = {
-	.name = "pic1",
-	.start = PIC_MASTER_CMD,
-	.end = PIC_MASTER_IMR,
-	.flags = IORESOURCE_BUSY
-};
-
-static struct resource pic2_io_resource = {
-	.name = "pic2",
-	.start = PIC_SLAVE_CMD,
-	.end = PIC_SLAVE_IMR,
-	.flags = IORESOURCE_BUSY
-};
-
-static int i8259A_irq_domain_map(struct irq_domain *d, unsigned int virq,
-				 irq_hw_number_t hw)
-{
-	irq_set_chip_and_handler(virq, &i8259A_chip, handle_level_irq);
-	irq_set_probe(virq);
-	return 0;
-}
-
-static struct irq_domain_ops i8259A_ops = {
-	.map = i8259A_irq_domain_map,
-	.xlate = irq_domain_xlate_onecell,
-};
-
-/*
- * On systems with i8259-style interrupt controllers we assume for
- * driver compatibility reasons interrupts 0 - 15 to be the i8259
- * interrupts even if the hardware uses a different interrupt numbering.
- */
-struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
-{
-	struct irq_domain *domain;
-
-	insert_resource(&ioport_resource, &pic1_io_resource);
-	insert_resource(&ioport_resource, &pic2_io_resource);
-
-	init_8259A(0);
-
-	domain = irq_domain_add_legacy(node, 16, I8259A_IRQ_BASE, 0,
-				       &i8259A_ops, NULL);
-	if (!domain)
-		panic("Failed to add i8259 IRQ domain");
-
-	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
-	return domain;
-}
-
-void __init init_i8259_irqs(void)
-{
-	__init_i8259_irqs(NULL);
-}
-
-static void i8259_irq_dispatch(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_domain *domain = irq_get_handler_data(irq);
-	int hwirq = i8259_irq();
-
-	if (hwirq < 0)
-		return;
-
-	irq = irq_linear_revmap(domain, hwirq);
-	generic_handle_irq(irq);
-}
-
-int __init i8259_of_init(struct device_node *node, struct device_node *parent)
-{
-	struct irq_domain *domain;
-	unsigned int parent_irq;
-
-	parent_irq = irq_of_parse_and_map(node, 0);
-	if (!parent_irq) {
-		pr_err("Failed to map i8259 parent IRQ\n");
-		return -ENODEV;
-	}
-
-	domain = __init_i8259_irqs(node);
-	irq_set_handler_data(parent_irq, domain);
-	irq_set_chained_handler(parent_irq, i8259_irq_dispatch);
-	return 0;
-}
-IRQCHIP_DECLARE(i8259, "intel,i8259", i8259_of_init);
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 120d815..5b85371 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -61,6 +61,10 @@ config ATMEL_AIC5_IRQ
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
+config I8259
+	bool
+	select IRQ_DOMAIN
+
 config BCM7038_L1_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b8d4e96..f561b5d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
 obj-$(CONFIG_ATMEL_AIC_IRQ)		+= irq-atmel-aic-common.o irq-atmel-aic.o
 obj-$(CONFIG_ATMEL_AIC5_IRQ)	+= irq-atmel-aic-common.o irq-atmel-aic5.o
+obj-$(CONFIG_I8259)			+= irq-i8259.o
 obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
 obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
 obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
new file mode 100644
index 0000000..a29638a
--- /dev/null
+++ b/drivers/irqchip/irq-i8259.c
@@ -0,0 +1,383 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Code to handle x86 style IRQs plus some generic interrupt stuff.
+ *
+ * Copyright (C) 1992 Linus Torvalds
+ * Copyright (C) 1994 - 2000 Ralf Baechle
+ */
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/of_irq.h>
+#include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
+#include <linux/irq.h>
+
+#include <asm/i8259.h>
+#include <asm/io.h>
+
+/*
+ * This is the 'legacy' 8259A Programmable Interrupt Controller,
+ * present in the majority of PC/AT boxes.
+ * plus some generic x86 specific things if generic specifics makes
+ * any sense at all.
+ * this file should become arch/i386/kernel/irq.c when the old irq.c
+ * moves to arch independent land
+ */
+
+static int i8259A_auto_eoi = -1;
+DEFINE_RAW_SPINLOCK(i8259A_lock);
+static void disable_8259A_irq(struct irq_data *d);
+static void enable_8259A_irq(struct irq_data *d);
+static void mask_and_ack_8259A(struct irq_data *d);
+static void init_8259A(int auto_eoi);
+
+static struct irq_chip i8259A_chip = {
+	.name			= "XT-PIC",
+	.irq_mask		= disable_8259A_irq,
+	.irq_disable		= disable_8259A_irq,
+	.irq_unmask		= enable_8259A_irq,
+	.irq_mask_ack		= mask_and_ack_8259A,
+};
+
+/*
+ * 8259A PIC functions to handle ISA devices:
+ */
+
+/*
+ * This contains the irq mask for both 8259A irq controllers,
+ */
+static unsigned int cached_irq_mask = 0xffff;
+
+#define cached_master_mask	(cached_irq_mask)
+#define cached_slave_mask	(cached_irq_mask >> 8)
+
+static void disable_8259A_irq(struct irq_data *d)
+{
+	unsigned int mask, irq = d->irq - I8259A_IRQ_BASE;
+	unsigned long flags;
+
+	mask = 1 << irq;
+	raw_spin_lock_irqsave(&i8259A_lock, flags);
+	cached_irq_mask |= mask;
+	if (irq & 8)
+		outb(cached_slave_mask, PIC_SLAVE_IMR);
+	else
+		outb(cached_master_mask, PIC_MASTER_IMR);
+	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
+}
+
+static void enable_8259A_irq(struct irq_data *d)
+{
+	unsigned int mask, irq = d->irq - I8259A_IRQ_BASE;
+	unsigned long flags;
+
+	mask = ~(1 << irq);
+	raw_spin_lock_irqsave(&i8259A_lock, flags);
+	cached_irq_mask &= mask;
+	if (irq & 8)
+		outb(cached_slave_mask, PIC_SLAVE_IMR);
+	else
+		outb(cached_master_mask, PIC_MASTER_IMR);
+	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
+}
+
+int i8259A_irq_pending(unsigned int irq)
+{
+	unsigned int mask;
+	unsigned long flags;
+	int ret;
+
+	irq -= I8259A_IRQ_BASE;
+	mask = 1 << irq;
+	raw_spin_lock_irqsave(&i8259A_lock, flags);
+	if (irq < 8)
+		ret = inb(PIC_MASTER_CMD) & mask;
+	else
+		ret = inb(PIC_SLAVE_CMD) & (mask >> 8);
+	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
+
+	return ret;
+}
+
+void make_8259A_irq(unsigned int irq)
+{
+	disable_irq_nosync(irq);
+	irq_set_chip_and_handler(irq, &i8259A_chip, handle_level_irq);
+	enable_irq(irq);
+}
+
+/*
+ * This function assumes to be called rarely. Switching between
+ * 8259A registers is slow.
+ * This has to be protected by the irq controller spinlock
+ * before being called.
+ */
+static inline int i8259A_irq_real(unsigned int irq)
+{
+	int value;
+	int irqmask = 1 << irq;
+
+	if (irq < 8) {
+		outb(0x0B, PIC_MASTER_CMD);	/* ISR register */
+		value = inb(PIC_MASTER_CMD) & irqmask;
+		outb(0x0A, PIC_MASTER_CMD);	/* back to the IRR register */
+		return value;
+	}
+	outb(0x0B, PIC_SLAVE_CMD);	/* ISR register */
+	value = inb(PIC_SLAVE_CMD) & (irqmask >> 8);
+	outb(0x0A, PIC_SLAVE_CMD);	/* back to the IRR register */
+	return value;
+}
+
+/*
+ * Careful! The 8259A is a fragile beast, it pretty
+ * much _has_ to be done exactly like this (mask it
+ * first, _then_ send the EOI, and the order of EOI
+ * to the two 8259s is important!
+ */
+static void mask_and_ack_8259A(struct irq_data *d)
+{
+	unsigned int irqmask, irq = d->irq - I8259A_IRQ_BASE;
+	unsigned long flags;
+
+	irqmask = 1 << irq;
+	raw_spin_lock_irqsave(&i8259A_lock, flags);
+	/*
+	 * Lightweight spurious IRQ detection. We do not want
+	 * to overdo spurious IRQ handling - it's usually a sign
+	 * of hardware problems, so we only do the checks we can
+	 * do without slowing down good hardware unnecessarily.
+	 *
+	 * Note that IRQ7 and IRQ15 (the two spurious IRQs
+	 * usually resulting from the 8259A-1|2 PICs) occur
+	 * even if the IRQ is masked in the 8259A. Thus we
+	 * can check spurious 8259A IRQs without doing the
+	 * quite slow i8259A_irq_real() call for every IRQ.
+	 * This does not cover 100% of spurious interrupts,
+	 * but should be enough to warn the user that there
+	 * is something bad going on ...
+	 */
+	if (cached_irq_mask & irqmask)
+		goto spurious_8259A_irq;
+	cached_irq_mask |= irqmask;
+
+handle_real_irq:
+	if (irq & 8) {
+		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
+		outb(cached_slave_mask, PIC_SLAVE_IMR);
+		outb(0x60+(irq&7), PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
+		outb(0x60+PIC_CASCADE_IR, PIC_MASTER_CMD); /* 'Specific EOI' to master-IRQ2 */
+	} else {
+		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
+		outb(cached_master_mask, PIC_MASTER_IMR);
+		outb(0x60+irq, PIC_MASTER_CMD); /* 'Specific EOI to master */
+	}
+	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
+	return;
+
+spurious_8259A_irq:
+	/*
+	 * this is the slow path - should happen rarely.
+	 */
+	if (i8259A_irq_real(irq))
+		/*
+		 * oops, the IRQ _is_ in service according to the
+		 * 8259A - not spurious, go handle it.
+		 */
+		goto handle_real_irq;
+
+	{
+		static int spurious_irq_mask;
+		/*
+		 * At this point we can be sure the IRQ is spurious,
+		 * lets ACK and report it. [once per IRQ]
+		 */
+		if (!(spurious_irq_mask & irqmask)) {
+			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);
+			spurious_irq_mask |= irqmask;
+		}
+		atomic_inc(&irq_err_count);
+		/*
+		 * Theoretically we do not have to handle this IRQ,
+		 * but in Linux this does not cause problems and is
+		 * simpler for us.
+		 */
+		goto handle_real_irq;
+	}
+}
+
+static void i8259A_resume(void)
+{
+	if (i8259A_auto_eoi >= 0)
+		init_8259A(i8259A_auto_eoi);
+}
+
+static void i8259A_shutdown(void)
+{
+	/* Put the i8259A into a quiescent state that
+	 * the kernel initialization code can get it
+	 * out of.
+	 */
+	if (i8259A_auto_eoi >= 0) {
+		outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
+		outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
+	}
+}
+
+static struct syscore_ops i8259_syscore_ops = {
+	.resume = i8259A_resume,
+	.shutdown = i8259A_shutdown,
+};
+
+static int __init i8259A_init_sysfs(void)
+{
+	register_syscore_ops(&i8259_syscore_ops);
+	return 0;
+}
+
+device_initcall(i8259A_init_sysfs);
+
+static void init_8259A(int auto_eoi)
+{
+	unsigned long flags;
+
+	i8259A_auto_eoi = auto_eoi;
+
+	raw_spin_lock_irqsave(&i8259A_lock, flags);
+
+	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
+	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
+
+	/*
+	 * outb_p - this has to work on a wide range of PC hardware.
+	 */
+	outb_p(0x11, PIC_MASTER_CMD);	/* ICW1: select 8259A-1 init */
+	outb_p(I8259A_IRQ_BASE + 0, PIC_MASTER_IMR);	/* ICW2: 8259A-1 IR0 mapped to I8259A_IRQ_BASE + 0x00 */
+	outb_p(1U << PIC_CASCADE_IR, PIC_MASTER_IMR);	/* 8259A-1 (the master) has a slave on IR2 */
+	if (auto_eoi)	/* master does Auto EOI */
+		outb_p(MASTER_ICW4_DEFAULT | PIC_ICW4_AEOI, PIC_MASTER_IMR);
+	else		/* master expects normal EOI */
+		outb_p(MASTER_ICW4_DEFAULT, PIC_MASTER_IMR);
+
+	outb_p(0x11, PIC_SLAVE_CMD);	/* ICW1: select 8259A-2 init */
+	outb_p(I8259A_IRQ_BASE + 8, PIC_SLAVE_IMR);	/* ICW2: 8259A-2 IR0 mapped to I8259A_IRQ_BASE + 0x08 */
+	outb_p(PIC_CASCADE_IR, PIC_SLAVE_IMR);	/* 8259A-2 is a slave on master's IR2 */
+	outb_p(SLAVE_ICW4_DEFAULT, PIC_SLAVE_IMR); /* (slave's support for AEOI in flat mode is to be investigated) */
+	if (auto_eoi)
+		/*
+		 * In AEOI mode we just have to mask the interrupt
+		 * when acking.
+		 */
+		i8259A_chip.irq_mask_ack = disable_8259A_irq;
+	else
+		i8259A_chip.irq_mask_ack = mask_and_ack_8259A;
+
+	udelay(100);		/* wait for 8259A to initialize */
+
+	outb(cached_master_mask, PIC_MASTER_IMR); /* restore master IRQ mask */
+	outb(cached_slave_mask, PIC_SLAVE_IMR);	  /* restore slave IRQ mask */
+
+	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
+}
+
+/*
+ * IRQ2 is cascade interrupt to second interrupt controller
+ */
+static struct irqaction irq2 = {
+	.handler = no_action,
+	.name = "cascade",
+	.flags = IRQF_NO_THREAD,
+};
+
+static struct resource pic1_io_resource = {
+	.name = "pic1",
+	.start = PIC_MASTER_CMD,
+	.end = PIC_MASTER_IMR,
+	.flags = IORESOURCE_BUSY
+};
+
+static struct resource pic2_io_resource = {
+	.name = "pic2",
+	.start = PIC_SLAVE_CMD,
+	.end = PIC_SLAVE_IMR,
+	.flags = IORESOURCE_BUSY
+};
+
+static int i8259A_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				 irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &i8259A_chip, handle_level_irq);
+	irq_set_probe(virq);
+	return 0;
+}
+
+static struct irq_domain_ops i8259A_ops = {
+	.map = i8259A_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+/*
+ * On systems with i8259-style interrupt controllers we assume for
+ * driver compatibility reasons interrupts 0 - 15 to be the i8259
+ * interrupts even if the hardware uses a different interrupt numbering.
+ */
+struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
+{
+	struct irq_domain *domain;
+
+	insert_resource(&ioport_resource, &pic1_io_resource);
+	insert_resource(&ioport_resource, &pic2_io_resource);
+
+	init_8259A(0);
+
+	domain = irq_domain_add_legacy(node, 16, I8259A_IRQ_BASE, 0,
+				       &i8259A_ops, NULL);
+	if (!domain)
+		panic("Failed to add i8259 IRQ domain");
+
+	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
+	return domain;
+}
+
+void __init init_i8259_irqs(void)
+{
+	__init_i8259_irqs(NULL);
+}
+
+static void i8259_irq_dispatch(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_domain *domain = irq_get_handler_data(irq);
+	int hwirq = i8259_irq();
+
+	if (hwirq < 0)
+		return;
+
+	irq = irq_linear_revmap(domain, hwirq);
+	generic_handle_irq(irq);
+}
+
+int __init i8259_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	unsigned int parent_irq;
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq) {
+		pr_err("Failed to map i8259 parent IRQ\n");
+		return -ENODEV;
+	}
+
+	domain = __init_i8259_irqs(node);
+	irq_set_handler_data(parent_irq, domain);
+	irq_set_chained_handler(parent_irq, i8259_irq_dispatch);
+	return 0;
+}
+IRQCHIP_DECLARE(i8259, "intel,i8259", i8259_of_init);
