Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2003 14:02:32 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:17392 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224821AbTHKNCU>; Mon, 11 Aug 2003 14:02:20 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA19944;
	Mon, 11 Aug 2003 15:02:17 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 11 Aug 2003 15:02:16 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [patch] Generic time trailing clean-ups
Message-ID: <Pine.GSO.3.96.1030811144812.19197C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Here is hopefully the final part (for now) of the generic time changes.
It addresses the following problems:

1. Due to the fact timers are initialized long before interrupts are
enabled, the high precision timer (HPT) is much fast compared to jiffies. 
This is now handled by reinitializing the HPT in timer_interrupt().

2. c0_fixed_hpt_init() doesn't set expirelo and cp0.compare properly
outside the first jiffy.

3. calibrate_div64_gettimeoffset() suffers from the R4000 erratum #28. 

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-20030725-mips-time-init-4
diff -up --recursive --new-file linux-mips-2.4.21-20030725.macro/arch/mips/kernel/time.c linux-mips-2.4.21-20030725/arch/mips/kernel/time.c
--- linux-mips-2.4.21-20030725.macro/arch/mips/kernel/time.c	2003-08-05 00:10:35.000000000 +0000
+++ linux-mips-2.4.21-20030725/arch/mips/kernel/time.c	2003-08-09 20:23:25.000000000 +0000
@@ -138,10 +138,10 @@ static void c0_hpt_init(unsigned int cou
 /* For a known frequency.  Used as an interrupt source.  */
 static void c0_fixed_hpt_init(unsigned int count)
 {
-	expirelo = cycles_per_jiffy;
 	count = read_c0_count() - count;
-	write_c0_count(0);
-	write_c0_compare(cycles_per_jiffy);
+	expirelo = (count / cycles_per_jiffy + 1) * cycles_per_jiffy;
+	write_c0_count(expirelo - cycles_per_jiffy);
+	write_c0_compare(expirelo);
 	write_c0_count(count);
 }
 
@@ -328,6 +328,7 @@ static unsigned long calibrate_div64_get
 				"dsll32	%1,%2,0\n\t"
 				"or	%1,%1,%0\n\t"
 				"ddivu	$0,%1,%4\n\t"
+				"nop\n\t"		/* R4000 erratum #28 */
 				"dsll32	%0,%5,0\n\t"
 				"or	%0,%0,%6\n\t"
 				"mflo	%1\n\t"
@@ -410,6 +411,7 @@ void local_timer_interrupt(int irq, void
  */
 void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	unsigned long j;
 	unsigned int count;
 
 	count = mips_hpt_read();
@@ -447,10 +449,41 @@ void timer_interrupt(int irq, void *dev_
 	 * If jiffies has overflown in this timer_interrupt, we must
 	 * update the timer[hi]/[lo] to make fast gettimeoffset funcs
 	 * quotient calc still valid. -arca
-	 */
-	if (!jiffies) {
-		timerhi = timerlo = 0;
-		mips_hpt_init(count);
+	 *
+	 * The first timer interrupt comes late as interrupts are
+	 * enabled long after timers are initialized.  Therefore the
+	 * high precision timer is fast, leading to wrong gettimeoffset()
+	 * calculations.  We deal with it by setting it based on the
+	 * number of its ticks between the second and the third interrupt.
+	 * That is still somewhat imprecise, but it's a good estimate.
+	 * --macro
+	 */
+	j = jiffies;
+	if (j < 4) {
+		static unsigned int prev_count;
+		static int hpt_initialized;
+
+		switch (j) {
+		case 0:
+			timerhi = timerlo = 0;
+			mips_hpt_init(count);
+			break;
+		case 2:
+			prev_count = count;
+			break;
+		case 3:
+			if (!hpt_initialized) {
+				unsigned int c3 = 3 * (count - prev_count);
+
+				timerhi = 0;
+				timerlo = c3;
+				mips_hpt_init(count - c3);
+				hpt_initialized = 1;
+			}
+			break;
+		default:
+			break;
+		}
 	}
 
 #if !defined(CONFIG_SMP)
diff -up --recursive --new-file linux-mips-2.4.21-20030725.macro/arch/mips64/kernel/time.c linux-mips-2.4.21-20030725/arch/mips64/kernel/time.c
--- linux-mips-2.4.21-20030725.macro/arch/mips64/kernel/time.c	2003-08-05 00:10:35.000000000 +0000
+++ linux-mips-2.4.21-20030725/arch/mips64/kernel/time.c	2003-08-09 20:23:42.000000000 +0000
@@ -138,10 +138,10 @@ static void c0_hpt_init(unsigned int cou
 /* For a known frequency.  Used as an interrupt source.  */
 static void c0_fixed_hpt_init(unsigned int count)
 {
-	expirelo = cycles_per_jiffy;
 	count = read_c0_count() - count;
-	write_c0_count(0);
-	write_c0_compare(cycles_per_jiffy);
+	expirelo = (count / cycles_per_jiffy + 1) * cycles_per_jiffy;
+	write_c0_count(expirelo - cycles_per_jiffy);
+	write_c0_compare(expirelo);
 	write_c0_count(count);
 }
 
@@ -185,7 +185,7 @@ void do_settimeofday(struct timeval *tv)
 	 * This is revolting.  We need to set "xtime" correctly.  However,
 	 * the value in this location is the value at the most recent update
 	 * of wall time.  Discover what correction gettimeofday() would have
-	 * done, and then undo it!
+	 * made, and then undo it!
 	 */
 	tv->tv_usec -= do_gettimeoffset();
 	tv->tv_usec -= (jiffies - wall_jiffies) * USECS_PER_JIFFY;
@@ -328,6 +328,7 @@ static unsigned long calibrate_div64_get
 				"dsll32	%1,%2,0\n\t"
 				"or	%1,%1,%0\n\t"
 				"ddivu	$0,%1,%4\n\t"
+				"nop\n\t"		/* R4000 erratum #28 */
 				"dsll32	%0,%5,0\n\t"
 				"or	%0,%0,%6\n\t"
 				"mflo	%1\n\t"
@@ -410,6 +411,7 @@ void local_timer_interrupt(int irq, void
  */
 void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	unsigned long j;
 	unsigned int count;
 
 	count = mips_hpt_read();
@@ -447,10 +449,41 @@ void timer_interrupt(int irq, void *dev_
 	 * If jiffies has overflown in this timer_interrupt, we must
 	 * update the timer[hi]/[lo] to make fast gettimeoffset funcs
 	 * quotient calc still valid. -arca
-	 */
-	if (!jiffies) {
-		timerhi = timerlo = 0;
-		mips_hpt_init(count);
+	 *
+	 * The first timer interrupt comes late as interrupts are
+	 * enabled long after timers are initialized.  Therefore the
+	 * high precision timer is fast, leading to wrong gettimeoffset()
+	 * calculations.  We deal with it by setting it based on the
+	 * number of its ticks between the second and the third interrupt.
+	 * That is still somewhat imprecise, but it's a good estimate.
+	 * --macro
+	 */
+	j = jiffies;
+	if (j < 4) {
+		static unsigned int prev_count;
+		static int hpt_initialized;
+
+		switch (j) {
+		case 0:
+			timerhi = timerlo = 0;
+			mips_hpt_init(count);
+			break;
+		case 2:
+			prev_count = count;
+			break;
+		case 3:
+			if (!hpt_initialized) {
+				unsigned int c3 = 3 * (count - prev_count);
+
+				timerhi = 0;
+				timerlo = c3;
+				mips_hpt_init(count - c3);
+				hpt_initialized = 1;
+			}
+			break;
+		default:
+			break;
+		}
 	}
 
 #if !defined(CONFIG_SMP)
