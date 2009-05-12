Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 23:47:00 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:48258 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026351AbZELWqw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 23:46:52 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a09fc2e0000>; Tue, 12 May 2009 18:46:09 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 15:45:20 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 15:45:20 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4CMjH4n004035;
	Tue, 12 May 2009 15:45:17 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4CMjGOH004033;
	Tue, 12 May 2009 15:45:16 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Don't branch to eret in TLB refill.
Date:	Tue, 12 May 2009 15:45:16 -0700
Message-Id: <1242168316-4009-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 12 May 2009 22:45:20.0395 (UTC) FILETIME=[5420C5B0:01C9D353]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

If the TLB refill handler is too bit and needs to be split, there is
no need to branch around the split if the branch target would be an
eret.  Since the eret returns from the handler, control flow never
passes it.  A branch to an eret is equivalent to the eret itself.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |   50 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4dc4f3e..ffa7104 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -656,6 +656,7 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	struct uasm_reloc *r = relocs;
 	u32 *f;
 	unsigned int final_len;
+	int split_on_eret;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	memset(labels, 0, sizeof(labels));
@@ -684,6 +685,13 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	build_update_entries(&p, K0, K1);
 	build_tlb_write_entry(&p, &l, &r, tlb_random);
 	uasm_l_leave(&l, p);
+
+	/*
+	 * Check to see if the eret will be the last instruction
+	 * before the split.  If it is, there is no need to branch
+	 * around the split, as we are returning.
+	 */
+	split_on_eret = (p - tlb_handler == 31);
 	uasm_i_eret(&p); /* return from trap */
 
 #ifdef CONFIG_64BIT
@@ -723,28 +731,36 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
 		final_len = p - tlb_handler;
 	} else {
-		u32 *split = tlb_handler + 30;
-
-		/*
-		 * Find the split point.
-		 */
-		if (uasm_insn_has_bdelay(relocs, split - 1))
-			split--;
+		u32 *split;
+		if (split_on_eret) {
+			split = tlb_handler + 32;
+		} else {
+			split = tlb_handler + 30;
+
+			/*
+			 * Find the split point.
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
