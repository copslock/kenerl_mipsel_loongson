Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 18:06:54 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39885 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903628Ab2DIQGr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 18:06:47 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SHH73-0005zb-7q; Mon, 09 Apr 2012 11:06:41 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, Chris Dearman <chris@mips.com>
Subject: [PATCH] Add new GIC clocksource.
Date:   Mon,  9 Apr 2012 11:06:34 -0500
Message-Id: <1333987594-950-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add new clocksource that uses the counter present on the
GIC controller.

Signed-off-by: Chris Dearman <chris@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig                |   21 ++++++++-
 arch/mips/include/asm/gic.h      |    3 ++
 arch/mips/include/asm/time.h     |    8 ++--
 arch/mips/kernel/Makefile        |    1 +
 arch/mips/kernel/csrc-gic.c      |   49 +++++++++++++++++++++
 arch/mips/kernel/irq-gic.c       |    3 +-
 arch/mips/mti-malta/malta-time.c |   88 +++++++++++++++++++++++++++-----------
 7 files changed, 141 insertions(+), 32 deletions(-)
 create mode 100644 arch/mips/kernel/csrc-gic.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fae33f3..3a8d277 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -264,7 +264,6 @@ config MIPS_MALTA
 	select BOOT_ELF32
 	select BOOT_RAW
 	select CEVT_R4K
-	select CSRC_R4K
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
 	select HAVE_PCSPKR_PLATFORM
@@ -863,6 +862,24 @@ source "arch/mips/netlogic/Kconfig"
 
 endmenu
 
+menu "Clock source"
+	depends on MIPS_MALTA || MIPS_SEAD3
+
+comment "Select one or more precise CPU clock source kernel modules below:"
+
+config CSRC_R4K
+	bool "R4K count/compare counter"
+	default y if !CSRC_GIC
+	help
+	  Use the R4K count/compare counter for the kernel clock source.
+
+config CSRC_GIC
+	bool "GIC global counter (ROC-it or similar system controller)"
+	help
+	  Use the GIC global counter for the kernel clock source.
+
+endmenu
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
@@ -2031,7 +2048,7 @@ config MIPS_APSP_KSPD
 config MIPS_CMP
 	bool "MIPS CMP framework support"
 	depends on SYS_SUPPORTS_MIPS_CMP
-	select SYNC_R4K
+	select SYNC_R4K if CSRC_R4K
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_SCHED_SMT if SMP
 	select WEAK_ORDERING
diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 991b659..7583417 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -13,6 +13,8 @@
 
 #undef	GICISBYTELITTLEENDIAN
 
+extern unsigned long _gic_base;
+
 /* Constants */
 #define GIC_POL_POS			1
 #define GIC_POL_NEG			0
@@ -345,6 +347,7 @@ extern void gic_init(unsigned long gic_base_addr,
 	unsigned long gic_addrspace_size, struct gic_intr_map *intrmap,
 	unsigned int intrmap_size, unsigned int irqbase);
 
+extern void gic_clocksource_init(unsigned int);
 extern unsigned int gic_get_int(void);
 extern void gic_send_ipi(unsigned int intr);
 extern unsigned int plat_ipi_call_int_xlate(unsigned int);
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index bc14447..96a6c8c 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -77,11 +77,11 @@ extern int init_r4k_clocksource(void);
 
 static inline int init_mips_clocksource(void)
 {
-#ifdef CONFIG_CSRC_R4K
-	return init_r4k_clocksource();
-#else
+	extern int gic_present;
+
+	if (!gic_present)
+		return init_r4k_clocksource();
 	return 0;
-#endif
 }
 
 static inline void clockevent_set_clock(struct clock_event_device *cd,
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 0c6877e..1b9af57 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_CSRC_IOASIC)	+= csrc-ioasic.o
 obj-$(CONFIG_CSRC_POWERTV)	+= csrc-powertv.o
 obj-$(CONFIG_CSRC_R4K_LIB)	+= csrc-r4k.o
 obj-$(CONFIG_CSRC_SB1250)	+= csrc-sb1250.o
+obj-$(CONFIG_CSRC_GIC)		+= csrc-gic.o
 obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
