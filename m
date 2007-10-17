Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 11:51:54 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:41678 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022717AbXJQKvq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 11:51:46 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 39FDF400B9;
	Wed, 17 Oct 2007 12:51:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id ndL3XshMzEHi; Wed, 17 Oct 2007 12:51:39 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id A7D90400A4;
	Wed, 17 Oct 2007 12:51:39 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9HApgWn032057;
	Wed, 17 Oct 2007 12:51:42 +0200
Date:	Wed, 17 Oct 2007 11:51:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] c-r3k: Implement flush_cache_range()
Message-ID: <Pine.LNX.4.64N.0710171144410.28993@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4542/Tue Oct 16 22:31:56 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Contrary to the belief of some, the R3000 and related processors did have 
caches, both a data and an instruction cache.  Here is an implementation 
of r3k_flush_cache_page(), which is the processor-specific back-end for 
flush_cache_range(), done according to the spec in 
Documentation/cachetlb.txt.

 While at it, remove an unused local function: get_phys_page(), do some 
trivial formatting fixes and modernise debugging facilities.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Fine with checkpatch.pl and tested at the run time with an R3000A, fixing 
problems surrounding ptrace(PTRACE_POKEDATA, ...).

 Please apply,

  Maciej

patch-mips-2.6.23-20071011-r3000-flush_cache_page-3
diff -up --recursive --new-file linux-mips-2.6.23-20071011.macro/arch/mips/mm/c-r3k.c linux-mips-2.6.23-20071011/arch/mips/mm/c-r3k.c
--- linux-mips-2.6.23-20071011.macro/arch/mips/mm/c-r3k.c	2007-10-11 04:56:52.000000000 +0000
+++ linux-mips-2.6.23-20071011/arch/mips/mm/c-r3k.c	2007-10-17 10:38:20.000000000 +0000
@@ -7,7 +7,7 @@
  * Tx39XX R4k style caches added. HK
  * Copyright (C) 1998, 1999, 2000 Harald Koerfgen
  * Copyright (C) 1998 Gleb Raiko & Vladimir Roganov
- * Copyright (C) 2001, 2004  Maciej W. Rozycki
+ * Copyright (C) 2001, 2004, 2007  Maciej W. Rozycki
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -26,8 +26,6 @@
 static unsigned long icache_size, dcache_size;		/* Size in bytes */
 static unsigned long icache_lsize, dcache_lsize;	/* Size in bytes */
 
-#undef DEBUG_CACHE
-
 unsigned long __init r3k_cache_size(unsigned long ca_flags)
 {
 	unsigned long flags, status, dummy, size;
@@ -217,26 +215,6 @@ static void r3k_flush_dcache_range(unsig
 	write_c0_status(flags);
 }
 
-static inline unsigned long get_phys_page(unsigned long addr,
-					  struct mm_struct *mm)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned long physpage;
-
-	pgd = pgd_offset(mm, addr);
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
-	pte = pte_offset(pmd, addr);
-
-	if ((physpage = pte_val(*pte)) & _PAGE_VALID)
-		return KSEG0ADDR(physpage & PAGE_MASK);
-
-	return 0;
-}
-
 static inline void r3k_flush_cache_all(void)
 {
 }
@@ -252,12 +230,40 @@ static void r3k_flush_cache_mm(struct mm
 }
 
 static void r3k_flush_cache_range(struct vm_area_struct *vma,
-	unsigned long start, unsigned long end)
+				  unsigned long start, unsigned long end)
 {
 }
 
-static void r3k_flush_cache_page(struct vm_area_struct *vma, unsigned long page, unsigned long pfn)
+static void r3k_flush_cache_page(struct vm_area_struct *vma,
+				 unsigned long addr, unsigned long pfn)
 {
+	unsigned long kaddr = KSEG0ADDR(pfn << PAGE_SHIFT);
+	int exec = vma->vm_flags & VM_EXEC;
+	struct mm_struct *mm = vma->vm_mm;
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	pr_debug("cpage[%08lx,%08lx]\n",
+		 cpu_context(smp_processor_id(), mm), addr);
+
+	/* No ASID => no such page in the cache.  */
+	if (cpu_context(smp_processor_id(), mm) == 0)
+		return;
+
+	pgdp = pgd_offset(mm, addr);
+	pudp = pud_offset(pgdp, addr);
+	pmdp = pmd_offset(pudp, addr);
+	ptep = pte_offset(pmdp, addr);
+
+	/* Invalid => no such page in the cache.  */
+	if (!(pte_val(*ptep) & _PAGE_PRESENT))
+		return;
+
+	r3k_flush_dcache_range(kaddr, kaddr + PAGE_SIZE);
+	if (exec)
+		r3k_flush_icache_range(kaddr, kaddr + PAGE_SIZE);
 }
 
 static void local_r3k_flush_data_cache_page(void *addr)
@@ -272,9 +278,7 @@ static void r3k_flush_cache_sigtramp(uns
 {
 	unsigned long flags;
 
-#ifdef DEBUG_CACHE
-	printk("csigtramp[%08lx]", addr);
-#endif
+	pr_debug("csigtramp[%08lx]\n", addr);
 
 	flags = read_c0_status();
 
