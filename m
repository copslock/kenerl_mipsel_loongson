Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 13:20:53 +0200 (CEST)
Received: from relay11.mail.gandi.net ([217.70.178.231]:44911 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994659AbeGELUpvwKG9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2018 13:20:45 +0200
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 93947100003;
        Thu,  5 Jul 2018 11:20:14 +0000 (UTC)
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
Subject: [PATCH v4 11/11] hugetlb: Introduce generic version of huge_ptep_get
Date:   Thu,  5 Jul 2018 11:07:16 +0000
Message-Id: <20180705110716.3919-12-alex@ghiti.fr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180705110716.3919-1-alex@ghiti.fr>
References: <20180705110716.3919-1-alex@ghiti.fr>
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64695
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

ia64, mips, parisc, powerpc, sh, sparc, x86 architectures use the
same version of huge_ptep_get, so move this generic implementation into
asm-generic/hugetlb.h.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/arm/include/asm/hugetlb-3level.h | 1 +
 arch/arm64/include/asm/hugetlb.h      | 1 +
 arch/ia64/include/asm/hugetlb.h       | 5 -----
 arch/mips/include/asm/hugetlb.h       | 5 -----
 arch/parisc/include/asm/hugetlb.h     | 5 -----
 arch/powerpc/include/asm/hugetlb.h    | 5 -----
 arch/sh/include/asm/hugetlb.h         | 5 -----
 arch/sparc/include/asm/hugetlb.h      | 5 -----
 arch/x86/include/asm/hugetlb.h        | 5 -----
 include/asm-generic/hugetlb.h         | 7 +++++++
 10 files changed, 9 insertions(+), 35 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
index 54e4b097b1f5..0d9f3918fa7e 100644
--- a/arch/arm/include/asm/hugetlb-3level.h
+++ b/arch/arm/include/asm/hugetlb-3level.h
@@ -29,6 +29,7 @@
  * ptes.
  * (The valid bit is automatically cleared by set_pte_at for PROT_NONE ptes).
  */
+#define __HAVE_ARCH_HUGE_PTEP_GET
 static inline pte_t huge_ptep_get(pte_t *ptep)
 {
 	pte_t retval = *ptep;
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 80887abcef7f..fb6609875455 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -20,6 +20,7 @@
 
 #include <asm/page.h>
 
+#define __HAVE_ARCH_HUGE_PTEP_GET
 static inline pte_t huge_ptep_get(pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
index e9b42750fdf5..36cc0396b214 100644
--- a/arch/ia64/include/asm/hugetlb.h
+++ b/arch/ia64/include/asm/hugetlb.h
@@ -27,11 +27,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline pte_t huge_ptep_get(pte_t *ptep)
-{
-	return *ptep;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index 120adc3b2ffd..425bb6fc3bda 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -82,11 +82,6 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	return changed;
 }
 
-static inline pte_t huge_ptep_get(pte_t *ptep)
-{
-	return *ptep;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index 165b4e5a6f32..7cb595dcb7d7 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -48,11 +48,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty);
 
-static inline pte_t huge_ptep_get(pte_t *ptep)
-{
-	return *ptep;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 658bf7136a3c..33a2d9e3ea9e 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -142,11 +142,6 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep,
 				      pte_t pte, int dirty);
 
-static inline pte_t huge_ptep_get(pte_t *ptep)
-{
-	return *ptep;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
index c87195ae0cfa..6f025fe18146 100644
--- a/arch/sh/include/asm/hugetlb.h
+++ b/arch/sh/include/asm/hugetlb.h
@@ -32,11 +32,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline pte_t huge_ptep_get(pte_t *ptep)
-{
-	return *ptep;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 	clear_bit(PG_dcache_clean, &page->flags);
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 028a1465fbe7..3963f80d1cb3 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -53,11 +53,6 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	return changed;
 }
 
-static inline pte_t huge_ptep_get(pte_t *ptep)
-{
-	return *ptep;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index 1df8944904c6..c97b34a29054 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -12,11 +12,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 	return 0;
 }
 
-static inline pte_t huge_ptep_get(pte_t *ptep)
-{
-	return *ptep;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index f3c99a03ee83..71d7b77eea50 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -119,4 +119,11 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 }
 #endif
 
+#ifndef __HAVE_ARCH_HUGE_PTEP_GET
+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+	return *ptep;
+}
+#endif
+
 #endif /* _ASM_GENERIC_HUGETLB_H */
-- 
2.16.2
