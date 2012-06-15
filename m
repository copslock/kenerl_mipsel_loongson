Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 10:11:36 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:50514 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901760Ab2FOILG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 10:11:06 +0200
Received: by pbbrq13 with SMTP id rq13so5186436pbb.36
        for <multiple recipients>; Fri, 15 Jun 2012 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2dMRNe6gsaV0ibTfFsHAlIIUqykXv74HjNTHTAqn9y8=;
        b=ZGOAZNldP4uAlMNZLBuytswj4tS00Gf00wN9mG9k+MgymZpmnU6/dUpPvWBHlicBLS
         rwaNeONyIxZoCgZkRW3P/MfGfHoYZD/5eZdBwtqtzbvP6j7GHcKbr8x9IAUWtrDnHcHn
         b0JtfoMpd5PEFg/7n+aMS0PKEeHSH5GfSv9gG1nUOD4OEdr2yQPH/O2FwbGmVw0Gt5uU
         Idc9xGn8RiJhJoNH3sfoZ3arKdJB+t1tB3zC57Gx62FUMa2bGC8E2LqDC9tvNMJsfAXe
         xXdGMMobbuTWsE8glujxWezrp13Fs2ucH6FMloxtCbY6zmicMwZjL5JL7aqNbIvqqPeI
         aeAQ==
Received: by 10.68.228.136 with SMTP id si8mr17407486pbc.159.1339747859863;
        Fri, 15 Jun 2012 01:10:59 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nh8sm12437247pbc.60.2012.06.15.01.10.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 01:10:58 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH 01/14] MIPS: Loongson: Add basic Loongson 3 CPU support.
Date:   Fri, 15 Jun 2012 16:09:48 +0800
Message-Id: <1339747801-28691-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33639
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

Loongson-3 is a multi-core MIPS family CPU, it support MIPS64R2
fully. Loongson-3 has the same IMP field (0x6300) as Loongson-2.

Loongson-3 has a hardware-maintained cache, system software doesn't
need to maintain coherency.

Loongson-3A is the first revision of Loongson-3, and it is the quad-
core version of Loongson-2G. Loongson-3A has a simplified version named
Loongson-2Gq, the main difference between Loongson-3A/2Gq is 3A has two
HyperTransport controller but 2Gq has only one. HT0 is used for cross-
chip interconnection and HT1 is used to link PCI bus. Therefore, 2Gq
cannot support NUMA but 3A can.

Exsisting Loongson family CPUs:
Loongson-1: Loongson-1A, Loongson-1B, they are 32-bit MIPS CPUs.
Loongson-2: Loongson-2E, Loongson-2F, Loongson-2G(including Loongson-
            2Gq), they are 64-bit MIPS CPUs.
Loongson-3: Loongson-3A, it is a 64-bit MIPS CPU.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/Kconfig                            |   13 ++++
 arch/mips/include/asm/addrspace.h            |    6 ++
 arch/mips/include/asm/cpu.h                  |    6 +-
 arch/mips/include/asm/mach-loongson/spaces.h |   15 +++++
 arch/mips/include/asm/module.h               |    2 +
 arch/mips/include/asm/pgtable-bits.h         |    7 ++
 arch/mips/kernel/Makefile                    |    1 +
 arch/mips/kernel/cpu-probe.c                 |   12 +++-
 arch/mips/lib/Makefile                       |    1 +
 arch/mips/loongson/Kconfig                   |    4 +
 arch/mips/loongson/Platform                  |    1 +
 arch/mips/loongson/common/env.c              |    3 +
 arch/mips/loongson/common/setup.c            |    6 +-
 arch/mips/mm/Makefile                        |    1 +
 arch/mips/mm/c-r4k.c                         |   84 ++++++++++++++++++++++++++
 arch/mips/mm/tlb-r4k.c                       |    2 +-
 arch/mips/mm/tlbex.c                         |    1 +
 17 files changed, 156 insertions(+), 9 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/spaces.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c179461..38e460b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1544,6 +1544,16 @@ config CPU_LOONGSON2
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 
+config CPU_LOONGSON3
+	bool "Loongson 3 CPU"
+	depends on SYS_HAS_CPU_LOONGSON3
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	help
+		The Loongson 3 processor implements the MIPS III instruction set
+		with many extensions.
+
 config CPU_BMIPS
 	bool
 	select CPU_MIPS32
@@ -1562,6 +1572,9 @@ config SYS_HAS_CPU_LOONGSON2F
 	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
 	select CPU_SUPPORTS_UNCACHED_ACCELERATED
 
+config SYS_HAS_CPU_LOONGSON3
+	bool
+
 config SYS_HAS_CPU_MIPS32_R1
 	bool
 
diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
index 569f80a..cf62bfb 100644
--- a/arch/mips/include/asm/addrspace.h
+++ b/arch/mips/include/asm/addrspace.h
@@ -116,7 +116,13 @@
 #define K_CALG_UNCACHED		2
 #define K_CALG_NONCOHERENT	3
 #define K_CALG_COH_EXCL		4
+
+#ifdef CONFIG_CPU_LOONGSON3
+#define K_CALG_COH_SHAREABLE	3
+#else
 #define K_CALG_COH_SHAREABLE	5
+#endif
+
 #define K_CALG_NOTUSED		6
 #define K_CALG_UNCACHED_ACCEL	7
 
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 95e40c1..3fa996a 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -72,6 +72,7 @@
 #define PRID_IMP_R5432		0x5400
 #define PRID_IMP_R5500		0x5500
 #define PRID_IMP_LOONGSON2	0x6300
+#define PRID_IMP_LOONGSON3	0x6300
 
 #define PRID_IMP_UNKNOWN	0xff00
 
@@ -199,6 +200,7 @@
 #define PRID_REV_34K_V1_0_2	0x0022
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
+#define PRID_REV_LOONGSON3A	0x0005
 
 /*
  * Older processors used to encode processor version and revision in two
@@ -267,8 +269,8 @@ enum cpu_type_enum {
 	 * MIPS64 class processors
 	 */
 	CPU_5KC, CPU_5KE, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
-	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
-	CPU_XLR, CPU_XLP,
+	CPU_LOONGSON3, CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
+	CPU_CAVIUM_OCTEON2, CPU_XLR, CPU_XLP,
 
 	CPU_LAST
 };
diff --git a/arch/mips/include/asm/mach-loongson/spaces.h b/arch/mips/include/asm/mach-loongson/spaces.h
new file mode 100644
index 0000000..1e82804
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/spaces.h
@@ -0,0 +1,15 @@
+#ifndef __ASM_MACH_LOONGSON_SPACES_H_
+#define __ASM_MACH_LOONGSON_SPACES_H_
+
+#ifndef CAC_BASE
+#if defined(CONFIG_64BIT)
+#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_CPU_LOONGSON3)
+#define CAC_BASE        _AC(0x9800000000000000, UL)
+#else
+#define CAC_BASE        _AC(0xa800000000000000, UL)
+#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_CPU_LOONGSON3 */
+#endif /* CONFIG_64BIT */
+#endif /* CONFIG_CAC_BASE */
+
+#include <asm/mach-generic/spaces.h>
+#endif
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index 5300080..375964a 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -119,6 +119,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "SB1 "
 #elif defined CONFIG_CPU_LOONGSON2
 #define MODULE_PROC_FAMILY "LOONGSON2 "
+#elif defined CONFIG_CPU_LOONGSON3
+#define MODULE_PROC_FAMILY "LOONGSON3 "
 #elif defined CONFIG_CPU_CAVIUM_OCTEON
 #define MODULE_PROC_FAMILY "OCTEON "
 #elif defined CONFIG_CPU_XLR
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index e9fe7e9..1afd39a 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -206,6 +206,13 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #define _CACHE_UNCACHED		    _CACHE_UC_B
 #define _CACHE_CACHABLE_NONCOHERENT _CACHE_WB
 
+#elif defined(CONFIG_CPU_LOONGSON3)
+
+#define _CACHE_UNCACHED             (2<<_CACHE_SHIFT)  /* LOONGSON       */
+#define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON       */
+#define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3     */
+#define _CACHE_UNCACHED_ACCELERATED (7<<_CACHE_SHIFT)  /* LOONGSON       */
+
 #else
 
 #define _CACHE_CACHABLE_NO_WA	    (0<<_CACHE_SHIFT)  /* R4600 only      */
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
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index aca93ee..d46a923 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -89,4 +89,8 @@ config LOONGSON_MC146818
 	bool
 	default n
 
+config ARCH_SPARSEMEM_ENABLE
+	bool
+	select SPARSEMEM_STATIC
+
 endif # MACH_LOONGSON
diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
index 29692e5..6205372 100644
--- a/arch/mips/loongson/Platform
+++ b/arch/mips/loongson/Platform
@@ -30,3 +30,4 @@ platform-$(CONFIG_MACH_LOONGSON) += loongson/
 cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
 load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
+load-$(CONFIG_CPU_LOONGSON3) += 0xffffffff80200000
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index d93830a..efae736 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -68,6 +68,9 @@ void __init prom_init_env(void)
 		case PRID_REV_LOONGSON2F:
 			cpu_clock_freq = 797000000;
 			break;
+		case PRID_REV_LOONGSON3A:
+			cpu_clock_freq = 900000000;
+			break;
 		default:
 			cpu_clock_freq = 100000000;
 			break;
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
