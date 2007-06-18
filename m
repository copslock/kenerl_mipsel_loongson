Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 13:41:25 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.168]:9415 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20023208AbXFRMlW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 13:41:22 +0100
Received: by ug-out-1314.google.com with SMTP id m3so1419848ugc
        for <linux-mips@linux-mips.org>; Mon, 18 Jun 2007 05:40:20 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=qk+m5nWWL8g0ypeT65CUt2KTH/dpc5oAPj6Px8Ey84j1tMFUU2lXzi+56VAuKYg7P4rYu7fj4E06eSRS1keuHH9xnP3k6NRUHbDP9H4ueblQULhS1zY5o+z6TeaD6oYQJLyOlAbnJ/VzKCb07Sdvlagbrfyuw5m07wLYfA3VKQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=lnL7uaJWJCOr6y3Oe8qgbH9mm4hFjwhdUFoPsMJ/8LvBdm+dBcYLGg3vWNSwGY6nHPT98X+/Fbj6S2csMn5+Z6kNeZ4Y/Q2QLaf3WfXEEKY5PokhvSklfvPv7X5TP7ms/D5Modn4CgI5RinifG+PAx8jPZvCYta7tsPQAyG+27o=
Received: by 10.66.254.2 with SMTP id b2mr2837313ugi.1182170420636;
        Mon, 18 Jun 2007 05:40:20 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id z40sm9601028ikz.2007.06.18.05.40.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Jun 2007 05:40:18 -0700 (PDT)
Message-ID: <46767D66.50501@innova-card.com>
Date:	Mon, 18 Jun 2007 14:41:10 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
References: <11818164011355-git-send-email-fbuihuu@gmail.com>	 <11818164023940-git-send-email-fbuihuu@gmail.com>	 <20070614111748.GA8223@alpha.franken.de>	 <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>	 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>	 <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>	 <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>	 <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>	 <20070615134948.GB16133@linux-mips.org> <cda58cb80706170636kbff000cw849fa1d5ccf31152@mail.gmail.com>
In-Reply-To: <cda58cb80706170636kbff000cw849fa1d5ccf31152@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> On 6/15/07, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Fri, Jun 15, 2007 at 10:59:00AM +0200, Franck Bui-Huu wrote:
>>
>> > > Please note that this generic calibration code may be used for
>> > >calibrating the CP0 timer too -- all that you need is defining
>> >
>> > Actually the current patchset breaks it since it changes the
>> calibration
>> > code to be used only for the cp0 hpt calibration. I'll change that.
>>
>> To many this really fun it also needs to become possible to calibrate
>> each processor's clock individually - not all MIPS MP systems run their
>> clocks at the same rate.
>>
> 
> OK I've updated patch 5/5, taking into account several raised points.

and for whom interested, here is a working version...

		Franck

---
Subject: [PATCH 6/6] Implement clockevents for R4000-style cp0 timer

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/Kconfig          |    9 +
 arch/mips/kernel/Makefile  |    2 +
 arch/mips/kernel/hpt-cp0.c |  248 ++++++++++++++++++++++++++
 arch/mips/kernel/process.c |    3 +
 arch/mips/kernel/smp.c     |    2 +
 arch/mips/kernel/time.c    |  416 ++++----------------------------------------
 include/asm-mips/hpt.h     |   30 ++++
 include/asm-mips/time.h    |   40 +----
 8 files changed, 330 insertions(+), 420 deletions(-)
 create mode 100644 arch/mips/kernel/hpt-cp0.c
 create mode 100644 include/asm-mips/hpt.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7bcf38d..d852cb0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -723,6 +723,14 @@ config GENERIC_TIME
 	bool
 	default y
 
+config GENERIC_CLOCKEVENTS
+	bool
+	default y
+
+config CP0_HPT_TIMER
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
index 4924626..ffd4352 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -11,6 +11,8 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 binfmt_irix-objs	:= irixelf.o irixinv.o irixioctl.o irixsig.o	\
 			   irix5sys.o sysirix.o
 
