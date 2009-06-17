Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2009 01:24:04 +0200 (CEST)
Received: from fw1-az.mvista.com ([65.200.49.156]:4903 "EHLO
	shomer.az.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492156AbZFQXX5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2009 01:23:57 +0200
Received: from shomer.az.mvista.com (localhost.localdomain [127.0.0.1])
	by shomer.az.mvista.com (8.14.2/8.14.2) with ESMTP id n5HNMPxu010747
	for <linux-mips@linux-mips.org>; Wed, 17 Jun 2009 16:22:25 -0700
Received: (from tsa@localhost)
	by shomer.az.mvista.com (8.14.2/8.14.2/Submit) id n5HNMPOH010746
	for linux-mips@linux-mips.org; Wed, 17 Jun 2009 16:22:25 -0700
Date:	Wed, 17 Jun 2009 16:22:25 -0700
From:	Tim Anderson <tanderson@mvista.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 2/5] Extend IPI handling to CPU number
Message-ID: <20090617232225.GC10714@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsa@shomer.az.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanderson@mvista.com
Precedence: bulk
X-list: linux-mips

This takes the current IPI interrupt assignment from
the fix number of 4 to the number of CPUs defined in the
system.

Signed-off-by: Tim Anderson <tanderson@mvista.com>
---
 arch/mips/kernel/irq-gic.c      |    4 ++
 arch/mips/mti-malta/malta-int.c |   74 +++++++++++++++++++--------------------
 2 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 1031ae1..d7d7673 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -246,6 +246,10 @@ static void __init gic_basic_init(void)
 		if (cpu == X)
 			continue;
 
