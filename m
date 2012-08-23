Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2012 19:02:23 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:49178 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903650Ab2HWRCR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Aug 2012 19:02:17 +0200
Received: by pbbrq8 with SMTP id rq8so1846219pbb.36
        for <multiple recipients>; Thu, 23 Aug 2012 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=caVaFmjpJoQZbDZw1dYo3j0dae4AdfP7IF1zMdsDEAU=;
        b=NU5e/GXETKmTYCX07anqVFPSS67Zdo1FAZEBJpOaPjrTxseRBSnKABXesFj1t2Wd0Q
         v3XXMHgc4FftoPLUb7I9UPCw6EDfk8b7Gkk1jeHyNlkGElzyExTHKp6AzE2LAuIu+fJq
         cYLsHF8uGRqWmPrIcaUPJiNVNES9Fznqka+7iz27X6NEtzeBHSF9/jABOx/mGierjdHv
         5oGcdJNifmxnvg1IyyI1cwQ8Ypg2ywafKErKdcmuyeCVK+sQCKJyQ0rhzIYRokO34sKp
         TpUfJ9TFpx/nIOVVkhIZ4mSDyDv038PUdIkbQESZaPquIyvYVeC46wSbh3TY+qf68V2n
         66gA==
Received: by 10.66.84.6 with SMTP id u6mr4596734pay.75.1345741330206;
        Thu, 23 Aug 2012 10:02:10 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pj3sm6351601pbc.53.2012.08.23.10.02.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2012 10:02:08 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7NH256W021733;
        Thu, 23 Aug 2012 10:02:05 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7NH2487021732;
        Thu, 23 Aug 2012 10:02:04 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Optimize TLB refill for RI/XI configurations.
Date:   Thu, 23 Aug 2012 10:02:03 -0700
Message-Id: <1345741323-21699-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
X-archive-position: 34352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 26209

From: David Daney <ddaney@caviumnetworks.com>

We don't have to do a separate shift to eliminate the software bits,
just rotate them into the fill and they will be ignored.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 03eb0ef..4f33acd 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -587,8 +587,7 @@ static __cpuinit __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 								  unsigned int reg)
 {
 	if (kernel_uses_smartmips_rixi) {
-		UASM_i_SRL(p, reg, reg, ilog2(_PAGE_NO_EXEC));
-		UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+		UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL));
 	} else {
 #ifdef CONFIG_64BIT_PHYS_ADDR
 		uasm_i_dsrl_safe(p, reg, reg, ilog2(_PAGE_GLOBAL));
@@ -991,11 +990,9 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 		uasm_i_ld(p, tmp, 0, ptep); /* get even pte */
 		uasm_i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
 		if (kernel_uses_smartmips_rixi) {
-			UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
-			UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
-			UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+			UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
 			UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-			UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+			UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL));
 		} else {
 			uasm_i_dsrl_safe(p, tmp, tmp, ilog2(_PAGE_GLOBAL)); /* convert to entrylo0 */
 			UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
@@ -1018,13 +1015,11 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 	if (r45k_bvahwbug())
 		build_tlb_probe_entry(p);
 	if (kernel_uses_smartmips_rixi) {
-		UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
-		UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
-		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
 		if (r4k_250MHZhwbug())
 			UASM_i_MTC0(p, 0, C0_ENTRYLO0);
 		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-		UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+		UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL));
 	} else {
 		UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_GLOBAL)); /* convert to entrylo0 */
 		if (r4k_250MHZhwbug())
@@ -1184,13 +1179,9 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 		UASM_i_LW(p, odd, sizeof(pte_t), ptr); /* get odd pte */
 	}
 	if (kernel_uses_smartmips_rixi) {
-		uasm_i_dsrl_safe(p, even, even, ilog2(_PAGE_NO_EXEC));
-		uasm_i_dsrl_safe(p, odd, odd, ilog2(_PAGE_NO_EXEC));
-		uasm_i_drotr(p, even, even,
-			     ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+		uasm_i_drotr(p, even, even, ilog2(_PAGE_GLOBAL));
 		UASM_i_MTC0(p, even, C0_ENTRYLO0); /* load it */
-		uasm_i_drotr(p, odd, odd,
-			     ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+		uasm_i_drotr(p, odd, odd, ilog2(_PAGE_GLOBAL));
 	} else {
 		uasm_i_dsrl_safe(p, even, even, ilog2(_PAGE_GLOBAL));
 		UASM_i_MTC0(p, even, C0_ENTRYLO0); /* load it */
-- 
1.7.11.4
