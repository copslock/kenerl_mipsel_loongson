Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 04:45:56 +0100 (CET)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:37074 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006150AbcCBDpwJkBOd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 04:45:52 +0100
X-QQ-mid: bizesmtp15t1456890313t778t25
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 02 Mar 2016 11:45:06 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK70B00A0000000
X-QQ-FEAT: 0ESs8nxzjD/+QOv9eIyZp9Iwdo9U+/bdMH0dXo8i+xBppsfX9ObJ8zDCoxv8o
        +VofecTfO+MPKgfUbSvZLrMzE4fprVLD/yYZ2RlfBwli+Gv0eax5vtWfQMfuEMYTP9+DhU7
        04D2HRiX67QzUzSWWDybgAaJN2fAlWR4R9WUrfZlbJr/T46iTQwdhzWPEs/yCbHJkdHHqQ4
        57A4N7LV5sjxVpxf7fLNZbDJ2vkuk6EJWV9yerC682GlNK60aI3spyd/+DkmJkakiY/xzR/
        WBDA==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V5 1/5] MIPS: Loongson: Add Loongson-3A R2 basic support
Date:   Wed,  2 Mar 2016 11:45:11 +0800
Message-Id: <1456890315-28814-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456890315-28814-1-git-send-email-chenhc@lemote.com>
References: <1456890315-28814-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Loongson-3 CPU family:

Code-name       Brand-name       PRId
Loongson-3A R1  Loongson-3A1000  0x6305
Loongson-3A R2  Loongson-3A2000  0x6308
Loongson-3B R1  Loongson-3B1000  0x6306
Loongson-3B R2  Loongson-3B1500  0x6307

Features of R2 revision of Loongson-3A:
1, Primary cache includes I-Cache, D-Cache and V-Cache (Victim Cache).
2, I-Cache, D-Cache and V-Cache are 16-way set-associative, linesize is 64 Bytes.
3, 64 entries of VTLB (classic TLB), 1024 entries of FTLB (8-way set-associative).
4, Support DSP/DSPv2 instructions, UserLocal register and Read-Inhibit/Execute-Inhibit.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig                                  |   1 +
 arch/mips/include/asm/cacheops.h                   |   6 ++
 arch/mips/include/asm/cpu-info.h                   |   1 +
 arch/mips/include/asm/cpu.h                        |   4 +-
 .../asm/mach-loongson64/cpu-feature-overrides.h    |  12 +--
 .../asm/mach-loongson64/kernel-entry-init.h        |   6 +-
 arch/mips/include/asm/mipsregs.h                   |   2 +
 arch/mips/include/asm/pgtable-bits.h               |   8 +-
 arch/mips/include/asm/pgtable.h                    |   4 +-
 arch/mips/kernel/cpu-probe.c                       |  38 +++++++-
 arch/mips/kernel/idle.c                            |   5 +
 arch/mips/kernel/traps.c                           |   3 +-
 arch/mips/loongson64/common/env.c                  |   7 +-
 arch/mips/loongson64/loongson-3/smp.c              | 106 +++++++++++++++++++--
 arch/mips/mm/c-r4k.c                               |  27 ++++++
 arch/mips/mm/tlbex.c                               |   2 +-
 drivers/platform/mips/cpu_hwmon.c                  |   4 +-
 17 files changed, 201 insertions(+), 35 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c5bf89cb..38c0b11 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1344,6 +1344,7 @@ config CPU_LOONGSON3
 	select CPU_SUPPORTS_HUGEPAGES
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
+	select MIPS_PGD_C0_CONTEXT
 	select ARCH_REQUIRE_GPIOLIB
 	help
 		The Loongson 3 processor implements the MIPS64R2 instruction
diff --git a/arch/mips/include/asm/cacheops.h b/arch/mips/include/asm/cacheops.h
index c3212ff..8031fbc 100644
--- a/arch/mips/include/asm/cacheops.h
+++ b/arch/mips/include/asm/cacheops.h
@@ -21,6 +21,7 @@
 #define Cache_I				0x00
 #define Cache_D				0x01
 #define Cache_T				0x02
+#define Cache_V				0x02 /* Loongson-3 */
 #define Cache_S				0x03
 
 #define Index_Writeback_Inv		0x00
@@ -107,4 +108,9 @@
  */
 #define Hit_Invalidate_I_Loongson2	(Cache_I | 0x00)
 
