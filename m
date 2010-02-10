Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2010 00:14:44 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15981 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492365Ab0BJXNv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2010 00:13:51 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b733db50003>; Wed, 10 Feb 2010 15:13:57 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:12:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:12:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1ANCofT005835;
        Wed, 10 Feb 2010 15:12:50 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1ANCoen005834;
        Wed, 10 Feb 2010 15:12:50 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/6] MIPS: Implement Read Inhibit/eXecute Inhibit
Date:   Wed, 10 Feb 2010 15:12:47 -0800
Message-Id: <1265843569-5786-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <4B733C71.8030304@caviumnetworks.com>
References: <4B733C71.8030304@caviumnetworks.com>
X-OriginalArrivalTime: 10 Feb 2010 23:12:52.0425 (UTC) FILETIME=[92000B90:01CAAAA6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25906
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

Because we need to carry the RI and XI bits in the PTE, the layout of
the PTE is changed.  There is a two instruction overhead in the TLB
refill hot path to get the EntryLo bits into the proper position.
Also the TLB load exception has to probe the TLB to check if RI or XI
caused the exception.

Also of note is that the layout of the PTE bits is done at compile and
runtime rather than statically.  In the 32-bit case this allows for
the same number of PFN bits as before the patch as the _PAGE_HUGE is
not supported in 32-bit kernels (we have _PAGE_NO_EXEC and
_PAGE_NO_READ instead of _PAGE_READ and _PAGE_HUGE).

The patch is tested on Cavium Octeon+, but should also work on 32-bit
systems with the Smart-MIPS ASE.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cpu-features.h |    3 +
 arch/mips/include/asm/pgtable-32.h   |    4 +-
 arch/mips/include/asm/pgtable-64.h   |    4 +-
 arch/mips/include/asm/pgtable-bits.h |  105 ++++++++++++++++++---
 arch/mips/include/asm/pgtable.h      |   26 +++--
 arch/mips/mm/cache.c                 |   53 ++++++++---
 arch/mips/mm/fault.c                 |   27 +++++-
 arch/mips/mm/init.c                  |    2 +-
 arch/mips/mm/tlb-r4k.c               |   19 +++-
 arch/mips/mm/tlbex.c                 |  169 ++++++++++++++++++++++++++++------
 10 files changed, 333 insertions(+), 79 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 272c5ef..ac73ced 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -95,6 +95,9 @@
 #ifndef cpu_has_smartmips
 #define cpu_has_smartmips      (cpu_data[0].ases & MIPS_ASE_SMARTMIPS)
 #endif
+#ifndef kernel_uses_smartmips_rixi
+#define kernel_uses_smartmips_rixi 0
+#endif
 #ifndef cpu_has_vtag_icache
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
 #endif
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 55813d6..ae90412 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -127,8 +127,8 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
 #else
-#define pte_pfn(x)		((unsigned long)((x).pte >> PAGE_SHIFT))
-#define pfn_pte(pfn, prot)	__pte(((unsigned long long)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pte_pfn(x)		((unsigned long)((x).pte >> _PFN_SHIFT))
+#define pfn_pte(pfn, prot)	__pte(((unsigned long long)(pfn) << _PFN_SHIFT) | pgprot_val(prot))
 #endif
 #endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 2c1d194..adc2093 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -216,8 +216,8 @@ static inline void pud_clear(pud_t *pudp)
 #define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
 #else
-#define pte_pfn(x)		((unsigned long)((x).pte >> PAGE_SHIFT))
-#define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pte_pfn(x)		((unsigned long)((x).pte >> _PFN_SHIFT))
+#define pfn_pte(pfn, prot)	__pte(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
 #endif
 
 #define __pgd_offset(address)	pgd_index(address)
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 1073e6d..a2e646f 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -50,7 +50,7 @@
 #define _CACHE_SHIFT                3
 #define _CACHE_MASK                 (7<<3)
 
-#else
+#elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 #define _PAGE_PRESENT               (1<<0)  /* implemented in software */
 #define _PAGE_READ                  (1<<1)  /* implemented in software */
@@ -59,8 +59,6 @@
 #define _PAGE_MODIFIED              (1<<4)  /* implemented in software */
 #define _PAGE_FILE                  (1<<4)  /* set:pagecache unset:swap */
 
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
-
 #define _PAGE_GLOBAL                (1<<8)
 #define _PAGE_VALID                 (1<<9)
 #define _PAGE_SILENT_READ           (1<<9)  /* synonym                 */
@@ -68,22 +66,99 @@
 #define _PAGE_SILENT_WRITE          (1<<10)
 #define _CACHE_UNCACHED             (1<<11)
 #define _CACHE_MASK                 (1<<11)
+#define _PFN_SHIFT                  PAGE_SHIFT
+
+#else /* 'Normal' r4K case */
+/*
+ * When using the RI/XI bit support, we have 13 bits of flags below
+ * the physical address. The RI/XI bits are placed such that a SRL 5
+ * can strip off the software bits, then a ROTR 2 can move the RI/XI
+ * into bits [63:62]. This also limits physical address to 56 bits,
+ * which is more than we need right now.
+ */
 
+/* implemented in software */
+#define _PAGE_PRESENT_SHIFT	(0)
+#define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
+/* implemented in software, should be unused if kernel_uses_smartmips_rixi. */
+#define _PAGE_READ_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_PRESENT_SHIFT : _PAGE_PRESENT_SHIFT + 1)
+#define _PAGE_READ ({if (kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_READ_SHIFT; })
+/* implemented in software */
+#define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
+#define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
+/* implemented in software */
+#define _PAGE_ACCESSED_SHIFT	(_PAGE_WRITE_SHIFT + 1)
+#define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
+/* implemented in software */
+#define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
+#define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
+/* set:pagecache unset:swap */
+#define _PAGE_FILE		(_PAGE_MODIFIED)
+
+#ifdef CONFIG_HUGETLB_PAGE
+/* huge tlb page */
+#define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
+#define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
 #else
+#define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT)
+#define _PAGE_HUGE		({BUG(); 1; })  /* Dummy value */
+#endif
 
-#define _PAGE_R4KBUG                (1<<5)  /* workaround for r4k bug  */
-#define _PAGE_HUGE                  (1<<5)  /* huge tlb page */
-#define _PAGE_GLOBAL                (1<<6)
-#define _PAGE_VALID                 (1<<7)
-#define _PAGE_SILENT_READ           (1<<7)  /* synonym                 */
-#define _PAGE_DIRTY                 (1<<8)  /* The MIPS dirty bit      */
-#define _PAGE_SILENT_WRITE          (1<<8)
-#define _CACHE_SHIFT		    9
-#define _CACHE_MASK                 (7<<9)
+/* Page cannot be executed */
+#define _PAGE_NO_EXEC_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_HUGE_SHIFT + 1 : _PAGE_HUGE_SHIFT)
+#define _PAGE_NO_EXEC		({if (!kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_NO_EXEC_SHIFT; })
+
+/* Page cannot be read */
+#define _PAGE_NO_READ_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
+#define _PAGE_NO_READ		({if (!kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_NO_READ_SHIFT; })
+
+#define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
+#define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
+
+#define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
+#define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
+/* synonym                 */
+#define _PAGE_SILENT_READ	(_PAGE_VALID)
+
+/* The MIPS dirty bit      */
+#define _PAGE_DIRTY_SHIFT	(_PAGE_VALID_SHIFT + 1)
+#define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)
+#define _PAGE_SILENT_WRITE	(_PAGE_DIRTY)
+
+#define _CACHE_SHIFT		(_PAGE_DIRTY_SHIFT + 1)
+#define _CACHE_MASK		(7 << _CACHE_SHIFT)
+
+#define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
+#define _PFN_MASK		(~((1 << (_PFN_SHIFT)) - 1))
 
-#endif
 #endif /* defined(CONFIG_64BIT_PHYS_ADDR && defined(CONFIG_CPU_MIPS32) */
 
+#ifndef __ASSEMBLY__
+/*
+ * pte_to_entrylo converts a page table entry (PTE) into a Mips
+ * entrylo0/1 value.
+ */
+static inline uint64_t pte_to_entrylo(unsigned long pte_val)
+{
+	if (kernel_uses_smartmips_rixi) {
+		int sa;
+#ifdef CONFIG_32BIT
+		sa = 31 - _PAGE_NO_READ_SHIFT;
+#else
+		sa = 63 - _PAGE_NO_READ_SHIFT;
+#endif
+		/*
+		 * C has no way to express that this is a DSRL 5
+		 * followed by a ROTR 2.  Luckily in the fast path
+		 * this is done in assembly
+		 */
+		return (pte_val >> _PAGE_GLOBAL_SHIFT) |
+			((pte_val & (_PAGE_NO_EXEC | _PAGE_NO_READ)) << sa);
+	}
+
+	return pte_val >> _PAGE_GLOBAL_SHIFT;
+}
+#endif
 
 /*
  * Cache attributes
@@ -130,9 +205,9 @@
 
 #endif
 
-#define __READABLE	(_PAGE_READ | _PAGE_SILENT_READ | _PAGE_ACCESSED)
+#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ))
 #define __WRITEABLE	(_PAGE_WRITE | _PAGE_SILENT_WRITE | _PAGE_MODIFIED)
 
-#define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
+#define _PAGE_CHG_MASK  (_PFN_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
 
 #endif /* _ASM_PGTABLE_BITS_H */
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 02335fd..93598ba 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -22,23 +22,24 @@ struct mm_struct;
 struct vm_area_struct;
 
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
 				 _page_cachable_default)
