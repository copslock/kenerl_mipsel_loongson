Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 18:37:45 +0000 (GMT)
Received: from pasta.sw.starentnetworks.com ([12.33.234.10]:45197 "EHLO
	pasta.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S3458548AbWAPSh0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 18:37:26 +0000
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP
	id AB3A5149719; Mon, 16 Jan 2006 13:40:51 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17355.59571.567485.592914@cortez.sw.starentnetworks.com>
Date:	Mon, 16 Jan 2006 13:40:51 -0500
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: [PATCH] fix lost ticks on SB1250 [WAS: Re: [PATCH] gettimeofday jumps backwards then forwards]
In-Reply-To: <17355.52046.456176.406834@cortez.sw.starentnetworks.com>
References: <17118.25343.948383.547250@cortez.sw.starentnetworks.com>
	<20060116160031.GA28383@deprecation.cyrius.com>
	<17355.52046.456176.406834@cortez.sw.starentnetworks.com>
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips

Dave Johnson writes:
> In addition to this problem I found significant lost ticks under load
> as there is no checking for lost ticks. I'll create a clean patch with
> just that fix in a bit.

Below patch fixes 2 issues and must be applied after my previous
gettimeofday patch because it uses the hpt introduced in that patch.

1) Lost timer ticks were not being noticed and counted for sb1250 causing
   time to slow down under heavy load.
2) The 2 periodic timers (one on each core of the sb1250) had a random phase
   when compared to each other.  In certain phases this will lead to artificial
   high cpu usage and load according to process accounting. (see comment in
   code below for more info).  This would occur on about 1 out of 50 cpu boots.

Patch is against 2.6.12 with some other patches unfortunatly (only the gettimeofday
one should matter as far as merging)

Signed-off-by: Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>

diff -Nru a/arch/mips/dec/time.c b/arch/mips/dec/time.c
--- a/arch/mips/dec/time.c	2006-01-16 13:15:10 -05:00
+++ b/arch/mips/dec/time.c	2006-01-16 13:15:10 -05:00
@@ -151,7 +151,7 @@
 	return (CMOS_READ(RTC_REG_C) & RTC_PF) != 0;
 }
 
-static void dec_timer_ack(void)
+static void dec_timer_ack(unsigned int count)
 {
 	CMOS_READ(RTC_REG_C);			/* Ack the RTC interrupt.  */
 }
diff -Nru a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
--- a/arch/mips/kernel/time.c	2006-01-16 13:15:08 -05:00
+++ b/arch/mips/kernel/time.c	2006-01-16 13:15:09 -05:00
@@ -88,7 +88,7 @@
 /*
  * Null timer ack for systems not needing one (e.g. i8254).
  */
-static void null_timer_ack(void) { /* nothing */ }
+static void null_timer_ack(unsigned int count) { /* nothing */ }
 
 /*
  * Null high precision timer functions for systems lacking one.
@@ -104,16 +104,13 @@
 /*
  * Timer ack for an R4k-compatible timer of a known frequency.
  */
-static void c0_timer_ack(void)
+static void c0_timer_ack(unsigned int count)
 {
-	unsigned int count;
-
 	/* Ack this timer interrupt and set the next one.  */
 	expirelo += cycles_per_jiffy;
 	write_c0_compare(expirelo);
 
 	/* Check to see if we have missed any timer interrupts.  */
-	count = read_c0_count();
 	if ((count - expirelo) < 0x7fffffff) {
 		/* missed_timer_count++; */
 		expirelo = count + cycles_per_jiffy;
@@ -146,7 +143,7 @@
 }
 
 int (*mips_timer_state)(void);
-void (*mips_timer_ack)(void);
+void (*mips_timer_ack)(unsigned int);
 unsigned int (*mips_hpt_read)(void);
 void (*mips_hpt_init)(unsigned int);
 
@@ -427,7 +424,7 @@
 	write_seqlock(&xtime_lock);
 
 	count = mips_hpt_read();
-	mips_timer_ack();
+	mips_timer_ack(count);
 
 	/* Update timerhi/timerlo for intra-jiffy calibration. */
 	timerhi += count < timerlo;			/* Wrap around */
diff -Nru a/arch/mips/sibyte/sb1250/time.c b/arch/mips/sibyte/sb1250/time.c
--- a/arch/mips/sibyte/sb1250/time.c	2006-01-16 13:15:09 -05:00
+++ b/arch/mips/sibyte/sb1250/time.c	2006-01-16 13:15:10 -05:00
@@ -54,6 +54,9 @@
 
 extern int sb1250_steal_irq(int irq);
 
+static void sb1250_timer_ack(unsigned int);
+
+static unsigned int sb1250_hpt_read_no_offset(void);
 static unsigned int sb1250_hpt_read(void);
 static void sb1250_hpt_init(unsigned int);
 
@@ -99,20 +102,10 @@
 		     IOADDR(A_IMR_REGISTER(cpu, R_IMR_INTERRUPT_MAP_BASE) +
 			    (irq << 3)));
 
