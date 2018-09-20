Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 08:14:36 +0200 (CEST)
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58193 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990423AbeITGOcoz3Nq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 08:14:32 +0200
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7F276C000D;
        Thu, 20 Sep 2018 06:14:06 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v7 09/11] hugetlb: Introduce generic version of huge_ptep_set_wrprotect
Date:   Thu, 20 Sep 2018 06:03:56 +0000
Message-Id: <20180920060358.16606-10-alex@ghiti.fr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180920060358.16606-1-alex@ghiti.fr>
References: <20180920060358.16606-1-alex@ghiti.fr>
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66426
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

arm, ia64, mips, powerpc, sh, x86 architectures use the same version
of huge_ptep_set_wrprotect, so move this generic implementation into
asm-generic/hugetlb.h.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Acked-by: Catalin Marinas <catalin.marinas@arm.com> # arm64
Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts
Acked-by: Ingo Molnar <mingo@kernel.org> # x86
Reviewed-by: Luiz Capitulino <lcapitulino@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/arm/include/asm/hugetlb-3level.h        | 6 ------
 arch/arm64/include/asm/hugetlb.h             | 1 +
 arch/ia64/include/asm/hugetlb.h              | 6 ------
 arch/mips/include/asm/hugetlb.h              | 6 ------
 arch/parisc/include/asm/hugetlb.h            | 1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h | 6 ------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 1 +
 arch/powerpc/include/asm/nohash/32/pgtable.h | 6 ------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 1 +
 arch/sh/include/asm/hugetlb.h                | 6 ------
 arch/sparc/include/asm/hugetlb.h             | 1 +
 arch/x86/include/asm/hugetlb.h               | 6 ------
 include/asm-generic/hugetlb.h                | 8 ++++++++
 13 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
index b897541520ef..8247cd6a2ac6 100644
--- a/arch/arm/include/asm/hugetlb-3level.h
+++ b/arch/arm/include/asm/hugetlb-3level.h
@@ -37,12 +37,6 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
 	return retval;
 }
 
-static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
-{
-	ptep_set_wrprotect(mm, addr, ptep);
-}
-
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 3e7f6e69b28d..f4f69ae5466e 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -48,6 +48,7 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 				     unsigned long addr, pte_t *ptep);
+#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
index cbe296271030..49d1f7949f3a 100644
--- a/arch/ia64/include/asm/hugetlb.h
+++ b/arch/ia64/include/asm/hugetlb.h
@@ -27,12 +27,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
-{
-	ptep_set_wrprotect(mm, addr, ptep);
-}
-
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index 6ff2531cfb1d..3dcf5debf8c4 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -63,12 +63,6 @@ static inline int huge_pte_none(pte_t pte)
 	return !val || (val == (unsigned long)invalid_pte_table);
 }
 
-static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
-{
-	ptep_set_wrprotect(mm, addr, ptep);
-}
-
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr,
 					     pte_t *ptep, pte_t pte,
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index fb7e0fd858a3..9c3950ca2974 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -39,6 +39,7 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
+#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep);
 
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 751cf931bb3f..796d026da37e 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -221,12 +221,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 {
 	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), _PAGE_RO);
 }
-static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
-{
-	ptep_set_wrprotect(mm, addr, ptep);
-}
-
 
 static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   pte_t *ptep, pte_t entry,
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 13a688fc8cd0..badb56963885 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -461,6 +461,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 0);
 }
 
+#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index a507a65b0866..6c82b9660c55 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -246,12 +246,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 {
 	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), _PAGE_RO);
 }
-static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
-{
-	ptep_set_wrprotect(mm, addr, ptep);
-}
-
 
 static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   pte_t *ptep, pte_t entry,
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 7cd6809f4d33..68283e632f04 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -239,6 +239,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
 }
 
+#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
index f1bbd255ee43..8df4004977b9 100644
--- a/arch/sh/include/asm/hugetlb.h
+++ b/arch/sh/include/asm/hugetlb.h
@@ -32,12 +32,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
-{
-	ptep_set_wrprotect(mm, addr, ptep);
-}
-
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 2101ea217f33..c41754a113f3 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -32,6 +32,7 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
+#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index 59c056adb3c9..a3f781f7a264 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -13,12 +13,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 	return 0;
 }
 
-static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
-{
-	ptep_set_wrprotect(mm, addr, ptep);
-}
-
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 6c0c8b0c71e0..9b9039845278 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -102,4 +102,12 @@ static inline int prepare_hugepage_range(struct file *file,
 }
 #endif
 
+#ifndef __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+		unsigned long addr, pte_t *ptep)
+{
+	ptep_set_wrprotect(mm, addr, ptep);
+}
+#endif
+
 #endif /* _ASM_GENERIC_HUGETLB_H */
-- 
2.16.2
