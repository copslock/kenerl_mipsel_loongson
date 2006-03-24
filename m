Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 04:08:31 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:35405 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133382AbWCXEIO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 04:08:14 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 24 Mar 2006 13:18:15 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id E0D7F20634;
	Fri, 24 Mar 2006 13:18:10 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id CC2CC1F5CB;
	Fri, 24 Mar 2006 13:18:10 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k2O4IA4D066258;
	Fri, 24 Mar 2006 13:18:10 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 24 Mar 2006 13:18:09 +0900 (JST)
Message-Id: <20060324.131809.115639866.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] oprofile cleanups
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060216.234519.82087885.anemo@mba.ocn.ne.jp>
References: <20060216.234519.82087885.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Revised for current git tree.


1. Use CONFIG_OPROFILE to get rid of overhead for null_perf_irq() call.
2. Call perf_irq from timer_interrupt() instead of
   ll_timer_interrupt().  Many boards are using timer_interrupt(), so
   it would be better to call perf_irq() here.
3. Use jiffies instead of timer_tick_count in scroll_display_message().

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 51273b7..43b4845 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -415,6 +415,18 @@ void local_timer_interrupt(int irq, void
 	update_process_times(user_mode(regs));
 }
 
+#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
+int null_perf_irq(struct pt_regs *regs)
+{
+	return 0;
+}
+
+int (*perf_irq)(struct pt_regs *regs) = null_perf_irq;
+
+EXPORT_SYMBOL(null_perf_irq);
+EXPORT_SYMBOL(perf_irq);
+#endif
+
 /*
  * High-level timer interrupt service routines.  This function
  * is set as irqaction->handler and is invoked through do_IRQ.
@@ -423,6 +435,22 @@ irqreturn_t timer_interrupt(int irq, voi
 {
 	unsigned long j;
 	unsigned int count;
+#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
+	int r2 = cpu_has_mips_r2;
+
+	/*
+	 * Suckage alert:
+	 * Before R2 of the architecture there was no way to see if a
+	 * performance counter interrupt was pending, so we have to run the
+	 * performance counter interrupt handler anyway.
+	 */
+	if (!r2 || (read_c0_cause() & (1 << 26)))
+		if (perf_irq(regs))
+			return IRQ_HANDLED;
+
+	if (r2 && !(read_c0_cause() & (1 << 30)))
+		return IRQ_HANDLED;
+#endif
 
 	write_seqlock(&xtime_lock);
 
@@ -510,38 +538,14 @@ irqreturn_t timer_interrupt(int irq, voi
 	return IRQ_HANDLED;
 }
 
-int null_perf_irq(struct pt_regs *regs)
-{
-	return 0;
-}
-
-int (*perf_irq)(struct pt_regs *regs) = null_perf_irq;
-
-EXPORT_SYMBOL(null_perf_irq);
-EXPORT_SYMBOL(perf_irq);
-
 asmlinkage void ll_timer_interrupt(int irq, struct pt_regs *regs)
 {
-	int r2 = cpu_has_mips_r2;
-
 	irq_enter();
 	kstat_this_cpu.irqs[irq]++;
 
-	/*
-	 * Suckage alert:
-	 * Before R2 of the architecture there was no way to see if a
-	 * performance counter interrupt was pending, so we have to run the
-	 * performance counter interrupt handler anyway.
-	 */
-	if (!r2 || (read_c0_cause() & (1 << 26)))
-		if (perf_irq(regs))
-			goto out;
-
 	/* we keep interrupt disabled all the time */
-	if (!r2 || (read_c0_cause() & (1 << 30)))
-		timer_interrupt(irq, NULL, regs);
+	timer_interrupt(irq, NULL, regs);
 
-out:
 	irq_exit();
 }
 
diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index 93f3bf2..f9471de 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -58,12 +58,11 @@ static char display_string[] = "        
 static unsigned int display_count = 0;
 #define MAX_DISPLAY_COUNT (sizeof(display_string) - 8)
 
-static unsigned int timer_tick_count=0;
 static int mips_cpu_timer_irq;
 
 static inline void scroll_display_message(void)
 {
-	if ((timer_tick_count++ % HZ) == 0) {
+	if ((jiffies % HZ) == 0) {
 		mips_display_message(&display_string[display_count++]);
 		if (display_count == MAX_DISPLAY_COUNT)
 			display_count = 0;
@@ -75,13 +74,8 @@ static void mips_timer_dispatch (struct 
 	do_IRQ (mips_cpu_timer_irq, regs);
 }
 
-extern int null_perf_irq(struct pt_regs *regs);
-
-extern int (*perf_irq)(struct pt_regs *regs);
-
 irqreturn_t mips_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	int r2 = cpu_has_mips_r2;
 	int cpu = smp_processor_id();
 
 	if (cpu == 0) {
@@ -90,13 +84,7 @@ irqreturn_t mips_timer_interrupt(int irq
 		 * accounting resets count/compare registers to trigger next
 		 * timer int.
 		 */
-		if (!r2 || (read_c0_cause() & (1 << 26)))
-			if (perf_irq(regs))
-				goto out;
-
-		/* we keep interrupt disabled all the time */
-		if (!r2 || (read_c0_cause() & (1 << 30)))
-			timer_interrupt(irq, NULL, regs);
+		timer_interrupt(irq, NULL, regs);
 
 		scroll_display_message();
 	} else {
@@ -114,7 +102,6 @@ irqreturn_t mips_timer_interrupt(int irq
 		local_timer_interrupt (irq, dev_id, regs);
 	}
 
-out:
 	return IRQ_HANDLED;
 }
 
