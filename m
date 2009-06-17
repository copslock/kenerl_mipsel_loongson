Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2009 01:27:31 +0200 (CEST)
Received: from fw1-az.mvista.com ([65.200.49.156]:5007 "EHLO
	shomer.az.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492210AbZFQX1Y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2009 01:27:24 +0200
Received: from shomer.az.mvista.com (localhost.localdomain [127.0.0.1])
	by shomer.az.mvista.com (8.14.2/8.14.2) with ESMTP id n5HNPrZ8010771
	for <linux-mips@linux-mips.org>; Wed, 17 Jun 2009 16:25:53 -0700
Received: (from tsa@localhost)
	by shomer.az.mvista.com (8.14.2/8.14.2/Submit) id n5HNPrTJ010770
	for linux-mips@linux-mips.org; Wed, 17 Jun 2009 16:25:53 -0700
Date:	Wed, 17 Jun 2009 16:25:53 -0700
From:	Tim Anderson <tanderson@mvista.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 5/5] Update sync-r4k for current kernel
Message-ID: <20090617232553.GF10714@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsa@shomer.az.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanderson@mvista.com
Precedence: bulk
X-list: linux-mips

This revises the sync-4k so it will boot and operate
since the removal of expirelo from the timer code.

Signed-off-by: Tim Anderson <tanderson@mvista.com>
---
 arch/mips/Kconfig           |    2 +-
 arch/mips/kernel/sync-r4k.c |   26 ++++++++++++++------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7e8ecf6..de0d152 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1624,7 +1624,7 @@ config MIPS_APSP_KSPD
 config MIPS_CMP
 	bool "MIPS CMP framework support"
 	depends on SYS_SUPPORTS_MIPS_CMP
-	select SYNC_R4K if BROKEN
+	select SYNC_R4K
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_SCHED_SMT if SMP
 	select WEAK_ORDERING
diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
index 9021108..3c60a34 100644
--- a/arch/mips/kernel/sync-r4k.c
+++ b/arch/mips/kernel/sync-r4k.c
@@ -1,7 +1,7 @@
 /*
  * Count register synchronisation.
  *
- * All CPUs will have their count registers synchronised to the CPU0 expirelo
+ * All CPUs will have their count registers synchronised to the CPU0 next time
  * value. This can cause a small timewarp for CPU0. All other CPU's should
  * not have done anything significant (but they may have had interrupts
  * enabled briefly - prom_smp_finish() should not be responsible for enabling
@@ -20,14 +20,15 @@
 #include <asm/cpumask.h>
 #include <asm/mipsregs.h>
 
-static atomic_t __initdata count_start_flag = ATOMIC_INIT(0);
-static atomic_t __initdata count_count_start = ATOMIC_INIT(0);
-static atomic_t __initdata count_count_stop = ATOMIC_INIT(0);
+static atomic_t __cpuinitdata count_start_flag = ATOMIC_INIT(0);
+static atomic_t __cpuinitdata count_count_start = ATOMIC_INIT(0);
+static atomic_t __cpuinitdata count_count_stop = ATOMIC_INIT(0);
+static atomic_t __cpuinitdata count_reference = ATOMIC_INIT(0);
 
 #define COUNTON	100
 #define NR_LOOPS 5
 
-void __init synchronise_count_master(void)
+void __cpuinit synchronise_count_master(void)
 {
 	int i;
 	unsigned long flags;
@@ -42,19 +43,20 @@ void __init synchronise_count_master(void)
 	return;
 #endif
 
-	pr_info("Checking COUNT synchronization across %u CPUs: ",
-		num_online_cpus());
+	printk(KERN_INFO "Synchronize counters across %u CPUs: ",
+	       num_online_cpus());
 
 	local_irq_save(flags);
 
 	/*
 	 * Notify the slaves that it's time to start
 	 */
+	atomic_set(&count_reference, read_c0_count());
 	atomic_set(&count_start_flag, 1);
 	smp_wmb();
 
-	/* Count will be initialised to expirelo for all CPU's */
-	initcount = expirelo;
+	/* Count will be initialised to current timer for all CPU's */
+	initcount = read_c0_count();
 
 	/*
 	 * We loop a few times to get a primed instruction cache,
@@ -106,7 +108,7 @@ void __init synchronise_count_master(void)
 	printk("done.\n");
 }
 
-void __init synchronise_count_slave(void)
+void __cpuinit synchronise_count_slave(void)
 {
 	int i;
 	unsigned long flags;
@@ -131,8 +133,8 @@ void __init synchronise_count_slave(void)
 	while (!atomic_read(&count_start_flag))
 		mb();
 
-	/* Count will be initialised to expirelo for all CPU's */
-	initcount = expirelo;
+	/* Count will be initialised to next expire for all CPU's */
+	initcount = atomic_read(&count_reference);
 
 	ncpus = num_online_cpus();
 	for (i = 0; i < NR_LOOPS; i++) {
-- 
1.6.2.5.175.g7c84
