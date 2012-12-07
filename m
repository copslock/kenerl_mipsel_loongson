Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:15:00 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60365 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824759Ab2LGFO73g6nr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:14:59 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TgqGz-0007Oy-D6; Thu, 06 Dec 2012 23:14:53 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: Reduce code size for MIPS32R2 platforms.
Date:   Thu,  6 Dec 2012 23:14:49 -0600
Message-Id: <1354857289-28828-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

If the CPU type is selected to be a MIPS32R2 core, we surround
some code with #ifdef's to reduce the kernel binary size.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mm/tlbex.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index cd9ad1b..4c23656 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -364,6 +364,7 @@ static void __cpuinit build_restore_work_registers(u32 **p)
  */
 extern unsigned long pgd_current[];
 
+# ifndef CONFIG_CPU_MIPS32_R2
 /*
  * The R3000 TLB handler is simple.
  */
@@ -403,6 +404,7 @@ static void __cpuinit build_r3000_tlb_refill_handler(void)
 
 	dump_handler((u32 *)ebase, 32);
 }
+# endif /* !CONFIG_CPU_MIPS32_R2 */
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
 
 /*
@@ -1672,7 +1674,7 @@ build_pte_modifiable(u32 **p, struct uasm_reloc **r,
 	}
 }
 
-#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
+#if !defined(CONFIG_MIPS_PGD_C0_CONTEXT) && !defined(CONFIG_CPU_MIPS32_R2)
 
 
 /*
@@ -1826,7 +1828,7 @@ static void __cpuinit build_r3000_tlb_modify_handler(void)
 
 	dump_handler(handle_tlbm, ARRAY_SIZE(handle_tlbm));
 }
-#endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
+#endif /* !CONFIG_MIPS_PGD_C0_CONTEXT && !CONFIG_CPU_MIPS32_R2 */
 
 /*
  * R4000 style TLB load/store/modify handlers.
@@ -2164,6 +2166,7 @@ void __cpuinit build_tlb_refill_handler(void)
 #endif
 
 	switch (current_cpu_type()) {
+#ifndef CONFIG_CPU_MIPS32_R2
 	case CPU_R2000:
 	case CPU_R3000:
 	case CPU_R3000A:
@@ -2193,6 +2196,7 @@ void __cpuinit build_tlb_refill_handler(void)
 		panic("No R8000 TLB refill handler yet");
 		break;
 
+#endif /* !CONFIG_CPU_MIPS32_R2 */
 	default:
 		if (!run_once) {
 			scratch_reg = allocate_kscratch();
-- 
1.7.9.5
