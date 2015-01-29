Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 18:18:06 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:50156 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012205AbbA2RRqlPhuF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 18:17:46 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1YGsfG-00015a-Gk; Thu, 29 Jan 2015 11:13:58 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH V3 1/5] MIPS: Usage and cosmetic cleanups of page table bits.
Date:   Thu, 29 Jan 2015 11:17:33 -0600
Message-Id: <1422551857-10981-2-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1422551857-10981-1-git-send-email-Steven.Hill@imgtec.com>
References: <1422551857-10981-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45544
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

   * Clean up white spaces and tabs.
   * Get rid of remaining hardcoded values for calculating
     shifts and masks.
   * Get rid of redundant macro values.
   * Do not use page table bits directly in #ifdef's.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/pgtable-bits.h |   96 +++++++++++++---------------------
 arch/mips/include/asm/pgtable.h      |    4 +-
 2 files changed, 38 insertions(+), 62 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index cb5ae93..9205fd5 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -35,9 +35,9 @@
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 
 /*
- * The following bits are directly used by the TLB hardware
+ * The following bits are implemented by the TLB hardware
  */
-#define _PAGE_GLOBAL_SHIFT	0
+#define _PAGE_GLOBAL_SHIFT	(0)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
 #define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
@@ -48,8 +48,6 @@
 
 /*
  * The following bits are implemented in software
- *
- * _PAGE_FILE semantics: set:pagecache unset:swap
  */
 #define _PAGE_PRESENT_SHIFT	(_CACHE_SHIFT + 3)
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
@@ -62,48 +60,40 @@
 #define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
 
-#define _PAGE_SILENT_READ	_PAGE_VALID
-#define _PAGE_SILENT_WRITE	_PAGE_DIRTY
-#define _PAGE_FILE		_PAGE_MODIFIED
-
 #define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
 
 #elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 /*
- * The following are implemented by software
- *
- * _PAGE_FILE semantics: set:pagecache unset:swap
+ * The following bits are implemented in software
  */
-#define _PAGE_PRESENT_SHIFT	0
-#define _PAGE_PRESENT		(1 <<  _PAGE_PRESENT_SHIFT)
-#define _PAGE_READ_SHIFT	1
-#define _PAGE_READ		(1 <<  _PAGE_READ_SHIFT)
-#define _PAGE_WRITE_SHIFT	2
-#define _PAGE_WRITE		(1 <<  _PAGE_WRITE_SHIFT)
-#define _PAGE_ACCESSED_SHIFT	3
-#define _PAGE_ACCESSED		(1 <<  _PAGE_ACCESSED_SHIFT)
-#define _PAGE_MODIFIED_SHIFT	4
-#define _PAGE_MODIFIED		(1 <<  _PAGE_MODIFIED_SHIFT)
-#define _PAGE_FILE_SHIFT	4
-#define _PAGE_FILE		(1 <<  _PAGE_FILE_SHIFT)
+#define _PAGE_PRESENT_SHIFT	(0)
+#define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
+#define _PAGE_READ_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
+#define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
+#define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
+#define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
+#define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
+#define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
+#define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
+#define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
 
 /*
- * And these are the hardware TLB bits
+ * The following bits are implemented by the TLB hardware
  */
-#define _PAGE_GLOBAL_SHIFT	8
-#define _PAGE_GLOBAL		(1 <<  _PAGE_GLOBAL_SHIFT)
-#define _PAGE_VALID_SHIFT	9
-#define _PAGE_VALID		(1 <<  _PAGE_VALID_SHIFT)
-#define _PAGE_SILENT_READ	(1 <<  _PAGE_VALID_SHIFT)	/* synonym  */
-#define _PAGE_DIRTY_SHIFT	10
+#define _PAGE_GLOBAL_SHIFT	(_PAGE_MODIFIED_SHIFT + 4)
+#define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
+#define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
+#define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
+#define _PAGE_DIRTY_SHIFT	(_PAGE_VALID_SHIFT + 1)
 #define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)
-#define _PAGE_SILENT_WRITE	(1 << _PAGE_DIRTY_SHIFT)
-#define _CACHE_UNCACHED_SHIFT	11
+#define _CACHE_UNCACHED_SHIFT	(_PAGE_DIRTY_SHIFT + 1)
 #define _CACHE_UNCACHED		(1 << _CACHE_UNCACHED_SHIFT)
-#define _CACHE_MASK		(1 << _CACHE_UNCACHED_SHIFT)
+#define _CACHE_MASK		_CACHE_UNCACHED
+
+#define _PFN_SHIFT		PAGE_SHIFT
 
