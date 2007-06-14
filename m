Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 11:21:47 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.173]:41794 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022756AbXFNKUp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 11:20:45 +0100
Received: by ug-out-1314.google.com with SMTP id m3so647585ugc
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2007 03:19:44 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=UnZthX6JwpAeoVK2/b72/090b88EBLW4jUg81AfDcfUoUwJlj8R838sb2yq0t+N6nE9SDPoqbd3aIfv6UyoK18GqNFXD8/yHui17MI1mDoAqkvU3ajpv64r2VhsolEoRwbzjWl/s5vPOHFAGoQc4zaUIImRcosZPNZ+GbYc+XKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=lieLhaZ5EopyFCg9zMpzSTc+VgH1LwffcTokaC+Vk4PwiChKuXroos7VKrYu1WF8hAFbTyUz0StUrOoObxPcudO9uAr4xq6abEXQDcot07bqgR3LwndseWi8+W0OboD0L9NWw2zbV4D9qgCQZAZyWnXjquu9MMTb4gVK0Bu5Rmo=
Received: by 10.67.92.9 with SMTP id u9mr1981823ugl.1181816384343;
        Thu, 14 Jun 2007 03:19:44 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id y37sm3882323iky.2007.06.14.03.19.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2007 03:19:43 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 0819323F774; Thu, 14 Jun 2007 12:20:03 +0200 (CEST)
To:	linux-mips@linux-mips.org
Subject: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Date:	Thu, 14 Jun 2007 12:20:01 +0200
Message-Id: <11818164024053-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818164011355-git-send-email-fbuihuu@gmail.com>
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/Kconfig          |    9 +
 arch/mips/kernel/Makefile  |    2 +
 arch/mips/kernel/hpt.c     |  294 ++++++++++++++++++++++++++
 arch/mips/kernel/process.c |    2 +
 arch/mips/kernel/smp.c     |    1 +
 arch/mips/kernel/time.c    |  500 +++-----------------------------------------
 arch/mips/lib/Makefile     |    2 +-
 arch/mips/lib/time.c       |   52 +++++
 include/asm-mips/hpt.h     |   16 ++
 include/asm-mips/time.h    |   38 +----
 10 files changed, 413 insertions(+), 503 deletions(-)
 create mode 100644 arch/mips/kernel/hpt.c
 create mode 100644 arch/mips/lib/time.c
 create mode 100644 include/asm-mips/hpt.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7bcf38d..af073f3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -723,6 +723,14 @@ config GENERIC_TIME
 	bool
 	default y
 
+config GENERIC_CLOCKEVENTS
+	bool
+	default y
+
+config HPT_TIMER
+	bool
+	default y
+
 config GENERIC_CMOS_UPDATE
 	bool
 	default y
@@ -1741,6 +1749,7 @@ config HZ
 	default 1000 if HZ_1000
 	default 1024 if HZ_1024
 
+source "kernel/time/Kconfig"
 source "kernel/Kconfig.preempt"
 
 config MIPS_INSANE_LARGE
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 4924626..7cc807c 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -11,6 +11,8 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 binfmt_irix-objs	:= irixelf.o irixinv.o irixioctl.o irixsig.o	\
 			   irix5sys.o sysirix.o
 
