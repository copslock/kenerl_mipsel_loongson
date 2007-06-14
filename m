Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 11:20:09 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.175]:54845 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022747AbXFNKTo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 11:19:44 +0100
Received: by ug-out-1314.google.com with SMTP id m3so647571ugc
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2007 03:19:43 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=mLBrb5gYTBsJN3RXvQaVCEUemWcJipI9gZ+rRnT9ErinqJLRcMjJEAfIE878hjGhDD41qXNdGOGdj/yw9F6vAMt73ijekmqU6/YB0zh4N8BvIU6w33nXFKyiDWbBFtxZ2TAkfVsQWZNtpqa0+fayk//9sdStTehOhuRd3pXVcXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=NzLk8qVpjMuoQXhkWbLfJDIhjE3CyuWGxYAfBg6W4Z3Y02M6HJGzw+3VFRRHn+Nqw0SOcnJ8DhxphT9PyPRmzN2U61p6TKkrcSCv3bTO6Y2WsIrtMLRFLUg2l9p5gelCvZ+bp9G8dqrVHARNLE8hzbxQj2km2lqXBmQ/yOtIpmU=
Received: by 10.66.217.5 with SMTP id p5mr1967936ugg.1181816383800;
        Thu, 14 Jun 2007 03:19:43 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id z37sm3863714ikz.2007.06.14.03.19.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2007 03:19:43 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id D2F7723F773; Thu, 14 Jun 2007 12:20:02 +0200 (CEST)
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4/5] Consolidate all variants of MIPS cp0 timer interrupt handlers.
Date:	Thu, 14 Jun 2007 12:20:00 +0200
Message-Id: <118181640247-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818164011355-git-send-email-fbuihuu@gmail.com>
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Ralf Baechle <ralf@linux-mips.org>

---
 arch/mips/au1000/common/irq.c        |    3 +-
 arch/mips/au1000/common/time.c       |   40 --------------
 arch/mips/kernel/smtc.c              |    2 +-
 arch/mips/kernel/time.c              |   81 +++++++++++++++++++++++++---
 arch/mips/mips-boards/generic/time.c |   97 ----------------------------------
 arch/mips/mips-boards/sim/sim_time.c |   70 ------------------------
 arch/mips/sgi-ip22/ip22-int.c        |    3 +-
 arch/mips/sgi-ip22/ip22-time.c       |   10 ----
 arch/mips/sibyte/bcm1480/time.c      |   13 +----
 arch/mips/sibyte/sb1250/time.c       |   13 +----
 include/asm-mips/time.h              |    5 +-
 11 files changed, 80 insertions(+), 257 deletions(-)

diff --git a/arch/mips/au1000/common/irq.c b/arch/mips/au1000/common/irq.c
index ea6e99f..cb33d9e 100644
--- a/arch/mips/au1000/common/irq.c
+++ b/arch/mips/au1000/common/irq.c
@@ -67,7 +67,6 @@
 
 extern void set_debug_traps(void);
 extern irq_cpustat_t irq_stat [NR_CPUS];
-extern void mips_timer_interrupt(void);
 
 static void setup_local_irq(unsigned int irq, int type, int int_req);
 static void end_irq(unsigned int irq_nr);
@@ -646,7 +645,7 @@ asmlinkage void plat_irq_dispatch(void)
 	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
 
 	if (pending & CAUSEF_IP7)
-		mips_timer_interrupt();
+		ll_timer_interrupt(63);
 	else if (pending & CAUSEF_IP2)
 		intc0_req0_irqdispatch();
 	else if (pending & CAUSEF_IP3)
diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index b32bf46..7028025 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -64,48 +64,8 @@ static unsigned long last_pc0, last_match20;
 
 static DEFINE_SPINLOCK(time_lock);
 
-static inline void ack_r4ktimer(unsigned long newval)
-{
-	write_c0_compare(newval);
-}
-
-/*
- * There are a lot of conceptually broken versions of the MIPS timer interrupt
- * handler floating around.  This one is rather different, but the algorithm
- * is provably more robust.
- */
 unsigned long wtimer;
 
