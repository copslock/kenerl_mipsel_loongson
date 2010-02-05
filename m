Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2010 00:28:55 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11641 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491032Ab0BEX1i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Feb 2010 00:27:38 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6ca96f0007>; Fri, 05 Feb 2010 15:27:43 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 5 Feb 2010 15:27:18 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 5 Feb 2010 15:27:18 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o15NRF20028551;
        Fri, 5 Feb 2010 15:27:15 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o15NRBN3028550;
        Fri, 5 Feb 2010 15:27:12 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/4] MIPS: Use 64-bit stores to c0_entrylo on 64-bit kernels.
Date:   Fri,  5 Feb 2010 15:27:08 -0800
Message-Id: <1265412431-28526-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4B6CA90C.1000609@caviumnetworks.com>
References: <4B6CA90C.1000609@caviumnetworks.com>
X-OriginalArrivalTime: 05 Feb 2010 23:27:18.0059 (UTC) FILETIME=[C1E48FB0:01CAA6BA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

64-bit CPUs have 64-bit c0_entrylo{0,1} registers.  We should use the
64-bit dmtc0 instruction to set them.  This becomes important if we
want to set the RI and XI bits present in some processors.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 2c68849..35431e1 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -460,14 +460,14 @@ static __cpuinit void build_huge_update_entries(u32 **p,
 		uasm_i_lui(p, tmp, HPAGE_SIZE >> (7 + 16));
 
 	UASM_i_SRL(p, pte, pte, 6); /* convert to entrylo */
-	uasm_i_mtc0(p, pte, C0_ENTRYLO0); /* load it */
+	UASM_i_MTC0(p, pte, C0_ENTRYLO0); /* load it */
 	/* convert to entrylo1 */
 	if (small_sequence)
 		UASM_i_ADDIU(p, pte, pte, HPAGE_SIZE >> 7);
 	else
 		UASM_i_ADDU(p, pte, pte, tmp);
 
-	uasm_i_mtc0(p, pte, C0_ENTRYLO1); /* load it */
+	UASM_i_MTC0(p, pte, C0_ENTRYLO1); /* load it */
 }
 
 static __cpuinit void build_huge_handler_tail(u32 **p,
@@ -686,18 +686,18 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 		uasm_i_ld(p, tmp, 0, ptep); /* get even pte */
 		uasm_i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
 		uasm_i_dsrl(p, tmp, tmp, 6); /* convert to entrylo0 */
-		uasm_i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
+		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
 		uasm_i_dsrl(p, ptep, ptep, 6); /* convert to entrylo1 */
-		uasm_i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
+		UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
 	} else {
 		int pte_off_even = sizeof(pte_t) / 2;
 		int pte_off_odd = pte_off_even + sizeof(pte_t);
 
 		/* The pte entries are pre-shifted */
 		uasm_i_lw(p, tmp, pte_off_even, ptep); /* get even pte */
-		uasm_i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
+		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
 		uasm_i_lw(p, ptep, pte_off_odd, ptep); /* get odd pte */
-		uasm_i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
+		UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
 	}
 #else
 	UASM_i_LW(p, tmp, 0, ptep); /* get even pte */
@@ -706,14 +706,14 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 		build_tlb_probe_entry(p);
 	UASM_i_SRL(p, tmp, tmp, 6); /* convert to entrylo0 */
 	if (r4k_250MHZhwbug())
-		uasm_i_mtc0(p, 0, C0_ENTRYLO0);
-	uasm_i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
+		UASM_i_MTC0(p, 0, C0_ENTRYLO0);
+	UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
 	UASM_i_SRL(p, ptep, ptep, 6); /* convert to entrylo1 */
 	if (r45k_bvahwbug())
 		uasm_i_mfc0(p, tmp, C0_INDEX);
 	if (r4k_250MHZhwbug())
-		uasm_i_mtc0(p, 0, C0_ENTRYLO1);
-	uasm_i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
+		UASM_i_MTC0(p, 0, C0_ENTRYLO1);
+	UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
 #endif
 }
 
-- 
1.6.0.6