+/*
+ * Loongson3-specific cacheops
+ */
+#define Index_Writeback_Inv_V		(Cache_V | Index_Writeback_Inv)
+
 #endif	/* __ASM_CACHEOPS_H */
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index e7dc785..6fd7b8bd 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -60,6 +60,7 @@ struct cpuinfo_mips {
 	int			tlbsizeftlbways;
 	struct cache_desc	icache; /* Primary I-cache */
 	struct cache_desc	dcache; /* Primary D or combined I/D cache */
+	struct cache_desc	vcache; /* Victim cache, between pcache and scache */
 	struct cache_desc	scache; /* Secondary cache */
 	struct cache_desc	tcache; /* Tertiary/split secondary cache */
 	int			srsets; /* Shadow register sets */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 7bea0f3..68807b8 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -42,6 +42,7 @@
 #define PRID_COMP_LEXRA		0x0b0000
 #define PRID_COMP_NETLOGIC	0x0c0000
 #define PRID_COMP_CAVIUM	0x0d0000
+#define PRID_COMP_LOONGSON	0x140000
 #define PRID_COMP_INGENIC_D0	0xd00000	/* JZ4740, JZ4750 */
 #define PRID_COMP_INGENIC_D1	0xd10000	/* JZ4770, JZ4775 */
 #define PRID_COMP_INGENIC_E1	0xe10000	/* JZ4780 */
@@ -239,9 +240,10 @@
 #define PRID_REV_LOONGSON1B	0x0020
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
-#define PRID_REV_LOONGSON3A	0x0005
+#define PRID_REV_LOONGSON3A_R1	0x0005
 #define PRID_REV_LOONGSON3B_R1	0x0006
 #define PRID_REV_LOONGSON3B_R2	0x0007
+#define PRID_REV_LOONGSON3A_R2	0x0008
 
 /*
  * Older processors used to encode processor version and revision in two
diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index 98963c2..c3406db 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -16,11 +16,6 @@
 #ifndef __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H
 #define __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H
 
-#define cpu_dcache_line_size()	32
-#define cpu_icache_line_size()	32
-#define cpu_scache_line_size()	32
-
-
 #define cpu_has_32fpr		1
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
@@ -31,8 +26,6 @@
 #define cpu_has_counter		1
 #define cpu_has_dc_aliases	(PAGE_SIZE < 0x4000)
 #define cpu_has_divec		0
-#define cpu_has_dsp		0
-#define cpu_has_dsp2		0
 #define cpu_has_ejtag		0
 #define cpu_has_ic_fills_f_dc	0
 #define cpu_has_inclusive_pcaches	1
@@ -40,15 +33,11 @@
 #define cpu_has_mcheck		0
 #define cpu_has_mdmx		0
 #define cpu_has_mips16		0
-#define cpu_has_mips32r2	0
 #define cpu_has_mips3d		0
-#define cpu_has_mips64r2	0
 #define cpu_has_mipsmt		0
-#define cpu_has_prefetch	0
 #define cpu_has_smartmips	0
 #define cpu_has_tlb		1
 #define cpu_has_tx39_cache	0
-#define cpu_has_userlocal	0
 #define cpu_has_vce		0
 #define cpu_has_veic		0
 #define cpu_has_vint		0
@@ -57,5 +46,6 @@
 #define cpu_has_local_ebase	0
 
 #define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
+#define cpu_hwrena_impl_bits	0xc0000000
 
 #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index 3f2f84f..da83482 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -23,7 +23,8 @@
 	or	t0, (0x1 << 7)
 	mtc0	t0, $16, 3
 	/* Set ELPA on LOONGSON3 pagegrain */
-	li	t0, (0x1 << 29)
+	mfc0	t0, $5, 1
+	or	t0, (0x1 << 29)
 	mtc0	t0, $5, 1
 	_ehb
 	.set	pop
@@ -42,7 +43,8 @@
 	or	t0, (0x1 << 7)
 	mtc0	t0, $16, 3
 	/* Set ELPA on LOONGSON3 pagegrain */
-	li	t0, (0x1 << 29)
+	mfc0	t0, $5, 1
+	or	t0, (0x1 << 29)
 	mtc0	t0, $5, 1
 	_ehb
 	.set	pop
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 3ad19ad..9290fd4 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -633,6 +633,8 @@
 #define MIPS_CONF6_SYND		(_ULCAST_(1) << 13)
 /* proAptiv FTLB on/off bit */
 #define MIPS_CONF6_FTLBEN	(_ULCAST_(1) << 15)
+/* Loongson-3 FTLB on/off bit */
+#define MIPS_CONF6_FTLBDIS	(_ULCAST_(1) << 22)
 /* FTLB probability bits */
 #define MIPS_CONF6_FTLBP_SHIFT	(16)
 
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 97b3138..32b77bd 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -113,7 +113,7 @@
 #define _PAGE_PRESENT_SHIFT	0
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
 /* R2 or later cores check for RI/XI support to determine _PAGE_READ */
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) || defined(CONFIG_CPU_LOONGSON3)
 #define _PAGE_WRITE_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
 #else
