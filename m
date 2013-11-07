Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 18:11:38 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43745 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823050Ab3KGRJ6Wf2U0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 18:09:58 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 3/6] MIPS: Add support for the proAptiv cores
Date:   Thu, 7 Nov 2013 17:08:37 +0000
Message-ID: <1383844120-29601-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_07_17_09_52
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

The proAptiv Multiprocessing System is a power efficient multi-core
microprocessor for use in system-on-chip (SoC) applications.
The proAptiv Multiprocessing System combines a deep pipeline
with multi-issue out of order execution for improved computational
throughput. The proAptiv Multiprocessing System can contain one to
six MIPS32r3 proAptiv cores, system level coherence
manager with L2 cache, optional coherent I/O port, and optional
floating point unit.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h |  3 +++
 arch/mips/include/asm/cpu-type.h     |  1 +
 arch/mips/include/asm/cpu.h          |  5 ++++-
 arch/mips/include/asm/tlb.h          |  4 +++-
 arch/mips/kernel/cpu-probe.c         | 15 +++++++++++++++
 arch/mips/kernel/idle.c              |  1 +
 arch/mips/kernel/spram.c             |  1 +
 arch/mips/kernel/traps.c             |  1 +
 arch/mips/mm/c-r4k.c                 |  1 +
 arch/mips/mm/sc-mips.c               |  1 +
 arch/mips/mm/tlbex.c                 |  1 +
 arch/mips/oprofile/op_model_mipsxx.c |  4 ++++
 12 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index d445d06..296606b 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -20,6 +20,9 @@
 #ifndef cpu_has_tlb
 #define cpu_has_tlb		(cpu_data[0].options & MIPS_CPU_TLB)
 #endif
+#ifndef cpu_has_tlbinv
+#define cpu_has_tlbinv		(cpu_data[0].options & MIPS_CPU_TLBINV)
+#endif
 
 /*
  * For the moment we don't consider R6000 and R8000 so we can assume that
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 4a402cc..673f426 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -47,6 +47,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_74K:
 	case CPU_M14KC:
 	case CPU_M14KEC:
+	case CPU_PROAPTIV:
 #endif
 
 #ifdef CONFIG_SYS_HAS_CPU_MIPS64_R1
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index d2035e1..ca5827c 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -111,6 +111,8 @@
 #define PRID_IMP_1074K		0x9a00
 #define PRID_IMP_M14KC		0x9c00
 #define PRID_IMP_M14KEC		0x9e00
+#define PRID_IMP_PROAPTIV_UP	0xa200
+#define PRID_IMP_PROAPTIV_MP	0xa300
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
@@ -289,7 +291,7 @@ enum cpu_type_enum {
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
 	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_LOONGSON1, CPU_M14KC,
-	CPU_M14KEC,
+	CPU_M14KEC, CPU_PROAPTIV,
 
 	/*
 	 * MIPS64 class processors
@@ -348,6 +350,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_PCI		0x00400000 /* CPU has Perf Ctr Int indicator */
 #define MIPS_CPU_RIXI		0x00800000 /* CPU has TLB Read/eXec Inhibit */
 #define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
+#define MIPS_CPU_TLBINV		0x02000000 /* CPU supports TLBINV/F */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/tlb.h b/arch/mips/include/asm/tlb.h
index 235367ce..4a23493 100644
--- a/arch/mips/include/asm/tlb.h
+++ b/arch/mips/include/asm/tlb.h
@@ -18,7 +18,9 @@
  */
 #define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 
-#define UNIQUE_ENTRYHI(idx)	(CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
+#define UNIQUE_ENTRYHI(idx)						\
+		((CKSEG0 + ((idx) << (PAGE_SHIFT + 1))) |		\
+		 (cpu_has_tlbinv ? MIPS_ENTRYHI_EHINV : 0))
 
 #include <asm-generic/tlb.h>
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c814287..8168e29 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -286,6 +286,13 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 	    && cpu_has_tlb)
 		c->tlbsize += (config4 & MIPS_CONF4_MMUSIZEEXT) * 0x40;
 
+	if (cpu_has_tlb) {
+		if (((config4 & MIPS_CONF4_IE) >> 29) == 2) {
+			c->options |= MIPS_CPU_TLBINV;
+			pr_info("TLBINV/F supported, config4=0x%0x\n", config4);
+		}
+	}
+
 	c->kscratch_mask = (config4 >> 16) & 0xff;
 
 	return config4 & MIPS_CONF_M;
@@ -739,6 +746,14 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_74K;
 		__cpu_name[cpu] = "MIPS 1074Kc";
 		break;
+	case PRID_IMP_PROAPTIV_UP:
+		c->cputype = CPU_PROAPTIV;
+		__cpu_name[cpu] = "MIPS proAptiv";
+		break;
+	case PRID_IMP_PROAPTIV_MP:
+		c->cputype = CPU_PROAPTIV;
+		__cpu_name[cpu] = "MIPS proAptiv (multi)";
+		break;
 	}
 
 	spram_config();
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index f7991d9..cb2c94f 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -184,6 +184,7 @@ void __init check_wait(void)
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
+	case CPU_PROAPTIV:
 		cpu_wait = r4k_wait;
 		if (read_c0_config7() & MIPS_CONF7_WII)
 			cpu_wait = r4k_wait_irqoff;
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index 93f8681..fb72b80 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -206,6 +206,7 @@ void spram_config(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_PROAPTIV:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
 		if (config0 & (1<<24)) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index f9c8746..cc20415 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1336,6 +1336,7 @@ static inline void parity_protection_init(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_PROAPTIV:
 		{
 #define ERRCTL_PE	0x80000000
 #define ERRCTL_L2P	0x00800000
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 62ffd20..24b3a63 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1098,6 +1098,7 @@ static void probe_pcache(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_PROAPTIV:
 		if (current_cpu_type() == CPU_74K)
 			alias_74k_erratum(c);
 		if ((read_c0_config7() & (1 << 16))) {
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 08d05ae..317c249 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -76,6 +76,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_PROAPTIV:
 	case CPU_BMIPS5000:
 		if (config2 & (1 << 12))
 			return 0;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 183f2b5..6fdfe1f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -510,6 +510,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		switch (current_cpu_type()) {
 		case CPU_M14KC:
 		case CPU_74K:
+		case CPU_PROAPTIV:
 			break;
 
 		default:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 3a2b6e9..3e28aaa 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -376,6 +376,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/74K";
 		break;
 
+	case CPU_PROAPTIV:
+		op_model_mipsxx_ops.cpu_type = "mips/proAptiv";
+		break;
+
 	case CPU_5KC:
 		op_model_mipsxx_ops.cpu_type = "mips/5K";
 		break;
-- 
1.8.4
