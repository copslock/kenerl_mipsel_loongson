Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2014 12:28:51 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10849 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817179AbaBML2stGeIJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Feb 2014 12:28:48 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: =?UTF-8?q?=5BPATCH=20v2=2015/15=5D=20mips=3A=20save/restore=20MSA=20context=20around=20signals?=
Date:   Thu, 13 Feb 2014 11:27:42 +0000
Message-ID: <1392290862-18017-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-16-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-16-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_02_13_11_28_43
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This patch extends sigcontext in order to hold the most significant 64
bits of each vector register in addition to the MSA control & status
register. The least significant 64 bits are already saved as the scalar
FP context. This makes things a little awkward since the least & most
significant 64 bits of each vector register are not contiguous in
memory. Thus the copy_u & insert instructions are used to transfer the
values of the most significant 64 bits via GP registers.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Changes in v2:
  - Conditionalise MSA sigcontext save/restore calls upon cpu_has_msa
    in addition to used_math in order to avoid them for kernels without
    MSA support. Fixes link errors such as:

        arch/mips/built-in.o: In function `restore_sigcontext':
        (.text+0x7500): undefined reference to `_restore_msa_context'
        make: *** [vmlinux] Error 1

  - Include asm/msa.h in signal32.c to avoid build errors such as:

          CC      arch/mips/kernel/signal32.o
        arch/mips/kernel/signal32.c: In function ‘protected_restore_fp_context32’:
arch/mips/kernel/signal32.c:191:5: error: implicit declaration of function ‘enable_msa’ [-Werror=implicit-function-declaration]
arch/mips/kernel/signal32.c:195:5: error: implicit declaration of function ‘disable_msa’ [-Werror=implicit-function-declaration]
arch/mips/kernel/signal32.c: In function ‘setup_sigcontext32’:
arch/mips/kernel/signal32.c:242:2: error: implicit declaration of function ‘thread_msa_context_live’ [-Werror=implicit-function-declaration]
---
 arch/mips/include/asm/sigcontext.h      |   2 +
 arch/mips/include/uapi/asm/sigcontext.h |   8 ++
 arch/mips/kernel/asm-offsets.c          |   3 +
 arch/mips/kernel/r4k_fpu.S              | 213 ++++++++++++++++++++++++++++++++
 arch/mips/kernel/signal.c               |  73 +++++++++--
 arch/mips/kernel/signal32.c             |  74 +++++++++--
 6 files changed, 357 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/sigcontext.h b/arch/mips/include/asm/sigcontext.h
index eeeb0f4..f54bdbe 100644
--- a/arch/mips/include/asm/sigcontext.h
+++ b/arch/mips/include/asm/sigcontext.h
@@ -32,6 +32,8 @@ struct sigcontext32 {
 	__u32		sc_lo2;
 	__u32		sc_hi3;
 	__u32		sc_lo3;
+	__u64		sc_msaregs[32];	/* Most significant 64 bits */
+	__u32		sc_msa_csr;
 };
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
 #endif /* _ASM_SIGCONTEXT_H */
diff --git a/arch/mips/include/uapi/asm/sigcontext.h b/arch/mips/include/uapi/asm/sigcontext.h
index 6c9906f..681c176 100644
--- a/arch/mips/include/uapi/asm/sigcontext.h
+++ b/arch/mips/include/uapi/asm/sigcontext.h
@@ -12,6 +12,10 @@
 #include <linux/types.h>
 #include <asm/sgidefs.h>
 
