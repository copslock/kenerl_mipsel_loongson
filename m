Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:27:47 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1494 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834952Ab3CWS0dp-WsX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 19:26:33 +0100
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 23 Mar 2013 11:21:55 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 23 Mar 2013 11:26:14 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 23 Mar 2013 11:26:14 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id C85303928D; Sat, 23
 Mar 2013 11:26:13 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 3/9] MIPS: Netlogic: print cpumask with
 cpumask_scnprintf
Date:   Sat, 23 Mar 2013 23:57:55 +0530
Message-ID: <15a96d9a37b2e9763d1095b262b269c650bed27d.1364062916.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1364062916.git.jchandra@broadcom.com>
References: <cover.1364062916.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D532D483A01621405-03-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35955
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

Use standard function to print cpumask. Also fixup the name of the
variable used and make it static.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/smp.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 2bb95dc..ffba524 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -148,8 +148,7 @@ void nlm_cpus_done(void)
 int nlm_cpu_ready[NR_CPUS];
 unsigned long nlm_next_gp;
 unsigned long nlm_next_sp;
-
-cpumask_t phys_cpu_present_map;
+static cpumask_t phys_cpu_present_mask;
 
 void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
 {
@@ -169,11 +168,12 @@ void __init nlm_smp_setup(void)
 {
 	unsigned int boot_cpu;
 	int num_cpus, i, ncore;
+	char buf[64];
 
 	boot_cpu = hard_smp_processor_id();
-	cpumask_clear(&phys_cpu_present_map);
+	cpumask_clear(&phys_cpu_present_mask);
 
-	cpumask_set_cpu(boot_cpu, &phys_cpu_present_map);
+	cpumask_set_cpu(boot_cpu, &phys_cpu_present_mask);
 	__cpu_number_map[boot_cpu] = 0;
 	__cpu_logical_map[0] = boot_cpu;
 	set_cpu_possible(0, true);
@@ -185,7 +185,7 @@ void __init nlm_smp_setup(void)
 		 * it is only set for ASPs (see smpboot.S)
 		 */
 		if (nlm_cpu_ready[i]) {
-			cpumask_set_cpu(i, &phys_cpu_present_map);
+			cpumask_set_cpu(i, &phys_cpu_present_mask);
 			__cpu_number_map[i] = num_cpus;
 			__cpu_logical_map[num_cpus] = i;
 			set_cpu_possible(num_cpus, true);
@@ -193,16 +193,19 @@ void __init nlm_smp_setup(void)
 		}
 	}
 
+	cpumask_scnprintf(buf, ARRAY_SIZE(buf), &phys_cpu_present_mask);
+	pr_info("Physical CPU mask: %s\n", buf);
+	cpumask_scnprintf(buf, ARRAY_SIZE(buf), cpu_possible_mask);
+	pr_info("Possible CPU mask: %s\n", buf);
+
 	/* check with the cores we have worken up */
 	for (ncore = 0, i = 0; i < NLM_NR_NODES; i++)
 		ncore += hweight32(nlm_get_node(i)->coremask);
 
-	pr_info("Phys CPU present map: %lx, possible map %lx\n",
-		(unsigned long)cpumask_bits(&phys_cpu_present_map)[0],
-		(unsigned long)cpumask_bits(cpu_possible_mask)[0]);
-
 	pr_info("Detected (%dc%dt) %d Slave CPU(s)\n", ncore,
 		nlm_threads_per_core, num_cpus);
+
+	/* switch NMI handler to boot CPUs */
 	nlm_set_nmi_handler(nlm_boot_secondary_cpus);
 }
 
-- 
1.7.9.5