+obj-$(CONFIG_CP0_HPT_TIMER)	+= hpt-cp0.o
+
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
diff --git a/arch/mips/kernel/hpt-cp0.c b/arch/mips/kernel/hpt-cp0.c
new file mode 100644
index 0000000..8581a20
--- /dev/null
+++ b/arch/mips/kernel/hpt-cp0.c
@@ -0,0 +1,248 @@
+/*
+ * This is a driver for CP0 hpt.
+ */
+#include <linux/kernel_stat.h>
+#include <linux/spinlock.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+
+
+#include <asm/time.h>
+#include <asm/hpt.h>
+
+
+#define MIPS_HPT_NAME	"cp0-hpt"
+
+
+static unsigned (*cp0_hpt_get_freq)(int cpu) __initdata;
+static irqreturn_t (*perf_handler)(int irq, void *dev_id) __read_mostly;
+
+
+/*
+ * hpt can be disabled by boot command line
+ */
+static int cp0_hpt_disabled __initdata;
+
+static int __init no_cp0_hpt_setup(char *str)
+{
+	cp0_hpt_disabled = 1;
+	return 0;
+}
+early_param("no-cp0-hpt", no_cp0_hpt_setup);
+
+/*
+ * cp0 hpt operations.
+ */
+static void cp0_hpt_ack(void)
+{
+	write_c0_compare(read_c0_compare());
+}
+
+static cycle_t cp0_hpt_read(void)
+{
+        return read_c0_count();
+}
+
+/*
+ * Clocksource functions
+ */
+struct clocksource hpt_clocksource = {
+	.name		= MIPS_HPT_NAME,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.read		= cp0_hpt_read,
+};
+
+/*
+ * FIXME: for a clocksource, rating should not depend on frequency,
+ * stability is something more valuable...
+ */
+static int cp0_hpt_rating(unsigned freq)
+{
+	return 200 + freq / 10000000;
+}
+
+static void __init setup_cp0_hpt_clocksource(void)
+{
+	unsigned freq = cp0_hpt_get_freq(smp_processor_id());
+	unsigned shift = 0;
+	u64 mult;
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
+	hpt_clocksource.rating = cp0_hpt_rating(freq);
+
+	clocksource_register(&hpt_clocksource);
+}
+
+/*
+ * High precision timer functions
+ */
+
+static int cp0_hpt_set_next_event(unsigned long delta,
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
+	return ((long)(read_c0_count() - cnt) > 0L) ? -ETIME : 0;
+}
+
+static void cp0_hpt_set_mode(enum clock_event_mode mode,
+			     struct clock_event_device *evt)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		/*
+		 * For now, we can't disable cp0 hpt interrupts. So we
+		 * leave them enabled, and ignore them in this mode.
+		 * Therefore we will get one useless but also harmless
+		 * interrupt every 2^32 cycles...
+		 */
+		cp0_hpt_ack();
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* nothing to do */
+		break;
+	case CLOCK_EVT_MODE_PERIODIC:
+		BUG();
+	};
+}
+
+static struct clock_event_device hpt_clockevent __initdata = {
+	.name		= MIPS_HPT_NAME,
+	.mode		= CLOCK_EVT_MODE_UNUSED,
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.shift		= 32,
+	.set_mode	= cp0_hpt_set_mode,
+	.set_next_event	= cp0_hpt_set_next_event,
+	.irq		= -1,
+};
+
+static DEFINE_PER_CPU(struct clock_event_device, cp0_hpt_clock_events);
+
+void __init setup_cp0_hpt_clockevent(void)
+{
+	struct clock_event_device *cd;
+	int cpu = smp_processor_id();
+	unsigned freq;
+
+	if (cp0_hpt_disabled)
+		return;
+
+	cd = &__get_cpu_var(cp0_hpt_clock_events);
+
+	memcpy(cd, &hpt_clockevent, sizeof(*cd));
+
+	freq = cp0_hpt_get_freq(cpu);
+
+	cd->mult = div_sc(freq, NSEC_PER_SEC, cd->shift);
+	cd->rating = cp0_hpt_rating(freq);
+	cd->cpumask = cpumask_of_cpu(cpu);
+
+	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
+	cd->min_delta_ns = clockevent_delta2ns(0x10, cd);
+
+	clockevents_register_device(cd);
+
+	printk("Using %u.%03u MHz CP0 high precision timer on CPU #%d.\n",
+	       ((freq + 500) / 1000) / 1000,
+	       ((freq + 500) / 1000) % 1000,
+		cpu);
+}
+
+static irqreturn_t cp0_hpt_interrupt(int irq, void *dev_id)
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
+	if (perf_handler && perf_handler(irq, dev_id) == IRQ_HANDLED)
+		/*
+		 * The performance counter overflow interrupt may be
+		 * shared with the timer interrupt. If it is (!r2)
+		 * then we can't reliably determine if a counter
+		 * interrupt has also happened. So don't check for a
+		 * timer interrupt in this case.
+		 */
+		if (!r2)
+			goto out;
+
+	/*
+	 * The same applies to performance counter interrupts.  But with the
+	 * above we now know that the reason we got here must be a timer
+	 * interrupt.  Being the paranoiacs we are we check anyway.
+	 */
+	if (!r2 || (read_c0_cause() & (1 << 30))) {
+		/*
+		 * We can get interrupts whereas the hpt clock event
+		 * device has been disabled since we can't shut it
+		 * down. So always ack the timer.
+		 */
+		cp0_hpt_ack();
+
+		cd = &__get_cpu_var(cp0_hpt_clock_events);
+		if (likely(cd->mode != CLOCK_EVT_MODE_SHUTDOWN))
+			cd->event_handler(cd);
+	}
+out:
+	return IRQ_HANDLED;
+}
+
+struct irqaction hpt_irqaction = {
+	.handler	= cp0_hpt_interrupt,
+	.flags		= IRQF_DISABLED | IRQF_PERCPU,
+	.name		= MIPS_HPT_NAME,
+};
+
+
+/*
+ * This function is used by platforms which use the hpt as clock
+ * source and timer.
+ */
+int __init setup_cp0_hpt(struct cp0_hpt_info *info)
+{
+	if (cp0_hpt_disabled)
+		goto out;
+	if (!cpu_has_counter)
+		goto disable;
+
+	if (info->irq == 0)
+		goto disable;
+	if (info->get_freq == NULL)
+		goto disable;
+
+	cp0_hpt_get_freq = info->get_freq;
+	perf_handler = info->perf_handler;
+
+	setup_cp0_hpt_clocksource();
+	setup_cp0_hpt_clockevent();
+
+	/* Enable events interrupt. */
+	setup_irq(info->irq, &hpt_irqaction);
+out:
+	return 0;
+disable:
+	printk(KERN_WARNING "Error when starting CP0 hpt... disabled\n");
+	cp0_hpt_disabled = 1;
+	return -EINVAL;
+}
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 6bdfb5a..23b8858 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/completion.h>
 #include <linux/kallsyms.h>
