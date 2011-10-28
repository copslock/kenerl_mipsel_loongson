Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2011 15:26:35 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:53065 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903620Ab1J1N02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Oct 2011 15:26:28 +0200
Received: by wwf10 with SMTP id 10so4856406wwf.24
        for <multiple recipients>; Fri, 28 Oct 2011 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=NiFwQv3+nfrklK/3MQEJKAuxNe2CY6dUyj2ExHKq+kA=;
        b=fFQra/irgCqcKngc/q8tS1wR7qZ1K1A5zMywyh2t1hML1GmEV65CkopNhUhWCe7Q8T
         yOXWoPnZnQHpXPg4klBscNUsQvSvXUknzzxAr2f1MP9rMiezXpb7TU7paa3nfhZUSYUt
         QYncEMDW4V7xjnHuNawc544TuT28ieBOQmeic=
MIME-Version: 1.0
Received: by 10.216.139.170 with SMTP id c42mr981530wej.0.1319808383472; Fri,
 28 Oct 2011 06:26:23 -0700 (PDT)
Received: by 10.216.167.138 with HTTP; Fri, 28 Oct 2011 06:26:23 -0700 (PDT)
Date:   Fri, 28 Oct 2011 21:26:23 +0800
Message-ID: <CAJd=RBC=_+qAnbTaYXgTOoiVdfgppRt-rBs4cnKoZKxHD14nuw@mail.gmail.com>
Subject: [PATCH] MIPS: Add fast get_user_pages
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20588

Gup is used in a few cases, say futex.

This work is derived from the x86 version, and operations of pte and pmd are
adapted to the defines of MIPS in straight forward manner.

As always all comments and ideas welcome.

Thanks

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/mm/Makefile	Fri Oct 28 21:10:01 2011
+++ b/arch/mips/mm/Makefile	Fri Oct 28 21:09:19 2011
@@ -4,7 +4,7 @@

 obj-y			+= cache.o dma-default.o extable.o fault.o \
 			   init.o mmap.o tlbex.o tlbex-fault.o uasm.o \
-			   page.o
+			   page.o gup.o

 obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
