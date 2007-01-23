Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 16:21:15 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:61174 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20051982AbXAWQVK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Jan 2007 16:21:10 +0000
Received: from localhost (p2057-ipad205funabasi.chiba.ocn.ne.jp [222.146.97.57])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5E4B3B5E5; Wed, 24 Jan 2007 01:21:06 +0900 (JST)
Date:	Wed, 24 Jan 2007 01:21:05 +0900 (JST)
Message-Id: <20070124.012105.63741796.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][RFC] Move some kernel globals from asm file to C file.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070123161226.GA20530@linux-mips.org>
References: <20070124.003859.126141727.anemo@mba.ocn.ne.jp>
	<20070123161226.GA20530@linux-mips.org>
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
X-archive-position: 13765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 23 Jan 2007 16:12:26 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> Looks ok but I think all the pagetable stuff should move to somewhere
> like arch/mips/mm/init.c.

Thanks, updated.  Also use "#ifdef MODULE_START" instead of complex
condition.


Subject: Move some kernel globals from asm file to C file.

This get rid of some undesirable hole in BSS section due to random
order of placement.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/asm-offsets.c |    4 ----
 arch/mips/kernel/head.S        |   25 -------------------------
 arch/mips/kernel/setup.c       |    3 +++
 arch/mips/mm/init.c            |   15 +++++++++++++++
 4 files changed, 18 insertions(+), 29 deletions(-)

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
index 89440a0..8da9d03 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -541,3 +541,6 @@ int __init dsp_disable(char *s)
 }
 
 __setup("nodsp", dsp_disable);
+
+unsigned long kernelsp[NR_CPUS];
+unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 30245c0..1e1427a 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -507,3 +507,18 @@ void free_initmem(void)
 			__pa_symbol(&__init_begin),
 			__pa_symbol(&__init_end));
 }
+
+unsigned long pgd_current[NR_CPUS];
+/*
+ * On 64-bit we've got three-level pagetables with a slightly
+ * different layout ...
+ */
+#define __page_aligned(order) __attribute__((__aligned__(PAGE_SIZE<<order)))
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
+#ifdef CONFIG_64BIT
+#ifdef MODULE_START
+pgd_t module_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
+#endif
+pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned(PMD_ORDER);
+#endif
+pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned(PTE_ORDER);
