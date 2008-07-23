Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 18:50:43 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:3548 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28577605AbYGWRul (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Jul 2008 18:50:41 +0100
Received: (qmail 6192 invoked by uid 1000); 23 Jul 2008 19:50:40 +0200
Date:	Wed, 23 Jul 2008 19:50:40 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH 3/8] make cp0 counter clocksource/event usable as fallback.
Message-ID: <20080723175040.GD5986@roarinelk.homelinux.net>
References: <20080723174557.GA5986@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080723174557.GA5986@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

The current mips clock build infrastructure lets a system only use
either the MIPS cp0 counter or a SoC specific timer as a clocksource /
clockevent device.

This patch renames the core cp0 counter clocksource / clockevent functions
from mips_* to r4k_* and updates the wrappers in asm-mips/time.h to
call these renamed functions instead.

Chips which can detect whether it is safe to use a chip-specific timer
can now fall back on the cp0 counter if necessary and possible (e.g. au1xxx).

Existing behaviour is not changed in any way.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/Kconfig           |    8 ++++++++
 arch/mips/kernel/Makefile   |    4 ++--
 arch/mips/kernel/cevt-r4k.c |    2 +-
 arch/mips/kernel/csrc-r4k.c |    2 +-
 include/asm-mips/time.h     |   24 ++++++++++++++++--------
 5 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b9c754f..acad4d9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -690,7 +690,11 @@ config CEVT_DS1287
 config CEVT_GT641XX
 	bool
 
+config CEVT_R4K_LIB
+	bool
+
 config CEVT_R4K
+	select CEVT_R4K_LIB
 	bool
 
 config CEVT_SB1250
@@ -705,7 +709,11 @@ config CSRC_BCM1480
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
index 0fd3197..e8facef 100644
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
1.5.6.3
