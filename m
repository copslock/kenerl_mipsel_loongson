Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:30:54 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60438 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831898Ab2LGFaeYElFd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:30:34 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TgqW4-0007R1-3O; Thu, 06 Dec 2012 23:30:28 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 1/2] MIPS: Allow ASID size to be determined at boot time.
Date:   Thu,  6 Dec 2012 23:30:21 -0600
Message-Id: <1354858222-29519-2-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1354858222-29519-1-git-send-email-sjhill@mips.com>
References: <1354858222-29519-1-git-send-email-sjhill@mips.com>
X-archive-position: 35237
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

Original patch by Ralf Baechle and removed by Harold Koerfgen
with commit f67e4ffc79905482c3b9b8c8dd65197bac7eb508. This
allows for more generic kernels since the size of the ASID
and corresponding masks can be determined at run-time. This
patch is also required for the new Aptiv cores and has been
tested on Malta and Malta Aptiv platforms.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mmu_context.h |   84 ++++++++++++++++++++++-------------
 arch/mips/kernel/genex.S            |    2 +-
 arch/mips/kernel/traps.c            |    6 ++-
 arch/mips/lib/dump_tlb.c            |    5 ++-
 arch/mips/lib/r3k_dump_tlb.c        |    6 +--
 arch/mips/mm/tlb-r3k.c              |   20 ++++-----
 arch/mips/mm/tlb-r4k.c              |    2 +-
 arch/mips/mm/tlb-r8k.c              |    2 +-
 arch/mips/mm/tlbex.c                |   51 +++++++++++++++++++++
 9 files changed, 127 insertions(+), 51 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 9b02cfb..74852ed 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -62,51 +62,73 @@ extern unsigned long pgd_current[];
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT*/
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
-#define ASID_INC	0x40
-#define ASID_MASK	0xfc0
-
-#elif defined(CONFIG_CPU_R8000)
-
-#define ASID_INC	0x10
-#define ASID_MASK	0xff0
-
-#elif defined(CONFIG_CPU_RM9000)
-
-#define ASID_INC	0x1
-#define ASID_MASK	0xfff
-
-/* SMTC/34K debug hack - but maybe we'll keep it */
-#elif defined(CONFIG_MIPS_MT_SMTC)
+#ifndef CONFIG_MIPS_MT_SMTC
+#define ASID_INC(asid)						\
+({								\
+	unsigned long __asid = asid;				\
+	__asm__("1:\taddiu\t%0,1\t\t\t\t# patched\n\t"		\
+	".section\t__asid_inc,\"a\"\n\t"			\
+	".word\t1b\n\t"						\
+	".previous"						\
+	:"=r" (__asid)						\
+	:"0" (__asid));						\
+	__asid;							\
+})
+#define ASID_MASK(asid)						\
+({								\
+	unsigned long __asid = asid;				\
+	__asm__("1:\tandi\t%0,%1,0xfc0\t\t\t# patched\n\t"	\
+	".section\t__asid_mask,\"a\"\n\t"			\
+	".word\t1b\n\t"						\
+	".previous"						\
+	:"=r" (__asid)						\
+	:"r" (__asid));						\
+	__asid;							\
+})
+#define ASID_VERSION_MASK					\
+({								\
+	unsigned long __asid;					\
+	__asm__("1:\tli\t%0,0xff00\t\t\t\t# patched\n\t"	\
+	".section\t__asid_version_mask,\"a\"\n\t"		\
+	".word\t1b\n\t"						\
+	".previous"						\
+	:"=r" (__asid));					\
+	__asid;							\
+})
+#define ASID_FIRST_VERSION					\
+({								\
+	unsigned long __asid = asid;				\
+	__asm__("1:\tli\t%0,0x100\t\t\t\t# patched\n\t"		\
+	".section\t__asid_first_version,\"a\"\n\t"		\
+	".word\t1b\n\t"						\
+	".previous"						\
+	:"=r" (__asid));					\
+	__asid;							\
+})
+
+#define ASID_FIRST_VERSION_R3000	0x1000
+#define ASID_FIRST_VERSION_R4000	0x100
+#define ASID_FIRST_VERSION_R8000	0x1000
+#define ASID_FIRST_VERSION_RM9000	0x1000
+#define ASID_FIRST_VERSION_99K		0x1000
 
