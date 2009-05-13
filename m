Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 23:22:30 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7355 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026361AbZEMWWU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2009 23:22:20 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a0b47e30000>; Wed, 13 May 2009 18:21:28 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 15:20:27 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 15:20:27 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4DMKLpj006692;
	Wed, 13 May 2009 15:20:22 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4DMKIda006690;
	Wed, 13 May 2009 15:20:18 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	paul.gortmaker@windriver.com,
	David Daney <ddaney@caviumnetworks.com>,
	David VomLehn <dvomlehn@cisco.com>
Subject: [PATCH 1/2] MIPS: Replace some magic numbers with symbolic values in tlbex.c (v2)
Date:	Wed, 13 May 2009 15:20:18 -0700
Message-Id: <1242253218-6666-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1242247717-21324-1-git-send-email-ddaney@caviumnetworks.com>
References: <1242247717-21324-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 13 May 2009 22:20:27.0527 (UTC) FILETIME=[04B8F170:01C9D419]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The logic used to split the r4000 refill handler is liberally
sprinkled with magic numbers.  We attempt to explain what they are and
normalize them against a new symbolic value (MIPS64_REFILL_INSNS).

Changes from v1:  Corrected spelling in comment.

CC: David VomLehn <dvomlehn@cisco.com>
Reviewed-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

Please use this version instead of the original 1/2.

 arch/mips/mm/tlbex.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4dc4f3e..cbc09de 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -649,6 +649,14 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 #endif
 }
 
+/*
+ * For a 64-bit kernel, we are using the 64-bit XTLB refill exception
+ * because EXL == 0.  If we wrap, we can also use the 32 instruction
+ * slots before the XTLB refill exception handler which belong to the
+ * unused TLB refill exception.
+ */
+#define MIPS64_REFILL_INSNS 32
+
 static void __cpuinit build_r4000_tlb_refill_handler(void)
 {
 	u32 *p = tlb_handler;
@@ -702,9 +710,10 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	if ((p - tlb_handler) > 64)
 		panic("TLB refill handler space exceeded");
 #else
-	if (((p - tlb_handler) > 63)
-	    || (((p - tlb_handler) > 61)
-		&& uasm_insn_has_bdelay(relocs, tlb_handler + 29)))
+	if (((p - tlb_handler) > (MIPS64_REFILL_INSNS * 2) - 1)
+	    || (((p - tlb_handler) > (MIPS64_REFILL_INSNS * 2) - 3)
+		&& uasm_insn_has_bdelay(relocs,
+					tlb_handler + MIPS64_REFILL_INSNS - 3)))
 		panic("TLB refill handler space exceeded");
 #endif
 
@@ -717,16 +726,24 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	uasm_copy_handler(relocs, labels, tlb_handler, p, f);
 	final_len = p - tlb_handler;
 #else /* CONFIG_64BIT */
-	f = final_handler + 32;
-	if ((p - tlb_handler) <= 32) {
+	f = final_handler + MIPS64_REFILL_INSNS;
+	if ((p - tlb_handler) <= MIPS64_REFILL_INSNS) {
 		/* Just copy the handler. */
 		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
 		final_len = p - tlb_handler;
 	} else {
-		u32 *split = tlb_handler + 30;
+		/*
+		 * Split two instructions before the end.  One for the
+		 * branch and one for the instruction in the delay
+		 * slot.
+		 */
+		u32 *split = tlb_handler + MIPS64_REFILL_INSNS - 2;
 
 		/*
-		 * Find the split point.
+		 * Find the split point.  If the branch would fall in
+		 * a delay slot, we must back up an additional
+		 * instruction so that it is no longer in a delay
+		 * slot.
 		 */
 		if (uasm_insn_has_bdelay(relocs, split - 1))
 			split--;
@@ -749,7 +766,8 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 
 		/* Copy the rest of the handler. */
 		uasm_copy_handler(relocs, labels, split, p, final_handler);
-		final_len = (f - (final_handler + 32)) + (p - split);
+		final_len = (f - (final_handler + MIPS64_REFILL_INSNS)) +
+			    (p - split);
 	}
 #endif /* CONFIG_64BIT */
 
-- 
1.6.0.6
