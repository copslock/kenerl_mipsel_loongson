Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 00:21:48 +0200 (CEST)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:43246 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026906AbbFBWVqkjl8k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2015 00:21:46 +0200
Received: from resomta-ch2-06v.sys.comcast.net ([69.252.207.102])
        by resqmta-ch2-10v.sys.comcast.net with comcast
        id baMg1q0012D5gil01aMgg3; Tue, 02 Jun 2015 22:21:40 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-06v.sys.comcast.net with comcast
        id baMf1q00642s2jH01aMffB; Tue, 02 Jun 2015 22:21:40 +0000
Message-ID: <556E2C6D.6070802@gentoo.org>
Date:   Tue, 02 Jun 2015 18:21:33 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH v3] MIPS: R12000: Enable branch prediction global history
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433283700;
        bh=f30MDA/eE7fZFoU+weOdB2VWcfkYa9dAmc09E814zko=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=hCdgKFWtWk5BDGSe25F9Nn6gjbDC61Gusrs5U9Y2dcA+9vGX+bF4hzyWJdo/cXFUr
         evBIA1QIfF5dD1t3gcsRr63AJ5GP9/xfg62943PjBbkz0L8hykRbUI7PrkbV+wG73A
         IWk3cN8XdDRObwMGRSVD1d4P6q2U7tYSedakLQ0rwvnhPXLgvexBk/3sfKBn21I2gx
         UyDyB573Qr92wZsN0giXowozzP4CEGIf3WncsaEtOtJxRDLt0NQCskS2KvoUnQk6TM
         r7AcVbX+U3KjJ/VXCpPBfFCHyDwAgLtixS/WK2selIIXqExqpXjW6Sqcp8YhV7H+Cn
         qWK+h2/wIWyEg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

The R12000 added a new feature to enhance branch prediction called
"global history".  Per the Vr10000 Series User Manual (U10278EJ4V0UM),
Coprocessor 0, Diagnostic Register (22):

"""
If bit 26 is set, branch prediction uses all eight bits of the global
history register.  If bit 26 is not set, then bits 25:23 specify a count
of the number of bits of global history to be used. Thus if bits 26:23
are all zero, global history is disabled.

The global history contains a record of the taken/not-taken status of
recently executed branches, and when used is XOR'ed with the PC of a
branch being predicted to produce a hashed value for indexing the BPT.
Some programs with small "working set of conditional branches" benefit
significantly from the use of such hashing, some see slight performance
degradation.
"""

This patch enables global history on R12000 CPUs and up by setting bit
26 in the branch prediction diagnostic register (CP0 $22) to '1'.  Bits
25:23 are left alone so that all eight bits of the global history
register are available for branch prediction.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/cpu-features.h |    3 +++
 arch/mips/include/asm/cpu.h          |    1 +
 arch/mips/include/asm/mipsregs.h     |   13 +++++++++++++
 arch/mips/kernel/cpu-probe.c         |    8 ++++++--
 4 files changed, 23 insertions(+), 2 deletions(-)

This version builds on v2 and actually uses the cpu_has_bp_ghist #define
instead of checking the cpu_data.options field directly.

linux-mips-r12k-branch-ghistory.patch
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 5aeaf19..f25de77 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -108,6 +108,9 @@
 #ifndef cpu_has_llsc
 #define cpu_has_llsc		(cpu_data[0].options & MIPS_CPU_LLSC)
 #endif
+#ifndef cpu_has_bp_ghist
+#define cpu_has_bp_ghist	(cpu_data[0].options & MIPS_CPU_BP_GHIST)
+#endif
 #ifndef kernel_uses_llsc
 #define kernel_uses_llsc	cpu_has_llsc
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index e3adca1..76154ba 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -379,6 +379,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_RW_LLB		0x1000000000ull /* LLADDR/LLB writes are allowed */
 #define MIPS_CPU_XPA		0x2000000000ull /* CPU supports Extended Physical Addressing */
 #define MIPS_CPU_CDMM		0x4000000000ull	/* CPU has Common Device Memory Map */
+#define MIPS_CPU_BP_GHIST	0x8000000000ull /* R12K+ Branch Prediction Global History */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 764e275..fc63ba7 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -685,6 +685,15 @@
 #define TX39_CONF_DRSIZE_SHIFT	0
 #define TX39_CONF_DRSIZE_MASK	0x00000003
 
+/*
+ * Interesting Bits in the R10K CP0 Branch Diagnostic Register
+ */
+/* Disable Branch Target Address Cache */
+#define R10K_DIAG_D_BTAC	(_ULCAST_(1) << 27)
+/* Enable Branch Prediction Global History */
+#define R10K_DIAG_E_GHIST	(_ULCAST_(1) << 26)
+/* Disable Branch Return Cache */
+#define R10K_DIAG_D_BRC		(_ULCAST_(1) << 22)
 
 /*
  * Coprocessor 1 (FPU) register names
@@ -1247,6 +1256,10 @@ do {									\
 #define read_c0_diag()		__read_32bit_c0_register($22, 0)
 #define write_c0_diag(val)	__write_32bit_c0_register($22, 0, val)
 
+/* R10K CP0 Branch Diagnostic register is 64bits wide */
+#define read_c0_r10k_diag()	__read_64bit_c0_register($22, 0)
+#define write_c0_r10k_diag(val)	__write_64bit_c0_register($22, 0, val)
+
 #define read_c0_diag1()		__read_32bit_c0_register($22, 1)
 #define write_c0_diag1(val)	__write_32bit_c0_register($22, 1, val)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index e36515d..c98b6c5 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -946,7 +946,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE | MIPS_CPU_4KEX |
 			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
-			     MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC | MIPS_CPU_BP_GHIST;
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_R14000:
@@ -961,7 +961,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE | MIPS_CPU_4KEX |
 			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
-			     MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC | MIPS_CPU_BP_GHIST;
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_LOONGSON_64:  /* Loongson-2/3 */
@@ -1479,6 +1479,10 @@ void cpu_probe(void)
 	else
 		cpu_set_nofpu_opts(c);
 
+	if (cpu_has_bp_ghist)
+		write_c0_r10k_diag(read_c0_r10k_diag() |
+				   R10K_DIAG_E_GHIST);
+
 	if (cpu_has_mips_r2_r6) {
 		c->srsets = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
 		/* R2 has Performance Counter Interrupt indicator */
