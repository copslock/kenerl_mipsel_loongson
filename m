Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 01:49:32 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11633 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021953AbZE1AtY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 01:49:24 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a1ddf6f0000>; Wed, 27 May 2009 20:48:47 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:48:56 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:48:56 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4S0mHpv027943;
	Wed, 27 May 2009 17:48:18 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4S0lk6S027938;
	Wed, 27 May 2009 17:47:46 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	wli@holomorphy.com, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/5] MIPS: Add support files for hugeTLBfs.
Date:	Wed, 27 May 2009 17:47:42 -0700
Message-Id: <1243471666-27915-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A1DDED7.3020306@caviumnetworks.com>
References: <4A1DDED7.3020306@caviumnetworks.com>
X-OriginalArrivalTime: 28 May 2009 00:48:56.0284 (UTC) FILETIME=[1489E1C0:01C9DF2E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/hugetlb.h |  114 +++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/Makefile           |    1 +
 arch/mips/mm/hugetlbpage.c      |  101 ++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/hugetlb.h
 create mode 100644 arch/mips/mm/hugetlbpage.c

diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
new file mode 100644
index 0000000..f5e8560
--- /dev/null
+++ b/arch/mips/include/asm/hugetlb.h
@@ -0,0 +1,114 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008, 2009 Cavium Networks, Inc.
+ */
+
+#ifndef __ASM_HUGETLB_H
+#define __ASM_HUGETLB_H
+
+#include <asm/page.h>
+
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					 unsigned long addr,
+					 unsigned long len)
+{
+	return 0;
+}
+
+static inline int prepare_hugepage_range(struct file *file,
+					 unsigned long addr,
+					 unsigned long len)
+{
+	unsigned long task_size = STACK_TOP;
+	struct hstate *h = hstate_file(file);
+
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if (addr & ~huge_page_mask(h))
+		return -EINVAL;
+	if (len > task_size)
+		return -ENOMEM;
+	if (task_size - len < addr)
+		return -EINVAL;
+	return 0;
+}
+
+static inline void hugetlb_prefault_arch_hook(struct mm_struct *mm)
+{
+}
+
+static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
+					  unsigned long addr,
+					  unsigned long end,
+					  unsigned long floor,
+					  unsigned long ceiling)
+{
+	free_pgd_range(tlb, addr, end, floor, ceiling);
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	set_pte_at(mm, addr, ptep, pte);
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	pte_t clear;
+	pte_t pte = *ptep;
+
+	pte_val(clear) = (unsigned long)invalid_pte_table;
+	set_pte_at(mm, addr, ptep, clear);
+	return pte;
+}
+
+static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep)
+{
+}
+
+static inline int huge_pte_none(pte_t pte)
+{
+	unsigned long val = pte_val(pte) & ~_PAGE_GLOBAL;
+	return !val || (val == (unsigned long)invalid_pte_table);
+}
+
+static inline pte_t huge_pte_wrprotect(pte_t pte)
+{
+	return pte_wrprotect(pte);
+}
+
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	ptep_set_wrprotect(mm, addr, ptep);
+}
+
+static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+					     unsigned long addr,
+					     pte_t *ptep, pte_t pte,
+					     int dirty)
+{
+	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+}
+
+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+	return *ptep;
+}
+
+static inline int arch_prepare_hugepage(struct page *page)
+{
+	return 0;
+}
+
+static inline void arch_release_hugepage(struct page *page)
+{
+}
+
+#endif /* __ASM_HUGETLB_H */
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index d7ec955..f0e4355 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -8,6 +8,7 @@ obj-y				+= cache.o dma-default.o extable.o fault.o \
 obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
+obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 
 obj-$(CONFIG_CPU_LOONGSON2)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_MIPS32)	+= c-r4k.o cex-gen.o tlb-r4k.o
diff --git a/arch/mips/mm/hugetlbpage.c b/arch/mips/mm/hugetlbpage.c
new file mode 100644
index 0000000..471c09a
--- /dev/null
+++ b/arch/mips/mm/hugetlbpage.c
@@ -0,0 +1,101 @@
+/*
+ * MIPS Huge TLB Page Support for Kernel.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
+ * Copyright 2005, Embedded Alley Solutions, Inc.
+ * Matt Porter <mporter@embeddedalley.com>
+ * Copyright (C) 2008, 2009 Cavium Networks, Inc.
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <linux/pagemap.h>
+#include <linux/smp_lock.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/sysctl.h>
+#include <asm/mman.h>
+#include <asm/tlb.h>
+#include <asm/tlbflush.h>
+
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr,
+		      unsigned long sz)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pte_t *pte = NULL;
+
+	pgd = pgd_offset(mm, addr);
+	pud = pud_alloc(mm, pgd, addr);
+	if (pud)
+		pte = (pte_t *)pmd_alloc(mm, pud, addr);
+
+	return pte;
+}
+
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd = NULL;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_present(*pgd)) {
+		pud = pud_offset(pgd, addr);
+		if (pud_present(*pud))
+			pmd = pmd_offset(pud, addr);
+	}
+	return (pte_t *) pmd;
+}
+
+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
+{
+	return 0;
+}
+
+/*
+ * This function checks for proper alignment of input addr and len parameters.
+ */
+int is_aligned_hugepage_range(unsigned long addr, unsigned long len)
+{
+	if (len & ~HPAGE_MASK)
+		return -EINVAL;
+	if (addr & ~HPAGE_MASK)
+		return -EINVAL;
+	return 0;
+}
+
+struct page *
+follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+int pmd_huge(pmd_t pmd)
+{
+	return (pmd_val(pmd) & _PAGE_HUGE) != 0;
+}
+
+int pud_huge(pud_t pud)
+{
+	return (pud_val(pud) & _PAGE_HUGE) != 0;
+}
+
+struct page *
+follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+		pmd_t *pmd, int write)
+{
+	struct page *page;
+
+	page = pte_page(*(pte_t *)pmd);
+	if (page)
+		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
+	return page;
+}
+
-- 
1.6.0.6
