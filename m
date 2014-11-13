Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 07:26:19 +0100 (CET)
Received: from [63.228.164.32] ([63.228.164.32]:33896 "EHLO
        home.bethel-hill.org" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012561AbaKMG0RQl-4L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 07:26:17 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1XonXV-0007Qu-IZ; Thu, 13 Nov 2014 00:05:53 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 10/11] MIPS: Add support for XPA.
Date:   Thu, 13 Nov 2014 00:05:42 -0600
Message-Id: <1415858743-24492-11-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
References: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44102
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

Add support for extended physical addressing (XPA) so that
32-bit platforms can access equal to or greater than 40 bits
of physical addresses.

NOTE:
      1) XPA and EVA are not the same and cannot be used
         simultaneously.
      2) If you configure your kernel for XPA, the PTEs
         and all address sizes become 64-bit.
      3) Your platform MUST have working HIGHMEM support.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/Kconfig                    |   34 +++++++++++++
 arch/mips/include/asm/cpu-features.h |    3 ++
 arch/mips/include/asm/cpu.h          |    1 +
 arch/mips/include/asm/mipsregs.h     |    1 +
 arch/mips/include/asm/pgtable-32.h   |   23 +++++----
 arch/mips/include/asm/pgtable-bits.h |   13 ++++-
 arch/mips/include/asm/pgtable.h      |   36 ++++++--------
 arch/mips/kernel/cpu-probe.c         |    4 ++
 arch/mips/kernel/proc.c              |    1 +
 arch/mips/mm/init.c                  |    7 ++-
 arch/mips/mm/tlb-r4k.c               |   12 +++++
 arch/mips/mm/tlbex.c                 |   88 +++++++++++++++++++++++++++++-----
 12 files changed, 175 insertions(+), 48 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f7e93c4..08ba7b9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -360,6 +360,7 @@ config MIPS_MALTA
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_CPU_MIPS32_R3_5
+	select SYS_HAS_CPU_MIPS32_R5
 	select SYS_HAS_CPU_MIPS64_R1
 	select SYS_HAS_CPU_MIPS64_R2
 	select SYS_HAS_CPU_NEVADA
@@ -367,6 +368,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MIPS_CMP
 	select SYS_SUPPORTS_MIPS_CPS
@@ -1547,6 +1549,32 @@ config CPU_MIPS32_3_5_EVA
 	  One of its primary benefits is an increase in the maximum size
 	  of lowmem (up to 3GB). If unsure, say 'N' here.
 
+config CPU_MIPS32_R5_FEATURES
+	bool "MIPS32 Release 5 Features"
+	depends on SYS_HAS_CPU_MIPS32_R5
+	depends on CPU_MIPS32_R2
+	help
+	  Choose this option to build a kernel for release 2 or later of the
+	  MIPS32 architecture including features from release 5 such as
+	  support for Extended Physical Addressing (XPA).
+
+config CPU_MIPS32_R5_XPA
+	bool "Extended Physical Addressing (XPA)"
+	depends on CPU_MIPS32_R5_FEATURES
+	depends on !EVA
+	depends on SYS_SUPPORTS_HIGHMEM
+	select XPA
+	select HIGHMEM
+	select 64BIT_PHYS_ADDR
+	default n
+	help
+	  Choose this option if you want to enable the Extended Physical
+	  Addressing (XPA) on your MIPS32 core (such as P5600 series). The
+	  benefit is to increase physical addressing equal to or greater
+	  than 40 bits. Note that this has the side effect of turning on
+	  64-bit addressing which in turn makes the PTEs 64-bit in size.
+	  If unsure, say 'N' here.
+
 if CPU_LOONGSON2F
 config CPU_NOP_WORKAROUNDS
 	bool
@@ -1650,6 +1678,9 @@ config SYS_HAS_CPU_MIPS32_R2
 config SYS_HAS_CPU_MIPS32_R3_5
 	bool
 
+config SYS_HAS_CPU_MIPS32_R5
+	bool
+
 config SYS_HAS_CPU_MIPS64_R1
 	bool
 