+/* Bits which may be set in sc_used_math */
+#define USEDMATH_FP	(1 << 0)
+#define USEDMATH_MSA	(1 << 1)
+
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
 /*
@@ -37,6 +41,8 @@ struct sigcontext {
 	unsigned long		sc_lo2;
 	unsigned long		sc_hi3;
 	unsigned long		sc_lo3;
+	unsigned long long	sc_msaregs[32];	/* Most significant 64 bits */
+	unsigned long		sc_msa_csr;
 };
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
@@ -70,6 +76,8 @@ struct sigcontext {
 	__u32	sc_used_math;
 	__u32	sc_dsp;
 	__u32	sc_reserved;
+	__u64	sc_msaregs[32];
+	__u32	sc_msa_csr;
 };
 
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index f454d7b..ace6814 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -294,6 +294,7 @@ void output_sc_defines(void)
 	OFFSET(SC_LO2, sigcontext, sc_lo2);
 	OFFSET(SC_HI3, sigcontext, sc_hi3);
 	OFFSET(SC_LO3, sigcontext, sc_lo3);
+	OFFSET(SC_MSAREGS, sigcontext, sc_msaregs);
 	BLANK();
 }
 #endif
@@ -308,6 +309,7 @@ void output_sc_defines(void)
 	OFFSET(SC_MDLO, sigcontext, sc_mdlo);
 	OFFSET(SC_PC, sigcontext, sc_pc);
 	OFFSET(SC_FPC_CSR, sigcontext, sc_fpc_csr);
+	OFFSET(SC_MSAREGS, sigcontext, sc_msaregs);
 	BLANK();
 }
 #endif
@@ -319,6 +321,7 @@ void output_sc32_defines(void)
 	OFFSET(SC32_FPREGS, sigcontext32, sc_fpregs);
 	OFFSET(SC32_FPC_CSR, sigcontext32, sc_fpc_csr);
 	OFFSET(SC32_FPC_EIR, sigcontext32, sc_fpc_eir);
+	OFFSET(SC32_MSAREGS, sigcontext32, sc_msaregs);
 	BLANK();
 }
 #endif
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 253b2fb..752b50a 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -13,6 +13,7 @@
  * Copyright (C) 1999, 2001 Silicon Graphics, Inc.
  */
 #include <asm/asm.h>
+#include <asm/asmmacro.h>
 #include <asm/errno.h>
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
@@ -245,6 +246,218 @@ LEAF(_restore_fp_context32)
 	END(_restore_fp_context32)
 #endif
 