-void mips_timer_interrupt(void)
-{
-	int irq = 63;
-
-	irq_enter();
-	kstat_this_cpu.irqs[irq]++;
-
-	if (r4k_offset == 0)
-		goto null;
-
-	do {
-		kstat_this_cpu.irqs[irq]++;
-		do_timer(1);
-#ifndef CONFIG_SMP
-		update_process_times(user_mode(get_irq_regs()));
-#endif
-		r4k_cur += r4k_offset;
-		ack_r4ktimer(r4k_cur);
-
-	} while (((unsigned long)read_c0_count()
-	         - r4k_cur) < 0x7fffffff);
-
-	irq_exit();
-	return;
-
-null:
-	ack_r4ktimer(0);
-	irq_exit();
-}
-
 #ifdef CONFIG_PM
 irqreturn_t counter0_irq(int irq, void *dev_id)
 {
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 21eb599..8b95808 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -828,7 +828,7 @@ void ipi_decode(struct smtc_ipi *pipi)
 #ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
 		clock_hang_reported[dest_copy] = 0;
 #endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */
-		local_timer_interrupt(0, NULL);
+		local_timer_interrupt(0);
 		irq_exit();
 		break;
 	case LINUX_SMP_IPI:
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index d176e91..a75d63b 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -131,7 +131,7 @@ void (*mips_timer_ack)(void);
  * a broadcasted inter-processor interrupt which itself is triggered
  * by the global timer interrupt.
  */
-void local_timer_interrupt(int irq, void *dev_id)
+void local_timer_interrupt(int irq)
 {
 	profile_tick(CPU_PROFILING);
 	update_process_times(user_mode(get_irq_regs()));
@@ -161,7 +161,7 @@ irqreturn_t timer_interrupt(int irq, void *dev_id)
 	 * In SMP mode, local_timer_interrupt() is invoked by appropriate
 	 * low-level local timer interrupt handler.
 	 */
-	local_timer_interrupt(irq, dev_id);
+	local_timer_interrupt(irq);
 
 	return IRQ_HANDLED;
 }
@@ -171,9 +171,10 @@ int null_perf_irq(void)
 	return 0;
 }
 
+EXPORT_SYMBOL(null_perf_irq);
+
 int (*perf_irq)(void) = null_perf_irq;
 
-EXPORT_SYMBOL(null_perf_irq);
 EXPORT_SYMBOL(perf_irq);
 
 /*
@@ -186,7 +187,7 @@ EXPORT_SYMBOL(mipsxx_perfcount_irq);
  * Possibly handle a performance counter interrupt.
  * Return true if the timer interrupt should not be checked
  */
-static inline int handle_perf_irq (int r2)
+static inline int handle_perf_irq(int r2)
 {
 	/*
 	 * The performance counter overflow interrupt may be shared with the
@@ -200,25 +201,89 @@ static inline int handle_perf_irq (int r2)
 		!r2;
 }
 
-asmlinkage void ll_timer_interrupt(int irq)
+extern void smtc_timer_broadcast(int);
+
+void ll_timer_interrupt(int irq)
 {
+	int cpu = smp_processor_id();
 	int r2 = cpu_has_mips_r2;
 
 	irq_enter();
 	kstat_this_cpu.irqs[irq]++;
 
+#ifdef CONFIG_MIPS_MT_SMTC
+	/*
+	 *  In an SMTC system, one Count/Compare set exists per VPE.
+	 *  Which TC within a VPE gets the interrupt is essentially
+	 *  random - we only know that it shouldn't be one with
+	 *  IXMT set. Whichever TC gets the interrupt needs to
+	 *  send special interprocessor interrupts to the other
+	 *  TCs to make sure that they schedule, etc.
+	 *
+	 *  That code is specific to the SMTC kernel, not to
+	 *  the a particular platform, so it's invoked from
+	 *  the general MIPS timer_interrupt routine.
+	 */
+
+	/*
+	 * We could be here due to timer interrupt,
+	 * perf counter overflow, or both.
+	 */
+	(void) handle_perf_irq(1);
+
+	if (read_c0_cause() & (1 << 30)) {
+		/*
+		 * There are things we only want to do once per tick
+		 * in an "MP" system.   One TC of each VPE will take
+		 * the actual timer interrupt.  The others will get
+		 * timer broadcast IPIs. We use whoever it is that takes
+		 * the tick on VPE 0 to run the full timer_interrupt().
+		 */
+		if (cpu_data[cpu].vpe_id == 0) {
+			timer_interrupt(irq, NULL);
+		} else {
+			write_c0_compare(read_c0_count() +
+			                 (mips_hpt_frequency/HZ));
+			local_timer_interrupt(irq);
+		}
+		smtc_timer_broadcast(cpu_data[cpu].vpe_id);
+	}
+#else /* CONFIG_MIPS_MT_SMTC */
 	if (handle_perf_irq(r2))
 		goto out;
 
 	if (r2 && ((read_c0_cause() & (1 << 30)) == 0))
 		goto out;
 
-	timer_interrupt(irq, NULL);
-
+	if (cpu == 0) {
+		/*
+		 * CPU 0 handles the global timer interrupt job and process
+		 * accounting resets count/compare registers to trigger next
+		 * timer int.
+		 */
+		timer_interrupt(irq, NULL);
+	} else {
+		/* Everyone else needs to reset the timer int here as
+		   ll_local_timer_interrupt doesn't */
+		/*
+		 * FIXME: need to cope with counter underflow.
+		 * More support needs to be added to kernel/time for
+		 * counter/timer interrupts on multiple CPU's
+		 */
+		write_c0_compare(read_c0_count() + (mips_hpt_frequency/HZ));
+
+		/*
+		 * Other CPUs should do profiling and process accounting
+		 */
+		local_timer_interrupt(irq);
+	}
 out:
+#endif /* CONFIG_MIPS_MT_SMTC */
+
 	irq_exit();
 }
 
