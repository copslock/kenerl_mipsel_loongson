Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2018 17:58:00 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:63036 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993070AbeFPP5xgwndw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jun 2018 17:57:53 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 0392440F22;
        Sat, 16 Jun 2018 17:57:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id tm6TxfYGwNF4; Sat, 16 Jun 2018 17:57:46 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, ak@linux.intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: Use same definition for tlbmiss_handler_setup_pgd
Date:   Sat, 16 Jun 2018 17:57:37 +0200
Message-Id: <20180616155737.31156-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

tlbmiss_handler_setup_pgd is defined as a pointer to a u32 array in
tlbex.c and as a function pointer in mmu_context.h. This was done
because tlbex.c fills the memory of u32 with assembler code which
implements a function, this assembler code depends on the CPU being
used. Later the code will jump into this function.

This patch uses the same type for both definitions and makes use of the
pointer to the _start of the function in places where we have to access
the code of the function.

This fixes the build with LTO.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/mm/tlbex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 79b9f2ad3ff5..f1aa5989a424 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1575,7 +1575,7 @@ extern u32 handle_tlbl[], handle_tlbl_end[];
 extern u32 handle_tlbs[], handle_tlbs_end[];
 extern u32 handle_tlbm[], handle_tlbm_end[];
 extern u32 tlbmiss_handler_setup_pgd_start[];
-extern u32 tlbmiss_handler_setup_pgd[];
+extern void tlbmiss_handler_setup_pgd(unsigned long);
 EXPORT_SYMBOL_GPL(tlbmiss_handler_setup_pgd);
 extern u32 tlbmiss_handler_setup_pgd_end[];
 
@@ -1592,7 +1592,7 @@ static void build_setup_pgd(void)
 #endif
 
 	memset(tlbmiss_handler_setup_pgd, 0, tlbmiss_handler_setup_pgd_size *
-					sizeof(tlbmiss_handler_setup_pgd[0]));
+					sizeof(u32));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 	pgd_reg = allocate_kscratch();
@@ -1650,9 +1650,9 @@ static void build_setup_pgd(void)
 
 	uasm_resolve_relocs(relocs, labels);
 	pr_debug("Wrote tlbmiss_handler_setup_pgd (%u instructions).\n",
-		 (unsigned int)(p - tlbmiss_handler_setup_pgd));
+		 (unsigned int)(p - tlbmiss_handler_setup_pgd_start));
 
-	dump_handler("tlbmiss_handler", tlbmiss_handler_setup_pgd,
+	dump_handler("tlbmiss_handler", tlbmiss_handler_setup_pgd_start,
 					tlbmiss_handler_setup_pgd_size);
 }
 
-- 
2.11.0
