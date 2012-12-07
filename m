Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 12:52:31 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:56955 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823910Ab2LGLw3ySzrb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Dec 2012 12:52:29 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 07 Dec 2012 03:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,236,1355126400"; 
   d="scan'208";a="260440328"
Received: from blue.fi.intel.com ([10.237.72.156])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2012 03:52:18 -0800
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id D0A93E0073; Fri,  7 Dec 2012 13:53:42 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH, RESEND] asm-generic, mm: pgtable: consolidate zero page helpers
Date:   Fri,  7 Dec 2012 13:53:35 +0200
Message-Id: <1354881215-26257-1-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill.shutemov@linux.intel.com
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

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

We have two different implementation of is_zero_pfn() and
my_zero_pfn() helpers: for architectures with and without zero page
coloring.

Let's consolidate them in <asm-generic/pgtable.h>.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/mips/include/asm/pgtable.h |   11 +----------
 arch/s390/include/asm/pgtable.h |   11 +----------
 include/asm-generic/pgtable.h   |   26 ++++++++++++++++++++++++++
 include/linux/mm.h              |    8 --------
 mm/memory.c                     |    7 -------
 5 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 252202d..ec50d52 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -77,16 +77,7 @@ extern unsigned long zero_page_mask;
 
 #define ZERO_PAGE(vaddr) \
 	(virt_to_page((void *)(empty_zero_page + (((unsigned long)(vaddr)) & zero_page_mask))))
-
-#define is_zero_pfn is_zero_pfn
-static inline int is_zero_pfn(unsigned long pfn)
-{
-	extern unsigned long zero_pfn;
-	unsigned long offset_from_zero_pfn = pfn - zero_pfn;
-	return offset_from_zero_pfn <= (zero_page_mask >> PAGE_SHIFT);
-}
-
-#define my_zero_pfn(addr)	page_to_pfn(ZERO_PAGE(addr))
+#define __HAVE_COLOR_ZERO_PAGE
 
 extern void paging_init(void);
 
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 23d9a8a..c928dc1 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -54,16 +54,7 @@ extern unsigned long zero_page_mask;
 #define ZERO_PAGE(vaddr) \
 	(virt_to_page((void *)(empty_zero_page + \
 	 (((unsigned long)(vaddr)) &zero_page_mask))))
-
-#define is_zero_pfn is_zero_pfn
-static inline int is_zero_pfn(unsigned long pfn)
-{
-	extern unsigned long zero_pfn;
-	unsigned long offset_from_zero_pfn = pfn - zero_pfn;
-	return offset_from_zero_pfn <= (zero_page_mask >> PAGE_SHIFT);
-}
-
-#define my_zero_pfn(addr)	page_to_pfn(ZERO_PAGE(addr))
+#define __HAVE_COLOR_ZERO_PAGE
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index d03d0a8..04a398e 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -453,6 +453,32 @@ extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size);
 #endif
 
+#ifdef __HAVE_COLOR_ZERO_PAGE
+static inline int is_zero_pfn(unsigned long pfn)
+{
+	extern unsigned long zero_pfn;
+	unsigned long offset_from_zero_pfn = pfn - zero_pfn;
+	return offset_from_zero_pfn <= (zero_page_mask >> PAGE_SHIFT);
+}
+
+static inline unsigned long my_zero_pfn(unsigned long addr)
+{
+	return page_to_pfn(ZERO_PAGE(addr));
+}
+#else
+static inline int is_zero_pfn(unsigned long pfn)
+{
+	extern unsigned long zero_pfn;
+	return pfn == zero_pfn;
+}
+
+static inline unsigned long my_zero_pfn(unsigned long addr)
+{
+	extern unsigned long zero_pfn;
+	return zero_pfn;
+}
+#endif
+
 #ifdef CONFIG_MMU
 
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2984e07..dad5c73 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -516,14 +516,6 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 }
 #endif
 
-#ifndef my_zero_pfn
-static inline unsigned long my_zero_pfn(unsigned long addr)
-{
-	extern unsigned long zero_pfn;
-	return zero_pfn;
-}
-#endif
-
 /*
  * Multiple processes may "see" the same page. E.g. for untouched
  * mappings of /dev/null, all processes see the same page full of
diff --git a/mm/memory.c b/mm/memory.c
index 3db03ed..efd870d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -725,13 +725,6 @@ static inline bool is_cow_mapping(vm_flags_t flags)
 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 }
 
-#ifndef is_zero_pfn
-static inline int is_zero_pfn(unsigned long pfn)
-{
-	return pfn == zero_pfn;
-}
-#endif
-
 /*
  * vm_normal_page -- This function gets the "struct page" associated with a pte.
  *
-- 
1.7.10.4
