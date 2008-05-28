From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Wed, 28 May 2008 08:50:19 +0200
Subject: [PATCH] MIPS: make r4k clocksource/clockevent usable in other codepaths
Message-ID: <20080528065019.L7KWex5gdgCxLMnqiQpjdEncqZJrBdRa5z8uTelx1pM@z>

Make the r4k cp0 counter clocksource and clockevent modules
library code so it may be used e.g. as a fallback in case other
clocksources/events aren't available.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/Kconfig           |    8 ++++++++
 arch/mips/kernel/Makefile   |    4 ++--
 arch/mips/kernel/cevt-r4k.c |    2 +-
 arch/mips/kernel/csrc-r4k.c |    2 +-
 include/asm-mips/time.h     |   24 ++++++++++++++++--------
 5 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e5a7c5d..58168c7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -777,7 +777,11 @@ config CEVT_DS1287
 config CEVT_GT641XX
 	bool
 
+config CEVT_R4K_LIB
+	bool
+
 config CEVT_R4K
+	select CEVT_R4K_LIB
 	bool
 
 config CEVT_SB1250
@@ -792,7 +796,11 @@ config CSRC_BCM1480
 config CSRC_IOASIC
 	bool
 
+config CSRC_R4K_LIB
+	bool
+
 config CSRC_R4K
+	select CSRC_R4K_LIB
 	bool
 
 config CSRC_SB1250
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index cc02440..aa352d6 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -9,14 +9,14 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   time.o topology.o traps.o unaligned.o
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
-obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
+obj-$(CONFIG_CEVT_R4K_LIB)	+= cevt-r4k.o
 obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
 obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
 obj-$(CONFIG_CEVT_SB1250)	+= cevt-sb1250.o
 obj-$(CONFIG_CEVT_TXX9)		+= cevt-txx9.o
 obj-$(CONFIG_CSRC_BCM1480)	+= csrc-bcm1480.o
 obj-$(CONFIG_CSRC_IOASIC)	+= csrc-ioasic.o
-obj-$(CONFIG_CSRC_R4K)		+= csrc-r4k.o
+obj-$(CONFIG_CSRC_R4K_LIB)	+= csrc-r4k.o
 obj-$(CONFIG_CSRC_SB1250)	+= csrc-sb1250.o
 obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 24a2d90..70f6343 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -219,7 +219,7 @@ static int c0_compare_int_usable(void)
 	return 1;
 }
 
-int __cpuinit mips_clockevent_init(void)
+int __cpuinit r4k_clockevent_init(void)
 {
 	uint64_t mips_freq = mips_hpt_frequency;
 	unsigned int cpu = smp_processor_id();
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index 86e026f..8dc1235 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -22,7 +22,7 @@ static struct clocksource clocksource_mips = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-int __init init_mips_clocksource(void)
+int __init init_r4k_clocksource(void)
 {
 	if (!cpu_has_counter || !mips_hpt_frequency)
 		return -ENXIO;
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
index d3bd5c5..01a4c93 100644
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -50,27 +50,35 @@ extern int (*perf_irq)(void);
 /*
  * Initialize the calling CPU's compare interrupt as clockevent device
  */
-#ifdef CONFIG_CEVT_R4K
-extern int mips_clockevent_init(void);
+#ifdef CONFIG_CEVT_R4K_LIB
 extern unsigned int __weak get_c0_compare_int(void);
-#else
+extern int r4k_clockevent_init(void);
+#endif
+
 static inline int mips_clockevent_init(void)
 {
+#ifdef CONFIG_CEVT_R4K
+	return r4k_clockevent_init();
+#else
 	return -ENXIO;
-}
 #endif
+}
 
 /*
  * Initialize the count register as a clocksource
  */
-#ifdef CONFIG_CEVT_R4K
-extern int init_mips_clocksource(void);
-#else
+#ifdef CONFIG_CSRC_R4K_LIB
+extern int init_r4k_clocksource(void);
+#endif
+
 static inline int init_mips_clocksource(void)
 {
+#ifdef CONFIG_CSRC_R4K
+	return init_r4k_clocksource(void);
+#else
 	return 0;
-}
 #endif
+}
 
 extern void clocksource_set_clock(struct clocksource *cs, unsigned int clock);
 extern void clockevent_set_clock(struct clock_event_device *cd,
-- 
1.5.5.1
