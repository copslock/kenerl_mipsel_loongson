Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 15:19:21 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1290 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825716Ab3JNNPtPcAgn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 15:15:49 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Oct 2013 06:15:18 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 14 Oct 2013 06:15:19 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 14 Oct 2013 06:15:19 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 9D6CF246A5; Mon, 14
 Oct 2013 06:15:18 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, ralf@linux-mips.org
Subject: [PATCH 07/18] MIPS: Netlogic: Core wakeup improvements
Date:   Mon, 14 Oct 2013 18:51:03 +0530
Message-ID: <1381756874-22616-8-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
References: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E4531EC4FK1415192-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38331
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
 arch/mips/netlogic/xlp/setup.c  |   14 ++++++++------
 arch/mips/netlogic/xlp/wakeup.c |    8 +++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 76a7131..bf3fdef 100644
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
 	panic_timeout	= 5;
 	_machine_restart = (void (*)(char *))nlm_linux_exit;
 	_machine_halt	= nlm_linux_exit;
@@ -163,11 +171,5 @@ void __init prom_init(void)
 
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
index 1011577..055dc17 100644
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
@@ -162,7 +162,8 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 			nodep->coremask |= 1u << core;
 
 			/* spin until the hw threads sets their ready */
-			wait_for_cpus(cpu, 0);
+			if (!wait_for_cpus(cpu, 0))
+				pr_err("Node %d : timeout core %d\n", n, core);
 		}
 	}
 }
@@ -174,7 +175,8 @@ void xlp_wakeup_secondary_cpus()
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
