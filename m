Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 12:38:08 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1629 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903969Ab1KKLhR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 12:37:17 +0100
X-TM-IMSS-Message-ID: <1accc7700007c9d8@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 1accc7700007c9d8 ; Fri, 11 Nov 2011 03:37:10 -0800
Date:   Fri, 11 Nov 2011 17:09:13 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [PATCH 06/12] MIPS: Netlogic: XLP CPU support.
Message-ID: <e2ce7a4fe957860451141599413998c6cbcd7949.1321011001.git.jayachandranc@netlogicmicro.com>
References: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 11 Nov 2011 11:37:09.0583 (UTC) FILETIME=[3F4A15F0:01CCA066]
X-archive-position: 31548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10226

Add support for Netlogic's XLP MIPS SoC. This patch adds:
* XLP processor ID in cpu_probe.c and asm/cpu.h
* XLP case to asm/module.h
* CPU_XLP case to mm/tlbex.c
* minor change to r4k cache handling to ignore XLP secondary cache
* XLP cpu overrides to mach-netlogic/cpu-feature-overrides.h

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/cpu.h                        |    3 ++-
 .../asm/mach-netlogic/cpu-feature-overrides.h      |   18 ++++++++++++++----
 arch/mips/include/asm/module.h                     |    2 ++
 arch/mips/kernel/cpu-probe.c                       |   19 ++++++++++++++++---
 arch/mips/mm/c-r4k.c                               |    3 +++
 5 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 79e4a0d..54e35ad 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -171,6 +171,7 @@
 #define PRID_IMP_NETLOGIC_XLS404B	0x4f00
 #define PRID_IMP_NETLOGIC_AU13XX	0x8000
 
+#define PRID_IMP_NETLOGIC_XLP832	0x1000
 /*
  * Definitions for 7:0 on legacy processors
  */
@@ -264,7 +265,7 @@ enum cpu_type_enum {
 	 */
 	CPU_5KC, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
 	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
-	CPU_XLR,
+	CPU_XLR, CPU_XLP,
 
 	CPU_LAST
 };
diff --git a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
index 3780743..d193fb6 100644
--- a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
@@ -24,23 +24,33 @@
 
 #define cpu_has_llsc		1
 #define cpu_has_vtag_icache	0
-#define cpu_has_dc_aliases	0
 #define cpu_has_ic_fills_f_dc	1
 #define cpu_has_dsp		0
 #define cpu_has_mipsmt		0
-#define cpu_has_userlocal	0
 #define cpu_icache_snoops_remote_store	1
 
 #define cpu_has_64bits		1
 
 #define cpu_has_mips32r1	1
-#define cpu_has_mips32r2	0
 #define cpu_has_mips64r1	1
-#define cpu_has_mips64r2	0
 
 #define cpu_has_inclusive_pcaches	0
 
 #define cpu_dcache_line_size()	32
 #define cpu_icache_line_size()	32
 
+#if defined(CONFIG_CPU_XLR)
+#define cpu_has_userlocal	0
+#define cpu_has_dc_aliases	0
+#define cpu_has_mips32r2	0
+#define cpu_has_mips64r2	0
+#elif defined(CONFIG_CPU_XLP)
+#define cpu_has_userlocal	1
+#define cpu_has_mips32r2	1
+#define cpu_has_mips64r2	1
+#define cpu_has_dc_aliases	1
+#else
+#error "Unknown Netlogic CPU"
+#endif
+
 #endif /* __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index bc01a02..2278e34 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -120,6 +120,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "OCTEON "
 #elif defined CONFIG_CPU_XLR
 #define MODULE_PROC_FAMILY "XLR "
+#elif defined CONFIG_CPU_XLP
+#define MODULE_PROC_FAMILY "XLP "
 #else
 #error MODULE_PROC_FAMILY undefined for your processor configuration
 #endif
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ee6eab6..906e916 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -192,6 +192,7 @@ void __init check_wait(void)
 	case CPU_CAVIUM_OCTEON2:
 	case CPU_JZRISC:
 	case CPU_XLR:
+	case CPU_XLP:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -1031,6 +1032,11 @@ static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
 			MIPS_CPU_LLSC);
 
 	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_NETLOGIC_XLP832:
+		c->cputype = CPU_XLP;
+		__cpu_name[cpu] = "Netlogic XLP";
+		break;
+
 	case PRID_IMP_NETLOGIC_XLR732:
 	case PRID_IMP_NETLOGIC_XLR716:
 	case PRID_IMP_NETLOGIC_XLR532:
@@ -1061,14 +1067,21 @@ static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
 		break;
 
 	default:
-		printk(KERN_INFO "Unknown Netlogic chip id [%02x]!\n",
+		pr_info("Unknown Netlogic chip id [%02x]!\n",
 		       c->processor_id);
 		c->cputype = CPU_XLR;
 		break;
 	}
 
-	c->isa_level = MIPS_CPU_ISA_M64R1;
-	c->tlbsize = ((read_c0_config1() >> 25) & 0x3f) + 1;
+	if (c->cputype == CPU_XLP) {
+		c->isa_level = MIPS_CPU_ISA_M64R2;
+		c->options |= (MIPS_CPU_FPU | MIPS_CPU_ULRI | MIPS_CPU_MCHECK);
+		/* This will be updated again after all threads are woken up */
+		c->tlbsize = ((read_c0_config6() >> 16) & 0xffff) + 1;
+	} else {
+		c->isa_level = MIPS_CPU_ISA_M64R1;
+		c->tlbsize = ((read_c0_config1() >> 25) & 0x3f) + 1;
+	}
 }
 
 #ifdef CONFIG_64BIT
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index a79fe9a..4f9eb0b 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1235,6 +1235,9 @@ static void __cpuinit setup_scache(void)
 		loongson2_sc_init();
 		return;
 #endif
+	case CPU_XLP:
+		/* don't need to worry about L2, fully coherent */
+		return;
 
 	default:
 		if (c->isa_level == MIPS_CPU_ISA_M32R1 ||
-- 
1.7.5.4