+obj-$(CONFIG_HPT_TIMER)		+= hpt.o
+
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
diff --git a/arch/mips/kernel/hpt.c b/arch/mips/kernel/hpt.c
new file mode 100644
index 0000000..0b5dbce
--- /dev/null
+++ b/arch/mips/kernel/hpt.c
@@ -0,0 +1,294 @@
+#include <linux/kernel_stat.h>
+#include <linux/spinlock.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+
+#include <asm/time.h>
+#include <asm/hpt.h>
+
+
+#define MIPS_HPT_NAME	"MIPS-HPT"
+
+/*
+ * FIXME: Is it really needed ? Can it be 'static at least ?
+ */
+unsigned int mips_hpt_frequency __read_mostly;
+
+/*
+ * hpt can be disabled by boot command line
+ */
+static int hpt_disabled __initdata;
+
+static int __init nohpt_setup(char *str)
+{
+	hpt_disabled = 1;
+	return 0;
+}
+early_param("nohpt", nohpt_setup);
+
+/*
+ * cp0 hpt operations. Can be overriden by platform code
+ */
+void __weak mips_hpt_ack(void)
+{
+	write_c0_compare(read_c0_compare());
+}
+
+cycle_t __weak mips_hpt_read(void)
+{
+        return read_c0_count();
+}
+
+/*
+ * Clocksource
+ */
+struct clocksource hpt_clocksource = {
+	.name		= MIPS_HPT_NAME,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.read		= mips_hpt_read,
+};
+
+static int mips_hpt_rating(unsigned freq)
+{
+	return 200 + freq / 10000000;
+}
+
+static void __init setup_hpt_clocksource(unsigned freq)
+{
+	u64 mult;
+	unsigned shift = 0;
+
+	for (shift = 32; shift > 0; shift--) {
+		mult = (u64)NSEC_PER_SEC << shift;
+		do_div(mult, freq);
+		if ((mult >> 32) == 0)
+			break;
+	}
+
+	hpt_clocksource.shift = shift;
+	hpt_clocksource.mult = mult;
+	hpt_clocksource.rating = mips_hpt_rating(freq);
+
+	clocksource_register(&hpt_clocksource);
+}
+
+/*
+ * High precision timer functions for a R4k-compatible timer.
+ */
+
+static int mips_hpt_set_next_event(unsigned long delta,
+				   struct clock_event_device *evt)
+{
+	unsigned int cnt;
+
+	BUG_ON(evt->mode != CLOCK_EVT_MODE_ONESHOT);
+
+	/* interrupt ack is done by setting up the next event */
+	cnt = read_c0_count();
+	cnt += delta;
+	write_c0_compare(cnt);
+
+	return ((long)(read_c0_count() - cnt ) > 0) ? -ETIME : 0;
+}
+
+static void mips_hpt_setup(enum clock_event_mode mode,
+			   struct clock_event_device *evt)
+{
+	/* nothing to do */
+}
+
+static struct clock_event_device hpt_clockevent = {
+	.name		= MIPS_HPT_NAME,
+	.mode		= CLOCK_EVT_MODE_UNUSED,
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.shift		= 32,
+	.set_mode	= mips_hpt_setup,
+	.set_next_event	= mips_hpt_set_next_event,
+	.irq		= -1,
+};
+
+static DEFINE_PER_CPU(struct clock_event_device, hpt_clock_events);
+
+static void __init finalize_hpt_clockevent(unsigned freq)
+{
+	hpt_clockevent.mult = div_sc(freq, NSEC_PER_SEC, 32);
+	hpt_clockevent.max_delta_ns = clockevent_delta2ns(-1, &hpt_clockevent);
+	hpt_clockevent.min_delta_ns = clockevent_delta2ns(+1, &hpt_clockevent);
+	hpt_clockevent.rating = mips_hpt_rating(freq);
+}
+
+void __init setup_hpt_clockevent(void)
+{
+	struct clock_event_device *cd;
+
+	if (hpt_disabled)
+		return;
+
+	cd = &__get_cpu_var(hpt_clock_events);
+
+	memcpy(cd, &hpt_clockevent, sizeof(*cd));
+	cd->cpumask = cpumask_of_cpu(smp_processor_id());
+
+	clockevents_register_device(cd);
+}
+
+/*
+ * Performance counter IRQ or -1 if shared with timer
+ */
+int mipsxx_perfcount_irq;
+
+int null_perf_irq(void)
+{
+	return 0;
+}
+
+int (*perf_irq)(void) = null_perf_irq;
+
+EXPORT_SYMBOL(mipsxx_perfcount_irq);
+EXPORT_SYMBOL(null_perf_irq);
+EXPORT_SYMBOL(perf_irq);
+
+/*
+ * Possibly handle a performance counter interrupt.
+ * Return true if the timer interrupt should not be checked
+ */
+static inline int handle_perf_irq (int r2)
+{
+	/*
+	 * The performance counter overflow interrupt may be shared with the
+	 * timer interrupt (mipsxx_perfcount_irq < 0). If it is and a
+	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
+	 * and we can't reliably determine if a counter interrupt has also
+	 * happened (!r2) then don't check for a timer interrupt.
+	 */
+	return mipsxx_perfcount_irq < 0 &&
+		perf_irq() == IRQ_HANDLED &&
+		!r2;
+}
+
+static irqreturn_t hpt_interrupt(int irq, void *dev_id)
+{
+	const int r2 = cpu_has_mips_r2;
+	struct clock_event_device *cd;
+
+	/*
+	 * Suckage alert:
+	 * Before R2 of the architecture there was no way to see if a
+	 * performance counter interrupt was pending, so we have to run
+	 * the performance counter interrupt handler anyway.
+	 */
+	if (handle_perf_irq(r2))
+		goto out;
+
+	/*
+	 * The same applies to performance counter interrupts.  But with the
+	 * above we now know that the reason we got here must be a timer
+	 * interrupt.  Being the paranoiacs we are we check anyway.
+	 */
+	if (!r2 || (read_c0_cause() & (1 << 30))) {
+		/*
+		 * We always ack the counter since we never shuts it down.
+		 * Therefore we can get interrupts whereas the hpt clock
+		 * event device has been disabled.
+		 */
+		mips_hpt_ack();
+
+		cd = &__get_cpu_var(hpt_clock_events);
+
+		if (cd->mode != CLOCK_EVT_MODE_SHUTDOWN)
+			cd->event_handler(cd);
+	}
+out:
+	return IRQ_HANDLED;
+}
+
+struct irqaction hpt_irqaction = {
+	.handler	= hpt_interrupt,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.name		= MIPS_HPT_NAME,
+};
+
+
+/*
+ * These 2 functions are used by platforms which uses the hpt as
+ * timer.
+ */
+void __init setup_hpt_timer(unsigned freq, unsigned irq)
+{
+	if (!cpu_has_counter || hpt_disabled)
+		return;
+	if (freq == 0)
+		return;
+
+	BUG_ON(freq != mips_hpt_frequency);
+
+	finalize_hpt_clockevent(freq);
+	setup_hpt_clockevent();
+
+	/* Enable hpt interrupt. */
+	setup_irq(irq, &hpt_irqaction);
+
+	printk("Using %u.%03u MHz high precision timer.\n",
+	       ((freq + 500) / 1000) / 1000,
+	       ((freq + 500) / 1000) % 1000);
+}
+
+void __init setup_hpt_clock(unsigned freq)
+{
+	if (!cpu_has_counter || hpt_disabled)
+		return;
+	if (freq == 0)
+		return;
+
+	/* FIXME: shouldn't get rid of mips_hpt_frequency ? */
+	mips_hpt_frequency = freq;
+
+	setup_hpt_clocksource(freq);
+}
+
+/*
+ * If you don't know your hpt frequency and you have another
+ * timer you can use this helper to determinate the hpt freq.
+ */
+unsigned int __init calibrate_hpt(int (*timer_state)(void))
+{
+	cycle_t freq, start, end, count, hz;
+
+	const int loops = HZ / 10;
+	int log_2_loops = 0;
+	int i;
+
+	/*
+	 * We want to calibrate for 0.1s, but to avoid a 64-bit
+	 * division we round the number of loops up to the nearest
+	 * power of 2.
+	 */
+	while (loops > 1 << log_2_loops)
+		log_2_loops++;
+	i = 1 << log_2_loops;
+
+	/*
+	 * Wait for a rising edge of the timer interrupt.
+	 */
+	while (timer_state());
+	while (!timer_state());
+
+	/*
+	 * Now see how many high precision timer ticks happen
+	 * during the calculated number of periods between timer
+	 * interrupts.
+	 */
+	start = mips_hpt_read();
+	do {
+		while (timer_state());
+		while (!timer_state());
+	} while (--i);
+	end = mips_hpt_read();
+
+	count = end - start;
+	hz = HZ;
+	freq = count * hz;
+
+	return freq >> log_2_loops;
+}
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 6bdfb5a..b75aa6c 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -50,6 +50,7 @@ ATTRIB_NORET void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
+		tick_nohz_stop_sched_tick();
 		while (!need_resched()) {
 #ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
 			extern void smtc_idle_loop_hook(void);
@@ -59,6 +60,7 @@ ATTRIB_NORET void cpu_idle(void)
 			if (cpu_wait)
 				(*cpu_wait)();
 		}
