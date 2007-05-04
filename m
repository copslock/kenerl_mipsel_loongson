Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2007 11:55:47 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.185]:52069 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021957AbXEDKzo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 May 2007 11:55:44 +0100
Received: by mu-out-0910.google.com with SMTP id w1so826293mue
        for <linux-mips@linux-mips.org>; Fri, 04 May 2007 03:55:43 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=elSDFqR2Goe8FR09bC6K+DOFvO/jzF9KTNNSu+++GRePEJ/XgOCG+rhq7V67ZCmgmSI3hlbdYu3ovV/CO/MwX6FSBr8lbx7U49FnjaJBOmgIt5CrBs+VEomwreGJl4B2D8U7j4bIEWphJzr0HLWbrIsPXOd2wjqFEFAO30TpDCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=tgYZv+iW72H37+47bwjY/gjzrXOA4E4kYfCrWUX/ZteEEs3eg+u1Zk1mo/UiBc7KkvjLsyUsVZj4BJFW+J3vjxa0WJG/omRlFnCWrqrD/maw1OQx35Q/Yg2KqXKvWBufIUOk8fx8jZRLsgbjMX6JUlt3GUpq3EIU9+QKeWgtYQQ=
Received: by 10.82.184.2 with SMTP id h2mr6169759buf.1178276141988;
        Fri, 04 May 2007 03:55:41 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id c24sm377310ika.2007.05.04.03.55.35;
        Fri, 04 May 2007 03:55:38 -0700 (PDT)
Message-ID: <463B117F.1070009@innova-card.com>
Date:	Fri, 04 May 2007 12:57:03 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Simplify pte_offset_{map,map_nested}() on 32 bits [try #2]
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Since both kernel and process page tables are never allocated in
highmem these 2 macros were doing unnecessary extra works for getting
a pte from a pmd.

This patch also clean up pte allocation functions by passing
__GFP_ZERO to alloc_pages() and by removing a useless local variable.

With this patch the size of the kernel is slighly reduced.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Hi Ralf,

 Maybe I'm missing something but it seems that page tables are
 never allocated from highmem. Please correct me if I'm wrong.
 This patch boot fine on a 32-bits platform without highmem
 though.

 This patch does not include any modifications for 64-bits
 platforms since I can't test them but this assertion
 should be more true since there's no highmem on these
 platforms. I can make another patch for such platforms if
 you think it makes sense.

 Please consider,

		Franck

 include/asm-mips/pgalloc.h    |   22 ++++++----------------
 include/asm-mips/pgtable-32.h |   13 +++++--------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/include/asm-mips/pgalloc.h b/include/asm-mips/pgalloc.h
index 5685d4f..a3b9953 100644
--- a/include/asm-mips/pgalloc.h
+++ b/include/asm-mips/pgalloc.h
@@ -62,26 +62,16 @@ static inline void pgd_free(pgd_t *pgd)
 	free_pages((unsigned long)pgd, PGD_ORDER);
 }
 
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-	unsigned long address)
+static inline pte_t *
+pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte;
-
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, PTE_ORDER);
-
-	return pte;
+	return (pte_t *)__get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, PTE_ORDER);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-	unsigned long address)
+static inline struct page *
+pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	struct page *pte;
-
-	pte = alloc_pages(GFP_KERNEL | __GFP_REPEAT, PTE_ORDER);
-	if (pte)
-		clear_highpage(pte);
-
-	return pte;
+	return alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, PTE_ORDER);
 }
 
 static inline void pte_free_kernel(pte_t *pte)
diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 2fbd47e..9e0a8c7 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -143,6 +143,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #define __pgd_offset(address)	pgd_index(address)
 #define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 #define __pmd_offset(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+#define __pte_offset(address)	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
@@ -153,19 +154,15 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #define pgd_offset(mm,addr)	((mm)->pgd + pgd_index(addr))
 
 /* Find an entry in the third-level page table.. */
-#define __pte_offset(address)						\
-	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset(dir, address)					\
 	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 #define pte_offset_kernel(dir, address)					\
 	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 
-#define pte_offset_map(dir, address)                                    \
-	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
-#define pte_offset_map_nested(dir, address)                             \
-	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
-#define pte_unmap(pte) ((void)(pte))
-#define pte_unmap_nested(pte) ((void)(pte))
+#define pte_offset_map(dir, address)		pte_offset_kernel(dir,address)
+#define pte_offset_map_nested(dir, address)	pte_offset_kernel(dir,address)
+#define pte_unmap(pte)				((void)(pte))
+#define pte_unmap_nested(pte)			((void)(pte))
 
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
-- 
1.5.1.3
