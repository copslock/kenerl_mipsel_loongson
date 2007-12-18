Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 00:33:15 +0000 (GMT)
Received: from mx02.hansenet.de ([213.191.73.26]:6854 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S28577074AbXLRAc1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Dec 2007 00:32:27 +0000
Received: from [213.39.184.147] (213.39.184.147) by webmail.hansenet.de (7.3.118.12) (authenticated as mbx20228207@koeller-hh.org)
        id 4766ADD8000AB815; Tue, 18 Dec 2007 01:31:46 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id C3C8D47C0E;
	Tue, 18 Dec 2007 01:31:40 +0100 (CET)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Date:	Tue, 18 Dec 2007 01:26:50 +0100
Subject: [PATCH 3/4] [MIPS] Allow platform to override default timer and performance counter interrupts
X-Length: 4845
X-UID:	20
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20071218003140.C3C8D47C0E@mail.koeller.dyndns.org>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

While there was a platform hook for setting the compare timer interrupt
before, it was implemented in a somewhat arkward way, and no such hook
existed for the performance counter interrupt. This change aims at a
cleaner solution, by using the platform-supplied values right from the
beginning instead of setting up the standard irq first, and then
ignoring it.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 24a2d90..3b1407e 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -9,6 +9,7 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/percpu.h>
+#include <linux/kernel.h>
 
 #include <asm/smtc_ipi.h>
 #include <asm/time.h>
@@ -76,8 +77,8 @@ static irqreturn_t c0_compare_interrupt(int irq, void 
*dev_id)
 {
 	const int r2 = cpu_has_mips_r2;
 	struct clock_event_device *cd;
-	int cpu = smp_processor_id();
-
+	const int cpu = smp_processor_id();
+	
 	/*
 	 * Suckage alert:
 	 * Before R2 of the architecture there was no way to see if a
@@ -169,9 +170,6 @@ static void mips_event_handler(struct clock_event_device 
*dev)
 {
 }
 
-/*
- * FIXME: This doesn't hold for the relocated E9000 compare interrupt.
- */
 static int c0_compare_int_pending(void)
 {
 	return (read_c0_cause() >> cp0_compare_irq) & 0x100;
@@ -183,7 +181,8 @@ static int c0_compare_int_usable(void)
 	unsigned int cnt;
 
 	/*
-	 * IP7 already pending?  Try to clear it by acking the timer.
+	 * Compare interrupt already pending?
+	 * Try to clear it by acking the timer.
 	 */
 	if (c0_compare_int_pending()) {
 		write_c0_compare(read_c0_count());
@@ -221,8 +220,8 @@ static int c0_compare_int_usable(void)
 
 int __cpuinit mips_clockevent_init(void)
 {
-	uint64_t mips_freq = mips_hpt_frequency;
-	unsigned int cpu = smp_processor_id();
+	const uint64_t mips_freq = mips_hpt_frequency;
+	const unsigned int cpu = smp_processor_id();
 	struct clock_event_device *cd;
 	unsigned int irq;
 
@@ -240,17 +239,12 @@ int __cpuinit mips_clockevent_init(void)
 		return 0;
 #endif
 
-	if (!c0_compare_int_usable())
+	if (!c0_compare_int_usable()) {
+		pr_crit("MIPS compare interrupt not working - no timer clock\n");
 		return -ENXIO;
+	}
 
-	/*
-	 * With vectored interrupts things are getting platform specific.
-	 * get_c0_compare_int is a hook to allow a platform to return the
-	 * interrupt number of it's liking.
-	 */
 	irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
-	if (get_c0_compare_int)
-		irq = get_c0_compare_int();
 
 	cd = &per_cpu(mips_clockevent_device, cpu);
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index fcae667..268247d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1281,6 +1281,20 @@ extern void flush_tlb_handlers(void);
  */
 int cp0_compare_irq;
 
+unsigned int __init __weak
+get_c0_compare_int(void)
+{
+	return cpu_has_mips_r2 ?
+		(read_c0_intctl() >> 29) & 7 : CP0_LEGACY_COMPARE_IRQ;
+}
+
+unsigned int __init __weak
+get_c0_perfcount_int(void)
+{
+	return cpu_has_mips_r2 ?
+		(read_c0_intctl() >> 26) & 7 : -1;
+}
+
 /*
  * Performance counter IRQ or -1 if shared with timer
  */
@@ -1352,21 +1366,11 @@ void __init per_cpu_trap_init(void)
 			set_c0_cause(CAUSEF_IV);
 	}
 
-	/*
-	 * Before R2 both interrupt numbers were fixed to 7, so on R2 only:
-	 *
-	 *  o read IntCtl.IPTI to determine the timer interrupt
-	 *  o read IntCtl.IPPCI to determine the performance counter interrupt
-	 */
-	if (cpu_has_mips_r2) {
-		cp0_compare_irq = (read_c0_intctl() >> 29) & 7;
-		cp0_perfcount_irq = (read_c0_intctl() >> 26) & 7;
-		if (cp0_perfcount_irq == cp0_compare_irq)
-			cp0_perfcount_irq = -1;
-	} else {
-		cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
+	/* Set up timer & performance counter interrupts */
+	cp0_compare_irq = get_c0_compare_int();
+	cp0_perfcount_irq = get_c0_perfcount_int();
+	if (cp0_perfcount_irq == cp0_compare_irq)
 		cp0_perfcount_irq = -1;
-	}
 
 #ifdef CONFIG_MIPS_MT_SMTC
 	}
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
index 7717934..be0d157 100644
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -59,7 +59,8 @@ extern int (*perf_irq)(void);
  */
 #ifdef CONFIG_CEVT_R4K
 extern int mips_clockevent_init(void);
-extern unsigned int __weak get_c0_compare_int(void);
+extern unsigned int get_c0_compare_int(void);
+extern unsigned int get_c0_perfcount_int(void);
 #else
 static inline int mips_clockevent_init(void)
 {
-- 
1.5.3.6
