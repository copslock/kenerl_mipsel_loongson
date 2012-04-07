Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 18:51:12 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36606 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904120Ab2DGQs7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2012 18:48:59 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SGYon-0004dH-HA; Sat, 07 Apr 2012 11:48:53 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Douglas Leung <douglas@mips.com>,
        Chris Dearman <chris@mips.com>
Subject: [PATCH 05/10] MIPS: GIC interrupt changes for M14K and SEAD-3 support.
Date:   Sat,  7 Apr 2012 11:48:30 -0500
Message-Id: <1333817315-30091-6-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333817315-30091-1-git-send-email-sjhill@mips.com>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
X-archive-position: 32883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

These changes are to support the different GIC implementation that
is used with M14K cores. It also supports the new SEAD-3 platform
interrupt sources.

Signed-off-by: Douglas Leung <douglas@mips.com>
Signed-off-by: Chris Dearman <chris@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cpu-features.h |    4 +-
 arch/mips/kernel/cevt-r4k.c          |    5 +
 arch/mips/kernel/irq-gic.c           |  168 ++++++++++++++++++++++++++++++++--
 3 files changed, 169 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index ca400f7..556afa2 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -222,13 +222,13 @@
 # endif
 #endif
 
-#if defined(CONFIG_CPU_MIPSR2_IRQ_VI) && !defined(cpu_has_vint)
+#if (defined(CONFIG_MIPS_SEAD3) || defined(CONFIG_CPU_MIPSR2_IRQ_VI)) && !defined(cpu_has_vint)
 # define cpu_has_vint		(cpu_data[0].options & MIPS_CPU_VINT)
 #elif !defined(cpu_has_vint)
 # define cpu_has_vint			0
 #endif
 
-#if defined(CONFIG_CPU_MIPSR2_IRQ_EI) && !defined(cpu_has_veic)
+#if (defined(CONFIG_MIPS_SEAD3) || defined(CONFIG_CPU_MIPSR2_IRQ_EI)) && !defined(cpu_has_veic)
 # define cpu_has_veic		(cpu_data[0].options & MIPS_CPU_VEIC)
 #elif !defined(cpu_has_veic)
 # define cpu_has_veic			0
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 51095dd9..17a59a5 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -15,6 +15,7 @@
 #include <asm/smtc_ipi.h>
 #include <asm/time.h>
 #include <asm/cevt-r4k.h>
+#include <asm/gic.h>
 
 /*
  * The SMTC Kernel for the 34K, 1004K, et. al. replaces several
@@ -98,6 +99,10 @@ void mips_event_handler(struct clock_event_device *dev)
  */
 static int c0_compare_int_pending(void)
 {
+#ifdef CONFIG_MIPS_SEAD3
+	if (cpu_has_veic)
+		return gic_get_timer_pending();
+#endif
 	return (read_c0_cause() >> cp0_compare_irq_shift) & (1ul << CAUSEB_IP);
 }
 
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 0c527f6..275b163 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -8,19 +8,93 @@
 #include <asm/io.h>
 #include <asm/gic.h>
 #include <asm/gcmpregs.h>
+#include <asm/setup.h>
+
+#ifdef CONFIG_MIPS_SEAD3
+#include <asm/mips-boards/sead3int.h>
+#else
+#include <asm/mips-boards/maltaint.h>
+#endif
+
+#include <asm/traps.h>
 #include <linux/hardirq.h>
 #include <asm-generic/bitops/find.h>
 
-
 static unsigned long _gic_base;
 static unsigned int _irqbase;
 static unsigned int gic_irq_flags[GIC_NUM_INTRS];
 #define GIC_IRQ_FLAG_EDGE      0x0001
 
+/* The index into this array is the vector # of the interrupt. */
+static struct gic_shared_intr_map gic_shared_intr_map[GIC_NUM_INTRS];
+
 struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static struct gic_pending_regs pending_regs[NR_CPUS];
 static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 
