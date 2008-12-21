Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:29:28 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:43949 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24127971AbYLUI0a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:30 +0000
Received: (qmail 3971 invoked from network); 21 Dec 2008 09:24:59 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:59 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 09/14] MIPS: make cp0 counter clocksource/event usable as fallback.
Date:	Sun, 21 Dec 2008 09:26:22 +0100
Message-Id: <45ced0b4c4d707995c92fc9c56bb71e2d383b3f2.1229846414.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <f701f25036ff0e654e2bad646e0103b32cb83d34.1229846414.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
 <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
 <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
 <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net>
 <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net>
 <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net>
 <ad6889e72585d9fa5bedeb080d6d78d91c9e23c9.1229846414.git.mano@roarinelk.homelinux.net>
 <f701f25036ff0e654e2bad646e0103b32cb83d34.1229846414.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21643
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
can now fall back on the cp0 counter if necessary and possible
(e.g. Alchemy with a follow-on patch).

Existing behaviour is not changed in any way.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/Kconfig            |    8 ++++++++
 arch/mips/include/asm/time.h |   24 ++++++++++++++++--------
 arch/mips/kernel/Makefile    |    4 ++--
 arch/mips/kernel/cevt-r4k.c  |    2 +-
 arch/mips/kernel/csrc-r4k.c  |    2 +-
 5 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f4af967..fc23751 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -682,7 +682,11 @@ config CEVT_DS1287
 config CEVT_GT641XX
 	bool
 
+config CEVT_R4K_LIB
+	bool
+
 config CEVT_R4K
+	select CEVT_R4K_LIB
 	bool
 
 config CEVT_SB1250
@@ -697,7 +701,11 @@ config CSRC_BCM1480
 config CSRC_IOASIC
 	bool
 
+config CSRC_R4K_LIB
+	bool
+
 config CSRC_R4K
+	select CSRC_R4K_LIB
 	bool
 
 config CSRC_SB1250
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 9601ea9..38a30d2 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
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
-#ifdef CONFIG_CSRC_R4K
-extern int init_mips_clocksource(void);
-#else
+#ifdef CONFIG_CSRC_R4K_LIB
+extern int init_r4k_clocksource(void);
+#endif
+
 static inline int init_mips_clocksource(void)
 {
+#ifdef CONFIG_CSRC_R4K
+	return init_r4k_clocksource();
+#else
 	return 0;
-}
 #endif
+}
 
 extern void clocksource_set_clock(struct clocksource *cs, unsigned int clock);
 extern void clockevent_set_clock(struct clock_event_device *cd,
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index b1372c2..4e362dc 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -9,7 +9,7 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   time.o topology.o traps.o unaligned.o watch.o
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
-obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
+obj-$(CONFIG_CEVT_R4K_LIB)	+= cevt-r4k.o
 obj-$(CONFIG_MIPS_MT_SMTC)	+= cevt-smtc.o
 obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
 obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
@@ -17,7 +17,7 @@ obj-$(CONFIG_CEVT_SB1250)	+= cevt-sb1250.o
 obj-$(CONFIG_CEVT_TXX9)		+= cevt-txx9.o
 obj-$(CONFIG_CSRC_BCM1480)	+= csrc-bcm1480.o
 obj-$(CONFIG_CSRC_IOASIC)	+= csrc-ioasic.o
-obj-$(CONFIG_CSRC_R4K)		+= csrc-r4k.o
+obj-$(CONFIG_CSRC_R4K_LIB)	+= csrc-r4k.o
 obj-$(CONFIG_CSRC_SB1250)	+= csrc-sb1250.o
 obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 4a4c59f..1105eca 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -160,7 +160,7 @@ int c0_compare_int_usable(void)
 
 #ifndef CONFIG_MIPS_MT_SMTC
 
-int __cpuinit mips_clockevent_init(void)
+int __cpuinit r4k_clockevent_init(void)
 {
 	uint64_t mips_freq = mips_hpt_frequency;
 	unsigned int cpu = smp_processor_id();
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index 74fb745..f1a2893 100644
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
-- 
1.6.0.4
