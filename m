Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2010 00:28:30 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11629 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493076Ab0BEX1h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Feb 2010 00:27:37 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6ca96f0003>; Fri, 05 Feb 2010 15:27:43 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 5 Feb 2010 15:27:18 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 5 Feb 2010 15:27:18 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o15NRFa5028563;
        Fri, 5 Feb 2010 15:27:15 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o15NRFGc028562;
        Fri, 5 Feb 2010 15:27:15 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/4] MIPS: Implement Read Inhibit/eXecute Inhibit
Date:   Fri,  5 Feb 2010 15:27:11 -0800
Message-Id: <1265412431-28526-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4B6CA90C.1000609@caviumnetworks.com>
References: <4B6CA90C.1000609@caviumnetworks.com>
X-OriginalArrivalTime: 05 Feb 2010 23:27:18.0059 (UTC) FILETIME=[C1E48FB0:01CAA6BA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The SmartMIPS ASE specifies how Read Inhibit (RI) and eXecute Inhibit
(XI) bits in the page tables work.  The upper two bits of EntryLo{0,1}
are RI and XI when the feature is enabled in the PageGrain register.
SmartMIPS only covers 32-bit systems.  Cavium Octeon+ extends this to
64-bit systems by continuing to place the RI and XI bits in the top of
EntryLo even when EntryLo is 64-bits wide.

This patch only targets Octeon+, but should be trivial to adapt for
and 32-bit SmartMIPS system.

Because we need to carry the RI and XI bits in the PTE, the layout of
the PTE is changed.  There is a two instruction overhead in the TLB
refill hot path to get the EntryLo bits into the proper position.
Also the TLB load exception has to probe the TLB to check if RI or XI
caused the exception.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                    |    7 ++
 arch/mips/include/asm/pgtable-64.h   |    4 +
 arch/mips/include/asm/pgtable-bits.h |   59 ++++++++++++++-
 arch/mips/include/asm/pgtable.h      |   39 +++++++++-
 arch/mips/mm/cache.c                 |   11 +++
 arch/mips/mm/fault.c                 |   23 ++++++
 arch/mips/mm/init.c                  |    2 +-
 arch/mips/mm/tlb-r4k.c               |   15 +++-
 arch/mips/mm/tlbex.c                 |  145 ++++++++++++++++++++++++++++++----
 9 files changed, 282 insertions(+), 23 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ed8d5b5..a79c424 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1484,6 +1484,13 @@ config 64BIT
 
 endchoice
 
+config USE_RI_XI_PAGE_BITS
+	bool "Use Read Inhibit (RI) and eXecute Inhibit (XI) page bits"
+	depends on CPU_CAVIUM_OCTEON
+	help
+	  This option enables the kernel to enforce PROT_EXEC and
+	  PROT_READ memory protection in mapped memory.
+
 choice
 	prompt "Kernel page size"
 	default PAGE_SIZE_4KB
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 2c1d194..9606d26 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -215,6 +215,10 @@ static inline void pud_clear(pud_t *pudp)
 #ifdef CONFIG_CPU_VR41XX
 #define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
+#elif defined(_PAGE_NO_EXEC)
+/* The NO_READ and NO_EXEC added an extra two bits */
+#define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
+#define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
 #else
 #define pte_pfn(x)		((unsigned long)((x).pte >> PAGE_SHIFT))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 1073e6d..637d4f6 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -50,7 +50,48 @@
 #define _CACHE_SHIFT                3
 #define _CACHE_MASK                 (7<<3)
 
-#else
+#elif defined(CONFIG_USE_RI_XI_PAGE_BITS)
+
+/*
+ * When using the RI/XI bit support, we have 14 bits of flags below
+ * the physical address. The RI/XI bits are places such that a SRL 6
+ * can strip off the software bits, then a ROTR 2 can move the RI/XI
+ * into bits [63:62]. This also limits physical address to 56 bits,
+ * which is more than we need right now. Octeon CSRs use 48 bits.
+ */
+#define _PAGE_PRESENT               (1<<0)  /* implemented in software */
+#define _PAGE_WRITE                 (1<<2)  /* implemented in software */
+#define _PAGE_ACCESSED              (1<<3)  /* implemented in software */
+#define _PAGE_MODIFIED              (1<<4)  /* implemented in software */
+#define _PAGE_FILE                  (1<<4)  /* set:pagecache unset:swap */
+#define _PAGE_HUGE                  (1<<5)  /* huge tlb page */
+#define _PAGE_NO_EXEC               (1<<6)  /* Page cannot be executed */
+#define _PAGE_NO_READ               (1<<7)  /* Page cannot be read */
+#define _PAGE_GLOBAL                (1<<8)
+#define _PAGE_VALID                 (1<<9)
+#define _PAGE_SILENT_READ           (1<<9)  /* synonym                 */
+#define _PAGE_DIRTY                 (1<<10) /* The MIPS dirty bit      */
+#define _PAGE_SILENT_WRITE          (1<<10)
+#define _CACHE_SHIFT                11
+#define _CACHE_MASK                 (7<<_CACHE_SHIFT)
+
+#ifndef __ASSEMBLY__
+/*
+ * pte_to_entrylo converts a page table entry (PTE) into a Mips
+ * entrylo0/1 value.
+ */
+static inline uint64_t pte_to_entrylo(unsigned long pte_val)
+{
+	/*
+	 * C has no way to express that this is a DSRL 6 followed by a
+	 * ROTR 2.  Luckily in the fast path this is done in
+	 * assembly
+	 */
+	return (pte_val >> 8) | ((pte_val & (_PAGE_NO_EXEC | _PAGE_NO_READ)) << 56);
+}
+#endif
+
+#else /* !CONFIG_USE_RI_XI_PAGE_BITS */
 
 #define _PAGE_PRESENT               (1<<0)  /* implemented in software */
 #define _PAGE_READ                  (1<<1)  /* implemented in software */
@@ -82,6 +123,18 @@
 #define _CACHE_MASK                 (7<<9)
 
 #endif
+
+#ifndef __ASSEMBLY__
+/*
+ * pte_to_entrylo converts a page table entry (PTE) into a Mips
+ * entrylo0/1 value.
+ */
+static inline uint64_t pte_to_entrylo(unsigned long pte_val)
+{
+	return pte_val >> 6;
+}
+#endif
+
 #endif /* defined(CONFIG_64BIT_PHYS_ADDR && defined(CONFIG_CPU_MIPS32) */
 
 
@@ -130,7 +183,11 @@
 
 #endif
 
+#ifdef _PAGE_NO_READ
+#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED)
+#else
 #define __READABLE	(_PAGE_READ | _PAGE_SILENT_READ | _PAGE_ACCESSED)
+#endif
 #define __WRITEABLE	(_PAGE_WRITE | _PAGE_SILENT_WRITE | _PAGE_MODIFIED)
 
 #define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 02335fd..9c2e5c9 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -21,6 +21,31 @@
 struct mm_struct;
 struct vm_area_struct;
 
+#ifdef _PAGE_NO_READ
+#define PAGE_BASE_FLAGS (_PAGE_PRESENT | _page_cachable_default)
+#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
+#define PAGE_SHARED	__pgprot(PAGE_BASE_FLAGS | _PAGE_WRITE)
+#define PAGE_COPY __pgprot(PAGE_BASE_FLAGS | _PAGE_NO_EXEC)
+#define PAGE_READONLY __pgprot(PAGE_BASE_FLAGS)
+#define PAGE_KERNEL __pgprot(PAGE_BASE_FLAGS | __READABLE | __WRITEABLE | _PAGE_GLOBAL)
+#define __P000	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ)
+#define __P001	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC)
+#define __P010	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ)
+#define __P011	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC)
+#define __P100	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ)
+#define __P101	__pgprot(_PAGE_PRESENT)
+#define __P110	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ)
+#define __P111	__pgprot(_PAGE_PRESENT)
+
+#define __S000	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ)
+#define __S001	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC)
+#define __S010	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ)
+#define __S011	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE)
+#define __S100	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ)
+#define __S101	__pgprot(_PAGE_PRESENT)
+#define __S110	__pgprot(_PAGE_PRESENT | _PAGE_WRITE  | _PAGE_NO_READ)
+#define __S111	__pgprot(_PAGE_PRESENT | _PAGE_WRITE)
+#else
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
 				 _page_cachable_default)
