Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 06:43:57 +0200 (CEST)
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:51538 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006523AbbEYEnxwA1ZJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 06:43:53 +0200
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-03v.sys.comcast.net with comcast
        id Y4jp1q0022S2Q5R014jpR0; Mon, 25 May 2015 04:43:49 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-16v.sys.comcast.net with comcast
        id Y4jo1q00442s2jH014jolS; Mon, 25 May 2015 04:43:49 +0000
Message-ID: <5562A883.1010703@gentoo.org>
Date:   Mon, 25 May 2015 00:43:47 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: MIPS: R12000: Enable branch prediction global history
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432529029;
        bh=0vdrgoX34YCc7ayijRQKnzAgCVJPB1ef1JPW+V7PSg4=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=sRW9L9UaxGLuhj1SY8cRJ4aF/R2K0EfBknra451NpNgclJoUV7AiP8GDU9Dmyphq1
         97mMfQoLPajrkPOXqkaqy2+8OCrEuBHTI0GKglmQsFScicy1mY2J06/eB8zglCud7c
         Egssg4REA3Sz2bPUsZPZ6F9M4w0cC5udk0lu2rKtY4eRrWi9NXY2o5vX3/67ZQHox4
         vtKglraw8OThgqCXyEyONC4L9VutDdygtYP2kWNg7xwwC2/+wVHeE1g8fbSX2tY+gl
         SyEJSDH+IklVWaxHzjO+7gL3RKhzTYRxh5QVd+aeDMe6Ika09XTVo7E72/JsqkXdup
         UeUDinbzcZFTQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47643
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
index 764e275..c04271a 100644
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
+#define R10K_DIAG_D_BRC 	(_ULCAST_(1) << 22)
 
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
index e36515d..7c0fffd 100644
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
 
+	if (c->options & MIPS_CPU_BP_GHIST)
+		write_c0_r10k_diag(read_c0_r10k_diag() |
+				   R10K_DIAG_E_GHIST);
+
 	if (cpu_has_mips_r2_r6) {
 		c->srsets = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
 		/* R2 has Performance Counter Interrupt indicator */