+
 asmlinkage void ll_local_timer_interrupt(int irq)
 {
 	irq_enter();
@@ -226,7 +291,7 @@ asmlinkage void ll_local_timer_interrupt(int irq)
 		kstat_this_cpu.irqs[irq]++;
 
 	/* we keep interrupt disabled all the time */
-	local_timer_interrupt(irq, NULL);
+	local_timer_interrupt(irq);
 
 	irq_exit();
 }
diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index 67a0718..1470318 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -75,101 +75,6 @@ extern int null_perf_irq(void);
 extern int (*perf_irq)(void);
 
 /*
- * Possibly handle a performance counter interrupt.
- * Return true if the timer interrupt should not be checked
- */
-static inline int handle_perf_irq (int r2)
-{
-	/*
-	 * The performance counter overflow interrupt may be shared with the
-	 * timer interrupt (mipsxx_perfcount_irq < 0). If it is and a
-	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
-	 * and we can't reliably determine if a counter interrupt has also
-	 * happened (!r2) then don't check for a timer interrupt.
-	 */
-	return (mipsxx_perfcount_irq < 0) &&
-		perf_irq() == IRQ_HANDLED &&
-		!r2;
-}
-
-irqreturn_t mips_timer_interrupt(int irq, void *dev_id)
-{
-	int cpu = smp_processor_id();
-
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 *  In an SMTC system, one Count/Compare set exists per VPE.
-	 *  Which TC within a VPE gets the interrupt is essentially
-	 *  random - we only know that it shouldn't be one with
-	 *  IXMT set. Whichever TC gets the interrupt needs to
-	 *  send special interprocessor interrupts to the other
-	 *  TCs to make sure that they schedule, etc.
-	 *
-	 *  That code is specific to the SMTC kernel, not to
-	 *  the a particular platform, so it's invoked from
-	 *  the general MIPS timer_interrupt routine.
-	 */
-
-	/*
-	 * We could be here due to timer interrupt,
-	 * perf counter overflow, or both.
-	 */
-	(void) handle_perf_irq(1);
-
-	if (read_c0_cause() & (1 << 30)) {
-		/*
-		 * There are things we only want to do once per tick
-		 * in an "MP" system.   One TC of each VPE will take
-		 * the actual timer interrupt.  The others will get
-		 * timer broadcast IPIs. We use whoever it is that takes
-		 * the tick on VPE 0 to run the full timer_interrupt().
-		 */
-		if (cpu_data[cpu].vpe_id == 0) {
-			timer_interrupt(irq, NULL);
-		} else {
-			write_c0_compare(read_c0_count() +
-			                 (mips_hpt_frequency/HZ));
-			local_timer_interrupt(irq, dev_id);
-		}
-		smtc_timer_broadcast(cpu_data[cpu].vpe_id);
-	}
-#else /* CONFIG_MIPS_MT_SMTC */
-	int r2 = cpu_has_mips_r2;
-
-	if (handle_perf_irq(r2))
-		goto out;
-
-	if (r2 && ((read_c0_cause() & (1 << 30)) == 0))
-		goto out;
-
-	if (cpu == 0) {
-		/*
-		 * CPU 0 handles the global timer interrupt job and process
-		 * accounting resets count/compare registers to trigger next
-		 * timer int.
-		 */
-		timer_interrupt(irq, NULL);
-	} else {
-		/* Everyone else needs to reset the timer int here as
-		   ll_local_timer_interrupt doesn't */
-		/*
-		 * FIXME: need to cope with counter underflow.
-		 * More support needs to be added to kernel/time for
-		 * counter/timer interrupts on multiple CPU's
-		 */
-		write_c0_compare(read_c0_count() + (mips_hpt_frequency/HZ));
-
-		/*
-		 * Other CPUs should do profiling and process accounting
-		 */
-		local_timer_interrupt(irq, dev_id);
-	}
-out:
-#endif /* CONFIG_MIPS_MT_SMTC */
-	return IRQ_HANDLED;
-}
-
-/*
  * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
  */
 static unsigned int __init estimate_cpu_frequency(void)
