Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 02:07:26 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:49658 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225250AbUDTBHY>;
	Tue, 20 Apr 2004 02:07:24 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i3K17Kx6020489;
	Mon, 19 Apr 2004 18:07:20 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i3K17KXO020487;
	Mon, 19 Apr 2004 18:07:20 -0700
Date: Mon, 19 Apr 2004 18:07:20 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [RFC] Separate time support for using cpu timer
Message-ID: <20040419180720.H14976@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Background
----------

The current arch/mips/kernel/time.c has been stretched over the time
such that it now looks like a convoluted spaghetti to me:

1) it was originally designed to be flexible so that we could support
   all imaginable timer sources and timer setups:
	. use cpu timer (count/compare pair)
	. use board timer, with cpu count and known frequency
	. use board timer, with cpu count and unknown frequency
	. use board timer, with cpu count and unknown frequency, and
	  we can use 64bit division
	. jiffy interrupt through do_IRQ
	. jiffy interrupt through ll_timer_interrupt
	.....

2) introduction of 32bit SMP causes more complexity

3) the hpt_xxx stuff introduces another abstraction layer between hw
   timer (where cpu timer is treated as one kind of hw timers) and the time 
   subsystem.


Solution
--------

All the boards that I am really concerned right now have cpu count/compare
registers.  I believe this will even more so in the future.

Therefore I like to propose a separate time support for systems that use
cpu timer as their system timer.

As you can see from the patch, the new code is much simpler.


The hidden agenda
-----------------

