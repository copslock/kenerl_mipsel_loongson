Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Nov 2015 17:53:57 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:49014 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012495AbbKOQxy5mCCS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 Nov 2015 17:53:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=JlzRLP/LkP86AUUkLpgDp/H0TdWkqmQdKRNNVYozroA=;
        b=ptcSQcBJdUXdlGVp94aoucqCY5tjjHa+4K3iL4eJSyJlDB6iVzAIYPxdLKl0Fu/c214jiK/E5CUvixKQBQPYpR+eRehGlwAdf7p2KWJOkg5xuZbhyErf8Prregn4kLiN9J75wstssV2ty0cpda1ejl0P9IO377Cp/EmA//N18FMEIWbcXSt0LXMjVDmLQ8JZ9Lu4NxapsUuCEzbjauCYDlQiseGm6+wYXYPXvmXrG8dTDQw4etGnAiqYqZEq5GQYTlg+hj0l6E9faOa9SHrMoxUCzjtmJiAAScPJO3JZLLRVr6ypWmn5ipmd7OgdwS+ONbe7X40CW7vO7LAfIe6MjA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:39858 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1Zy0Ym-0008Iw-7D (Exim); Sun, 15 Nov 2015 16:53:48 +0000
Subject: [PATCH 2/2] MIPS: bmips: Add bcm63168-l1 interrupt controller
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
References: <5648B804.40806@simon.arlott.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5648B89A.8080203@simon.arlott.org.uk>
Date:   Sun, 15 Nov 2015 16:53:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5648B804.40806@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

Add the BCM63168 interrupt controller based on the SMP-capable BCM7038
and the BCM3380 but with packed interrupt registers.

Add the BCM63168 interrupt controller to a list with the existing BCM7038
so that interrupts on CPU1 are not ignored.

Update the maintainers file list for BMIPS to include this driver.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 MAINTAINERS                       |   1 +
 arch/mips/Kconfig                 |   1 +
 arch/mips/bmips/irq.c             |  10 +-
 drivers/irqchip/Kconfig           |   5 +
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-bcm63168-l1.c | 372 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 388 insertions(+), 2 deletions(-)
 create mode 100644 drivers/irqchip/irq-bcm63168-l1.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b..63bf54a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2373,6 +2373,7 @@ F:	arch/mips/bmips/*
 F:	arch/mips/include/asm/mach-bmips/*
 F:	arch/mips/kernel/*bmips*
 F:	arch/mips/boot/dts/brcm/bcm*.dts*
+F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0..1a8decd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -149,6 +149,7 @@ config BMIPS_GENERIC
 	select CSRC_R4K
 	select SYNC_R4K
 	select COMMON_CLK
+	select BCM63168_L1_IRQ
 	select BCM7038_L1_IRQ
 	select BCM7120_L2_IRQ
 	select BRCMSTB_L2_IRQ
diff --git a/arch/mips/bmips/irq.c b/arch/mips/bmips/irq.c
index e7fc6f934..7983cef 100644
--- a/arch/mips/bmips/irq.c
+++ b/arch/mips/bmips/irq.c
@@ -15,6 +15,12 @@
 #include <asm/irq_cpu.h>
 #include <asm/time.h>
 
+static const struct of_device_id smp_intc_dt_match[] = {
+	{ .compatible = "brcm,bcm7038-l1-intc" },
+	{ .compatible = "brcm,bcm63168-l1-intc" },
+	{}
+};
+
 unsigned int get_c0_compare_int(void)
 {
 	return CP0_LEGACY_COMPARE_IRQ;
@@ -24,8 +30,8 @@ void __init arch_init_irq(void)
 {
 	struct device_node *dn;
 
-	/* Only the STB (bcm7038) controller supports SMP IRQ affinity */
-	dn = of_find_compatible_node(NULL, NULL, "brcm,bcm7038-l1-intc");
+	/* Only these controllers support SMP IRQ affinity */
+	dn = of_find_matching_node(NULL, smp_intc_dt_match);
 	if (dn)
 		of_node_put(dn);
 	else
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4d7294e..82ce318 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -65,6 +65,11 @@ config I8259
 	bool
 	select IRQ_DOMAIN
 
