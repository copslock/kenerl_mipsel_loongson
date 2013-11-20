Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2013 11:48:33 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43123 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825129Ab3KTKsKu9GXx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Nov 2013 11:48:10 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/3] MIPS: Add support for interAptiv cores
Date:   Wed, 20 Nov 2013 10:46:01 +0000
Message-ID: <1384944362-7197-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1384944362-7197-1-git-send-email-markos.chandras@imgtec.com>
References: <1384944362-7197-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_20_10_48_05
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38562
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

The interAptiv is a power-efficient multi-core microprocessor
for use in system-on-chip (SoC) applications. The interAptiv combines
a multi-threading pipeline with a coherence manager to deliver improved
computational throughput and power efficiency. The interAptiv can
contain one to four MIPS32R3 interAptiv cores, system level
coherence manager with L2 cache, optional coherent I/O port,
and optional floating point unit.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-type.h     | 1 +
 arch/mips/include/asm/cpu.h          | 2 +-
 arch/mips/kernel/idle.c              | 1 +
 arch/mips/kernel/spram.c             | 1 +
 arch/mips/kernel/traps.c             | 1 +
 arch/mips/mm/c-r4k.c                 | 1 +
 arch/mips/oprofile/common.c          | 1 +
 arch/mips/oprofile/op_model_mipsxx.c | 4 ++++
 8 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 673f426..d879c91 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -47,6 +47,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_74K:
 	case CPU_M14KC:
 	case CPU_M14KEC:
+	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 #endif
 
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index aa63c4c..770685c 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -293,7 +293,7 @@ enum cpu_type_enum {
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
 	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_LOONGSON1, CPU_M14KC,
-	CPU_M14KEC, CPU_PROAPTIV,
+	CPU_M14KEC, CPU_INTERAPTIV, CPU_PROAPTIV,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index cb2c94f..3553243 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -184,6 +184,7 @@ void __init check_wait(void)
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
+	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 		cpu_wait = r4k_wait;
 		if (read_c0_config7() & MIPS_CONF7_WII)
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index fb72b80..dfed8a4 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -206,6 +206,7 @@ void spram_config(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7541855..e451f67 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1337,6 +1337,7 @@ static inline void parity_protection_init(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 		{
 #define ERRCTL_PE	0x80000000
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 24b3a63..2b28afa 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1098,6 +1098,7 @@ static void probe_pcache(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 		if (current_cpu_type() == CPU_74K)
 			alias_74k_erratum(c);
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index efd2eb3..2a86e38 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -86,6 +86,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_34K:
 	case CPU_1004K:
 	case CPU_74K:
+	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_LOONGSON1:
 	case CPU_SB1:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 3e28aaa..4d94d75 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -376,6 +376,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/74K";
 		break;
 
+	case CPU_INTERAPTIV:
+		op_model_mipsxx_ops.cpu_type = "mips/interAptiv";
+		break;
+
 	case CPU_PROAPTIV:
 		op_model_mipsxx_ops.cpu_type = "mips/proAptiv";
 		break;
-- 
1.8.4.3
