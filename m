Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 03:18:41 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:34557 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225228AbTFJCSj>;
	Tue, 10 Jun 2003 03:18:39 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h5A2IVv30567;
	Mon, 9 Jun 2003 19:18:31 -0700
Date: Mon, 9 Jun 2003 19:18:31 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] get time right for SMP machines
Message-ID: <20030609191831.H26703@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Fixes a couple of things:

1) extend xtime_lock protection to cover do_timer() call (the same
   as in i386 arch).  This enables other CPUs to use jiffie in a sane way.

2) It was not quite right to deliver ll_timer_interrupt() and
   ll_local_timer_interrupt() as two separate interrupts, because
   it may cause bottom half to execute ahead of the second interrupt.

3) for bcm1250, we now use zb bus counter for intra-jiffie offset.
   No more time running backward problem. 

(TODO, I think I probably need to check the chip revision to make
sure zb bus counter is there.  Otherwise we can use null_gettimeoffset())

The patch should apply to 64bit and 2.5 as well.  Comments?

Jun 

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030609.a-smp-gettimeoffset-fix.patch"

diff -Nru linux/arch/mips/kernel/time.c.orig linux/arch/mips/kernel/time.c
--- linux/arch/mips/kernel/time.c.orig	Fri Jun  6 12:44:08 2003
+++ linux/arch/mips/kernel/time.c	Fri Jun  6 12:45:19 2003
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/param.h>
 #include <linux/time.h>
+#include <linux/timer.h>
 #include <linux/smp.h>
 #include <linux/kernel_stat.h>
 #include <linux/spinlock.h>
@@ -79,7 +80,7 @@
 	 * is nonzero if the timer bottom half hasnt executed yet.
 	 */
 	if (jiffies - wall_jiffies)
-		tv->tv_usec += USECS_PER_JIFFY;
+		tv->tv_usec += USECS_PER_JIFFY * (jiffies - wall_jiffies);
 
 	read_unlock_irqrestore (&xtime_lock, flags);
 
@@ -344,7 +345,7 @@
 		count = read_c0_count();
 
 		/* check to see if we have missed any timer interrupts */
-		if ((count - expirelo) < 0x7fffffff) {
+		if (time_after(count, expirelo)) {
 			/* missed_timer_count ++; */
 			expirelo = count + cycles_per_jiffy;
 			write_c0_compare(expirelo);
@@ -355,6 +356,8 @@
 		timerlo = count;
 	}
 
+	write_lock (&xtime_lock);
+
 	/*
 	 * call the generic timer interrupt handling
 	 */
@@ -365,7 +368,6 @@
 	 * CMOS clock accordingly every ~11 minutes. rtc_set_time() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	read_lock (&xtime_lock);
 	if ((time_status & STA_UNSYNC) == 0 &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
@@ -377,7 +379,6 @@
 			/* do it again in 60 s */
 		}
 	}
-	read_unlock (&xtime_lock);
 
 	/*
 	 * If jiffies has overflowed in this timer_interrupt we must
@@ -388,26 +389,20 @@
 		timerhi = timerlo = 0;
 	}
 
-#if !defined(CONFIG_SMP)
+	write_unlock (&xtime_lock);
+
 	/*
-	 * In UP mode, we call local_timer_interrupt() to do profiling
-	 * and process accouting.
-	 *
-	 * In SMP mode, local_timer_interrupt() is invoked by appropriate
-	 * low-level local timer interrupt handler.
+	 * We call local_timer_interrupt() to do profiling and 
+	 * process accouting.
 	 */
 	local_timer_interrupt(0, NULL, regs);
 
-#else	/* CONFIG_SMP */
-
+#if defined(CONFIG_SMP)
 	if (emulate_local_timer_interrupt) {
 		/*
 		 * this is the place where we send out inter-process
 		 * interrupts and let each CPU do its own profiling
 		 * and process accouting.
-		 *
-		 * Obviously we need to call local_timer_interrupt() for
-		 * the current CPU too.
 		 */
 		panic("Not implemented yet!!!");
 	}
diff -Nru linux/arch/mips/sibyte/sb1250/time.c.orig linux/arch/mips/sibyte/sb1250/time.c
--- linux/arch/mips/sibyte/sb1250/time.c.orig	Fri Jun  6 12:44:08 2003
+++ linux/arch/mips/sibyte/sb1250/time.c	Mon Jun  9 19:01:43 2003
@@ -30,11 +30,13 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/kernel_stat.h>
+#include <linux/time.h>
 
 #include <asm/irq.h>
 #include <asm/ptrace.h>
 #include <asm/addrspace.h>
 #include <asm/time.h>
+#include <asm/div64.h>
 
 #include <asm/sibyte/sb1250.h>
 #include <asm/sibyte/sb1250_regs.h>
