Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 16:53:48 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:38129 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013632AbaKMPwTzbifg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 16:52:19 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1Xowgu-0007pf-Ks; Thu, 13 Nov 2014 09:52:12 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 5/8] MIPS: Cosmetic cleanups of page table headers.
Date:   Thu, 13 Nov 2014 09:52:01 -0600
Message-Id: <1415893924-36351-6-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415893924-36351-1-git-send-email-Steven.Hill@imgtec.com>
References: <1415893924-36351-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44136
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
   * Remove _PAGE_R4KBUG which is no longer used.
   * Get rid of hardcoded values and calculate shifts and
     masks where possible.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/pgtable-32.h   |   98 +++++++++++++++++-----------------
 arch/mips/include/asm/pgtable-bits.h |   32 +++++------
 arch/mips/include/asm/pgtable.h      |    8 +--
 3 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index cd7d606..55a2748 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -155,73 +155,75 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 /* Swap entries must have VALID bit cleared. */
-#define __swp_type(x)		(((x).val >> 10) & 0x1f)
-#define __swp_offset(x)		((x).val >> 15)
-#define __swp_entry(type,offset)	\
-	((swp_entry_t) { ((type) << 10) | ((offset) << 15) })
+#define __swp_type(x)			(((x).val >> 10) & 0x1f)
+#define __swp_offset(x)			((x).val >> 15)
+#define __swp_entry(type,offset)	((swp_entry_t) { ((type) << 10) | ((offset) << 15) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
 /*
- * Bits 0, 4, 8, and 9 are taken, split up 28 bits of offset into this range:
+ * Encode and decode a nonlinear file mapping entry
  */
-#define PTE_FILE_MAX_BITS	28
-
-#define pte_to_pgoff(_pte)	((((_pte).pte >> 1 ) & 0x07) | \
-				 (((_pte).pte >> 2 ) & 0x38) | \
-				 (((_pte).pte >> 10) <<	 6 ))
+#define pte_to_pgoff(_pte)		((((_pte).pte >> 1 ) & 0x07) | \
+					 (((_pte).pte >> 2 ) & 0x38) | \
+					 (((_pte).pte >> 10) <<	 6 ))
 
-#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x07) << 1 ) | \
-					   (((off) & 0x38) << 2 ) | \
-					   (((off) >>  6 ) << 10) | \
-					   _PAGE_FILE })
+#define pgoff_to_pte(off)		((pte_t) { (((off) & 0x07) << 1 ) | \
+						   (((off) & 0x38) << 2 ) | \
+						   (((off) >>  6 ) << 10) | \
+						   _PAGE_FILE })
 
+/*
+ * Bits 0, 4, 8, and 9 are taken, split up 28 bits of offset into this range:
+ */
+#define PTE_FILE_MAX_BITS		28
 #else
 
-/* Swap entries must have VALID and GLOBAL bits cleared. */
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
-#define __swp_type(x)		(((x).val >> 2) & 0x1f)
-#define __swp_offset(x)		 ((x).val >> 7)
-#define __swp_entry(type,offset)	\
-		((swp_entry_t)	{ ((type) << 2) | ((offset) << 7) })
-#else
-#define __swp_type(x)		(((x).val >> 8) & 0x1f)
-#define __swp_offset(x)		 ((x).val >> 13)
-#define __swp_entry(type,offset)	\
-		((swp_entry_t)	{ ((type) << 8) | ((offset) << 13) })
-#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+/* Swap entries must have VALID and GLOBAL bits cleared. */
+#define __swp_type(x)			(((x).val >> 2) & 0x1f)
+#define __swp_offset(x)			 ((x).val >> 7)
+#define __swp_entry(type,offset)	((swp_entry_t)	{ ((type) << 2) | ((offset) << 7) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_high })
+#define __swp_entry_to_pte(x)		((pte_t) { 0, (x).val })
+
 /*
  * Bits 0 and 1 of pte_high are taken, use the rest for the page offset...
  */
-#define PTE_FILE_MAX_BITS	30
-
-#define pte_to_pgoff(_pte)	((_pte).pte_high >> 2)
-#define pgoff_to_pte(off)	((pte_t) { _PAGE_FILE, (off) << 2 })
+#define pte_to_pgoff(_pte)		((_pte).pte_high >> 2)
+#define pgoff_to_pte(off)		((pte_t) { _PAGE_FILE, (off) << 2 })
 
+#define PTE_FILE_MAX_BITS		30
 #else
 /*
- * Bits 0, 4, 6, and 7 are taken, split up 28 bits of offset into this range:
+ * Constraints:
+ *      _PAGE_PRESENT at bit 0
+ *      _PAGE_MODIFIED at bit 4
+ *      _PAGE_GLOBAL at bit 6
+ *      _PAGE_VALID at bit 7
  */
