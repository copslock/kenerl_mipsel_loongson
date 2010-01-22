Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 23:41:40 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16836 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492018Ab0AVWle (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2010 23:41:34 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b5a29a20004>; Fri, 22 Jan 2010 14:41:38 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 22 Jan 2010 14:41:22 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 22 Jan 2010 14:41:22 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o0MMfHDQ005019;
        Fri, 22 Jan 2010 14:41:18 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o0MMfF8x005016;
        Fri, 22 Jan 2010 14:41:15 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Remove probe_tlb().
Date:   Fri, 22 Jan 2010 14:41:14 -0800
Message-Id: <1264200075-4992-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 22 Jan 2010 22:41:22.0518 (UTC) FILETIME=[05ADDF60:01CA9BB4]
X-archive-position: 25639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15066

The function probe_tlb() only does anything for processors that are
not PRID_COMP_LEGACY.  This is precisely the set of processors for
which decode_configs() is called to do identical tlbsize probing
calculations.  Therefore probe_tlb() is completely redundant and may
be removed.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlb-r4k.c |   31 -------------------------------
 1 files changed, 0 insertions(+), 31 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index b61ad60..7de128a 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -447,34 +447,6 @@ out:
 	return ret;
 }
 
-static void __cpuinit probe_tlb(unsigned long config)
-{
-	struct cpuinfo_mips *c = &current_cpu_data;
-	unsigned int reg;
-
-	/*
-	 * If this isn't a MIPS32 / MIPS64 compliant CPU.  Config 1 register
-	 * is not supported, we assume R4k style.  Cpu probing already figured
-	 * out the number of tlb entries.
-	 */
-	if ((c->processor_id & 0xff0000) == PRID_COMP_LEGACY)
-		return;
-#ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * If TLB is shared in SMTC system, total size already
-	 * has been calculated and written into cpu_data tlbsize
-	 */
-	if((smtc_status & SMTC_TLB_SHARED) == SMTC_TLB_SHARED)
-		return;
-#endif /* CONFIG_MIPS_MT_SMTC */
-
-	reg = read_c0_config1();
-	if (!((config >> 7) & 3))
-		panic("No TLB present");
-
-	c->tlbsize = ((reg >> 25) & 0x3f) + 1;
-}
-
 static int __cpuinitdata ntlb;
 static int __init set_ntlb(char *str)
 {
@@ -486,8 +458,6 @@ __setup("ntlb=", set_ntlb);
 
 void __cpuinit tlb_init(void)
 {
-	unsigned int config = read_c0_config();
-
 	/*
 	 * You should never change this register:
 	 *   - On R4600 1.7 the tlbp never hits for pages smaller than
@@ -495,7 +465,6 @@ void __cpuinit tlb_init(void)
 	 *   - The entire mm handling assumes the c0_pagemask register to
 	 *     be set to fixed-size pages.
 	 */
-	probe_tlb(config);
 	write_c0_pagemask(PM_DEFAULT_MASK);
 #ifndef CONFIG_MAPPED_KERNEL
 	write_c0_wired(0);
-- 
1.6.0.6
