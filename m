Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 15:26:10 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2059 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903798Ab2HNNZQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 15:25:16 +0200
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 14 Aug 2012 06:24:08 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 14 Aug 2012 06:24:59 -0700
Received: from jc-linux.netlogicmicro.com (unknown [10.7.2.153]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 7C6AF9F9F5; Tue, 14
 Aug 2012 06:24:57 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 2/2] MIPS: Synchronize MIPS count one CPU at a time
Date:   Tue, 14 Aug 2012 18:56:13 +0530
Message-ID: <1344950773-29299-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344950773-29299-1-git-send-email-jchandra@broadcom.com>
References: <1344950773-29299-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C348EF23MK19975527-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The current implementation of synchronise_count_{master,slave} blocks
slave CPUs in early boot until all of them come up. This no longer
works because blocking a CPU with interrupts off after notifying the
CPU to be online causes problems with the current kernel.

Specifically, after the workqueue changes
(commit a08489c569dc1 "Pull workqueue changes from Tejun Heo")
the CPU_ONLINE notification callback workqueue_cpu_up_callback()
will hang on wait_for_completion(&idle_rebind.done), if the slave
CPUs are blocked for synchronize_count_slave().

The changes are to update synchronize_count_{master,slave}() to handle
one CPU at a time and to call synchronise_count_master() in __cpu_up()
so that the CPU_ONLINE notification goes out only after the COP0 COUNT
register is synchronized.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/r4k-timer.h |    8 ++++----
 arch/mips/kernel/smp.c            |    4 ++--
 arch/mips/kernel/sync-r4k.c       |   26 +++++++++++---------------
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/mips/include/asm/r4k-timer.h b/arch/mips/include/asm/r4k-timer.h
index a37d12b..afe9e0e 100644
--- a/arch/mips/include/asm/r4k-timer.h
+++ b/arch/mips/include/asm/r4k-timer.h
@@ -12,16 +12,16 @@
 
 #ifdef CONFIG_SYNC_R4K
 
-extern void synchronise_count_master(void);
-extern void synchronise_count_slave(void);
+extern void synchronise_count_master(int cpu);
+extern void synchronise_count_slave(int cpu);
 
 #else
 
-static inline void synchronise_count_master(void)
+static inline void synchronise_count_master(int cpu)
 {
 }
 
-static inline void synchronise_count_slave(void)
+static inline void synchronise_count_slave(int cpu)
 {
 }
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 31637d8..9005bf9 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -130,7 +130,7 @@ asmlinkage __cpuinit void start_secondary(void)
 
 	cpu_set(cpu, cpu_callin_map);
 
-	synchronise_count_slave();
+	synchronise_count_slave(cpu);
 
 	/*
 	 * irq will be enabled in ->smp_finish(), enabling it too early
@@ -173,7 +173,6 @@ void smp_send_stop(void)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	mp_ops->cpus_done();
-	synchronise_count_master();
 }
 
 /* called from main before smp_init() */
@@ -206,6 +205,7 @@ int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	while (!cpu_isset(cpu, cpu_callin_map))
 		udelay(100);
 
+	synchronise_count_master(cpu);
 	return 0;
 }
 
diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
index 842d55e..7f1eca3 100644
--- a/arch/mips/kernel/sync-r4k.c
+++ b/arch/mips/kernel/sync-r4k.c
@@ -28,12 +28,11 @@ static atomic_t __cpuinitdata count_reference = ATOMIC_INIT(0);
 #define COUNTON	100
 #define NR_LOOPS 5
 
-void __cpuinit synchronise_count_master(void)
+void __cpuinit synchronise_count_master(int cpu)
 {
 	int i;
 	unsigned long flags;
 	unsigned int initcount;
-	int nslaves;
 
 #ifdef CONFIG_MIPS_MT_SMTC
 	/*
@@ -43,8 +42,7 @@ void __cpuinit synchronise_count_master(void)
 	return;
 #endif
 
-	printk(KERN_INFO "Synchronize counters across %u CPUs: ",
-	       num_online_cpus());
+	printk(KERN_INFO "Synchronize counters for CPU %u: ", cpu);
 
 	local_irq_save(flags);
 
@@ -52,7 +50,7 @@ void __cpuinit synchronise_count_master(void)
 	 * Notify the slaves that it's time to start
 	 */
 	atomic_set(&count_reference, read_c0_count());
-	atomic_set(&count_start_flag, 1);
+	atomic_set(&count_start_flag, cpu);
 	smp_wmb();
 
 	/* Count will be initialised to current timer for all CPU's */
@@ -69,10 +67,9 @@ void __cpuinit synchronise_count_master(void)
 	 * two CPUs.
 	 */
 
-	nslaves = num_online_cpus()-1;
 	for (i = 0; i < NR_LOOPS; i++) {
-		/* slaves loop on '!= ncpus' */
-		while (atomic_read(&count_count_start) != nslaves)
+		/* slaves loop on '!= 2' */
+		while (atomic_read(&count_count_start) != 1)
 			mb();
 		atomic_set(&count_count_stop, 0);
 		smp_wmb();
@@ -89,7 +86,7 @@ void __cpuinit synchronise_count_master(void)
 		/*
 		 * Wait for all slaves to leave the synchronization point:
 		 */
-		while (atomic_read(&count_count_stop) != nslaves)
+		while (atomic_read(&count_count_stop) != 1)
 			mb();
 		atomic_set(&count_count_start, 0);
 		smp_wmb();
@@ -97,6 +94,7 @@ void __cpuinit synchronise_count_master(void)
 	}
 	/* Arrange for an interrupt in a short while */
 	write_c0_compare(read_c0_count() + COUNTON);
+	atomic_set(&count_start_flag, 0);
 
 	local_irq_restore(flags);
 
@@ -108,11 +106,10 @@ void __cpuinit synchronise_count_master(void)
 	printk("done.\n");
 }
 
-void __cpuinit synchronise_count_slave(void)
+void __cpuinit synchronise_count_slave(int cpu)
 {
 	int i;
 	unsigned int initcount;
-	int ncpus;
 
 #ifdef CONFIG_MIPS_MT_SMTC
 	/*
@@ -127,16 +124,15 @@ void __cpuinit synchronise_count_slave(void)
 	 * so we first wait for the master to say everyone is ready
 	 */
 
-	while (!atomic_read(&count_start_flag))
+	while (atomic_read(&count_start_flag) != cpu)
 		mb();
 
 	/* Count will be initialised to next expire for all CPU's */
 	initcount = atomic_read(&count_reference);
 
-	ncpus = num_online_cpus();
 	for (i = 0; i < NR_LOOPS; i++) {
 		atomic_inc(&count_count_start);
-		while (atomic_read(&count_count_start) != ncpus)
+		while (atomic_read(&count_count_start) != 2)
 			mb();
 
 		/*
@@ -146,7 +142,7 @@ void __cpuinit synchronise_count_slave(void)
 			write_c0_count(initcount);
 
 		atomic_inc(&count_count_stop);
-		while (atomic_read(&count_count_stop) != ncpus)
+		while (atomic_read(&count_count_stop) != 2)
 			mb();
 	}
 	/* Arrange for an interrupt in a short while */
-- 
1.7.9.5