@@ -1775,6 +1806,9 @@ config CPU_MIPSR2
 config EVA
 	bool
 
+config XPA
+	bool
+
 config SYS_SUPPORTS_32BIT_KERNEL
 	bool
 config SYS_SUPPORTS_64BIT_KERNEL
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 92aa321..9d64b1b 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -136,6 +136,9 @@
 # endif
 #endif
 
+#ifndef cpu_has_xpa
+#define cpu_has_xpa		(cpu_data[0].options & MIPS_CPU_XPA)
+#endif   
 #ifndef cpu_has_vtag_icache
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 33866fc..cd39826 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -370,6 +370,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_RIXIEX		0x200000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
 #define MIPS_CPU_MAAR		0x400000000ull /* MAAR(I) registers are present */
 #define MIPS_CPU_FRE		0x800000000ull /* FRE & UFE bits implemented */
+#define MIPS_CPU_XPA		0x1000000000ull /* CPU supports Extended Physical Addressing */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index eaae8b0..98b6767 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -653,6 +653,7 @@
 #define MIPS_CONF5_NF		(_ULCAST_(1) << 0)
 #define MIPS_CONF5_UFR		(_ULCAST_(1) << 2)
 #define MIPS_CONF5_MRP		(_ULCAST_(1) << 3)
+#define MIPS_CONF5_MVH		(_ULCAST_(1) << 5)
 #define MIPS_CONF5_FRE		(_ULCAST_(1) << 8)
 #define MIPS_CONF5_UFE		(_ULCAST_(1) << 9)
 #define MIPS_CONF5_MSAEN	(_ULCAST_(1) << 27)
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 55a2748..50951bd 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -105,13 +105,16 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
-#define pte_pfn(x)		((unsigned long)((x).pte_high >> 6))
+#define pte_pfn(x)		(((unsigned long)((x).pte_high >> _PFN_SHIFT)) | (unsigned long)((x).pte_low << _PAGE_PRESENT_SHIFT))
 static inline pte_t
 pfn_pte(unsigned long pfn, pgprot_t prot)
 {
 	pte_t pte;
-	pte.pte_high = (pfn << 6) | (pgprot_val(prot) & 0x3f);
-	pte.pte_low = pgprot_val(prot);
+
+	pte.pte_low = (pfn >> _PAGE_PRESENT_SHIFT) |
+				(pgprot_val(prot) & ~_PFNX_MASK);
+	pte.pte_high = (pfn << _PFN_SHIFT) |
+				(pgprot_val(prot) & ~_PFN_MASK);
 	return pte;
 }
 
@@ -182,19 +185,19 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 
 /* Swap entries must have VALID and GLOBAL bits cleared. */
-#define __swp_type(x)			(((x).val >> 2) & 0x1f)
-#define __swp_offset(x)			 ((x).val >> 7)
-#define __swp_entry(type,offset)	((swp_entry_t)	{ ((type) << 2) | ((offset) << 7) })
+#define __swp_type(x)			(((x).val >> 4) & 0x1f)
+#define __swp_offset(x)			 ((x).val >> 9)
+#define __swp_entry(type,offset)	((swp_entry_t)  { ((type) << 4) | ((offset) << 9) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_high })
 #define __swp_entry_to_pte(x)		((pte_t) { 0, (x).val })
 
 /*
- * Bits 0 and 1 of pte_high are taken, use the rest for the page offset...
+ * Bits 3:0 of pte_high are taken, use the rest for the page offset...
  */
-#define pte_to_pgoff(_pte)		((_pte).pte_high >> 2)
-#define pgoff_to_pte(off)		((pte_t) { _PAGE_FILE, (off) << 2 })
+#define pte_to_pgoff(_pte)		((_pte).pte_high >> 4)
+#define pgoff_to_pte(off)		((pte_t) { _PAGE_FILE, (off) << 4 })
 