+		tick_nohz_restart_sched_tick();
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 67edfa7..0d84d70 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -79,6 +79,7 @@ asmlinkage __cpuinit void start_secondary(void)
 	cpu_probe();
 	cpu_report();
 	per_cpu_trap_init();
+	setup_hpt_clockevent();
 	prom_init_secondary();
 
 	/*
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index a75d63b..3d0a575 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -1,507 +1,75 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- * Copyright (c) 2003, 2004  Maciej W. Rozycki
- *
- * Common time service routines for MIPS machines. See
- * Documentation/mips/time.README.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/param.h>
-#include <linux/time.h>
-#include <linux/timex.h>
-#include <linux/smp.h>
 #include <linux/kernel_stat.h>
 #include <linux/spinlock.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
 
-#include <asm/bootinfo.h>
-#include <asm/cache.h>
-#include <asm/compiler.h>
-#include <asm/cpu.h>
-#include <asm/cpu-features.h>
-#include <asm/div64.h>
-#include <asm/sections.h>
 #include <asm/time.h>
+#include <asm/hpt.h>
 
 /*
- * The integer part of the number of usecs per jiffy is taken from tick,
- * but the fractional part is not recorded, so we calculate it using the
- * initial value of HZ.  This aids systems where tick isn't really an
- * integer (e.g. for HZ = 128).
- */
-#define USECS_PER_JIFFY		TICK_SIZE
-#define USECS_PER_JIFFY_FRAC	((unsigned long)(u32)((1000000ULL << 32) / HZ))
-
-#define TICK_SIZE	(tick_nsec / 1000)
-
-/*
- * forward reference
+ * RTC. By default we provide the null RTC hooks
  */
 DEFINE_SPINLOCK(rtc_lock);
