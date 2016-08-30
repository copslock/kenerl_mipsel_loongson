Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 19:37:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43854 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992474AbcH3ReozE0a0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 19:34:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4FB00655260E6;
        Tue, 30 Aug 2016 18:34:24 +0100 (IST)
Received: from localhost (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 18:34:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <john@phrozen.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 18/26] MIPS: smp-mt: Use CPU interrupt controller IPI IRQ domain support
Date:   Tue, 30 Aug 2016 18:29:21 +0100
Message-ID: <20160830172929.16948-19-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830172929.16948-1-paul.burton@imgtec.com>
References: <20160830172929.16948-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54859
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
---

Changes in v2: None

 arch/mips/kernel/smp-mt.c       | 49 +++------------------------
 arch/mips/lantiq/irq.c          | 52 ----------------------------
 arch/mips/mti-malta/malta-int.c | 75 ++---------------------------------------
 3 files changed, 7 insertions(+), 169 deletions(-)

diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 4f9570a..fd3ce15 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -82,6 +82,8 @@ static unsigned int __init smvp_vpe_init(unsigned int tc, unsigned int mvpconf0,
 	if (tc != 0)
 		smvp_copy_vpe_config();
 
+	cpu_data[ncpu].vpe_id = tc;
+
 	return ncpu;
 }
 
@@ -113,49 +115,6 @@ static void __init smvp_tc_init(unsigned int tc, unsigned int mvpconf0)
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
@@ -280,8 +239,8 @@ static void __init vsmp_prepare_cpus(unsigned int max_cpus)
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
index 8ac0e59..eb831d2 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -269,47 +269,6 @@ static void ltq_hw5_irqdispatch(void)
 DEFINE_HWx_IRQDISPATCH(5)
 #endif
 
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
@@ -406,17 +365,6 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
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
index 548130d..26adb77 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -190,56 +190,6 @@ static irqreturn_t corehi_handler(int irq, void *dev_id)
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
 static struct irqaction i8259irq = {
 	.handler = i8259_handler,
 	.name = "XT-PIC cascade",
@@ -273,12 +223,6 @@ static msc_irqmap_t msc_eicirqmap[] __initdata = {
 
 static int msc_nr_eicirqs __initdata = ARRAY_SIZE(msc_eicirqmap);
 
-void __init arch_init_ipiirq(int irq, struct irqaction *action)
-{
-	setup_irq(irq, action);
-	irq_set_handler(irq, handle_percpu_irq);
-}
-
 void __init arch_init_irq(void)
 {
 	int corehi_irq, i8259_irq;
@@ -343,23 +287,10 @@ void __init arch_init_irq(void)
 		}
 		i8259_irq = MIPS_GIC_IRQ_BASE + GIC_INT_I8259A;
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
 		if (cpu_has_veic) {
 			set_vi_handler(MSC01E_INT_I8259A,
 				       malta_hw0_irqdispatch);
-- 
2.9.3