-#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_READ | \
-				 _page_cachable_default)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_READ | \
+#define PAGE_COPY	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
+				 (kernel_uses_smartmips_rixi ?  _PAGE_NO_EXEC : 0) | _page_cachable_default)
+#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
 				 _page_cachable_default)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _page_cachable_default)
-#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | _PAGE_WRITE | \
 				 _page_cachable_default)
 #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
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
@@ -298,8 +299,13 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
-	if (pte_val(pte) & _PAGE_READ)
-		pte_val(pte) |= _PAGE_SILENT_READ;
+	if (kernel_uses_smartmips_rixi) {
+		if (!(pte_val(pte) & _PAGE_NO_READ))
+			pte_val(pte) |= _PAGE_SILENT_READ;
+	} else {
+		if (pte_val(pte) & _PAGE_READ)
+			pte_val(pte) |= _PAGE_SILENT_READ;
+	}
 	return pte;
 }
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index e716caf..be8627b 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -137,22 +137,43 @@ EXPORT_SYMBOL_GPL(_page_cachable_default);
 
 static inline void setup_protection_map(void)
 {
-	protection_map[0] = PAGE_NONE;
-	protection_map[1] = PAGE_READONLY;
-	protection_map[2] = PAGE_COPY;
-	protection_map[3] = PAGE_COPY;
-	protection_map[4] = PAGE_READONLY;
-	protection_map[5] = PAGE_READONLY;
-	protection_map[6] = PAGE_COPY;
-	protection_map[7] = PAGE_COPY;
-	protection_map[8] = PAGE_NONE;
-	protection_map[9] = PAGE_READONLY;
-	protection_map[10] = PAGE_SHARED;
-	protection_map[11] = PAGE_SHARED;
-	protection_map[12] = PAGE_READONLY;
-	protection_map[13] = PAGE_READONLY;
-	protection_map[14] = PAGE_SHARED;
-	protection_map[15] = PAGE_SHARED;
+	if (kernel_uses_smartmips_rixi) {
+		protection_map[0]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
+		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
+		protection_map[2]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
+		protection_map[3]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
+		protection_map[4]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_READ);
+		protection_map[5]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
+		protection_map[6]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_READ);
+		protection_map[7]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
+
+		protection_map[8]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
+		protection_map[9]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
+		protection_map[10] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
+		protection_map[11] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
+		protection_map[12] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_READ);
+		protection_map[13] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
+		protection_map[14] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE  | _PAGE_NO_READ);
+		protection_map[15] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
+
+	} else {
+		protection_map[0] = PAGE_NONE;
+		protection_map[1] = PAGE_READONLY;
+		protection_map[2] = PAGE_COPY;
+		protection_map[3] = PAGE_COPY;
+		protection_map[4] = PAGE_READONLY;
+		protection_map[5] = PAGE_READONLY;
+		protection_map[6] = PAGE_COPY;
+		protection_map[7] = PAGE_COPY;
+		protection_map[8] = PAGE_NONE;
+		protection_map[9] = PAGE_READONLY;
+		protection_map[10] = PAGE_SHARED;
+		protection_map[11] = PAGE_SHARED;
+		protection_map[12] = PAGE_READONLY;
+		protection_map[13] = PAGE_READONLY;
+		protection_map[14] = PAGE_SHARED;
+		protection_map[15] = PAGE_SHARED;
+	}
 }
 
 void __cpuinit cpu_cache_init(void)
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index e97a7a2..b78f7d9 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -99,8 +99,31 @@ good_area:
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-		if (!(vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)))
-			goto bad_area;
+		if (kernel_uses_smartmips_rixi) {
+			if (address == regs->cp0_epc && !(vma->vm_flags & VM_EXEC)) {
+#if 0
+				pr_notice("Cpu%d[%s:%d:%0*lx:%ld:%0*lx] XI violation\n",
+					  raw_smp_processor_id(),
+					  current->comm, current->pid,
+					  field, address, write,
+					  field, regs->cp0_epc);
+#endif
+				goto bad_area;
+			}
+			if (!(vma->vm_flags & VM_READ)) {
+#if 0
+				pr_notice("Cpu%d[%s:%d:%0*lx:%ld:%0*lx] RI violation\n",
+					  raw_smp_processor_id(),
+					  current->comm, current->pid,
+					  field, address, write,
+					  field, regs->cp0_epc);
+#endif
+				goto bad_area;
+			}
+		} else {
+			if (!(vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)))
+				goto bad_area;
+		}
 	}
 
 	/*
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 3c5b7de..f34c264 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -143,7 +143,7 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 	entrylo = pte.pte_high;
 #else
-	entrylo = pte_val(pte) >> 6;
+	entrylo = pte_to_entrylo(pte_val(pte));
 #endif
 
 	ENTER_CRITICAL(flags);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index e551559..1032e71 100644
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
@@ -439,6 +439,19 @@ void __cpuinit tlb_init(void)
 	    current_cpu_type() == CPU_R12000 ||
 	    current_cpu_type() == CPU_R14000)
 		write_c0_framemask(0);
+
+	if (kernel_uses_smartmips_rixi) {
+		/*
+		 * Enable the no read, no exec bits, and enable large virtual
+		 * address.
+		 */
+		u32 pg = PG_RIE | PG_XIE;
+#ifdef CONFIG_64BIT
+		pg |= PG_ELPA;
+#endif
+		write_c0_pagegrain(pg);
+	}
+
 	temp_tlb_entry = current_cpu_data.tlbsize - 1;
 
         /* From this point on the ARC firmware is dead.  */
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 35431e1..ec60bd5 100644
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
@@ -396,36 +400,60 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	}
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
-static __cpuinit void build_huge_tlb_write_entry(u32 **p,
-						 struct uasm_label **l,
-						 struct uasm_reloc **r,
-						 unsigned int tmp,
-						 enum tlb_write_entry wmode)
+static __cpuinit __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
+								  unsigned int reg)
 {
-	/* Set huge page tlb entry size */
-	uasm_i_lui(p, tmp, PM_HUGE_MASK >> 16);
-	uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);
-	uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+	if (kernel_uses_smartmips_rixi) {
+		UASM_i_SRL(p, reg, reg, ilog2(_PAGE_NO_EXEC));
+		UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+	} else {
+#ifdef CONFIG_64BIT_PHYS_ADDR
+		uasm_i_dsrl(p, reg, reg, ilog2(_PAGE_GLOBAL));
+#else
+		UASM_i_SRL(p, reg, reg, ilog2(_PAGE_GLOBAL));
+#endif
+	}
+}
 
