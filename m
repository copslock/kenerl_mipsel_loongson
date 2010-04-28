Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 21:18:42 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9086 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492614Ab0D1TRT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 21:17:19 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bd889c90004>; Wed, 28 Apr 2010 12:17:29 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 12:16:27 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 12:16:27 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o3SJGNs4004763;
        Wed, 28 Apr 2010 12:16:23 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o3SJGNJB004762;
        Wed, 28 Apr 2010 12:16:23 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/3] MIPS: Use uasm_i_ds{r,l}l_safe() instead of uasm_i_ds{r,l}l() in tlbex.c
Date:   Wed, 28 Apr 2010 12:16:17 -0700
Message-Id: <1272482178-4712-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1272482178-4712-1-git-send-email-ddaney@caviumnetworks.com>
References: <1272482178-4712-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Apr 2010 19:16:27.0635 (UTC) FILETIME=[4D039C30:01CAE707]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This makes the code somewhat cleaner while reducing the risk of shift
amount overflows when various page table related options are changed.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index d1f68aa..61374b2 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -408,7 +408,7 @@ static __cpuinit __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 		UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
 	} else {
 #ifdef CONFIG_64BIT_PHYS_ADDR
-		uasm_i_dsrl(p, reg, reg, ilog2(_PAGE_GLOBAL));
+		uasm_i_dsrl_safe(p, reg, reg, ilog2(_PAGE_GLOBAL));
 #else
 		UASM_i_SRL(p, reg, reg, ilog2(_PAGE_GLOBAL));
 #endif
@@ -549,14 +549,14 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 	 * SMTC uses TCBind value as "CPU" index
 	 */
 	uasm_i_mfc0(p, ptr, C0_TCBIND);
-	uasm_i_dsrl(p, ptr, ptr, 19);
+	uasm_i_dsrl_safe(p, ptr, ptr, 19);
 # else
 	/*
 	 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
 	 * stored in CONTEXT.
 	 */
 	uasm_i_dmfc0(p, ptr, C0_CONTEXT);
-	uasm_i_dsrl(p, ptr, ptr, 23);
+	uasm_i_dsrl_safe(p, ptr, ptr, 23);
 # endif
 	UASM_i_LA_mostly(p, tmp, pgdc);
 	uasm_i_daddu(p, ptr, ptr, tmp);
@@ -569,17 +569,15 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 
 	uasm_l_vmalloc_done(l, *p);
 
-	if (PGDIR_SHIFT - 3 < 32)		/* get pgd offset in bytes */
-		uasm_i_dsrl(p, tmp, tmp, PGDIR_SHIFT-3);
-	else
-		uasm_i_dsrl32(p, tmp, tmp, PGDIR_SHIFT - 3 - 32);
+	/* get pgd offset in bytes */
+	uasm_i_dsrl_safe(p, tmp, tmp, PGDIR_SHIFT - 3);
 
 	uasm_i_andi(p, tmp, tmp, (PTRS_PER_PGD - 1)<<3);
 	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pgd offset */
 #ifndef __PAGETABLE_PMD_FOLDED
 	uasm_i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
 	uasm_i_ld(p, ptr, 0, ptr); /* get pmd pointer */
-	uasm_i_dsrl(p, tmp, tmp, PMD_SHIFT-3); /* get pmd offset in bytes */
+	uasm_i_dsrl_safe(p, tmp, tmp, PMD_SHIFT-3); /* get pmd offset in bytes */
 	uasm_i_andi(p, tmp, tmp, (PTRS_PER_PMD - 1)<<3);
 	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pmd offset */
 #endif
@@ -720,9 +718,9 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 			UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
 			UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
 		} else {
-			uasm_i_dsrl(p, tmp, tmp, ilog2(_PAGE_GLOBAL)); /* convert to entrylo0 */
+			uasm_i_dsrl_safe(p, tmp, tmp, ilog2(_PAGE_GLOBAL)); /* convert to entrylo0 */
 			UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-			uasm_i_dsrl(p, ptep, ptep, ilog2(_PAGE_GLOBAL)); /* convert to entrylo1 */
+			uasm_i_dsrl_safe(p, ptep, ptep, ilog2(_PAGE_GLOBAL)); /* convert to entrylo1 */
 		}
 		UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
 	} else {
@@ -793,9 +791,9 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 		uasm_i_dmfc0(&p, K0, C0_BADVADDR);
 		uasm_i_dmfc0(&p, K1, C0_ENTRYHI);
 		uasm_i_xor(&p, K0, K0, K1);
-		uasm_i_dsrl32(&p, K1, K0, 62 - 32);
-		uasm_i_dsrl(&p, K0, K0, 12 + 1);
-		uasm_i_dsll32(&p, K0, K0, 64 + 12 + 1 - segbits - 32);
+		uasm_i_dsrl_safe(&p, K1, K0, 62);
+		uasm_i_dsrl_safe(&p, K0, K0, 12 + 1);
+		uasm_i_dsll_safe(&p, K0, K0, 64 + 12 + 1 - segbits);
 		uasm_i_or(&p, K0, K0, K1);
 		uasm_il_bnez(&p, &r, K0, label_leave);
 		/* No need for uasm_i_nop */
@@ -1322,9 +1320,9 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		uasm_i_dmfc0(&p, K0, C0_BADVADDR);
 		uasm_i_dmfc0(&p, K1, C0_ENTRYHI);
 		uasm_i_xor(&p, K0, K0, K1);
-		uasm_i_dsrl32(&p, K1, K0, 62 - 32);
-		uasm_i_dsrl(&p, K0, K0, 12 + 1);
-		uasm_i_dsll32(&p, K0, K0, 64 + 12 + 1 - segbits - 32);
+		uasm_i_dsrl_safe(&p, K1, K0, 62);
+		uasm_i_dsrl_safe(&p, K0, K0, 12 + 1);
+		uasm_i_dsll_safe(&p, K0, K0, 64 + 12 + 1 - segbits);
 		uasm_i_or(&p, K0, K0, K1);
 		uasm_il_bnez(&p, &r, K0, label_leave);
 		/* No need for uasm_i_nop */
-- 
1.6.6.1