+#include <linux/tick.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -50,6 +51,7 @@ ATTRIB_NORET void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
+		tick_nohz_stop_sched_tick();
 		while (!need_resched()) {
 #ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
 			extern void smtc_idle_loop_hook(void);
@@ -59,6 +61,7 @@ ATTRIB_NORET void cpu_idle(void)
 			if (cpu_wait)
 				(*cpu_wait)();
 		}
+		tick_nohz_restart_sched_tick();
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 67edfa7..85ad130 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -37,6 +37,7 @@
 #include <asm/system.h>
 #include <asm/mmu_context.h>
 #include <asm/smp.h>
+#include <asm/hpt.h>
 
 #ifdef CONFIG_MIPS_MT_SMTC
 #include <asm/mipsmtregs.h>
@@ -79,6 +80,7 @@ asmlinkage __cpuinit void start_secondary(void)
 	cpu_probe();
 	cpu_report();
 	per_cpu_trap_init();
+	setup_cp0_hpt_clockevent(/* calibrate_timer() */);
 	prom_init_secondary();
 
 	/*
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 72df0bf..0cc8363 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -1,48 +1,16 @@
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
+#include <linux/clocksource.h>	/* cycle_t */
 
-#include <asm/bootinfo.h>
-#include <asm/cache.h>
-#include <asm/compiler.h>
-#include <asm/cpu.h>
-#include <asm/cpu-features.h>
-#include <asm/div64.h>
-#include <asm/sections.h>
 #include <asm/time.h>
 
 /*
- * The integer part of the number of usecs per jiffy is taken from tick,
- * but the fractional part is not recorded, so we calculate it using the
- * initial value of HZ.  This aids systems where tick isn't really an
- * integer (e.g. for HZ = 128).
+ * This is the freq of the tick timer of the platform.  It's not
+ * always a _high_ precision timer as its name suggests.
+ *
+ * FIXME: Is it really needed ? shouldn't it be a per cpu value ?
  */