+unsigned int gic_get_timer_pending(void)
+{
+	unsigned int vpe_pending;
+
+	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), 0);
+	GICREAD(GIC_REG(VPE_OTHER, GIC_VPE_PEND), vpe_pending);
+	return vpe_pending & GIC_VPE_PEND_TIMER_MSK;
+}
+
+/* Helper function to enable the interrupt */
+/* NOTE: the _irqbase have already been removed. */
+void gic_enable_interrupt(int irq_vec)
+{
+#ifdef CONFIG_MIPS_SEAD3
+	unsigned int i;
+	unsigned int irq_source;
+
+	/* enable all the interrupts associated with this vector */
+	for (i = 0; i < gic_shared_intr_map[irq_vec].num_shared_intr; i++) {
+		irq_source = gic_shared_intr_map[irq_vec].intr_list[i];
+		GIC_SET_INTR_MASK(irq_source);
+	}
+	/* enable all local interrupts associated with this vector */
+	if (gic_shared_intr_map[irq_vec].local_intr_mask) {
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), 0);
+		GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_SMASK), gic_shared_intr_map[irq_vec].local_intr_mask);
+	}
+#else
+	GIC_SET_INTR_MASK(irq_vec);
+#endif
+}
+
+/* Helper function to disable the interrupt */
+/* NOTE: the _irqbase have already been removed. */
+void gic_disable_interrupt(int irq_vec)
+{
+#ifdef CONFIG_MIPS_SEAD3
+	unsigned int i;
+	unsigned int irq_source;
+
+	/* disable all the interrupts associated with this vector */
+	for (i = 0; i < gic_shared_intr_map[irq_vec].num_shared_intr; i++) {
+		irq_source = gic_shared_intr_map[irq_vec].intr_list[i];
+		GIC_CLR_INTR_MASK(irq_source);
+	}
+	/* disable all local interrupts associated with this vector */
+	if (gic_shared_intr_map[irq_vec].local_intr_mask) {
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), 0);
+		GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), gic_shared_intr_map[irq_vec].local_intr_mask);
+	}
+#else
+	GIC_CLR_INTR_MASK(irq_vec);
+#endif
+}
+
+void gic_bind_eic_interrupt(int irq, int set)
+{
+	irq = irq - GIC_PIN_TO_VEC_OFFSET;   /* convert irq vector # to hw int # */
+
+	/* set irq to use shadow set */
+	GICWRITE(GIC_REG_ADDR(VPE_LOCAL, GIC_VPE_EIC_SS(irq)), set);
+}
+
 void gic_send_ipi(unsigned int intr)
 {
 	pr_debug("CPU%d: %s status %08x\n", smp_processor_id(), __func__,
@@ -28,13 +102,35 @@ void gic_send_ipi(unsigned int intr)
 	GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), 0x80000000 | intr);
 }
 
