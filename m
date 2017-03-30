Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 21:08:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36175 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993878AbdC3TH4RwWvr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 21:07:56 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 775BED23874A8;
        Thu, 30 Mar 2017 20:07:45 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 30 Mar 2017 20:07:48
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/5] MIPS: smp-mt: Use CPU interrupt controller IPI IRQ domain support
Date:   Thu, 30 Mar 2017 12:06:12 -0700
Message-ID: <20170330190614.14844-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.12.1
In-Reply-To: <20170330190614.14844-1-paul.burton@imgtec.com>
References: <20170330190614.14844-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Remove the smp-mt IPI code that supported single-core multithreaded
systems and instead make use of the IPI IRQ domain support provided by
the MIPS CPU interrupt controller driver. This removes some less than
nice code, the horrible split between arch & board code and the
duplication that led to within board code.

The lantiq portion of this patch has only been compile tested. Malta has
been tested & is functional.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/smp-mt.c       | 49 ++----------------------
 arch/mips/lantiq/irq.c          | 52 --------------------------
 arch/mips/mti-malta/malta-int.c | 83 ++---------------------------------------
 3 files changed, 8 insertions(+), 176 deletions(-)

diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index e398cbc3d776..ed6b4df583ea 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -83,6 +83,8 @@ static unsigned int __init smvp_vpe_init(unsigned int tc, unsigned int mvpconf0,
 	if (tc != 0)
 		smvp_copy_vpe_config();
 
+	cpu_data[ncpu].vpe_id = tc;
+
 	return ncpu;
 }
 
@@ -114,49 +116,6 @@ static void __init smvp_tc_init(unsigned int tc, unsigned int mvpconf0)
 	write_tc_c0_tchalt(TCHALT_H);
 }
 
-static void vsmp_send_ipi_single(int cpu, unsigned int action)
-{
-	int i;
-	unsigned long flags;
-	int vpflags;
-
-#ifdef CONFIG_MIPS_GIC
-	if (gic_present) {
-		mips_smp_send_ipi_single(cpu, action);
-		return;
-	}
-#endif
-	local_irq_save(flags);
-
-	vpflags = dvpe();	/* can't access the other CPU's registers whilst MVPE enabled */
-
-	switch (action) {
-	case SMP_CALL_FUNCTION:
-		i = C_SW1;
-		break;
-
-	case SMP_RESCHEDULE_YOURSELF:
-	default:
-		i = C_SW0;
-		break;
-	}
-
-	/* 1:1 mapping of vpe and tc... */
-	settc(cpu);
-	write_vpe_c0_cause(read_vpe_c0_cause() | i);
-	evpe(vpflags);
-
-	local_irq_restore(flags);
-}
-
-static void vsmp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
-{
-	unsigned int i;
-
-	for_each_cpu(i, mask)
-		vsmp_send_ipi_single(i, action);
-}
-
 static void vsmp_init_secondary(void)
 {
 #ifdef CONFIG_MIPS_GIC
@@ -281,8 +240,8 @@ static void __init vsmp_prepare_cpus(unsigned int max_cpus)
 }
 
 struct plat_smp_ops vsmp_smp_ops = {
-	.send_ipi_single	= vsmp_send_ipi_single,
-	.send_ipi_mask		= vsmp_send_ipi_mask,
+	.send_ipi_single	= mips_smp_send_ipi_single,
+	.send_ipi_mask		= mips_smp_send_ipi_mask,
 	.init_secondary		= vsmp_init_secondary,
 	.smp_finish		= vsmp_smp_finish,
 	.boot_secondary		= vsmp_boot_secondary,
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 0ddf3698b85d..33728b7af426 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -274,47 +274,6 @@ static void ltq_hw_irq_handler(struct irq_desc *desc)
 	ltq_hw_irqdispatch(irq_desc_get_irq(desc) - 2);
 }
 
-#ifdef CONFIG_MIPS_MT_SMP
-void __init arch_init_ipiirq(int irq, struct irqaction *action)
-{
-	setup_irq(irq, action);
-	irq_set_handler(irq, handle_percpu_irq);
-}
-
-static void ltq_sw0_irqdispatch(void)
-{
-	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_RESCHED_IRQ);
-}
-
-static void ltq_sw1_irqdispatch(void)
-{
-	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ);
-}
-static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
-{
-	scheduler_ipi();
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
-{
-	generic_smp_call_function_interrupt();
-	return IRQ_HANDLED;
-}
-
-static struct irqaction irq_resched = {
-	.handler	= ipi_resched_interrupt,
-	.flags		= IRQF_PERCPU,
-	.name		= "IPI_resched"
-};
-
-static struct irqaction irq_call = {
-	.handler	= ipi_call_interrupt,
-	.flags		= IRQF_PERCPU,
-	.name		= "IPI_call"
-};
-#endif
-
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
@@ -402,17 +361,6 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 		(MAX_IM * INT_NUM_IM_OFFSET) + MIPS_CPU_IRQ_CASCADE,
 		&irq_domain_ops, 0);
 