-#define PTE_FILE_MAX_BITS		30
+#define PTE_FILE_MAX_BITS		28
 #else
 /*
  * Constraints:
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index a4ed2bd..2b91fd2 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -37,7 +37,11 @@
 /*
  * The following bits are directly used by the TLB hardware
  */
-#define _PAGE_GLOBAL_SHIFT	0
+#define _PAGE_NO_EXEC_SHIFT	(0)
+#define _PAGE_NO_EXEC		(1 << _PAGE_NO_EXEC_SHIFT)
+#define _PAGE_NO_READ_SHIFT	(_PAGE_NO_EXEC_SHIFT + 1)
+#define _PAGE_NO_READ		(1 << _PAGE_NO_READ_SHIFT)
+#define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
 #define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
@@ -51,7 +55,7 @@
  *
  * _PAGE_FILE semantics: set:pagecache unset:swap
  */
-#define _PAGE_PRESENT_SHIFT	(_CACHE_SHIFT + 3)
+#define _PAGE_PRESENT_SHIFT	(24)
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
 #define _PAGE_READ_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
 #define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
@@ -68,6 +72,11 @@
 
 #define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
 
+/*
+ * Bits for extended EntryLo0/EntryLo1 registers
+ */
+#define _PFNX_MASK		0xffffff
+
 #elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 /*
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 845a417..95cd47c 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -127,7 +127,7 @@ extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 
-#define pte_none(pte)		(!(((pte).pte_low | (pte).pte_high) & ~_PAGE_GLOBAL))
+#define pte_none(pte)		(!(((pte).pte_high) & ~_PAGE_GLOBAL))
 #define pte_present(pte)	((pte).pte_low & _PAGE_PRESENT)
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
@@ -136,16 +136,14 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	smp_wmb();
 	ptep->pte_low = pte.pte_low;
 
-	if (pte.pte_low & _PAGE_GLOBAL) {
+	if (pte.pte_high & _PAGE_GLOBAL) {
 		pte_t *buddy = ptep_buddy(ptep);
 		/*
 		 * Make sure the buddy is global too (if it's !none,
 		 * it better already be global)
 		 */
-		if (pte_none(*buddy)) {
-			buddy->pte_low	|= _PAGE_GLOBAL;
+		if (pte_none(*buddy))
 			buddy->pte_high |= _PAGE_GLOBAL;
-		}
 	}
 }
 
@@ -154,8 +152,8 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 	pte_t null = __pte(0);
 
 	/* Preserve global status for the pair */
-	if (ptep_buddy(ptep)->pte_low & _PAGE_GLOBAL)
-		null.pte_low = null.pte_high = _PAGE_GLOBAL;
+	if (ptep_buddy(ptep)->pte_high & _PAGE_GLOBAL)
+		null.pte_high = _PAGE_GLOBAL;
 
 	set_pte_at(mm, addr, ptep, null);
 	htw_reset();
@@ -235,21 +233,21 @@ static inline int pte_file(pte_t pte)	{ return pte.pte_low & _PAGE_FILE; }
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	pte.pte_low  &= ~(_PAGE_WRITE | _PAGE_SILENT_WRITE);
+	pte.pte_low  &= ~_PAGE_WRITE;
 	pte.pte_high &= ~_PAGE_SILENT_WRITE;
 	return pte;
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	pte.pte_low  &= ~(_PAGE_MODIFIED | _PAGE_SILENT_WRITE);
+	pte.pte_low  &= ~_PAGE_MODIFIED;
 	pte.pte_high &= ~_PAGE_SILENT_WRITE;
 	return pte;
 }
 
 static inline pte_t pte_mkold(pte_t pte)
 {
-	pte.pte_low  &= ~(_PAGE_ACCESSED | _PAGE_SILENT_READ);
+	pte.pte_low  &= ~_PAGE_ACCESSED;
 	pte.pte_high &= ~_PAGE_SILENT_READ;
 	return pte;
 }