+static void gic_eic_irq_dispatch(void)
+{
+	unsigned int cause = read_c0_cause();
+	int irq;
+
+	irq = (cause & ST0_IM) >> STATUSB_IP2;
+	if (irq == 0)
+		irq = -1;
+
+	if (irq >= 0)
+		do_IRQ(_irqbase + irq);
+	else
+		spurious_interrupt();
+}
+
 /* This is Malta specific and needs to be exported */
 static void __init vpe_local_setup(unsigned int numvpes)
 {
 	int i;
-	unsigned long timer_interrupt = 5, perf_interrupt = 5;
+	unsigned long timer_interrupt = GIC_INT_TMR, perf_interrupt = GIC_INT_PERFCTR;
 	unsigned int vpe_ctl;
 
+	if (cpu_has_veic) {
+		/* GIC timer interrupt -> CPU HW Int X (vector X+2) -> map to pin X+2-1 (since GIC adds 1) */
+		timer_interrupt += (GIC_CPU_TO_VEC_OFFSET - GIC_PIN_TO_VEC_OFFSET);
+		/* GIC perfcnt interrupt -> CPU HW Int X (vector X+2) -> map to pin X+2-1 (since GIC adds 1) */
+		perf_interrupt += (GIC_CPU_TO_VEC_OFFSET - GIC_PIN_TO_VEC_OFFSET);
+	}
+
 	/*
 	 * Setup the default performance counter timer interrupts
 	 * for all VPEs
@@ -47,10 +143,18 @@ static void __init vpe_local_setup(unsigned int numvpes)
 		if (vpe_ctl & GIC_VPE_CTL_TIMER_RTBL_MSK)
 			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_TIMER_MAP),
 				 GIC_MAP_TO_PIN_MSK | timer_interrupt);
+		if (cpu_has_veic) {
+			set_vi_handler(timer_interrupt+GIC_PIN_TO_VEC_OFFSET, gic_eic_irq_dispatch);
+			gic_shared_intr_map[timer_interrupt+GIC_PIN_TO_VEC_OFFSET].local_intr_mask |= GIC_VPE_RMASK_TIMER_MSK;
+		}
 
 		if (vpe_ctl & GIC_VPE_CTL_PERFCNT_RTBL_MSK)
 			GICWRITE(GIC_REG(VPE_OTHER, GIC_VPE_PERFCTR_MAP),
 				 GIC_MAP_TO_PIN_MSK | perf_interrupt);
+		if (cpu_has_veic) {
+			set_vi_handler(perf_interrupt+GIC_PIN_TO_VEC_OFFSET, gic_eic_irq_dispatch);
+			gic_shared_intr_map[perf_interrupt+GIC_PIN_TO_VEC_OFFSET].local_intr_mask |= GIC_VPE_RMASK_PERFCNT_MSK;
+		}
 	}
 }
 
@@ -94,8 +198,10 @@ static void gic_irq_ack(struct irq_data *d)
 	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
 	GIC_CLR_INTR_MASK(irq);
 
+#ifndef CONFIG_MIPS_SEAD3
 	if (gic_irq_flags[irq] & GIC_IRQ_FLAG_EDGE)
 		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
+#endif
 }
 
 static void gic_mask_irq(struct irq_data *d)
@@ -112,6 +218,26 @@ static void gic_unmask_irq(struct irq_data *d)
 	GIC_SET_INTR_MASK(irq);
 }
 
+static void gic_finish_irq(struct irq_data *d)
+{
+	unsigned int irq = d->irq - _irqbase;
+#ifdef CONFIG_MIPS_SEAD3
+	unsigned int i;
+	unsigned int irq_source;
+
+	/* clear edge detectors */
+	for (i = 0; i < gic_shared_intr_map[irq].num_shared_intr; i++) {
+		irq_source = gic_shared_intr_map[irq].intr_list[i];
+		if (gic_irq_flags[irq_source] & GIC_IRQ_FLAG_EDGE)
+			GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq_source);
+	}
+#endif
+
+	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
+	/* enable interrupts */
+	GIC_SET_INTR_MASK(irq);
+}
+
 #ifdef CONFIG_SMP
 
 static DEFINE_SPINLOCK(gic_lock);
@@ -154,7 +280,7 @@ static struct irq_chip gic_irq_controller = {
 	.irq_mask		=	gic_mask_irq,
 	.irq_mask_ack		=	gic_mask_irq,
 	.irq_unmask		=	gic_unmask_irq,
-	.irq_eoi		=	gic_unmask_irq,
+	.irq_eoi		=	gic_finish_irq,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	=	gic_set_affinity,
 #endif
@@ -164,6 +290,8 @@ static void __init gic_setup_intr(unsigned int intr, unsigned int cpu,
 	unsigned int pin, unsigned int polarity, unsigned int trigtype,
 	unsigned int flags)
 {
+	struct gic_shared_intr_map *map_ptr;
+
 	/* Setup Intr to Pin mapping */
 	if (pin & GIC_MAP_TO_NMI_MSK) {
 		GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(intr)), pin);
@@ -178,6 +306,13 @@ static void __init gic_setup_intr(unsigned int intr, unsigned int cpu,
 			 GIC_MAP_TO_PIN_MSK | pin);
 		/* Setup Intr to CPU mapping */
 		GIC_SH_MAP_TO_VPE_SMASK(intr, cpu);
+		if (cpu_has_veic) {
+			set_vi_handler(pin+GIC_PIN_TO_VEC_OFFSET, gic_eic_irq_dispatch);
+			map_ptr = &gic_shared_intr_map[pin+GIC_PIN_TO_VEC_OFFSET];
+			if (map_ptr->num_shared_intr >= GIC_MAX_SHARED_INTR)
+				BUG();
+			map_ptr->intr_list[map_ptr->num_shared_intr++] = intr;
+		}
 	}
 
 	/* Setup Intr Polarity */
