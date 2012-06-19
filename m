Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 08:53:19 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52239 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903560Ab2FSGxL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 08:53:11 +0200
Received: by pbbrq13 with SMTP id rq13so9838055pbb.36
        for <multiple recipients>; Mon, 18 Jun 2012 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=y3exeCrv/0p7GG/DQJEYaM3mCSEOFodOyTjWaXbYWJI=;
        b=OsEBSqqB+xuPOVO9kv7nTcexDQ2Y+GTGuPfnmI0iIIMQkQ5Do/8VK472aSEEls9FEd
         bvR2DofJ4owmlv19SxHJCOQYw3UeimsulaRGjrcuZgI4FgHbLCIvoZHYq+edJV63dLt0
         axMfa6jMBPXce2jr4J7hLvDibRZp1n6lZrtwiLQZQuLleR8YXVwp9LE39qbIFmgq4blJ
         lWE9GIywgjESeD2f7ZSEtZ8BxuElq7QOWdFjhYV9k5UvY47e9FHteggl/dKjggIO9ET2
         VZycLYw9wUEK9+BFH1n7bl3gLGMRi9oViYBoUekTFxyAVdvgNHFGLDKv2YUCMO3Eyhbh
         IOSw==
Received: by 10.68.230.68 with SMTP id sw4mr1258811pbc.142.1340088784465;
        Mon, 18 Jun 2012 23:53:04 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id gk3sm20156319pbc.1.2012.06.18.23.52.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2012 23:53:03 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V2 02/16] MIPS: Loongson: Add basic Loongson-3 CPU support.
Date:   Tue, 19 Jun 2012 14:50:10 +0800
Message-Id: <1340088624-25550-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Basic Loongson-3 CPU support include: CPU probing, TLB and cache
initializing, cache flushing method, etc.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/kernel/Makefile         |    1 +
 arch/mips/kernel/cpu-probe.c      |   12 ++++-
 arch/mips/lib/Makefile            |    1 +
 arch/mips/loongson/common/setup.c |    6 +-
 arch/mips/mm/Makefile             |    1 +
 arch/mips/mm/c-r4k.c              |   84 +++++++++++++++++++++++++++++++++++++
 arch/mips/mm/tlb-r4k.c            |    2 +-
 arch/mips/mm/tlbex.c              |    1 +
 8 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index fdaf65e..a0fc07f 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 
 obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_LOONGSON3)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o r2300_switch.o
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 27404ad..3283224 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -619,16 +619,22 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_LOONGSON2:
-		c->cputype = CPU_LOONGSON2;
-		__cpu_name[cpu] = "ICT Loongson-2";
-
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON2E:
+			c->cputype = CPU_LOONGSON2;
+			__cpu_name[cpu] = "ICT Loongson-2";
 			set_elf_platform(cpu, "loongson2e");
 			break;
 		case PRID_REV_LOONGSON2F:
+			c->cputype = CPU_LOONGSON2;
+			__cpu_name[cpu] = "ICT Loongson-2";
 			set_elf_platform(cpu, "loongson2f");
 			break;
+		case PRID_REV_LOONGSON3A:
+			c->cputype = CPU_LOONGSON3;
+			__cpu_name[cpu] = "ICT Loongson-3";
+			set_elf_platform(cpu, "loongson3a");
+			break;
 		}
 
 		c->isa_level = MIPS_CPU_ISA_III;
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 2a7c74f..59bed91 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -9,6 +9,7 @@ obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
 
 obj-$(CONFIG_CPU_LOONGSON2)	+= dump_tlb.o
+obj-$(CONFIG_CPU_LOONGSON3)	+= dump_tlb.o
 obj-$(CONFIG_CPU_MIPS32)	+= dump_tlb.o
 obj-$(CONFIG_CPU_MIPS64)	+= dump_tlb.o
 obj-$(CONFIG_CPU_NEVADA)	+= dump_tlb.o
diff --git a/arch/mips/loongson/common/setup.c b/arch/mips/loongson/common/setup.c
index 27d826b..ebb17ef 100644
--- a/arch/mips/loongson/common/setup.c
+++ b/arch/mips/loongson/common/setup.c
@@ -18,9 +18,6 @@
 #include <linux/screen_info.h>
 #endif
 
-void (*__wbflush)(void);
-EXPORT_SYMBOL(__wbflush);
-
 static void wbflush_loongson(void)
 {
 	asm(".set\tpush\n\t"
@@ -32,6 +29,9 @@ static void wbflush_loongson(void)
 	    ".set mips0\n\t");
 }
 
+void (*__wbflush)(void) = wbflush_loongson;
+EXPORT_SYMBOL(__wbflush);
+
 void __init plat_mem_setup(void)
 {
 	__wbflush = wbflush_loongson;
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index fd6203f..a79b6d1 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 
 obj-$(CONFIG_CPU_LOONGSON2)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_LOONGSON3)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_MIPS32)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_MIPS64)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_NEVADA)	+= c-r4k.o cex-gen.o tlb-r4k.o
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ce0dbee..a1a3482 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -362,6 +362,9 @@ static inline void local_r4k___flush_cache_all(void * args)
 
 static void r4k___flush_cache_all(void)
 {
+#if defined(CONFIG_CPU_LOONGSON3)
+	return;
+#endif
 	r4k_on_each_cpu(local_r4k___flush_cache_all, NULL);
 }
 