+EXPORT_SYMBOL(rtc_lock);
 
-int __attribute__((weak)) rtc_mips_set_time(unsigned long sec)
-{
-	return 0;
-}
-
-int __attribute__((weak)) rtc_mips_set_mmss(unsigned long nowtime)
-{
-	return rtc_mips_set_time(nowtime);
-}
-
-int update_persistent_clock(struct timespec now)
-{
-	return rtc_mips_set_mmss(now.tv_sec);
-}
-
-/* how many counter cycles in a jiffy */
-static unsigned long cycles_per_jiffy __read_mostly;
-
-/* expirelo is the count value for next CPU timer interrupt */
-static unsigned int expirelo;
-
-
-/*
- * Null timer ack for systems not needing one (e.g. i8254).
- */
-static void null_timer_ack(void) { /* nothing */ }
-
-/*
- * Null high precision timer functions for systems lacking one.
- */
-static cycle_t null_hpt_read(void)
+unsigned long __weak mips_rtc_get_time(void)
 {
 	return 0;
 }
 
-/*
- * Timer ack for an R4k-compatible timer of a known frequency.
- */
-static void c0_timer_ack(void)
+int __weak mips_rtc_set_time(unsigned long sec)
 {
-	unsigned int count;
-
-	/* Ack this timer interrupt and set the next one.  */
-	expirelo += cycles_per_jiffy;
-	write_c0_compare(expirelo);
-
-	/* Check to see if we have missed any timer interrupts.  */
-	while (((count = read_c0_count()) - expirelo) < 0x7fffffff) {
-		/* missed_timer_count++; */
-		expirelo = count + cycles_per_jiffy;
-		write_c0_compare(expirelo);
-	}
+	return rtc_mips_set_time(sec);
 }
 
-/*
- * High precision timer functions for a R4k-compatible timer.
- */
-static cycle_t c0_hpt_read(void)
-{
-	return read_c0_count();
-}
+int __weak mips_rtc_set_mmss(unsigned long time)
+ {
+	return mips_rtc_set_time(time);
+ }
 
-/* For use both as a high precision timer and an interrupt source.  */
-static void __init c0_hpt_timer_init(void)
+int update_persistent_clock(struct timespec now)
 {
-	expirelo = read_c0_count() + cycles_per_jiffy;
-	write_c0_compare(expirelo);
+	return mips_rtc_set_mmss(now.tv_sec);
 }
 
-int (*mips_timer_state)(void);
-void (*mips_timer_ack)(void);
-
+#if 0
 /*
- * local_timer_interrupt() does profiling and process accounting
- * on a per-CPU basis.
- *
- * In UP mode, it is invoked from the (global) timer_interrupt.
- *
- * In SMP mode, it might invoked by per-CPU timer interrupt, or
- * a broadcasted inter-processor interrupt which itself is triggered
- * by the global timer interrupt.
+ * FIXME: we need to init rtc earlier since timekeeping_init()
+ * is called before time_init().
  */
-void local_timer_interrupt(int irq)
+unsigned long read_persistent_clock(void)
 {
-	profile_tick(CPU_PROFILING);
-	update_process_times(user_mode(get_irq_regs()));
+	return mips_rtc_get_time();
 }
+#endif
 
