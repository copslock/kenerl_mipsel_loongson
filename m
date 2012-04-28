Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:15:00 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1438 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903708Ab2D1NNE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:13:04 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 28 Apr 2012 06:12:50 -0700
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 28 Apr 2012 06:11:59 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 949DC9F9F5; Sat, 28
 Apr 2012 06:12:38 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Sat, 28 Apr 2012 06:12:37 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 04/12] MIPS: Netlogic: Fix TLB size of boot CPU.
Date:   Sat, 28 Apr 2012 18:42:10 +0530
Message-ID: <1335618738-4679-5-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 638533583JG2109429-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33052
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
 1 file changed, 7 insertions(+), 1 deletion(-)

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
1.7.9.5
