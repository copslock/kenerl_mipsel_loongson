Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2006 15:48:06 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:12253 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133813AbWDYOrx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Apr 2006 15:47:53 +0100
Received: from localhost (p1199-ipad30funabasi.chiba.ocn.ne.jp [221.184.76.199])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 47C8E9A98; Wed, 26 Apr 2006 00:00:55 +0900 (JST)
Date:	Wed, 26 Apr 2006 00:01:27 +0900 (JST)
Message-Id: <20060426.000127.108120574.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] oprofile cleanups
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060324.131809.115639866.nemoto@toshiba-tops.co.jp>
References: <20060216.234519.82087885.anemo@mba.ocn.ne.jp>
	<20060324.131809.115639866.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11200
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
index 13ff4da..f470ec5 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -414,6 +414,18 @@ void local_timer_interrupt(int irq, void
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
@@ -422,6 +434,22 @@ irqreturn_t timer_interrupt(int irq, voi
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
 
@@ -509,38 +537,14 @@ irqreturn_t timer_interrupt(int irq, voi
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
index a9f6124..4eb9b96 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -65,13 +65,12 @@ static unsigned int display_count;
 
 #define CPUCTR_IMASKBIT (0x100 << MIPSCPU_INT_CPUCTR)
 
-static unsigned int timer_tick_count;
 static int mips_cpu_timer_irq;
 extern void smtc_timer_broadcast(int);
 
 static inline void scroll_display_message(void)
 {
-	if ((timer_tick_count++ % HZ) == 0) {
+	if ((jiffies % HZ) == 0) {
 		mips_display_message(&display_string[display_count++]);
 		if (display_count == MAX_DISPLAY_COUNT)
 			display_count = 0;
@@ -83,17 +82,9 @@ static void mips_timer_dispatch (struct 
 	do_IRQ (mips_cpu_timer_irq, regs);
 }
 
-/*
- * Redeclare until I get around mopping the timer code insanity on MIPS.
- */
-extern int null_perf_irq(struct pt_regs *regs);
-
-extern int (*perf_irq)(struct pt_regs *regs);
-
 irqreturn_t mips_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
-	int r2 = cpu_has_mips_r2;
 
 #ifdef CONFIG_MIPS_MT_SMTC
         /*
@@ -138,13 +129,7 @@ irqreturn_t mips_timer_interrupt(int irq
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
@@ -164,7 +149,6 @@ irqreturn_t mips_timer_interrupt(int irq
 	}
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-out:
 	return IRQ_HANDLED;
 }
 