@@ -191,7 +326,7 @@ static void __init gic_setup_intr(unsigned int intr, unsigned int cpu,
 	/* Initialise per-cpu Interrupt software masks */
 	if (flags & GIC_FLAG_IPI)
 		set_bit(intr, pcpu_masks[cpu].pcpu_mask);
-	if (flags & GIC_FLAG_TRANSPARENT)
+	if ((flags & GIC_FLAG_TRANSPARENT) && (cpu_has_veic == 0))
 		GIC_SET_INTR_MASK(intr);
 	if (trigtype == GIC_TRIG_EDGE)
 		gic_irq_flags[intr] |= GIC_IRQ_FLAG_EDGE;
@@ -201,16 +336,27 @@ static void __init gic_basic_init(int numintrs, int numvpes,
 			struct gic_intr_map *intrmap, int mapsize)
 {
 	unsigned int i, cpu;
+	unsigned int pin_offset = 0;
+
+	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
 
 	/* Setup defaults */
 	for (i = 0; i < numintrs; i++) {
 		GIC_SET_POLARITY(i, GIC_POL_POS);
 		GIC_SET_TRIGGER(i, GIC_TRIG_LEVEL);
 		GIC_CLR_INTR_MASK(i);
-		if (i < GIC_NUM_INTRS)
+		if (i < GIC_NUM_INTRS) {
 			gic_irq_flags[i] = 0;
+			gic_shared_intr_map[i].num_shared_intr = 0;
+			gic_shared_intr_map[i].local_intr_mask = 0;
+		}
 	}
 
+	/* In EIC mode, the HW_INT# is offset by (2-1). */
+	/* Need to subtract one because the GIC will add one (since 0=no intr). */
+	if (cpu_has_veic)
+		pin_offset = (GIC_CPU_TO_VEC_OFFSET - GIC_PIN_TO_VEC_OFFSET);
+
 	/* Setup specifics */
 	for (i = 0; i < mapsize; i++) {
 		cpu = intrmap[i].cpunum;
@@ -220,7 +366,7 @@ static void __init gic_basic_init(int numintrs, int numvpes,
 			continue;
 		gic_setup_intr(i,
 			intrmap[i].cpunum,
-			intrmap[i].pin,
+			intrmap[i].pin + pin_offset,
 			intrmap[i].polarity,
 			intrmap[i].trigtype,
 			intrmap[i].flags);
@@ -228,8 +374,17 @@ static void __init gic_basic_init(int numintrs, int numvpes,
 
 	vpe_local_setup(numvpes);
 
+#ifdef CONFIG_MIPS_SEAD3
+	/* for non-eic mode, we want to setup the GIC in pass-through mode. */
+	/* That is, as if the GIC don't exist. */
+	if (cpu_has_veic) {
+		for (i = _irqbase; i < (_irqbase + numintrs); i++)
+			irq_set_chip_and_handler(i, &gic_irq_controller, handle_percpu_irq);
+	}
+#else
 	for (i = _irqbase; i < (_irqbase + numintrs); i++)
 		irq_set_chip(i, &gic_irq_controller);
+#endif
 }
 
 void __init gic_init(unsigned long gic_base_addr,
@@ -251,6 +406,7 @@ void __init gic_init(unsigned long gic_base_addr,
 
 	numvpes = (gicconfig & GIC_SH_CONFIG_NUMVPES_MSK) >>
 		  GIC_SH_CONFIG_NUMVPES_SHF;
+	numvpes = numvpes + 1;
 
 	pr_debug("%s called\n", __func__);
 
-- 
1.7.9.6
