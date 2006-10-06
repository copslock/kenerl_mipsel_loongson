Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2006 16:35:35 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:25610 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039472AbWJFPfa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2006 16:35:30 +0100
Received: by mo.po.2iij.net (mo30) id k96FZQe9028474; Sat, 7 Oct 2006 00:35:26 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox33) id k96FZHLf031391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 7 Oct 2006 00:35:18 +0900 (JST)
Date:	Sat, 7 Oct 2006 00:35:16 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] fix build errors by IRQ hander change
Message-Id: <20061007003516.5eec677e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed build errors by the IRQ handler change.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/smtc.c mips/arch/mips/kernel/smtc.c
--- mips-orig/arch/mips/kernel/smtc.c	2006-10-06 23:19:07.909029750 +0900
+++ mips/arch/mips/kernel/smtc.c	2006-10-06 23:25:16.796083750 +0900
@@ -846,7 +846,7 @@ void ipi_decode(struct pt_regs *regs, st
 #ifdef SMTC_IDLE_HOOK_DEBUG
 		clock_hang_reported[dest_copy] = 0;
 #endif /* SMTC_IDLE_HOOK_DEBUG */
-		local_timer_interrupt(0, NULL, regs);
+		local_timer_interrupt(0, NULL);
 		break;
 	case LINUX_SMP_IPI:
 		switch ((int)arg_copy) {
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/mips-boards/generic/time.c mips/arch/mips/mips-boards/generic/time.c
--- mips-orig/arch/mips/mips-boards/generic/time.c	2006-10-06 23:19:07.981034250 +0900
+++ mips/arch/mips/mips-boards/generic/time.c	2006-10-06 23:25:16.816085000 +0900
@@ -94,7 +94,7 @@ extern int null_perf_irq(struct pt_regs 
 
 extern int (*perf_irq)(struct pt_regs *regs);
 
-irqreturn_t mips_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t mips_timer_interrupt(int irq, void *dev_id)
 {
 	int cpu = smp_processor_id();
 
@@ -119,7 +119,7 @@ irqreturn_t mips_timer_interrupt(int irq
 	 * perf counter overflow, or both.
 	 */
 	if (read_c0_cause() & (1 << 26))
-		perf_irq(regs);
+		perf_irq(get_irq_regs());
 
 	if (read_c0_cause() & (1 << 30)) {
 		/* If timer interrupt, make it de-assert */
@@ -139,13 +139,13 @@ irqreturn_t mips_timer_interrupt(int irq
 		 * the tick on VPE 0 to run the full timer_interrupt().
 		 */
 		if (cpu_data[cpu].vpe_id == 0) {
-				timer_interrupt(irq, NULL, regs);
+				timer_interrupt(irq, NULL);
 				smtc_timer_broadcast(cpu_data[cpu].vpe_id);
 				scroll_display_message();
 		} else {
 			write_c0_compare(read_c0_count() +
 			                 (mips_hpt_frequency/HZ));
-			local_timer_interrupt(irq, dev_id, regs);
+			local_timer_interrupt(irq, dev_id);
 			smtc_timer_broadcast(cpu_data[cpu].vpe_id);
 		}
 	}
@@ -159,12 +159,12 @@ irqreturn_t mips_timer_interrupt(int irq
 		 * timer int.
 		 */
 		if (!r2 || (read_c0_cause() & (1 << 26)))
-			if (perf_irq(regs))
+			if (perf_irq(get_irq_regs()))
 				goto out;
 
 		/* we keep interrupt disabled all the time */
 		if (!r2 || (read_c0_cause() & (1 << 30)))
-			timer_interrupt(irq, NULL, regs);
+			timer_interrupt(irq, NULL);
 
 		scroll_display_message();
 	} else {
@@ -180,7 +180,7 @@ irqreturn_t mips_timer_interrupt(int irq
 		/*
 		 * Other CPUs should do profiling and process accounting
 		 */
-		local_timer_interrupt(irq, dev_id, regs);
+		local_timer_interrupt(irq, dev_id);
 	}
 out:
 #endif /* CONFIG_MIPS_MT_SMTC */
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/mips-boards/sim/sim_time.c mips/arch/mips/mips-boards/sim/sim_time.c
--- mips-orig/arch/mips/mips-boards/sim/sim_time.c	2006-10-06 23:19:07.985034500 +0900
+++ mips/arch/mips/mips-boards/sim/sim_time.c	2006-10-06 23:25:16.848087000 +0900
@@ -33,7 +33,7 @@
 
 unsigned long cpu_khz;
 
-irqreturn_t sim_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t sim_timer_interrupt(int irq, void *dev_id)
 {
 #ifdef CONFIG_SMP
 	int cpu = smp_processor_id();
@@ -44,7 +44,7 @@ irqreturn_t sim_timer_interrupt(int irq,
 	 */
 #ifndef CONFIG_MIPS_MT_SMTC
 	if (cpu == 0) {
-		timer_interrupt(irq, dev_id, regs);
+		timer_interrupt(irq, dev_id);
 	}
 	else {
 		/* Everyone else needs to reset the timer int here as
@@ -84,7 +84,7 @@ irqreturn_t sim_timer_interrupt(int irq,
 	irq_enable_hazard();
 	evpe(vpflags);
 
-	if(cpu_data[cpu].vpe_id == 0) timer_interrupt(irq, dev_id, regs);
+	if(cpu_data[cpu].vpe_id == 0) timer_interrupt(irq, dev_id);
 	else write_c0_compare (read_c0_count() + ( mips_hpt_frequency/HZ));
 	smtc_timer_broadcast(cpu_data[cpu].vpe_id);
 
@@ -93,10 +93,10 @@ irqreturn_t sim_timer_interrupt(int irq,
 	/*
 	 * every CPU should do profiling and process accounting
 	 */
- 	local_timer_interrupt (irq, dev_id, regs);
+ 	local_timer_interrupt (irq, dev_id);
 	return IRQ_HANDLED;
 #else
-	return timer_interrupt (irq, dev_id, regs);
+	return timer_interrupt (irq, dev_id);
 #endif
 }
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/sgi-ip27/ip27-timer.c mips/arch/mips/sgi-ip27/ip27-timer.c
--- mips-orig/arch/mips/sgi-ip27/ip27-timer.c	2006-10-06 23:19:08.065039500 +0900
+++ mips/arch/mips/sgi-ip27/ip27-timer.c	2006-10-06 23:25:16.856087500 +0900
@@ -87,15 +87,11 @@ static int set_rtc_mmss(unsigned long no
 }
 #endif
 
-static unsigned int rt_timer_irq;
-
-void ip27_rt_timer_interrupt(struct pt_regs *regs)
+irqreturn_t ip27_rt_timer_interrupt(int irq, void *dev_id)
 {
 	int cpu = smp_processor_id();
 	int cpuA = cputoslice(cpu) == 0;
-	unsigned int irq = rt_timer_irq;
 
-	irq_enter();
 	write_seqlock(&xtime_lock);
 
 again:
@@ -111,7 +107,7 @@ again:
 	if (cpu == 0)
 		do_timer(1);
 
-	update_process_times(user_mode(regs));
+	update_process_times(user_mode(get_irq_regs()));
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
@@ -131,7 +127,8 @@ again:
 	}
 
 	write_sequnlock(&xtime_lock);
-	irq_exit();
+
+	return IRQ_HANDLED;
 }
 
 unsigned long ip27_do_gettimeoffset(void)
@@ -241,7 +238,6 @@ void __init plat_timer_setup(struct irqa
 	/* setup irqaction */
 	irq_desc[irqno].status |= IRQ_PER_CPU;
 
-	rt_timer_irq = irqno;
 	/*
 	 * Only needed to get /proc/interrupt to display timer irq stats
 	 */
