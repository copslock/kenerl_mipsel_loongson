Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Mar 2013 10:55:52 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:41551 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816823Ab3CQJznlpjB7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Mar 2013 10:55:43 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UH4Ud-0007XO-3S; Sat, 16 Mar 2013 22:42:43 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Raghu Gandham <Raghu.Gandham@imgtec.com>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH] MIPS: Add new GIC clockevent driver.
Date:   Sat, 16 Mar 2013 22:42:10 -0500
Message-Id: <1363491730-1899-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Raghu Gandham <Raghu.Gandham@imgtec.com>

Add new clockevent driver that uses the counter present on the MIPS
Global Interrupt Controller.

Signed-off-by: Raghu Gandham <Raghu.Gandham@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/Kconfig                |    4 ++
 arch/mips/include/asm/gic.h      |   14 +++--
 arch/mips/include/asm/time.h     |    5 ++
 arch/mips/kernel/Makefile        |    1 +
 arch/mips/kernel/cevt-gic.c      |  120 ++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/csrc-gic.c      |   27 ++++++++-
 arch/mips/kernel/irq-gic.c       |   11 ++++
 arch/mips/mti-malta/malta-int.c  |   11 ++--
 arch/mips/mti-malta/malta-time.c |    2 +-
 9 files changed, 183 insertions(+), 12 deletions(-)
 create mode 100644 arch/mips/kernel/cevt-gic.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1945ec3..729cdc4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -296,6 +296,7 @@ config MIPS_MALTA
 	select BOOT_ELF32
 	select BOOT_RAW
 	select CEVT_R4K
+	select CEVT_GIC
 	select CSRC_R4K
 	select CSRC_GIC
 	select DMA_NONCOHERENT
@@ -911,6 +912,9 @@ config CEVT_GT641XX
 config CEVT_R4K
 	bool
 
+config CEVT_GIC
+	bool
+
 config CEVT_SB1250
 	bool
 
diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index bdc9786..5e0e9cf 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -202,7 +202,7 @@
 #define GIC_VPE_WD_COUNT0_OFS		0x0094
 #define GIC_VPE_WD_INITIAL0_OFS		0x0098
 #define GIC_VPE_COMPARE_LO_OFS		0x00a0
-#define GIC_VPE_COMPARE_HI		0x00a4
+#define GIC_VPE_COMPARE_HI_OFS		0x00a4
 
 #define GIC_VPE_EIC_SHADOW_SET_BASE	0x0100
 #define GIC_VPE_EIC_SS(intr) \