@@ -133,7 +133,7 @@
 #define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
 #endif	/* CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT */
 
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) || defined(CONFIG_CPU_LOONGSON3)
 /* XI - page cannot be executed */
 #ifdef _PAGE_HUGE_SHIFT
 #define _PAGE_NO_EXEC_SHIFT	(_PAGE_HUGE_SHIFT + 1)
@@ -147,7 +147,7 @@
 #define _PAGE_READ		(cpu_has_rixi ? 0 : (1 << _PAGE_READ_SHIFT))
 #define _PAGE_NO_READ_SHIFT	_PAGE_READ_SHIFT
 #define _PAGE_NO_READ		(cpu_has_rixi ? (1 << _PAGE_READ_SHIFT) : 0)
-#endif	/* defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) */
+#endif	/* defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) || defined(CONFIG_CPU_LOONGSON3) */
 
 #if defined(_PAGE_NO_READ_SHIFT)
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
@@ -198,7 +198,7 @@
  */
 static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 {
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) || defined(CONFIG_CPU_LOONGSON3)
 	if (cpu_has_rixi) {
 		int sa;
 #ifdef CONFIG_32BIT
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 9a4fe01..35cd713 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -353,7 +353,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) || defined(CONFIG_CPU_LOONGSON3)
 	if (!(pte_val(pte) & _PAGE_NO_READ))
 		pte_val(pte) |= _PAGE_SILENT_READ;
 	else
@@ -542,7 +542,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 {
 	pmd_val(pmd) |= _PAGE_ACCESSED;
 
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) || defined(CONFIG_CPU_LOONGSON3)
 	if (!(pmd_val(pmd) & _PAGE_NO_READ))
 		pmd_val(pmd) |= _PAGE_SILENT_READ;
 	else
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 9ad6157..2a2ae86 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -561,6 +561,16 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 		write_c0_config7(config | (calculate_ftlb_probability(c)
 					   << MIPS_CONF7_FTLBP_SHIFT));
 		break;
+	case CPU_LOONGSON3:
+		/* Loongson-3 cores use Config6 to enable the FTLB */
+		config = read_c0_config6();
+		if (enable)
+			/* Enable FTLB */
+			write_c0_config6(config & ~MIPS_CONF6_FTLBDIS);
+		else
+			/* Disable FTLB */
+			write_c0_config6(config | MIPS_CONF6_FTLBDIS);
+		break;
 	default:
 		return 1;
 	}
@@ -1172,7 +1182,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			set_isa(c, MIPS_CPU_ISA_III);
 			c->fpu_msk31 |= FPU_CSR_CONDX;
 			break;
-		case PRID_REV_LOONGSON3A:
+		case PRID_REV_LOONGSON3A_R1:
 			c->cputype = CPU_LOONGSON3;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
@@ -1495,6 +1505,29 @@ platform:
 	}
 }
 
+static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
+{
+	switch (c->processor_id & PRID_IMP_MASK) {
+	case PRID_IMP_LOONGSON_64:  /* Loongson-2/3 */
+		switch (c->processor_id & PRID_REV_MASK) {
+		case PRID_REV_LOONGSON3A_R2:
+			c->cputype = CPU_LOONGSON3;
+			__cpu_name[cpu] = "ICT Loongson-3";
+			set_elf_platform(cpu, "loongson3a");
+			set_isa(c, MIPS_CPU_ISA_M64R2);
+			break;
+		}
+
+		decode_configs(c);
+		c->options |= MIPS_CPU_TLBINV;
+		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
+		break;
+	default:
+		panic("Unknown Loongson Processor ID!");
+		break;
+	}
+}
+
 static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
