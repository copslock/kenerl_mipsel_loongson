Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2011 12:52:54 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:4775 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491052Ab1CPLwD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2011 12:52:03 +0100
X-TM-IMSS-Message-ID: <248d21ab00013c00@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 248d21ab00013c00 ; Wed, 16 Mar 2011 04:51:55 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 16 Mar 2011 04:52:47 -0700
Date:   Wed, 16 Mar 2011 17:27:49 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 3/7] Add XLR/XLS cache and TLB support
Message-ID: <cadf7ed67683e96d920fedc87d8fc5d6dbdccdc7.1300275485.git.jayachandranc@netlogicmicro.com>
References: <cover.1300275485.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1300275485.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 16 Mar 2011 11:52:48.0228 (UTC) FILETIME=[AB9FF240:01CBE3D0]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Add c-netlogic.c for XLR/XLS cache operations.
New cache type cpu_has_netlogic_cache in asm/cpu-features.h
asm/mach-netlogic/cpu-feature-overrides.h for cache
CPU_XLR case added to mm/tlbex.c

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/cpu-features.h               |    3 +
 .../asm/mach-netlogic/cpu-feature-overrides.h      |    9 +
 arch/mips/mm/c-netlogic.c                          |  450 ++++++++++++++++++++
 arch/mips/mm/cache.c                               |    5 +
 arch/mips/mm/tlbex.c                               |    1 +
 5 files changed, 468 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
 create mode 100644 arch/mips/mm/c-netlogic.c

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index ca400f7..bbf8f35 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -41,6 +41,9 @@
 #ifndef cpu_has_octeon_cache
 #define cpu_has_octeon_cache	0
 #endif
+#ifndef cpu_has_netlogic_cache
+#define cpu_has_netlogic_cache	0
+#endif
 #ifndef cpu_has_fpu
 #define cpu_has_fpu		(current_cpu_data.options & MIPS_CPU_FPU)
 #define raw_cpu_has_fpu		(raw_current_cpu_data.options & MIPS_CPU_FPU)
