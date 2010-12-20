Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2010 00:55:55 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4100 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492619Ab0LTXzG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Dec 2010 00:55:06 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d0fed050000>; Mon, 20 Dec 2010 15:55:49 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 20 Dec 2010 15:56:25 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 20 Dec 2010 15:56:25 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBKNsx6l012892;
        Mon, 20 Dec 2010 15:54:59 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBKNswK8012891;
        Mon, 20 Dec 2010 15:54:58 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Use BBIT instructions in TLB handlers
Date:   Mon, 20 Dec 2010 15:54:50 -0800
Message-Id: <1292889290-12849-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1292889290-12849-1-git-send-email-ddaney@caviumnetworks.com>
References: <1292889290-12849-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 20 Dec 2010 23:56:25.0736 (UTC) FILETIME=[82F36880:01CBA0A1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

If the CPU supports BBIT0 and BBIT1, use them in TLB handlers as they
are more efficient than an AND followed by an branch and then
restoring the clobbered register.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |  119 +++++++++++++++++++++++++++++++++++++------------
 1 files changed, 90 insertions(+), 29 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index cec0e1b..601f4c2 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -65,6 +65,18 @@ static inline int __maybe_unused r10000_llsc_war(void)
 	return R10000_LLSC_WAR;
 }
 
+static int use_bbit_insns(void)
+{
+	switch (current_cpu_type()) {
+	case CPU_CAVIUM_OCTEON:
+	case CPU_CAVIUM_OCTEON_PLUS:
+	case CPU_CAVIUM_OCTEON2:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 /*
  * Found by experiment: At least some revisions of the 4kc throw under
  * some circumstances a machine check exception, triggered by invalid
@@ -507,8 +519,12 @@ build_is_huge_pte(u32 **p, struct uasm_reloc **r, unsigned int tmp,
 		unsigned int pmd, int lid)
 {
 	UASM_i_LW(p, tmp, 0, pmd);
-	uasm_i_andi(p, tmp, tmp, _PAGE_HUGE);
-	uasm_il_bnez(p, r, tmp, lid);
+	if (use_bbit_insns()) {
+		uasm_il_bbit1(p, r, tmp, ilog2(_PAGE_HUGE), lid);
+	} else {
+		uasm_i_andi(p, tmp, tmp, _PAGE_HUGE);
+		uasm_il_bnez(p, r, tmp, lid);
+	}
 }
 
 static __cpuinit void build_huge_update_entries(u32 **p,
@@ -1183,14 +1199,20 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
 		  unsigned int pte, unsigned int ptr, enum label_id lid)
 {
 	if (kernel_uses_smartmips_rixi) {
-		uasm_i_andi(p, pte, pte, _PAGE_PRESENT);
-		uasm_il_beqz(p, r, pte, lid);
+		if (use_bbit_insns()) {
+			uasm_il_bbit0(p, r, pte, ilog2(_PAGE_PRESENT), lid);
+			uasm_i_nop(p);
+		} else {
+			uasm_i_andi(p, pte, pte, _PAGE_PRESENT);
+			uasm_il_beqz(p, r, pte, lid);
+			iPTE_LW(p, pte, ptr);
+		}
 	} else {
 		uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
 		uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
 		uasm_il_bnez(p, r, pte, lid);
+		iPTE_LW(p, pte, ptr);
 	}
-	iPTE_LW(p, pte, ptr);
 }
 
 /* Make PTE valid, store result in PTR. */
@@ -1211,10 +1233,17 @@ static void __cpuinit
 build_pte_writable(u32 **p, struct uasm_reloc **r,
 		   unsigned int pte, unsigned int ptr, enum label_id lid)
 {
-	uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
-	uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
-	uasm_il_bnez(p, r, pte, lid);
-	iPTE_LW(p, pte, ptr);
+	if (use_bbit_insns()) {
+		uasm_il_bbit0(p, r, pte, ilog2(_PAGE_PRESENT), lid);
+		uasm_i_nop(p);
+		uasm_il_bbit0(p, r, pte, ilog2(_PAGE_WRITE), lid);
+		uasm_i_nop(p);
+	} else {
+		uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
+		uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
+		uasm_il_bnez(p, r, pte, lid);
+		iPTE_LW(p, pte, ptr);
+	}
 }
 
 /* Make PTE writable, update software status bits as well, then store
@@ -1238,9 +1267,14 @@ static void __cpuinit
 build_pte_modifiable(u32 **p, struct uasm_reloc **r,
 		     unsigned int pte, unsigned int ptr, enum label_id lid)
 {
-	uasm_i_andi(p, pte, pte, _PAGE_WRITE);
-	uasm_il_beqz(p, r, pte, lid);
-	iPTE_LW(p, pte, ptr);
+	if (use_bbit_insns()) {
+		uasm_il_bbit0(p, r, pte, ilog2(_PAGE_WRITE), lid);
+		uasm_i_nop(p);
+	} else {
+		uasm_i_andi(p, pte, pte, _PAGE_WRITE);
+		uasm_il_beqz(p, r, pte, lid);
+		iPTE_LW(p, pte, ptr);
+	}
 }
 
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
@@ -1485,14 +1519,23 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		 * If the page is not _PAGE_VALID, RI or XI could not
 		 * have triggered it.  Skip the expensive test..
 		 */
-		uasm_i_andi(&p, K0, K0, _PAGE_VALID);
-		uasm_il_beqz(&p, &r, K0, label_tlbl_goaround1);
+		if (use_bbit_insns()) {
+			uasm_il_bbit0(&p, &r, K0, ilog2(_PAGE_VALID),
+				      label_tlbl_goaround1);
+		} else {
+			uasm_i_andi(&p, K0, K0, _PAGE_VALID);
+			uasm_il_beqz(&p, &r, K0, label_tlbl_goaround1);
+		}
 		uasm_i_nop(&p);
 
 		uasm_i_tlbr(&p);
 		/* Examine  entrylo 0 or 1 based on ptr. */
-		uasm_i_andi(&p, K0, K1, sizeof(pte_t));
-		uasm_i_beqz(&p, K0, 8);
+		if (use_bbit_insns()) {
+			uasm_i_bbit0(&p, K1, ilog2(sizeof(pte_t)), 8);
+		} else {
+			uasm_i_andi(&p, K0, K1, sizeof(pte_t));
+			uasm_i_beqz(&p, K0, 8);
+		}
 
 		UASM_i_MFC0(&p, K0, C0_ENTRYLO0); /* load it in the delay slot*/
 		UASM_i_MFC0(&p, K0, C0_ENTRYLO1); /* load it if ptr is odd */
@@ -1500,12 +1543,18 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		 * If the entryLo (now in K0) is valid (bit 1), RI or
 		 * XI must have triggered it.
 		 */
-		uasm_i_andi(&p, K0, K0, 2);
-		uasm_il_bnez(&p, &r, K0, label_nopage_tlbl);
-
-		uasm_l_tlbl_goaround1(&l, p);
-		/* Reload the PTE value */
-		iPTE_LW(&p, K0, K1);
+		if (use_bbit_insns()) {
+			uasm_il_bbit1(&p, &r, K0, 1, label_nopage_tlbl);
+			/* Reload the PTE value */
+			iPTE_LW(&p, K0, K1);
+			uasm_l_tlbl_goaround1(&l, p);
+		} else {
+			uasm_i_andi(&p, K0, K0, 2);
+			uasm_il_bnez(&p, &r, K0, label_nopage_tlbl);
+			uasm_l_tlbl_goaround1(&l, p);
+			/* Reload the PTE value */
+			iPTE_LW(&p, K0, K1);
+		}
 	}
 	build_make_valid(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
@@ -1525,23 +1574,35 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		 * If the page is not _PAGE_VALID, RI or XI could not
 		 * have triggered it.  Skip the expensive test..
 		 */
-		uasm_i_andi(&p, K0, K0, _PAGE_VALID);
-		uasm_il_beqz(&p, &r, K0, label_tlbl_goaround2);
+		if (use_bbit_insns()) {
+			uasm_il_bbit0(&p, &r, K0, ilog2(_PAGE_VALID),
+				      label_tlbl_goaround2);
+		} else {
+			uasm_i_andi(&p, K0, K0, _PAGE_VALID);
+			uasm_il_beqz(&p, &r, K0, label_tlbl_goaround2);
+		}
 		uasm_i_nop(&p);
 
 		uasm_i_tlbr(&p);
 		/* Examine  entrylo 0 or 1 based on ptr. */
-		uasm_i_andi(&p, K0, K1, sizeof(pte_t));
-		uasm_i_beqz(&p, K0, 8);
-
+		if (use_bbit_insns()) {
+			uasm_i_bbit0(&p, K1, ilog2(sizeof(pte_t)), 8);
+		} else {
+			uasm_i_andi(&p, K0, K1, sizeof(pte_t));
+			uasm_i_beqz(&p, K0, 8);
+		}
 		UASM_i_MFC0(&p, K0, C0_ENTRYLO0); /* load it in the delay slot*/
 		UASM_i_MFC0(&p, K0, C0_ENTRYLO1); /* load it if ptr is odd */
 		/*
 		 * If the entryLo (now in K0) is valid (bit 1), RI or
 		 * XI must have triggered it.
 		 */
-		uasm_i_andi(&p, K0, K0, 2);
-		uasm_il_beqz(&p, &r, K0, label_tlbl_goaround2);
+		if (use_bbit_insns()) {
+			uasm_il_bbit0(&p, &r, K0, 1, label_tlbl_goaround2);
+		} else {
+			uasm_i_andi(&p, K0, K0, 2);
+			uasm_il_beqz(&p, &r, K0, label_tlbl_goaround2);
+		}
 		/* Reload the PTE value */
 		iPTE_LW(&p, K0, K1);
 
-- 
1.7.2.3