@@ -1642,6 +1675,9 @@ void cpu_probe(void)
 	case PRID_COMP_CAVIUM:
 		cpu_probe_cavium(c, cpu);
 		break;
+	case PRID_COMP_LOONGSON:
+		cpu_probe_loongson(c, cpu);
+		break;
 	case PRID_COMP_INGENIC_D0:
 	case PRID_COMP_INGENIC_D1:
 	case PRID_COMP_INGENIC_E1:
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 46794d6..60ab4c4 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -181,6 +181,11 @@ void __init check_wait(void)
 	case CPU_XLP:
 		cpu_wait = r4k_wait;
 		break;
+	case CPU_LOONGSON3:
+		if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R2)
+			cpu_wait = r4k_wait;
+		break;
+
 	case CPU_BMIPS5000:
 		cpu_wait = r4k_wait_irqoff;
 		break;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index c01f615..e49e7bc 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1770,7 +1770,8 @@ asmlinkage void do_ftlb(void)
 
 	/* For the moment, report the problem and hang. */
 	if ((cpu_has_mips_r2_r6) &&
-	    ((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_MIPS)) {
+	    (((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_MIPS) ||
+	    ((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_LOONGSON))) {
 		pr_err("FTLB error exception, cp0_ecc=0x%08x:\n",
 		       read_c0_ecc());
 		pr_err("cp0_errorepc == %0*lx\n", field, read_c0_errorepc());
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index d6d07ad..57d590a 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -105,6 +105,10 @@ void __init prom_init_env(void)
 		loongson_chiptemp[1] = 0x900010001fe0019c;
 		loongson_chiptemp[2] = 0x900020001fe0019c;
 		loongson_chiptemp[3] = 0x900030001fe0019c;
+		loongson_freqctrl[0] = 0x900000001fe001d0;
+		loongson_freqctrl[1] = 0x900010001fe001d0;
+		loongson_freqctrl[2] = 0x900020001fe001d0;
+		loongson_freqctrl[3] = 0x900030001fe001d0;
 		loongson_sysconf.ht_control_base = 0x90000EFDFB000000;
 		loongson_sysconf.workarounds = WORKAROUND_CPUFREQ;
 	} else if (ecpu->cputype == Loongson_3B) {
@@ -187,7 +191,8 @@ void __init prom_init_env(void)
 		case PRID_REV_LOONGSON2F:
 			cpu_clock_freq = 797000000;
 			break;
-		case PRID_REV_LOONGSON3A:
+		case PRID_REV_LOONGSON3A_R1:
+		case PRID_REV_LOONGSON3A_R2:
 			cpu_clock_freq = 900000000;
 			break;
 		case PRID_REV_LOONGSON3B_R1:
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index b913cd2..e59759a 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -439,7 +439,7 @@ static void loongson3_cpu_die(unsigned int cpu)
  * flush all L1 entries at first. Then, another core (usually Core 0) can
  * safely disable the clock of the target core. loongson3_play_dead() is
  * called via CKSEG1 (uncached and unmmaped) */
-static void loongson3a_play_dead(int *state_addr)
+static void loongson3a_r1_play_dead(int *state_addr)
 {
 	register int val;
 	register long cpuid, core, node, count;
@@ -501,6 +501,89 @@ static void loongson3a_play_dead(int *state_addr)
 		: "a1");
 }
 
+static void loongson3a_r2_play_dead(int *state_addr)
+{
+	register int val;
+	register long cpuid, core, node, count;
+	register void *addr, *base, *initfunc;
+
+	__asm__ __volatile__(
+		"   .set push                     \n"
+		"   .set noreorder                \n"
+		"   li %[addr], 0x80000000        \n" /* KSEG0 */
+		"1: cache 0, 0(%[addr])           \n" /* flush L1 ICache */
+		"   cache 0, 1(%[addr])           \n"
+		"   cache 0, 2(%[addr])           \n"
+		"   cache 0, 3(%[addr])           \n"
+		"   cache 1, 0(%[addr])           \n" /* flush L1 DCache */
+		"   cache 1, 1(%[addr])           \n"
+		"   cache 1, 2(%[addr])           \n"
+		"   cache 1, 3(%[addr])           \n"
+		"   addiu %[sets], %[sets], -1    \n"
+		"   bnez  %[sets], 1b             \n"
+		"   addiu %[addr], %[addr], 0x40  \n"
+		"   li %[addr], 0x80000000        \n" /* KSEG0 */
+		"2: cache 2, 0(%[addr])           \n" /* flush L1 VCache */
+		"   cache 2, 1(%[addr])           \n"
+		"   cache 2, 2(%[addr])           \n"
+		"   cache 2, 3(%[addr])           \n"
+		"   cache 2, 4(%[addr])           \n"
+		"   cache 2, 5(%[addr])           \n"
+		"   cache 2, 6(%[addr])           \n"
+		"   cache 2, 7(%[addr])           \n"
+		"   cache 2, 8(%[addr])           \n"
+		"   cache 2, 9(%[addr])           \n"
+		"   cache 2, 10(%[addr])          \n"
+		"   cache 2, 11(%[addr])          \n"
+		"   cache 2, 12(%[addr])          \n"
+		"   cache 2, 13(%[addr])          \n"
+		"   cache 2, 14(%[addr])          \n"
+		"   cache 2, 15(%[addr])          \n"
+		"   addiu %[vsets], %[vsets], -1  \n"
+		"   bnez  %[vsets], 2b            \n"
+		"   addiu %[addr], %[addr], 0x40  \n"
+		"   li    %[val], 0x7             \n" /* *state_addr = CPU_DEAD; */
+		"   sw    %[val], (%[state_addr]) \n"
+		"   sync                          \n"
+		"   cache 21, (%[state_addr])     \n" /* flush entry of *state_addr */
+		"   .set pop                      \n"
+		: [addr] "=&r" (addr), [val] "=&r" (val)
+		: [state_addr] "r" (state_addr),
+		  [sets] "r" (cpu_data[smp_processor_id()].dcache.sets),
+		  [vsets] "r" (cpu_data[smp_processor_id()].vcache.sets));
+
+	__asm__ __volatile__(
+		"   .set push                         \n"
+		"   .set noreorder                    \n"
+		"   .set mips64                       \n"
+		"   mfc0  %[cpuid], $15, 1            \n"
+		"   andi  %[cpuid], 0x3ff             \n"
+		"   dli   %[base], 0x900000003ff01000 \n"
+		"   andi  %[core], %[cpuid], 0x3      \n"
+		"   sll   %[core], 8                  \n" /* get core id */
+		"   or    %[base], %[base], %[core]   \n"
+		"   andi  %[node], %[cpuid], 0xc      \n"
+		"   dsll  %[node], 42                 \n" /* get node id */
+		"   or    %[base], %[base], %[node]   \n"
+		"1: li    %[count], 0x100             \n" /* wait for init loop */
+		"2: bnez  %[count], 2b                \n" /* limit mailbox access */
+		"   addiu %[count], -1                \n"
+		"   ld    %[initfunc], 0x20(%[base])  \n" /* get PC via mailbox */
+		"   beqz  %[initfunc], 1b             \n"
+		"   nop                               \n"
+		"   ld    $sp, 0x28(%[base])          \n" /* get SP via mailbox */
+		"   ld    $gp, 0x30(%[base])          \n" /* get GP via mailbox */
+		"   ld    $a1, 0x38(%[base])          \n"
+		"   jr    %[initfunc]                 \n" /* jump to initial PC */
+		"   nop                               \n"
+		"   .set pop                          \n"
+		: [core] "=&r" (core), [node] "=&r" (node),
+		  [base] "=&r" (base), [cpuid] "=&r" (cpuid),
+		  [count] "=&r" (count), [initfunc] "=&r" (initfunc)
+		: /* No Input */
+		: "a1");
+}
+
 static void loongson3b_play_dead(int *state_addr)
 {
 	register int val;
@@ -572,13 +655,18 @@ void play_dead(void)
 	void (*play_dead_at_ckseg1)(int *);
 
 	idle_task_exit();
-	switch (loongson_sysconf.cputype) {
-	case Loongson_3A:
+	switch (read_c0_prid() & PRID_REV_MASK) {
+	case PRID_REV_LOONGSON3A_R1:
 	default:
 		play_dead_at_ckseg1 =
-			(void *)CKSEG1ADDR((unsigned long)loongson3a_play_dead);
+			(void *)CKSEG1ADDR((unsigned long)loongson3a_r1_play_dead);
+		break;
+	case PRID_REV_LOONGSON3A_R2:
+		play_dead_at_ckseg1 =
+			(void *)CKSEG1ADDR((unsigned long)loongson3a_r2_play_dead);
 		break;
-	case Loongson_3B:
+	case PRID_REV_LOONGSON3B_R1:
+	case PRID_REV_LOONGSON3B_R2:
 		play_dead_at_ckseg1 =
 			(void *)CKSEG1ADDR((unsigned long)loongson3b_play_dead);
 		break;
@@ -593,9 +681,9 @@ void loongson3_disable_clock(int cpu)
 	uint64_t core_id = cpu_data[cpu].core;
 	uint64_t package_id = cpu_data[cpu].package;
 
-	if (loongson_sysconf.cputype == Loongson_3A) {
+	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
 		LOONGSON_CHIPCFG(package_id) &= ~(1 << (12 + core_id));
-	} else if (loongson_sysconf.cputype == Loongson_3B) {
+	} else {
 		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
 			LOONGSON_FREQCTRL(package_id) &= ~(1 << (core_id * 4 + 3));
 	}
@@ -606,9 +694,9 @@ void loongson3_enable_clock(int cpu)
 	uint64_t core_id = cpu_data[cpu].core;
 	uint64_t package_id = cpu_data[cpu].package;
 
-	if (loongson_sysconf.cputype == Loongson_3A) {
+	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
 		LOONGSON_CHIPCFG(package_id) |= 1 << (12 + core_id);
-	} else if (loongson_sysconf.cputype == Loongson_3B) {
+	} else {
 		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
 			LOONGSON_FREQCTRL(package_id) |= 1 << (core_id * 4 + 3);
 	}
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index caac3d7..2abc73d 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -77,6 +77,7 @@ static inline void r4k_on_each_cpu(void (*func) (void *info), void *info)
  */
 static unsigned long icache_size __read_mostly;
 static unsigned long dcache_size __read_mostly;
+static unsigned long vcache_size __read_mostly;
 static unsigned long scache_size __read_mostly;
 
 /*
@@ -1328,6 +1329,31 @@ static void probe_pcache(void)
 	       c->dcache.linesz);
 }
 
+static void probe_vcache(void)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	unsigned int config2, lsize;
+
+	if (current_cpu_type() != CPU_LOONGSON3)
+		return;
+
+	config2 = read_c0_config2();
+	if ((lsize = ((config2 >> 20) & 15)))
+		c->vcache.linesz = 2 << lsize;
+	else
+		c->vcache.linesz = lsize;
+
+	c->vcache.sets = 64 << ((config2 >> 24) & 15);
+	c->vcache.ways = 1 + ((config2 >> 16) & 15);
+
+	vcache_size = c->vcache.sets * c->vcache.ways * c->vcache.linesz;
+
+	c->vcache.waybit = 0;
+
+	pr_info("Unified victim cache %ldkB %s, linesize %d bytes.\n",
+		vcache_size >> 10, way_string[c->vcache.ways], c->vcache.linesz);
+}
+
 /*
  * If you even _breathe_ on this function, look at the gcc output and make sure
  * it does not pop things on and off the stack for the cache sizing loop that
@@ -1650,6 +1676,7 @@ void r4k_cache_init(void)
 	struct cpuinfo_mips *c = &current_cpu_data;
 
 	probe_pcache();
+	probe_vcache();
 	setup_scache();
 
 	r4k_blast_dcache_page_setup();
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 84c6e3f..b1a712f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -241,7 +241,7 @@ static void output_pgtable_bits_defines(void)
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	pr_define("_PAGE_HUGE_SHIFT %d\n", _PAGE_HUGE_SHIFT);
 #endif
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) || defined(CONFIG_CPU_LOONGSON3)
 	if (cpu_has_rixi) {
 #ifdef _PAGE_NO_EXEC_SHIFT
 		pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
index 0f6c63e..8c5072b 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -20,9 +20,9 @@ int loongson3_cpu_temp(int cpu)
 	u32 reg;
 
 	reg = LOONGSON_CHIPTEMP(cpu);
-	if (loongson_sysconf.cputype == Loongson_3A)
+	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1)
 		reg = (reg >> 8) & 0xff;
-	else if (loongson_sysconf.cputype == Loongson_3B)
+	else
 		reg = ((reg >> 8) & 0xff) - 100;
 
 	return (int)reg * 1000;
-- 
2.7.0