-#if defined(CONFIG_MIPS_MT_SMP)
-	if (cpu_has_vint) {
-		pr_info("Setting up IPI vectored interrupts\n");
-		set_vi_handler(MIPS_CPU_IPI_RESCHED_IRQ, ltq_sw0_irqdispatch);
-		set_vi_handler(MIPS_CPU_IPI_CALL_IRQ, ltq_sw1_irqdispatch);
-	}
-	arch_init_ipiirq(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_RESCHED_IRQ,
-		&irq_resched);
-	arch_init_ipiirq(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ, &irq_call);
-#endif
-
 #ifndef CONFIG_MIPS_MT_SMP
 	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 |
 		IE_IRQ3 | IE_IRQ4 | IE_IRQ5);
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index cb675ec6f283..fe9bb479f2a0 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -145,56 +145,6 @@ static irqreturn_t corehi_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_MIPS_MT_SMP
-
-#define MIPS_CPU_IPI_RESCHED_IRQ 0	/* SW int 0 for resched */
-#define C_RESCHED C_SW0
-#define MIPS_CPU_IPI_CALL_IRQ 1		/* SW int 1 for resched */
-#define C_CALL C_SW1
-static int cpu_ipi_resched_irq, cpu_ipi_call_irq;
-
-static void ipi_resched_dispatch(void)
-{
-	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_RESCHED_IRQ);
-}
-
-static void ipi_call_dispatch(void)
-{
-	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ);
-}
-
-static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
-{
-#ifdef CONFIG_MIPS_VPE_APSP_API_CMP
-	if (aprp_hook)
-		aprp_hook();
-#endif
-
-	scheduler_ipi();
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
-{
-	generic_smp_call_function_interrupt();
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction irq_resched = {
-	.handler	= ipi_resched_interrupt,
-	.flags		= IRQF_PERCPU,
-	.name		= "IPI_resched"
-};
-
-static struct irqaction irq_call = {
-	.handler	= ipi_call_interrupt,
-	.flags		= IRQF_PERCPU,
-	.name		= "IPI_call"
-};
-#endif /* CONFIG_MIPS_MT_SMP */
-
 static struct irqaction corehi_irqaction = {
 	.handler = corehi_handler,
 	.name = "CoreHi",
@@ -222,12 +172,6 @@ static msc_irqmap_t msc_eicirqmap[] __initdata = {
 
 static int msc_nr_eicirqs __initdata = ARRAY_SIZE(msc_eicirqmap);
 
-void __init arch_init_ipiirq(int irq, struct irqaction *action)
-{
-	setup_irq(irq, action);
-	irq_set_handler(irq, handle_percpu_irq);
-}
-
 void __init arch_init_irq(void)
 {
 	int corehi_irq;
@@ -262,30 +206,11 @@ void __init arch_init_irq(void)
 
 	if (gic_present) {
 		corehi_irq = MIPS_CPU_IRQ_BASE + MIPSCPU_INT_COREHI;
+	} else if (cpu_has_veic) {
+		set_vi_handler(MSC01E_INT_COREHI, corehi_irqdispatch);
+		corehi_irq = MSC01E_INT_BASE + MSC01E_INT_COREHI;
 	} else {
-#if defined(CONFIG_MIPS_MT_SMP)
-		/* set up ipi interrupts */
-		if (cpu_has_veic) {
-			set_vi_handler (MSC01E_INT_SW0, ipi_resched_dispatch);
-			set_vi_handler (MSC01E_INT_SW1, ipi_call_dispatch);
-			cpu_ipi_resched_irq = MSC01E_INT_SW0;
-			cpu_ipi_call_irq = MSC01E_INT_SW1;
-		} else {
-			cpu_ipi_resched_irq = MIPS_CPU_IRQ_BASE +
-				MIPS_CPU_IPI_RESCHED_IRQ;
-			cpu_ipi_call_irq = MIPS_CPU_IRQ_BASE +
-				MIPS_CPU_IPI_CALL_IRQ;
-		}
-		arch_init_ipiirq(cpu_ipi_resched_irq, &irq_resched);
-		arch_init_ipiirq(cpu_ipi_call_irq, &irq_call);
-#endif
-		if (cpu_has_veic) {
-			set_vi_handler(MSC01E_INT_COREHI,
-				       corehi_irqdispatch);
-			corehi_irq = MSC01E_INT_BASE + MSC01E_INT_COREHI;
-		} else {
-			corehi_irq = MIPS_CPU_IRQ_BASE + MIPSCPU_INT_COREHI;
-		}
+		corehi_irq = MIPS_CPU_IRQ_BASE + MIPSCPU_INT_COREHI;
 	}
 
 	setup_irq(corehi_irq, &corehi_irqaction);
-- 
2.12.1
