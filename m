Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 12:39:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17490 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026664AbcDOKjOAmQTe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 12:39:14 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 0CB262C66BBB2;
        Fri, 15 Apr 2016 11:39:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 11:39:06 +0100
Received: from localhost (10.100.200.59) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 11:39:05 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, Paul Burton
        <paul.burton@imgtec.com>, "# v4 . 1+" <stable@vger.kernel.org>, David Daney
        <david.daney@cavium.com>, Huacai Chen <chenhc@lemote.com>, "Maciej W.
 Rozycki" <macro@linux-mips.org>, Paul Gortmaker
        <paul.gortmaker@windriver.com>, Aneesh Kumar K.V
        <aneesh.kumar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, David Hildenbrand
        <dahi@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Markos Chandras" <markos.chandras@imgtec.com>, Ingo Molnar
        <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH 07/12] MIPS: mm: Fix MIPS32 36b physical addressing (alchemy, netlogic)
Date:   Fri, 15 Apr 2016 11:36:55 +0100
Message-ID: <1460716620-13382-8-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.59]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

There are 2 distinct cases in which a kernel for a MIPS32 CPU
(CONFIG_CPU_MIPS32=y) may use 64 bit physical addresses
(CONFIG_PHYS_ADDR_T_64BIT=y):

  - 36 bit physical addressing as used by RMI Alchemy & Netlogic XLP/XLR
    CPUs.

  - MIPS32r5 eXtended Physical Addressing (XPA).

These 2 cases are distinct in that they require different behaviour from
the kernel - the EntryLo registers have different formats. Until Linux
v4.1 we only supported the first case, with code conditional upon the 2
aforementioned Kconfig variables being set. Commit c5b367835cfc ("MIPS:
Add support for XPA.") added support for the second case, but did so by
modifying the code that existed for the first case rather than treating
the 2 cases as distinct. Since the EntryLo registers have different
formats this breaks the 36 bit Alchemy/XLP/XLR case. Fix this by
splitting the 2 cases, with XPA cases now being conditional upon
CONFIG_XPA and the non-XPA case matching the code as it existed prior to
commit c5b367835cfc ("MIPS: Add support for XPA.").

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reported-by: Manuel Lauss <manuel.lauss@gmail.com>
Tested-by: Manuel Lauss <manuel.lauss@gmail.com>
Fixes: c5b367835cfc ("MIPS: Add support for XPA.")
Cc: <stable@vger.kernel.org> # v4.1+
---

 arch/mips/include/asm/pgtable-32.h   | 27 +++++++++++++++++++++++++--
 arch/mips/include/asm/pgtable-bits.h | 29 +++++++++++++++++++++++++----
 arch/mips/include/asm/pgtable.h      | 32 ++++++++++++++++++++++++++++++--
 arch/mips/mm/init.c                  |  4 +++-
 arch/mips/mm/tlbex.c                 | 35 +++++++++++++++++++++++------------
 5 files changed, 106 insertions(+), 21 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 181bd8e..d21f3da 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -103,7 +103,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 	pmd_val(*pmdp) = ((unsigned long) invalid_pte_table);
 }
 
-#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+#if defined(CONFIG_XPA)
 
 #define pte_pfn(x)		(((unsigned long)((x).pte_high >> _PFN_SHIFT)) | (unsigned long)((x).pte_low << _PAGE_PRESENT_SHIFT))
 static inline pte_t
@@ -118,6 +118,20 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 	return pte;
 }
 
+#elif defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+
+#define pte_pfn(x)		((unsigned long)((x).pte_high >> 6))
+
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pte;
+
+	pte.pte_high = (pfn << 6) | (pgprot_val(prot) & 0x3f);
+	pte.pte_low = pgprot_val(prot);
+
+	return pte;
+}
+
 #else
 
 #ifdef CONFIG_CPU_VR41XX
@@ -166,7 +180,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 
 #else
 
-#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+#if defined(CONFIG_XPA)
 
 /* Swap entries must have VALID and GLOBAL bits cleared. */
 #define __swp_type(x)			(((x).val >> 4) & 0x1f)
@@ -175,6 +189,15 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_high })
 #define __swp_entry_to_pte(x)		((pte_t) { 0, (x).val })
 
+#elif defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+
+/* Swap entries must have VALID and GLOBAL bits cleared. */
+#define __swp_type(x)			(((x).val >> 2) & 0x1f)
+#define __swp_offset(x)			 ((x).val >> 7)
+#define __swp_entry(type, offset)	((swp_entry_t)  { ((type) << 2) | ((offset) << 7) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_high })
+#define __swp_entry_to_pte(x)		((pte_t) { 0, (x).val })
+
 #else
 /*
  * Constraints:
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 5bc663d..58e8bf8 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -32,11 +32,11 @@
  * unpredictable things.  The code (when it is written) to deal with
  * this problem will be in the update_mmu_cache() code for the r4k.
  */