@@ -257,30 +255,24 @@ static inline pte_t pte_mkold(pte_t pte)
 static inline pte_t pte_mkwrite(pte_t pte)
 {
 	pte.pte_low |= _PAGE_WRITE;
-	if (pte.pte_low & _PAGE_MODIFIED) {
-		pte.pte_low  |= _PAGE_SILENT_WRITE;
+	if (pte.pte_low & _PAGE_MODIFIED)
 		pte.pte_high |= _PAGE_SILENT_WRITE;
-	}
 	return pte;
 }
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
 	pte.pte_low |= _PAGE_MODIFIED;
-	if (pte.pte_low & _PAGE_WRITE) {
-		pte.pte_low  |= _PAGE_SILENT_WRITE;
+	if (pte.pte_low & _PAGE_WRITE)
 		pte.pte_high |= _PAGE_SILENT_WRITE;
-	}
 	return pte;
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte.pte_low |= _PAGE_ACCESSED;
-	if (pte.pte_low & _PAGE_READ) {
-		pte.pte_low  |= _PAGE_SILENT_READ;
+	if (pte.pte_low & _PAGE_READ)
 		pte.pte_high |= _PAGE_SILENT_READ;
-	}
 	return pte;
 }
 #else
@@ -385,10 +377,10 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	pte.pte_low  &= _PAGE_CHG_MASK;
+	pte.pte_low  &= (_PAGE_MODIFIED | _PAGE_ACCESSED | _PFNX_MASK);
 	pte.pte_high &= (_PFN_MASK | _CACHE_MASK);
-	pte.pte_low  |= pgprot_val(newprot);
-	pte.pte_high |= pgprot_val(newprot) & ~(_PFN_MASK | _CACHE_MASK);
+	pte.pte_low  |= pgprot_val(newprot) & ~_PFNX_MASK;
+	pte.pte_high |= pgprot_val(newprot) & ~_PFN_MASK;
 	return pte;
 }
 #else
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 17d7e12..9cefd36 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -503,6 +503,10 @@ static inline unsigned int decode_config5(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_EVA;
 	if (config5 & MIPS_CONF5_MRP)
 		c->options |= MIPS_CPU_MAAR;
+#ifdef CONFIG_XPA
+	if (config5 & MIPS_CONF5_MVH)
+		c->options |= MIPS_CPU_XPA;
+#endif
 
 	return config5 & MIPS_CONF_M;
 }
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 097fc8d..595ebf9 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -114,6 +114,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has_msa)	seq_printf(m, "%s", " msa");
 	if (cpu_has_eva)	seq_printf(m, "%s", " eva");
 	if (cpu_has_htw)	seq_printf(m, "%s", " htw");
