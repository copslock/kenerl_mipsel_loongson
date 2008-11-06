Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 20:57:00 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:33178 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23298192AbYKFUzR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 20:55:17 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4913599a0001>; Thu, 06 Nov 2008 15:54:50 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:50 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:50 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mA6KsjNm027692;
	Thu, 6 Nov 2008 12:54:45 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mA6KsjvP027691;
	Thu, 6 Nov 2008 12:54:45 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 04/29] MIPS: Add Cavium OCTEON processor support files to arch/mips/mm.
Date:	Thu,  6 Nov 2008 12:54:17 -0800
Message-Id: <1226004875-27654-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <491358F5.7040002@caviumnetworks.com>
References: <491358F5.7040002@caviumnetworks.com>
X-OriginalArrivalTime: 06 Nov 2008 20:54:50.0261 (UTC) FILETIME=[E9035C50:01C94051]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/c-octeon.c |  307 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/cex-oct.S  |   70 +++++++++++
 2 files changed, 377 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/mm/c-octeon.c
 create mode 100644 arch/mips/mm/cex-oct.S

diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
new file mode 100644
index 0000000..44d01a0
--- /dev/null
+++ b/arch/mips/mm/c-octeon.c
@@ -0,0 +1,307 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2007 Cavium Networks
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/io.h>
+
+#include <asm/bcache.h>
+#include <asm/bootinfo.h>
+#include <asm/cacheops.h>
+#include <asm/cpu-features.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/r4kcache.h>
+#include <asm/system.h>
+#include <asm/mmu_context.h>
+#include <asm/war.h>
+
+#include <asm/octeon/octeon.h>
+
+unsigned long long cache_err_dcache[NR_CPUS];
+
+/**
+ * Octeon automatically flushes the dcache on tlb changes, so
+ * from Linux's viewpoint it acts much like a physically
+ * tagged cache. No flushing is needed
+ *
+ */
+static void octeon_flush_data_cache_page(unsigned long addr)
+{
+    /* Nothing to do */
+}
+
+static inline void octeon_local_flush_icache(void)
+{
+	asm volatile ("synci 0($0)");
+}
+
+/*
+ * Flush local I-cache for the specified range.
+ */
+static void local_octeon_flush_icache_range(unsigned long start,
+					    unsigned long end)
+{
+	octeon_local_flush_icache();
+}
+
+/**
+ * Flush caches as necessary for all cores affected by a
+ * vma. If no vma is supplied, all cores are flushed.
+ *
+ * @vma:    VMA to flush or NULL to flush all icaches.
+ */
+static void octeon_flush_icache_all_cores(struct vm_area_struct *vma)
+{
+	extern void octeon_send_ipi_single(int cpu, unsigned int action);
+#ifdef CONFIG_SMP
+	int cpu;
+	cpumask_t mask;
+#endif
+
+	mb();
+	octeon_local_flush_icache();
+#ifdef CONFIG_SMP
+	preempt_disable();
+	cpu = smp_processor_id();
+
+	/*
+	 * If we have a vma structure, we only need to worry about
+	 * cores it has been used on
+	 */
+	if (vma)
+		mask = vma->vm_mm->cpu_vm_mask;
+	else
+		mask = cpu_online_map;
+	cpu_clear(cpu, mask);
+	for_each_cpu_mask(cpu, mask)
+		octeon_send_ipi_single(cpu, SMP_ICACHE_FLUSH);
+
+	preempt_enable();
+#endif
+}
+
+
+/**
+ * Called to flush the icache on all cores
+ */
+static void octeon_flush_icache_all(void)
+{
+	octeon_flush_icache_all_cores(NULL);
+}
+
+
+/**
+ * Called to flush all memory associated with a memory
+ * context.
+ *
+ * @mm:     Memory context to flush
+ */
+static void octeon_flush_cache_mm(struct mm_struct *mm)
+{
+	/*
+	 * According to the R4K version of this file, CPUs without
+	 * dcache aliases don't need to do anything here
+	 */
+}
+
+
+/**
+ * Flush a range of kernel addresses out of the icache
+ *
+ */
+static void octeon_flush_icache_range(unsigned long start, unsigned long end)
+{
+	octeon_flush_icache_all_cores(NULL);
+}
+
+
+/**
+ * Flush the icache for a trampoline. These are used for interrupt
+ * and exception hooking.
+ *
+ * @addr:   Address to flush
+ */
+static void octeon_flush_cache_sigtramp(unsigned long addr)
+{
+	struct vm_area_struct *vma;
+
+	vma = find_vma(current->mm, addr);
+	octeon_flush_icache_all_cores(vma);
+}
+
+
+/**
+ * Flush a range out of a vma
+ *
+ * @vma:    VMA to flush
+ * @start:
+ * @end:
+ */
+static void octeon_flush_cache_range(struct vm_area_struct *vma,
+				     unsigned long start, unsigned long end)
+{
+	if (vma->vm_flags & VM_EXEC)
+		octeon_flush_icache_all_cores(vma);
+}
+
+
+/**
+ * Flush a specific page of a vma
+ *
+ * @vma:    VMA to flush page for
+ * @page:   Page to flush
+ * @pfn:
+ */
+static void octeon_flush_cache_page(struct vm_area_struct *vma,
+				    unsigned long page, unsigned long pfn)
+{
+	if (vma->vm_flags & VM_EXEC)
+		octeon_flush_icache_all_cores(vma);
+}
+
+
+/**
+ * Probe Octeon's caches
+ *
+ */
+static void __devinit probe_octeon(void)
+{
+	unsigned long icache_size;
+	unsigned long dcache_size;
+	unsigned int config1;
+	struct cpuinfo_mips *c = &current_cpu_data;
+
+	switch (c->cputype) {
+	case CPU_CAVIUM_OCTEON:
+		config1 = read_c0_config1();
+		c->icache.linesz = 2 << ((config1 >> 19) & 7);
+		c->icache.sets = 64 << ((config1 >> 22) & 7);
+		c->icache.ways = 1 + ((config1 >> 16) & 7);
+		c->icache.flags |= MIPS_CACHE_VTAG;
+		icache_size =
+			c->icache.sets * c->icache.ways * c->icache.linesz;
+		c->icache.waybit = ffs(icache_size / c->icache.ways) - 1;
+		c->dcache.linesz = 128;
+		if (OCTEON_IS_MODEL(OCTEON_CN3XXX))
+			c->dcache.sets = 1; /* CN3XXX has one Dcache set */
+		else
+			c->dcache.sets = 2; /* CN5XXX has two Dcache sets */
+		c->dcache.ways = 64;
+		dcache_size =
+			c->dcache.sets * c->dcache.ways * c->dcache.linesz;
+		c->dcache.waybit = ffs(dcache_size / c->dcache.ways) - 1;
+		c->options |= MIPS_CPU_PREFETCH;
+		break;
+
+	default:
+		panic("Unsupported Cavium Networks CPU type\n");
+		break;
+	}
+
+	/* compute a couple of other cache variables */
+	c->icache.waysize = icache_size / c->icache.ways;
+	c->dcache.waysize = dcache_size / c->dcache.ways;
+
+	c->icache.sets = icache_size / (c->icache.linesz * c->icache.ways);
+	c->dcache.sets = dcache_size / (c->dcache.linesz * c->dcache.ways);
+
+	if (smp_processor_id() == 0) {
+		pr_notice("Primary instruction cache %ldkB, %s, %d way, "
+			  "%d sets, linesize %d bytes.\n",
+			  icache_size >> 10,
+			  cpu_has_vtag_icache ?
+				"virtually tagged" : "physically tagged",
+			  c->icache.ways, c->icache.sets, c->icache.linesz);
+
+		pr_notice("Primary data cache %ldkB, %d-way, %d sets, "
+			  "linesize %d bytes.\n",
+			  dcache_size >> 10, c->dcache.ways,
+			  c->dcache.sets, c->dcache.linesz);
+	}
+}
+
+
+/**
+ * Setup the Octeon cache flush routines
+ *
+ */
+void __devinit octeon_cache_init(void)
+{
+	extern unsigned long ebase;
+	extern char except_vec2_octeon;
+
+	memcpy((void *)(ebase + 0x100), &except_vec2_octeon, 0x80);
+	octeon_flush_cache_sigtramp(ebase + 0x100);
+
+	probe_octeon();
+
+	shm_align_mask = PAGE_SIZE - 1;
+
+	flush_cache_all			= octeon_flush_icache_all;
+	__flush_cache_all		= octeon_flush_icache_all;
+	flush_cache_mm			= octeon_flush_cache_mm;
+	flush_cache_page		= octeon_flush_cache_page;
+	flush_cache_range		= octeon_flush_cache_range;
+	flush_cache_sigtramp		= octeon_flush_cache_sigtramp;
+	flush_icache_all		= octeon_flush_icache_all;
+	flush_data_cache_page		= octeon_flush_data_cache_page;
+	flush_icache_range		= octeon_flush_icache_range;
+	local_flush_icache_range	= local_octeon_flush_icache_range;
+
+	build_clear_page();
+	build_copy_page();
+}
+
+/**
+ * Handle a cache error exception
+ */
+
+static void  cache_parity_error_octeon(int non_recoverable)
+{
+	unsigned long coreid = cvmx_get_core_num();
+	uint64_t icache_err = read_octeon_c0_icacheerr();
+
+	pr_err("Cache error exception:\n");
+	pr_err("cp0_errorepc == %lx\n", read_c0_errorepc());
+	if (icache_err & 1) {
+		pr_err("CacheErr (Icache) == %llx\n",
+		       (unsigned long long)icache_err);
+		write_octeon_c0_icacheerr(0);
+	}
+	if (cache_err_dcache[coreid] & 1) {
+		pr_err("CacheErr (Dcache) == %llx\n",
+		       (unsigned long long)cache_err_dcache[coreid]);
+		cache_err_dcache[coreid] = 0;
+	}
+
+	if (non_recoverable)
+		panic("Can't handle cache error: nested exception");
+}
+
+/**
+ * Called when the the exception is not recoverable
+ */
+
+asmlinkage void cache_parity_error_octeon_recoverable(void)
+{
+	cache_parity_error_octeon(0);
+}
+
+/**
+ * Called when the the exception is recoverable
+ */
+
+asmlinkage void cache_parity_error_octeon_non_recoverable(void)
+{
+	cache_parity_error_octeon(1);
+}
+
diff --git a/arch/mips/mm/cex-oct.S b/arch/mips/mm/cex-oct.S
new file mode 100644
index 0000000..3db8553
--- /dev/null
+++ b/arch/mips/mm/cex-oct.S
@@ -0,0 +1,70 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006 Cavium Networks
+ * Cache error handler
+ */
+
+#include <asm/asm.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/stackframe.h>
+
+/*
+ * Handle cache error. Indicate to the second level handler whether
+ * the exception is recoverable.
+ */
+	LEAF(except_vec2_octeon)
+
+	.set    push
+	.set	mips64r2
+	.set	noreorder
+	.set	noat
+
+
+	/* due to an errata we need to read the COP0 CacheErr (Dcache)
+	 * before any cache/DRAM access	 */
+
+	rdhwr   k0, $0        /* get core_id */
+	PTR_LA  k1, cache_err_dcache
+	sll     k0, k0, 3
+	PTR_ADDU k1, k0, k1    /* k1 = &cache_err_dcache[core_id] */
+
+	dmfc0   k0, CP0_CACHEERR, 1
+	sd      k0, (k1)
+	dmtc0   $0, CP0_CACHEERR, 1
+
+        /* check whether this is a nested exception */
+	mfc0    k1, CP0_STATUS
+	andi    k1, k1, ST0_EXL
+	beqz    k1, 1f
+	 nop
+	j	cache_parity_error_octeon_non_recoverable
+	 nop
+
+	/* exception is recoverable */
+1:	j	handle_cache_err
+	 nop
+
+	.set    pop
+	END(except_vec2_octeon)
+
+ /* We need to jump to handle_cache_err so that the previous handler
+  * can fit within 0x80 bytes. We also move from 0xFFFFFFFFAXXXXXXX
+  * space (uncached) to the 0xFFFFFFFF8XXXXXXX space (cached).  */
+	LEAF(handle_cache_err)
+	.set    push
+        .set    noreorder
+        .set    noat
+
+	SAVE_ALL
+	KMODE
+	jal     cache_parity_error_octeon_recoverable
+	nop
+	j       ret_from_exception
+	nop
+
+	.set pop
+	END(handle_cache_err)
-- 
1.5.6.5