-	/* the general purpose timer ticks at 1 Mhz independent if the rest of the system */
-	/* Disable the timer and set up the count */
-	__raw_writeq(0, IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
-#ifdef CONFIG_SIMULATION
-	__raw_writeq((50000 / HZ) - 1,
-		     IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT)));
-#else
-	__raw_writeq((V_SCD_TIMER_FREQ / HZ) - 1,
-		     IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT)));
-#endif
+	/* this will setup the interrupt for the first time */
+	sb1250_timer_ack(-1);
 
-	/* Set the timer running */
-	__raw_writeq(M_SCD_TIMER_ENABLE | M_SCD_TIMER_MODE_CONTINUOUS,
-		     IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
+	mips_timer_ack = sb1250_timer_ack;
 
 	sb1250_unmask_irq(cpu, irq);
 	sb1250_steal_irq(irq);
@@ -126,21 +119,66 @@
 	 */
 }
 
+
+static void sb1250_timer_ack(unsigned int count) {
+	static unsigned int expected[NR_CPUS];
+	int newval = (V_SCD_TIMER_FREQ / HZ) << SB1250_HPT_SHIFT;
+	int cpu = smp_processor_id();
+
+	/* first time through? setup expected */
+	if (unlikely(count == -1)) {
+		expected[cpu] = count = sb1250_hpt_read_no_offset();
+
+		/*
+		 * We want the 2 cores to have their timers in sync instead of at a 
+		 * random phase.  Once started the phase doesn't change until the
+		 * cpu is rebooted.  With perticular phasing artificially inflated
+		 * cpu usage values and load can be reported to userspace that
+		 * remain until the cpu is rebooted.
+		 */
+		expected[cpu] -= count % newval;
+	}
+	else if (cpu == 0)
+		count += hpt_offset;
+
+	/* did we miss any ticks? */
+	if (unlikely((cpu == 0) && ((count - expected[cpu]) > newval)))
+		jiffies_64 += (count - expected[cpu]) / newval;
+
+	/* Now, how much time is left in current slice? */
+	newval -= (count - expected[cpu]) % newval;
+
+	expected[cpu] = count + newval;
+	newval >>= SB1250_HPT_SHIFT;
+
+	/* wait at least 1us before next IRQ */
+	if (unlikely(newval < 2))
+		newval = 2;
+
+	/* Disable the timer and set up the new count */
+	__raw_writeq(0, IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
+	__raw_writeq(newval - 1,
+		     IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT)));
+	/* Set the timer running */
+	__raw_writeq(M_SCD_TIMER_ENABLE,
+		     IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
+}
+
+
 void sb1250_timer_interrupt(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 	int irq = K_INT_TIMER_0 + cpu;
 
-	/* ACK interrupt */
-	____raw_writeq(M_SCD_TIMER_ENABLE | M_SCD_TIMER_MODE_CONTINUOUS,
-		       IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
-
 	/*
 	 * CPU 0 handles the global timer interrupt job
 	 */
 	if (cpu == 0) {
 		ll_timer_interrupt(irq, regs);
 	}
+	else {
+		sb1250_timer_ack(sb1250_hpt_read_no_offset());
+	}
 
 	/*
 	 * every CPU should do profiling and process accouting
@@ -156,7 +194,7 @@
  * Note: Timer isn't full 32bits so shift it into the upper part making
  *       it appear to run at a higher frequency.
  */
-static unsigned int sb1250_hpt_read(void)
+static unsigned int sb1250_hpt_read_no_offset(void)
 {
 	unsigned int count;
 
@@ -164,7 +202,12 @@
 
 	count = (SB1250_HPT_VALUE - count) << SB1250_HPT_SHIFT;
 
-	return count - hpt_offset;
+	return count;
+}
+
+static unsigned int sb1250_hpt_read(void)
+{
+	return sb1250_hpt_read_no_offset() - hpt_offset;
 }
 
 static void sb1250_hpt_init(unsigned int count)
diff -Nru a/include/asm-mips/sibyte/sb1250_scd.h b/include/asm-mips/sibyte/sb1250_scd.h
--- a/include/asm-mips/sibyte/sb1250_scd.h	2006-01-16 13:15:10 -05:00
+++ b/include/asm-mips/sibyte/sb1250_scd.h	2006-01-16 13:15:10 -05:00
@@ -306,7 +306,11 @@
  * Timer Registers (Table 4-11) (Table 4-12) (Table 4-13)
  */
 
+#ifdef CONFIG_SIMULATION
+#define V_SCD_TIMER_FREQ            50000
+#else
 #define V_SCD_TIMER_FREQ            1000000
+#endif
 #define V_SCD_TIMER_WIDTH           23
 
 #define S_SCD_TIMER_INIT            0
diff -Nru a/include/asm-mips/time.h b/include/asm-mips/time.h
--- a/include/asm-mips/time.h	2006-01-16 13:15:05 -05:00
+++ b/include/asm-mips/time.h	2006-01-16 13:15:06 -05:00
@@ -38,7 +38,7 @@
  * mips_timer_ack may be NULL if the interrupt is self-recoverable.
  */
 extern int (*mips_timer_state)(void);
-extern void (*mips_timer_ack)(void);
+extern void (*mips_timer_ack)(unsigned int);
 
 /*
  * High precision timer functions.