-#define PTE_FILE_MAX_BITS	28
+#define __swp_type(x)			(((x).val >> 8) & 0x1f)
+#define __swp_offset(x)			 ((x).val >> 13)
+#define __swp_entry(type,offset)	((swp_entry_t)	{ ((type) << 8) | ((offset) << 13) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#define pte_to_pgoff(_pte)	((((_pte).pte >> 1) & 0x7) | \
-				 (((_pte).pte >> 2) & 0x8) | \
-				 (((_pte).pte >> 8) <<	4))
+/*
+ * Encode and decode a nonlinear file mapping entry
+ */
+#define pte_to_pgoff(_pte)		((((_pte).pte >> 1) & 0x7) | \
+					 (((_pte).pte >> 2) & 0x8) | \
+					 (((_pte).pte >> 8) <<	4))
 
-#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x7) << 1) | \
-					   (((off) & 0x8) << 2) | \
-					   (((off) >>  4) << 8) | \
-					   _PAGE_FILE })
-#endif
+#define pgoff_to_pte(off)		((pte_t) { (((off) & 0x7) << 1) | \
+						   (((off) & 0x8) << 2) | \
+						   (((off) >>  4) << 8) | \
+						   _PAGE_FILE })
 
-#endif
+#define PTE_FILE_MAX_BITS		28
+#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
-#define __pte_to_swp_entry(pte) ((swp_entry_t) { (pte).pte_high })
-#define __swp_entry_to_pte(x)	((pte_t) { 0, (x).val })
-#else
-#define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
-#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
-#endif
+#endif /* defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) */
 
 #endif /* _ASM_PGTABLE_32_H */
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index f336281..a4ed2bd 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -37,34 +37,36 @@
 /*
  * The following bits are directly used by the TLB hardware
  */
-#define _PAGE_R4KBUG		(1 << 0)  /* workaround for r4k bug  */
-#define _PAGE_GLOBAL		(1 << 0)
-#define _PAGE_VALID_SHIFT	1
+#define _PAGE_GLOBAL_SHIFT	0
+#define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
+#define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
-#define _PAGE_SILENT_READ	(1 << 1)  /* synonym		     */
-#define _PAGE_DIRTY_SHIFT	2
-#define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)  /* The MIPS dirty bit	     */
-#define _PAGE_SILENT_WRITE	(1 << 2)
-#define _CACHE_SHIFT		3
-#define _CACHE_MASK		(7 << 3)
+#define _PAGE_DIRTY_SHIFT	(_PAGE_VALID_SHIFT + 1)
+#define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)
+#define _CACHE_SHIFT		(_PAGE_DIRTY_SHIFT + 1)
+#define _CACHE_MASK		(7 << _CACHE_SHIFT)
 
 /*
  * The following bits are implemented in software
  *
  * _PAGE_FILE semantics: set:pagecache unset:swap
  */
-#define _PAGE_PRESENT_SHIFT	6
+#define _PAGE_PRESENT_SHIFT	(_CACHE_SHIFT + 3)
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
-#define _PAGE_READ_SHIFT	7
+#define _PAGE_READ_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
 #define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
-#define _PAGE_WRITE_SHIFT	8
+#define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
-#define _PAGE_ACCESSED_SHIFT	9
+#define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
 #define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
-#define _PAGE_MODIFIED_SHIFT	10
+#define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
 
-#define _PAGE_FILE		(1 << 10)
+#define _PAGE_SILENT_READ	_PAGE_VALID
+#define _PAGE_SILENT_WRITE	_PAGE_DIRTY
+#define _PAGE_FILE		_PAGE_MODIFIED
+
+#define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
 
 #elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index d6d1928..845a417 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -297,13 +297,13 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	pte_val(pte) &= ~(_PAGE_MODIFIED|_PAGE_SILENT_WRITE);
+	pte_val(pte) &= ~(_PAGE_MODIFIED | _PAGE_SILENT_WRITE);
 	return pte;
 }
 
 static inline pte_t pte_mkold(pte_t pte)
 {
-	pte_val(pte) &= ~(_PAGE_ACCESSED|_PAGE_SILENT_READ);
+	pte_val(pte) &= ~(_PAGE_ACCESSED | _PAGE_SILENT_READ);
 	return pte;
 }
 
@@ -386,9 +386,9 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte.pte_low  &= _PAGE_CHG_MASK;
-	pte.pte_high &= ~0x3f;
+	pte.pte_high &= (_PFN_MASK | _CACHE_MASK);
 	pte.pte_low  |= pgprot_val(newprot);
-	pte.pte_high |= pgprot_val(newprot) & 0x3f;
+	pte.pte_high |= pgprot_val(newprot) & ~(_PFN_MASK | _CACHE_MASK);
 	return pte;
 }
 #else
-- 
1.7.10.4