-/*
- * High-level timer interrupt service routines.  This function
- * is set as irqaction->handler and is invoked through do_IRQ.
- */
-irqreturn_t timer_interrupt(int irq, void *dev_id)
+/* only during transition period */
+unsigned long rtc_mips_get_time(void)
 {
-	write_seqlock(&xtime_lock);
-
-	mips_timer_ack();
-
-	/*
-	 * call the generic timer interrupt handling
-	 */
-	do_timer(1);
-
-	write_sequnlock(&xtime_lock);
-
-	/*
-	 * In UP mode, we call local_timer_interrupt() to do profiling
-	 * and process accouting.
-	 *
-	 * In SMP mode, local_timer_interrupt() is invoked by appropriate
-	 * low-level local timer interrupt handler.
-	 */
-	local_timer_interrupt(irq);
-
-	return IRQ_HANDLED;
+	return mips_rtc_get_time();
 }
+EXPORT_SYMBOL(rtc_mips_get_time);
 
-int null_perf_irq(void)
+int rtc_mips_set_time(unsigned long sec)
 {
-	return 0;
-}
-
-EXPORT_SYMBOL(null_perf_irq);
-
-int (*perf_irq)(void) = null_perf_irq;
-
-EXPORT_SYMBOL(perf_irq);
-
-/*
- * Performance counter IRQ or -1 if shared with timer
- */
-int mipsxx_perfcount_irq;
-EXPORT_SYMBOL(mipsxx_perfcount_irq);
-
-/*
- * Possibly handle a performance counter interrupt.
- * Return true if the timer interrupt should not be checked
- */
-static inline int handle_perf_irq(int r2)
-{
-	/*
-	 * The performance counter overflow interrupt may be shared with the
-	 * timer interrupt (mipsxx_perfcount_irq < 0). If it is and a
-	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
-	 * and we can't reliably determine if a counter interrupt has also
-	 * happened (!r2) then don't check for a timer interrupt.
-	 */
-	return (mipsxx_perfcount_irq < 0) &&
-		perf_irq() == IRQ_HANDLED &&
-		!r2;
-}
-
-extern void smtc_timer_broadcast(int);
-
-void ll_timer_interrupt(int irq)
-{
-	int cpu = smp_processor_id();
-	int r2 = cpu_has_mips_r2;
-
-	irq_enter();
-	kstat_this_cpu.irqs[irq]++;
-
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 *  In an SMTC system, one Count/Compare set exists per VPE.
-	 *  Which TC within a VPE gets the interrupt is essentially
-	 *  random - we only know that it shouldn't be one with
-	 *  IXMT set. Whichever TC gets the interrupt needs to
-	 *  send special interprocessor interrupts to the other
-	 *  TCs to make sure that they schedule, etc.
-	 *
-	 *  That code is specific to the SMTC kernel, not to
-	 *  the a particular platform, so it's invoked from
-	 *  the general MIPS timer_interrupt routine.
-	 */
-
-	/*
-	 * We could be here due to timer interrupt,
-	 * perf counter overflow, or both.
-	 */
-	(void) handle_perf_irq(1);
-
-	if (read_c0_cause() & (1 << 30)) {
-		/*
-		 * There are things we only want to do once per tick
-		 * in an "MP" system.   One TC of each VPE will take
-		 * the actual timer interrupt.  The others will get
-		 * timer broadcast IPIs. We use whoever it is that takes
-		 * the tick on VPE 0 to run the full timer_interrupt().
-		 */
-		if (cpu_data[cpu].vpe_id == 0) {
-			timer_interrupt(irq, NULL);
-		} else {
-			write_c0_compare(read_c0_count() +
-			                 (mips_hpt_frequency/HZ));
-			local_timer_interrupt(irq);
-		}
-		smtc_timer_broadcast(cpu_data[cpu].vpe_id);
-	}
-#else /* CONFIG_MIPS_MT_SMTC */
-	if (handle_perf_irq(r2))
-		goto out;
-
-	if (r2 && ((read_c0_cause() & (1 << 30)) == 0))
-		goto out;
-
-	if (cpu == 0) {
-		/*
-		 * CPU 0 handles the global timer interrupt job and process
-		 * accounting resets count/compare registers to trigger next
-		 * timer int.
-		 */
-		timer_interrupt(irq, NULL);
-	} else {
-		/* Everyone else needs to reset the timer int here as
-		   ll_local_timer_interrupt doesn't */
-		/*
-		 * FIXME: need to cope with counter underflow.
-		 * More support needs to be added to kernel/time for
-		 * counter/timer interrupts on multiple CPU's
-		 */
-		write_c0_compare(read_c0_count() + (mips_hpt_frequency/HZ));
-
-		/*
-		 * Other CPUs should do profiling and process accounting
-		 */
-		local_timer_interrupt(irq);
-	}
-out:
-#endif /* CONFIG_MIPS_MT_SMTC */
-
-	irq_exit();
-}
-
-
-asmlinkage void ll_local_timer_interrupt(int irq)
-{
-	irq_enter();
-	if (smp_processor_id() != 0)
-		kstat_this_cpu.irqs[irq]++;
-
-	/* we keep interrupt disabled all the time */
-	local_timer_interrupt(irq);
-
-	irq_exit();
+	return mips_rtc_set_time(sec);
 }