@@ -315,8 +220,6 @@ void __init plat_timer_setup(struct irqaction *irq)
 		mips_cpu_timer_irq = MIPSCPU_INT_BASE + hwint;
 	}
 
-	/* we are using the cpu counter for timer interrupts */
-	irq->handler = mips_timer_interrupt;	/* we use our own handler */
 #ifdef CONFIG_MIPS_MT_SMTC
 	setup_irq_smtc(mips_cpu_timer_irq, irq, 0x100 << hwint);
 #else
diff --git a/arch/mips/mips-boards/sim/sim_time.c b/arch/mips/mips-boards/sim/sim_time.c
index f8b8dff..32f2097 100644
--- a/arch/mips/mips-boards/sim/sim_time.c
+++ b/arch/mips/mips-boards/sim/sim_time.c
@@ -25,75 +25,6 @@
 
 unsigned long cpu_khz;
 
-irqreturn_t sim_timer_interrupt(int irq, void *dev_id)
-{
-#ifdef CONFIG_SMP
-	int cpu = smp_processor_id();
-
-	/*
-	 * CPU 0 handles the global timer interrupt job
-	 * resets count/compare registers to trigger next timer int.
-	 */
-#ifndef CONFIG_MIPS_MT_SMTC
-	if (cpu == 0) {
-		timer_interrupt(irq, dev_id);
-	}
-	else {
-		/* Everyone else needs to reset the timer int here as
-		   ll_local_timer_interrupt doesn't */
-		/*
-		 * FIXME: need to cope with counter underflow.
-		 * More support needs to be added to kernel/time for
-		 * counter/timer interrupts on multiple CPU's
-		 */
-		write_c0_compare (read_c0_count() + ( mips_hpt_frequency/HZ));
-	}
-#else /* SMTC */
-	/*
-	 *  In SMTC system, one Count/Compare set exists per VPE.
-	 *  Which TC within a VPE gets the interrupt is essentially
-	 *  random - we only know that it shouldn't be one with
-	 *  IXMT set. Whichever TC gets the interrupt needs to
-	 *  send special interprocessor interrupts to the other
-	 *  TCs to make sure that they schedule, etc.
-	 *
-	 *  That code is specific to the SMTC kernel, not to
-	 *  the simulation platform, so it's invoked from
-	 *  the general MIPS timer_interrupt routine.
-	 *
-	 * We have a problem in that the interrupt vector code
-	 * had to turn off the timer IM bit to avoid redundant
-	 * entries, but we may never get to mips_cpu_irq_end
-	 * to turn it back on again if the scheduler gets
-	 * involved.  So we clear the pending timer here,
-	 * and re-enable the mask...
-	 */
-
-	int vpflags = dvpe();
-	write_c0_compare (read_c0_count() - 1);
-	clear_c0_cause(0x100 << MIPSCPU_INT_CPUCTR);
-	set_c0_status(0x100 << MIPSCPU_INT_CPUCTR);
-	irq_enable_hazard();
-	evpe(vpflags);
-
-	if(cpu_data[cpu].vpe_id == 0) timer_interrupt(irq, dev_id);
-	else write_c0_compare (read_c0_count() + ( mips_hpt_frequency/HZ));
-	smtc_timer_broadcast(cpu_data[cpu].vpe_id);
-
-#endif /* CONFIG_MIPS_MT_SMTC */
-
-	/*
-	 * every CPU should do profiling and process accounting
-	 */
- 	local_timer_interrupt (irq, dev_id);
-	return IRQ_HANDLED;
-#else
-	return timer_interrupt (irq, dev_id);
-#endif
-}
-
-
-
 /*
  * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
  */
@@ -188,7 +119,6 @@ void __init plat_timer_setup(struct irqaction *irq)
 	}
 
 	/* we are using the cpu counter for timer interrupts */