+#else
+/* SMTC/34K debug hack. */
 #define ASID_INC	0x1
 extern unsigned long smtc_asid_mask;
 #define ASID_MASK	(smtc_asid_mask)
 #define	HW_ASID_MASK	0xff
-/* End SMTC/34K debug hack */
-#else /* FIXME: not correct for R6000 */
-
-#define ASID_INC	0x1
-#define ASID_MASK	0xff
-
 #endif
 
 #define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
-#define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & ASID_MASK)
+#define cpu_asid(cpu, mm)	ASID_MASK(cpu_context((cpu), (mm)))
 #define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
-/*
- *  All unused by hardware upper bits will be considered
- *  as a software asid extension.
- */
-#define ASID_VERSION_MASK  ((unsigned long)~(ASID_MASK|(ASID_MASK-1)))
-#define ASID_FIRST_VERSION ((unsigned long)(~ASID_VERSION_MASK) + 1)
-
 #ifndef CONFIG_MIPS_MT_SMTC
 /* Normal, classic MIPS get_new_mmu_context */
 static inline void
@@ -114,7 +136,7 @@ get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 {
 	unsigned long asid = asid_cache(cpu);
 
-	if (! ((asid += ASID_INC) & ASID_MASK) ) {
+	if (!ASID_MASK((asid = ASID_INC(asid)))) {
 		if (cpu_has_vtag_icache)
 			flush_icache_all();
 		local_flush_tlb_all();	/* start new asid cycle */
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index dc7d756..cff6e06 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -494,7 +494,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	noreorder
 	/* check if TLB contains a entry for EPC */
 	MFC0	k1, CP0_ENTRYHI
-	andi	k1, 0xff	/* ASID_MASK */
+	andi	k1, 0xff	/* ASID_MASK patched at run-time!! */
 	MFC0	k0, CP0_EPC
 	PTR_SRL	k0, PAGE_SHIFT + 1
 	PTR_SLL	k0, PAGE_SHIFT + 1
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index feccbe8..0d3d742 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1664,6 +1664,7 @@ void __cpuinit per_cpu_trap_init(bool is_boot_cpu)
 	unsigned int cpu = smp_processor_id();
 	unsigned int status_set = ST0_CU0;
 	unsigned int hwrena = cpu_hwrena_impl_bits;
+	unsigned long asid = 0;
 #ifdef CONFIG_MIPS_MT_SMTC
 	int secondaryTC = 0;
 	int bootTC = (cpu == 0);
@@ -1747,8 +1748,9 @@ void __cpuinit per_cpu_trap_init(bool is_boot_cpu)
 	}
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-	if (!cpu_data[cpu].asid_cache)
-		cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
+	asid = ASID_FIRST_VERSION;
+	cpu_data[cpu].asid_cache = asid;
+	TLBMISS_HANDLER_SETUP();
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index a99c1d3..27be26c 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -11,6 +11,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/tlbdebug.h>
+#include <asm/mmu_context.h>
 
 static inline const char *msk2str(unsigned int mask)
 {
@@ -55,7 +56,7 @@ static void dump_tlb(int first, int last)
 	s_pagemask = read_c0_pagemask();
 	s_entryhi = read_c0_entryhi();
 	s_index = read_c0_index();
-	asid = s_entryhi & 0xff;
+	asid = ASID_MASK(s_entryhi);
 
 	for (i = first; i <= last; i++) {
 		write_c0_index(i);
@@ -85,7 +86,7 @@ static void dump_tlb(int first, int last)
 
 			printk("va=%0*lx asid=%02lx\n",
 			       width, (entryhi & ~0x1fffUL),
-			       entryhi & 0xff);
+			       ASID_MASK(entryhi));
 			printk("\t[pa=%0*llx c=%d d=%d v=%d g=%d] ",
 			       width,
 			       (entrylo0 << 6) & PAGE_MASK, c0,
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index 9cee907..361c46c 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -21,7 +21,7 @@ static void dump_tlb(int first, int last)
 	unsigned int asid;
 	unsigned long entryhi, entrylo0;
 
-	asid = read_c0_entryhi() & 0xfc0;
+	asid = ASID_MASK(read_c0_entryhi());
 
 	for (i = first; i <= last; i++) {
 		write_c0_index(i<<8);
@@ -35,7 +35,7 @@ static void dump_tlb(int first, int last)
 
 		/* Unused entries have a virtual address of KSEG0.  */
 		if ((entryhi & 0xffffe000) != 0x80000000
-		    && (entryhi & 0xfc0) == asid) {
+		    && (ASID_MASK(entryhi) == asid)) {
 			/*
 			 * Only print entries in use
 			 */
@@ -44,7 +44,7 @@ static void dump_tlb(int first, int last)
 			printk("va=%08lx asid=%08lx"
 			       "  [pa=%06lx n=%d d=%d v=%d g=%d]",
 			       (entryhi & 0xffffe000),
-			       entryhi & 0xfc0,
+			       ASID_MASK(entryhi),
 			       entrylo0 & PAGE_MASK,
 			       (entrylo0 & (1 << 11)) ? 1 : 0,
 			       (entrylo0 & (1 << 10)) ? 1 : 0,
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index a63d1ed..4a13c15 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -51,7 +51,7 @@ void local_flush_tlb_all(void)
 #endif
 
 	local_irq_save(flags);
-	old_ctx = read_c0_entryhi() & ASID_MASK;
+	old_ctx = ASID_MASK(read_c0_entryhi());
 	write_c0_entrylo0(0);
 	entry = r3k_have_wired_reg ? read_c0_wired() : 8;
 	for (; entry < current_cpu_data.tlbsize; entry++) {
@@ -87,13 +87,13 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 #ifdef DEBUG_TLB
 		printk("[tlbrange<%lu,0x%08lx,0x%08lx>]",
-			cpu_context(cpu, mm) & ASID_MASK, start, end);
+			ASID_MASK(cpu_context(cpu, mm)), start, end);
 #endif
 		local_irq_save(flags);
 		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
 		if (size <= current_cpu_data.tlbsize) {
-			int oldpid = read_c0_entryhi() & ASID_MASK;
-			int newpid = cpu_context(cpu, mm) & ASID_MASK;
+			int oldpid = ASID_MASK(read_c0_entryhi());
+			int newpid = ASID_MASK(cpu_context(cpu, mm));
 
 			start &= PAGE_MASK;
 			end += PAGE_SIZE - 1;
@@ -166,10 +166,10 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 #ifdef DEBUG_TLB
 		printk("[tlbpage<%lu,0x%08lx>]", cpu_context(cpu, vma->vm_mm), page);
 #endif
-		newpid = cpu_context(cpu, vma->vm_mm) & ASID_MASK;
+		newpid = ASID_MASK(cpu_context(cpu, vma->vm_mm));
 		page &= PAGE_MASK;
 		local_irq_save(flags);
-		oldpid = read_c0_entryhi() & ASID_MASK;
+		oldpid = ASID_MASK(read_c0_entryhi());
 		write_c0_entryhi(page | newpid);
 		BARRIER;
 		tlb_probe();
@@ -197,10 +197,10 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 	if (current->active_mm != vma->vm_mm)
 		return;
 
-	pid = read_c0_entryhi() & ASID_MASK;
+	pid = ASID_MASK(read_c0_entryhi());
 
 #ifdef DEBUG_TLB
-	if ((pid != (cpu_context(cpu, vma->vm_mm) & ASID_MASK)) || (cpu_context(cpu, vma->vm_mm) == 0)) {
+	if ((pid != ASID_MASK(cpu_context(cpu, vma->vm_mm))) || (cpu_context(cpu, vma->vm_mm) == 0)) {
 		printk("update_mmu_cache: Wheee, bogus tlbpid mmpid=%lu tlbpid=%d\n",
 		       (cpu_context(cpu, vma->vm_mm)), pid);
 	}
@@ -241,7 +241,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 		local_irq_save(flags);
 		/* Save old context and create impossible VPN2 value */
-		old_ctx = read_c0_entryhi() & ASID_MASK;
+		old_ctx = ASID_MASK(read_c0_entryhi());
 		old_pagemask = read_c0_pagemask();
 		w = read_c0_wired();
 		write_c0_wired(w + 1);
@@ -264,7 +264,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 #endif
 
 		local_irq_save(flags);
-		old_ctx = read_c0_entryhi() & ASID_MASK;
+		old_ctx = ASID_MASK(read_c0_entryhi());
 		write_c0_entrylo0(entrylo0);
 		write_c0_entryhi(entryhi);
 		write_c0_index(wired);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 88e79ad..76b9e60 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -285,7 +285,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 
 	ENTER_CRITICAL(flags);
 
-	pid = read_c0_entryhi() & ASID_MASK;
+	pid = ASID_MASK(read_c0_entryhi());
 	address &= (PAGE_MASK << 1);
 	write_c0_entryhi(address | pid);
 	pgdp = pgd_offset(vma->vm_mm, address);
diff --git a/arch/mips/mm/tlb-r8k.c b/arch/mips/mm/tlb-r8k.c
index 91c2499..122f920 100644
--- a/arch/mips/mm/tlb-r8k.c
+++ b/arch/mips/mm/tlb-r8k.c
@@ -195,7 +195,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	if (current->active_mm != vma->vm_mm)
 		return;
 
-	pid = read_c0_entryhi() & ASID_MASK;
+	pid = ASID_MASK(read_c0_entryhi());
 
 	local_irq_save(flags);
 	address &= PAGE_MASK;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4c23656..6983454 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/cache.h>
 
+#include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
 #include <asm/war.h>
@@ -261,6 +262,54 @@ static struct uasm_reloc relocs[128] __cpuinitdata;
 static int check_for_high_segbits __cpuinitdata;
 #endif
 
+#ifndef CONFIG_MIPS_MT_SMTC
+/* Fixup an immediate instruction. */
+static void __cpuinit insn_fixup(unsigned int **start, unsigned int **stop,
+					unsigned int i_const)
+{
+	unsigned int **p, *ip;
+
+	for (p = start; p < stop; p++) {
+		ip = *p;
+		*ip = (*ip & 0xffff0000) | i_const;
+	}
+}
+
+#define asid_insn_fixup(section, const)					\
+do {									\
+	extern unsigned int *__start_ ## section;			\
+	extern unsigned int *__stop_ ## section;			\
+	insn_fixup(&__start_ ## section, &__stop_ ## section, const);	\
+} while(0)
+
+/* Caller is assumed to flush the caches before first context switch. */
+static void __cpuinit setup_asid(unsigned int inc, unsigned int mask,
+				 unsigned int version_mask,
+				 unsigned int first_version)
+{
+	extern asmlinkage void handle_ri_rdhwr_vivt(void);
+	unsigned long *vivt_exc;
+
+	asid_insn_fixup(__asid_inc, inc);
+	asid_insn_fixup(__asid_mask, mask);
+	asid_insn_fixup(__asid_version_mask, version_mask);
+	asid_insn_fixup(__asid_first_version, first_version);
+
+	/* Patch up the 'handle_ri_rdhwr_vivt' handler. */
+	vivt_exc = (unsigned long *) &handle_ri_rdhwr_vivt;
+	vivt_exc++;
+	*vivt_exc = (*vivt_exc & ~mask) | mask;
+
+	current_cpu_data.asid_cache = first_version;
+}
+#else
+static void __cpuinit setup_asid(unsigned int inc, unsigned int mask,
+				 unsigned int version_mask,
+				 unsigned int first_version)
+{
+}
+#endif
+
 static int check_for_high_segbits __cpuinitdata;
 
 static unsigned int kscratch_used_mask __cpuinitdata;
@@ -2175,6 +2224,7 @@ void __cpuinit build_tlb_refill_handler(void)
 	case CPU_TX3922:
 	case CPU_TX3927:
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
+		setup_asid(0x40, 0xfc0, 0xf000, ASID_FIRST_VERSION_R3000);
 		build_r3000_tlb_refill_handler();
 		if (!run_once) {
 			build_r3000_tlb_load_handler();
@@ -2198,6 +2248,7 @@ void __cpuinit build_tlb_refill_handler(void)
 
 #endif /* !CONFIG_CPU_MIPS32_R2 */
 	default:
+		setup_asid(0x1, 0xff, 0xff00, ASID_FIRST_VERSION_R4000);
 		if (!run_once) {
 			scratch_reg = allocate_kscratch();
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
-- 
1.7.9.5