@@ -382,11 +385,17 @@ static inline int has_valid_asid(const struct mm_struct *mm)
 
 static void r4k__flush_cache_vmap(void)
 {
+#if defined(CONFIG_CPU_LOONGSON3)
+	return;
+#endif
 	r4k_blast_dcache();
 }
 
 static void r4k__flush_cache_vunmap(void)
 {
+#if defined(CONFIG_CPU_LOONGSON3)
+	return;
+#endif
 	r4k_blast_dcache();
 }
 
@@ -408,6 +417,9 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
 {
 	int exec = vma->vm_flags & VM_EXEC;
 
+#if defined(CONFIG_CPU_LOONGSON3)
+	return;
+#endif
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
 		r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
 }
@@ -438,6 +450,9 @@ static inline void local_r4k_flush_cache_mm(void * args)
 
 static void r4k_flush_cache_mm(struct mm_struct *mm)
 {
+#if defined(CONFIG_CPU_LOONGSON3)
+	return;
+#endif
 	if (!cpu_has_dc_aliases)
 		return;
 
@@ -528,6 +543,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 	unsigned long addr, unsigned long pfn)
 {
 	struct flush_cache_page_args args;
+#if defined(CONFIG_CPU_LOONGSON3)
+	return;
+#endif
 
 	args.vma = vma;
 	args.addr = addr;
@@ -543,6 +561,9 @@ static inline void local_r4k_flush_data_cache_page(void * addr)
 
 static void r4k_flush_data_cache_page(unsigned long addr)
 {
+#if defined(CONFIG_CPU_LOONGSON3)
+	return;
+#endif
 	if (in_atomic())
 		local_r4k_flush_data_cache_page((void *)addr);
 	else
@@ -701,6 +722,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
 
 static void r4k_flush_cache_sigtramp(unsigned long addr)
 {
+#if defined(CONFIG_CPU_LOONGSON3)
+	return;
+#endif
 	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
 }
 
@@ -952,6 +976,31 @@ static void __cpuinit probe_pcache(void)
 		c->dcache.waybit = 0;
 		break;
 
+	case CPU_LOONGSON3:
+		config1 = read_c0_config1();
+		if ((lsize = ((config1 >> 19) & 7)))
+			c->icache.linesz = 2 << lsize;
+		else
+			c->icache.linesz = lsize;
+		c->icache.sets = 64 << ((config1 >> 22) & 7);
+		c->icache.ways = 1 + ((config1 >> 16) & 7);
+		icache_size = c->icache.sets *
+					  c->icache.ways *
+					  c->icache.linesz;
+		c->icache.waybit = 0;
+
+		if ((lsize = ((config1 >> 10) & 7)))
+			c->dcache.linesz = 2 << lsize;
+		else
+			c->dcache.linesz = lsize;
+		c->dcache.sets = 64 << ((config1 >> 13) & 7);
+		c->dcache.ways = 1 + ((config1 >> 7) & 7);
+		dcache_size = c->dcache.sets *
+					  c->dcache.ways *
+					  c->dcache.linesz;
+		c->dcache.waybit = 0;
+		break;
+
 	default:
 		if (!(config & MIPS_CONF_M))
 			panic("Don't know how to probe P-caches on this cpu.");
@@ -1170,6 +1219,34 @@ static void __init loongson2_sc_init(void)
 }
 #endif
 
+#if defined(CONFIG_CPU_LOONGSON3)
+static void __init loongson3_sc_init(void)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	unsigned int config2, lsize;
+
+	config2 = read_c0_config2();
+	if ((lsize = ((config2 >> 4) & 15)))
+		c->scache.linesz = 2 << lsize;
+	else
+		c->scache.linesz = lsize;
+	c->scache.sets = 64 << ((config2 >> 8) & 15);
+	c->scache.ways = 1 + (config2 & 15);
+
+	scache_size = c->scache.sets *
+				  c->scache.ways *
+				  c->scache.linesz;
+	/* Loongson-3 has 4 cores, 1MB scache for each. scaches are shared */
+	scache_size *= 4;
+	c->scache.waybit = 0;
+	pr_info("Unified secondary cache %ldkB %s, linesize %d bytes.\n",
+	       scache_size >> 10, way_string[c->scache.ways], c->scache.linesz);
+	if (scache_size)
+		c->options |= MIPS_CPU_INCLUSIVE_CACHES;
+	return;
+}
+#endif
+
 extern int r5k_sc_init(void);
 extern int rm7k_sc_init(void);
 extern int mips_sc_init(void);
@@ -1224,6 +1301,13 @@ static void __cpuinit setup_scache(void)
 		loongson2_sc_init();
 		return;
 #endif
+
+#if defined(CONFIG_CPU_LOONGSON3)
+	case CPU_LOONGSON3:
+		loongson3_sc_init();
+		return;
+#endif
+
 	case CPU_XLP:
 		/* don't need to worry about L2, fully coherent */
 		return;
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index d2572cb..11b9c88 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -50,7 +50,7 @@ extern void build_tlb_refill_handler(void);
 
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-#if defined(CONFIG_CPU_LOONGSON2)
+#if defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_LOONGSON3)
 /*
  * LOONGSON2 has a 4 entry itlb which is a subset of dtlb,
  * unfortrunately, itlb is not totally transparent to software.
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 03eb0ef..4420250 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -507,6 +507,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BMIPS4380:
 	case CPU_BMIPS5000:
 	case CPU_LOONGSON2:
+	case CPU_LOONGSON3:
 	case CPU_R5500:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
-- 
1.7.7.3