@@ -47,13 +49,42 @@
 #define IMR_IP3_VAL	K_INT_MAP_I1
 #define IMR_IP4_VAL	K_INT_MAP_I2
 
+extern rwlock_t xtime_lock;
+
 extern int sb1250_steal_irq(int irq);
 
+#define	zbcycle2msec_shift	32
+#define USECS_PER_JIFFY 	(1000000/HZ)
+
+static unsigned zbbus_freq;
+static unsigned scaled_usec_per_zbcycle;
+
+/*
+ * return (u32)( ((u64)x * (u64)y) >> shift ), where shift <= 32
+ */
+static inline unsigned 
+scaled_mult(unsigned x, unsigned y, int shift)
+{
+	unsigned hi, lo;
+
+	__asm__("multu\t%2,%3\n\t"
+		"mfhi\t%0\n\t"
+		"mflo\t%1"
+		:"=r" (hi), "=r" (lo)
+		:"r" (x), "r" (y));
+	if (shift == 32) {
+		return hi;
+	} else {
+		return (hi << (32 - shift)) | (lo >> shift);
+	}
+}
+
 void sb1250_time_init(void)
 {
 	int cpu = smp_processor_id();
 	int irq = K_INT_TIMER_0+cpu;
-
+	u64 temp;
+	
 	/* Only have 4 general purpose timers */
 	if (cpu > 3) {
 		BUG();
@@ -95,6 +126,23 @@
 	 * called directly from irq_handler.S when IP[4] is set during an
 	 * interrupt
 	 */
+
+        temp = G_SYS_PLL_DIV(in64(IO_SPACE_BASE | A_SCD_SYSTEM_CFG));
+        temp = ((temp >> 1) * 50) + ((temp & 1) * 25);
+        zbbus_freq = temp * 1000000;
+
+	temp = 1000000ULL << zbcycle2msec_shift;
+	do_div(temp, zbbus_freq);
+	scaled_usec_per_zbcycle = temp;
+}
+
+static unsigned last_jiffie;
+static u64 last_zbcount;
+
+static inline u64
+read_zbcount(void)
+{
+	return in64(KSEG1 + A_SCD_ZBBUS_CYCLE_COUNT);
 }
 
 void sb1250_timer_interrupt(struct pt_regs *regs)
@@ -102,7 +150,6 @@
 	int cpu = smp_processor_id();
 	int irq = K_INT_TIMER_0+cpu;
 
-	kstat.irqs[cpu][irq]++;
 	/* Reset the timer */
 	out64(M_SCD_TIMER_ENABLE|M_SCD_TIMER_MODE_CONTINUOUS,
 	      KSEG1 + A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
@@ -111,25 +158,45 @@
 	 * CPU 0 handles the global timer interrupt job
 	 */
 	if (cpu == 0) {
+		write_lock(&xtime_lock);
+		last_jiffie = jiffies;
+		last_zbcount = read_zbcount();
+		write_unlock(&xtime_lock);
 		ll_timer_interrupt(irq, regs);
-	}
-
-	/*
-	 * every CPU should do profiling and process accouting
-	 */
-	ll_local_timer_interrupt(irq, regs);
+	} else 
+		ll_local_timer_interrupt(irq, regs);
 }
 
 /*
  * We use our own do_gettimeoffset() instead of the generic one,
  * because the generic one does not work for SMP case.
- * In addition, since we use general timer 0 for system time,
- * we can get accurate intra-jiffy offset without calibration.
+ *
+ * It turns out to be very hard to get monotonically increasing time offset.
+ * We have to resort to zb bus counter.
  */
 unsigned long sb1250_gettimeoffset(void)
 {
-	unsigned long count =
-		in64(KSEG1 + A_SCD_TIMER_REGISTER(0, R_SCD_TIMER_CNT));
+	u64 count;
+	unsigned ret;
+	unsigned count_diff;
+
+	/* we have xtime lock, irq disabled */
+	count = read_zbcount();
+	count_diff = count - last_zbcount;
+	ret = scaled_mult(count_diff,
+			scaled_usec_per_zbcycle, 
+			zbcycle2msec_shift);
+
+	if (jiffies == last_jiffie) {
+		// we are in a narrow window where timer interrupt
+		// has happened but jiffies has not been increased yet
+		// The offset should be about 1 jiffie.  We just return
+		// the maximum intra-jiffie offset here.
+		ret = USECS_PER_JIFFY-1;
+	}
 
-	return 1000000/HZ - count;
- }
+	if (ret >= USECS_PER_JIFFY)
+		ret = USECS_PER_JIFFY-1;
+
+	return ret;
+}

--uAKRQypu60I7Lcqm--