-#else /* 'Normal' r4K case */
+#else
 /*
  * When using the RI/XI bit support, we have 13 bits of flags below
  * the physical address. The RI/XI bits are placed such that a SRL 5
@@ -114,9 +104,6 @@
 
 /*
  * The following bits are implemented in software
- *
- * _PAGE_READ / _PAGE_READ_SHIFT should be unused if cpu_has_rixi.
- * _PAGE_FILE semantics: set:pagecache unset:swap
  */
 #define _PAGE_PRESENT_SHIFT	(0)
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
@@ -128,22 +115,16 @@
 #define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
 #define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
-#define _PAGE_FILE		(_PAGE_MODIFIED)
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 /* huge tlb page */
 #define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
 #define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
-#else
-#define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT)
-#define _PAGE_HUGE		({BUG(); 1; })	/* Dummy value */
-#endif
-
-#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
-/* huge tlb page */
 #define _PAGE_SPLITTING_SHIFT	(_PAGE_HUGE_SHIFT + 1)
 #define _PAGE_SPLITTING		(1 << _PAGE_SPLITTING_SHIFT)
 #else
+#define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT)
+#define _PAGE_HUGE		({BUG(); 1; })	/* Dummy value */
 #define _PAGE_SPLITTING_SHIFT	(_PAGE_HUGE_SHIFT)
 #define _PAGE_SPLITTING		({BUG(); 1; })	/* Dummy value */
 #endif
@@ -158,17 +139,10 @@
 
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
-
 #define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
-/* synonym		   */
-#define _PAGE_SILENT_READ	(_PAGE_VALID)
-
-/* The MIPS dirty bit	   */
 #define _PAGE_DIRTY_SHIFT	(_PAGE_VALID_SHIFT + 1)
 #define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)
-#define _PAGE_SILENT_WRITE	(_PAGE_DIRTY)
-
 #define _CACHE_SHIFT		(_PAGE_DIRTY_SHIFT + 1)
 #define _CACHE_MASK		(7 << _CACHE_SHIFT)
 
@@ -176,9 +150,13 @@
 
 #endif /* defined(CONFIG_PHYS_ADDR_T_64BIT && defined(CONFIG_CPU_MIPS32) */
 
-#ifndef _PFN_SHIFT
-#define _PFN_SHIFT		    PAGE_SHIFT
-#endif
+/*
+ * _PAGE_FILE semantics: set:pagecache unset:swap
+ */
+#define _PAGE_FILE		_PAGE_MODIFIED
+#define _PAGE_SILENT_READ	_PAGE_VALID
+#define _PAGE_SILENT_WRITE	_PAGE_DIRTY
+
 #define _PFN_MASK		(~((1 << (_PFN_SHIFT)) - 1))
 
 #ifndef _PAGE_NO_READ
@@ -188,9 +166,6 @@
 #ifndef _PAGE_NO_EXEC
 #define _PAGE_NO_EXEC ({BUG(); 0; })
 #endif
-#ifndef _PAGE_GLOBAL_SHIFT
-#define _PAGE_GLOBAL_SHIFT ilog2(_PAGE_GLOBAL)
-#endif
 
 
 #ifndef __ASSEMBLY__
@@ -280,8 +255,9 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #endif
 
 #define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (cpu_has_rixi ? 0 : _PAGE_READ))
-#define __WRITEABLE	(_PAGE_WRITE | _PAGE_SILENT_WRITE | _PAGE_MODIFIED)
+#define __WRITEABLE	(_PAGE_SILENT_WRITE | _PAGE_WRITE | _PAGE_MODIFIED)
 
-#define _PAGE_CHG_MASK	(_PFN_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
+#define _PAGE_CHG_MASK	(_PAGE_ACCESSED | _PAGE_MODIFIED |	\
+			 _PFN_MASK | _CACHE_MASK)
 
 #endif /* _ASM_PGTABLE_BITS_H */
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 0a6a944..8d1b259 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -338,7 +338,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte;
 }
 
-#ifdef _PAGE_HUGE
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 static inline int pte_huge(pte_t pte)	{ return pte_val(pte) & _PAGE_HUGE; }
 
 static inline pte_t pte_mkhuge(pte_t pte)
@@ -346,7 +346,7 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	pte_val(pte) |= _PAGE_HUGE;
 	return pte;
 }
-#endif /* _PAGE_HUGE */
+#endif /* CONFIG_MIPS_HUGE_TLB_SUPPORT */
 #endif
 static inline int pte_special(pte_t pte)	{ return 0; }
 static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
-- 
1.7.10.4
