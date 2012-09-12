Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2012 19:03:06 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:33962 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903350Ab2ILRCG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2012 19:02:06 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TBqK8-0003K9-GJ; Wed, 12 Sep 2012 12:02:00 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 2/2] MIPS: Replace 'kernel_uses_smartmips_rixi' with 'cpu_has_rixi'.
Date:   Wed, 12 Sep 2012 12:01:49 -0500
Message-Id: <1347469309-11468-3-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1347469309-11468-1-git-send-email-sjhill@mips.com>
References: <1347469309-11468-1-git-send-email-sjhill@mips.com>
X-archive-position: 34481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Remove usage of the 'kernel_uses_smartmips_rixi' macro from all files
and use new 'cpu_has_rixi' instead.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cpu-features.h               |    3 ---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    2 +-
 arch/mips/include/asm/pgtable-bits.h               |   18 +++++++++---------
 arch/mips/include/asm/pgtable.h                    |   12 ++++++------
 arch/mips/mm/cache.c                               |    2 +-
 arch/mips/mm/fault.c                               |    2 +-
 arch/mips/mm/tlb-r4k.c                             |    2 +-
 arch/mips/mm/tlbex.c                               |   14 +++++++-------
 8 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 232cb1e..5a65870 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -98,9 +98,6 @@
 #ifndef cpu_has_rixi
 #define cpu_has_rixi		(cpu_data[0].options & MIPS_CPU_RIXI)
 #endif
-#ifndef kernel_uses_smartmips_rixi
-#define kernel_uses_smartmips_rixi 0
-#endif
 #ifndef cpu_has_mmips
 #define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
 #endif
diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index a58addb..375ad0c 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -58,7 +58,7 @@
 #define cpu_has_veic		0
 #define cpu_hwrena_impl_bits	0xc0000000
 
-#define kernel_uses_smartmips_rixi (cpu_data[0].cputype != CPU_CAVIUM_OCTEON)
+#define cpu_has_rixi		(cpu_data[0].cputype != CPU_CAVIUM_OCTEON)
 
 #define ARCH_HAS_IRQ_PER_CPU	1
 #define ARCH_HAS_SPINLOCK_PREFETCH 1
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index e9fe7e9..2f99313 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -79,9 +79,9 @@
 /* implemented in software */
 #define _PAGE_PRESENT_SHIFT	(0)
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
-/* implemented in software, should be unused if kernel_uses_smartmips_rixi. */
-#define _PAGE_READ_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_PRESENT_SHIFT : _PAGE_PRESENT_SHIFT + 1)
-#define _PAGE_READ ({if (kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_READ_SHIFT; })
+/* implemented in software, should be unused if cpu_has_rixi. */
+#define _PAGE_READ_SHIFT	(cpu_has_rixi ? _PAGE_PRESENT_SHIFT : _PAGE_PRESENT_SHIFT + 1)
+#define _PAGE_READ ({if (cpu_has_rixi) BUG(); 1 << _PAGE_READ_SHIFT; })
 /* implemented in software */
 #define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
@@ -104,12 +104,12 @@
 #endif
 
 /* Page cannot be executed */
-#define _PAGE_NO_EXEC_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_HUGE_SHIFT + 1 : _PAGE_HUGE_SHIFT)
-#define _PAGE_NO_EXEC		({if (!kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_NO_EXEC_SHIFT; })
+#define _PAGE_NO_EXEC_SHIFT	(cpu_has_rixi ? _PAGE_HUGE_SHIFT + 1 : _PAGE_HUGE_SHIFT)
+#define _PAGE_NO_EXEC		({if (!cpu_has_rixi) BUG(); 1 << _PAGE_NO_EXEC_SHIFT; })
 
 /* Page cannot be read */
-#define _PAGE_NO_READ_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
-#define _PAGE_NO_READ		({if (!kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_NO_READ_SHIFT; })
+#define _PAGE_NO_READ_SHIFT	(cpu_has_rixi ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
+#define _PAGE_NO_READ		({if (!cpu_has_rixi) BUG(); 1 << _PAGE_NO_READ_SHIFT; })
 
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
@@ -155,7 +155,7 @@
  */
 static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 {
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_rixi) {
 		int sa;
 #ifdef CONFIG_32BIT
 		sa = 31 - _PAGE_NO_READ_SHIFT;
@@ -220,7 +220,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 
 #endif
 
-#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ))
+#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (cpu_has_rixi ? 0 : _PAGE_READ))
 #define __WRITEABLE	(_PAGE_WRITE | _PAGE_SILENT_WRITE | _PAGE_MODIFIED)
 
 #define _PAGE_CHG_MASK  (_PFN_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index b2202a6..c02158b 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -22,15 +22,15 @@ struct mm_struct;
 struct vm_area_struct;
 
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
+#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | (cpu_has_rixi ? 0 : _PAGE_READ) | \
 				 _page_cachable_default)