+EXPORT_SYMBOL(rtc_mips_set_time);
 
 /*
- * time_init() - it does the following things.
- *
- * 1) plat_time_init() -
- * 	a) (optional) set up RTC routines,
- *      b) (optional) calibrate and set the mips_hpt_frequency
- *	    (only needed if you intended to use cpu counter as timer interrupt
- *	     source)
- * 2) calculate a couple of cached variables for later usage
- * 3) plat_timer_setup() -
- *	a) (optional) over-write any choices made above by time_init().
- *	b) machine specific code should setup the timer irqaction.
- *	c) enable the timer interrupt
+ * Basically it calls platform hooks to set up
+ *	a) RTC
+ *	b) a timer
  */
-
-unsigned int mips_hpt_frequency;
-
-static struct irqaction timer_irqaction = {
-	.handler = timer_interrupt,
-	.flags = IRQF_DISABLED | IRQF_PERCPU,
-	.name = "timer",
-};
-
-static unsigned int __init calibrate_hpt(void)
-{
-	cycle_t frequency, hpt_start, hpt_end, hpt_count, hz;
-
-	const int loops = HZ / 10;
-	int log_2_loops = 0;
-	int i;
-
-	/*
-	 * We want to calibrate for 0.1s, but to avoid a 64-bit
-	 * division we round the number of loops up to the nearest
-	 * power of 2.
-	 */
-	while (loops > 1 << log_2_loops)
-		log_2_loops++;
-	i = 1 << log_2_loops;
-
-	/*
-	 * Wait for a rising edge of the timer interrupt.
-	 */
-	while (mips_timer_state());
-	while (!mips_timer_state());
-
-	/*
-	 * Now see how many high precision timer ticks happen
-	 * during the calculated number of periods between timer
-	 * interrupts.
-	 */
-	hpt_start = clocksource_mips.read();
-	do {
-		while (mips_timer_state());
-		while (!mips_timer_state());
-	} while (--i);
-	hpt_end = clocksource_mips.read();
-
-	hpt_count = (hpt_end - hpt_start) & clocksource_mips.mask;
-	hz = HZ;
-	frequency = hpt_count * hz;
-
-	return frequency >> log_2_loops;
-}
-
-struct clocksource clocksource_mips = {
-	.name		= "MIPS",
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static void __init init_mips_clocksource(void)
-{
-	u64 temp;
-	u32 shift;
-
-	if (!mips_hpt_frequency || clocksource_mips.read == null_hpt_read)
-		return;
-
-	/* Calclate a somewhat reasonable rating value */
-	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
-	/* Find a shift value */
-	for (shift = 32; shift > 0; shift--) {
-		temp = (u64) NSEC_PER_SEC << shift;
-		do_div(temp, mips_hpt_frequency);
-		if ((temp >> 32) == 0)
-			break;
-	}
-	clocksource_mips.shift = shift;
-	clocksource_mips.mult = (u32)temp;
-
-	clocksource_register(&clocksource_mips);
-}
-
-void __init __weak plat_time_init(void)
-{
-}
-
 void __init time_init(void)
 {
-	plat_time_init();
-
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
-		/* We know counter frequency.  Or we can get it.  */
-		if (!clocksource_mips.read) {
-			/* No external high precision timer -- use R4k.  */
-			clocksource_mips.read = c0_hpt_read;
-
-			if (!mips_timer_state) {
-				/* No external timer interrupt -- use R4k.  */
-				mips_timer_ack = c0_timer_ack;
-				/* Calculate cache parameters.  */
-				cycles_per_jiffy =
-					(mips_hpt_frequency + HZ / 2) / HZ;
-				/*
-				 * This sets up the high precision
-				 * timer for the first interrupt.
-				 */
-				c0_hpt_timer_init();
-			}
-		}
-		if (!mips_hpt_frequency)
-			mips_hpt_frequency = calibrate_hpt();
-
-		/* Report the high precision timer rate for a reference.  */
-		printk("Using %u.%03u MHz high precision timer.\n",
-		       ((mips_hpt_frequency + 500) / 1000) / 1000,
-		       ((mips_hpt_frequency + 500) / 1000) % 1000);
-	}
-
-	if (!mips_timer_ack)
-		/* No timer interrupt ack (e.g. i8254).  */
-		mips_timer_ack = null_timer_ack;
-
 	/*
-	 * Call board specific timer interrupt setup.
-	 *
-	 * this pointer must be setup in machine setup routine.
-	 *
-	 * Even if a machine chooses to use a low-level timer interrupt,
-	 * it still needs to setup the timer_irqaction.
-	 * In that case, it might be better to set timer_irqaction.handler
-	 * to be NULL function so that we are sure the high-level code
-	 * is not invoked accidentally.
+	 * Mandatory platform hook. It basically setup the RTC.
+	 * FIXME: shouldn't we call these before calling
+	 * timekeeping_init() ?
 	 */
-	plat_timer_setup(&timer_irqaction);
-
-	init_mips_clocksource();
-}
-
-#define FEBRUARY		2
-#define STARTOFTIME		1970
-#define SECDAY			86400L
-#define SECYR			(SECDAY * 365)
-#define leapyear(y)		((!((y) % 4) && ((y) % 100)) || !((y) % 400))
-#define days_in_year(y)		(leapyear(y) ? 366 : 365)
-#define days_in_month(m)	(month_days[(m) - 1])
-
-static int month_days[12] = {
-	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
-};
-
-void to_tm(unsigned long tim, struct rtc_time *tm)
-{
-	long hms, day, gday;
-	int i;
-
-	gday = day = tim / SECDAY;
-	hms = tim % SECDAY;
-
-	/* Hours, minutes, seconds are easy */
-	tm->tm_hour = hms / 3600;
-	tm->tm_min = (hms % 3600) / 60;
-	tm->tm_sec = (hms % 3600) % 60;
-
-	/* Number of years in days */
-	for (i = STARTOFTIME; day >= days_in_year(i); i++)
-		day -= days_in_year(i);
-	tm->tm_year = i;
-
-	/* Number of months in days left */
-	if (leapyear(tm->tm_year))
-		days_in_month(FEBRUARY) = 29;
-	for (i = 1; day >= days_in_month(i); i++)
-		day -= days_in_month(i);
-	days_in_month(FEBRUARY) = 28;
-	tm->tm_mon = i - 1;		/* tm_mon starts from 0 to 11 */
-
-	/* Days are what is left over (+1) from all that. */
-	tm->tm_mday = day + 1;
+	plat_time_init();
 
 	/*
-	 * Determine the day of week
+	 * Platform can setup a new timer, hpt timer or both...
 	 */
-	tm->tm_wday = (gday + 4) % 7;	/* 1970/1/1 was Thursday */
+	plat_timer_setup();
 }
