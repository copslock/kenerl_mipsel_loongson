Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Nov 2011 15:36:01 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:45790 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903658Ab1KZOfx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Nov 2011 15:35:53 +0100
Received: by wwo1 with SMTP id 1so6442746wwo.24
        for <multiple recipients>; Sat, 26 Nov 2011 06:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=rfsRKJGF8Rl8f7AImJvHM8a4NYs/953wFPlC3aC8tRk=;
        b=G+xyJfD7wYdnEj5KS3oUPr10mqiFBHreLSCuCxlw/3FnlhMo3i9YabZsIS/GbKl2c8
         fJfpPrizG3EPU1DB0GytFXTXZ2yGqCG3yPMXcWmQ8geyCLhsALIIYn9djBJrMs8/6W99
         DB2EU5ApVKYfrvBBccd/bbiQg+dU4SKlWwKXI=
MIME-Version: 1.0
Received: by 10.227.204.208 with SMTP id fn16mr1729251wbb.6.1322318147931;
 Sat, 26 Nov 2011 06:35:47 -0800 (PST)
Received: by 10.216.69.74 with HTTP; Sat, 26 Nov 2011 06:35:47 -0800 (PST)
Date:   Sat, 26 Nov 2011 22:35:47 +0800
Message-ID: <CAJd=RBAXc+QSX+xnJ2W9vVwK64Etrzrr=iBqPkJXNvYgwujQ_Q@mail.gmail.com>
Subject: [PATCH 1/3] MIPS: Add support for transparent huge page
From:   Hillf Danton <dhillf@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21852

This patchset adds THP support for MIPS.

Two page-table-entry bits, namely huge and splitting, are required by THP.
The huge bit is already defined and used for huge TLB, THP simply uses it.

For the splitting bit, the present bit is selected, since for regular pmd
entry pmd_present() is defined to be not directly related to the bit. If this
selection is not sane, this work as a whole is a mess. So selected then the
current work of huge TLB could also be used for THP, see next patch.

Other pmd mangling primitives are added in a straight manner, and they are
confined to a single file, asm/thp.h.


Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/include/asm/pgtable-bits.h	Thu Nov 24 21:16:22 2011
+++ b/arch/mips/include/asm/pgtable-bits.h	Sat Nov 26 20:49:31 2011
@@ -94,7 +94,7 @@
 /* set:pagecache unset:swap */
 #define _PAGE_FILE		(_PAGE_MODIFIED)

-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 /* huge tlb page */
 #define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
 #define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
