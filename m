Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 21:49:12 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:20877 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025127AbZEMUtB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2009 21:49:01 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a0b32310003>; Wed, 13 May 2009 16:48:49 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 13:48:41 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 13:48:41 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4DKmc0m021354;
	Wed, 13 May 2009 13:48:38 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4DKmcEm021353;
	Wed, 13 May 2009 13:48:38 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Don't branch to eret in TLB refill.
Date:	Wed, 13 May 2009 13:48:37 -0700
Message-Id: <1242247717-21324-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A0B31C6.9050804@caviumnetworks.com>
References: <4A0B31C6.9050804@caviumnetworks.com>
X-OriginalArrivalTime: 13 May 2009 20:48:41.0109 (UTC) FILETIME=[32A43C50:01C9D40C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

If the TLB refill handler is too big and needs to be split, there is
no need to branch around the split if the branch target would be an
eret.  Since the eret returns from the handler, control flow never
passes it.  A branch to an eret is equivalent to the eret itself.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |   66 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index d99ed78..0a88383 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -664,6 +664,7 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	struct uasm_reloc *r = relocs;
 	u32 *f;
 	unsigned int final_len;
+	int split_on_eret;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	memset(labels, 0, sizeof(labels));
@@ -693,6 +694,12 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	build_tlb_write_entry(&p, &l, &r, tlb_random);
 	uasm_l_leave(&l, p);
 	uasm_i_eret(&p); /* return from trap */
+	/*
+	 * Check to see if the eret was the last instruction before
+	 * the split.  If it was, there will be no need to branch
+	 * around the split, because we are returning.
+	 */
+	split_on_eret = (p - tlb_handler == MIPS64_REFILL_INSNS);
 
 #ifdef CONFIG_64BIT
 	build_get_pgd_vmalloc64(&p, &l, &r, K0, K1);
@@ -732,36 +739,43 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
 		final_len = p - tlb_handler;
 	} else {
-		/*
-		 * Split two instructions before the end.  One for the
-		 * branch and one for the instruction in the delay
-		 * slot.
-		 */
-		u32 *split = tlb_handler + MIPS64_REFILL_INSNS - 2;
-
-		/*
-		 * Find the split point.  If the branch would fall in
-		 * a delay slot, we must back up an additional
-		 * instruction so that it is no longer in a delay
-		 * slot.
-		 */
-		if (uasm_insn_has_bdelay(relocs, split - 1))
-			split--;
-
+		u32 *split;
+		if (split_on_eret) {
+			split = tlb_handler + MIPS64_REFILL_INSNS;
+		} else {
+			/*
+			 * Split two instructions before the end.  One
+			 * for the branch and one for the instruction
+			 * in the delay slot.
+			 */
+			u32 *split = tlb_handler + MIPS64_REFILL_INSNS - 2;
+
+			/*
+			 * Find the split point.  If the branch would
+			 * fall in a delay slot, we must back up an
+			 * additional instruction so that it is no
+			 * longer in a delay slot.
+			 */
+			if (uasm_insn_has_bdelay(relocs, split - 1))
+				split--;
+		}
 		/* Copy first part of the handler. */
 		uasm_copy_handler(relocs, labels, tlb_handler, split, f);
 		f += split - tlb_handler;
 
-		/* Insert branch. */
-		uasm_l_split(&l, final_handler);
-		uasm_il_b(&f, &r, label_split);
-		if (uasm_insn_has_bdelay(relocs, split))
-			uasm_i_nop(&f);
-		else {
-			uasm_copy_handler(relocs, labels, split, split + 1, f);
-			uasm_move_labels(labels, f, f + 1, -1);
-			f++;
-			split++;
+		if (!split_on_eret) {
+			/* Insert branch. */
+			uasm_l_split(&l, final_handler);
+			uasm_il_b(&f, &r, label_split);
+			if (uasm_insn_has_bdelay(relocs, split))
+				uasm_i_nop(&f);
+			else {
+				uasm_copy_handler(relocs, labels,
+						  split, split + 1, f);
+				uasm_move_labels(labels, f, f + 1, -1);
+				f++;
+				split++;
+			}
 		}
 
 		/* Copy the rest of the handler. */
-- 
1.6.0.6
