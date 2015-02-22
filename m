Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2015 07:37:02 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60492 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006765AbbBVGgmvtbEL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Feb 2015 07:36:42 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1YPQ60-0000CY-MO; Sun, 22 Feb 2015 00:32:52 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH V5 1/3] MIPS: Rearrange PTE bits into fixed positions.
Date:   Sun, 22 Feb 2015 00:36:26 -0600
Message-Id: <1424586988-21544-2-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1424586988-21544-1-git-send-email-Steven.Hill@imgtec.com>
References: <1424586988-21544-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

This patch rearranges the PTE bits into fixed positions for R2
and later cores. In the past, the TLB handling code did runtime
checking of RI/XI and adjusted the shifts and rotates in order
to fit the largest PFN value into the PTE. The checking now
occurs when building the TLB handler, thus eliminating those
checks. These new arrangements also define the largest possible
PFN value that can fit in the PTE. HUGE page support is only
available on 64-bit platforms.

The new layouts of the PTE bits are the following:

   64-bit, R1 or earlier:     CCC D V G [S H] M A W R P
   32-bit, R1 or earler:      CCC D V G M A W R P
   64-bit, R2 or later:       CCC D V G RI XI [S H] M A W R P
   32-bit, R2 or later:       CCC D V G RI XI M A W R P

In the case of cores that support the RI/XI bits, the value of
the R bit may be ignored.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/pgtable-bits.h |   91 ++++++++++++++++++++--------------
 arch/mips/include/asm/pgtable.h      |   20 ++++----
 2 files changed, 64 insertions(+), 47 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 537e9b6..924db7f 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -37,7 +37,7 @@
 /*
  * The following bits are implemented by the TLB hardware
  */
-#define _PAGE_GLOBAL_SHIFT	0
+#define _PAGE_GLOBAL_SHIFT	(0)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
 #define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
@@ -60,9 +60,6 @@
 #define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
 
-#define _PAGE_SILENT_READ	_PAGE_VALID
-#define _PAGE_SILENT_WRITE	_PAGE_DIRTY
-
 #define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
 
 #elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
@@ -98,20 +95,21 @@
 
 #else
 /*
- * When using the RI/XI bit support, we have 13 bits of flags below
- * the physical address. The RI/XI bits are placed such that a SRL 5
- * can strip off the software bits, then a ROTR 2 can move the RI/XI
- * into bits [63:62]. This also limits physical address to 56 bits,
- * which is more than we need right now.
+ * Below are the "Normal" R4K cases
  */
 
 /*
  * The following bits are implemented in software
  */
-#define _PAGE_PRESENT_SHIFT	0
+#define _PAGE_PRESENT_SHIFT	(0)
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
-#define _PAGE_READ_SHIFT	(cpu_has_rixi ? _PAGE_PRESENT_SHIFT : _PAGE_PRESENT_SHIFT + 1)
-#define _PAGE_READ ({BUG_ON(cpu_has_rixi); 1 << _PAGE_READ_SHIFT; })
+#define _PAGE_READ_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
+/* Only R2 or newer cores have RI/XI bits */
+#ifdef CONFIG_CPU_MIPSR2
+#define _PAGE_READ		(cpu_has_rixi ? 0 : (1 << _PAGE_READ_SHIFT))
+#else
+#define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
+#endif
 #define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
 #define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
@@ -119,29 +117,41 @@
 #define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
 
-#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
-/* huge tlb page */
+#if defined(CONFIG_64BIT) && defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
+/* Huge TLB page */
 #define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
 #define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
 #define _PAGE_SPLITTING_SHIFT	(_PAGE_HUGE_SHIFT + 1)
 #define _PAGE_SPLITTING		(1 << _PAGE_SPLITTING_SHIFT)
+
+/* Only R2 or newer cores have RI/XI bits */
+#ifdef CONFIG_CPU_MIPSR2
+#define _PAGE_NO_EXEC_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
 #else
-#define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT)
-#define _PAGE_HUGE		({BUG(); 1; })	/* Dummy value */
-#define _PAGE_SPLITTING_SHIFT	(_PAGE_HUGE_SHIFT)
-#define _PAGE_SPLITTING		({BUG(); 1; })	/* Dummy value */
-#endif
+#define _PAGE_GLOBAL_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
+#define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
+#endif	/* CONFIG_CPU_MIPSR2 */
 
-/* Page cannot be executed */
-#define _PAGE_NO_EXEC_SHIFT	(cpu_has_rixi ? _PAGE_SPLITTING_SHIFT + 1 : _PAGE_SPLITTING_SHIFT)
-#define _PAGE_NO_EXEC		({BUG_ON(!cpu_has_rixi); 1 << _PAGE_NO_EXEC_SHIFT; })
+#endif	/* CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT */
 
+#ifdef CONFIG_CPU_MIPSR2
+/* Page cannot be executed */
+#ifndef _PAGE_NO_EXEC_SHIFT
+#define _PAGE_NO_EXEC_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
+#endif
+#define _PAGE_NO_EXEC		(cpu_has_rixi ? (1 << _PAGE_NO_EXEC_SHIFT) : 0)
 /* Page cannot be read */
-#define _PAGE_NO_READ_SHIFT	(cpu_has_rixi ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
-#define _PAGE_NO_READ		({BUG_ON(!cpu_has_rixi); 1 << _PAGE_NO_READ_SHIFT; })
+#define _PAGE_NO_READ_SHIFT	(_PAGE_NO_EXEC_SHIFT + 1)
+#define _PAGE_NO_READ		(cpu_has_rixi ? (1 << _PAGE_NO_READ_SHIFT) : 0)
+/* For R2 or newer cores */
+#define _PAGE_GLOBAL_SHIFT	(_PAGE_READ_SHIFT + 1)
+#define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
 
