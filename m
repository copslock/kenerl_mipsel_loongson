Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2009 16:30:12 +0200 (CEST)
Received: from mail-fx0-f220.google.com ([209.85.220.220]:37375 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492730AbZICOaG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Sep 2009 16:30:06 +0200
Received: by fxm20 with SMTP id 20so1680982fxm.0
        for <multiple recipients>; Thu, 03 Sep 2009 07:30:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FCl7MH4hu+t6mfKBCOeI1dQAVfEiLK79DD/hGM1IEoo=;
        b=ltogB3mtwoK0jES3WTmeG7qfXtBu89DSSsDdofJd/1Z/9d9ArFGZFXD9/gsjnFn25J
         g9HqnPDDyqAsQ7JMpG5FxQdenYxekEjbLBf4UujQwc66OZih42XBODYxa2jXUs9Ra+FT
         vqYEIh/yEc01+PZ5mOi/d9xbA3xO3lwGA8WIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PHM+ik3Xa54uFMRISvBRSFPibyFNBRgbzouwN6NwGiuy3zVI+HXdSP9uIlhy3DtqOx
         rF5atX6bTkl8aLYNeDf8/3pBvVKwK49WMNS30pbdVKldylRjplElExDT1OaJRKNSNv9c
         uRnHsrvEjDLyp2Cnk02A4LVkoj9ZSTaQ++9jc=
Received: by 10.204.34.71 with SMTP id k7mr7908986bkd.206.1251988199927;
        Thu, 03 Sep 2009 07:29:59 -0700 (PDT)
Received: from desktop ([58.31.9.46])
        by mx.google.com with ESMTPS id y15sm1997182fkd.47.2009.09.03.07.29.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Sep 2009 07:29:59 -0700 (PDT)
Date:	Thu, 3 Sep 2009 22:29:53 +0800
From:	Wu Fei <at.wufei@gmail.com>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Shrink the size of tlb handler
Message-ID: <20090903142953.GB6482@desktop>
References: <20090903142753.GA6482@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090903142753.GA6482@desktop>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <at.wufei@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: at.wufei@gmail.com
Precedence: bulk
X-list: linux-mips

By combining swapper_pg_dir and module_pg_dir, several if conditions
can be eliminated from the tlb exception handler. The reason they
can be combined is that, the effective virtual address of vmalloc
returned is at the bottom, and of module_alloc returned is at the
top. It also fixes the bug in vmalloc(), which happens when its
return address is not covered by the first pgd.

Signed-off-by: Wu Fei <at.wufei@gmail.com>
---
 arch/mips/include/asm/pgtable-64.h |   11 ++------
 arch/mips/mm/init.c                |    3 --
 arch/mips/mm/pgtable-64.c          |    3 --
 arch/mips/mm/tlbex.c               |   49 ------------------------------------
 4 files changed, 3 insertions(+), 63 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 4ed9d1b..9cd5089 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -109,13 +109,13 @@
 
 #define VMALLOC_START		MAP_BASE
 #define VMALLOC_END	\
-	(VMALLOC_START + PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)
+	(VMALLOC_START + \
+	 PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
 #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
 	VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
 #define MODULE_START	CKSSEG
 #define MODULE_END	(FIXADDR_START-2*PAGE_SIZE)
-extern pgd_t module_pg_dir[PTRS_PER_PGD];
 #endif
 
 #define pte_ERROR(e) \
@@ -188,12 +188,7 @@ static inline void pud_clear(pud_t *pudp)
 #define __pmd_offset(address)	pmd_index(address)
 
 /* to find an entry in a kernel page-table-directory */
-#ifdef MODULE_START
-#define pgd_offset_k(address) \
-	((address) >= MODULE_START ? module_pg_dir : pgd_offset(&init_mm, 0UL))
-#else
-#define pgd_offset_k(address) pgd_offset(&init_mm, 0UL)
-#endif
+#define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
 #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 0e82050..38c79c5 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -475,9 +475,6 @@ unsigned long pgd_current[NR_CPUS];
  */
 pgd_t swapper_pg_dir[_PTRS_PER_PGD] __page_aligned(_PGD_ORDER);
 #ifdef CONFIG_64BIT
-#ifdef MODULE_START
-pgd_t module_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
-#endif
 pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned(PMD_ORDER);
 #endif
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned(PTE_ORDER);
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index e4b565a..1121019 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -59,9 +59,6 @@ void __init pagetable_init(void)
 
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
-#ifdef MODULE_START
-	pgd_init((unsigned long)module_pg_dir);
-#endif
 	pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
 
 	pgd_base = swapper_pg_dir;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 9a17bf8..bc66f57 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -499,11 +499,7 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 	 * The vmalloc handling is not in the hotpath.
 	 */
 	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
-#ifdef MODULE_START
-	uasm_il_bltz(p, r, tmp, label_module_alloc);
-#else
 	uasm_il_bltz(p, r, tmp, label_vmalloc);
-#endif
 	/* No uasm_i_nop needed here, since the next insn doesn't touch TMP. */
 
 #ifdef CONFIG_SMP
@@ -556,52 +552,7 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 {
 	long swpd = (long)swapper_pg_dir;
 
-#ifdef MODULE_START
-	long modd = (long)module_pg_dir;
-
-	uasm_l_module_alloc(l, *p);
-	/*
-	 * Assumption:
-	 * VMALLOC_START >= 0xc000000000000000UL
-	 * MODULE_START >= 0xe000000000000000UL
-	 */
-	UASM_i_SLL(p, ptr, bvaddr, 2);
-	uasm_il_bgez(p, r, ptr, label_vmalloc);
-
-	if (uasm_in_compat_space_p(MODULE_START) &&
-	    !uasm_rel_lo(MODULE_START)) {
-		uasm_i_lui(p, ptr, uasm_rel_hi(MODULE_START)); /* delay slot */
-	} else {
-		/* unlikely configuration */
-		uasm_i_nop(p); /* delay slot */
-		UASM_i_LA(p, ptr, MODULE_START);
-	}
-	uasm_i_dsubu(p, bvaddr, bvaddr, ptr);
-
-	if (uasm_in_compat_space_p(modd) && !uasm_rel_lo(modd)) {
-		uasm_il_b(p, r, label_vmalloc_done);
-		uasm_i_lui(p, ptr, uasm_rel_hi(modd));
-	} else {
-		UASM_i_LA_mostly(p, ptr, modd);
-		uasm_il_b(p, r, label_vmalloc_done);
-		if (uasm_in_compat_space_p(modd))
-			uasm_i_addiu(p, ptr, ptr, uasm_rel_lo(modd));
-		else
-			uasm_i_daddiu(p, ptr, ptr, uasm_rel_lo(modd));
-	}
-
 	uasm_l_vmalloc(l, *p);
-	if (uasm_in_compat_space_p(MODULE_START) &&
-	    !uasm_rel_lo(MODULE_START) &&
-	    MODULE_START << 32 == VMALLOC_START)
-		uasm_i_dsll32(p, ptr, ptr, 0);	/* typical case */
-	else
-		UASM_i_LA(p, ptr, VMALLOC_START);
-#else
-	uasm_l_vmalloc(l, *p);
-	UASM_i_LA(p, ptr, VMALLOC_START);
-#endif
-	uasm_i_dsubu(p, bvaddr, bvaddr, ptr);
 
 	if (uasm_in_compat_space_p(swpd) && !uasm_rel_lo(swpd)) {
 		uasm_il_b(p, r, label_vmalloc_done);
-- 
1.6.4.rc1
