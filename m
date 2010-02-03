Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 02:19:51 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:12771 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492569Ab0BCBTr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2010 02:19:47 +0100
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b68cde40001>; Tue, 02 Feb 2010 20:14:12 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 2 Feb 2010 20:19:46 -0500
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 2 Feb 2010 17:19:44 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o131Jeu4012459;
        Tue, 2 Feb 2010 17:19:40 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o131JckU012458;
        Tue, 2 Feb 2010 17:19:38 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Remove #if 0 r4k_update_mmu_cache_hwbug
Date:   Tue,  2 Feb 2010 17:19:38 -0800
Message-Id: <1265159978-12434-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 03 Feb 2010 01:19:44.0613 (UTC) FILETIME=[F7E9C150:01CAA46E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The function is #if 0ed out.  There are no other occurrences of its
name in the tree.  It is safe to remove.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlb-r4k.c |   34 ----------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 7de128a..e551559 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -337,40 +337,6 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	EXIT_CRITICAL(flags);
 }
 
-#if 0
-static void r4k_update_mmu_cache_hwbug(struct vm_area_struct * vma,
-				       unsigned long address, pte_t pte)
-{
-	unsigned long flags;
-	unsigned int asid;
-	pgd_t *pgdp;
-	pmd_t *pmdp;
-	pte_t *ptep;
-	int idx;
-
-	ENTER_CRITICAL(flags);
-	address &= (PAGE_MASK << 1);
-	asid = read_c0_entryhi() & ASID_MASK;
-	write_c0_entryhi(address | asid);
-	pgdp = pgd_offset(vma->vm_mm, address);
-	mtc0_tlbw_hazard();
-	tlb_probe();
-	tlb_probe_hazard();
-	pmdp = pmd_offset(pgdp, address);
-	idx = read_c0_index();
-	ptep = pte_offset_map(pmdp, address);
-	write_c0_entrylo0(pte_val(*ptep++) >> 6);
-	write_c0_entrylo1(pte_val(*ptep) >> 6);
-	mtc0_tlbw_hazard();
-	if (idx < 0)
-		tlb_write_random();
-	else
-		tlb_write_indexed();
-	tlbw_use_hazard();
-	EXIT_CRITICAL(flags);
-}
-#endif
-
 void __init add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 	unsigned long entryhi, unsigned long pagemask)
 {
-- 
1.6.0.6
