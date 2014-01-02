Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 15:51:08 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:17084 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821116AbaABOvEqQG21 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 15:51:04 +0100
X-IronPort-AV: E=Sophos;i="4.95,591,1384329600"; 
   d="scan'208";a="7038274"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 02 Jan 2014 06:54:36 -0800
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Thu, 2 Jan 2014 06:50:55 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.1.438.0; Thu, 2 Jan 2014 06:50:55 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 AE1F7246A3;    Thu,  2 Jan 2014 06:50:54 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>, John Crispin <john@phrozen.org>
CC:     Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 07/18 UPDATED] MIPS: Netlogic: Core wakeup improvements
Date:   Thu, 2 Jan 2014 20:33:39 +0530
Message-ID: <1388675019-8718-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38836
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

Move wakeup to after early console. This will allow us to display error
messages when cores are not woken up.  Also reduce the wait time for core
to come up.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
Updated to take care of conflict with http://patchwork.linux-mips.org/patch/6141/

 arch/mips/netlogic/xlp/setup.c  |   14 ++++++++------
 arch/mips/netlogic/xlp/wakeup.c |    8 +++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 54e75c7..eefdfff 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -92,6 +92,14 @@ static void __init xlp_init_mem_from_bars(void)
 
 void __init plat_mem_setup(void)
 {
+#ifdef CONFIG_SMP
+	nlm_wakeup_secondary_cpus();
+
+	/* update TLB size after waking up threads */
+	current_cpu_data.tlbsize = ((read_c0_config6() >> 16) & 0xffff) + 1;
+
+	register_smp_ops(&nlm_smp_ops);
+#endif
 	_machine_restart = (void (*)(char *))nlm_linux_exit;
 	_machine_halt	= nlm_linux_exit;
 	pm_power_off	= nlm_linux_exit;
@@ -162,11 +170,5 @@ void __init prom_init(void)
 
 #ifdef CONFIG_SMP
 	cpumask_setall(&nlm_cpumask);
-	nlm_wakeup_secondary_cpus();
-
-	/* update TLB size after waking up threads */
-	current_cpu_data.tlbsize = ((read_c0_config6() >> 16) & 0xffff) + 1;
-
-	register_smp_ops(&nlm_smp_ops);
 #endif
 }
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index e6f77c0..5bd7d18 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -84,7 +84,7 @@ static int wait_for_cpus(int cpu, int bootcpu)
 	volatile uint32_t *cpu_ready = nlm_get_boot_data(BOOT_CPU_READY);
 	int i, count, notready;
 
-	count = 0x20000000;
+	count = 0x800000;
 	do {
 		notready = nlm_threads_per_core;
 		for (i = 0; i < nlm_threads_per_core; i++)
@@ -160,7 +160,8 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 			nodep->coremask |= 1u << core;
 
 			/* spin until the hw threads sets their ready */
-			wait_for_cpus(cpu, 0);
+			if (!wait_for_cpus(cpu, 0))
+				pr_err("Node %d : timeout core %d\n", n, core);
 		}
 	}
 }
@@ -172,7 +173,8 @@ void xlp_wakeup_secondary_cpus()
 	 * first wakeup core 0 threads
 	 */
 	xlp_boot_core0_siblings();
-	wait_for_cpus(0, 0);
+	if (!wait_for_cpus(0, 0))
+		pr_err("Node 0 : timeout core 0\n");
 
 	/* now get other cores out of reset */
 	xlp_enable_secondary_cores(&nlm_cpumask);
-- 
1.7.9.5
