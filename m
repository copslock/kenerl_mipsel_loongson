Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2012 15:41:37 +0100 (CET)
Received: from smtpgw1.netlogicmicro.com ([12.203.210.53]:46754 "EHLO
        smtpgw1.netlogicmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904111Ab2BBOjW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2012 15:39:22 +0100
Received: from pps.filterd (smtpgw1 [127.0.0.1])
        by smtpgw1.netlogicmicro.com (8.14.5/8.14.5) with SMTP id q12EM67V012889;
        Thu, 2 Feb 2012 06:39:16 -0800
Received: from hqcas02.netlogicmicro.com (hqcas02.netlogicmicro.com [10.65.50.15])
        by smtpgw1.netlogicmicro.com with ESMTP id 12hfu7nyfp-1
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 02 Feb 2012 06:39:16 -0800
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Jayachandran C <jayachandranc@netlogicmicro.com>
Subject: [PATCH 06/11] MIPS: Netlogic: Fix TLB size of boot CPU.
Date:   Thu, 2 Feb 2012 20:13:00 +0530
Message-ID: <8f6783d1c4c5cd731448bac40a547a1f2b5f8e45.1328189941.git.jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1328189941.git.jayachandranc@netlogicmicro.com>
References: <cover.1328189941.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.7.0.77]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.211,0.0.0000
 definitions=2012-01-28_02:2012-01-27,2012-01-28,1970-01-01 signatures=0
X-archive-position: 32389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Starting other threads in the core will change the number of
TLB entries of a CPU.  Re-calculate current_cpu_data.tlbsize
on the boot cpu after enabling and waking up other threads.

The secondary CPUs do not need this logic because the threads
are enabled on the secondary cores at wakeup and before cpu_probe.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/xlp/setup.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index acb677a..b3df7c2 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -82,8 +82,10 @@ void __init prom_free_prom_memory(void)
 
 void xlp_mmu_init(void)
 {
+	/* enable extended TLB and Large Fixed TLB */
 	write_c0_config6(read_c0_config6() | 0x24);
-	current_cpu_data.tlbsize = ((read_c0_config6() >> 16) & 0xffff) + 1;
+
+	/* set page mask of Fixed TLB in config7 */
 	write_c0_config7(PM_DEFAULT_MASK >>
 		(13 + (ffz(PM_DEFAULT_MASK >> 13) / 2)));
 }
@@ -100,6 +102,10 @@ void __init prom_init(void)
 	nlm_common_ebase = read_c0_ebase() & (~((1 << 12) - 1));
 #ifdef CONFIG_SMP
 	nlm_wakeup_secondary_cpus(0xffffffff);
+
+	/* update TLB size after waking up threads */
+	current_cpu_data.tlbsize = ((read_c0_config6() >> 16) & 0xffff) + 1;
+
 	register_smp_ops(&nlm_smp_ops);
 #endif
 }
-- 
1.7.5.4