@@ -359,27 +359,33 @@ struct gic_shared_intr_map {
 /* Mapped interrupt to pin X, then GIC will generate the vector (X+1). */
 #define GIC_PIN_TO_VEC_OFFSET	(1)
 
+#include <linux/clocksource.h>
+#include <linux/irq.h>
+
 extern int gic_present;
 extern unsigned long _gic_base;
 extern unsigned int gic_irq_base;
 extern unsigned int gic_irq_flags[];
 extern struct gic_shared_intr_map gic_shared_intr_map[];
+extern unsigned int gic_frequency;
 
 extern void gic_init(unsigned long gic_base_addr,
 	unsigned long gic_addrspace_size, struct gic_intr_map *intrmap,
 	unsigned int intrmap_size, unsigned int irqbase);
-
 extern void gic_clocksource_init(unsigned int);
-extern unsigned int gic_get_int(void);
+extern unsigned int gic_compare_int (void);
+extern cycle_t gic_read_count(void);
+extern cycle_t gic_read_compare(void);
+extern void gic_write_compare(cycle_t cnt);
 extern void gic_send_ipi(unsigned int intr);
 extern unsigned int plat_ipi_call_int_xlate(unsigned int);
 extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
 extern void gic_bind_eic_interrupt(int irq, int set);
 extern unsigned int gic_get_timer_pending(void);
+extern unsigned int gic_get_int(void);
 extern void gic_enable_interrupt(int irq_vec);
 extern void gic_disable_interrupt(int irq_vec);
 extern void gic_irq_ack(struct irq_data *d);
 extern void gic_finish_irq(struct irq_data *d);
 extern void gic_platform_init(int irqs, struct irq_chip *irq_controller);
-
 #endif /* _ASM_GICREGS_H */
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index debc800..ab0575c 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -52,6 +52,9 @@ extern int (*perf_irq)(void);
  */
 extern unsigned int __weak get_c0_compare_int(void);
 extern int r4k_clockevent_init(void);
+#ifdef CONFIG_CEVT_GIC
+extern int gic_clockevent_init(void);
+#endif
 
 static inline int mips_clockevent_init(void)
 {
@@ -59,6 +62,8 @@ static inline int mips_clockevent_init(void)
 	extern int smtc_clockevent_init(void);
 
 	return smtc_clockevent_init();
+#elif defined(CONFIG_CEVT_GIC)
+	return (gic_clockevent_init() | r4k_clockevent_init());
 #elif defined(CONFIG_CEVT_R4K)
 	return r4k_clockevent_init();
 #else
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index f81d98f..8b62cf5 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -17,6 +17,7 @@ endif
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
 obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
+obj-$(CONFIG_CEVT_GIC)		+= cevt-gic.o
 obj-$(CONFIG_MIPS_MT_SMTC)	+= cevt-smtc.o
 obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
 obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
diff --git a/arch/mips/kernel/cevt-gic.c b/arch/mips/kernel/cevt-gic.c
new file mode 100644
index 0000000..dcf1654
--- /dev/null
+++ b/arch/mips/kernel/cevt-gic.c
@@ -0,0 +1,120 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 MIPS Technologies, Inc.  All rights reserved.
+ */
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/percpu.h>
+#include <linux/smp.h>
+#include <linux/irq.h>
+
+#include <asm/smtc_ipi.h>
+#include <asm/time.h>
+#include <asm/gic.h>
+#include <asm/mips-boards/maltaint.h>
+/*
+ * The SMTC Kernel for the 34K, 1004K, et. al. replaces several
+ * of these routines with SMTC-specific variants.
+ */
+
+#ifndef CONFIG_MIPS_MT_SMTC
+
+static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
+{
+	u64 cnt;
+	int res;
+
+	cnt = gic_read_count();
+	cnt += (u64)delta;
+	gic_write_compare(cnt);
+	res = ((int)(gic_read_count() - cnt) >= 0) ? -ETIME : 0;
+	return res;
+}
+
+#endif /* CONFIG_MIPS_MT_SMTC */
+
+void gic_set_clock_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	/* Nothing to do ...  */
+}
+
+DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
+int gic_timer_irq_installed;
+
+#ifndef CONFIG_MIPS_MT_SMTC
+
+irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *cd;
+	int cpu = smp_processor_id();
+
+	gic_write_compare(gic_read_compare());
+	cd = &per_cpu(gic_clockevent_device, cpu);
+	cd->event_handler(cd);
+	return IRQ_HANDLED;
+}
+
+#endif /* Not CONFIG_MIPS_MT_SMTC */
+
+struct irqaction gic_compare_irqaction = {
+	.handler = gic_compare_interrupt,
+	.flags = IRQF_PERCPU | IRQF_TIMER,
+	.name = "timer",
+};
+
+
+void gic_event_handler(struct clock_event_device *dev)
+{
+}
+
+#ifndef CONFIG_MIPS_MT_SMTC
+
+int __cpuinit gic_clockevent_init(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *cd;
+	unsigned int irq;
+
+	if (!cpu_has_counter || !gic_frequency)
+		return -ENXIO;
+
+	irq = MIPS_GIC_IRQ_BASE;
+
+	cd = &per_cpu(gic_clockevent_device, cpu);
+
+	cd->name		= "MIPS GIC";
+	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
+
+	clockevent_set_clock(cd, gic_frequency);
+
+	/* Calculate the min / max delta */
+	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
+	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
+
+	cd->rating		= 300;
+	cd->irq			= irq;
+	cd->cpumask		= cpumask_of(cpu);
+	cd->set_next_event	= gic_next_event;
+	cd->set_mode		= gic_set_clock_mode;
+	cd->event_handler	= gic_event_handler;
+
+	clockevents_register_device(cd);
+
+	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_MAP), 0x80000002);
+	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), GIC_VPE_SMASK_CMP_MSK);
+
+	if (gic_timer_irq_installed)
+		return 0;
+
+	gic_timer_irq_installed = 1;
+
+	setup_irq(irq, &gic_compare_irqaction);
+	irq_set_handler(irq, handle_percpu_irq);
+	return 0;
+}
+
+#endif /* Not CONFIG_MIPS_MT_SMTC */
diff --git a/arch/mips/kernel/csrc-gic.c b/arch/mips/kernel/csrc-gic.c
index 5dca24b..6c6e802 100644
--- a/arch/mips/kernel/csrc-gic.c
+++ b/arch/mips/kernel/csrc-gic.c
@@ -5,13 +5,12 @@
  *
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
-#include <linux/clocksource.h>
 #include <linux/init.h>