-
-EXPORT_SYMBOL(rtc_lock);
-EXPORT_SYMBOL(to_tm);
-EXPORT_SYMBOL(rtc_mips_set_time);
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 5dad13e..447e803 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -3,7 +3,7 @@
 #
 
 lib-y	+= csum_partial.o memcpy.o memcpy-inatomic.o memset.o strlen_user.o \
-	   strncpy_user.o strnlen_user.o uncached.o
+	   strncpy_user.o strnlen_user.o time.o uncached.o
 
 obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
diff --git a/arch/mips/lib/time.c b/arch/mips/lib/time.c
new file mode 100644
index 0000000..e561050
--- /dev/null
+++ b/arch/mips/lib/time.c
@@ -0,0 +1,52 @@
+#include <asm/time.h>
+
+/*
+ * to_tm(). FIXME: should be shared with all archs...
+ */
+#define FEBRUARY		2
+#define STARTOFTIME		1970
+#define SECDAY			86400L
+#define SECYR			(SECDAY * 365)
+#define leapyear(y)		((!((y) % 4) && ((y) % 100)) || !((y) % 400))
+#define days_in_year(y)		(leapyear(y) ? 366 : 365)
+#define days_in_month(m)	(month_days[(m) - 1])
+
+static int month_days[12] = {
+	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
+};
+
+void to_tm(unsigned long tim, struct rtc_time *tm)
+{
+	long hms, day, gday;
+	int i;
+
+	gday = day = tim / SECDAY;
+	hms = tim % SECDAY;
+
+	/* Hours, minutes, seconds are easy */
+	tm->tm_hour = hms / 3600;
+	tm->tm_min = (hms % 3600) / 60;
+	tm->tm_sec = (hms % 3600) % 60;
+
+	/* Number of years in days */
+	for (i = STARTOFTIME; day >= days_in_year(i); i++)
+		day -= days_in_year(i);
+	tm->tm_year = i;
+
+	/* Number of months in days left */
+	if (leapyear(tm->tm_year))
+		days_in_month(FEBRUARY) = 29;
+	for (i = 1; day >= days_in_month(i); i++)
+		day -= days_in_month(i);
+	days_in_month(FEBRUARY) = 28;
+	tm->tm_mon = i - 1;		/* tm_mon starts from 0 to 11 */
+
+	/* Days are what is left over (+1) from all that. */
+	tm->tm_mday = day + 1;
+
+	/*
+	 * Determine the day of week
+	 */
+	tm->tm_wday = (gday + 4) % 7;	/* 1970/1/1 was Thursday */
+}
+EXPORT_SYMBOL(to_tm);
diff --git a/include/asm-mips/hpt.h b/include/asm-mips/hpt.h
new file mode 100644
index 0000000..08f7650
--- /dev/null
+++ b/include/asm-mips/hpt.h
@@ -0,0 +1,16 @@
+#ifndef _ASM_HPT_H
+#define _ASM_HPT_H
+
+/*
+ * mips_hpt_frequency - must be set if you intend to use an R4k-compatible
+ * counter as a timer interrupt source; otherwise it can be set up
+ * automagically with an aid of mips_timer_state.
+ */
+extern unsigned int mips_hpt_frequency;
+
+
+extern void setup_hpt_clock(unsigned freq);
+extern void setup_hpt_timer(unsigned freq, unsigned irq);
+extern unsigned calibrate_hpt(int (*timer_state)(void));
+
+#endif	/* _ASM_HPT_H */
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
index 9a49a93..e63e51a 100644
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -16,12 +16,7 @@
 #ifndef _ASM_TIME_H
 #define _ASM_TIME_H
 