+#ifdef CONFIG_CPU_HAS_MSA
+
+	.macro	save_sc_msareg	wr, off, sc, tmp
+#ifdef CONFIG_64BIT
+	copy_u_d \tmp, \wr, 1
+	EX sd	\tmp, (\off+(\wr*8))(\sc)
+#elif defined(CONFIG_CPU_LITTLE_ENDIAN)
+	copy_u_w \tmp, \wr, 2
+	EX sw	\tmp, (\off+(\wr*8)+0)(\sc)
+	copy_u_w \tmp, \wr, 3
+	EX sw	\tmp, (\off+(\wr*8)+4)(\sc)
+#else /* CONFIG_CPU_BIG_ENDIAN */
+	copy_u_w \tmp, \wr, 2
+	EX sw	\tmp, (\off+(\wr*8)+4)(\sc)
+	copy_u_w \tmp, \wr, 3
+	EX sw	\tmp, (\off+(\wr*8)+0)(\sc)
+#endif
+	.endm
+
+/*
+ * int _save_msa_context(struct sigcontext *sc)
+ *
+ * Save the upper 64 bits of each vector register along with the MSA_CSR
+ * register into sc. Returns zero on success, else non-zero.
+ */
+LEAF(_save_msa_context)
+	save_sc_msareg	0, SC_MSAREGS, a0, t0
+	save_sc_msareg	1, SC_MSAREGS, a0, t0
+	save_sc_msareg	2, SC_MSAREGS, a0, t0
+	save_sc_msareg	3, SC_MSAREGS, a0, t0
+	save_sc_msareg	4, SC_MSAREGS, a0, t0
+	save_sc_msareg	5, SC_MSAREGS, a0, t0
+	save_sc_msareg	6, SC_MSAREGS, a0, t0
+	save_sc_msareg	7, SC_MSAREGS, a0, t0
+	save_sc_msareg	8, SC_MSAREGS, a0, t0
+	save_sc_msareg	9, SC_MSAREGS, a0, t0
+	save_sc_msareg	10, SC_MSAREGS, a0, t0
+	save_sc_msareg	11, SC_MSAREGS, a0, t0
+	save_sc_msareg	12, SC_MSAREGS, a0, t0
+	save_sc_msareg	13, SC_MSAREGS, a0, t0
+	save_sc_msareg	14, SC_MSAREGS, a0, t0
+	save_sc_msareg	15, SC_MSAREGS, a0, t0
+	save_sc_msareg	16, SC_MSAREGS, a0, t0
+	save_sc_msareg	17, SC_MSAREGS, a0, t0
+	save_sc_msareg	18, SC_MSAREGS, a0, t0
+	save_sc_msareg	19, SC_MSAREGS, a0, t0
+	save_sc_msareg	20, SC_MSAREGS, a0, t0
+	save_sc_msareg	21, SC_MSAREGS, a0, t0
+	save_sc_msareg	22, SC_MSAREGS, a0, t0
+	save_sc_msareg	23, SC_MSAREGS, a0, t0
+	save_sc_msareg	24, SC_MSAREGS, a0, t0
+	save_sc_msareg	25, SC_MSAREGS, a0, t0
+	save_sc_msareg	26, SC_MSAREGS, a0, t0
+	save_sc_msareg	27, SC_MSAREGS, a0, t0
+	save_sc_msareg	28, SC_MSAREGS, a0, t0
+	save_sc_msareg	29, SC_MSAREGS, a0, t0
+	save_sc_msareg	30, SC_MSAREGS, a0, t0
+	save_sc_msareg	31, SC_MSAREGS, a0, t0
+	jr	ra
+	 li	v0, 0
+	END(_save_msa_context)
+
+#ifdef CONFIG_MIPS32_COMPAT
+
+/*
+ * int _save_msa_context32(struct sigcontext32 *sc)
+ *
+ * Save the upper 64 bits of each vector register along with the MSA_CSR
+ * register into sc. Returns zero on success, else non-zero.
+ */
+LEAF(_save_msa_context32)
+	save_sc_msareg	0, SC32_MSAREGS, a0, t0
+	save_sc_msareg	1, SC32_MSAREGS, a0, t0
+	save_sc_msareg	2, SC32_MSAREGS, a0, t0
+	save_sc_msareg	3, SC32_MSAREGS, a0, t0
+	save_sc_msareg	4, SC32_MSAREGS, a0, t0
+	save_sc_msareg	5, SC32_MSAREGS, a0, t0
+	save_sc_msareg	6, SC32_MSAREGS, a0, t0
+	save_sc_msareg	7, SC32_MSAREGS, a0, t0
+	save_sc_msareg	8, SC32_MSAREGS, a0, t0
+	save_sc_msareg	9, SC32_MSAREGS, a0, t0
+	save_sc_msareg	10, SC32_MSAREGS, a0, t0
+	save_sc_msareg	11, SC32_MSAREGS, a0, t0
+	save_sc_msareg	12, SC32_MSAREGS, a0, t0
+	save_sc_msareg	13, SC32_MSAREGS, a0, t0
+	save_sc_msareg	14, SC32_MSAREGS, a0, t0
+	save_sc_msareg	15, SC32_MSAREGS, a0, t0
+	save_sc_msareg	16, SC32_MSAREGS, a0, t0
+	save_sc_msareg	17, SC32_MSAREGS, a0, t0
+	save_sc_msareg	18, SC32_MSAREGS, a0, t0
+	save_sc_msareg	19, SC32_MSAREGS, a0, t0
+	save_sc_msareg	20, SC32_MSAREGS, a0, t0
+	save_sc_msareg	21, SC32_MSAREGS, a0, t0
+	save_sc_msareg	22, SC32_MSAREGS, a0, t0
+	save_sc_msareg	23, SC32_MSAREGS, a0, t0
+	save_sc_msareg	24, SC32_MSAREGS, a0, t0
+	save_sc_msareg	25, SC32_MSAREGS, a0, t0
+	save_sc_msareg	26, SC32_MSAREGS, a0, t0
+	save_sc_msareg	27, SC32_MSAREGS, a0, t0
+	save_sc_msareg	28, SC32_MSAREGS, a0, t0
+	save_sc_msareg	29, SC32_MSAREGS, a0, t0
+	save_sc_msareg	30, SC32_MSAREGS, a0, t0
+	save_sc_msareg	31, SC32_MSAREGS, a0, t0
+	jr	ra
+	 li	v0, 0
+	END(_save_msa_context32)
+
+#endif /* CONFIG_MIPS32_COMPAT */
+
+	.macro restore_sc_msareg	wr, off, sc, tmp
+#ifdef CONFIG_64BIT
+	EX ld	\tmp, (\off+(\wr*8))(\sc)
+	insert_d \wr, 1, \tmp
+#elif defined(CONFIG_CPU_LITTLE_ENDIAN)
+	EX lw	\tmp, (\off+(\wr*8)+0)(\sc)
+	insert_w \wr, 2, \tmp
+	EX lw	\tmp, (\off+(\wr*8)+4)(\sc)
+	insert_w \wr, 3, \tmp
+#else /* CONFIG_CPU_BIG_ENDIAN */
+	EX lw	\tmp, (\off+(\wr*8)+4)(\sc)
+	insert_w \wr, 2, \tmp
+	EX lw	\tmp, (\off+(\wr*8)+0)(\sc)
+	insert_w \wr, 3, \tmp
+#endif
+	.endm
+
+/*
+ * int _restore_msa_context(struct sigcontext *sc)
+ */
+LEAF(_restore_msa_context)
+	restore_sc_msareg	0, SC_MSAREGS, a0, t0
+	restore_sc_msareg	1, SC_MSAREGS, a0, t0
+	restore_sc_msareg	2, SC_MSAREGS, a0, t0
+	restore_sc_msareg	3, SC_MSAREGS, a0, t0
+	restore_sc_msareg	4, SC_MSAREGS, a0, t0
+	restore_sc_msareg	5, SC_MSAREGS, a0, t0
+	restore_sc_msareg	6, SC_MSAREGS, a0, t0
+	restore_sc_msareg	7, SC_MSAREGS, a0, t0
+	restore_sc_msareg	8, SC_MSAREGS, a0, t0
+	restore_sc_msareg	9, SC_MSAREGS, a0, t0
+	restore_sc_msareg	10, SC_MSAREGS, a0, t0
+	restore_sc_msareg	11, SC_MSAREGS, a0, t0
+	restore_sc_msareg	12, SC_MSAREGS, a0, t0
+	restore_sc_msareg	13, SC_MSAREGS, a0, t0
+	restore_sc_msareg	14, SC_MSAREGS, a0, t0
+	restore_sc_msareg	15, SC_MSAREGS, a0, t0
+	restore_sc_msareg	16, SC_MSAREGS, a0, t0
+	restore_sc_msareg	17, SC_MSAREGS, a0, t0
+	restore_sc_msareg	18, SC_MSAREGS, a0, t0
+	restore_sc_msareg	19, SC_MSAREGS, a0, t0
+	restore_sc_msareg	20, SC_MSAREGS, a0, t0
+	restore_sc_msareg	21, SC_MSAREGS, a0, t0
+	restore_sc_msareg	22, SC_MSAREGS, a0, t0
+	restore_sc_msareg	23, SC_MSAREGS, a0, t0
+	restore_sc_msareg	24, SC_MSAREGS, a0, t0
+	restore_sc_msareg	25, SC_MSAREGS, a0, t0
+	restore_sc_msareg	26, SC_MSAREGS, a0, t0
+	restore_sc_msareg	27, SC_MSAREGS, a0, t0
+	restore_sc_msareg	28, SC_MSAREGS, a0, t0
+	restore_sc_msareg	29, SC_MSAREGS, a0, t0
+	restore_sc_msareg	30, SC_MSAREGS, a0, t0
+	restore_sc_msareg	31, SC_MSAREGS, a0, t0
+	jr	ra
+	 li	v0, 0
+	END(_restore_msa_context)
+
+#ifdef CONFIG_MIPS32_COMPAT
+
+/*
+ * int _restore_msa_context32(struct sigcontext32 *sc)
+ */
+LEAF(_restore_msa_context32)
+	restore_sc_msareg	0, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	1, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	2, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	3, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	4, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	5, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	6, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	7, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	8, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	9, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	10, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	11, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	12, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	13, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	14, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	15, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	16, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	17, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	18, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	19, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	20, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	21, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	22, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	23, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	24, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	25, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	26, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	27, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	28, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	29, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	30, SC32_MSAREGS, a0, t0
+	restore_sc_msareg	31, SC32_MSAREGS, a0, t0
+	jr	ra
+	 li	v0, 0
+	END(_restore_msa_context32)
+
+#endif /* CONFIG_MIPS32_COMPAT */
+
+#endif /* CONFIG_CPU_HAS_MSA */
+
 	.set	reorder
 
 	.type	fault@function
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 0f97c7d..fd61700 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -30,6 +30,7 @@
 #include <linux/bitops.h>
 #include <asm/cacheflush.h>
 #include <asm/fpu.h>