+config BCM63168_L1_IRQ
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config BCM7038_L1_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 177f78f..a3a21e2 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
 obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
 obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
 obj-$(CONFIG_SOC_VF610)			+= irq-vf610-mscm-ir.o
+obj-$(CONFIG_BCM63168_L1_IRQ)		+= irq-bcm63168-l1.o
 obj-$(CONFIG_BCM7038_L1_IRQ)		+= irq-bcm7038-l1.o
 obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
 obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
diff --git a/drivers/irqchip/irq-bcm63168-l1.c b/drivers/irqchip/irq-bcm63168-l1.c
new file mode 100644
index 0000000..5a144af
--- /dev/null
+++ b/drivers/irqchip/irq-bcm63168-l1.c
@@ -0,0 +1,372 @@
+/*
+ * Broadcom BCM63168 style Level 1 interrupt controller driver
+ *
+ * Copyright (C) 2014 Broadcom Corporation
+ * Copyright 2015 Simon Arlott
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This is based on the BCM7038 (which supports SMP) but with a single
+ * enable register instead of separate mask/set/clear registers.
+ *
+ * The BCM3380 has a similar mask/status register layout, but each pair
+ * of words is at separate locations (and SMP is not supported).
+ *
+ * ENABLE/STATUS words are packed next to each other for each CPU:
+ *
+ * 6368:
+ *   0x1000_0020: CPU0_W0_ENABLE
+ *   0x1000_0024: CPU0_W1_ENABLE
+ *   0x1000_0028: CPU0_W0_STATUS		IRQs 31-63
+ *   0x1000_002c: CPU0_W1_STATUS		IRQs 0-31
+ *   0x1000_0030: CPU1_W0_ENABLE
+ *   0x1000_0034: CPU1_W1_ENABLE
+ *   0x1000_0038: CPU1_W0_STATUS		IRQs 31-63
+ *   0x1000_003c: CPU1_W1_STATUS		IRQs 0-31
+ *
+ * 63168:
+ *   0x1000_0020: CPU0_W0_ENABLE
+ *   0x1000_0024: CPU0_W1_ENABLE
+ *   0x1000_0028: CPU0_W2_ENABLE
+ *   0x1000_002c: CPU0_W3_ENABLE
+ *   0x1000_0030: CPU0_W0_STATUS	IRQs 96-127
+ *   0x1000_0034: CPU0_W1_STATUS	IRQs 64-95
+ *   0x1000_0038: CPU0_W2_STATUS	IRQs 32-63
+ *   0x1000_003c: CPU0_W3_STATUS	IRQs 0-31
+ *   0x1000_0040: CPU1_W0_ENABLE
+ *   0x1000_0044: CPU1_W1_ENABLE
+ *   0x1000_0048: CPU1_W2_ENABLE
+ *   0x1000_004c: CPU1_W3_ENABLE
+ *   0x1000_0050: CPU1_W0_STATUS	IRQs 96-127
+ *   0x1000_0054: CPU1_W1_STATUS	IRQs 64-95
+ *   0x1000_0058: CPU1_W2_STATUS	IRQs 32-63
+ *   0x1000_005c: CPU1_W3_STATUS	IRQs 0-31
+ *
+ * IRQs are numbered in CPU native endian order
+ * (which is big-endian in these examples)
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME	": " fmt
+
+#include <linux/bitops.h>
+#include <linux/cpumask.h>
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
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+
+#define IRQS_PER_WORD		32
+#define REG_BYTES_PER_IRQ_WORD	(sizeof(u32) * 2)
+#define MAX_WORDS		4
+
+struct bcm63168_l1_cpu;
+
+struct bcm63168_l1_chip {
+	raw_spinlock_t		lock[MAX_WORDS];
+	unsigned int		n_words;
+	struct irq_domain	*domain;
+	struct cpumask		cpumask;
+	struct bcm63168_l1_cpu	*cpus[NR_CPUS];
+};
+
+struct bcm63168_l1_cpu {
+	void __iomem		*map_base;
+	unsigned int		parent_irq;
+	u32			enable_cache[];
+};
+
+static inline unsigned int reg_enable(struct bcm63168_l1_chip *intc,
+					   unsigned int word)
+{
+#ifdef __BIG_ENDIAN
+	return (1 * intc->n_words - word - 1) * sizeof(u32);
+#else
+	return (0 * intc->n_words + word) * sizeof(u32);
+#endif
+}
+
+static inline unsigned int reg_status(struct bcm63168_l1_chip *intc,
+				      unsigned int word)
+{
+#ifdef __BIG_ENDIAN
+	return (2 * intc->n_words - word - 1) * sizeof(u32);
+#else
+	return (1 * intc->n_words + word) * sizeof(u32);
+#endif
+}
+
+static inline unsigned int cpu_for_irq(struct bcm63168_l1_chip *intc,
+					struct irq_data *d)
+{
+	return cpumask_first_and(&intc->cpumask, irq_data_get_affinity_mask(d));
+}
+
+static void bcm63168_l1_irq_handle(struct irq_desc *desc)
+{
+	struct bcm63168_l1_chip *intc = irq_desc_get_handler_data(desc);
+	struct bcm63168_l1_cpu *cpu;
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
+		unsigned long pending;
+		irq_hw_number_t hwirq;
+		unsigned int irq;
+
+		pending = __raw_readl(cpu->map_base + reg_status(intc, idx));
+		pending &= __raw_readl(cpu->map_base + reg_enable(intc, idx));
+
+		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
+			irq = irq_linear_revmap(intc->domain, base + hwirq);
+			if (irq)
+				do_IRQ(irq);
+			else
+				spurious_interrupt();
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static inline void __bcm63168_l1_unmask(struct irq_data *d)
+{
+	struct bcm63168_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	u32 word = d->hwirq / IRQS_PER_WORD;
+	u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
+	unsigned int cpu_idx = cpu_for_irq(intc, d);
+
+	intc->cpus[cpu_idx]->enable_cache[word] |= mask;
+	__raw_writel(intc->cpus[cpu_idx]->enable_cache[word],
+		intc->cpus[cpu_idx]->map_base + reg_enable(intc, word));
+}
+
+static inline void __bcm63168_l1_mask(struct irq_data *d)
+{
+	struct bcm63168_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	u32 word = d->hwirq / IRQS_PER_WORD;
+	u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
+	unsigned int cpu_idx = cpu_for_irq(intc, d);
+
+	intc->cpus[cpu_idx]->enable_cache[word] &= ~mask;
+	__raw_writel(intc->cpus[cpu_idx]->enable_cache[word],
+		intc->cpus[cpu_idx]->map_base + reg_enable(intc, word));
+}
+
+static void bcm63168_l1_unmask(struct irq_data *d)
+{
+	struct bcm63168_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	u32 word = d->hwirq / IRQS_PER_WORD;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&intc->lock[word], flags);
+	__bcm63168_l1_unmask(d);
+	raw_spin_unlock_irqrestore(&intc->lock[word], flags);
+}
+
+static void bcm63168_l1_mask(struct irq_data *d)
+{
+	struct bcm63168_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	u32 word = d->hwirq / IRQS_PER_WORD;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&intc->lock[word], flags);
+	__bcm63168_l1_mask(d);
+	raw_spin_unlock_irqrestore(&intc->lock[word], flags);
+}
+
+static int bcm63168_l1_set_affinity(struct irq_data *d,
+				   const struct cpumask *dest,
+				   bool force)
+{
+	struct bcm63168_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	u32 word = d->hwirq / IRQS_PER_WORD;
+	u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
+	unsigned int old_cpu = cpu_for_irq(intc, d);
+	unsigned int new_cpu;
+	struct cpumask valid;
+	unsigned long flags;
+	bool enabled;
+
+	if (!cpumask_and(&valid, &intc->cpumask, dest))
+		return -EINVAL;
+
+	new_cpu = cpumask_any_and(&valid, cpu_online_mask);
+	if (new_cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	dest = cpumask_of(new_cpu);
+
+	raw_spin_lock_irqsave(&intc->lock[word], flags);
+	if (old_cpu != new_cpu) {
+		enabled = intc->cpus[old_cpu]->enable_cache[word] & mask;
+		if (enabled)
+			__bcm63168_l1_mask(d);
+		cpumask_copy(irq_data_get_affinity_mask(d), dest);
+		if (enabled)
+			__bcm63168_l1_unmask(d);
+	} else {
+		cpumask_copy(irq_data_get_affinity_mask(d), dest);
+	}
+	raw_spin_unlock_irqrestore(&intc->lock[word], flags);
+
+	return IRQ_SET_MASK_OK_NOCOPY;
+}
+
+static int __init bcm63168_l1_init_one(struct device_node *dn,
+				      unsigned int idx,
+				      struct bcm63168_l1_chip *intc)
+{
+	struct resource res;
+	resource_size_t sz;
+	struct bcm63168_l1_cpu *cpu;
+	unsigned int i, n_words;
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
+		cpu->enable_cache[i] = 0;
+		__raw_writel(0, cpu->map_base + reg_enable(intc, i));
+	}
+
+	cpu->parent_irq = irq_of_parse_and_map(dn, idx);
+	if (!cpu->parent_irq) {
+		pr_err("failed to map parent interrupt %d\n", cpu->parent_irq);
+		return -EINVAL;
+	}
+	irq_set_chained_handler_and_data(cpu->parent_irq,
+						bcm63168_l1_irq_handle, intc);
+
+	return 0;
+}
+
+static struct irq_chip bcm63168_l1_irq_chip = {
+	.name			= "bcm63168-l1",
+	.irq_mask		= bcm63168_l1_mask,
+	.irq_unmask		= bcm63168_l1_unmask,
+	.irq_set_affinity	= bcm63168_l1_set_affinity,
+};
+
+static int bcm63168_l1_map(struct irq_domain *d, unsigned int virq,
+			  irq_hw_number_t hw_irq)
+{
+	irq_set_chip_and_handler(virq,
+		&bcm63168_l1_irq_chip, handle_percpu_irq);
+	irq_set_chip_data(virq, d->host_data);
+	return 0;
+}
+
+static const struct irq_domain_ops bcm63168_l1_domain_ops = {
+	.xlate			= irq_domain_xlate_onecell,
+	.map			= bcm63168_l1_map,
+};
+
+static int __init bcm63168_l1_of_init(struct device_node *dn,
+			      struct device_node *parent)
+{
+	struct bcm63168_l1_chip *intc;
+	unsigned int idx;
+	int ret;
+
+	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
+	if (!intc)
+		return -ENOMEM;
+
+	cpumask_clear(&intc->cpumask);
+
+	for_each_possible_cpu(idx) {
+		ret = bcm63168_l1_init_one(dn, idx, intc);
+		if (ret)
+			pr_err("failed to init intc L1 for cpu %d: %d\n",
+				idx, ret);
+		else
+			cpumask_set_cpu(idx, &intc->cpumask);
+	}
+
+	if (!cpumask_weight(&intc->cpumask)) {
+		ret = -ENODEV;
+		goto out_free;
+	}
+
+	for (idx = 0; idx < intc->n_words; idx++)
+		raw_spin_lock_init(&intc->lock[idx]);
+
+	intc->domain = irq_domain_add_linear(dn, IRQS_PER_WORD * intc->n_words,
+					     &bcm63168_l1_domain_ops,
+					     intc);
+	if (!intc->domain) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	pr_info("registered BCM63168 L1 intc (IRQs: %d)\n",
+			IRQS_PER_WORD * intc->n_words);
+	for_each_cpu(idx, &intc->cpumask) {
+		struct bcm63168_l1_cpu *cpu = intc->cpus[idx];
+
+		pr_info("  CPU%u at MMIO 0x%p (irq = %d)\n", idx,
+				cpu->map_base, cpu->parent_irq);
+	}
+
+	return 0;
+
+out_unmap:
+	for_each_possible_cpu(idx) {
+		struct bcm63168_l1_cpu *cpu = intc->cpus[idx];
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
+IRQCHIP_DECLARE(bcm63168_l1, "brcm,bcm63168-l1-intc", bcm63168_l1_of_init);
-- 
2.1.4

-- 
Simon Arlott