-#include <linux/interrupt.h>
-#include <linux/linkage.h>
-#include <linux/ptrace.h>
 #include <linux/rtc.h>
-#include <linux/spinlock.h>
-#include <linux/clocksource.h>
 
 extern spinlock_t rtc_lock;
 
@@ -43,12 +38,6 @@ extern int (*mips_timer_state)(void);
 extern void (*mips_timer_ack)(void);
 
 /*
- * High precision timer clocksource.
- * If .read is NULL, an R4k-compatible timer setup is attempted.
- */
-extern struct clocksource clocksource_mips;
-
-/*
  * to_tm() converts system time back to (year, mon, day, hour, min, sec).
  * It is intended to help implement rtc_set_time() functions.
  * Copied from PPC implementation.
@@ -56,32 +45,9 @@ extern struct clocksource clocksource_mips;
 extern void to_tm(unsigned long tim, struct rtc_time *tm);
 
 /*
- * high-level timer interrupt routines.
- */
-extern irqreturn_t timer_interrupt(int irq, void *dev_id);
-
-/*
- * the corresponding low-level timer interrupt routine.
+ * board specific hooks called by time_init().
  */
-extern void ll_timer_interrupt(int irq);
-
-/*
- * profiling and process accouting is done separately in local_timer_interrupt
- */
-extern void local_timer_interrupt(int irq);
-
-/*
- * board specific routines required by time_init().
- */
-struct irqaction;
 extern void plat_time_init(void);
-extern void plat_timer_setup(struct irqaction *irq);
-
-/*
- * mips_hpt_frequency - must be set if you intend to use an R4k-compatible
- * counter as a timer interrupt source; otherwise it can be set up
- * automagically with an aid of mips_timer_state.
- */
-extern unsigned int mips_hpt_frequency;
+extern void plat_timer_setup(void);
 
 #endif /* _ASM_TIME_H */
-- 
1.5.2.1