-	irq->handler = sim_timer_interrupt;
 	setup_irq(mips_cpu_timer_irq, irq);
 
 #ifdef CONFIG_SMP
diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
index 1834832..790ccc5 100644
--- a/arch/mips/sgi-ip22/ip22-int.c
+++ b/arch/mips/sgi-ip22/ip22-int.c
@@ -204,7 +204,6 @@ static struct irqaction map1_cascade = {
 #define SGI_INTERRUPTS	SGINT_LOCAL3
 #endif
 
-extern void indy_r4k_timer_interrupt(void);
 extern void indy_8254timer_irq(void);
 
 /*
@@ -243,7 +242,7 @@ asmlinkage void plat_irq_dispatch(void)
 	 * First we check for r4k counter/timer IRQ.
 	 */
 	if (pending & CAUSEF_IP7)
-		indy_r4k_timer_interrupt();
+		ll_timer_interrupt(SGI_TIMER_IRQ);
 	else if (pending & CAUSEF_IP2)
 		indy_local0_irqdispatch();
 	else if (pending & CAUSEF_IP3)
diff --git a/arch/mips/sgi-ip22/ip22-time.c b/arch/mips/sgi-ip22/ip22-time.c
index 77f0c30..7f4e3b1 100644
--- a/arch/mips/sgi-ip22/ip22-time.c
+++ b/arch/mips/sgi-ip22/ip22-time.c
@@ -189,16 +189,6 @@ void indy_8254timer_irq(void)
 	irq_exit();
 }
 
-void indy_r4k_timer_interrupt(void)
-{
-	int irq = SGI_TIMER_IRQ;
-
-	irq_enter();
-	kstat_this_cpu.irqs[irq]++;
-	timer_interrupt(irq, NULL);
-	irq_exit();
-}
-
 void __init plat_timer_setup(struct irqaction *irq)
 {
 	/* over-write the handler, we use our own way */
diff --git a/arch/mips/sibyte/bcm1480/time.c b/arch/mips/sibyte/bcm1480/time.c
index 6f3f71b..8519091 100644
--- a/arch/mips/sibyte/bcm1480/time.c
+++ b/arch/mips/sibyte/bcm1480/time.c
@@ -103,18 +103,7 @@ void bcm1480_timer_interrupt(void)
 	__raw_writeq(M_SCD_TIMER_ENABLE|M_SCD_TIMER_MODE_CONTINUOUS,
 	      IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
 
-	if (cpu == 0) {
-		/*
-		 * CPU 0 handles the global timer interrupt job
-		 */
-		ll_timer_interrupt(irq);
-	}
-	else {
-		/*
-		 * other CPUs should just do profiling and process accounting
-		 */
-		ll_local_timer_interrupt(irq);
-	}
+	ll_timer_interrupt(irq);
 }
 
 static cycle_t bcm1480_hpt_read(void)
diff --git a/arch/mips/sibyte/sb1250/time.c b/arch/mips/sibyte/sb1250/time.c
index 2efffe1..5bb83cd 100644
--- a/arch/mips/sibyte/sb1250/time.c
+++ b/arch/mips/sibyte/sb1250/time.c
@@ -125,18 +125,7 @@ void sb1250_timer_interrupt(void)
 	____raw_writeq(M_SCD_TIMER_ENABLE | M_SCD_TIMER_MODE_CONTINUOUS,
 		       IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG)));
 
-	if (cpu == 0) {
-		/*
-		 * CPU 0 handles the global timer interrupt job
-		 */
-		ll_timer_interrupt(irq);
-	}
-	else {
-		/*
-		 * other CPUs should just do profiling and process accounting
-		 */
-		ll_local_timer_interrupt(irq);
-	}
+	ll_timer_interrupt(irq);
 }
 
 /*
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
index 74ab331..9a49a93 100644
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -63,13 +63,12 @@ extern irqreturn_t timer_interrupt(int irq, void *dev_id);
 /*
  * the corresponding low-level timer interrupt routine.
  */
-extern asmlinkage void ll_timer_interrupt(int irq);
+extern void ll_timer_interrupt(int irq);
 
 /*
  * profiling and process accouting is done separately in local_timer_interrupt
  */
-extern void local_timer_interrupt(int irq, void *dev_id);
-extern asmlinkage void ll_local_timer_interrupt(int irq);
+extern void local_timer_interrupt(int irq);
 
 /*
  * board specific routines required by time_init().
-- 
1.5.2.1
