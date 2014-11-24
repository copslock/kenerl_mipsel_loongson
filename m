Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 03:43:02 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:42579 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006776AbaKXClJMROzt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 03:41:09 +0100
Received: by mail-pa0-f52.google.com with SMTP id eu11so8617406pac.11
        for <multiple recipients>; Sun, 23 Nov 2014 18:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QGhgaCz+cRAEHhwlutacC/EMx6BeA1NK89CYTigfSyE=;
        b=rI5tdl0rx2cn3r/YPwRTCYu+UU+Bl9HxqSLaPg73qWJB+LXk8l/ns5ZBUE003PGdJq
         kR5svVcaBlCYPLyTSguJtMGuKYd0aTJQJYgBn+d4jJm/Vp5MDEJB9g3NX0VscMjuVsVm
         9aGVqVg9Zo8TpzhYxKRzSJ7M4F3w3coMaDOUI32iPrDt+WUxvi/nkFDPy+px46W2P8o6
         IZDyAWssYpOE6L6TlJKE9jB1fyBuY12wApFJXYMJ+6dI8gTIJkIYb/20zli8Kivcq0r3
         ao/G0/XIp0aMsrd4q0GxwZY+hEiDkwMoxXuuUXR/iIiX28C2+6W4QfMyWlTSit0wqM9d
         ZMQw==
X-Received: by 10.70.130.73 with SMTP id oc9mr3004166pdb.42.1416796862810;
        Sun, 23 Nov 2014 18:41:02 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id ml5sm10930673pab.32.2014.11.23.18.41.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Nov 2014 18:41:02 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 07/11] irqchip: Add new driver for BCM7038-style level 1 interrupt controllers
Date:   Sun, 23 Nov 2014 18:40:42 -0800
Message-Id: <1416796846-28149-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This is the main peripheral IRQ controller on the BCM7xxx MIPS chips;
it has the following characteristics:

 - 64 to 160+ level IRQs
 - Atomic set/clear registers
 - Reasonably predictable register layout (N status words, then N
   mask status words, then N mask set words, then N mask clear words)
 - SMP affinity supported on most systems
 - Typically connected to MIPS IRQ 2,3,2,3 on CPUs 0,1,2,3

This driver registers one IRQ domain and one IRQ chip to cover all
instances of the block.  Up to 4 instances of the block may appear, as
it supports 4-way IRQ affinity on BCM7435.

The same block exists on the ARM BCM7xxx chips, but typically the ARM GIC
is used instead.  So this driver is primarily intended for MIPS STB chips.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../interrupt-controller/brcm,bcm7038-l1-intc.txt  |  52 ++++
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-bcm7038-l1.c                   | 335 +++++++++++++++++++++
 4 files changed, 393 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
 create mode 100644 drivers/irqchip/irq-bcm7038-l1.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
new file mode 100644
index 000000000000..cc217b22dccd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
@@ -0,0 +1,52 @@
+Broadcom BCM7038-style Level 1 interrupt controller
+
+This block is a first level interrupt controller that is typically connected
+directly to one of the HW INT lines on each CPU.  Every BCM7xxx set-top chip
+since BCM7038 has contained this hardware.
+
+Key elements of the hardware design include:
+
+- 64, 96, 128, or 160 incoming level IRQ lines
+
+- Most onchip peripherals are wired directly to an L1 input
+
+- A separate instance of the register set for each CPU, allowing individual
+  peripheral IRQs to be routed to any CPU
+
+- Atomic mask/unmask operations
+
+- No polarity/level/edge settings
+
+- No FIFO or priority encoder logic; software is expected to read all
+  2-5 status words to determine which IRQs are pending
+
+Required properties:
+
+- compatible: should be "brcm,bcm7038-l1-intc"
+- reg: specifies the base physical address and size of the registers;
+  the number of supported IRQs is inferred from the size argument
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 1.
+- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
+  this one is cascaded from
+- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
+  node; valid values depend on the type of parent interrupt controller
+
+If multiple reg ranges and interrupt-parent entries are present on an SMP
+system, the driver will allow IRQ SMP affinity to be set up through the
+/proc/irq/ interface.  In the simplest possible configuration, only one
+reg range and one interrupt-parent is needed.
+
+Example:
+
+periph_intc: periph_intc@1041a400 {
+        compatible = "brcm,bcm7038-l1-intc";
+        reg = <0x1041a400 0x30 0x1041a600 0x30>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        interrupt-parent = <&cpu_intc>;
+        interrupts = <2>, <3>;
+};
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 018f884aa3b0..89ee92b8b94c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -48,6 +48,11 @@ config ATMEL_AIC5_IRQ
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
+config BCM7038_L1_IRQ
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config BCM7120_L2_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 4954a314c31e..446ae7a98f7a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
 obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
 obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
 obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