-#define PAGE_COPY	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
-				 (kernel_uses_smartmips_rixi ?  _PAGE_NO_EXEC : 0) | _page_cachable_default)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
+#define PAGE_COPY	__pgprot(_PAGE_PRESENT | (cpu_has_rixi ? 0 : _PAGE_READ) | \
+				 (cpu_has_rixi ?  _PAGE_NO_EXEC : 0) | _page_cachable_default)
+#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | (cpu_has_rixi ? 0 : _PAGE_READ) | \
 				 _page_cachable_default)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _page_cachable_default)
-#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | _PAGE_WRITE | \
+#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | (cpu_has_rixi ? 0 : _PAGE_READ) | _PAGE_WRITE | \
 				 _page_cachable_default)
 #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
 			__WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
@@ -299,7 +299,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_rixi) {
 		if (!(pte_val(pte) & _PAGE_NO_READ))
 			pte_val(pte) |= _PAGE_SILENT_READ;
 	} else {
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index ff910a1..d449d9a 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -183,7 +183,7 @@ EXPORT_SYMBOL(_page_cachable_default);
 
 static inline void setup_protection_map(void)
 {
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_rixi) {
 		protection_map[0]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
 		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
 		protection_map[2]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index c14f6df..7a19957 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -114,7 +114,7 @@ good_area:
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-		if (kernel_uses_smartmips_rixi) {
+		if (cpu_has_rixi) {
 			if (address == regs->cp0_epc && !(vma->vm_flags & VM_EXEC)) {
 #if 0
 				pr_notice("Cpu%d[%s:%d:%0*lx:%ld:%0*lx] XI violation\n",
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index d2572cb..87b9cfc 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -401,7 +401,7 @@ void __cpuinit tlb_init(void)
 	    current_cpu_type() == CPU_R14000)
 		write_c0_framemask(0);
 
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_rixi) {
 		/*
 		 * Enable the no read, no exec bits, and enable large virtual
 		 * address.
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 202908e..542dae1 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -601,7 +601,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 static __cpuinit __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 								  unsigned int reg)
 {
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_rixi) {
 		UASM_i_SRL(p, reg, reg, ilog2(_PAGE_NO_EXEC));
 		UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
 	} else {
@@ -1021,7 +1021,7 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 	if (cpu_has_64bits) {
 		uasm_i_ld(p, tmp, 0, ptep); /* get even pte */
 		uasm_i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
-		if (kernel_uses_smartmips_rixi) {
+		if (cpu_has_rixi) {
 			UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
 			UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
 			UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
@@ -1048,7 +1048,7 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 	UASM_i_LW(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
 	if (r45k_bvahwbug())
 		build_tlb_probe_entry(p);
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_rixi) {
 		UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
 		UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
 		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
@@ -1214,7 +1214,7 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 		UASM_i_LW(p, even, 0, ptr); /* get even pte */
 		UASM_i_LW(p, odd, sizeof(pte_t), ptr); /* get odd pte */
 	}
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_rixi) {
 		uasm_i_dsrl_safe(p, even, even, ilog2(_PAGE_NO_EXEC));
 		uasm_i_dsrl_safe(p, odd, odd, ilog2(_PAGE_NO_EXEC));
 		uasm_i_drotr(p, even, even,
@@ -1576,7 +1576,7 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
 {
 	int t = scratch >= 0 ? scratch : pte;
 
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_rixi) {
 		if (use_bbit_insns()) {
 			uasm_il_bbit0(p, r, pte, ilog2(_PAGE_PRESENT), lid);
 			uasm_i_nop(p);
@@ -1906,7 +1906,7 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_rixi) {
 		/*
 		 * If the page is not _PAGE_VALID, RI or XI could not
 		 * have triggered it.  Skip the expensive test..
@@ -1960,7 +1960,7 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	build_pte_present(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbl);
 	build_tlb_probe_entry(&p);
 
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_rixi) {
 		/*
 		 * If the page is not _PAGE_VALID, RI or XI could not
 		 * have triggered it.  Skip the expensive test..
-- 
1.7.9.5
