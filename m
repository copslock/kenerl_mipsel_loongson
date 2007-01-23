Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 15:39:09 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:50908 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28579617AbXAWPjE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Jan 2007 15:39:04 +0000
Received: from localhost (p2057-ipad205funabasi.chiba.ocn.ne.jp [222.146.97.57])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 35A82B8B3; Wed, 24 Jan 2007 00:38:59 +0900 (JST)
Date:	Wed, 24 Jan 2007 00:38:59 +0900 (JST)
Message-Id: <20070124.003859.126141727.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH][RFC] Move some kernel globals from asm file to C file.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found that symbols defined by .comm in head.S are placed in random
order (with binutils 2.17).  For example, here is a tail of
System.map:

801ce000 B fw_arg3
801ce004 B fw_arg1
801cf000 B swapper_pg_dir
801d0000 B invalid_pte_table
801d1000 B fw_arg2
801d1008 B kernelsp
801d1010 B fw_arg0
801d1018 B pgd_current
801d1020 A __bss_stop
801d1020 A _end

It looks less efficient while fw_arg[0-3] are all 4 byte.

Is there any point on declaring those symbols in asm file?  If
nothing, how about moving them to C file?  And I can not see why
kernel_sp and pgd_current have 8-byte size even on 32-bit kernel.

Here is a proposal patch.  Comments?

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/asm-offsets.c |    4 ----
 arch/mips/kernel/head.S        |   25 -------------------------
 arch/mips/kernel/setup.c       |   17 +++++++++++++++++
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index ff88b06..ea7df4b 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -234,10 +234,6 @@ void output_mm_defines(void)
 	constant("#define _PMD_SHIFT     ", PMD_SHIFT);
 	constant("#define _PGDIR_SHIFT   ", PGDIR_SHIFT);
 	linefeed;
-	constant("#define _PGD_ORDER     ", PGD_ORDER);
-	constant("#define _PMD_ORDER     ", PMD_ORDER);
-	constant("#define _PTE_ORDER     ", PTE_ORDER);
-	linefeed;
 	constant("#define _PTRS_PER_PGD  ", PTRS_PER_PGD);
 	constant("#define _PTRS_PER_PMD  ", PTRS_PER_PMD);
 	constant("#define _PTRS_PER_PTE  ", PTRS_PER_PTE);
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 9a7811d..6f57ca4 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -231,28 +231,3 @@ NESTED(smp_bootstrap, 16, sp)
 #endif /* CONFIG_SMP */
 
 	__FINIT
-
-	.comm	kernelsp,    NR_CPUS * 8, 8
-	.comm	pgd_current, NR_CPUS * 8, 8
-
-	.comm	fw_arg0, SZREG, SZREG		# firmware arguments
-	.comm	fw_arg1, SZREG, SZREG
-	.comm	fw_arg2, SZREG, SZREG
-	.comm	fw_arg3, SZREG, SZREG
-
-	.macro page name, order
-	.comm	\name, (_PAGE_SIZE << \order), (_PAGE_SIZE << \order)
-	.endm
-
-	/*
-	 * On 64-bit we've got three-level pagetables with a slightly
-	 * different layout ...
-	 */
-	page	swapper_pg_dir, _PGD_ORDER
-#ifdef CONFIG_64BIT
-#if defined(CONFIG_MODULES) && !defined(CONFIG_BUILD_ELF64)
-	page	module_pg_dir, _PGD_ORDER
-#endif
-	page	invalid_pmd_table, _PMD_ORDER
-#endif
-	page	invalid_pte_table, _PTE_ORDER
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 89440a0..dc307e4 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -541,3 +541,20 @@ int __init dsp_disable(char *s)
 }
 
 __setup("nodsp", dsp_disable);
+
+unsigned long kernelsp[NR_CPUS];
+unsigned long pgd_current[NR_CPUS];
+unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
+/*
+ * On 64-bit we've got three-level pagetables with a slightly
+ * different layout ...
+ */
+#define __page_aligned(order) __attribute__((__aligned__(PAGE_SIZE<<order)))
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
+#ifdef CONFIG_64BIT
+#if defined(CONFIG_MODULES) && !defined(CONFIG_BUILD_ELF64)
+pgd_t module_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
+#endif
+pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned(PMD_ORDER);
+#endif
+pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned(PTE_ORDER);