diff --git a/arch/mips/kernel/csrc-gic.c b/arch/mips/kernel/csrc-gic.c
new file mode 100644
index 0000000..82f09c4
--- /dev/null
+++ b/arch/mips/kernel/csrc-gic.c
@@ -0,0 +1,49 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 MIPS Technologies, Inc.
+ */
+#include <linux/clocksource.h>
+#include <linux/init.h>
+
+#include <asm/time.h>
+#include <asm/gic.h>
+
+static cycle_t gic_hpt_read(struct clocksource *cs)
+{
+	unsigned int hi, hi2, lo;
+
+	do {
+		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_63_32), hi);
+		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_31_00), lo);
+		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_63_32), hi2);
+	} while (hi2 != hi);
+
+	return (((cycle_t) hi) << 32) + lo;
+}
+
+static struct clocksource gic_clocksource = {
+	.name	= "GIC",
+	.read	= gic_hpt_read,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+void __init gic_clocksource_init(unsigned int frequency)
+{
+	unsigned int config, bits;
+
+	/* Calculate the clocksource mask. */
+	GICREAD(GIC_REG(SHARED, GIC_SH_CONFIG), config);
+	bits = 32 + ((config & GIC_SH_CONFIG_COUNTBITS_MSK) >>
+		(GIC_SH_CONFIG_COUNTBITS_SHF - 2));
+
+	/* Set clocksource mask. */
+	gic_clocksource.mask = CLOCKSOURCE_MASK(bits);
+
+	/* Calculate a somewhat reasonable rating value. */
+	gic_clocksource.rating = 200 + frequency / 10000000;
+
+	clocksource_register_hz(&gic_clocksource, frequency);
+}
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 275b163..191a255 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -20,7 +20,8 @@
 #include <linux/hardirq.h>
 #include <asm-generic/bitops/find.h>
 
-static unsigned long _gic_base;
+
+unsigned long _gic_base;
 static unsigned int _irqbase;
 static unsigned int gic_irq_flags[GIC_NUM_INTRS];
 #define GIC_IRQ_FLAG_EDGE      0x0001
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 115f5bc..c9b2eaa 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -39,6 +39,7 @@
 #include <asm/time.h>
 #include <asm/mc146818-time.h>
 #include <asm/msc01_ic.h>
+#include <asm/gic.h>
 
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/prom.h>
@@ -50,6 +51,10 @@ unsigned long cpu_khz;
 static int mips_cpu_timer_irq;
 static int mips_cpu_perf_irq;
 extern int cp0_perfcount_irq;
+#ifdef CONFIG_CSRC_GIC
+static int gic_frequency;
+extern int gic_present;
+#endif
 
 static void mips_timer_dispatch(void)
 {
@@ -61,16 +66,23 @@ static void mips_perf_dispatch(void)
 	do_IRQ(mips_cpu_perf_irq);
 }
 
+static unsigned int freqround(unsigned int freq, unsigned int amount)
+{
+	freq += amount;
+	freq -= freq % (amount*2);
+	return freq;
+}
+
 /*
- * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
+ * Estimate CPU (and GIC) frequencies
  */
-static unsigned int __init estimate_cpu_frequency(void)
+static void __init estimate_frequencies(void)
 {
-	unsigned int prid = read_c0_prid() & 0xffff00;
-	unsigned int count;
-
 	unsigned long flags;
-	unsigned int start;
+	unsigned int count, start;
+#ifdef CONFIG_CSRC_GIC
+	unsigned int giccount = 0, gicstart = 0;
+#endif
 
 	local_irq_save(flags);
 
@@ -80,25 +92,34 @@ static unsigned int __init estimate_cpu_frequency(void)
 
 	/* Start r4k counter. */
 	start = read_c0_count();
+#ifdef CONFIG_CSRC_GIC
+	if (gic_present)
+		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_31_00), gicstart);
+#endif
 
 	/* Read counter exactly on falling edge of update flag */
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
 
-	count = read_c0_count() - start;
-
+	count = read_c0_count();
+#ifdef CONFIG_CSRC_GIC
+	if (gic_present)
+		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_31_00), giccount);
+#endif
 	/* restore interrupts */
 	local_irq_restore(flags);
 
-	mips_hpt_frequency = count;
-	if ((prid != (PRID_COMP_MIPS | PRID_IMP_20KC)) &&
-	    (prid != (PRID_COMP_MIPS | PRID_IMP_25KF)))
-		count *= 2;
-
-	count += 5000;    /* round */
-	count -= count%10000;
+	count -= start;
+#ifdef CONFIG_CSRC_GIC
+	if (gic_present)
+		giccount -= gicstart;
+#endif
 
-	return count;
+	mips_hpt_frequency = count;
+#ifdef CONFIG_CSRC_GIC
+	if (gic_present)
+		gic_frequency = giccount;
+#endif
 }
 
 void read_persistent_clock(struct timespec *ts)
@@ -144,22 +165,39 @@ unsigned int __cpuinit get_c0_compare_int(void)
 
 void __init plat_time_init(void)
 {
-	unsigned int est_freq;
-
-        /* Set Data mode - binary. */
-        CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_DM_BINARY, RTC_CONTROL);
-
-	est_freq = estimate_cpu_frequency();
+	unsigned int prid = read_c0_prid() & 0xffff00;
+	unsigned int freq;
 
-	printk("CPU frequency %d.%02d MHz\n", est_freq/1000000,
-	       (est_freq%1000000)*100/1000000);
+	estimate_frequencies();
 
-        cpu_khz = est_freq / 1000;
+	freq = mips_hpt_frequency;
+	if ((prid != (PRID_COMP_MIPS | PRID_IMP_20KC)) &&
+	    (prid != (PRID_COMP_MIPS | PRID_IMP_25KF)))
+		freq *= 2;
+	freq = freqround(freq, 5000);
+	printk("CPU frequency %d.%02d MHz\n", freq/1000000,
+	       (freq%1000000)*100/1000000);
+        cpu_khz = freq / 1000;
+
+#ifdef CONFIG_CSRC_GIC
+	if (gic_present) {
+		freq = gic_frequency;
+		freq = freqround(freq, 5000);
+		printk("GIC frequency %d.%02d MHz\n", freq/1000000,
+		       (freq%1000000)*100/1000000);
+	}
+#endif
 
 	mips_scroll_message();
+
 #ifdef CONFIG_I8253		/* Only Malta has a PIT */
 	setup_pit_timer();
 #endif
 
+#ifdef CONFIG_CSRC_GIC
+	if (gic_present)
+		gic_clocksource_init(gic_frequency);
+#endif
+
 	plat_perf_setup();
 }
-- 
1.7.9.6