@@ -36,9 +61,10 @@ struct vm_area_struct;
 			__WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
 
 /*
- * MIPS can't do page protection for execute, and considers that the same like
- * read. Also, write permissions imply read permissions. This is the closest
- * we can get by reasonable means..
+ * If _PAGE_NO_EXEC is not defined, we can't do page protection for
+ * execute, and consider it to be the same as read. Also, write
+ * permissions imply read permissions. This is the closest we can get
+ * by reasonable means..
  */
 
 /*
@@ -63,6 +89,8 @@ struct vm_area_struct;
 #define __S110 __pgprot(0)
 #define __S111 __pgprot(0)
 
+#endif
+
 extern unsigned long _page_cachable_default;
 
 /*
@@ -298,8 +326,13 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
+#ifdef _PAGE_NO_READ
+	if (!(pte_val(pte) & _PAGE_NO_READ))
+		pte_val(pte) |= _PAGE_SILENT_READ;
+#else
 	if (pte_val(pte) & _PAGE_READ)
 		pte_val(pte) |= _PAGE_SILENT_READ;
+#endif
 	return pte;
 }
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index e716caf..31d7f0f 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -137,6 +137,16 @@ EXPORT_SYMBOL_GPL(_page_cachable_default);
 
 static inline void setup_protection_map(void)
 {
+#ifdef _PAGE_NO_READ
+	/*
+	 * It was statically initialized with everything but the
+	 * _page_cachable_default bits.
+	 */
+	int i;
+	for (i = 0; i < 16; i++)
+		protection_map[i] = __pgprot(pgprot_val(protection_map[i]) |
+					_page_cachable_default);
+#else
 	protection_map[0] = PAGE_NONE;
 	protection_map[1] = PAGE_READONLY;
 	protection_map[2] = PAGE_COPY;
