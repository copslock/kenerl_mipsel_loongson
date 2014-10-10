Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 11:34:13 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:48906
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011062AbaJJJeLgdScN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 11:34:11 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/2] MIPS: ralink: add gic support
Date:   Fri, 10 Oct 2014 11:34:04 +0200
Message-Id: <1412933645-55061-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43196
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

The mt7621 has a GIC. rather than handle both irq coree in one file we add a
secondary irq-gic.c.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/irq.h |    9 +
 arch/mips/ralink/Kconfig                |    5 +
 arch/mips/ralink/Makefile               |    5 +-
 arch/mips/ralink/irq-gic.c              |  277 +++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/mach-ralink/irq.h
 create mode 100644 arch/mips/ralink/irq-gic.c

diff --git a/arch/mips/include/asm/mach-ralink/irq.h b/arch/mips/include/asm/mach-ralink/irq.h
new file mode 100644
index 0000000..4321865
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/irq.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_MACH_RALINK_IRQ_H
+#define __ASM_MACH_RALINK_IRQ_H
+
+#define GIC_NUM_INTRS	64
+#define NR_IRQS 256
+
+#include_next <irq.h>
+
+#endif
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 5aaa97e..ca31156 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -7,6 +7,11 @@ config CLKEVT_RT3352
 	select CLKSRC_OF
 	select CLKSRC_MMIO
 
+config IRQ_INTC
+	bool
+	default y
+	depends on !SOC_MT7621
+
 choice
 	prompt "Ralink SoC selection"
 	default SOC_RT305X
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index fc57c16..7bf1b96 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -6,12 +6,15 @@
 # Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
 # Copyright (C) 2013 John Crispin <blogic@openwrt.org>
 
-obj-y := prom.o of.o reset.o clk.o irq.o timer.o
+obj-y := prom.o of.o reset.o clk.o timer.o
 
 obj-$(CONFIG_CLKEVT_RT3352) += cevt-rt3352.o
 
 obj-$(CONFIG_RALINK_ILL_ACC) += ill_acc.o
 
+obj-$(CONFIG_IRQ_INTC) += irq.o
+obj-$(CONFIG_IRQ_GIC) += irq-gic.o
+
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
 obj-$(CONFIG_SOC_RT3883) += rt3883.o
