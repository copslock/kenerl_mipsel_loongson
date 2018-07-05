Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 07:26:16 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43393 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992936AbeGEF0IztVtK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2018 07:26:08 +0200
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B7BCFE0007;
        Thu,  5 Jul 2018 05:25:43 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v3 08/11] hugetlb: Introduce generic version of prepare_hugepage_range
Date:   Thu,  5 Jul 2018 05:16:37 +0000
Message-Id: <20180705051640.790-9-alex@ghiti.fr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180705051640.790-1-alex@ghiti.fr>
References: <20180705051640.790-1-alex@ghiti.fr>
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@ghiti.fr
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

arm, arm64, powerpc, sparc, x86 architectures use the same version of
prepare_hugepage_range, so move this generic implementation into
asm-generic/hugetlb.h.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/arm/include/asm/hugetlb.h     | 11 -----------
 arch/arm64/include/asm/hugetlb.h   | 11 -----------
 arch/ia64/include/asm/hugetlb.h    |  1 +
 arch/mips/include/asm/hugetlb.h    |  1 +
 arch/parisc/include/asm/hugetlb.h  |  1 +
 arch/powerpc/include/asm/hugetlb.h | 15 ---------------
 arch/sh/include/asm/hugetlb.h      |  1 +
 arch/sparc/include/asm/hugetlb.h   | 16 ----------------
 arch/x86/include/asm/hugetlb.h     | 15 ---------------
 include/asm-generic/hugetlb.h      | 15 +++++++++++++++
 10 files changed, 19 insertions(+), 68 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
index 1e718a626ef9..34fb401efe81 100644
--- a/arch/arm/include/asm/hugetlb.h
+++ b/arch/arm/include/asm/hugetlb.h
@@ -32,17 +32,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 	return 0;
 }
 
-static inline int prepare_hugepage_range(struct file *file,
-					 unsigned long addr, unsigned long len)
-{
-	struct hstate *h = hstate_file(file);
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (addr & ~huge_page_mask(h))
-		return -EINVAL;
-	return 0;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 	clear_bit(PG_dcache_clean, &page->flags);
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 1fd64ebf0cd7..3e7f6e69b28d 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -31,17 +31,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 	return 0;
 }
 
-static inline int prepare_hugepage_range(struct file *file,
-					 unsigned long addr, unsigned long len)
-{
-	struct hstate *h = hstate_file(file);
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (addr & ~huge_page_mask(h))
-		return -EINVAL;
-	return 0;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 	clear_bit(PG_dcache_clean, &page->flags);
diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
index 82fe3d7a38d9..cbe296271030 100644
--- a/arch/ia64/include/asm/hugetlb.h
+++ b/arch/ia64/include/asm/hugetlb.h
@@ -9,6 +9,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
 			    unsigned long ceiling);
 
+#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
 int prepare_hugepage_range(struct file *file,
 			unsigned long addr, unsigned long len);
 
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index b3d6bb53ee6e..6ff2531cfb1d 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -18,6 +18,7 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 	return 0;
 }
 
+#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
 static inline int prepare_hugepage_range(struct file *file,
 					 unsigned long addr,
 					 unsigned long len)
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index 5a102d7251e4..fb7e0fd858a3 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -22,6 +22,7 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
  * If the arch doesn't supply something else, assume that hugepage
  * size aligned regions are ok without further preparation.
  */
+#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
 static inline int prepare_hugepage_range(struct file *file,
 			unsigned long addr, unsigned long len)
 {
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 6f056dc44345..9fcb5fee2e33 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -117,21 +117,6 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
 			    unsigned long ceiling);
 
-/*
- * If the arch doesn't supply something else, assume that hugepage
- * size aligned regions are ok without further preparation.
- */
-static inline int prepare_hugepage_range(struct file *file,
-			unsigned long addr, unsigned long len)
-{
-	struct hstate *h = hstate_file(file);
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (addr & ~huge_page_mask(h))
-		return -EINVAL;
-	return 0;
-}
-
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 					    unsigned long addr, pte_t *ptep)
diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
index 54f65094efe6..f1bbd255ee43 100644
--- a/arch/sh/include/asm/hugetlb.h
+++ b/arch/sh/include/asm/hugetlb.h
@@ -15,6 +15,7 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
  * If the arch doesn't supply something else, assume that hugepage
  * size aligned regions are ok without further preparation.
  */
+#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
 static inline int prepare_hugepage_range(struct file *file,
 			unsigned long addr, unsigned long len)
 {
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index f661362376e0..2101ea217f33 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -26,22 +26,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 	return 0;
 }
 
-/*
- * If the arch doesn't supply something else, assume that hugepage
- * size aligned regions are ok without further preparation.
- */
-static inline int prepare_hugepage_range(struct file *file,
-			unsigned long addr, unsigned long len)
-{
-	struct hstate *h = hstate_file(file);
-
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (addr & ~huge_page_mask(h))
-		return -EINVAL;
-	return 0;
-}
-
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 					 unsigned long addr, pte_t *ptep)
diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index 19668672ab37..2e5117d37c7d 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -12,21 +12,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 	return 0;
 }
 
-/*
- * If the arch doesn't supply something else, assume that hugepage
- * size aligned regions are ok without further preparation.
- */
-static inline int prepare_hugepage_range(struct file *file,
-			unsigned long addr, unsigned long len)
-{
-	struct hstate *h = hstate_file(file);
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (addr & ~huge_page_mask(h))
-		return -EINVAL;
-	return 0;
-}
-
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index cd9697672b79..6c0c8b0c71e0 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -87,4 +87,19 @@ static inline pte_t huge_pte_wrprotect(pte_t pte)
 }
 #endif
 
+#ifndef __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
+static inline int prepare_hugepage_range(struct file *file,
+		unsigned long addr, unsigned long len)
+{
+	struct hstate *h = hstate_file(file);
+
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if (addr & ~huge_page_mask(h))
+		return -EINVAL;
+
+	return 0;
+}
+#endif
+
 #endif /* _ASM_GENERIC_HUGETLB_H */
-- 
2.16.2