OK, I admit there is another motivation in all of this.  Linux is moving
to have higher resolution timer.  For example, see the introduction of high resolution 
posix timer (http://sourceforge.net/projects/high-res-timers/).  Having a MIPS common
time routine based on cpu timer makes it much easier to support
such a feature for MIPS boards.  We don't need to mess with individual board timer
anymore.

In addition I think in 2.7 time frame Linux needs to replace its ancient jiffy
time system with a natively higher resolution time system.  A MIPS cpu timer based 
routine would evolve much better into the future.


The patch
---------

The attached is the patch for UP case.  I will post an additional patch for SMP
case later.

The patch is currently designed to be drop-in replace for arch/mips/kernel/time.c.
As you can see from the patch, you will only need to modify the Kconfig to define
CPU_TIMER for the qualified boards.

Comments?

Jun

--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="040419.a-cpu-timer.patch"

diff -Nru linux/arch/mips/Kconfig.orig linux/arch/mips/Kconfig
--- linux/arch/mips/Kconfig.orig	2004-04-19 16:33:42.000000000 -0700
+++ linux/arch/mips/Kconfig	2004-04-19 16:42:18.000000000 -0700
@@ -320,6 +320,7 @@
 config DDB5477
 	bool "Support for NEC DDB Vrc-5477"
 	select IRQ_CPU
+	select CPU_TIMER
 	help
 	  This enables support for the R5432-based NEC DDB Vrc-5477,
 	  or Rockhopper/SolutionGear boards with R5432/R5500 CPUs.
@@ -516,6 +517,7 @@
 config SIBYTE_SWARM
 	bool "BCM91250A-SWARM"
 	select SIBYTE_SB1250
+	select CPU_TIMER
 
 config SIBYTE_SENTOSA
 	bool "BCM91250E-Sentosa"
@@ -800,6 +802,13 @@
 	  byte order. These modes require different kernels. Say Y if your
 	  machine is little endian, N if it's a big endian machine.
 
+config CPU_TIMER
+	bool
+	help
+	  If CPU has count/compare registers (most do), and they are used
+	  as system timer, you can say 'Y' here to use the alternative
+	  time routines.
+
 config IRQ_CPU
 	bool
 
diff -Nru linux/arch/mips/kernel/cpu-timer.c.orig linux/arch/mips/kernel/cpu-timer.c
--- linux/arch/mips/kernel/cpu-timer.c.orig	2004-04-19 16:33:42.000000000 -0700
+++ linux/arch/mips/kernel/cpu-timer.c	2004-04-19 17:01:13.000000000 -0700
@@ -0,0 +1,445 @@
+/*
+ * Copyright 2004 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ *
+ * This routine provides time routines for boards that use cpu count/compare
+ * as their system timer.  A couple of requirements:
+ *   . Must have count/compare register and use them as your system timer
+ *     (obviously)
+ *   . Timer interrupt must go through do_IRQ() or ll_timer_interrupt()
+ *   . You must know or calibrate cpu timer frequency.
+ *
+ * See more in Documentation/mips/time.README.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/param.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/smp.h>
+#include <linux/kernel_stat.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+#include <asm/cpu-features.h>
+#include <asm/div64.h>
+#include <asm/hardirq.h>
+#include <asm/sections.h>
+#include <asm/time.h>
+#include <asm/debug.h>
+
+/*
+ * The integer part of the number of usecs per jiffy is taken from tick,
+ * but the fractional part is not recorded, so we calculate it using the
+ * initial value of HZ.  This aids systems where tick isn't really an
+ * integer (e.g. for HZ = 128).
+ */
+#define USECS_PER_JIFFY		TICK_SIZE
+
+#define TICK_SIZE	(tick_nsec / 1000)
+
+u64 jiffies_64 = INITIAL_JIFFIES;
+
+EXPORT_SYMBOL(jiffies_64);
+
+/*
+ * forward reference
+ */
+extern volatile unsigned long wall_jiffies;
+
+/*
+ * By default we provide the null RTC ops
+ */
+static unsigned long null_rtc_get_time(void)
+{
+	return mktime(2000, 1, 1, 0, 0, 0);
+}
+
+static int null_rtc_set_time(unsigned long sec)
+{
+	return 0;
+}
+
+unsigned long (*rtc_get_time)(void) = null_rtc_get_time;
+int (*rtc_set_time)(unsigned long) = null_rtc_set_time;
+int (*rtc_set_mmss)(unsigned long);
+
+
+/* usecs per counter cycle, shifted to left by 32 bits */
+static unsigned int sll32_usecs_per_cycle;
+
+/* how many counter cycles in a jiffy */
+static unsigned long cycles_per_jiffy;
+
+/* Cycle counter value at the previous timer interrupt.. */
+static unsigned int last_count;
+
+/* last time when xtime and rtc are sync'ed up */
+static long last_rtc_update;
+
+/* any missed timer interrupts */
+int missed_timer_count;
+
+
+/*
+ * Gettimeoffset routines.  These routines returns the time duration
+ * since last timer interrupt in usecs.
+ */
+static unsigned long get_intra_jiffy_offset(void)
+{
+	u32 count;
+	unsigned long res;
+
+	/* Get last timer tick in absolute kernel time */
+	count = read_c0_count();
+
+	/* 
+	 * .. relative to previous jiffy (32 bits is enough).
+	 * This routine should be protected by xtime_lock.  No race condition.
+	 * In SMP case, count may occasionally be behind last_count.
+	 */ 
+	/*
+	 * FIXME: time_after/time_before() not 64bit safe?
+	 */
+	if (time_after(count, last_count))
+	       count -= last_count;
+	else
+		count = 0;
+
+	__asm__("multu	%1,%2"
+		: "=h" (res)
+		: "r" (count), "r" (sll32_usecs_per_cycle)
+		: "lo", "accum");
+
+	/*
+	 * Due to possible jiffies inconsistencies, we need to check
+	 * the result so that we'll get a timer that is monotonic.
+	 */
+	if (res >= USECS_PER_JIFFY)
+		res = USECS_PER_JIFFY;
+
+	return res;
+}
+
+/*
+ * This version of gettimeofday has better than microsecond precision.
+ */
+void do_gettimeofday(struct timeval *tv)
+{
+	unsigned long seq;
+	unsigned long lost;
+	unsigned long usec, sec;
+	unsigned long max_ntp_tick;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+
+		usec = get_intra_jiffy_offset();
+
+		lost = jiffies - wall_jiffies;
+
+		/*
+		 * If time_adjust is negative then NTP is slowing the clock
+		 * so make sure not to go into next possible interval.
+		 * Better to lose some accuracy than have time go backwards..
+		 */
+		if (unlikely(time_adjust < 0)) {
+			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
+			usec = min(usec, max_ntp_tick);
+
+			if (lost)
+				usec += lost * max_ntp_tick;
+		} else if (unlikely(lost))
+			usec += lost * (USEC_PER_SEC / HZ);
+
+		sec = xtime.tv_sec;
+		usec += (xtime.tv_nsec / 1000);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	while (usec >= 1000000) {
+		usec -= 1000000;
+		sec++;
+	}
+	
+	tv->tv_sec = sec;
+	tv->tv_usec = usec;
+}
+
+EXPORT_SYMBOL(do_gettimeofday);
+
+int do_settimeofday(struct timespec *tv)
+{
+	time_t wtm_sec, sec = tv->tv_sec;
+	long wtm_nsec, nsec = tv->tv_nsec;
+
+	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
+		return -EINVAL;
+
+	write_seqlock_irq(&xtime_lock);
+
+	/*
+	 * This is revolting.  We need to set "xtime" correctly.  However,
+	 * the value in this location is the value at the most recent update
+	 * of wall time.  Discover what correction gettimeofday() would have
+	 * made, and then undo it!
+	 */
+	nsec -= get_intra_jiffy_offset() * NSEC_PER_USEC;
+	nsec -= (jiffies - wall_jiffies) * tick_nsec;
+
+	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
+	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
+
+	set_normalized_timespec(&xtime, sec, nsec);
+	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
+
+	time_adjust = 0;			/* stop active adjtime() */
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
+
+	write_sequnlock_irq(&xtime_lock);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(do_settimeofday);
+
+
+/*
+ * local_timer_interrupt() does profiling and process accounting
+ * on a per-CPU basis.
+ *
+ * In UP mode, it is invoked from the (global) timer_interrupt.
+ *
+ * In SMP mode, it might invoked by per-CPU timer interrupt, or
+ * a broadcasted inter-processor interrupt which itself is triggered
+ * by the global timer interrupt.
+ */
+void local_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	if (!user_mode(regs)) {
+		if (prof_buffer && current->pid) {
+			unsigned long pc = regs->cp0_epc;
+
+			pc -= (unsigned long) _stext;
+			pc >>= prof_shift;
+			/*
+			 * Dont ignore out-of-bounds pc values silently,
+			 * put them into the last histogram slot, so if
+			 * present, they will show up as a sharp peak.
+			 */
+			if (pc > prof_len - 1)
+				pc = prof_len - 1;
+			atomic_inc((atomic_t *)&prof_buffer[pc]);
+		}
+	}
+}
+
+/*
+ * Timer interrupt service routines.  This function
+ * is set as irqaction->handler and is invoked through do_IRQ.
+ */
+irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long compare;
+
+	db_assert(smp_processor_id() == 0);
+
+	write_seqlock(&xtime_lock);
+
+	missed_timer_count--;
+	do {
+		missed_timer_count++;
+
+		/* Ack this timer interrupt and set the next one.  */
+		last_count += cycles_per_jiffy;
+		compare = last_count + cycles_per_jiffy;
+		write_c0_compare(compare);
+
+		do_timer(regs);
+
+	} while (time_before_eq(compare, (unsigned long)read_c0_count()));
+
+	/*
+	 * If we have an externally synchronized Linux clock, then update
+	 * CMOS clock accordingly every ~11 minutes. rtc_set_time() has to be
+	 * called as close as possible to 500 ms before the new second starts.
+	 */
+	if ((time_status & STA_UNSYNC) == 0 &&
+	    xtime.tv_sec > last_rtc_update + 660 &&
+	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
+	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
+		if (rtc_set_mmss(xtime.tv_sec) == 0) {
+			last_rtc_update = xtime.tv_sec;
+		} else {
+			/* do it again in 60 s */
+			last_rtc_update = xtime.tv_sec - 600;
+		}
+	}
+
+	write_sequnlock(&xtime_lock);
+
+	/*
+	 * We call local_timer_interrupt() to do profiling and process 
+	 * accouting.
+	 */
+	local_timer_interrupt(irq, dev_id, regs);
+
+	return IRQ_HANDLED;
+}
+
+asmlinkage void ll_timer_interrupt(int irq, struct pt_regs *regs)
+{
+	irq_enter();
+	kstat_this_cpu.irqs[irq]++;
+
+	/* we keep interrupt disabled all the time */
+	timer_interrupt(irq, NULL, regs);
+
+	irq_exit();
+}
+
+/*
+ * time_init() - it does the following things.
+ *
+ * .) board_time_init() (or in board setup routine) -
+ * 	a) set up RTC routines,
+ *      b) calibrate and set the mips_hpt_frequency
+ * .) set rtc_set_mmss if it is not set by board code
+ * .) setup xtime based on rtc_get_time().
+ * .) init walt_to_monotonic
+ * .) calculate a couple of cached variables for later usage
+ * .) board_timer_setup() -
+ * 	. If you use ll_timer_interrupt(), do
+ *			set_c0_status(IE_IRQ5);
+ *		
+ *	. Otherwise if you are using IRQ_CPU, do
+ *		setup_irq(CPU_IRQ_BASE + 7, irq)
+ *
+ *	. If you are not using ll_timer_interrupt() (i.e., go through
+ *	  do_IRQ()) and you are not using IRQ_CPU, you can work around,
+ *	  but you probably really should ask yourself why.
+ */
+
+void (*board_time_init)(void);
+void (*board_timer_setup)(struct irqaction *irq);
+
+unsigned int mips_hpt_frequency;
+
+static struct irqaction timer_irqaction = {
+	.handler = timer_interrupt,
+	.flags = SA_INTERRUPT,
+	.name = "timer",
+};
+
+void __init time_init(void)
+{
+	if (board_time_init)
+		board_time_init();
+
+	db_assert(mips_hpt_frequency != 0);
+
+	if (!rtc_set_mmss)
+		rtc_set_mmss = rtc_set_time;
+
+	xtime.tv_sec = rtc_get_time();
+	xtime.tv_nsec = 0;
+
+	set_normalized_timespec(&wall_to_monotonic,
+	                        -xtime.tv_sec, -xtime.tv_nsec);
+
+	/* Calculate cache parameters.  */
+	cycles_per_jiffy = (mips_hpt_frequency + HZ / 2) / HZ;
+
+	/* sll32_usecs_per_cycle = 10^6 * 2^32 / mips_hpt_frequency  */
+	{ 
+		u64 div = ((u64)1000000 << 32) + mips_hpt_frequency / 2;
+		do_div(div, mips_hpt_frequency);
+		sll32_usecs_per_cycle = div;
+	}
+
+	/* Report the high precision timer rate for a reference.  */
+	printk("Using %u.%03u MHz cpu timer.\n",
+		       ((mips_hpt_frequency + 500) / 1000) / 1000,
+		       ((mips_hpt_frequency + 500) / 1000) % 1000);
+
+	/* initialize cp0 count and compare */
+	write_c0_compare(cycles_per_jiffy);
+	write_c0_count(0);
+	last_count = 0;
+
+	/*
+	 * Call board specific timer interrupt setup.
+	 *
+	 * this pointer must be setup in machine setup routine.
+	 *
+	 * Even if a machine chooses to use a low-level timer interrupt,
+	 * it still needs to setup the timer_irqaction.
+	 * In that case, it might be better to set timer_irqaction.handler
+	 * to be NULL function so that we are sure the high-level code
+	 * is not invoked accidentally.
+	 */
+	board_timer_setup(&timer_irqaction);
+}
+
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
+
+EXPORT_SYMBOL(to_tm);
+EXPORT_SYMBOL(rtc_set_time);
+EXPORT_SYMBOL(rtc_get_time);
diff -Nru linux/arch/mips/kernel/Makefile.orig linux/arch/mips/kernel/Makefile
--- linux/arch/mips/kernel/Makefile.orig	2004-04-19 16:33:42.000000000 -0700
+++ linux/arch/mips/kernel/Makefile	2004-04-19 16:42:18.000000000 -0700
@@ -6,7 +6,13 @@
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o semaphore.o setup.o signal.o syscall.o \
-		   time.o traps.o unaligned.o
+		   traps.o unaligned.o
+
+ifdef CONFIG_CPU_TIMER
+obj-y				+= cpu-timer.o
+else
+obj-y				+= time.o
+endif
 
 ifdef CONFIG_MODULES
 obj-y				+= mips_ksyms.o
diff -Nru linux/arch/mips/kernel/proc.c.orig linux/arch/mips/kernel/proc.c
--- linux/arch/mips/kernel/proc.c.orig	2004-04-19 16:33:42.000000000 -0700
+++ linux/arch/mips/kernel/proc.c	2004-04-19 16:42:18.000000000 -0700
@@ -78,7 +78,9 @@
 	[CPU_SR71000]	"Sandcraft SR71000"
 };
 
-
+#if defined(CONFIG_CPU_TIMER)
+extern int missed_timer_count;
+#endif
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	unsigned int version = current_cpu_data.processor_id;
@@ -121,6 +123,10 @@
 	seq_printf(m, fmt, 'D', vced_count);
 	seq_printf(m, fmt, 'I', vcei_count);
 
+#if defined(CONFIG_CPU_TIMER)
+	seq_printf(m, "missed timers\t\t: %d\n", missed_timer_count);
+#endif
+
 	return 0;
 }
 

--eRtJSFbw+EEWtPj3--