@@ -153,6 +163,7 @@ static inline void setup_protection_map(void)
 	protection_map[13] = PAGE_READONLY;
 	protection_map[14] = PAGE_SHARED;
 	protection_map[15] = PAGE_SHARED;
+#endif
 }
 
 void __cpuinit cpu_cache_init(void)
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index e97a7a2..24990be 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -99,8 +99,31 @@ good_area:
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
+#ifdef _PAGE_NO_READ
+		if (address == regs->cp0_epc && !(vma->vm_flags & VM_EXEC)) {
+#if 0
+			pr_notice("Cpu%d[%s:%d:%0*lx:%ld:%0*lx] XI violation\n",
+				  raw_smp_processor_id(),
+				  current->comm, current->pid,
+				  field, address, write,
+				  field, regs->cp0_epc);
+#endif
+			goto bad_area;
+		}
+		if (!(vma->vm_flags & VM_READ)) {
+#if 0
+			pr_notice("Cpu%d[%s:%d:%0*lx:%ld:%0*lx] RI violation\n",
+				  raw_smp_processor_id(),
+				  current->comm, current->pid,
+				  field, address, write,
+				  field, regs->cp0_epc);
+#endif
+			goto bad_area;
+		}
+#else
 		if (!(vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)))
 			goto bad_area;