+#include <asm/msa.h>
 #include <asm/sim.h>
 #include <asm/ucontext.h>
 #include <asm/cpu-features.h>
@@ -46,6 +47,9 @@ static int (*restore_fp_context)(struct sigcontext __user *sc);
 extern asmlinkage int _save_fp_context(struct sigcontext __user *sc);
 extern asmlinkage int _restore_fp_context(struct sigcontext __user *sc);
 
+extern asmlinkage int _save_msa_context(struct sigcontext __user *sc);
+extern asmlinkage int _restore_msa_context(struct sigcontext __user *sc);
+
 struct sigframe {
 	u32 sf_ass[4];		/* argument save space for o32 */
 	u32 sf_pad[2];		/* Was: signal trampoline */
@@ -95,19 +99,59 @@ static int copy_fp_from_sigcontext(struct sigcontext __user *sc)
 }
 
 /*
+ * These functions will save only the upper 64 bits of the vector registers,
+ * since the lower 64 bits have already been saved as the scalar FP context.
+ */
+static int copy_msa_to_sigcontext(struct sigcontext __user *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		err |=
+		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 1),
+			       &sc->sc_msaregs[i]);
+	}
+	err |= __put_user(current->thread.fpu.msacsr, &sc->sc_msa_csr);
+
+	return err;
+}
+
+static int copy_msa_from_sigcontext(struct sigcontext __user *sc)
+{
+	int i;
+	int err = 0;
+	u64 val;
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		err |= __get_user(val, &sc->sc_msaregs[i]);
+		set_fpr64(&current->thread.fpu.fpr[i], 1, val);
+	}
+	err |= __get_user(current->thread.fpu.msacsr, &sc->sc_msa_csr);
+
+	return err;
+}
+
+/*
  * Helper routines
  */
