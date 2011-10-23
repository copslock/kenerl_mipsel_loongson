Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Oct 2011 15:48:33 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3555 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491055Ab1JWNoO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Oct 2011 15:44:14 +0200
X-TM-IMSS-Message-ID: <b9687d9b0004e567@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id b9687d9b0004e567 ; Sun, 23 Oct 2011 06:44:07 -0700
Date:   Sun, 23 Oct 2011 19:13:40 +0530
From:   Hillf Danton <dhillf@gmail.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 12/12] MIPS: Netlogic: Mark Netlogic chips as SMT capable
Message-ID: <20111023134334.GA29864@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Oct 2011 13:41:38.0581 (UTC) FILETIME=[7D4F7C50:01CC9189]
X-archive-position: 31280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16587

Netlogic XLR chip has multiple cores. Each core includes four integrated
hardware threads, and they share L1 data and instruction caches.

If the chip is marked to be SMT capable, scheduler then could do more, say,
idle load balancing.

Changes are now confined only to the code of XLR, and hardware is probed
to get core ID for correct setup.

[jayachandranc: simplified and adapted for new merged XLR/XLP code]

Signed-off-by: Hillf Danton <dhillf@gmail.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/common/smp.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 4657fe8..7249f93 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -108,9 +108,16 @@ void nlm_early_init_secondary(int cpu)
  */
 static void __cpuinit nlm_init_secondary(void)
 {
+	current_cpu_data.core = hard_smp_processor_id() / 4;
 	nlm_smp_irq_init();
 }
 
+void nlm_prepare_cpus(unsigned int max_cpus)
+{
+	/* declare we are SMT capable */
+	smp_num_siblings = nlm_threads_per_core;
+}
+
 void nlm_smp_finish(void)
 {
 #ifdef notyet
@@ -179,10 +186,6 @@ void __init nlm_smp_setup(void)
 	nlm_set_nmi_handler(nlm_boot_secondary_cpus);
 }
 
-void nlm_prepare_cpus(unsigned int max_cpus)
-{
-}
-
 static int nlm_parse_cpumask(u32 cpu_mask)
 {
 	uint32_t core0_thr_mask, core_thr_mask;
-- 
1.7.4.1