-#define USECS_PER_JIFFY		TICK_SIZE
-#define USECS_PER_JIFFY_FRAC	((unsigned long)(u32)((1000000ULL << 32) / HZ))
-
-#define TICK_SIZE	(tick_nsec / 1000)
+unsigned int mips_hpt_frequency __read_mostly;
 
 /*
  * RTC. By default we provide the null RTC hooks
@@ -79,264 +47,36 @@ int update_persistent_clock(struct timespec now)
 	return mips_rtc_set_mmss(now.tv_sec);
 }
 
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
-{
-	return 0;
-}
-
-/*
- * Timer ack for an R4k-compatible timer of a known frequency.
- */
-static void c0_timer_ack(void)
-{
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
-}
-
-/*
- * High precision timer functions for a R4k-compatible timer.
- */
-static cycle_t c0_hpt_read(void)
-{
-	return read_c0_count();
-}
-
-/* For use both as a high precision timer and an interrupt source.  */
-static void __init c0_hpt_timer_init(void)
-{
-	expirelo = read_c0_count() + cycles_per_jiffy;
-	write_c0_compare(expirelo);
-}
-
-int (*mips_timer_state)(void);
-void (*mips_timer_ack)(void);
-
-/*
- * local_timer_interrupt() does profiling and process accounting
- * on a per-CPU basis.
- *
- * In UP mode, it is invoked from the (global) timer_interrupt.
- *
- * In SMP mode, it might invoked by per-CPU timer interrupt, or
- * a broadcasted inter-processor interrupt which itself is triggered
- * by the global timer interrupt.
- */
-void local_timer_interrupt(int irq)
-{
-	profile_tick(CPU_PROFILING);
-	update_process_times(user_mode(get_irq_regs()));
-}
-
-/*
- * High-level timer interrupt service routines.  This function
- * is set as irqaction->handler and is invoked through do_IRQ.
- */
-irqreturn_t timer_interrupt(int irq, void *dev_id)
-{
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
-}
-
-int null_perf_irq(void)
-{
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
 /*
- * Possibly handle a performance counter interrupt.
- * Return true if the timer interrupt should not be checked
+ * Basically it calls the platform hooks to setup:
+ *	a) RTC
+ *	b) a timer
  */
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
+void __init time_init(void)
 {
-	int cpu = smp_processor_id();
-	int r2 = cpu_has_mips_r2;
-
-	irq_enter();
-	kstat_this_cpu.irqs[irq]++;
-
-#ifdef CONFIG_MIPS_MT_SMTC
 	/*
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
+	 * Mandatory platform hook. It basically setup the RTC.
+	 * FIXME: shouldn't we call these before calling
+	 * timekeeping_init() ?
 	 */
+	plat_time_init();
 
 	/*
-	 * We could be here due to timer interrupt,
-	 * perf counter overflow, or both.
+	 * Platform can setup a new timer, hpt timer...
 	 */
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
+	plat_timer_setup();
 }
 
 
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
-}
-
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
+ * If you don't know timer 'X' frequency and have another timer 'Y'
+ * that flips at HZ rate, you can use this helper to determinate the
+ * timer 'X' freq.
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
+unsigned __init calibrate_timer(cycle_t (*x_read)(void),
+				int (*y_state)(void))
 {
-	cycle_t frequency, hpt_start, hpt_end, hpt_count, hz;
+	cycle_t freq, start, end, count, hz;
 
 	const int loops = HZ / 10;
 	int log_2_loops = 0;
@@ -354,118 +94,24 @@ static unsigned int __init calibrate_hpt(void)
 	/*
 	 * Wait for a rising edge of the timer interrupt.
 	 */
-	while (mips_timer_state());
-	while (!mips_timer_state());
+	while (y_state());
+	while (!y_state());
 
 	/*
 	 * Now see how many high precision timer ticks happen
 	 * during the calculated number of periods between timer
 	 * interrupts.
 	 */
-	hpt_start = clocksource_mips.read();
+	start = x_read();
 	do {
-		while (mips_timer_state());
-		while (!mips_timer_state());
+		while (y_state());
+		while (!y_state());
 	} while (--i);
-	hpt_end = clocksource_mips.read();
+	end = x_read();
 
-	hpt_count = (hpt_end - hpt_start) & clocksource_mips.mask;
+	count = end - start;
 	hz = HZ;
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
-void __init time_init(void)
-{
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
-	/*
-	 * Call board specific timer interrupt setup.
-	 *
-	 * this pointer must be setup in machine setup routine.
-	 *
-	 * Even if a machine chooses to use a low-level timer interrupt,
-	 * it still needs to setup the timer_irqaction.
-	 * In that case, it might be better to set timer_irqaction.handler
-	 * to be NULL function so that we are sure the high-level code
-	 * is not invoked accidentally.
-	 */
-	plat_timer_setup(&timer_irqaction);
+	freq = count * hz;
 
-	init_mips_clocksource();
+	return freq >> log_2_loops;
 }
diff --git a/include/asm-mips/hpt.h b/include/asm-mips/hpt.h
new file mode 100644
index 0000000..2b62827
--- /dev/null
+++ b/include/asm-mips/hpt.h
@@ -0,0 +1,30 @@
+#ifndef _ASM_HPT_H
+#define _ASM_HPT_H
+
+#ifdef CONFIG_CP0_HPT_TIMER
+
+struct cp0_hpt_info {
+	/* FIXME: could we let the user override hpt ops ? */
+	/* FIXME: should we add a disable_irq method ? */
+	int		irq;
+	unsigned	(*get_freq)(int cpu);
+
+	/*
+	 * The performance counter overflow irq may be shared with the
+	 * hpt interrupt. In that case this handler will be called
+	 * during a hpt interrupt.
+	 */
+	irqreturn_t	(*perf_handler)(int irq, void *dev_id);
+};
+
+
+extern int setup_cp0_hpt(struct cp0_hpt_info *info);
+extern void setup_cp0_hpt_clockevent(void);
+
+#else
+
+static inline void setup_cp0_hpt_clockevent(void) {}
+
+#endif	/* CONFIG_CP0_HPT_TIMER */
+
+#endif	/* _ASM_HPT_H */
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
index 33645ed..6d8c9b4 100644
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -16,12 +16,8 @@
 #ifndef _ASM_TIME_H
 #define _ASM_TIME_H
 
-#include <linux/interrupt.h>
-#include <linux/linkage.h>
-#include <linux/ptrace.h>
+#include <linux/clocksource.h>	/* cycle_t */
 #include <linux/rtc.h>
-#include <linux/spinlock.h>
-#include <linux/clocksource.h>
 
 extern spinlock_t rtc_lock;
 
@@ -41,12 +37,6 @@ extern int (*mips_timer_state)(void);
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
@@ -54,32 +44,12 @@ extern struct clocksource clocksource_mips;
 extern void to_tm(unsigned long tim, struct rtc_time *tm);
 
 /*
- * high-level timer interrupt routines.
- */
-extern irqreturn_t timer_interrupt(int irq, void *dev_id);
-
-/*
- * the corresponding low-level timer interrupt routine.
- */
-extern void ll_timer_interrupt(int irq);
-
-/*
- * profiling and process accouting is done separately in local_timer_interrupt
+ * board specific hooks called by time_init().
  */
-extern void local_timer_interrupt(int irq);
-
-/*
- * board specific routines required by time_init().
- */
-struct irqaction;
 extern void plat_time_init(void);
-extern void plat_timer_setup(struct irqaction *irq);
+extern void plat_timer_setup(void);
 
-/*
- * mips_hpt_frequency - must be set if you intend to use an R4k-compatible
- * counter as a timer interrupt source; otherwise it can be set up
- * automagically with an aid of mips_timer_state.
- */
-extern unsigned int mips_hpt_frequency;
+extern unsigned calibrate_timer(cycle_t (*x_read)(void),
+				int (*y_state)(void));
 
 #endif /* _ASM_TIME_H */
-- 
1.5.2.2
