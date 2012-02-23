Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:10:57 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:60679 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903774Ab2BWQFL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:05:11 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: lantiq: add ipi handlers to make vsmp work
Date:   Thu, 23 Feb 2012 17:04:52 +0100
Message-Id: <1330013092-13815-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 32520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add IPI handlers to the interrupt code. This patch makes MIPS_MT_SMP work
on lantiq SoCs.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/irq.c  |   61 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/lantiq/prom.c |    5 ++++
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 3b8cea5..71648a8 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -9,6 +9,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/sched.h>
 
 #include <asm/bootinfo.h>
 #include <asm/irq_cpu.h>
@@ -51,6 +52,14 @@
 #define ltq_eiu_w32(x, y)	ltq_w32((x), ltq_eiu_membase + (y))
 #define ltq_eiu_r32(x)		ltq_r32(ltq_eiu_membase + (x))
 
+/* our 2 ipi interrupts for VSMP */
+#define MIPS_CPU_IPI_RESCHED_IRQ	0
+#define MIPS_CPU_IPI_CALL_IRQ		1
+
+#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
+int gic_present;
+#endif
+
 static unsigned short ltq_eiu_irq[MAX_EIU] = {
 	LTQ_EIU_IR0,
 	LTQ_EIU_IR1,
@@ -216,6 +225,47 @@ static void ltq_hw5_irqdispatch(void)
 	do_IRQ(MIPS_CPU_TIMER_IRQ);
 }
 
+#ifdef CONFIG_MIPS_MT_SMP
+void __init arch_init_ipiirq(int irq, struct irqaction *action)
+{
+	setup_irq(irq, action);
+	irq_set_handler(irq, handle_percpu_irq);
+}
+
+static void ltq_sw0_irqdispatch(void)
+{
+	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_RESCHED_IRQ);
+}
+
+static void ltq_sw1_irqdispatch(void)
+{
+	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ);
+}
+static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
+{
+	scheduler_ipi();
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
+{
+	smp_call_function_interrupt();
+	return IRQ_HANDLED;
+}
+
+static struct irqaction irq_resched = {
+	.handler	= ipi_resched_interrupt,
+	.flags		= IRQF_PERCPU,
+	.name		= "IPI_resched"
+};
+
+static struct irqaction irq_call = {
+	.handler	= ipi_call_interrupt,
+	.flags		= IRQF_PERCPU,
+	.name		= "IPI_call"
+};
+#endif
+
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
@@ -310,6 +360,17 @@ void __init arch_init_irq(void)
 			irq_set_chip_and_handler(i, &ltq_irq_type,
 				handle_level_irq);
 
+#if defined(CONFIG_MIPS_MT_SMP)
+	if (cpu_has_vint) {
+		pr_info("Setting up IPI vectored interrupts\n");
+		set_vi_handler(MIPS_CPU_IPI_RESCHED_IRQ, ltq_sw0_irqdispatch);
+		set_vi_handler(MIPS_CPU_IPI_CALL_IRQ, ltq_sw1_irqdispatch);
+	}
+	arch_init_ipiirq(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_RESCHED_IRQ,
+		&irq_resched);
+	arch_init_ipiirq(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ, &irq_call);
+#endif
+
 #if !defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
 	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 |
 		IE_IRQ3 | IE_IRQ4 | IE_IRQ5);
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index b002bc7..c68a4d2 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -108,4 +108,9 @@ void __init prom_init(void)
 	soc_info.sys_type[LTQ_SYS_TYPE_LEN - 1] = '\0';
 	pr_info("SoC: %s\n", soc_info.sys_type);
 	prom_init_cmdline();
+
+#if defined(CONFIG_MIPS_MT_SMP)
+	if (register_vsmp_smp_ops())
+		panic("failed to register_vsmp_smp_ops()");
+#endif
 }
-- 
1.7.7.1