-static int protected_save_fp_context(struct sigcontext __user *sc)
+static int protected_save_fp_context(struct sigcontext __user *sc,
+				     unsigned used_math)
 {
 	int err;
+	bool save_msa = cpu_has_msa && (used_math & USEDMATH_MSA);
 	while (1) {
 		lock_fpu_owner();
 		if (is_fpu_owner()) {
 			err = save_fp_context(sc);
+			if (save_msa && !err)
+				err = _save_msa_context(sc);
 			unlock_fpu_owner();
 		} else {
 			unlock_fpu_owner();
 			err = copy_fp_to_sigcontext(sc);
+			if (save_msa && !err)
+				err = copy_msa_to_sigcontext(sc);
 		}
 		if (likely(!err))
 			break;
@@ -121,17 +165,28 @@ static int protected_save_fp_context(struct sigcontext __user *sc)
 	return err;
 }
 
-static int protected_restore_fp_context(struct sigcontext __user *sc)
+static int protected_restore_fp_context(struct sigcontext __user *sc,
+					unsigned used_math)
 {
 	int err, tmp __maybe_unused;
+	bool restore_msa = cpu_has_msa && (used_math & USEDMATH_MSA);
 	while (1) {
 		lock_fpu_owner();
 		if (is_fpu_owner()) {
 			err = restore_fp_context(sc);
+			if (restore_msa && !err) {
+				enable_msa();
+				err = _restore_msa_context(sc);
+			} else {
+				/* signal handler may have used MSA */
+				disable_msa();
+			}
 			unlock_fpu_owner();
 		} else {
 			unlock_fpu_owner();
 			err = copy_fp_from_sigcontext(sc);
+			if (!err && (used_math & USEDMATH_MSA))
+				err = copy_msa_from_sigcontext(sc);
 		}
 		if (likely(!err))
 			break;
@@ -172,7 +227,8 @@ int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
 	}
 
-	used_math = !!used_math();
+	used_math = used_math() ? USEDMATH_FP : 0;
+	used_math |= thread_msa_context_live() ? USEDMATH_MSA : 0;
 	err |= __put_user(used_math, &sc->sc_used_math);
 
 	if (used_math) {
@@ -180,7 +236,7 @@ int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 		 * Save FPU state to signal context. Signal handler
 		 * will "inherit" current FPU state.
 		 */
-		err |= protected_save_fp_context(sc);
+		err |= protected_save_fp_context(sc, used_math);
 	}
 	return err;
 }
@@ -205,14 +261,14 @@ int fpcsr_pending(unsigned int __user *fpcsr)
 }
 
 static int
