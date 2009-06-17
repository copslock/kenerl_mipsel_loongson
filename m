Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 02:02:22 +0200 (CEST)
Received: from fw1-az.mvista.com ([65.200.49.156]:55063 "EHLO
	shomer.az.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492853AbZFQACP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 02:02:15 +0200
Received: from shomer.az.mvista.com (localhost.localdomain [127.0.0.1])
	by shomer.az.mvista.com (8.14.2/8.14.2) with ESMTP id n5H010Tr006414
	for <linux-mips@linux-mips.org>; Tue, 16 Jun 2009 17:01:00 -0700
Received: (from tsa@localhost)
	by shomer.az.mvista.com (8.14.2/8.14.2/Submit) id n5H0104k006413
	for linux-mips@linux-mips.org; Tue, 16 Jun 2009 17:01:00 -0700
Date:	Tue, 16 Jun 2009 17:01:00 -0700
From:	Tim Anderson <tanderson@mvista.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 5/5] Synchronise Count registers across multiple cores
Message-ID: <20090617000100.GH6346@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsa@shomer.az.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanderson@mvista.com
Precedence: bulk
X-list: linux-mips

This implements the SMP counter synchronization. This is a
port of linux-mti commit 71fb5e76e8c01bfb04967131ac63a1d2194f8550

Signed-off-by: Tim Anderson <tanderson@mvista.com>
---
 arch/mips/include/asm/r4k-timer.h |    2 +-
 arch/mips/mti-malta/malta-time.c  |  154 +++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/r4k-timer.h b/arch/mips/include/asm/r4k-timer.h
index a37d12b..af34634 100644
--- a/arch/mips/include/asm/r4k-timer.h
+++ b/arch/mips/include/asm/r4k-timer.h
@@ -10,7 +10,7 @@
 
 #include <linux/compiler.h>
 
-#ifdef CONFIG_SYNC_R4K
+#if defined(CONFIG_SYNC_R4K) || defined(CONFIG_MIPS_CMP)
 
 extern void synchronise_count_master(void);
 extern void synchronise_count_slave(void);
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 0b97d47..e4fc2e0 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -28,6 +28,7 @@
 #include <linux/timex.h>
 #include <linux/mc146818rtc.h>
 
+#include <linux/delay.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/hardirq.h>
@@ -161,3 +162,156 @@ void __init plat_time_init(void)
 
 	plat_perf_setup();
 }
+#ifdef CONFIG_SMP
+/*
+ * Count register synchronisation.
+ *
+ * All CPUs will have their count registers synchronised to the CPU0 next time
+ * value. This can cause a small timewarp for CPU0. All other CPU's should
+ * not have done anything significant (but they may have had interrupts
+ * enabled briefly - prom_smp_finish() should not be responsible for enabling
+ * interrupts...)
+ *
+ * FIXME: broken for SMTC
+ *
+ */
+
+static atomic_t __cpuinitdata count_start_flag = ATOMIC_INIT(0);
+static atomic_t __cpuinitdata count_count_start = ATOMIC_INIT(0);
+static atomic_t __cpuinitdata count_count_stop = ATOMIC_INIT(0);
+static atomic_t __cpuinitdata count_reference = ATOMIC_INIT(0);
+
+#define COUNTON	100
+#define NR_LOOPS 5
+
+void __cpuinit synchronise_count_master(void)
+{
+	int i;
+	unsigned long flags;
+	unsigned int initcount;
+	int nslaves;
+
+#ifdef CONFIG_MIPS_MT_SMTC
+	/*
+	 * SMTC needs to synchronise per VPE, not per CPU
+	 * ignore for now
+	 */
+	return;
+#endif
+
+	printk(KERN_INFO "Synchronize counters across %u CPUs: ",
+	       num_online_cpus());
+
+	local_irq_save(flags);
+
+	/*
+	 * Notify the slaves that it's time to start
+	 */
+	atomic_set(&count_reference, read_c0_count());
+	atomic_set(&count_start_flag, 1);
+	smp_wmb();		/* Allow other CPU's see this update */
+
+	/* Count will be initialised to current timer for all CPU's */
+	initcount = read_c0_count();
+
+	/*
+	 * We loop a few times to get a primed instruction cache,
+	 * then the last pass is more or less synchronised and
+	 * the master and slaves each set their cycle counters to a known
+	 * value all at once. This reduces the chance of having random offsets
+	 * between the processors, and guarantees that the maximum
+	 * delay between the cycle counters is never bigger than
+	 * the latency of information-passing (cachelines) between
+	 * two CPUs.
+	 */
+
+	nslaves = num_online_cpus()-1;
+	for (i = 0; i < NR_LOOPS; i++) {
+		/* slaves loop on '!= ncpus' */
+		while (atomic_read(&count_count_start) != nslaves)
+			mb();	/* Wait for other CPUs */
+		atomic_set(&count_count_stop, 0);
+		smp_wmb();	/* Inform other CPUs */
+
+		/* this lets the slaves write their count register */
+		atomic_inc(&count_count_start);
+
+		/*
+		 * Everyone initialises count in the last loop:
+		 */
+		if (i == NR_LOOPS-1)
+			write_c0_count(initcount);
+
+		/*
+		 * Wait for all slaves to leave the synchronization point:
+		 */
+		while (atomic_read(&count_count_stop) != nslaves)
+			mb();	/* Wait for other CPUs */
+		atomic_set(&count_count_start, 0);
+		smp_wmb();	/* Inform other CPUs */
+		atomic_inc(&count_count_stop);
+	}
+	/* Arrange for an interrupt in a short while */
+	write_c0_compare(read_c0_count() + COUNTON);
+
+	local_irq_restore(flags);
+
+	/*
+	 * i386 code reported the skew here, but the
+	 * count registers were almost certainly out of sync
+	 * so no point in alarming people
+	 */
+	printk("done.\n");
+}
+
+void __cpuinit synchronise_count_slave(void)
+{
+	int i;
+	unsigned long flags;
+	unsigned int initcount;
+	int ncpus;
+
+#ifdef CONFIG_MIPS_MT_SMTC
+	/*
+	 * SMTC needs to synchronise per VPE, not per CPU
+	 * ignore for now
+	 */
+	return;
+#endif
+
+	local_irq_save(flags);
+
+	/*
+	 * Not every cpu is online at the time this gets called,
+	 * so we first wait for the master to say everyone is ready
+	 */
+
+	while (!atomic_read(&count_start_flag))
+		mb();		/* Wait for master */
+
+	/* Count will be initialised to next expire for all CPU's */
+	initcount = atomic_read(&count_reference);
+
+	ncpus = num_online_cpus();
+	for (i = 0; i < NR_LOOPS; i++) {
+		atomic_inc(&count_count_start);
+		while (atomic_read(&count_count_start) != ncpus)
+			mb();	/* Wait for all CPUs */
+
+		/*
+		 * Everyone initialises count in the last loop:
+		 */
+		if (i == NR_LOOPS-1)
+			write_c0_count(initcount);
+
+		atomic_inc(&count_count_stop);
+		while (atomic_read(&count_count_stop) != ncpus)
+			mb();	/* Wait for all CPUs */
+	}
+	/* Arrange for an interrupt in a short while */
+	write_c0_compare(read_c0_count() + COUNTON);
+
+	local_irq_restore(flags);
+}
+#undef NR_LOOPS
+#endif
-- 
1.6.2.5.170.gf2181