--- /dev/null	Fri Oct 28 21:12:42 2011
+++ b/arch/mips/mm/gup.c	Fri Oct 28 21:07:06 2011
@@ -0,0 +1,321 @@
+/*
+ * Lockless get_user_pages_fast for MIPS
+ *
+ * Copyright (C) 2008 Nick Piggin
+ * Copyright (C) 2008 Novell Inc.
+ * Copyright (C) 2011 Ralf Baechle
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/vmstat.h>
+#include <linux/highmem.h>
+#include <linux/swap.h>
+#include <linux/hugetlb.h>
+
+#include <asm/pgtable.h>
+
+static inline pte_t gup_get_pte(pte_t *ptep)
+{
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+	pte_t pte;
+
+retry:
+	pte.pte_low = ptep->pte_low;
+	smp_rmb();
+	pte.pte_high = ptep->pte_high;
+	smp_rmb();
+	if (unlikely(pte.pte_low != ptep->pte_low))
+		goto retry;
+
+	return pte;
+#else
+	return ACCESS_ONCE(*ptep);
+#endif
+}
+
+static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
+			int write, struct page **pages, int *nr)
+{
+	pte_t *ptep = pte_offset_map(&pmd, addr);
+	do {
+		pte_t pte = gup_get_pte(ptep);
+		struct page *page;
+
+		if (!pte_present(pte) ||
+		    pte_special(pte) || (write && !pte_write(pte))) {
+			pte_unmap(ptep);
+			return 0;
+		}
+		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+		page = pte_page(pte);
+		get_page(page);
+		SetPageReferenced(page);
+		pages[*nr] = page;
+		(*nr)++;
+
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
+
+	pte_unmap(ptep - 1);
+	return 1;
+}
+
+static inline void get_head_page_multiple(struct page *page, int nr)
+{
+	VM_BUG_ON(page != compound_head(page));
+	VM_BUG_ON(page_count(page) == 0);
+	atomic_add(nr, &page->_count);
+	SetPageReferenced(page);
+}
+
+static inline void get_huge_page_tail(struct page *page)
+{
+	VM_BUG_ON(atomic_read(&page->_count) < 0);
+	atomic_inc(&page->_count);
+}
+
+static int gup_huge_pmd(pmd_t pmd, unsigned long addr, unsigned long end,
+			int write, struct page **pages, int *nr)
+{
+	pte_t pte = *(pte_t *)&pmd;
+	struct page *head, *page;
+	int refs;
+
+	if (write && !pte_write(pte))
+		return 0;
+	/* hugepages are never "special" */
+	VM_BUG_ON(pte_special(pte));
+	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+
+	refs = 0;
+	head = pte_page(pte);
+	page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	do {
+		VM_BUG_ON(compound_head(page) != head);
+		pages[*nr] = page;
+		if (PageTail(page))
+			get_huge_page_tail(page);
+		(*nr)++;
+		page++;
+		refs++;
+	} while (addr += PAGE_SIZE, addr != end);
+
+	get_head_page_multiple(head, refs);
+	return 1;
+}
+
+static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
+			int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	pmd_t *pmdp;
+
+	pmdp = pmd_offset(&pud, addr);
+	do {
+		pmd_t pmd = *pmdp;
+
+		next = pmd_addr_end(addr, end);
+		/*
+		 * The pmd_trans_splitting() check below explains why
+		 * pmdp_splitting_flush has to flush the tlb, to stop
+		 * this gup-fast code from running while we set the
+		 * splitting bit in the pmd. Returning zero will take
+		 * the slow path that will call wait_split_huge_page()
+		 * if the pmd is still in splitting state. gup-fast
+		 * can't because it has irq disabled and
+		 * wait_split_huge_page() would never return as the
+		 * tlb flush IPI wouldn't run.
+		 */
+		if (pmd_none(pmd) || pmd_trans_splitting(pmd))
+			return 0;
+		if (unlikely(pmd_huge(pmd))) {
+			if (!gup_huge_pmd(pmd, addr, next, write, pages,nr))
+				return 0;
+		} else {
+			if (!gup_pte_range(pmd, addr, next, write, pages,nr))
+				return 0;
+		}
+	} while (pmdp++, addr = next, addr != end);
+
+	return 1;
+}
+
+static int gup_huge_pud(pud_t pud, unsigned long addr, unsigned long end,
+			int write, struct page **pages, int *nr)
+{
+	pte_t pte = *(pte_t *)&pud;
+	struct page *head, *page;
+	int refs;
+
+	if (write && !pte_write(pte))
+		return 0;
+	/* hugepages are never "special" */
+	VM_BUG_ON(pte_special(pte));
+	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+
+	refs = 0;
+	head = pte_page(pte);
+	page = head + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	do {
+		VM_BUG_ON(compound_head(page) != head);
+		pages[*nr] = page;
+		(*nr)++;
+		page++;
+		refs++;
+	} while (addr += PAGE_SIZE, addr != end);
+
+	get_head_page_multiple(head, refs);
+	return 1;
+}
+
+static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
+			int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	pud_t *pudp;
+
+	pudp = pud_offset(&pgd, addr);
+	do {
+		pud_t pud = *pudp;
+
+		next = pud_addr_end(addr, end);
+		if (pud_none(pud))
+			return 0;
+		if (unlikely(pud_huge(pud))) {
+			if (!gup_huge_pud(pud, addr, next, write, pages,nr))
+				return 0;
+		} else {
+			if (!gup_pmd_range(pud, addr, next, write, pages,nr))
+				return 0;
+		}
+	} while (pudp++, addr = next, addr != end);
+
+	return 1;
+}
+
+/*
+ * Like get_user_pages_fast() except its IRQ-safe in that it won't fall
+ * back to the regular GUP.
+ */
+int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			  struct page **pages)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long addr, len, end;
+	unsigned long next;
+	unsigned long flags;
+	pgd_t *pgdp;
+	int nr = 0;
+
+	start &= PAGE_MASK;
+	addr = start;
+	len = (unsigned long) nr_pages << PAGE_SHIFT;
+	end = start + len;
+	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
+					(void __user *)start, len)))
+		return 0;
+
+	/*
+	 * XXX: batch / limit 'nr', to avoid large irq off latency
+	 * needs some instrumenting to determine the common sizes used by
+	 * important workloads (eg. DB2), and whether limiting the batch
+	 * size will decrease performance.
+	 *
+	 * It seems like we're in the clear for the moment. Direct-IO is
+	 * the main guy that batches up lots of get_user_pages, and even
+	 * they are limited to 64-at-a-time which is not so many.
+	 */
+	/*
+	 * This doesn't prevent pagetable teardown, but does prevent
+	 * the pagetables and pages from being freed.
+	 *
+	 * So long as we atomically load page table pointers versus teardown,
+	 * we can follow the address down to the page and take a ref on it.
+	 */
+	local_irq_save(flags);
+	pgdp = pgd_offset(mm, addr);
+	do {
+		pgd_t pgd = *pgdp;
+
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(pgd))
+			break;
+		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+			break;
+	} while (pgdp++, addr = next, addr != end);
+	local_irq_restore(flags);
+
+	return nr;
+}
+
+/**
+ * get_user_pages_fast() - pin user pages in memory
+ * @start:	starting user address
+ * @nr_pages:	number of pages from start to pin
+ * @write:	whether pages will be written to
+ * @pages:	array that receives pointers to the pages pinned.
+ * 		Should be at least nr_pages long.
+ *
+ * Attempt to pin user pages in memory without taking mm->mmap_sem.
+ * If not successful, it will fall back to taking the lock and
+ * calling get_user_pages().
+ *
+ * Returns number of pages pinned. This may be fewer than the number
+ * requested. If nr_pages is 0 or negative, returns 0. If no pages
+ * were pinned, returns -errno.
+ */
+int get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			struct page **pages)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long addr, len, end;
+	unsigned long next;
+	pgd_t *pgdp;
+	int ret, nr = 0;
+
+	start &= PAGE_MASK;
+	addr = start;
+	len = (unsigned long) nr_pages << PAGE_SHIFT;
+
+	end = start + len;
+	if (end < start)
+		goto slow_irqon;
+
+	/* XXX: batch / limit 'nr' */
+	local_irq_disable();
+	pgdp = pgd_offset(mm, addr);
+	do {
+		pgd_t pgd = *pgdp;
+
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(pgd))
+			goto slow;
+		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+			goto slow;
+	} while (pgdp++, addr = next, addr != end);
+	local_irq_enable();
+
+	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
+	return nr;
+slow:
+	local_irq_enable();
+
+slow_irqon:
+	/* Try to get the remaining pages with get_user_pages */
+	start += nr << PAGE_SHIFT;
+	pages += nr;
+
+	down_read(&mm->mmap_sem);
+	ret = get_user_pages(current, mm, start,
+				(end - start) >> PAGE_SHIFT,
+				write, 0, pages, NULL);
+	up_read(&mm->mmap_sem);
+
+	/* Have to be a bit careful with return values */
+	if (nr > 0) {
+		if (ret < 0)
+			ret = nr;
+		else
+			ret += nr;
+	}
+	return ret;
+}