-check_and_restore_fp_context(struct sigcontext __user *sc)
+check_and_restore_fp_context(struct sigcontext __user *sc, unsigned used_math)
 {
 	int err, sig;
 
 	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
 	if (err > 0)
 		err = 0;
-	err |= protected_restore_fp_context(sc);
+	err |= protected_restore_fp_context(sc, used_math);
 	return err ?: sig;
 }
 
@@ -252,9 +308,10 @@ int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	if (used_math) {
 		/* restore fpu context if we have used it before */
 		if (!err)
-			err = check_and_restore_fp_context(sc);
+			err = check_and_restore_fp_context(sc, used_math);
 	} else {
-		/* signal handler may have used FPU.  Give it up. */
+		/* signal handler may have used FPU or MSA. Disable them. */
+		disable_msa();
 		lose_fpu(0);
 	}
 
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index bae2e6e..299f956 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -30,6 +30,7 @@
 #include <asm/sim.h>
 #include <asm/ucontext.h>
 #include <asm/fpu.h>
+#include <asm/msa.h>
 #include <asm/war.h>
 #include <asm/vdso.h>
 #include <asm/dsp.h>
@@ -42,6 +43,9 @@ static int (*restore_fp_context32)(struct sigcontext32 __user *sc);
 extern asmlinkage int _save_fp_context32(struct sigcontext32 __user *sc);
 extern asmlinkage int _restore_fp_context32(struct sigcontext32 __user *sc);
 
+extern asmlinkage int _save_msa_context32(struct sigcontext32 __user *sc);
+extern asmlinkage int _restore_msa_context32(struct sigcontext32 __user *sc);
+
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
  */
@@ -111,19 +115,59 @@ static int copy_fp_from_sigcontext32(struct sigcontext32 __user *sc)
 }
 
 /*
+ * These functions will save only the upper 64 bits of the vector registers,
+ * since the lower 64 bits have already been saved as the scalar FP context.
+ */
+static int copy_msa_to_sigcontext32(struct sigcontext32 __user *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		err |=
+		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 1),
+			       &sc->sc_msaregs[i]);
+	}
+	err |= __put_user(current->thread.fpu.msacsr, &sc->sc_msa_csr);
+
+	return err;
+}
+
+static int copy_msa_from_sigcontext32(struct sigcontext32 __user *sc)
+{
+	int i;
+	int err = 0;
+	u64 val;
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		err |= __get_user(val, &sc->sc_msaregs[i]);
+		set_fpr64(&current->thread.fpu.fpr[i], 1, val);
+	}
+	err |= __get_user(current->thread.fpu.msacsr, &sc->sc_msa_csr);
+
+	return err;
+}
+
+/*
  * sigcontext handlers
  */