-	build_tlb_write_entry(p, l, r, wmode);
+#ifdef CONFIG_HUGETLB_PAGE
 
+static __cpuinit void build_restore_pagemask(u32 **p,
+					     struct uasm_reloc **r,
+					     unsigned int tmp,
+					     enum label_id lid)
+{
 	/* Reset default page size */
 	if (PM_DEFAULT_MASK >> 16) {
 		uasm_i_lui(p, tmp, PM_DEFAULT_MASK >> 16);
 		uasm_i_ori(p, tmp, tmp, PM_DEFAULT_MASK & 0xffff);
-		uasm_il_b(p, r, label_leave);
+		uasm_il_b(p, r, lid);
 		uasm_i_mtc0(p, tmp, C0_PAGEMASK);
 	} else if (PM_DEFAULT_MASK) {
 		uasm_i_ori(p, tmp, 0, PM_DEFAULT_MASK);
-		uasm_il_b(p, r, label_leave);
+		uasm_il_b(p, r, lid);
 		uasm_i_mtc0(p, tmp, C0_PAGEMASK);
 	} else {
-		uasm_il_b(p, r, label_leave);
+		uasm_il_b(p, r, lid);
 		uasm_i_mtc0(p, 0, C0_PAGEMASK);
 	}
 }
 