+	if (cpu_has_xpa)	seq_printf(m, "%s", " xpa");
 	seq_printf(m, "\n");
 
 	if (cpu_has_mmips) {
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index ed217db..0a171dc 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -94,7 +94,7 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 	vaddr = __fix_to_virt(FIX_CMAP_END - idx);
 	pte = mk_pte(page, prot);
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
-	entrylo = pte.pte_high;
+	entrylo = pte_to_entrylo(pte.pte_high);
 #else
 	entrylo = pte_to_entrylo(pte_val(pte));
 #endif
@@ -104,6 +104,11 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 	write_c0_entryhi(vaddr & (PAGE_MASK << 1));
 	write_c0_entrylo0(entrylo);
 	write_c0_entrylo1(entrylo);
+#ifdef CONFIG_XPA
+	entrylo = (pte.pte_low & _PFNX_MASK);
+	writex_c0_entrylo0(entrylo);
+	writex_c0_entrylo1(entrylo);
+#endif
 	tlbidx = read_c0_wired();
 	write_c0_wired(tlbidx + 1);
 	write_c0_index(tlbidx);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index fa6ebd4..aab10f1 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -332,9 +332,17 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 		ptep = pte_offset_map(pmdp, address);
 
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+#ifdef CONFIG_XPA
+		write_c0_entrylo0(pte_to_entrylo(ptep->pte_high));
+		writex_c0_entrylo0(ptep->pte_low & _PFNX_MASK);
+		ptep++;
+		write_c0_entrylo1(pte_to_entrylo(ptep->pte_high));
+		writex_c0_entrylo1(ptep->pte_low & _PFNX_MASK);
+#else
 		write_c0_entrylo0(ptep->pte_high);
 		ptep++;
 		write_c0_entrylo1(ptep->pte_high);
+#endif
 #else
 		write_c0_entrylo0(pte_to_entrylo(pte_val(*ptep++)));
 		write_c0_entrylo1(pte_to_entrylo(pte_val(*ptep)));
@@ -353,6 +361,9 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 		     unsigned long entryhi, unsigned long pagemask)
 {
+#ifdef CONFIG_XPA
+	panic("Broken for XPA kernels");
+#else
 	unsigned long flags;
 	unsigned long wired;
 	unsigned long old_pagemask;
@@ -381,6 +392,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 	write_c0_pagemask(old_pagemask);
 	local_flush_tlb_all();
 	local_irq_restore(flags);
+#endif
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index b5f228e..e59bd3a 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -35,6 +35,17 @@
 #include <asm/uasm.h>
 #include <asm/setup.h>
 
+static int __cpuinitdata mips_xpa_disabled;
+
+static int __init xpa_disable(char *s)
+{
+	mips_xpa_disabled = 1;
+
+	return 1;
+}
+
+__setup("noxpa", xpa_disable);
+
 /*
  * TLB load/store/modify handlers.
  *
@@ -1026,12 +1037,27 @@ static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
 	} else {
 		int pte_off_even = sizeof(pte_t) / 2;
 		int pte_off_odd = pte_off_even + sizeof(pte_t);
+#ifdef CONFIG_XPA
+		const int scratch = 1; /* Our extra working register */
 
-		/* The pte entries are pre-shifted */
-		uasm_i_lw(p, tmp, pte_off_even, ptep); /* get even pte */
-		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-		uasm_i_lw(p, ptep, pte_off_odd, ptep); /* get odd pte */
-		UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
+		uasm_i_addu(p, scratch, 0, ptep);
+#endif
+		uasm_i_lw(p, tmp, pte_off_even, ptep); /* even pte */
+		uasm_i_lw(p, ptep, pte_off_odd, ptep); /* odd pte */
+		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
+		UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL));
+		UASM_i_MTC0(p, tmp, C0_ENTRYLO0);
+		UASM_i_MTC0(p, ptep, C0_ENTRYLO1);
+#ifdef CONFIG_XPA
+		uasm_i_lw(p, tmp, 0, scratch);
+		uasm_i_lw(p, ptep, sizeof(pte_t), scratch);
+		uasm_i_lui(p, scratch, 0xff);
+		uasm_i_ori(p, scratch, scratch, 0xffff);
+		uasm_i_and(p, tmp, scratch, tmp);
+		uasm_i_and(p, ptep, scratch, ptep);
+		uasm_i_mthc0(p, tmp, C0_ENTRYLO0);
+		uasm_i_mthc0(p, ptep, C0_ENTRYLO1);
+#endif
 	}
 #else
 	UASM_i_LW(p, tmp, 0, ptep); /* get even pte */
