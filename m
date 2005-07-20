Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 15:42:05 +0100 (BST)
Received: from pasta.sw.starentnetworks.com ([IPv6:::ffff:12.33.234.10]:48011
	"EHLO pasta.sw.starentnetworks.com") by linux-mips.org with ESMTP
	id <S8224955AbVGTOlq>; Wed, 20 Jul 2005 15:41:46 +0100
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP id 8590414B646
	for <linux-mips@linux-mips.org>; Wed, 20 Jul 2005 10:43:16 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17118.25343.948383.547250@cortez.sw.starentnetworks.com>
Date:	Wed, 20 Jul 2005 10:43:11 -0400
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] gettimeofday jumps backwards then forwards
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


Below are 2 fixes I made to 2.6.12 to do with time jumping around
as reported by gettimeofday().  One is SB1250 specific and one appears
generic.

The symptom is revealed by running multile copies (1 per cpu) of a
simple test program that calls gettimeofday() as fast as possible
looking for time to go backwards.

When a jump is detected the program outputs a few samples before and
after each jump:

value               delta
1121781527.912525:      1
1121781527.912525:      0
1121781527.912526:      1
1121781527.912526:      0
1121781527.912527:      1
1121781527.912527:      0
1121781527.912527:      0
1121781527.912527:      0
1121781527.911528:   -999
1121781527.911529:      1
1121781527.911530:      1
1121781527.912532:   1002
1121781527.912533:      1
1121781527.912533:      0
1121781527.912534:      1
1121781527.912534:      0
1121781527.912535:      1
1121781527.912536:      1

value               delta
1121781545.635524:      1
1121781545.635524:      0
1121781545.635525:      1
1121781545.635525:      0
1121781545.635526:      1
1121781545.635526:      0
1121781545.635527:      1
1121781545.635527:      0
1121781545.634527:  -1000
1121781545.635527:   1000
1121781545.635528:      1
1121781545.635529:      1
1121781545.635529:      0
1121781545.635530:      1
1121781545.635530:      0
1121781545.635531:      1
1121781545.635531:      0
1121781545.635532:      1
1121781545.635533:      1

Time jumps backwards 1msec then forwards 1msec a few usec
later.  Usually lasts < 2us but I've seen it as long as 5us if the
system is under load.

--

First problem I found is that sb1250_gettimeoffset() simply reads the
current cpu 0 timer remaining value, however once this counter reaches
0 and the interrupt is raised, it immediately resets and begins to
count down again.

If sb1250_gettimeoffset() is called on cpu 1 via do_gettimeofday()
after the timer has reset but prior to cpu 0 processing the interrupt
and taking write_seqlock() in timer_interrupt() it will return a
full value (or close to it) causing time to jump backwards 1ms. Once
cpu 0 handles the interrupt and timer_interrupt() gets far enough
along it will jump forward 1ms.

To fix this problem I implemented mips_hpt_*() on sb1250 using a spare
timer unrelated to the existing periodic interrupt timers. It runs at
1Mhz with a full 23bit counter.  This eliminated the custom
do_gettimeoffset() for sb1250 and allowed use of the generic
fixed_rate_gettimeoffset() using mips_hpt_*() and timerhi/timerlo.

--

The second problem is that more of timer_interrupt() needs to be
protected by xtime_lock:

* do_timer() expects the arch-specific handler to take the lock as it
  modifies jiffies[_64] and xtime.
* writing timerhi/lo in timer_interrupt() will mess up
  fixed_rate_gettimeoffset() which reads timerhi/lo.

--

With both changes do_gettimeofday() works correctly on both cpu 0 and
cpu 1.

--

Other changes/cleanups:

The existing sb1250 periodic timers were slow by 999ppm (given a
perfect 100mhz reference).  The timers need to be loaded with 1 less
than the desired interval not the interval itself.

M_SCD_TIMER_INIT and M_SCD_TIMER_CNT had the wrong field width (should
be 23 bits not 20 bits)

-- 
Dave Johnson
Starent Networks

============

diff -Nru a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
--- a/arch/mips/kernel/time.c	2005-07-20 10:25:22 -04:00
+++ b/arch/mips/kernel/time.c	2005-07-20 10:25:22 -04:00
@@ -424,6 +424,8 @@
 	unsigned long j;
 	unsigned int count;
 
+	write_seqlock(&xtime_lock);
+
 	count = mips_hpt_read();
 	mips_timer_ack();
 
