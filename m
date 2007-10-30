Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 16:20:35 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:11204 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025008AbXJ3QU1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2007 16:20:27 +0000
Received: from localhost (p5091-ipad31funabasi.chiba.ocn.ne.jp [221.189.129.91])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E935A9981; Wed, 31 Oct 2007 01:19:04 +0900 (JST)
Date:	Wed, 31 Oct 2007 01:21:03 +0900 (JST)
Message-Id: <20071031.012103.128619208.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] More time cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Do not include unnecessary headers.
* Do not mention time.README.
* Do not mention mips_timer_ack.
* Make clocksource_mips static.  It is now dedicated to c0_timer.
* Initialize clocksource_mips.read statically.
* Remove null_hpt_read.
* Remove an argument of plat_timer_setup.  It is just a placeholder.

 arch/mips/kernel/time.c                |   57 ++++++-------------------------
 arch/mips/qemu/q-irq.c                 |    1 +
 include/asm-mips/time.h                |   13 -------
 3 files changed, 12 insertions(+), 59 deletions(-)

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 622379b..3284b9b 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -3,8 +3,7 @@
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
  * Copyright (c) 2003, 2004  Maciej W. Rozycki
  *
- * Common time service routines for MIPS machines. See
- * Documentation/mips/time.README.
+ * Common time service routines for MIPS machines.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -18,28 +17,17 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/param.h>
-#include <linux/profile.h>
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/smp.h>
-#include <linux/kernel_stat.h>
 #include <linux/spinlock.h>
-#include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/kallsyms.h>
 
-#include <asm/bootinfo.h>
-#include <asm/cache.h>
-#include <asm/compiler.h>
-#include <asm/cpu.h>
 #include <asm/cpu-features.h>
 #include <asm/div64.h>
-#include <asm/sections.h>
 #include <asm/smtc_ipi.h>
 #include <asm/time.h>
 
-#include <irq.h>
-
 /*
  * forward reference
  */
@@ -63,14 +51,6 @@ int update_persistent_clock(struct timespec now)
 }
 
 /*
- * Null high precision timer functions for systems lacking one.
- */
-static cycle_t null_hpt_read(void)
-{
-	return 0;
-}
-
-/*
  * High precision timer functions for a R4k-compatible timer.
  */
 static cycle_t c0_hpt_read(void)
@@ -104,6 +84,13 @@ EXPORT_SYMBOL(perf_irq);
 
 unsigned int mips_hpt_frequency;
 
+static struct clocksource clocksource_mips = {
+	.name		= "MIPS",
+	.read		= c0_hpt_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 static unsigned int __init calibrate_hpt(void)
 {
 	cycle_t frequency, hpt_start, hpt_end, hpt_count, hz;
@@ -146,12 +133,6 @@ static unsigned int __init calibrate_hpt(void)
 	return frequency >> log_2_loops;
 }
 
-struct clocksource clocksource_mips = {
-	.name		= "MIPS",
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 void __init clocksource_set_clock(struct clocksource *cs, unsigned int clock)
 {
 	u64 temp;
@@ -187,9 +168,6 @@ void __cpuinit clockevent_set_clock(struct clock_event_device *cd,
 
 static void __init init_mips_clocksource(void)
 {
-	if (!mips_hpt_frequency || clocksource_mips.read == null_hpt_read)
-		return;
-
 	/* Calclate a somewhat reasonable rating value */
 	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
 
@@ -211,7 +189,7 @@ void __init __weak plat_time_init(void)
  * setup_irq calls and each clock_event_device should use its own
  * struct irqrequest.
  */
-void __init plat_timer_setup(struct irqaction *irq)
+void __init plat_timer_setup(void)
 {
 	BUG();
 }
@@ -220,21 +198,8 @@ void __init time_init(void)
 {
 	plat_time_init();
 
-	/* Choose appropriate high precision timer routines.  */
-	if (!cpu_has_counter && !clocksource_mips.read)
-		/* No high precision timer -- sorry.  */
-		clocksource_mips.read = null_hpt_read;
-	else if (!mips_hpt_frequency && !mips_timer_state) {
-		/* A high precision timer of unknown frequency.  */
-		if (!clocksource_mips.read)
-			/* No external high precision timer -- use R4k.  */
-			clocksource_mips.read = c0_hpt_read;
-	} else {
+	if (cpu_has_counter && (mips_hpt_frequency || mips_timer_state)) {
 		/* We know counter frequency.  Or we can get it.  */
-		if (!clocksource_mips.read) {
-			/* No external high precision timer -- use R4k.  */
-			clocksource_mips.read = c0_hpt_read;
-		}
 		if (!mips_hpt_frequency)
 			mips_hpt_frequency = calibrate_hpt();
 
@@ -242,8 +207,8 @@ void __init time_init(void)
 		printk("Using %u.%03u MHz high precision timer.\n",
 		       ((mips_hpt_frequency + 500) / 1000) / 1000,
 		       ((mips_hpt_frequency + 500) / 1000) % 1000);
+		init_mips_clocksource();
 	}
 
-	init_mips_clocksource();
 	mips_clockevent_init();
 }
diff --git a/arch/mips/qemu/q-irq.c b/arch/mips/qemu/q-irq.c
index 4681757..11f9847 100644
--- a/arch/mips/qemu/q-irq.c
+++ b/arch/mips/qemu/q-irq.c
@@ -1,4 +1,5 @@
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/linkage.h>
 
 #include <asm/i8259.h>
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
index a45f24a..ee1663e 100644
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -10,15 +10,10 @@
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
- *
- * Please refer to Documentation/mips/time.README.
  */
 #ifndef _ASM_TIME_H
 #define _ASM_TIME_H
 
-#include <linux/interrupt.h>
-#include <linux/linkage.h>
-#include <linux/ptrace.h>
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
 #include <linux/clockchips.h>
@@ -38,20 +33,12 @@ extern int rtc_mips_set_mmss(unsigned long);
 /*
  * Timer interrupt functions.
  * mips_timer_state is needed for high precision timer calibration.
- * mips_timer_ack may be NULL if the interrupt is self-recoverable.
  */
 extern int (*mips_timer_state)(void);
 
 /*
- * High precision timer clocksource.
- * If .read is NULL, an R4k-compatible timer setup is attempted.
- */
-extern struct clocksource clocksource_mips;
-
-/*
  * board specific routines required by time_init().
  */
-struct irqaction;
 extern void plat_time_init(void);
 
 /*