@@ -1532,8 +1558,14 @@ iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
 {
 #ifdef CONFIG_64BIT_PHYS_ADDR
 	unsigned int hwmode = mode & (_PAGE_VALID | _PAGE_DIRTY);
-#endif
 
+	if (!cpu_has_64bits) {
+		const int scratch = 1; /* Our extra working register */
+
+		uasm_i_lui(p, scratch, (mode >> 16));
+		uasm_i_or(p, pte, pte, scratch);
+	} else
+#endif
 	uasm_i_ori(p, pte, pte, mode);
 #ifdef CONFIG_SMP
 # ifdef CONFIG_64BIT_PHYS_ADDR
@@ -1597,15 +1629,17 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
 			uasm_il_bbit0(p, r, pte, ilog2(_PAGE_PRESENT), lid);
 			uasm_i_nop(p);
 		} else {
-			uasm_i_andi(p, t, pte, _PAGE_PRESENT);
+			uasm_i_srl(p, t, pte, _PAGE_PRESENT_SHIFT);
+			uasm_i_andi(p, t, t, 1);
 			uasm_il_beqz(p, r, t, lid);
 			if (pte == t)
 				/* You lose the SMP race :-(*/
 				iPTE_LW(p, pte, ptr);
 		}
 	} else {
-		uasm_i_andi(p, t, pte, _PAGE_PRESENT | _PAGE_READ);
-		uasm_i_xori(p, t, t, _PAGE_PRESENT | _PAGE_READ);
+		uasm_i_srl(p, t, pte, _PAGE_PRESENT_SHIFT);
+		uasm_i_andi(p, t, t, 3);
+		uasm_i_xori(p, t, t, 3);
 		uasm_il_bnez(p, r, t, lid);
 		if (pte == t)
 			/* You lose the SMP race :-(*/
@@ -1634,8 +1668,9 @@ build_pte_writable(u32 **p, struct uasm_reloc **r,
 {
 	int t = scratch >= 0 ? scratch : pte;
 
-	uasm_i_andi(p, t, pte, _PAGE_PRESENT | _PAGE_WRITE);
-	uasm_i_xori(p, t, t, _PAGE_PRESENT | _PAGE_WRITE);
+	uasm_i_srl(p, t, pte, _PAGE_PRESENT_SHIFT);
+	uasm_i_andi(p, t, t, 5);
+	uasm_i_xori(p, t, t, 5);
 	uasm_il_bnez(p, r, t, lid);
 	if (pte == t)
 		/* You lose the SMP race :-(*/
@@ -1671,7 +1706,8 @@ build_pte_modifiable(u32 **p, struct uasm_reloc **r,
 		uasm_i_nop(p);
 	} else {
 		int t = scratch >= 0 ? scratch : pte;
-		uasm_i_andi(p, t, pte, _PAGE_WRITE);
+		uasm_i_srl(p, t, pte, _PAGE_WRITE_SHIFT);
+		uasm_i_andi(p, t, t, 1);
 		uasm_il_beqz(p, r, t, lid);
 		if (pte == t)
 			/* You lose the SMP race :-(*/
@@ -2276,6 +2312,11 @@ static void config_htw_params(void)
 
 	pwsize = ilog2(PTRS_PER_PGD) << MIPS_PWSIZE_GDW_SHIFT;
 	pwsize |= ilog2(PTRS_PER_PTE) << MIPS_PWSIZE_PTW_SHIFT;
+
+	/* If XPA has been enabled, PTEs are 64-bit in size. */
+	if (read_c0_pagegrain() & PG_ELPA)
+		pwsize |= 1;
+
 	write_c0_pwsize(pwsize);
 
 	/* Make sure everything is set before we enable the HTW */
@@ -2289,6 +2330,26 @@ static void config_htw_params(void)
 	print_htw_config();
 }
 
+static void config_xpa_params(void)
+{
+	unsigned int pagegrain;
+
+	if (mips_xpa_disabled) {
+		pr_info("Extended Physical Addressing (XPA) disabled\n");
+		return;
+	}
+
+	pagegrain = read_c0_pagegrain();
+	write_c0_pagegrain(pagegrain | PG_ELPA);
+	back_to_back_c0_hazard();
+	pagegrain = read_c0_pagegrain();
+
+	if (pagegrain & PG_ELPA)
+		pr_info("Extended Physical Addressing (XPA) enabled\n");
+	else
+		panic("Extended Physical Addressing (XPA) disabled");
+}
+
 void build_tlb_refill_handler(void)
 {
 	/*
@@ -2353,8 +2414,9 @@ void build_tlb_refill_handler(void)
 		}
 		if (cpu_has_local_ebase)
 			build_r4000_tlb_refill_handler();
+		if (cpu_has_xpa)
+			config_xpa_params();
 		if (cpu_has_htw)
 			config_htw_params();
-
 	}
 }
-- 
1.7.10.4
