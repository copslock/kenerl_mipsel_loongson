Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 01:17:19 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:48121 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225202AbTDOARS>;
	Tue, 15 Apr 2003 01:17:18 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3F0Gtn08721;
	Mon, 14 Apr 2003 17:16:55 -0700
Date: Mon, 14 Apr 2003 17:16:55 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] loosing time with CPU counter timer
Message-ID: <20030414171655.G1642@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This patch fixes an ancient timer bug.

If one uses CPU counter as the system timer, it looses time
over the time.

Basically, timer_interrupt() does the following when it serves
an cpu counter interrupt (only relavent part shown);

0) interrupt happens
1) read cpu counter;
2) add it with cycles_per_jiffy, and set the value to compare
   register.

The problem is that cpu counter could increase between 0) and 1),
say by delta units.  Then the next timer interrupt is set to
t0 + delta + cycles_per_unit, instead of t0 + cycles_per_unit,
(where t0 is the current timer interrupt time)

Similar bug also exists in old-time.c, but anybody really cares? :)
Especially it has been there for quite a while ....

Jun

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030414.loosing-time-with-cpu-counter-timer.patch"

diff -Nru linux/arch/mips/ddb5xxx/ddb5477/setup.c.orig linux/arch/mips/ddb5xxx/ddb5477/setup.c
--- linux/arch/mips/ddb5xxx/ddb5477/setup.c.orig	Mon Apr 14 15:28:57 2003
+++ linux/arch/mips/ddb5xxx/ddb5477/setup.c	Mon Apr 14 16:08:35 2003
@@ -43,7 +43,7 @@
 #include "lcd44780.h"
 
 
-// #define	USE_CPU_COUNTER_TIMER	/* whether we use cpu counter */
+#define	USE_CPU_COUNTER_TIMER	/* whether we use cpu counter */
 
 #define	SP_TIMER_BASE			DDB_SPT1CTRL_L
 #define	SP_TIMER_IRQ			VRC5477_IRQ_SPT1
@@ -154,10 +154,6 @@
         /* we are using the cpu counter for timer interrupts */
 	setup_irq(CPU_IRQ_BASE + 7, irq);
 
-        /* to generate the first timer interrupt */
-        count = read_c0_count();
-        write_c0_compare(count + 1000);
-
 #else
 
 	/* if we use Special purpose timer 1 */
diff -Nru linux/arch/mips/kernel/time.c.orig linux/arch/mips/kernel/time.c
--- linux/arch/mips/kernel/time.c.orig	Fri Apr 11 11:05:18 2003
+++ linux/arch/mips/kernel/time.c	Mon Apr 14 16:51:13 2003
@@ -140,6 +140,24 @@
 /* Cycle counter value at the previous timer interrupt.. */
 static unsigned int timerhi, timerlo;
 
+/* 
+ * Cycle counter value after which next timer interrupt is considered "missed".
+ * Suppose we are serving timer interrupt scheduled at time t, the theorectical 
+ * expiriing point for next interrupt is t + 2 * cycles_per_jiffy.
+ * In practice, we set it a little earlier, which is 
+ * 	t + 2 * cycles_per_jiffy - EXTRA_CUSHION_CYCLES
+ * just to make sure we still have some time to set registers after we
+ * decide whether a timer interrupt is missed.
+ */
+static unsigned int expirehi, expirelo;
+
+/* 
+ * extra "cushion" cycles used when we decide whether we have missed an
+ * timer interrupt (in the case of using cpu counter).  It should be long
+ * enough to cover at least 20 instructions.
+ */
+#define	EXTRA_CUSHION_CYCLES	50
+
 /* last time when xtime and rtc are sync'ed up */
 static long last_rtc_update;
 
@@ -330,6 +348,16 @@
  * high-level timer interrupt service routines.  This function
  * is set as irqaction->handler and is invoked through do_IRQ.
  */
+static inline int 
+64bit_compare(unsigned hi1, unsigned lo1, unsigned hi2, unsigned lo2)
+{
+	if (hi1 == hi2) {
+		return lo1 - lo2;
+	} else {
+		return hi1 - hi2;
+	}
+}
+
 void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	if (cpu_has_counter) {
@@ -343,14 +371,19 @@
 		timerhi += (count < timerlo);   /* Wrap around */
 		timerlo = count;
 
-		/*
-		 * set up for next timer interrupt - no harm if the machine
-		 * is using another timer interrupt source.
-		 * Note that writing to COMPARE register clears the interrupt
-		 */
-		write_c0_compare(
-					  count + cycles_per_jiffy);
-
+		/* check to see if we have missed a timer interrupt */
+		if (64bit_compare(timerhi, timerlo, expirehi, expirelo) < 0) {
+			unsigned int old_expirelo=expirelo;
+			expirelo += cycles_per_jiffy;
+			expirehi += (expirelo < old_expirelo);
+			write_c0_compare(old_expirelo + EXTRA_CUSHION_CYCLES);
+		} else {
+			// missed_timer_count ++;
+			/* we have missed at least one timer interrupt */
+			expirelo = timerlo + cycles_per_jiffy*2 - EXTRA_CUSHION_CYCLES;
+			expirehi = timerhi + (expirelo < timerlo);
+			write_c0_compare(timerlo + cycles_per_jiffy);
+		}
 	}
 
 	/*
@@ -504,8 +537,6 @@
 
 	/* caclulate cache parameters */
 	if (mips_counter_frequency) {
-		u32 count;
-
 		cycles_per_jiffy = mips_counter_frequency / HZ;
 
 		/* sll32_usecs_per_cycle = 10^6 * 2^32 / mips_counter_freq */
@@ -518,9 +549,9 @@
 		 * For those using cpu counter as timer,  this sets up the
 		 * first interrupt
 		 */
-		count = read_c0_count();
-		write_c0_compare(
-					  count + cycles_per_jiffy);
+		write_c0_compare(cycles_per_jiffy);
+		write_c0_count(0);
+		expirelo = cycles_per_jiffy * 2 - EXTRA_CUSHION_CYCLES;
 	}
 
 	/*

--FCuugMFkClbJLl1L--
