Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2012 10:50:04 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1721 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822190Ab2LRJuBK8vXX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Dec 2012 10:50:01 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 18 Dec 2012 01:46:45 -0800
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 18 Dec 2012 01:49:22 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id EB66A40FE4; Tue, 18
 Dec 2012 01:49:37 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     "Steven J . Hill" <sjhill@mips.com>, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, linux-mips@linux-mips.org
Subject: [PATCH] Revert
 "MIPS: Optimise TLB handlers for MIPS32/64 R2 cores."
Date:   Tue, 18 Dec 2012 15:20:03 +0530
Message-ID: <1355824203-18912-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7CCEE40F3R022890145-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

This reverts commit ff401e52100dcdc85e572d1ad376d3307b3fe28e.

The commit causes a boot-time crash on Netlogic XLP boards. The
crash is caused by the second part of the patch that changes
build_get_ptep(), which seems to break mips64 TLB handling on r2
platforms.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/mm/tlbex.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e085e15..1a17a9b 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -976,13 +976,6 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 #endif
 	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
 	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
-
-	if (cpu_has_mips_r2) {
-		uasm_i_ext(p, tmp, tmp, PGDIR_SHIFT, (32 - PGDIR_SHIFT));
-		uasm_i_ins(p, ptr, tmp, PGD_T_LOG2, (32 - PGDIR_SHIFT));
-		return;
-	}
-
 	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
 	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
 	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
@@ -1018,15 +1011,6 @@ static void __cpuinit build_adjust_context(u32 **p, unsigned int ctx)
 
 static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 {
-	if (cpu_has_mips_r2) {
-		/* PTE ptr offset is obtained from BadVAddr */
-		UASM_i_MFC0(p, tmp, C0_BADVADDR);
-		UASM_i_LW(p, ptr, 0, ptr);
-		uasm_i_ext(p, tmp, tmp, PAGE_SHIFT+1, PGDIR_SHIFT-PAGE_SHIFT-1);
-		uasm_i_ins(p, ptr, tmp, PTE_T_LOG2+1, PGDIR_SHIFT-PAGE_SHIFT-1);
-		return;
-	}
-
 	/*
 	 * Bug workaround for the Nevada. It seems as if under certain
 	 * circumstances the move from cp0_context might produce a
-- 
1.7.9.5
