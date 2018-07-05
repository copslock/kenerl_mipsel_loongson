Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 07:13:54 +0200 (CEST)
Received: from relay10.mail.gandi.net ([217.70.178.230]:46683 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992442AbeGEFNhqRUw0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2018 07:13:37 +0200
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 87A60240009;
        Thu,  5 Jul 2018 05:13:12 +0000 (UTC)
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
Subject: [PATCH v2 02/11] hugetlb: Introduce generic version of hugetlb_free_pgd_range
Date:   Thu,  5 Jul 2018 05:12:33 +0000
Message-Id: <20180705051242.694-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180705051242.694-1-alex@ghiti.fr>
References: <20180705050323.301-1-alex@ghiti.fr>
 <20180705051242.694-1-alex@ghiti.fr>
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64631
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

arm, arm64, mips, parisc, sh, x86 architectures use the
same version of hugetlb_free_pgd_range, so move this generic
implementation into asm-generic/hugetlb.h.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/arm/include/asm/hugetlb.h     | 12 ++----------
 arch/arm64/include/asm/hugetlb.h   | 10 ----------
 arch/ia64/include/asm/hugetlb.h    |  5 +++--
 arch/mips/include/asm/hugetlb.h    | 13 ++-----------
 arch/parisc/include/asm/hugetlb.h  | 12 ++----------
 arch/powerpc/include/asm/hugetlb.h |  4 +++-
 arch/sh/include/asm/hugetlb.h      | 12 ++----------
 arch/sparc/include/asm/hugetlb.h   |  4 +++-
 arch/x86/include/asm/hugetlb.h     | 11 ++---------
 include/asm-generic/hugetlb.h      | 11 +++++++++++
 10 files changed, 30 insertions(+), 64 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
index 7d26f6c4f0f5..047b893ef95d 100644
--- a/arch/arm/include/asm/hugetlb.h
+++ b/arch/arm/include/asm/hugetlb.h
@@ -23,19 +23,9 @@
 #define _ASM_ARM_HUGETLB_H
 
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
 
 #include <asm/hugetlb-3level.h>
 
-static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-					  unsigned long addr, unsigned long end,
-					  unsigned long floor,
-					  unsigned long ceiling)
-{
-	free_pgd_range(tlb, addr, end, floor, ceiling);
-}
-
-
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr, unsigned long len)
 {
@@ -68,4 +58,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 	clear_bit(PG_dcache_clean, &page->flags);
 }
 
+#include <asm-generic/hugetlb.h>
+
 #endif /* _ASM_ARM_HUGETLB_H */
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 3fcf14663dfa..4af1a800a900 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -25,16 +25,6 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
 	return READ_ONCE(*ptep);
 }
 
-
-
-static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-					  unsigned long addr, unsigned long end,
-					  unsigned long floor,
-					  unsigned long ceiling)
-{
-	free_pgd_range(tlb, addr, end, floor, ceiling);
-}
-
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr, unsigned long len)
 {
diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
index 74d2a5540aaf..afe9fa4d969b 100644
--- a/arch/ia64/include/asm/hugetlb.h
+++ b/arch/ia64/include/asm/hugetlb.h
@@ -3,9 +3,8 @@
 #define _ASM_IA64_HUGETLB_H
 
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
-
 
+#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
 			    unsigned long ceiling);
@@ -70,4 +69,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
 
+#include <asm-generic/hugetlb.h>
+
 #endif /* _ASM_IA64_HUGETLB_H */
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index 982bc0685330..53764050243e 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -10,8 +10,6 @@
 #define __ASM_HUGETLB_H
 
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
-
 
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr,
@@ -38,15 +36,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-					  unsigned long addr,
-					  unsigned long end,
-					  unsigned long floor,
-					  unsigned long ceiling)
-{
-	free_pgd_range(tlb, addr, end, floor, ceiling);
-}
-
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, pte_t pte)
 {
@@ -114,4 +103,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
 
+#include <asm-generic/hugetlb.h>
+
 #endif /* __ASM_HUGETLB_H */
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index 58e0f4620426..28c23b68d38d 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -3,8 +3,6 @@
 #define _ASM_PARISC64_HUGETLB_H
 
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
-
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
@@ -32,14 +30,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-					  unsigned long addr, unsigned long end,
-					  unsigned long floor,
-					  unsigned long ceiling)
-{
-	free_pgd_range(tlb, addr, end, floor, ceiling);
-}
-
 static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 					 unsigned long addr, pte_t *ptep)
 {
@@ -71,4 +61,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
 
+#include <asm-generic/hugetlb.h>
+
 #endif /* _ASM_PARISC64_HUGETLB_H */
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 3225eb6402cc..de46ee16b615 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -4,7 +4,6 @@
 
 #ifdef CONFIG_HUGETLB_PAGE
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
 
 extern struct kmem_cache *hugepte_cache;
 
@@ -113,6 +112,7 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 #endif
 
+#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
 			    unsigned long ceiling);
@@ -193,4 +193,6 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
+#include <asm-generic/hugetlb.h>
+
 #endif /* _ASM_POWERPC_HUGETLB_H */
diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
index 735939c0f513..f6a51b609409 100644
--- a/arch/sh/include/asm/hugetlb.h
+++ b/arch/sh/include/asm/hugetlb.h
@@ -4,8 +4,6 @@
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
-
 
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr,
@@ -27,14 +25,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-					  unsigned long addr, unsigned long end,
-					  unsigned long floor,
-					  unsigned long ceiling)
-{
-	free_pgd_range(tlb, addr, end, floor, ceiling);
-}
-
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, pte_t pte)
 {
@@ -85,4 +75,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 	clear_bit(PG_dcache_clean, &page->flags);
 }
 
+#include <asm-generic/hugetlb.h>
+
 #endif /* _ASM_SH_HUGETLB_H */
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 300557c66698..59d89b52ccb7 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -3,7 +3,6 @@
 #define _ASM_SPARC64_HUGETLB_H
 
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
 
 #ifdef CONFIG_HUGETLB_PAGE
 struct pud_huge_patch_entry {
@@ -84,8 +83,11 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
 
+#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
 			    unsigned long ceiling);
 
+#include <asm-generic/hugetlb.h>
+
 #endif /* _ASM_SPARC64_HUGETLB_H */
diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index 5ed826da5e07..996ce8e15365 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -3,7 +3,6 @@
 #define _ASM_X86_HUGETLB_H
 
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
 
 #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
 
@@ -28,14 +27,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-					  unsigned long addr, unsigned long end,
-					  unsigned long floor,
-					  unsigned long ceiling)
-{
-	free_pgd_range(tlb, addr, end, floor, ceiling);
-}
-
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, pte_t pte)
 {
@@ -90,4 +81,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 static inline bool gigantic_page_supported(void) { return true; }
 #endif
 
+#include <asm-generic/hugetlb.h>
+
 #endif /* _ASM_X86_HUGETLB_H */
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 3da7cff52360..c697ca9dda18 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -40,4 +40,15 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 }
 #endif
 
+#ifndef __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
+static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
+		unsigned long addr, unsigned long end,
+		unsigned long floor, unsigned long ceiling)
+{
+	free_pgd_range(tlb, addr, end, floor, ceiling);
+}
+
+
+#endif
+
 #endif /* _ASM_GENERIC_HUGETLB_H */
-- 
2.16.2
