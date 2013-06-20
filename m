Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 07:59:31 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43949 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817179Ab3FTF63sWNaG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 07:58:29 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UpXsc-00038J-If; Thu, 20 Jun 2013 00:57:58 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: Add missing hazard barrier in TLB load handler.
Date:   Thu, 20 Jun 2013 00:57:54 -0500
Message-Id: <1371707874-6632-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

MIPS R2 documents state that an execution hazard barrier is needed
after a TLBR before reading EntryLo.

Change-Id: Idef3b6abbb63a1bbd5e153c6110a979fa7bd5896
Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/mm/tlbex.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index d9969d2..5ef426c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1922,6 +1922,11 @@ static void build_r4000_tlb_load_handler(void)
 		uasm_i_nop(&p);
 
 		uasm_i_tlbr(&p);
+#if !defined(CONFIG_CPU_CAVIUM_OCTEON)
+		/* hazard barrier after TLBR but before read EntryLo */
+		if (cpu_has_mips_r2)
+			uasm_i_ehb(&p);
+#endif
 		/* Examine  entrylo 0 or 1 based on ptr. */
 		if (use_bbit_insns()) {
 			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
@@ -1976,6 +1981,11 @@ static void build_r4000_tlb_load_handler(void)
 		uasm_i_nop(&p);
 
 		uasm_i_tlbr(&p);
+#if !defined(CONFIG_CPU_CAVIUM_OCTEON)
+		/* hazard barrier after TLBR but before read EntryLo */
+		if (cpu_has_mips_r2)
+			uasm_i_ehb(&p);
+#endif
 		/* Examine  entrylo 0 or 1 based on ptr. */
 		if (use_bbit_insns()) {
 			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
-- 
1.7.2.5