diff --git a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
new file mode 100644
index 0000000..7740401
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H
+
+/*
+ * Most of the properties are in cpu->options
+ */
+#define cpu_has_netlogic_cache	1
+
+#endif /* __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/mm/c-netlogic.c b/arch/mips/mm/c-netlogic.c
new file mode 100644
index 0000000..27a0067
--- /dev/null
+++ b/arch/mips/mm/c-netlogic.c
@@ -0,0 +1,450 @@
+/*
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ * Copyright (C) 1997, 2001 Ralf Baechle (ralf@gnu.org)
+ * Copyright (C) 2011 Netlogic Microsystems.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+#include <linux/init.h>
+#include <asm/asm.h>
+#include <asm/mmu_context.h>
+#include <asm/bootinfo.h>
+#include <asm/cacheops.h>
+#include <asm/cpu.h>
+#include <asm/uaccess.h>
+#include <linux/smp.h>
+#include <linux/kallsyms.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+
+static unsigned int icache_linesz;
+static unsigned int icache_lines;
+
+#define cacheop(op, base)				\
+		__asm__ __volatile__ (			\
+			"	.set	push\n"		\
+			"	.set	mips4\n"	\
+			"	cache	%0, 0(%1)\n"	\
+			"	.set	pop\n"		\
+			: : "i"(op), "r"(base))
+
+#define cacheop_extable(op, base) do {			\
+		__asm__ __volatile__(			\
+			"	.set	push\n"		\
+			"	.set	noreorder\n"	\
+			"	.set	mips4\n"	\
+			"1:	cache	%0, 0(%1)\n"	\
+			"2:	.set	pop\n"		\
+			"	.section __ex_table,\"a\"\n"\
+			STR(PTR)"	1b, 2b\n"	\
+			"	.previous\n"		\
+			: : "i" (op), "r" (base));	\
+	} while (0)
+
+static inline void sync_istream(void)
+{
+	__asm__ __volatile__ (
+		"	.set	push\n"
+		"	.set	noreorder\n"
+		"	nop;nop;nop;nop;nop\n"
+		"	nop;nop;nop;nop;nop\n"
+		"	.set	pop\n"
+	);
+}
+
+static inline void cacheop_hazard(void)
+{
+	__asm__ __volatile__ (
+		"	.set	push\n"
+		"	.set	noreorder\n"
+		"	nop;nop;nop;nop\n"
+		"	nop;nop;nop;nop\n"
+		"	.set	pop\n"
+	);
+}
+
+static inline void cacheop_sync_istream(void)
+{
+	cacheop_hazard();
+	sync_istream();
+}
+
+extern unsigned long nlm_common_ebase;
+/*
+ * These routines support Generic Kernel cache flush requirements
+ */
+void nlm_common_flush_dcache_page(struct page *page)
+{
+	ClearPageDcacheDirty(page);
+}
+
+static void nlm_common_local_flush_icache_range(unsigned long start,
+	unsigned long end)
+{
+	unsigned long addr;
+
+	for (addr = (start & ~((unsigned long)(icache_linesz - 1)));
+			addr < end; addr += icache_linesz) {
+		cacheop_extable(Hit_Invalidate_I, addr);
+	}
+	cacheop_sync_istream();
+}
+
+struct flush_icache_range_args {
+	unsigned long start;
+	unsigned long end;
+};
+
+struct flush_icache_range_args_paddr {
+	phys_t start;
+	phys_t end;
+};
+
+static void nlm_common_flush_icache_range_ipi(void *info)
+{
+	struct flush_icache_range_args *args = info;
+
+	nlm_common_local_flush_icache_range(args->start, args->end);
+}
+
+void nlm_common_flush_icache_range(unsigned long start, unsigned long end)
+{
+	struct flush_icache_range_args args;
+
+	if ((end - start) > PAGE_SIZE)
+		pr_info("flushing more than page size of icache addresses"
+			" starting @ %lx\n", start);
+
+	args.start = start;
+	args.end = end;
+	on_each_cpu(nlm_common_flush_icache_range_ipi, &args, 1);
+}
+
+static void nlm_common_flush_cache_sigtramp_ipi(void *info)
+{
+	unsigned long addr = (unsigned long)info;
+
+	addr = addr & ~(icache_linesz - 1);
+	cacheop_extable(Hit_Invalidate_I, addr);
+	cacheop_sync_istream();
+}
+
+static void nlm_common_flush_cache_sigtramp(unsigned long addr)
+{
+	on_each_cpu(nlm_common_flush_cache_sigtramp_ipi, (void *)addr, 1);
+}
+
+/*
+ * These routines support MIPS specific cache flush requirements.
+ * These are called only during bootup or special system calls
+ */
+
+static void nlm_common_local_flush_icache(void)
+{
+	int i = 0;
+	unsigned long base = CKSEG0;
+
+	/* Index Invalidate all the lines and the ways */
+	for (i = 0; i < icache_lines; i++) {
+		cacheop(Index_Invalidate_I, base);
+		base += icache_linesz;
+	}
+
+	cacheop_sync_istream();
+}
+
+static void nlm_common_local_flush_dcache(void)
+{
+	int i = 0;
+	unsigned long base = CKSEG0;
+	unsigned int lines;
+
+	lines = current_cpu_data.dcache.ways * current_cpu_data.dcache.sets;
+
+	/* Index Invalidate all the lines and the ways */
+	for (i = 0; i < lines; i++) {
+		cacheop(Index_Writeback_Inv_D, base);
+		base += current_cpu_data.dcache.linesz;
+	}
+
+	cacheop_hazard();
+}
+
+#ifdef CONFIG_KGDB
+void nlm_common_flush_l1_icache_ipi(void *info)
+{
+	nlm_common_local_flush_icache();
+}
+#endif
+
+#ifdef CONFIG_KGDB
+void nlm_common_flush_l1_caches_ipi(void *info)
+#else
+static void nlm_common_flush_l1_caches_ipi(void *info)
+#endif
+{
+	nlm_common_local_flush_dcache();
+	nlm_common_local_flush_icache();
+}
+
+static void nlm_common_flush_l1_caches(void)
+{
+	pr_err("CACHE FLUSH: flushing L1 caches on all cpus!\n");
+	on_each_cpu(nlm_common_flush_l1_caches_ipi, (void *)NULL, 1);
+}
+
+static void nlm_common_noflush(void) {/* do nothing */}
+
+static __init void probe_l1_cache(void)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	unsigned int config1 = read_c0_config1();
+	int lsize, icache_size, dcache_size;
+
+	lsize = (config1 >> 19) & 7;
+	if (lsize != 0)
+		c->icache.linesz = 2 << lsize;
+	else
+		c->icache.linesz = lsize;
+	c->icache.sets = 64 << ((config1 >> 22) & 7);
+	c->icache.ways = 1 + ((config1 >> 16) & 7);
+
+	icache_size = c->icache.sets *
+		c->icache.ways * c->icache.linesz;
+	c->icache.waybit = ffs(icache_size/c->icache.ways) - 1;
+
+	c->dcache.flags = 0;
+
+	lsize = (config1 >> 10) & 7;
+	if (lsize != 0)
+		c->dcache.linesz = 2 << lsize;
+	else
+		c->dcache.linesz = lsize;
+	c->dcache.sets = 64 << ((config1 >> 13) & 7);
+	c->dcache.ways = 1 + ((config1 >> 7) & 7);
+
+	dcache_size = c->dcache.sets *
+		c->dcache.ways * c->dcache.linesz;
+	c->dcache.waybit = ffs(dcache_size/c->dcache.ways) - 1;
+
+	if (smp_processor_id() == 0) {
+		pr_info("Primary instruction cache %dkB, %d-way, linesize"
+			" %d bytes.\n", icache_size >> 10, c->icache.ways,
+			c->icache.linesz);
+		pr_info("Primary data cache %dkB %d-way, linesize %d bytes.\n",
+			dcache_size >> 10, c->dcache.ways, c->dcache.linesz);
+	}
+}
+
+static inline void install_cerr_handler(void)
+{
+	extern char except_vec2_generic;
+
+	memcpy((void *)(nlm_common_ebase + 0x100), &except_vec2_generic, 0x80);
+}
+
+static void update_kseg0_coherency(void)
+{
+	int attr = read_c0_config() & CONF_CM_CMASK;
+
+	if (attr != 0x3) {
+		nlm_common_local_flush_dcache();
+		nlm_common_local_flush_icache();
+
+		change_c0_config(CONF_CM_CMASK, 0x3);
+		sync_istream();
+	}
+	_page_cachable_default = (0x3 << _CACHE_SHIFT);
+}
+
+void nlm_cache_init(void)
+{
+	extern void build_clear_page(void);
+	extern void build_copy_page(void);
+	/* update cpu_data */
+
+	probe_l1_cache();
+	if (smp_processor_id() != 0) {
+		nlm_common_local_flush_icache();
+		update_kseg0_coherency();
+		return;
+	}
+
+	/* These values are assumed to be the same for all cores */
+	icache_lines = current_cpu_data.icache.ways *
+				current_cpu_data.icache.sets;
+	icache_linesz = current_cpu_data.icache.linesz;
+
+	/*
+	 * When does this function get called? Looks like MIPS has some syscalls
+	 * to flush the caches.
+	 */
+	__flush_cache_all = nlm_common_flush_l1_caches;
+
+	/* flush_cache_all: makes all kernel data coherent.
+	 * This gets called just before changing or removing
+	 * a mapping in the page-table-mapped kernel segment (kmap).
+	 * Physical Cache -> do nothing
+	 */
+	flush_cache_all = nlm_common_noflush;
+
+	/* flush_icache_range: makes the range of addresses coherent w.r.t
+	 * I-cache and D-cache. This gets called after the instructions are
+	 * written to memory. All addresses are valid kernel or mapped
+	 * user-space virtual addresses
+	 */
+	flush_icache_range = nlm_common_flush_icache_range;
+
+	/* flush_cache_{mm, range, page}: make these memory locations, that
+	 * may have been written by a user process, coherent. These get called
+	 * when virtual->physical translation of a user address space is about
+	 * to be changed. These are closely related to TLB coherency
+	 * (flush_tlb_{mm, range, page})
+	 */
+	flush_cache_mm = (void (*)(struct mm_struct *))nlm_common_noflush;
+	flush_cache_range = (void *) nlm_common_noflush;
+	flush_cache_page = (void *) nlm_common_noflush;
+
+	/*
+	 * flush_icache_page: flush_dcache_page + update_mmu_cache takes care
+	 * of this
+	 */
+	flush_data_cache_page = (void *) nlm_common_noflush;
+
+	/*
+	 * flush_cache_sigtramp: flush the single I-cache line with the proper
+	 * fixup code
+	 */
+	flush_cache_sigtramp = nlm_common_flush_cache_sigtramp;
+
+	/*
+	 * flush_icache_all: This should get called only for Virtuall Tagged
+	 * I-Caches
+	 */
+	flush_icache_all = (void *)nlm_common_noflush;
+
+	local_flush_icache_range = nlm_common_local_flush_icache_range;
+	local_flush_data_cache_page	= (void *)nlm_common_noflush;
+
+	__flush_cache_vmap = (void *)nlm_common_noflush;
+	__flush_cache_vunmap = (void *)nlm_common_noflush;
+
+	install_cerr_handler();
+
+	build_clear_page();
+	build_copy_page();
+
+	nlm_common_local_flush_icache();
+
+	update_kseg0_coherency();
+}
+
+#ifdef CONFIG_64BIT
+#define cacheop_paddr(op, base)			\
+	__asm__ __volatile__ (			\
+		"	.set	push\n"		\
+		"	.set	mips64\n"	\
+		"	cache	%0, 0($8)\n"	\
+		"	.set	pop\n"		\
+		: : "i"(op), "r"((base) | 0x9800000000000000ULL))
+
+#else
+#define cacheop_paddr(op, base)			\
+	do {						\
+		uint32_t msb, lsb;			\
+							\
+		msb = 0;				\
+		if (sizeof(base) == 8)			\
+			msb = ((base) >> 32);		\
+		msb |= 0x98000000U;			\
+		lsb = ((base) & 0xffffffff);		\
+							\
+		__asm__ volatile(			\
+			"	.set	push\n"		\
+			"	.set	noreorder\n"	\
+			"	.set	mips64\n"	\
+			"	dsll32	$8, %1, 0\n"	\
+			"	dsll32	$9, %2, 0\n"	\
+			"	dsrl32	$9, $9, 0\n"	\
+			"	or	$8, $8, $9\n"	\
+			"	cache	%0, 0($8)\n"	\
+			"	.set	pop\n"		\
+			: : "i"(op), "r"(msb), "r"(lsb)	\
+			: "$8", "$9");			\
+	} while (0)
+#endif
+
+#define c0_enable_kx(flags)				\
+	do {						\
+		preempt_disable();			\
+		__asm__ __volatile__(			\
+			"	.set	push\n"		\
+			"	.set	noreorder\n"	\
+			"	mfc0	%0, $12\n"	\
+			"	ori	$8, %0, 0x81\n"	\
+			"	xori	$8, 1\n"	\
+			"	mtc0	$8, $12\n"	\
+			"	.set	pop\n"		\
+		: "=r"(flags)				\
+		: : "$8");				\
+		preempt_enable();			\
+	} while (0)
+
+#define c0_restore_kx(flags)			\
+	__asm__ __volatile__ (			\
+		"	mtc0	%0, $12\n"	\
+		: : "r"(flags)			\
+	)
+
+#define SETS_PER_WAY_SHIFT	22
+#define SETS_PER_WAY_MASK	0x7
+#define CACHELINE_SIZE_BITS	5
+
+static void nlm_common_local_flush_icache_range_paddr(phys_t start, phys_t end)
+{
+	phys_t addr;
+#ifdef CONFIG_32BIT
+	unsigned long flags;
+#endif
+
+#ifdef CONFIG_32BIT
+	c0_enable_kx(flags);
+#endif
+	for (addr = (start & ~(phys_t)(icache_linesz - 1)); addr < end;
+		addr += icache_linesz) {
+		cacheop_paddr(Hit_Invalidate_I, addr);
+	}
+
+#ifdef CONFIG_32BIT
+	c0_restore_kx(flags);
+#endif
+	cacheop_sync_istream();
+}
+
+static void nlm_common_flush_icache_range_paddr_ipi(void *info)
+{
+	struct flush_icache_range_args_paddr *args = info;
+
+	nlm_common_local_flush_icache_range_paddr(args->start, args->end);
+}
+
+void nlm_common_flush_icache_range_paddr(phys_t start)
+{
+	struct flush_icache_range_args_paddr args;
+
+	args.start = start;
+	args.end = start + PAGE_SIZE;
+	on_each_cpu(nlm_common_flush_icache_range_paddr_ipi, &args, 1);
+}
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 12af739..b8186ae 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -209,6 +209,11 @@ void __cpuinit cpu_cache_init(void)
 
 		octeon_cache_init();
 	}
+	if (cpu_has_netlogic_cache) {
+		extern void __weak nlm_cache_init(void);
+
+		nlm_cache_init();
+	}
 
 	setup_protection_map();
 }
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 04f9e17..c9f9e27 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -404,6 +404,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_5KC:
 	case CPU_TX49XX:
 	case CPU_PR4450:
+	case CPU_XLR:
 		uasm_i_nop(p);
 		tlbw(p);
 		break;
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