@@ -441,7 +443,6 @@
 	 * CMOS clock accordingly every ~11 minutes. rtc_set_time() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	write_seqlock(&xtime_lock);
 	if ((time_status & STA_UNSYNC) == 0 &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
@@ -453,7 +454,6 @@
 			last_rtc_update = xtime.tv_sec - 600;
 		}
 	}
-	write_sequnlock(&xtime_lock);
 
 	/*
 	 * If jiffies has overflown in this timer_interrupt, we must
@@ -495,6 +495,8 @@
 			break;
 		}
 	}
+
+	write_sequnlock(&xtime_lock);
 
 	/*
 	 * In UP mode, we call local_timer_interrupt() to do profiling
diff -Nru a/arch/mips/sibyte/sb1250/time.c b/arch/mips/sibyte/sb1250/time.c
--- a/arch/mips/sibyte/sb1250/time.c	2005-07-20 10:25:22 -04:00
+++ b/arch/mips/sibyte/sb1250/time.c	2005-07-20 10:25:22 -04:00
@@ -47,23 +47,51 @@
 #define IMR_IP3_VAL	K_INT_MAP_I1
 #define IMR_IP4_VAL	K_INT_MAP_I2
 
+#define SB1250_HPT_NUM		3
+#define SB1250_HPT_VALUE	M_SCD_TIMER_CNT /* max value */
+#define SB1250_HPT_SHIFT	((sizeof(unsigned int)*8)-V_SCD_TIMER_WIDTH)
+
+
 extern int sb1250_steal_irq(int irq);
 
+static unsigned int sb1250_hpt_read(void);
+static void sb1250_hpt_init(unsigned int);
+
+static unsigned int hpt_offset;
+
+void __init sb1250_hpt_setup(void)
+{
+	int cpu = smp_processor_id();
+
+	if (!cpu) {
+		/* Setup hpt using timer #3 but do not enable irq for it */
+		__raw_writeq(0, IOADDR(A_SCD_TIMER_REGISTER(SB1250_HPT_NUM, R_SCD_TIMER_CFG)));
+		__raw_writeq(SB1250_HPT_VALUE,
+			     IOADDR(A_SCD_TIMER_REGISTER(SB1250_HPT_NUM, R_SCD_TIMER_INIT)));
+		__raw_writeq(M_SCD_TIMER_ENABLE | M_SCD_TIMER_MODE_CONTINUOUS,
+			     IOADDR(A_SCD_TIMER_REGISTER(SB1250_HPT_NUM, R_SCD_TIMER_CFG)));
+
+		/*
+		 * we need to fill 32 bits, so just use the upper 23 bits and pretend
+		 * the timer is going 512Mhz instead of 1Mhz
+		 */
+		mips_hpt_frequency = V_SCD_TIMER_FREQ << SB1250_HPT_SHIFT;
+		mips_hpt_init = sb1250_hpt_init;
+		mips_hpt_read = sb1250_hpt_read;
+	}
+}
+
+
 void sb1250_time_init(void)
 {
 	int cpu = smp_processor_id();
 	int irq = K_INT_TIMER_0+cpu;
 
-	/* Only have 4 general purpose timers */
-	if (cpu > 3) {
+	/* Only have 4 general purpose timers, and we use last one as hpt */
+	if (cpu > 2) {
 		BUG();
 	}
 
-	if (!cpu) {
-		/* Use our own gettimeoffset() routine */
-		do_gettimeoffset = sb1250_gettimeoffset;
-	}
-
 	sb1250_mask_irq(cpu, irq);
 
 	/* Map the timer interrupt to ip[4] of this cpu */
@@ -75,10 +103,10 @@
 	/* Disable the timer and set up the count */
 	__raw_writeq(0, IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
 #ifdef CONFIG_SIMULATION
-	__raw_writeq(50000 / HZ,
+	__raw_writeq((50000 / HZ) - 1,
 		     IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT)));
 #else
-	__raw_writeq(1000000 / HZ,
+	__raw_writeq((V_SCD_TIMER_FREQ / HZ) - 1,
 		     IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT)));
 #endif
 
@@ -104,7 +132,7 @@
 	int cpu = smp_processor_id();
 	int irq = K_INT_TIMER_0 + cpu;
 
-	/* Reset the timer */
+	/* ACK interrupt */
 	____raw_writeq(M_SCD_TIMER_ENABLE | M_SCD_TIMER_MODE_CONTINUOUS,
 		       IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
 
@@ -122,15 +150,26 @@
 }
 
 /*
- * We use our own do_gettimeoffset() instead of the generic one,
- * because the generic one does not work for SMP case.
- * In addition, since we use general timer 0 for system time,
- * we can get accurate intra-jiffy offset without calibration.
+ * The HPT is free running from SB1250_HPT_VALUE down to 0 then starts over
+ * again. There's no easy way to set to a specific value so store init value
+ * in hpt_offset and subtract each time.
+ *
+ * Note: Timer isn't full 32bits so shift it into the upper part making
+ *       it appear to run at a higher frequency.
  */
-unsigned long sb1250_gettimeoffset(void)
+static unsigned int sb1250_hpt_read(void)
 {
-	unsigned long count =
-		__raw_readq(IOADDR(A_SCD_TIMER_REGISTER(0, R_SCD_TIMER_CNT)));
+	unsigned int count;
+
+	count = G_SCD_TIMER_CNT(__raw_readq(IOADDR(A_SCD_TIMER_REGISTER(SB1250_HPT_NUM, R_SCD_TIMER_CNT))));
 
-	return 1000000/HZ - count;
- }
+	count = (SB1250_HPT_VALUE - count) << SB1250_HPT_SHIFT;
+
+	return count - hpt_offset;
+}
+
+static void sb1250_hpt_init(unsigned int count)
+{
+	hpt_offset = count;
+	return;
+}
diff -Nru a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
--- a/arch/mips/sibyte/swarm/setup.c	2005-07-20 10:25:22 -04:00
+++ b/arch/mips/sibyte/swarm/setup.c	2005-07-20 10:25:22 -04:00
@@ -64,6 +64,12 @@
 	return "SiByte " SIBYTE_BOARD_NAME;
 }
 