-#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+#if defined(CONFIG_XPA)
 
 /*
- * Page table bit offsets used for 64 bit physical addressing on MIPS32,
- * for example with Alchemy, Netlogic XLP/XLR or XPA.
+ * Page table bit offsets used for 64 bit physical addressing on
+ * MIPS32r5 with XPA.
  */
 enum pgtable_bits {
 	/* Used by TLB hardware (placed in EntryLo*) */
@@ -59,6 +59,27 @@ enum pgtable_bits {
  */
 #define _PFNX_MASK		0xffffff
 
+#elif defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+
+/*
+ * Page table bit offsets used for 36 bit physical addressing on MIPS32,
+ * for example with Alchemy or Netlogic XLP/XLR.
+ */
+enum pgtable_bits {
+	/* Used by TLB hardware (placed in EntryLo*) */
+	_PAGE_GLOBAL_SHIFT,
+	_PAGE_VALID_SHIFT,
+	_PAGE_DIRTY_SHIFT,
+	_CACHE_SHIFT,
+
+	/* Used only by software (masked out before writing EntryLo*) */
+	_PAGE_PRESENT_SHIFT = _CACHE_SHIFT + 3,
+	_PAGE_NO_READ_SHIFT,
+	_PAGE_WRITE_SHIFT,
+	_PAGE_ACCESSED_SHIFT,
+	_PAGE_MODIFIED_SHIFT,
+};
+
 #elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 /* Page table bits used for r3k systems */
@@ -116,7 +137,7 @@ enum pgtable_bits {
 #endif
 
 /* Used by TLB hardware (placed in EntryLo*) */
-#if (defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32))
+#if defined(CONFIG_XPA)
 # define _PAGE_NO_EXEC		(1 << _PAGE_NO_EXEC_SHIFT)
 #elif defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 # define _PAGE_NO_EXEC		(cpu_has_rixi ? (1 << _PAGE_NO_EXEC_SHIFT) : 0)
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 1459ee9..b83727d 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -130,7 +130,12 @@ do {									\
 
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 
-#define pte_none(pte)		(!(((pte).pte_high) & ~_PAGE_GLOBAL))
+#ifdef CONFIG_XPA
+# define pte_none(pte)		(!(((pte).pte_high) & ~_PAGE_GLOBAL))
+#else
+# define pte_none(pte)		(!(((pte).pte_low | (pte).pte_high) & ~_PAGE_GLOBAL))
+#endif
+
 #define pte_present(pte)	((pte).pte_low & _PAGE_PRESENT)
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
@@ -139,7 +144,11 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	smp_wmb();
 	ptep->pte_low = pte.pte_low;
 
+#ifdef CONFIG_XPA
 	if (pte.pte_high & _PAGE_GLOBAL) {
+#else
+	if (pte.pte_low & _PAGE_GLOBAL) {
+#endif
 		pte_t *buddy = ptep_buddy(ptep);
 		/*
 		 * Make sure the buddy is global too (if it's !none,
@@ -157,7 +166,11 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 
 	htw_stop();
 	/* Preserve global status for the pair */
+#ifdef CONFIG_XPA
 	if (ptep_buddy(ptep)->pte_high & _PAGE_GLOBAL)
+#else
+	if (ptep_buddy(ptep)->pte_low & _PAGE_GLOBAL)
+#endif
 		null.pte_high = _PAGE_GLOBAL;
 
 	set_pte_at(mm, addr, ptep, null);
@@ -271,6 +284,8 @@ static inline int pte_young(pte_t pte)	{ return pte.pte_low & _PAGE_ACCESSED; }
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	pte.pte_low  &= ~_PAGE_WRITE;
+	if (!config_enabled(CONFIG_XPA))
+		pte.pte_low &= ~_PAGE_SILENT_WRITE;
 	pte.pte_high &= ~_PAGE_SILENT_WRITE;
 	return pte;
 }
@@ -278,6 +293,8 @@ static inline pte_t pte_wrprotect(pte_t pte)
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	pte.pte_low  &= ~_PAGE_MODIFIED;
+	if (!config_enabled(CONFIG_XPA))
+		pte.pte_low &= ~_PAGE_SILENT_WRITE;
 	pte.pte_high &= ~_PAGE_SILENT_WRITE;
 	return pte;
 }
@@ -285,6 +302,8 @@ static inline pte_t pte_mkclean(pte_t pte)
 static inline pte_t pte_mkold(pte_t pte)
 {
 	pte.pte_low  &= ~_PAGE_ACCESSED;
+	if (!config_enabled(CONFIG_XPA))
+		pte.pte_low &= ~_PAGE_SILENT_READ;
 	pte.pte_high &= ~_PAGE_SILENT_READ;
 	return pte;
 }
@@ -407,7 +426,7 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
  */
 #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
 
-#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+#if defined(CONFIG_XPA)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte.pte_low  &= (_PAGE_MODIFIED | _PAGE_ACCESSED | _PFNX_MASK);
@@ -416,6 +435,15 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	pte.pte_high |= pgprot_val(newprot) & ~_PFN_MASK;
 	return pte;
 }
+#elif defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	pte.pte_low  &= _PAGE_CHG_MASK;
+	pte.pte_high &= (_PFN_MASK | _CACHE_MASK);
+	pte.pte_low  |= pgprot_val(newprot);
+	pte.pte_high |= pgprot_val(newprot) & ~(_PFN_MASK | _CACHE_MASK);
+	return pte;
+}
 #else
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 7e5fa09..0e57893 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -98,8 +98,10 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 	idx += in_interrupt() ? FIX_N_COLOURS : 0;
 	vaddr = __fix_to_virt(FIX_CMAP_END - idx);
 	pte = mk_pte(page, prot);
-#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+#if defined(CONFIG_XPA)
 	entrylo = pte_to_entrylo(pte.pte_high);
+#elif defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
+	entrylo = pte.pte_high;
 #else
 	entrylo = pte_to_entrylo(pte_val(pte));
 #endif
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 7e3272f..ceaee32 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1003,25 +1003,21 @@ static void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 
 static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
 {
-	/*
-	 * 64bit address support (36bit on a 32bit CPU) in a 32bit
-	 * Kernel is a special case. Only a few CPUs use it.
-	 */
-	if (config_enabled(CONFIG_PHYS_ADDR_T_64BIT) && !cpu_has_64bits) {
+	if (config_enabled(CONFIG_XPA)) {
 		int pte_off_even = sizeof(pte_t) / 2;
 		int pte_off_odd = pte_off_even + sizeof(pte_t);
-#ifdef CONFIG_XPA
 		const int scratch = 1; /* Our extra working register */
 
 		uasm_i_addu(p, scratch, 0, ptep);
-#endif
+
 		uasm_i_lw(p, tmp, pte_off_even, ptep); /* even pte */
-		uasm_i_lw(p, ptep, pte_off_odd, ptep); /* odd pte */
 		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
-		UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL));
 		UASM_i_MTC0(p, tmp, C0_ENTRYLO0);
+
+		uasm_i_lw(p, ptep, pte_off_odd, ptep); /* odd pte */
+		UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL));
 		UASM_i_MTC0(p, ptep, C0_ENTRYLO1);
-#ifdef CONFIG_XPA
+
 		uasm_i_lw(p, tmp, 0, scratch);
 		uasm_i_lw(p, ptep, sizeof(pte_t), scratch);
 		uasm_i_lui(p, scratch, 0xff);
@@ -1030,7 +1026,22 @@ static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
 		uasm_i_and(p, ptep, scratch, ptep);
 		uasm_i_mthc0(p, tmp, C0_ENTRYLO0);
 		uasm_i_mthc0(p, ptep, C0_ENTRYLO1);
-#endif
+		return;
+	}
+
+	/*
+	 * 64bit address support (36bit on a 32bit CPU) in a 32bit
+	 * Kernel is a special case. Only a few CPUs use it.
+	 */
+	if (config_enabled(CONFIG_PHYS_ADDR_T_64BIT) && !cpu_has_64bits) {
+		int pte_off_even = sizeof(pte_t) / 2;
+		int pte_off_odd = pte_off_even + sizeof(pte_t);
+
+		uasm_i_lw(p, tmp, pte_off_even, ptep); /* even pte */
+		UASM_i_MTC0(p, tmp, C0_ENTRYLO0);
+
+		uasm_i_lw(p, ptep, pte_off_odd, ptep); /* odd pte */
+		UASM_i_MTC0(p, ptep, C0_ENTRYLO1);
 		return;
 	}
 
@@ -1524,7 +1535,7 @@ iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 	unsigned int hwmode = mode & (_PAGE_VALID | _PAGE_DIRTY);
 
-	if (!cpu_has_64bits) {
+	if (config_enabled(CONFIG_XPA) && !cpu_has_64bits) {
 		const int scratch = 1; /* Our extra working register */
 
 		uasm_i_lui(p, scratch, (mode >> 16));
-- 
2.8.0
