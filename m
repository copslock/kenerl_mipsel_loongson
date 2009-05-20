Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 19:41:20 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:22142 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025103AbZETSlN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 19:41:13 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a144ebd0000>; Wed, 20 May 2009 14:41:01 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 May 2009 11:41:04 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 May 2009 11:41:04 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4KIf1pj006818;
	Wed, 20 May 2009 11:41:02 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4KIf1EY006817;
	Wed, 20 May 2009 11:41:01 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 2/2] MIPS: Fold the TLB refill at the vmalloc path if possible.
Date:	Wed, 20 May 2009 11:40:59 -0700
Message-Id: <1242844859-6788-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A144DFF.90602@caviumnetworks.com>
References: <4A144DFF.90602@caviumnetworks.com>
X-OriginalArrivalTime: 20 May 2009 18:41:04.0395 (UTC) FILETIME=[87C6A5B0:01C9D97A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Try to fold the 64-bit TLB refill handler opportunistically at the
beginning of the vmalloc path so as to avoid splitting execution flow in
half and wasting cycles for a branch required at that point then.  Resort
to doing the split if either of the newly created parts would not fit into
its designated slot.

Original-patch-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |   73 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index cbc09de..62fbd0d 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -6,7 +6,7 @@
  * Synthesize TLB refill handlers at runtime.
  *
  * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
- * Copyright (C) 2005, 2007  Maciej W. Rozycki
+ * Copyright (C) 2005, 2007, 2008, 2009  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
  *
  * ... and the days got worse and worse and now you see
@@ -19,6 +19,7 @@
  * (Condolences to Napoleon XIV)
  */
 
+#include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -732,36 +733,60 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
 		final_len = p - tlb_handler;
 	} else {
-		/*
-		 * Split two instructions before the end.  One for the
-		 * branch and one for the instruction in the delay
-		 * slot.
-		 */
-		u32 *split = tlb_handler + MIPS64_REFILL_INSNS - 2;
+#ifdef MODULE_START
+		const enum label_id ls = label_module_alloc;
+#else
+		const enum label_id ls = label_vmalloc;
+#endif
+		u32 *split;
+		int ov = 0;
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(labels) && labels[i].lab != ls; i++)
+			;
+		BUG_ON(i == ARRAY_SIZE(labels));
+		split = labels[i].addr;
 
 		/*
-		 * Find the split point.  If the branch would fall in
-		 * a delay slot, we must back up an additional
-		 * instruction so that it is no longer in a delay
-		 * slot.
+		 * See if we have overflown one way or the other.
 		 */
-		if (uasm_insn_has_bdelay(relocs, split - 1))
-			split--;
-
+		if (split > tlb_handler + MIPS64_REFILL_INSNS ||
+		    split < p - MIPS64_REFILL_INSNS)
+			ov = 1;
+
+		if (ov) {
+			/*
+			 * Split two instructions before the end.  One
+			 * for the branch and one for the instruction
+			 * in the delay slot.
+			 */
+			split = tlb_handler + MIPS64_REFILL_INSNS - 2;
+
+			/*
+			 * If the branch would fall in a delay slot,
+			 * we must back up an additional instruction
+			 * so that it is no longer in a delay slot.
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
+		if (ov) {
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
