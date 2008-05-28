Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2008 08:43:00 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:56989 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20025268AbYE1Hm5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 May 2008 08:42:57 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1K1GJD-0000Jf-3l
	for linux-mips@linux-mips.org; Wed, 28 May 2008 00:42:55 -0700
Message-ID: <17506903.post@talk.nabble.com>
Date:	Wed, 28 May 2008 00:42:55 -0700 (PDT)
From:	Daniel Laird <daniel.j.laird@nxp.com>
To:	linux-mips@linux-mips.org
Subject: Vectored Interrupts and timers for MIPS 4KC
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: daniel.j.laird@nxp.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips


I am trying to get a patch ready that will add the NXP 22X platform to the
kernel.  Currently it is running 2.6.24 and I am trying to bring forward
support.
However to get things working on our platform we made some changes to
arch/mips/cevt-r4k.c.  These work well for us but i want to see if there is
a better way of doing this or whether the patch would be acceptable to rest
of the world:

--- initial/linux-2.6.24/arch/mips/kernel/cevt-r4k.c 
+++ rel-1.0/arch/mips/kernel/cevt-r4k.c 
@@ -47,11 +47,28 @@
 static int cp0_timer_irq_installed;
 
 /*
+ * FIXME: This doesn't hold for the relocated E9000 compare interrupt.
+ */
+static inline int c0_compare_int_pending(void)
+{
+	return (read_c0_cause() >> cp0_compare_irq) & 0x100;
+}
+
+/*
  * Timer ack for an R4k-compatible timer of a known frequency.
  */
-static void c0_timer_ack(void)
-{
-	write_c0_compare(read_c0_compare());
+static inline void c0_timer_ack(bool timeout)
+{
+	int attempts_remaining = 10;
+	do
+	{
+		write_c0_compare(read_c0_compare());
+		irq_disable_hazard();
+		if (timeout)
+		{
+			attempts_remaining--;
+		}
+	} while (c0_compare_int_pending() && attempts_remaining);
 }
 
 /*
@@ -93,7 +110,7 @@
 	 * interrupt.  Being the paranoiacs we are we check anyway.
 	 */
 	if (!r2 || (read_c0_cause() & (1 << 30))) {
-		c0_timer_ack();
+		c0_timer_ack(false);
 #ifdef CONFIG_MIPS_MT_SMTC
 		if (cpu_data[cpu].vpe_id)
 			goto out;
@@ -169,12 +186,9 @@
 {
 }
 
-/*
- * FIXME: This doesn't hold for the relocated E9000 compare interrupt.
- */
-static int c0_compare_int_pending(void)
-{
-	return (read_c0_cause() >> cp0_compare_irq) & 0x100;
+static void c0_compare_dispatch(void)
+{
+	do_IRQ(MIPS_CPU_IRQ_BASE + cp0_compare_irq);
 }
 
 static int c0_compare_int_usable(void)
@@ -186,8 +200,7 @@
 	 * IP7 already pending?  Try to clear it by acking the timer.
 	 */
 	if (c0_compare_int_pending()) {
-		write_c0_compare(read_c0_count());
-		irq_disable_hazard();
+		c0_timer_ack(true);
 		if (c0_compare_int_pending())
 			return 0;
 	}
@@ -208,8 +221,7 @@
 	if (!c0_compare_int_pending())
 		return 0;
 
-	write_c0_compare(read_c0_count());
-	irq_disable_hazard();
+	c0_timer_ack(true);
 	if (c0_compare_int_pending())
 		return 0;
 
@@ -285,6 +297,10 @@
 #define CPUCTR_IMASKBIT (0x100 << cp0_compare_irq)
 	setup_irq_smtc(irq, &c0_compare_irqaction, CPUCTR_IMASKBIT);
 #else
+	if (cpu_has_vint && (irq == MIPS_CPU_IRQ_BASE + cp0_compare_irq))
+	{
+		set_vi_handler(cp0_compare_irq, c0_compare_dispatch);
+	}
 	setup_irq(irq, &c0_compare_irqaction);
 #endif

The reason for the patch is that we seem to have to bash the timer register
more than once to get it to work.  Hence the timer loop etc.  We also had to
add the set_vi_handler so that we could get vectored interrupt support
working.
I look forward to peoples input to these changes so that I can get my patch
in order :-)  
-- 
View this message in context: http://www.nabble.com/Vectored-Interrupts-and-timers-for-MIPS-4KC-tp17506903p17506903.html
Sent from the linux-mips main mailing list archive at Nabble.com.