+obj-$(CONFIG_BCM7038_L1_IRQ)		+= irq-bcm7038-l1.o
 obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
 obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
new file mode 100644
index 000000000000..d3b8c8be15f6
--- /dev/null
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -0,0 +1,335 @@
+/*
+ * Broadcom BCM7038 style Level 1 interrupt controller driver
+ *
+ * Copyright (C) 2014 Broadcom Corporation
+ * Author: Kevin Cernekee
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME	": " fmt
+
+#include <linux/bitops.h>
+#include <linux/kconfig.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+#include <linux/irqchip/chained_irq.h>
+
+#include "irqchip.h"
+
+#define IRQS_PER_WORD		32
+#define REG_BYTES_PER_IRQ_WORD	(sizeof(u32) * 4)
+#define MAX_WORDS		8
+
+struct bcm7038_l1_cpu;
+
+struct bcm7038_l1_chip {
+	raw_spinlock_t		lock;
+	unsigned int		n_words;
+	struct irq_domain	*domain;
+	struct bcm7038_l1_cpu	*cpus[NR_CPUS];
+	u8			affinity[MAX_WORDS * IRQS_PER_WORD];
+};
+
+struct bcm7038_l1_cpu {
+	void __iomem		*map_base;
+	u32			mask_cache[0];
+};
+
+/*
+ * STATUS/MASK_STATUS/MASK_SET/MASK_CLEAR are packed one right after another:
+ *
+ * 7038:
+ *   0x1000_1400: W0_STATUS
+ *   0x1000_1404: W1_STATUS
+ *   0x1000_1408: W0_MASK_STATUS
+ *   0x1000_140c: W1_MASK_STATUS
+ *   0x1000_1410: W0_MASK_SET
+ *   0x1000_1414: W1_MASK_SET
+ *   0x1000_1418: W0_MASK_CLEAR
+ *   0x1000_141c: W1_MASK_CLEAR
+ *
+ * 7445:
+ *   0xf03e_1500: W0_STATUS
+ *   0xf03e_1504: W1_STATUS
+ *   0xf03e_1508: W2_STATUS
+ *   0xf03e_150c: W3_STATUS
+ *   0xf03e_1510: W4_STATUS
+ *   0xf03e_1514: W0_MASK_STATUS
+ *   0xf03e_1518: W1_MASK_STATUS
+ *   [...]
+ */
+
+static inline unsigned int reg_status(struct bcm7038_l1_chip *intc,
+				      unsigned int word)
+{
+	return (0 * intc->n_words + word) * sizeof(u32);
+}
+
+static inline unsigned int reg_mask_status(struct bcm7038_l1_chip *intc,
+					   unsigned int word)
+{
+	return (1 * intc->n_words + word) * sizeof(u32);
+}
+
+static inline unsigned int reg_mask_set(struct bcm7038_l1_chip *intc,
+					unsigned int word)
+{
+	return (2 * intc->n_words + word) * sizeof(u32);
+}
+
+static inline unsigned int reg_mask_clr(struct bcm7038_l1_chip *intc,
+					unsigned int word)
+{
+	return (3 * intc->n_words + word) * sizeof(u32);
+}
+
+static inline u32 l1_readl(void __iomem *reg)
+{
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		return ioread32be(reg);
+	else
+		return readl(reg);
+}
+
+static inline void l1_writel(u32 val, void __iomem *reg)
+{
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		iowrite32be(val, reg);
+	else
+		writel(val, reg);
+}
+
+static void bcm7038_l1_irq_handle(unsigned int irq, struct irq_desc *desc)
+{
+	struct bcm7038_l1_chip *intc = irq_desc_get_handler_data(desc);
+	struct bcm7038_l1_cpu *cpu;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int idx;
+
+#ifdef CONFIG_SMP
+	cpu = intc->cpus[cpu_logical_map(smp_processor_id())];
+#else
+	cpu = intc->cpus[0];
+#endif
+
+	chained_irq_enter(chip, desc);
+
+	for (idx = 0; idx < intc->n_words; idx++) {
+		int base = idx * IRQS_PER_WORD;
+		unsigned long pending, flags;
+		int hwirq;
+
+		raw_spin_lock_irqsave(&intc->lock, flags);
+		pending = l1_readl(cpu->map_base + reg_status(intc, idx)) &
+			  ~cpu->mask_cache[idx];
+		raw_spin_unlock_irqrestore(&intc->lock, flags);
+
+		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
+			generic_handle_irq(irq_find_mapping(intc->domain,
+							    base + hwirq));
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void __bcm7038_l1_unmask(struct irq_data *d, unsigned int cpu_idx)
+{
+	struct bcm7038_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	u32 word = d->hwirq / IRQS_PER_WORD;
+	u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
+
+	intc->cpus[cpu_idx]->mask_cache[word] &= ~mask;
+	l1_writel(mask, intc->cpus[cpu_idx]->map_base +
+			reg_mask_clr(intc, word));
+}
+
+static void __bcm7038_l1_mask(struct irq_data *d, unsigned int cpu_idx)
+{
+	struct bcm7038_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	u32 word = d->hwirq / IRQS_PER_WORD;
+	u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
+
+	intc->cpus[cpu_idx]->mask_cache[word] |= mask;
+	l1_writel(mask, intc->cpus[cpu_idx]->map_base +
+			reg_mask_set(intc, word));
+}
+
+static void bcm7038_l1_unmask(struct irq_data *d)
+{
+	struct bcm7038_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&intc->lock, flags);
+	__bcm7038_l1_unmask(d, intc->affinity[d->hwirq]);
+	raw_spin_unlock_irqrestore(&intc->lock, flags);
+}
+
+static void bcm7038_l1_mask(struct irq_data *d)
+{
+	struct bcm7038_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&intc->lock, flags);
+	__bcm7038_l1_mask(d, intc->affinity[d->hwirq]);
+	raw_spin_unlock_irqrestore(&intc->lock, flags);
+}
+
+static int bcm7038_l1_set_affinity(struct irq_data *d,
+				   const struct cpumask *dest,
+				   bool force)
+{
+	struct bcm7038_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	irq_hw_number_t hw = d->hwirq;
+	u32 word = hw / IRQS_PER_WORD;
+	u32 mask = BIT(hw % IRQS_PER_WORD);
+	unsigned int first_cpu = cpumask_any_and(dest, cpu_online_mask);
+	bool was_disabled;
+
+	raw_spin_lock_irqsave(&intc->lock, flags);
+
+	was_disabled = !!(intc->cpus[intc->affinity[hw]]->mask_cache[word] &
+			  mask);
+	__bcm7038_l1_mask(d, intc->affinity[hw]);
+	intc->affinity[hw] = first_cpu;
+	if (!was_disabled)
+		__bcm7038_l1_unmask(d, first_cpu);
+
+	raw_spin_unlock_irqrestore(&intc->lock, flags);
+	return 0;
+}
+
+static int __init bcm7038_l1_init_one(struct device_node *dn,
+				      unsigned int idx,
+				      struct bcm7038_l1_chip *intc)
+{
+	struct resource res;
+	resource_size_t sz;
+	struct bcm7038_l1_cpu *cpu;
+	unsigned int i, n_words, parent_irq;
+
+	if (of_address_to_resource(dn, idx, &res))
+		return -EINVAL;
+	sz = resource_size(&res);
+	n_words = sz / REG_BYTES_PER_IRQ_WORD;
+
+	if (n_words > MAX_WORDS)
+		return -EINVAL;
+	else if (!intc->n_words)
+		intc->n_words = n_words;
+	else if (intc->n_words != n_words)
+		return -EINVAL;
+
+	cpu = intc->cpus[idx] = kzalloc(sizeof(*cpu) + n_words * sizeof(u32),
+					GFP_KERNEL);
+	if (!cpu)
+		return -ENOMEM;
+
+	cpu->map_base = ioremap(res.start, sz);
+	if (!cpu->map_base)
+		return -ENOMEM;
+
+	for (i = 0; i < n_words; i++) {
+		l1_writel(0xffffffff, cpu->map_base + reg_mask_set(intc, i));
+		cpu->mask_cache[i] = 0xffffffff;
+	}
+
+	parent_irq = irq_of_parse_and_map(dn, idx);
+	if (!parent_irq) {
+		pr_err("failed to map parent interrupt %d\n", parent_irq);
+		return -EINVAL;
+	}
+	irq_set_handler_data(parent_irq, intc);
+	irq_set_chained_handler(parent_irq, bcm7038_l1_irq_handle);
+
+	return 0;
+}
+
+static struct irq_chip bcm7038_l1_irq_chip = {
+	.name			= "bcm7038-l1",
+	.irq_mask		= bcm7038_l1_mask,
+	.irq_unmask		= bcm7038_l1_unmask,
+	.irq_set_affinity	= bcm7038_l1_set_affinity,
+};
+
+static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,
+			  irq_hw_number_t hw_irq)
+{
+	irq_set_chip_and_handler(virq, &bcm7038_l1_irq_chip, handle_level_irq);
+	irq_set_chip_data(virq, d->host_data);
+	return 0;
+}
+
+static const struct irq_domain_ops bcm7038_l1_domain_ops = {
+	.xlate			= irq_domain_xlate_onecell,
+	.map			= bcm7038_l1_map,
+};
+
+int __init bcm7038_l1_of_init(struct device_node *dn,
+			      struct device_node *parent)
+{
+	struct bcm7038_l1_chip *intc;
+	int idx, ret;
+
+	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
+	if (!intc)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&intc->lock);
+	for_each_possible_cpu(idx) {
+		ret = bcm7038_l1_init_one(dn, idx, intc);
+		if (ret < 0) {
+			if (idx)
+				break;
+			pr_err("failed to remap intc L1 registers\n");
+			goto out_free;
+		}
+	}
+
+	intc->domain = irq_domain_add_linear(dn, IRQS_PER_WORD * intc->n_words,
+					     &bcm7038_l1_domain_ops,
+					     intc);
+	if (!intc->domain) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
+		intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
+
+	return 0;
+
+out_unmap:
+	for_each_possible_cpu(idx) {
+		struct bcm7038_l1_cpu *cpu = intc->cpus[idx];
+
+		if (cpu) {
+			if (cpu->map_base)
+				iounmap(cpu->map_base);
+			kfree(cpu);
+		}
+	}
+out_free:
+	kfree(intc);
+	return ret;
+}
+
+IRQCHIP_DECLARE(bcm7038_l1, "brcm,bcm7038-l1-intc", bcm7038_l1_of_init);
-- 
2.1.1