diff --git a/arch/mips/ralink/irq-gic.c b/arch/mips/ralink/irq-gic.c
new file mode 100644
index 0000000..0ae7ea0
--- /dev/null
+++ b/arch/mips/ralink/irq-gic.c
@@ -0,0 +1,277 @@
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/hardirq.h>
+#include <linux/preempt.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+
+#include <asm/irq.h>
+#include <asm/setup.h>
+
+#include <asm/gic.h>
+#include <asm/gcmpregs.h>
+
+#include <asm/mach-ralink/mt7621.h>
+
+unsigned long _gcmp_base;
+static int gic_resched_int_base = 56;
+static int gic_call_int_base = 60;
+static struct irq_chip *irq_gic;
+static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS];
+
+#if defined(CONFIG_MIPS_MT_SMP)
+static int gic_resched_int_base;
+static int gic_call_int_base;
+
+#define GIC_RESCHED_INT(cpu) (gic_resched_int_base+(cpu))
+#define GIC_CALL_INT(cpu) (gic_call_int_base+(cpu))
+
+static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
+{
+	scheduler_ipi();
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t
+ipi_call_interrupt(int irq, void *dev_id)
+{
+	smp_call_function_interrupt();
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction irq_resched = {
+	.handler	= ipi_resched_interrupt,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.name		= "ipi resched"
+};
+
+static struct irqaction irq_call = {
+	.handler	= ipi_call_interrupt,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.name		= "ipi call"
+};
+
+#endif
+
+static void __init
+gic_fill_map(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gic_intr_map); i++) {
+		gic_intr_map[i].cpunum = 0;
+		gic_intr_map[i].pin = GIC_CPU_INT0;
+		gic_intr_map[i].polarity = GIC_POL_POS;
+		gic_intr_map[i].trigtype = GIC_TRIG_LEVEL;
+		gic_intr_map[i].flags = GIC_FLAG_IPI;
+	}
+
+#if defined(CONFIG_MIPS_MT_SMP)
+	{
+		int cpu;
+
+		gic_call_int_base = ARRAY_SIZE(gic_intr_map) - nr_cpu_ids;
+		gic_resched_int_base = gic_call_int_base - nr_cpu_ids;
+
+		i = gic_resched_int_base;
+
+		for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+			gic_intr_map[i + cpu].cpunum = cpu;
+			gic_intr_map[i + cpu].pin = GIC_CPU_INT1;
+			gic_intr_map[i + cpu].trigtype = GIC_TRIG_EDGE;
+
+			gic_intr_map[i + cpu + nr_cpu_ids].cpunum = cpu;
+			gic_intr_map[i + cpu + nr_cpu_ids].pin = GIC_CPU_INT2;
+			gic_intr_map[i + cpu + nr_cpu_ids].trigtype =
+								GIC_TRIG_EDGE;
+		}
+	}
+#endif
+}
+
+void
+gic_irq_ack(struct irq_data *d)
+{
+	int irq = (d->irq - gic_irq_base);
+
+	GIC_CLR_INTR_MASK(irq);
+
+	if (gic_irq_flags[irq] & GIC_TRIG_EDGE)
+		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
+}
+
+void
+gic_finish_irq(struct irq_data *d)
+{
+	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
+}
+
+void __init
+gic_platform_init(int irqs, struct irq_chip *irq_controller)
+{
+	irq_gic = irq_controller;
+}
+
+static void
+gic_irqdispatch(void)
+{
+	unsigned int irq = gic_get_int();
+
+	if (likely(irq < GIC_NUM_INTRS))
+		do_IRQ(MIPS_GIC_IRQ_BASE + irq);
+	else {
+		pr_err("Spurious GIC Interrupt!\n");
+		spurious_interrupt();
+	}
+
+}
+
+static void
+vi_timer_irqdispatch(void)
+{
+	do_IRQ(cp0_compare_irq);
+}
+
+#if defined(CONFIG_MIPS_MT_SMP)
+unsigned int
+plat_ipi_call_int_xlate(unsigned int cpu)
+{
+	return GIC_CALL_INT(cpu);
+}
+
+unsigned int
+plat_ipi_resched_int_xlate(unsigned int cpu)
+{
+	return GIC_RESCHED_INT(cpu);
+}
+#endif
+
+asmlinkage void
+plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
+
+	if (unlikely(!pending)) {
+		pr_err("Spurious CP0 Interrupt!\n");
+		spurious_interrupt();
+	} else {
+		if (pending & CAUSEF_IP7)
+			do_IRQ(cp0_compare_irq);
+
+		if (pending & (CAUSEF_IP4 | CAUSEF_IP3 | CAUSEF_IP2))
+			gic_irqdispatch();
+	}
+}
+
+unsigned int __cpuinit
+get_c0_compare_int(void)
+{
+	return CP0_LEGACY_COMPARE_IRQ;
+}
+
+static int
+gic_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, irq_gic,
+#if defined(CONFIG_MIPS_MT_SMP)
+		(hw >= gic_resched_int_base) ?
+			handle_percpu_irq :
+#endif
+			handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops irq_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = gic_map,
+};
+
+static int __init
+of_gic_init(struct device_node *node,
+				struct device_node *parent)
+{
+	struct irq_domain *domain;
+	struct resource gcmp = { 0 }, gic = { 0 };
+	unsigned int gic_rev;
+	int i;
+
+	if (of_address_to_resource(node, 0, &gic))
+		panic("Failed to get gic memory range");
+	if (request_mem_region(gic.start, resource_size(&gic),
+				gic.name) < 0)
+		panic("Failed to request gic memory");
+	if (of_address_to_resource(node, 2, &gcmp))
+		panic("Failed to get gic memory range");
+	if (request_mem_region(gcmp.start, resource_size(&gcmp),
+				gcmp.name) < 0)
+		panic("Failed to request gcmp memory");
+
+	_gcmp_base = (unsigned long) ioremap_nocache(gcmp.start,
+							resource_size(&gcmp));
+	if (!_gcmp_base)
+		panic("Failed to remap gcmp memory\n");
+
+	if ((GCMPGCB(GCMPB) & GCMP_GCB_GCMPB_GCMPBASE_MSK) != gcmp.start)
+		panic("Failed to find gcmp core\n");
+
+	/* tell the gcmp where to find the gic */
+	GCMPGCB(GICBA) = gic.start | GCMP_GCB_GICBA_EN_MSK;
+	gic_present = 1;
+	if (cpu_has_vint) {
+		set_vi_handler(2, gic_irqdispatch);
+		set_vi_handler(3, gic_irqdispatch);
+		set_vi_handler(4, gic_irqdispatch);
+		set_vi_handler(7, vi_timer_irqdispatch);
+	}
+
+	gic_fill_map();
+
+	gic_init(gic.start, resource_size(&gic), gic_intr_map,
+		ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
+
+	GICREAD(GIC_REG(SHARED, GIC_SH_REVISIONID), gic_rev);
+	pr_info("gic: revision %d.%d\n", (gic_rev >> 8) & 0xff, gic_rev & 0xff);
+
+	domain = irq_domain_add_legacy(node, GIC_NUM_INTRS, MIPS_GIC_IRQ_BASE,
+			0, &irq_domain_ops, NULL);
+	if (!domain)
+		panic("Failed to add irqdomain");
+
+#if defined(CONFIG_MIPS_MT_SMP)
+	for (i = 0; i < nr_cpu_ids; i++) {
+		setup_irq(MIPS_GIC_IRQ_BASE + GIC_RESCHED_INT(i), &irq_resched);
+		setup_irq(MIPS_GIC_IRQ_BASE + GIC_CALL_INT(i), &irq_call);
+	}
+#endif
+
+	change_c0_status(ST0_IM, STATUSF_IP7 | STATUSF_IP4 | STATUSF_IP3 |
+				STATUSF_IP2);
+	return 0;
+}
+
+static struct of_device_id of_irq_ids[] __initdata = {
+	{
+		.compatible = "mti,cpu-interrupt-controller",
+		.data = mips_cpu_intc_init
+	}, {
+		.compatible = "ralink,mt7621-gic",
+		.data = of_gic_init
+	}, { }
+};
+
+void __init
+arch_init_irq(void)
+{
+	of_irq_init(of_irq_ids);
+}
-- 
1.7.10.4
