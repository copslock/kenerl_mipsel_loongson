Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 23:11:29 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18527 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025712AbZEHWLX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2009 23:11:23 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a04adf00002>; Fri, 08 May 2009 18:10:57 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 May 2009 15:10:54 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 May 2009 15:10:54 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n48MApgk029256;
	Fri, 8 May 2009 15:10:51 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n48MAoLD029254;
	Fri, 8 May 2009 15:10:50 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Remove unused parameters from iPTE_LW.
Date:	Fri,  8 May 2009 15:10:50 -0700
Message-Id: <1241820650-29230-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 08 May 2009 22:10:54.0244 (UTC) FILETIME=[DAF42640:01C9D029]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The l parameter to iPTE_LW() is unused. Remove it and from some of its
callers as well.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 0615b62..3548acf 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -782,7 +782,7 @@ u32 handle_tlbs[FASTPATH_SIZE] __cacheline_aligned;
 u32 handle_tlbm[FASTPATH_SIZE] __cacheline_aligned;
 
 static void __cpuinit
-iPTE_LW(u32 **p, struct uasm_label **l, unsigned int pte, unsigned int ptr)
+iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
 {
 #ifdef CONFIG_SMP
 # ifdef CONFIG_64BIT_PHYS_ADDR
@@ -862,13 +862,13 @@ iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
  * with it's original value.
  */
 static void __cpuinit
-build_pte_present(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
+build_pte_present(u32 **p, struct uasm_reloc **r,
 		  unsigned int pte, unsigned int ptr, enum label_id lid)
 {
 	uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
 	uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
 	uasm_il_bnez(p, r, pte, lid);
-	iPTE_LW(p, l, pte, ptr);
+	iPTE_LW(p, pte, ptr);
 }
 
 /* Make PTE valid, store result in PTR. */
@@ -886,13 +886,13 @@ build_make_valid(u32 **p, struct uasm_reloc **r, unsigned int pte,
  * restore PTE with value from PTR when done.
  */
 static void __cpuinit
-build_pte_writable(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
+build_pte_writable(u32 **p, struct uasm_reloc **r,
 		   unsigned int pte, unsigned int ptr, enum label_id lid)
 {
 	uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
 	uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
 	uasm_il_bnez(p, r, pte, lid);
-	iPTE_LW(p, l, pte, ptr);
+	iPTE_LW(p, pte, ptr);
 }
 
 /* Make PTE writable, update software status bits as well, then store
@@ -913,12 +913,12 @@ build_make_write(u32 **p, struct uasm_reloc **r, unsigned int pte,
  * restore PTE with value from PTR when done.
  */
 static void __cpuinit
-build_pte_modifiable(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
+build_pte_modifiable(u32 **p, struct uasm_reloc **r,
 		     unsigned int pte, unsigned int ptr, enum label_id lid)
 {
 	uasm_i_andi(p, pte, pte, _PAGE_WRITE);
 	uasm_il_beqz(p, r, pte, lid);
-	iPTE_LW(p, l, pte, ptr);
+	iPTE_LW(p, pte, ptr);
 }
 
 /*
@@ -994,7 +994,7 @@ static void __cpuinit build_r3000_tlb_load_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
-	build_pte_present(&p, &l, &r, K0, K1, label_nopage_tlbl);
+	build_pte_present(&p, &r, K0, K1, label_nopage_tlbl);
 	uasm_i_nop(&p); /* load delay */
 	build_make_valid(&p, &r, K0, K1);
 	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
@@ -1024,7 +1024,7 @@ static void __cpuinit build_r3000_tlb_store_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
-	build_pte_writable(&p, &l, &r, K0, K1, label_nopage_tlbs);
+	build_pte_writable(&p, &r, K0, K1, label_nopage_tlbs);
 	uasm_i_nop(&p); /* load delay */
 	build_make_write(&p, &r, K0, K1);
 	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
@@ -1054,7 +1054,7 @@ static void __cpuinit build_r3000_tlb_modify_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
-	build_pte_modifiable(&p, &l, &r, K0, K1, label_nopage_tlbm);
+	build_pte_modifiable(&p, &r, K0, K1, label_nopage_tlbm);
 	uasm_i_nop(&p); /* load delay */
 	build_make_write(&p, &r, K0, K1);
 	build_r3000_pte_reload_tlbwi(&p, K0, K1);
@@ -1096,7 +1096,7 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 #ifdef CONFIG_SMP
 	uasm_l_smp_pgtable_change(l, *p);
 #endif
-	iPTE_LW(p, l, pte, ptr); /* get even pte */
+	iPTE_LW(p, pte, ptr); /* get even pte */
 	if (!m4kc_tlbp_war())
 		build_tlb_probe_entry(p);
 }
@@ -1138,7 +1138,7 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	}
 
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
-	build_pte_present(&p, &l, &r, K0, K1, label_nopage_tlbl);
+	build_pte_present(&p, &r, K0, K1, label_nopage_tlbl);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 	build_make_valid(&p, &r, K0, K1);
@@ -1169,7 +1169,7 @@ static void __cpuinit build_r4000_tlb_store_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
-	build_pte_writable(&p, &l, &r, K0, K1, label_nopage_tlbs);
+	build_pte_writable(&p, &r, K0, K1, label_nopage_tlbs);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 	build_make_write(&p, &r, K0, K1);
@@ -1200,7 +1200,7 @@ static void __cpuinit build_r4000_tlb_modify_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
-	build_pte_modifiable(&p, &l, &r, K0, K1, label_nopage_tlbm);
+	build_pte_modifiable(&p, &r, K0, K1, label_nopage_tlbm);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 	/* Present and writable bits set, set accessed and dirty bits. */
-- 
1.6.0.6