+#endif
 	}
 
 	/*
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 3c5b7de..9a8e9f1 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -143,7 +143,7 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 	entrylo = pte.pte_high;
 #else
-	entrylo = pte_val(pte) >> 6;
+	entrylo = pte_to_entrylo(pte.pte);
 #endif
 
 	ENTER_CRITICAL(flags);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index e551559..c9ae7a8 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -303,7 +303,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 		unsigned long lo;
 		write_c0_pagemask(PM_HUGE_MASK);
 		ptep = (pte_t *)pmdp;
-		lo = pte_val(*ptep) >> 6;
+		lo = pte_to_entrylo(pte_val(*ptep));
 		write_c0_entrylo0(lo);
 		write_c0_entrylo1(lo + (HPAGE_SIZE >> 7));
 
@@ -323,8 +323,8 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 		ptep++;
 		write_c0_entrylo1(ptep->pte_high);
 #else
-		write_c0_entrylo0(pte_val(*ptep++) >> 6);
-		write_c0_entrylo1(pte_val(*ptep) >> 6);
+		write_c0_entrylo0(pte_to_entrylo(pte_val(*ptep++)));
+		write_c0_entrylo1(pte_to_entrylo(pte_val(*ptep)));
 #endif
 		mtc0_tlbw_hazard();
 		if (idx < 0)
@@ -439,6 +439,15 @@ void __cpuinit tlb_init(void)
 	    current_cpu_type() == CPU_R12000 ||
 	    current_cpu_type() == CPU_R14000)
 		write_c0_framemask(0);
+
+#ifdef _PAGE_NO_READ
+	/*
+	 * Enable the no read, no exec bits, and enable large virtual
+	 * address.
+	 */
+	write_c0_pagegrain(PG_RIE | PG_XIE | PG_ELPA);
+#endif
+
 	temp_tlb_entry = current_cpu_data.tlbsize - 1;
 
         /* From this point on the ARC firmware is dead.  */
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 35431e1..3ee26aa 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -76,6 +76,8 @@ enum label_id {
 	label_vmalloc_done,
 	label_tlbw_hazard,
 	label_split,
+	label_tlbl_goaround1,
+	label_tlbl_goaround2,
 	label_nopage_tlbl,
 	label_nopage_tlbs,
 	label_nopage_tlbm,
@@ -92,6 +94,8 @@ UASM_L_LA(_vmalloc)
 UASM_L_LA(_vmalloc_done)
 UASM_L_LA(_tlbw_hazard)
 UASM_L_LA(_split)
+UASM_L_LA(_tlbl_goaround1)
+UASM_L_LA(_tlbl_goaround2)
 UASM_L_LA(_nopage_tlbl)
 UASM_L_LA(_nopage_tlbs)
 UASM_L_LA(_nopage_tlbm)
@@ -397,6 +401,28 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
+
+static __cpuinit void build_restore_pagemask(u32 **p,
+					     struct uasm_reloc **r,
+					     unsigned int tmp,
+					     enum label_id lid)
+{
+	/* Reset default page size */
+	if (PM_DEFAULT_MASK >> 16) {
+		uasm_i_lui(p, tmp, PM_DEFAULT_MASK >> 16);
+		uasm_i_ori(p, tmp, tmp, PM_DEFAULT_MASK & 0xffff);
+		uasm_il_b(p, r, lid);
+		uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+	} else if (PM_DEFAULT_MASK) {
+		uasm_i_ori(p, tmp, 0, PM_DEFAULT_MASK);
+		uasm_il_b(p, r, lid);
+		uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+	} else {
+		uasm_il_b(p, r, lid);
+		uasm_i_mtc0(p, 0, C0_PAGEMASK);
+	}
+}
+
 static __cpuinit void build_huge_tlb_write_entry(u32 **p,
 						 struct uasm_label **l,
 						 struct uasm_reloc **r,
@@ -410,20 +436,7 @@ static __cpuinit void build_huge_tlb_write_entry(u32 **p,
 
 	build_tlb_write_entry(p, l, r, wmode);
 
-	/* Reset default page size */
-	if (PM_DEFAULT_MASK >> 16) {
-		uasm_i_lui(p, tmp, PM_DEFAULT_MASK >> 16);
-		uasm_i_ori(p, tmp, tmp, PM_DEFAULT_MASK & 0xffff);
-		uasm_il_b(p, r, label_leave);
-		uasm_i_mtc0(p, tmp, C0_PAGEMASK);
-	} else if (PM_DEFAULT_MASK) {
-		uasm_i_ori(p, tmp, 0, PM_DEFAULT_MASK);
-		uasm_il_b(p, r, label_leave);
-		uasm_i_mtc0(p, tmp, C0_PAGEMASK);
-	} else {
-		uasm_il_b(p, r, label_leave);
-		uasm_i_mtc0(p, 0, C0_PAGEMASK);
-	}
+	build_restore_pagemask(p, r, tmp, label_leave);
 }
 
 /*
@@ -459,7 +472,7 @@ static __cpuinit void build_huge_update_entries(u32 **p,
 	if (!small_sequence)
 		uasm_i_lui(p, tmp, HPAGE_SIZE >> (7 + 16));
 
-	UASM_i_SRL(p, pte, pte, 6); /* convert to entrylo */
+	build_convert_pte_to_entrylo(p, pte);
 	UASM_i_MTC0(p, pte, C0_ENTRYLO0); /* load it */
 	/* convert to entrylo1 */
 	if (small_sequence)
@@ -674,6 +687,19 @@ static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr
 	UASM_i_ADDU(p, ptr, ptr, tmp); /* add in offset */
 }
 
+static __cpuinit __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
+								  unsigned int reg)
+{
+#ifdef _PAGE_NO_READ
+	uasm_i_dsrl(p, reg, reg, ilog2(_PAGE_NO_EXEC));
+	uasm_i_drotr(p, reg, reg, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+#elif defined(CONFIG_64BIT_PHYS_ADDR)
+	uasm_i_dsrl(p, reg, reg, 6);
+#else
+	uasm_i_SRL(p, reg, reg, 6);
+#endif
+}
+
 static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 					unsigned int ptep)
 {
@@ -685,9 +711,17 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 	if (cpu_has_64bits) {
 		uasm_i_ld(p, tmp, 0, ptep); /* get even pte */
 		uasm_i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
+#ifdef _PAGE_NO_READ
+		uasm_i_dsrl(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
+		uasm_i_dsrl(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
+		uasm_i_drotr(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
+		uasm_i_drotr(p, ptep, ptep, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+#else
 		uasm_i_dsrl(p, tmp, tmp, 6); /* convert to entrylo0 */
 		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
 		uasm_i_dsrl(p, ptep, ptep, 6); /* convert to entrylo1 */
+#endif
 		UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
 	} else {
 		int pte_off_even = sizeof(pte_t) / 2;
@@ -704,6 +738,15 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 	UASM_i_LW(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
 	if (r45k_bvahwbug())
 		build_tlb_probe_entry(p);
+#ifdef _PAGE_NO_READ
+	uasm_i_dsrl(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
+	uasm_i_dsrl(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
+	uasm_i_drotr(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+	if (r4k_250MHZhwbug())
+		UASM_i_MTC0(p, 0, C0_ENTRYLO0);
+	UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
+	uasm_i_drotr(p, ptep, ptep, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+#else
 	UASM_i_SRL(p, tmp, tmp, 6); /* convert to entrylo0 */
 	if (r4k_250MHZhwbug())
 		UASM_i_MTC0(p, 0, C0_ENTRYLO0);
@@ -711,6 +754,7 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 	UASM_i_SRL(p, ptep, ptep, 6); /* convert to entrylo1 */
 	if (r45k_bvahwbug())
 		uasm_i_mfc0(p, tmp, C0_INDEX);
+#endif
 	if (r4k_250MHZhwbug())
 		UASM_i_MTC0(p, 0, C0_ENTRYLO1);
 	UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
@@ -989,9 +1033,14 @@ static void __cpuinit
 build_pte_present(u32 **p, struct uasm_reloc **r,
 		  unsigned int pte, unsigned int ptr, enum label_id lid)
 {
+#ifdef _PAGE_NO_READ
+	uasm_i_andi(p, pte, pte, _PAGE_PRESENT);
+	uasm_il_beqz(p, r, pte, lid);
+#else
 	uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
 	uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
 	uasm_il_bnez(p, r, pte, lid);
+#endif
 	iPTE_LW(p, pte, ptr);
 }
 
@@ -1279,6 +1328,36 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	build_pte_present(&p, &r, K0, K1, label_nopage_tlbl);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
+
+#ifdef _PAGE_NO_READ
+	/*
+	 * If the page is not _PAGE_VALID, RI or XI could not have
+	 * triggered it.  Skip the expensive test..
+	 */
+	uasm_i_andi(&p, K0, K0, _PAGE_VALID);
+	uasm_il_beqz(&p, &r, K0, label_tlbl_goaround1);
+
+	uasm_i_nop(&p);
+	uasm_i_tlbr(&p);
+	/* Examine  entrylo 0 or 1 based on ptr. */
+	uasm_i_andi(&p, K0, K1, sizeof(pte_t));
+	uasm_i_beqz(&p, K0, 8);
+
+	UASM_i_MFC0(&p, K0, C0_ENTRYLO0); /* load it in the delay slot*/
+	UASM_i_MFC0(&p, K0, C0_ENTRYLO1); /* load it if ptr is odd */
+	/*
+	 * If the entryLo (now in K0) is valid (bit 1), RI or XI must
+	 * have triggered it.
+	 */
+	uasm_i_andi(&p, K0, K0, 2);
+	uasm_il_bnez(&p, &r, K0, label_nopage_tlbl);
+
+
+	uasm_l_tlbl_goaround1(&l, p);
+	/* Reload the PTE value */
+	iPTE_LW(&p, K0, K1);
+
+#endif
 	build_make_valid(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
@@ -1291,6 +1370,42 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	iPTE_LW(&p, K0, K1);
 	build_pte_present(&p, &r, K0, K1, label_nopage_tlbl);
 	build_tlb_probe_entry(&p);
+
+#ifdef _PAGE_NO_READ
+	/*
+	 * If the page is not _PAGE_VALID, RI or XI could not have
+	 * triggered it.  Skip the expensive test..
+	 */
+	uasm_i_andi(&p, K0, K0, _PAGE_VALID);
+	uasm_il_beqz(&p, &r, K0, label_tlbl_goaround2);
+
+	uasm_i_nop(&p);
+	uasm_i_tlbr(&p);
+	/* Examine  entrylo 0 or 1 based on ptr. */
+	uasm_i_andi(&p, K0, K1, sizeof(pte_t));
+	uasm_i_beqz(&p, K0, 8);
+
+	UASM_i_MFC0(&p, K0, C0_ENTRYLO0); /* load it in the delay slot*/
+	UASM_i_MFC0(&p, K0, C0_ENTRYLO1); /* load it if ptr is odd */
+	/*
+	 * If the entryLo (now in K0) is valid (bit 1), RI or XI must
+	 * have triggered it.
+	 */
+	uasm_i_andi(&p, K0, K0, 2);
+	uasm_il_beqz(&p, &r, K0, label_tlbl_goaround2);
+	/* Reload the PTE value */
+	iPTE_LW(&p, K0, K1);
+
+	/*
+	 * We clobbered C0_PAGEMASK, restore it.  On the other branch
+	 * it is restored in build_huge_tlb_write_entry.
+	 */
+	build_restore_pagemask(&p, &r, K0, label_nopage_tlbl, 0);
+
+	uasm_l_tlbl_goaround2(&l, p);
+
+#endif
+
 	uasm_i_ori(&p, K0, K0, (_PAGE_ACCESSED | _PAGE_VALID));
 	build_huge_handler_tail(&p, &r, &l, K0, K1);
 #endif
-- 
1.6.0.6