-#define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
+#else	/* !CONFIG_CPU_MIPSR2 */
+#define _PAGE_GLOBAL_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
+#endif	/* CONFIG_CPU_MIPSR2 */
+
 #define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
 #define _PAGE_DIRTY_SHIFT	(_PAGE_VALID_SHIFT + 1)
@@ -151,25 +161,28 @@
 
 #define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
 
-#endif /* defined(CONFIG_PHYS_ADDR_T_64BIT && defined(CONFIG_CPU_MIPS32) */
-
 /*
- * _PAGE_FILE semantics: set:pagecache unset:swap
+ * Below are the different layouts of the PTE bits:
+ *
+ *   64-bit, R1 or earlier:     CCC D V G [S H] M A W R P
+ *   32-bit, R1 or earler:      CCC D V G M A W R P
+ *   64-bit, R2 or later:       CCC D V G RI XI [S H] M A W R P
+ *   32-bit, R2 or later:       CCC D V G RI XI M A W R P
  */
-#define _PAGE_FILE		_PAGE_MODIFIED
+#endif /* defined(CONFIG_PHYS_ADDR_T_64BIT && defined(CONFIG_CPU_MIPS32) */
+
+#ifndef _PAGE_NO_EXEC
+#define _PAGE_NO_EXEC		(0)
+#endif
+#ifndef _PAGE_NO_READ
+#define _PAGE_NO_READ		(0)
+#endif
+
 #define _PAGE_SILENT_READ	_PAGE_VALID
 #define _PAGE_SILENT_WRITE	_PAGE_DIRTY
 
 #define _PFN_MASK		(~((1 << (_PFN_SHIFT)) - 1))
 
-#ifndef _PAGE_NO_READ
-#define _PAGE_NO_READ ({BUG(); 0; })
-#define _PAGE_NO_READ_SHIFT ({BUG(); 0; })
-#endif
-#ifndef _PAGE_NO_EXEC
-#define _PAGE_NO_EXEC ({BUG(); 0; })
-#endif
-
 
 #ifndef __ASSEMBLY__
 /*
@@ -178,6 +191,7 @@
  */
 static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 {
+#ifdef CONFIG_CPU_MIPSR2
 	if (cpu_has_rixi) {
 		int sa;
 #ifdef CONFIG_32BIT
@@ -193,6 +207,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 		return (pte_val >> _PAGE_GLOBAL_SHIFT) |
 			((pte_val & (_PAGE_NO_EXEC | _PAGE_NO_READ)) << sa);
 	}
+#endif
 
 	return pte_val >> _PAGE_GLOBAL_SHIFT;
 }
@@ -252,7 +267,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #define _CACHE_UNCACHED_ACCELERATED	(7<<_CACHE_SHIFT)
 #endif
 
-#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (cpu_has_rixi ? 0 : _PAGE_READ))
+#define __READABLE	(_PAGE_SILENT_READ | _PAGE_READ | _PAGE_ACCESSED)
 #define __WRITEABLE	(_PAGE_SILENT_WRITE | _PAGE_WRITE | _PAGE_MODIFIED)
 
 #define _PAGE_CHG_MASK	(_PAGE_ACCESSED | _PAGE_MODIFIED |	\
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index baac292..bedea3a 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -24,17 +24,17 @@ struct mm_struct;
 struct vm_area_struct;
 
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | (cpu_has_rixi ? 0 : _PAGE_READ) | \
+#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | \
 				 _page_cachable_default)
-#define PAGE_COPY	__pgprot(_PAGE_PRESENT | (cpu_has_rixi ? 0 : _PAGE_READ) | \
-				 (cpu_has_rixi ?  _PAGE_NO_EXEC : 0) | _page_cachable_default)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | (cpu_has_rixi ? 0 : _PAGE_READ) | \
+#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_NO_EXEC | \
+				 _page_cachable_default)
+#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_READ | \
 				 _page_cachable_default)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _page_cachable_default)
 #define PAGE_KERNEL_NC	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _CACHE_CACHABLE_NONCOHERENT)
-#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | (cpu_has_rixi ? 0 : _PAGE_READ) | _PAGE_WRITE | \
+#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
 				 _page_cachable_default)
 #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
 			__WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
@@ -334,13 +334,14 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
+#ifdef CONFIG_CPU_MIPSR2
 	if (cpu_has_rixi) {
 		if (!(pte_val(pte) & _PAGE_NO_READ))
 			pte_val(pte) |= _PAGE_SILENT_READ;
-	} else {
+	} else
+#endif
 		if (pte_val(pte) & _PAGE_READ)
 			pte_val(pte) |= _PAGE_SILENT_READ;
-	}
 	return pte;
 }
 
@@ -539,13 +540,14 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 {
 	pmd_val(pmd) |= _PAGE_ACCESSED;
 
+#ifdef CONFIG_CPU_MIPSR2
 	if (cpu_has_rixi) {
 		if (!(pmd_val(pmd) & _PAGE_NO_READ))
 			pmd_val(pmd) |= _PAGE_SILENT_READ;
-	} else {
+	} else
+#endif
 		if (pmd_val(pmd) & _PAGE_READ)
 			pmd_val(pmd) |= _PAGE_SILENT_READ;
-	}
 
 	return pmd;
 }
-- 
1.7.10.4