+void __init swarm_time_init(void)
+{
+	/* Setup HPT */
+	sb1250_hpt_setup();
+}
+
 void __init swarm_timer_setup(struct irqaction *irq)
 {
         /*
@@ -96,6 +102,7 @@
 
 	panic_timeout = 5;  /* For debug.  */
 
+	board_time_init = swarm_time_init;
 	board_timer_setup = swarm_timer_setup;
 	board_be_handler = swarm_be_handler;
 
diff -Nru a/include/asm-mips/sibyte/sb1250.h b/include/asm-mips/sibyte/sb1250.h
--- a/include/asm-mips/sibyte/sb1250.h	2005-07-20 10:25:22 -04:00
+++ b/include/asm-mips/sibyte/sb1250.h	2005-07-20 10:25:22 -04:00
@@ -41,8 +41,8 @@
 extern unsigned int periph_rev;
 extern unsigned int zbbus_mhz;
 
+extern void sb1250_hpt_setup(void);
 extern void sb1250_time_init(void);
-extern unsigned long sb1250_gettimeoffset(void);
 extern void sb1250_mask_irq(int cpu, int irq);
 extern void sb1250_unmask_irq(int cpu, int irq);
 extern void sb1250_smp_finish(void);
diff -Nru a/include/asm-mips/sibyte/sb1250_scd.h b/include/asm-mips/sibyte/sb1250_scd.h
--- a/include/asm-mips/sibyte/sb1250_scd.h	2005-07-20 10:25:22 -04:00
+++ b/include/asm-mips/sibyte/sb1250_scd.h	2005-07-20 10:25:22 -04:00
@@ -307,14 +307,15 @@
  */
 
 #define V_SCD_TIMER_FREQ            1000000
+#define V_SCD_TIMER_WIDTH           23
 
 #define S_SCD_TIMER_INIT            0
-#define M_SCD_TIMER_INIT            _SB_MAKEMASK(20,S_SCD_TIMER_INIT)
+#define M_SCD_TIMER_INIT            _SB_MAKEMASK(V_SCD_TIMER_WIDTH,S_SCD_TIMER_INIT)
 #define V_SCD_TIMER_INIT(x)         _SB_MAKEVALUE(x,S_SCD_TIMER_INIT)
 #define G_SCD_TIMER_INIT(x)         _SB_GETVALUE(x,S_SCD_TIMER_INIT,M_SCD_TIMER_INIT)
 
 #define S_SCD_TIMER_CNT             0
-#define M_SCD_TIMER_CNT             _SB_MAKEMASK(20,S_SCD_TIMER_CNT)
+#define M_SCD_TIMER_CNT             _SB_MAKEMASK(V_SCD_TIMER_WIDTH,S_SCD_TIMER_CNT)
 #define V_SCD_TIMER_CNT(x)         _SB_MAKEVALUE(x,S_SCD_TIMER_CNT)
 #define G_SCD_TIMER_CNT(x)         _SB_GETVALUE(x,S_SCD_TIMER_CNT,M_SCD_TIMER_CNT)
 