+#include <linux/time.h>
 
-#include <asm/time.h>
 #include <asm/gic.h>
 
-static cycle_t gic_hpt_read(struct clocksource *cs)
+cycle_t gic_read_count(void)
 {
 	unsigned int hi, hi2, lo;
 
@@ -24,6 +23,28 @@ static cycle_t gic_hpt_read(struct clocksource *cs)
 	return (((cycle_t) hi) << 32) + lo;
 }
 
+void gic_write_compare(cycle_t cnt)
+{
+	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_HI), (int)(cnt >> 32));
+	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_LO),
+		(int)(cnt & 0xffffffff));
+}
+
+cycle_t gic_read_compare(void)
+{
+	unsigned int hi, lo;
+
+	GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_HI), hi);
+	GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_LO), lo);
+
+	return (((cycle_t) hi) << 32) + lo;
+}
+
+static cycle_t gic_hpt_read(struct clocksource *cs)
+{
+	return (cycle_t)gic_read_count();
+}
+
 static struct clocksource gic_clocksource = {
 	.name	= "GIC",
 	.read	= gic_hpt_read,
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 485e6a9..6839964 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -116,6 +116,17 @@ static void __init vpe_local_setup(unsigned int numvpes)
 	}
 }
 
+unsigned int gic_compare_int(void)
+{
+	unsigned int pending;
+
+	GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_PEND), pending);
+	if (pending & GIC_VPE_PEND_CMP_MSK)
+		return 1;
+	else
+		return 0;
+}
+
 unsigned int gic_get_int(void)
 {
 	unsigned int i;
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index e364af7..789e366 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -134,6 +134,9 @@ static void malta_ipi_irqdispatch(void)
 {
 	int irq;
 
+	if (gic_compare_int())
+		do_IRQ(MIPS_GIC_IRQ_BASE);
+
 	irq = gic_get_int();
 	if (irq < 0)
 		return;	 /* interrupt has already been cleared */
@@ -395,9 +398,9 @@ static int __initdata msc_nr_eicirqs = ARRAY_SIZE(msc_eicirqmap);
 #define X GIC_UNUSED
 
 static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
-	{ X, X,		   X,		X,		0 },
-	{ X, X,		   X,		X,		0 },
-	{ X, X,		   X,		X,		0 },
+	{ 0, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 1, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
+	{ 2, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
 	{ 0, GIC_CPU_INT0, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
 	{ 0, GIC_CPU_INT1, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
 	{ 0, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
@@ -405,7 +408,7 @@ static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
 	{ 0, GIC_CPU_INT4, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
 	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
 	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
-	{ X, X,		   X,		X,		0 },
+	{ 3, GIC_CPU_INT2, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
 	{ X, X,		   X,		X,		0 },
 	{ 0, GIC_CPU_INT3, GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
 	{ 0, GIC_CPU_NMI,  GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 5681994..3650fd7a 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -44,7 +44,7 @@
 #include <asm/mips-boards/maltaint.h>
 
 unsigned long cpu_khz;
-int gic_frequency;
+unsigned int gic_frequency;
 
 static int mips_cpu_timer_irq;
 static int mips_cpu_perf_irq;
-- 
1.7.9.5