+		if (cpu == 0 && i != 0 && _intrmap[i].intrnum == 0 &&
+					_intrmap[i].ipiflag == 0)
+			continue;
+
 		setup_intr(_intrmap[i].intrnum,
 				_intrmap[i].cpunum,
 				_intrmap[i].pin,
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index ea17611..1c23548 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -330,6 +330,11 @@ static struct irqaction irq_call = {
 	.flags		= IRQF_DISABLED|IRQF_PERCPU,
 	.name		= "IPI_call"
 };
+
+static int gic_resched_int_base;
+static int gic_call_int_base;
+#define GIC_RESCHED_INT(cpu) (gic_resched_int_base+(cpu))
+#define GIC_CALL_INT(cpu) (gic_call_int_base+(cpu))
 #endif /* CONFIG_MIPS_MT_SMP */
 
 static struct irqaction i8259irq = {
@@ -369,7 +374,7 @@ static int __initdata msc_nr_eicirqs = ARRAY_SIZE(msc_eicirqmap);
  * Interrupts and CPUs/Core Interrupts. The nature of the External
  * Interrupts is also defined here - polarity/trigger.
  */
-static struct gic_intr_map gic_intr_map[] = {
+static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
 	{ GIC_EXT_INTR(0), 	X,	X,		X, 		X,		0 },
 	{ GIC_EXT_INTR(1), 	X,	X,		X, 		X,		0 },
 	{ GIC_EXT_INTR(2), 	X,	X,		X, 		X,		0 },
@@ -386,14 +391,7 @@ static struct gic_intr_map gic_intr_map[] = {
 	{ GIC_EXT_INTR(13), 	0,	GIC_MAP_TO_NMI_MSK,	GIC_POL_POS, GIC_TRIG_LEVEL,	0 },
 	{ GIC_EXT_INTR(14), 	0,	GIC_MAP_TO_NMI_MSK,	GIC_POL_POS, GIC_TRIG_LEVEL,	0 },
 	{ GIC_EXT_INTR(15), 	X,	X,		X, 		X,		0 },
-	{ GIC_EXT_INTR(16), 	0,	GIC_CPU_INT1,	GIC_POL_POS, GIC_TRIG_EDGE,	1 },
-	{ GIC_EXT_INTR(17), 	0,	GIC_CPU_INT2,	GIC_POL_POS, GIC_TRIG_EDGE,	1 },
-	{ GIC_EXT_INTR(18), 	1,	GIC_CPU_INT1,	GIC_POL_POS, GIC_TRIG_EDGE,	1 },
-	{ GIC_EXT_INTR(19), 	1,	GIC_CPU_INT2,	GIC_POL_POS, GIC_TRIG_EDGE,	1 },
-	{ GIC_EXT_INTR(20), 	2,	GIC_CPU_INT1,	GIC_POL_POS, GIC_TRIG_EDGE,	1 },
-	{ GIC_EXT_INTR(21), 	2,	GIC_CPU_INT2,	GIC_POL_POS, GIC_TRIG_EDGE,	1 },
-	{ GIC_EXT_INTR(22), 	3,	GIC_CPU_INT1,	GIC_POL_POS, GIC_TRIG_EDGE,	1 },
-	{ GIC_EXT_INTR(23), 	3,	GIC_CPU_INT2,	GIC_POL_POS, GIC_TRIG_EDGE,	1 },
+/* This is the end of the general interrupts now we do IPI ones */
 };
 #endif
 
@@ -415,14 +413,25 @@ static int __init gcmp_probe(unsigned long addr, unsigned long size)
 }
 
 #if defined(CONFIG_MIPS_MT_SMP)
+static void __init fill_ipi_map1(int baseintr, int cpu, int cpupin)
+{
+	int intr = baseintr + cpu;
+	gic_intr_map[intr].intrnum = GIC_EXT_INTR(intr);
+	gic_intr_map[intr].cpunum = cpu;
+	gic_intr_map[intr].pin = cpupin;
+	gic_intr_map[intr].polarity = GIC_POL_POS;
+	gic_intr_map[intr].trigtype = GIC_TRIG_EDGE;
+	gic_intr_map[intr].ipiflag = 1;
+	ipi_map[cpu] |= (1 << (cpupin + 2));
+}
+
 static void __init fill_ipi_map(void)
 {
-	int i;
+	int cpu;
 
-	for (i = 0; i < ARRAY_SIZE(gic_intr_map); i++) {
-		if (gic_intr_map[i].ipiflag && (gic_intr_map[i].cpunum != X))
-			ipi_map[gic_intr_map[i].cpunum] |=
-				(1 << (gic_intr_map[i].pin + 2));
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		fill_ipi_map1(gic_resched_int_base, cpu, GIC_CPU_INT1);
+		fill_ipi_map1(gic_call_int_base, cpu, GIC_CPU_INT2);
 	}
 }
 #endif
@@ -513,24 +522,10 @@ void __init arch_init_irq(void)
 	if (gic_present) {
 		/* FIXME */
 		int i;
-		struct {
-			unsigned int resched;
-			unsigned int call;
-		} ipiirq[] = {
-			{
-				.resched = GIC_IPI_EXT_INTR_RESCHED_VPE0,
-				.call =  GIC_IPI_EXT_INTR_CALLFNC_VPE0},
-			{
-				.resched = GIC_IPI_EXT_INTR_RESCHED_VPE1,
-				.call =  GIC_IPI_EXT_INTR_CALLFNC_VPE1
-			}, {
-				.resched = GIC_IPI_EXT_INTR_RESCHED_VPE2,
-				.call =  GIC_IPI_EXT_INTR_CALLFNC_VPE2
-			}, {
-				.resched = GIC_IPI_EXT_INTR_RESCHED_VPE3,
-				.call =  GIC_IPI_EXT_INTR_CALLFNC_VPE3
-			}
-		};
+
+		gic_call_int_base = GIC_NUM_INTRS - NR_CPUS;
+		gic_resched_int_base = gic_call_int_base - NR_CPUS;
+
 		fill_ipi_map();
 		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map, ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
 		if (!gcmp_present) {
@@ -552,12 +547,15 @@ void __init arch_init_irq(void)
 		printk("CPU%d: status register now %08x\n", smp_processor_id(), read_c0_status());
 		write_c0_status(0x1100dc00);
 		printk("CPU%d: status register frc %08x\n", smp_processor_id(), read_c0_status());
-		for (i = 0; i < ARRAY_SIZE(ipiirq); i++) {
-			setup_irq(MIPS_GIC_IRQ_BASE + ipiirq[i].resched, &irq_resched);
-			setup_irq(MIPS_GIC_IRQ_BASE + ipiirq[i].call, &irq_call);
-
-			set_irq_handler(MIPS_GIC_IRQ_BASE + ipiirq[i].resched, handle_percpu_irq);
-			set_irq_handler(MIPS_GIC_IRQ_BASE + ipiirq[i].call, handle_percpu_irq);
+		for (i = 0; i < NR_CPUS; i++) {
+			setup_irq(MIPS_GIC_IRQ_BASE +
+					GIC_RESCHED_INT(i), &irq_resched);
+			setup_irq(MIPS_GIC_IRQ_BASE +
+					GIC_CALL_INT(i), &irq_call);
+			set_irq_handler(MIPS_GIC_IRQ_BASE +
+					GIC_RESCHED_INT(i), handle_percpu_irq);
+			set_irq_handler(MIPS_GIC_IRQ_BASE +
+					GIC_CALL_INT(i), handle_percpu_irq);
 		}
 	} else {
 		/* set up ipi interrupts */
-- 
1.6.2.5.175.g7c84