-static int protected_save_fp_context32(struct sigcontext32 __user *sc)
+static int protected_save_fp_context32(struct sigcontext32 __user *sc,
+				       unsigned used_math)
 {
 	int err;
+	bool save_msa = cpu_has_msa && (used_math & USEDMATH_MSA);
 	while (1) {
 		lock_fpu_owner();
 		if (is_fpu_owner()) {
 			err = save_fp_context32(sc);
+			if (save_msa && !err)
+				err = _save_msa_context32(sc);
 			unlock_fpu_owner();
 		} else {
 			unlock_fpu_owner();
 			err = copy_fp_to_sigcontext32(sc);
+			if (save_msa && !err)
+				err = copy_msa_to_sigcontext32(sc);
 		}
 		if (likely(!err))
 			break;
@@ -137,17 +181,28 @@ static int protected_save_fp_context32(struct sigcontext32 __user *sc)
 	return err;
 }
 
-static int protected_restore_fp_context32(struct sigcontext32 __user *sc)
+static int protected_restore_fp_context32(struct sigcontext32 __user *sc,
+					  unsigned used_math)
 {
 	int err, tmp __maybe_unused;
+	bool restore_msa = cpu_has_msa && (used_math & USEDMATH_MSA);
 	while (1) {
 		lock_fpu_owner();
 		if (is_fpu_owner()) {
 			err = restore_fp_context32(sc);
+			if (restore_msa && !err) {
+				enable_msa();
+				err = _restore_msa_context32(sc);
+			} else {
+				/* signal handler may have used MSA */
+				disable_msa();
+			}
 			unlock_fpu_owner();
 		} else {
 			unlock_fpu_owner();
 			err = copy_fp_from_sigcontext32(sc);
+			if (restore_msa && !err)
+				err = copy_msa_from_sigcontext32(sc);
 		}
 		if (likely(!err))
 			break;
@@ -186,7 +241,8 @@ static int setup_sigcontext32(struct pt_regs *regs,
 		err |= __put_user(mflo3(), &sc->sc_lo3);
 	}
 
-	used_math = !!used_math();
+	used_math = used_math() ? USEDMATH_FP : 0;
+	used_math |= thread_msa_context_live() ? USEDMATH_MSA : 0;
 	err |= __put_user(used_math, &sc->sc_used_math);
 
 	if (used_math) {
@@ -194,20 +250,21 @@ static int setup_sigcontext32(struct pt_regs *regs,
 		 * Save FPU state to signal context.  Signal handler
 		 * will "inherit" current FPU state.
 		 */
-		err |= protected_save_fp_context32(sc);
+		err |= protected_save_fp_context32(sc, used_math);
 	}
 	return err;
 }
 
 static int
-check_and_restore_fp_context32(struct sigcontext32 __user *sc)
+check_and_restore_fp_context32(struct sigcontext32 __user *sc,
+			       unsigned used_math)
 {
 	int err, sig;
 
 	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
 	if (err > 0)
 		err = 0;
-	err |= protected_restore_fp_context32(sc);
+	err |= protected_restore_fp_context32(sc, used_math);
 	return err ?: sig;
 }
 
@@ -244,9 +301,10 @@ static int restore_sigcontext32(struct pt_regs *regs,
 	if (used_math) {
 		/* restore fpu context if we have used it before */
 		if (!err)
-			err = check_and_restore_fp_context32(sc);
+			err = check_and_restore_fp_context32(sc, used_math);
 	} else {
-		/* signal handler may have used FPU.  Give it up. */
+		/* signal handler may have used FPU or MSA. Disable them. */
+		disable_msa();
 		lose_fpu(0);
 	}
 
-- 
1.8.5.3
