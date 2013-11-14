Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2013 17:15:11 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:1075 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865322Ab3KNQM6UNqFI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Nov 2013 17:12:58 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 07/12] MIPS: Add support for the proAptiv cores
Date:   Thu, 14 Nov 2013 16:12:27 +0000
Message-ID: <1384445552-30573-8-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
References: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_14_16_12_57
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38527
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

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-type.h     | 1 +
 arch/mips/include/asm/cpu.h          | 2 +-
 arch/mips/kernel/idle.c              | 1 +
 arch/mips/kernel/spram.c             | 1 +
 arch/mips/kernel/traps.c             | 1 +
 arch/mips/mm/c-r4k.c                 | 1 +
 arch/mips/mm/sc-mips.c               | 1 +
 arch/mips/mm/tlbex.c                 | 1 +
 arch/mips/oprofile/common.c          | 1 +
 arch/mips/oprofile/op_model_mipsxx.c | 4 ++++
 10 files changed, 13 insertions(+), 1 deletion(-)

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
index 6273f6a..9bb2abe 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -291,7 +291,7 @@ enum cpu_type_enum {
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
 	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_LOONGSON1, CPU_M14KC,
-	CPU_M14KEC,
+	CPU_M14KEC, CPU_PROAPTIV,
 
 	/*
 	 * MIPS64 class processors
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
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 4d1736f..efd2eb3 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -86,6 +86,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_34K:
 	case CPU_1004K:
 	case CPU_74K:
+	case CPU_PROAPTIV:
 	case CPU_LOONGSON1:
 	case CPU_SB1:
 	case CPU_SB1A:
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
1.8.4.3