--- a/arch/mips/include/asm/pgtable.h	Thu Nov 24 21:17:38 2011
+++ b/arch/mips/include/asm/pgtable.h	Sat Nov 26 20:50:52 2011
@@ -394,6 +394,9 @@ static inline int io_remap_pfn_range(str
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 #endif

+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#include <asm/thp.h>
+#endif
 #include <asm-generic/pgtable.h>

 /*
--- /dev/null	Sat Nov 26 21:04:52 2011
+++ b/arch/mips/include/asm/thp.h	Sat Nov 26 21:02:52 2011
@@ -0,0 +1,167 @@
+#ifndef _ASM_PGTABLE_THP_H
+#define _ASM_PGTABLE_THP_H
+/*
+ * pmd primitives for transparent huge page
+ *
+ * Copyright (C) 2011 David Daney
+ * Copyright (C) 2011 Andrea Arcangeli
+ * Copyright (C) 2011 Ralf Baechle
+ */
+
+#include <asm/tlbflush.h>
+
+#define _PAGE_SPLITTING  (_PAGE_PRESENT)
+
+static inline int has_transparent_hugepage(void)
+{
+	return 1;
+}
+
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_HUGE);
+}
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	pmd_val(pmd) |= _PAGE_HUGE;
+	return pmd;
+}
+
+static inline int pmd_trans_splitting(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_SPLITTING);
+}
+static inline pmd_t pmd_mksplitting(pmd_t pmd)
+{
+	pmd_val(pmd) |= _PAGE_SPLITTING;
+	return pmd;
+}
+
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+				pmd_t *pmdp, pmd_t pmd)
+{
+	*pmdp = pmd;
+}
+
+#define __HAVE_ARCH_PMDP_SPLITTING_FLUSH
+static inline void pmdp_splitting_flush(struct vm_area_struct *vma,
+					unsigned long address,
+					pmd_t *pmdp)
+{
+	if (!pmd_trans_splitting(*pmdp)) {
+		pmd_t pmd = pmd_mksplitting(*pmdp);
+		set_pmd_at(vma->vm_mm, address, pmdp, pmd);
+		flush_tlb_range(vma, address, address + HPAGE_SIZE);
+	}
+}
+
+#define __HAVE_ARCH_PMD_WRITE
+static inline int pmd_write(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_WRITE);
+}
+static inline pmd_t pmd_wrprotect(pmd_t pmd)
+{
+	pmd_val(pmd) &= ~(_PAGE_WRITE | _PAGE_SILENT_WRITE);
+	return pmd;
+}
+static inline pmd_t pmd_mkwrite(pmd_t pmd)
+{
+	pmd_val(pmd) |= _PAGE_WRITE;
+	if (pmd_val(pmd) & _PAGE_MODIFIED)
+		pmd_val(pmd) |= _PAGE_SILENT_WRITE;
+
+	return pmd;
+}
+
+static inline int pmd_dirty(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_MODIFIED);
+}
+static inline pmd_t pmd_mkclean(pmd_t pmd)
+{
+	pmd_val(pmd) &= ~(_PAGE_MODIFIED | _PAGE_SILENT_WRITE);
+	return pmd;
+}
+static inline pmd_t pmd_mkdirty(pmd_t pmd)
+{
+	pmd_val(pmd) |= _PAGE_MODIFIED;
+	if (pmd_val(pmd) & _PAGE_WRITE)
+		pmd_val(pmd) |= _PAGE_SILENT_WRITE;
+
+	return pmd;
+}
+
+static inline int pmd_young(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_ACCESSED);
+}
+static inline pmd_t pmd_mkold(pmd_t pmd)
+{
+	pmd_val(pmd) &= ~_PAGE_ACCESSED;
+	return pmd;
+}
+static inline pmd_t pmd_mkyoung(pmd_t pmd)
+{
+	pmd_val(pmd) |= _PAGE_ACCESSED;
+	return pmd;
+}
+
+static inline pmd_t mk_pmd(struct page *page, pgprot_t prot)
+{
+	pmd_t pmd;
+
+	pmd_val(pmd) = (page_to_pfn(page) << _PFN_SHIFT) | pgprot_val(prot);
+	/*
+	 * note, new THP pmd entry is not splitting
+	 */
+	pmd_val(pmd) &= ~_PAGE_PRESENT;
+
+	return pmd;
+}
+
+#define __HAVE_ARCH_THP_PMD_PAGE
+static inline struct page *thp_pmd_page(pmd_t pmd)
+{
+	struct page *page = NULL;
+
+	if (pmd_trans_huge(pmd)) {
+		unsigned long pfn = pmd_val(pmd) >> _PFN_SHIFT;
+		page = pfn_to_page(pfn);
+	} else {
+		page = pmd_page(pmd);
+	}
+	return page;
+}
+
+static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
+{
+	pmd_val(pmd) = (pmd_val(pmd) & _PAGE_CHG_MASK) | pgprot_val(newprot);
+	return pmd;
+}
+
+static inline pmd_t pmd_mknotpresent(pmd_t pmd)
+{
+	pmd_clear(&pmd);
+	return pmd;
+}
+
+#define __HAVE_ARCH_PMDP_GET_AND_CLEAR
+static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
+					unsigned long address, pmd_t *pmdp)
+{
+	pmd_t old = *pmdp;
+
+	pmd_clear(pmdp);
+	return old;
+}
+
+#define __HAVE_ARCH_UPDATE_MMU_THP
+static inline void update_mmu_thp(struct vm_area_struct *vma,
+					unsigned long addr, pmd_t *pmdp)
+{
+	update_mmu_cache(vma, addr, (pte_t *)pmdp);
+}
+
+#endif /* _ASM_PGTABLE_THP_H */
+