+static __cpuinit void build_huge_tlb_write_entry(u32 **p,
+						 struct uasm_label **l,
+						 struct uasm_reloc **r,
+						 unsigned int tmp,
+						 enum tlb_write_entry wmode)
+{
+	/* Set huge page tlb entry size */
+	uasm_i_lui(p, tmp, PM_HUGE_MASK >> 16);
+	uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);
+	uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+
+	build_tlb_write_entry(p, l, r, wmode);
+
+	build_restore_pagemask(p, r, tmp, label_leave);
+}
+
 /*
  * Check if Huge PTE is present, if so then jump to LABEL.
  */
@@ -459,7 +487,7 @@ static __cpuinit void build_huge_update_entries(u32 **p,
 	if (!small_sequence)
 		uasm_i_lui(p, tmp, HPAGE_SIZE >> (7 + 16));
 
-	UASM_i_SRL(p, pte, pte, 6); /* convert to entrylo */
+	build_convert_pte_to_entrylo(p, pte);
 	UASM_i_MTC0(p, pte, C0_ENTRYLO0); /* load it */
 	/* convert to entrylo1 */
 	if (small_sequence)
@@ -685,9 +713,17 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 	if (cpu_has_64bits) {
 		uasm_i_ld(p, tmp, 0, ptep); /* get even pte */
 		uasm_i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
-		uasm_i_dsrl(p, tmp, tmp, 6); /* convert to entrylo0 */
-		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-		uasm_i_dsrl(p, ptep, ptep, 6); /* convert to entrylo1 */
+		if (kernel_uses_smartmips_rixi) {
+			UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
+			UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
+			UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+			UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
+			UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+		} else {
+			uasm_i_dsrl(p, tmp, tmp, ilog2(_PAGE_GLOBAL)); /* convert to entrylo0 */
+			UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
+			uasm_i_dsrl(p, ptep, ptep, ilog2(_PAGE_GLOBAL)); /* convert to entrylo1 */
+		}
 		UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
 	} else {
 		int pte_off_even = sizeof(pte_t) / 2;
@@ -704,13 +740,23 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 	UASM_i_LW(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
 	if (r45k_bvahwbug())
 		build_tlb_probe_entry(p);
-	UASM_i_SRL(p, tmp, tmp, 6); /* convert to entrylo0 */
-	if (r4k_250MHZhwbug())
-		UASM_i_MTC0(p, 0, C0_ENTRYLO0);
-	UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-	UASM_i_SRL(p, ptep, ptep, 6); /* convert to entrylo1 */
-	if (r45k_bvahwbug())
-		uasm_i_mfc0(p, tmp, C0_INDEX);
+	if (kernel_uses_smartmips_rixi) {
+		UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
+		UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
+		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+		if (r4k_250MHZhwbug())
+			UASM_i_MTC0(p, 0, C0_ENTRYLO0);
+		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
+		UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+	} else {
+		UASM_i_SRL(p, tmp, tmp, 6); /* convert to entrylo0 */
+		if (r4k_250MHZhwbug())
+			UASM_i_MTC0(p, 0, C0_ENTRYLO0);
+		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
+		UASM_i_SRL(p, ptep, ptep, 6); /* convert to entrylo1 */
+		if (r45k_bvahwbug())
+			uasm_i_mfc0(p, tmp, C0_INDEX);
+	}
 	if (r4k_250MHZhwbug())
 		UASM_i_MTC0(p, 0, C0_ENTRYLO1);
 	UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
@@ -989,9 +1035,14 @@ static void __cpuinit
 build_pte_present(u32 **p, struct uasm_reloc **r,
 		  unsigned int pte, unsigned int ptr, enum label_id lid)
 {
-	uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
-	uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
-	uasm_il_bnez(p, r, pte, lid);
+	if (kernel_uses_smartmips_rixi) {
+		uasm_i_andi(p, pte, pte, _PAGE_PRESENT);
+		uasm_il_beqz(p, r, pte, lid);
+	} else {
+		uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
+		uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
+		uasm_il_bnez(p, r, pte, lid);
+	}
 	iPTE_LW(p, pte, ptr);
 }
 
@@ -1279,6 +1330,34 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	build_pte_present(&p, &r, K0, K1, label_nopage_tlbl);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
+
+	if (kernel_uses_smartmips_rixi) {
+		/*
+		 * If the page is not _PAGE_VALID, RI or XI could not
+		 * have triggered it.  Skip the expensive test..
+		 */
+		uasm_i_andi(&p, K0, K0, _PAGE_VALID);
+		uasm_il_beqz(&p, &r, K0, label_tlbl_goaround1);
+		uasm_i_nop(&p);
+
+		uasm_i_tlbr(&p);
+		/* Examine  entrylo 0 or 1 based on ptr. */
+		uasm_i_andi(&p, K0, K1, sizeof(pte_t));
+		uasm_i_beqz(&p, K0, 8);
+
+		UASM_i_MFC0(&p, K0, C0_ENTRYLO0); /* load it in the delay slot*/
+		UASM_i_MFC0(&p, K0, C0_ENTRYLO1); /* load it if ptr is odd */
+		/*
+		 * If the entryLo (now in K0) is valid (bit 1), RI or
+		 * XI must have triggered it.
+		 */
+		uasm_i_andi(&p, K0, K0, 2);
+		uasm_il_bnez(&p, &r, K0, label_nopage_tlbl);
+
+		uasm_l_tlbl_goaround1(&l, p);
+		/* Reload the PTE value */
+		iPTE_LW(&p, K0, K1);
+	}
 	build_make_valid(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
@@ -1291,6 +1370,40 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	iPTE_LW(&p, K0, K1);
 	build_pte_present(&p, &r, K0, K1, label_nopage_tlbl);
 	build_tlb_probe_entry(&p);
+
+	if (kernel_uses_smartmips_rixi) {
+		/*
+		 * If the page is not _PAGE_VALID, RI or XI could not
+		 * have triggered it.  Skip the expensive test..
+		 */
+		uasm_i_andi(&p, K0, K0, _PAGE_VALID);
+		uasm_il_beqz(&p, &r, K0, label_tlbl_goaround2);
+		uasm_i_nop(&p);
+
+		uasm_i_tlbr(&p);
+		/* Examine  entrylo 0 or 1 based on ptr. */
+		uasm_i_andi(&p, K0, K1, sizeof(pte_t));
+		uasm_i_beqz(&p, K0, 8);
+
+		UASM_i_MFC0(&p, K0, C0_ENTRYLO0); /* load it in the delay slot*/
+		UASM_i_MFC0(&p, K0, C0_ENTRYLO1); /* load it if ptr is odd */
+		/*
+		 * If the entryLo (now in K0) is valid (bit 1), RI or
+		 * XI must have triggered it.
+		 */
+		uasm_i_andi(&p, K0, K0, 2);
+		uasm_il_beqz(&p, &r, K0, label_tlbl_goaround2);
+		/* Reload the PTE value */
+		iPTE_LW(&p, K0, K1);
+
+		/*
+		 * We clobbered C0_PAGEMASK, restore it.  On the other branch
+		 * it is restored in build_huge_tlb_write_entry.
+		 */
+		build_restore_pagemask(&p, &r, K0, label_nopage_tlbl);
+
+		uasm_l_tlbl_goaround2(&l, p);
+	}
 	uasm_i_ori(&p, K0, K0, (_PAGE_ACCESSED | _PAGE_VALID));
 	build_huge_handler_tail(&p, &r, &l, K0, K1);
 #endif
-- 
1.6.2.5
