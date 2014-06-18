Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 16:02:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20141 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821654AbaFROBrCW0RV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 16:01:47 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7B294253F638B;
        Wed, 18 Jun 2014 15:01:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 18 Jun 2014 15:01:38 +0100
Received: from pburton-laptop.home (192.168.159.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 18 Jun
 2014 15:01:36 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     "Joseph S. Myers" <joseph@codesourcery.com>,
        Paul Burton <paul.burton@imgtec.com>, <stable@vger.kernel.org>
Subject: [PATCH] Revert "MIPS: Save/restore MSA context around signals"
Date:   Wed, 18 Jun 2014 15:00:46 +0100
Message-ID: <1403100046-5693-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.89]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40633
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

This reverts commit eec43a224cf1 "MIPS: Save/restore MSA context around
signals" and the MSA parts of ca750649e08c "MIPS: kernel: signal:
Prevent save/restore FPU context in user memory" (the restore path of
which appears incorrect anyway...).

The reverted patch took care not to break compatibility with userland
users of struct sigcontext, but inadvertantly changed the offset of the
uc_sigmask field of struct ucontext. Thus Linux v3.15 breaks the
userland ABI. The MSA context will need to be saved via some other
opt-in mechanism, but for now revert the change to reduce the fallout.

This will have minimal impact upon use of MSA since the only supported
CPU which includes it (the P5600) is 32-bit and therefore requires that
the experimental CONFIG_MIPS_O32_FP64_SUPPORT Kconfig option be selected
before the kernel will set FR=1 for a task, a requirement for MSA use.
Thus the users of MSA are limited to known small groups of people & this
patch won't be breaking any previously working MSA-using userland
outside of experimental settings.

Cc: stable@vger.kernel.org
Reported-by: Joseph S. Myers <joseph@codesourcery.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Ralf: if this can get into mainline ASAP so it can hit the 3.15 stable
branch too that would be great. Sorry for this!
---
 arch/mips/include/asm/sigcontext.h      |   2 -
 arch/mips/include/uapi/asm/sigcontext.h |   8 --
 arch/mips/kernel/asm-offsets.c          |   6 -
 arch/mips/kernel/r4k_fpu.S              | 221 --------------------------------
 arch/mips/kernel/signal.c               |  79 ++----------
 arch/mips/kernel/signal32.c             |  74 ++---------
 6 files changed, 16 insertions(+), 374 deletions(-)

diff --git a/arch/mips/include/asm/sigcontext.h b/arch/mips/include/asm/sigcontext.h
index f54bdbe..eeeb0f4 100644
--- a/arch/mips/include/asm/sigcontext.h
+++ b/arch/mips/include/asm/sigcontext.h
@@ -32,8 +32,6 @@ struct sigcontext32 {
 	__u32		sc_lo2;
 	__u32		sc_hi3;
 	__u32		sc_lo3;
-	__u64		sc_msaregs[32];	/* Most significant 64 bits */
-	__u32		sc_msa_csr;
 };
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
 #endif /* _ASM_SIGCONTEXT_H */
diff --git a/arch/mips/include/uapi/asm/sigcontext.h b/arch/mips/include/uapi/asm/sigcontext.h
index 681c176..6c9906f 100644
--- a/arch/mips/include/uapi/asm/sigcontext.h
+++ b/arch/mips/include/uapi/asm/sigcontext.h
@@ -12,10 +12,6 @@
 #include <linux/types.h>
 #include <asm/sgidefs.h>
 
-/* Bits which may be set in sc_used_math */
-#define USEDMATH_FP	(1 << 0)
-#define USEDMATH_MSA	(1 << 1)
-
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
 /*
@@ -41,8 +37,6 @@ struct sigcontext {
 	unsigned long		sc_lo2;
 	unsigned long		sc_hi3;
 	unsigned long		sc_lo3;
-	unsigned long long	sc_msaregs[32];	/* Most significant 64 bits */
-	unsigned long		sc_msa_csr;
 };
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
@@ -76,8 +70,6 @@ struct sigcontext {
 	__u32	sc_used_math;
 	__u32	sc_dsp;
 	__u32	sc_reserved;
-	__u64	sc_msaregs[32];
-	__u32	sc_msa_csr;
 };
 
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index d278efa..5db1f01 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -296,8 +296,6 @@ void output_sc_defines(void)
 	OFFSET(SC_LO2, sigcontext, sc_lo2);
 	OFFSET(SC_HI3, sigcontext, sc_hi3);
 	OFFSET(SC_LO3, sigcontext, sc_lo3);
-	OFFSET(SC_MSAREGS, sigcontext, sc_msaregs);
-	OFFSET(SC_MSA_CSR, sigcontext, sc_msa_csr);
 	BLANK();
 }
 #endif
@@ -312,8 +310,6 @@ void output_sc_defines(void)
 	OFFSET(SC_MDLO, sigcontext, sc_mdlo);
 	OFFSET(SC_PC, sigcontext, sc_pc);
 	OFFSET(SC_FPC_CSR, sigcontext, sc_fpc_csr);
-	OFFSET(SC_MSAREGS, sigcontext, sc_msaregs);
-	OFFSET(SC_MSA_CSR, sigcontext, sc_msa_csr);
 	BLANK();
 }
 #endif
@@ -325,8 +321,6 @@ void output_sc32_defines(void)
 	OFFSET(SC32_FPREGS, sigcontext32, sc_fpregs);
 	OFFSET(SC32_FPC_CSR, sigcontext32, sc_fpc_csr);
 	OFFSET(SC32_FPC_EIR, sigcontext32, sc_fpc_eir);
-	OFFSET(SC32_MSAREGS, sigcontext32, sc_msaregs);
-	OFFSET(SC32_MSA_CSR, sigcontext32, sc_msa_csr);
 	BLANK();
 }
 #endif
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index ffb5fea..8c96ed9 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -13,7 +13,6 @@
  * Copyright (C) 1999, 2001 Silicon Graphics, Inc.
  */
 #include <asm/asm.h>
-#include <asm/asmmacro.h>
 #include <asm/errno.h>
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
@@ -247,226 +246,6 @@ LEAF(_restore_fp_context32)
 	END(_restore_fp_context32)
 #endif
 
-#ifdef CONFIG_CPU_HAS_MSA
-
-	.macro	save_sc_msareg	wr, off, sc, tmp
-#ifdef CONFIG_64BIT
-	copy_u_d \tmp, \wr, 1
-	EX sd	\tmp, (\off+(\wr*8))(\sc)
-#elif defined(CONFIG_CPU_LITTLE_ENDIAN)
-	copy_u_w \tmp, \wr, 2
-	EX sw	\tmp, (\off+(\wr*8)+0)(\sc)
-	copy_u_w \tmp, \wr, 3
-	EX sw	\tmp, (\off+(\wr*8)+4)(\sc)
-#else /* CONFIG_CPU_BIG_ENDIAN */
-	copy_u_w \tmp, \wr, 2
-	EX sw	\tmp, (\off+(\wr*8)+4)(\sc)
-	copy_u_w \tmp, \wr, 3
-	EX sw	\tmp, (\off+(\wr*8)+0)(\sc)
-#endif
-	.endm
-
-/*
- * int _save_msa_context(struct sigcontext *sc)
- *
- * Save the upper 64 bits of each vector register along with the MSA_CSR
- * register into sc. Returns zero on success, else non-zero.
- */
-LEAF(_save_msa_context)
-	save_sc_msareg	0, SC_MSAREGS, a0, t0
-	save_sc_msareg	1, SC_MSAREGS, a0, t0
-	save_sc_msareg	2, SC_MSAREGS, a0, t0
-	save_sc_msareg	3, SC_MSAREGS, a0, t0
-	save_sc_msareg	4, SC_MSAREGS, a0, t0
-	save_sc_msareg	5, SC_MSAREGS, a0, t0
-	save_sc_msareg	6, SC_MSAREGS, a0, t0
-	save_sc_msareg	7, SC_MSAREGS, a0, t0
-	save_sc_msareg	8, SC_MSAREGS, a0, t0
-	save_sc_msareg	9, SC_MSAREGS, a0, t0
-	save_sc_msareg	10, SC_MSAREGS, a0, t0
-	save_sc_msareg	11, SC_MSAREGS, a0, t0
-	save_sc_msareg	12, SC_MSAREGS, a0, t0
-	save_sc_msareg	13, SC_MSAREGS, a0, t0
-	save_sc_msareg	14, SC_MSAREGS, a0, t0
-	save_sc_msareg	15, SC_MSAREGS, a0, t0
-	save_sc_msareg	16, SC_MSAREGS, a0, t0
-	save_sc_msareg	17, SC_MSAREGS, a0, t0
-	save_sc_msareg	18, SC_MSAREGS, a0, t0
-	save_sc_msareg	19, SC_MSAREGS, a0, t0
-	save_sc_msareg	20, SC_MSAREGS, a0, t0
-	save_sc_msareg	21, SC_MSAREGS, a0, t0
-	save_sc_msareg	22, SC_MSAREGS, a0, t0
-	save_sc_msareg	23, SC_MSAREGS, a0, t0
-	save_sc_msareg	24, SC_MSAREGS, a0, t0
-	save_sc_msareg	25, SC_MSAREGS, a0, t0
-	save_sc_msareg	26, SC_MSAREGS, a0, t0
-	save_sc_msareg	27, SC_MSAREGS, a0, t0
-	save_sc_msareg	28, SC_MSAREGS, a0, t0
-	save_sc_msareg	29, SC_MSAREGS, a0, t0
-	save_sc_msareg	30, SC_MSAREGS, a0, t0
-	save_sc_msareg	31, SC_MSAREGS, a0, t0
-	cfcmsa	t0, MSA_CSR
-	sw	t0, SC_MSA_CSR(a0)
-	jr	ra
-	 li	v0, 0
-	END(_save_msa_context)
-
-#ifdef CONFIG_MIPS32_COMPAT
-
-/*
- * int _save_msa_context32(struct sigcontext32 *sc)
- *
- * Save the upper 64 bits of each vector register along with the MSA_CSR
- * register into sc. Returns zero on success, else non-zero.
- */
-LEAF(_save_msa_context32)
-	save_sc_msareg	0, SC32_MSAREGS, a0, t0
-	save_sc_msareg	1, SC32_MSAREGS, a0, t0
-	save_sc_msareg	2, SC32_MSAREGS, a0, t0
-	save_sc_msareg	3, SC32_MSAREGS, a0, t0
-	save_sc_msareg	4, SC32_MSAREGS, a0, t0
-	save_sc_msareg	5, SC32_MSAREGS, a0, t0
-	save_sc_msareg	6, SC32_MSAREGS, a0, t0
-	save_sc_msareg	7, SC32_MSAREGS, a0, t0
-	save_sc_msareg	8, SC32_MSAREGS, a0, t0
-	save_sc_msareg	9, SC32_MSAREGS, a0, t0
-	save_sc_msareg	10, SC32_MSAREGS, a0, t0
-	save_sc_msareg	11, SC32_MSAREGS, a0, t0
-	save_sc_msareg	12, SC32_MSAREGS, a0, t0
-	save_sc_msareg	13, SC32_MSAREGS, a0, t0
-	save_sc_msareg	14, SC32_MSAREGS, a0, t0
-	save_sc_msareg	15, SC32_MSAREGS, a0, t0
-	save_sc_msareg	16, SC32_MSAREGS, a0, t0
-	save_sc_msareg	17, SC32_MSAREGS, a0, t0
-	save_sc_msareg	18, SC32_MSAREGS, a0, t0
-	save_sc_msareg	19, SC32_MSAREGS, a0, t0
-	save_sc_msareg	20, SC32_MSAREGS, a0, t0
-	save_sc_msareg	21, SC32_MSAREGS, a0, t0
-	save_sc_msareg	22, SC32_MSAREGS, a0, t0
-	save_sc_msareg	23, SC32_MSAREGS, a0, t0
-	save_sc_msareg	24, SC32_MSAREGS, a0, t0
-	save_sc_msareg	25, SC32_MSAREGS, a0, t0
-	save_sc_msareg	26, SC32_MSAREGS, a0, t0
-	save_sc_msareg	27, SC32_MSAREGS, a0, t0
-	save_sc_msareg	28, SC32_MSAREGS, a0, t0
-	save_sc_msareg	29, SC32_MSAREGS, a0, t0
-	save_sc_msareg	30, SC32_MSAREGS, a0, t0
-	save_sc_msareg	31, SC32_MSAREGS, a0, t0
-	cfcmsa	t0, MSA_CSR
-	sw	t0, SC32_MSA_CSR(a0)
-	jr	ra
-	 li	v0, 0
-	END(_save_msa_context32)
-
-#endif /* CONFIG_MIPS32_COMPAT */
-
-	.macro restore_sc_msareg	wr, off, sc, tmp
-#ifdef CONFIG_64BIT
-	EX ld	\tmp, (\off+(\wr*8))(\sc)
-	insert_d \wr, 1, \tmp
-#elif defined(CONFIG_CPU_LITTLE_ENDIAN)
-	EX lw	\tmp, (\off+(\wr*8)+0)(\sc)
-	insert_w \wr, 2, \tmp
-	EX lw	\tmp, (\off+(\wr*8)+4)(\sc)
-	insert_w \wr, 3, \tmp
-#else /* CONFIG_CPU_BIG_ENDIAN */
-	EX lw	\tmp, (\off+(\wr*8)+4)(\sc)
-	insert_w \wr, 2, \tmp
-	EX lw	\tmp, (\off+(\wr*8)+0)(\sc)
-	insert_w \wr, 3, \tmp
-#endif
-	.endm
-
-/*
- * int _restore_msa_context(struct sigcontext *sc)
- */
-LEAF(_restore_msa_context)
-	lw	t0, SC_MSA_CSR(a0)
-	ctcmsa	MSA_CSR, t0
-	restore_sc_msareg	0, SC_MSAREGS, a0, t0
-	restore_sc_msareg	1, SC_MSAREGS, a0, t0
-	restore_sc_msareg	2, SC_MSAREGS, a0, t0
-	restore_sc_msareg	3, SC_MSAREGS, a0, t0
-	restore_sc_msareg	4, SC_MSAREGS, a0, t0
-	restore_sc_msareg	5, SC_MSAREGS, a0, t0
-	restore_sc_msareg	6, SC_MSAREGS, a0, t0
-	restore_sc_msareg	7, SC_MSAREGS, a0, t0
-	restore_sc_msareg	8, SC_MSAREGS, a0, t0
-	restore_sc_msareg	9, SC_MSAREGS, a0, t0
-	restore_sc_msareg	10, SC_MSAREGS, a0, t0
-	restore_sc_msareg	11, SC_MSAREGS, a0, t0
-	restore_sc_msareg	12, SC_MSAREGS, a0, t0
-	restore_sc_msareg	13, SC_MSAREGS, a0, t0
-	restore_sc_msareg	14, SC_MSAREGS, a0, t0
-	restore_sc_msareg	15, SC_MSAREGS, a0, t0
-	restore_sc_msareg	16, SC_MSAREGS, a0, t0
-	restore_sc_msareg	17, SC_MSAREGS, a0, t0
-	restore_sc_msareg	18, SC_MSAREGS, a0, t0
-	restore_sc_msareg	19, SC_MSAREGS, a0, t0
-	restore_sc_msareg	20, SC_MSAREGS, a0, t0
-	restore_sc_msareg	21, SC_MSAREGS, a0, t0
-	restore_sc_msareg	22, SC_MSAREGS, a0, t0
-	restore_sc_msareg	23, SC_MSAREGS, a0, t0
-	restore_sc_msareg	24, SC_MSAREGS, a0, t0
-	restore_sc_msareg	25, SC_MSAREGS, a0, t0
-	restore_sc_msareg	26, SC_MSAREGS, a0, t0
-	restore_sc_msareg	27, SC_MSAREGS, a0, t0
-	restore_sc_msareg	28, SC_MSAREGS, a0, t0
-	restore_sc_msareg	29, SC_MSAREGS, a0, t0
-	restore_sc_msareg	30, SC_MSAREGS, a0, t0
-	restore_sc_msareg	31, SC_MSAREGS, a0, t0
-	jr	ra
-	 li	v0, 0
-	END(_restore_msa_context)
-
-#ifdef CONFIG_MIPS32_COMPAT
-
-/*
- * int _restore_msa_context32(struct sigcontext32 *sc)
- */
-LEAF(_restore_msa_context32)
-	lw	t0, SC_MSA_CSR(a0)
-	ctcmsa	MSA_CSR, t0
-	restore_sc_msareg	0, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	1, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	2, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	3, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	4, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	5, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	6, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	7, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	8, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	9, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	10, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	11, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	12, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	13, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	14, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	15, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	16, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	17, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	18, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	19, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	20, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	21, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	22, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	23, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	24, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	25, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	26, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	27, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	28, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	29, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	30, SC32_MSAREGS, a0, t0
-	restore_sc_msareg	31, SC32_MSAREGS, a0, t0
-	jr	ra
-	 li	v0, 0
-	END(_restore_msa_context32)
-
-#endif /* CONFIG_MIPS32_COMPAT */
-
-#endif /* CONFIG_CPU_HAS_MSA */
-
 	.set	reorder
 
 	.type	fault@function
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 33133d3..9e60d11 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -31,7 +31,6 @@
 #include <linux/bitops.h>
 #include <asm/cacheflush.h>
 #include <asm/fpu.h>
-#include <asm/msa.h>
 #include <asm/sim.h>
 #include <asm/ucontext.h>
 #include <asm/cpu-features.h>
@@ -48,9 +47,6 @@ static int (*restore_fp_context)(struct sigcontext __user *sc);
 extern asmlinkage int _save_fp_context(struct sigcontext __user *sc);
 extern asmlinkage int _restore_fp_context(struct sigcontext __user *sc);
 
-extern asmlinkage int _save_msa_context(struct sigcontext __user *sc);
-extern asmlinkage int _restore_msa_context(struct sigcontext __user *sc);
-
 struct sigframe {
 	u32 sf_ass[4];		/* argument save space for o32 */
 	u32 sf_pad[2];		/* Was: signal trampoline */
@@ -100,60 +96,20 @@ static int copy_fp_from_sigcontext(struct sigcontext __user *sc)
 }
 
 /*
- * These functions will save only the upper 64 bits of the vector registers,
- * since the lower 64 bits have already been saved as the scalar FP context.
- */
-static int copy_msa_to_sigcontext(struct sigcontext __user *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < NUM_FPU_REGS; i++) {
-		err |=
-		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 1),
-			       &sc->sc_msaregs[i]);
-	}
-	err |= __put_user(current->thread.fpu.msacsr, &sc->sc_msa_csr);
-
-	return err;
-}
-
-static int copy_msa_from_sigcontext(struct sigcontext __user *sc)
-{
-	int i;
-	int err = 0;
-	u64 val;
-
-	for (i = 0; i < NUM_FPU_REGS; i++) {
-		err |= __get_user(val, &sc->sc_msaregs[i]);
-		set_fpr64(&current->thread.fpu.fpr[i], 1, val);
-	}
-	err |= __get_user(current->thread.fpu.msacsr, &sc->sc_msa_csr);
-
-	return err;
-}
-
-/*
  * Helper routines
  */
-static int protected_save_fp_context(struct sigcontext __user *sc,
-				     unsigned used_math)
+static int protected_save_fp_context(struct sigcontext __user *sc)
 {
 	int err;
-	bool save_msa = cpu_has_msa && (used_math & USEDMATH_MSA);
 #ifndef CONFIG_EVA
 	while (1) {
 		lock_fpu_owner();
 		if (is_fpu_owner()) {
 			err = save_fp_context(sc);
-			if (save_msa && !err)
-				err = _save_msa_context(sc);
 			unlock_fpu_owner();
 		} else {
 			unlock_fpu_owner();
 			err = copy_fp_to_sigcontext(sc);
-			if (save_msa && !err)
-				err = copy_msa_to_sigcontext(sc);
 		}
 		if (likely(!err))
 			break;
@@ -169,38 +125,24 @@ static int protected_save_fp_context(struct sigcontext __user *sc,
 	 * EVA does not have FPU EVA instructions so saving fpu context directly
 	 * does not work.
 	 */
-	disable_msa();
 	lose_fpu(1);
 	err = save_fp_context(sc); /* this might fail */
-	if (save_msa && !err)
-		err = copy_msa_to_sigcontext(sc);
 #endif
 	return err;
 }
 
-static int protected_restore_fp_context(struct sigcontext __user *sc,
-					unsigned used_math)
+static int protected_restore_fp_context(struct sigcontext __user *sc)
 {
 	int err, tmp __maybe_unused;
-	bool restore_msa = cpu_has_msa && (used_math & USEDMATH_MSA);
 #ifndef CONFIG_EVA
 	while (1) {
 		lock_fpu_owner();
 		if (is_fpu_owner()) {
 			err = restore_fp_context(sc);
-			if (restore_msa && !err) {
-				enable_msa();
-				err = _restore_msa_context(sc);
-			} else {
-				/* signal handler may have used MSA */
-				disable_msa();
-			}
 			unlock_fpu_owner();
 		} else {
 			unlock_fpu_owner();
 			err = copy_fp_from_sigcontext(sc);
-			if (!err && (used_math & USEDMATH_MSA))
-				err = copy_msa_from_sigcontext(sc);
 		}
 		if (likely(!err))
 			break;
@@ -216,11 +158,8 @@ static int protected_restore_fp_context(struct sigcontext __user *sc,
 	 * EVA does not have FPU EVA instructions so restoring fpu context
 	 * directly does not work.
 	 */
-	enable_msa();
 	lose_fpu(0);
 	err = restore_fp_context(sc); /* this might fail */
-	if (restore_msa && !err)
-		err = copy_msa_from_sigcontext(sc);
 #endif
 	return err;
 }
@@ -252,8 +191,7 @@ int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
 	}
 
-	used_math = used_math() ? USEDMATH_FP : 0;
-	used_math |= thread_msa_context_live() ? USEDMATH_MSA : 0;
+	used_math = !!used_math();
 	err |= __put_user(used_math, &sc->sc_used_math);
 
 	if (used_math) {
@@ -261,7 +199,7 @@ int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 		 * Save FPU state to signal context. Signal handler
 		 * will "inherit" current FPU state.
 		 */
-		err |= protected_save_fp_context(sc, used_math);
+		err |= protected_save_fp_context(sc);
 	}
 	return err;
 }
@@ -286,14 +224,14 @@ int fpcsr_pending(unsigned int __user *fpcsr)
 }
 
 static int
-check_and_restore_fp_context(struct sigcontext __user *sc, unsigned used_math)
+check_and_restore_fp_context(struct sigcontext __user *sc)
 {
 	int err, sig;
 
 	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
 	if (err > 0)
 		err = 0;
-	err |= protected_restore_fp_context(sc, used_math);
+	err |= protected_restore_fp_context(sc);
 	return err ?: sig;
 }
 
@@ -333,10 +271,9 @@ int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	if (used_math) {
 		/* restore fpu context if we have used it before */
 		if (!err)
-			err = check_and_restore_fp_context(sc, used_math);
+			err = check_and_restore_fp_context(sc);
 	} else {
-		/* signal handler may have used FPU or MSA. Disable them. */
-		disable_msa();
+		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu(0);
 	}
 
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 299f956..bae2e6e 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -30,7 +30,6 @@
 #include <asm/sim.h>
 #include <asm/ucontext.h>
 #include <asm/fpu.h>
-#include <asm/msa.h>
 #include <asm/war.h>
 #include <asm/vdso.h>
 #include <asm/dsp.h>
@@ -43,9 +42,6 @@ static int (*restore_fp_context32)(struct sigcontext32 __user *sc);
 extern asmlinkage int _save_fp_context32(struct sigcontext32 __user *sc);
 extern asmlinkage int _restore_fp_context32(struct sigcontext32 __user *sc);
 
-extern asmlinkage int _save_msa_context32(struct sigcontext32 __user *sc);
-extern asmlinkage int _restore_msa_context32(struct sigcontext32 __user *sc);
-
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
  */
@@ -115,59 +111,19 @@ static int copy_fp_from_sigcontext32(struct sigcontext32 __user *sc)
 }
 
 /*
- * These functions will save only the upper 64 bits of the vector registers,
- * since the lower 64 bits have already been saved as the scalar FP context.
- */
-static int copy_msa_to_sigcontext32(struct sigcontext32 __user *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < NUM_FPU_REGS; i++) {
-		err |=
-		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 1),
-			       &sc->sc_msaregs[i]);
-	}
-	err |= __put_user(current->thread.fpu.msacsr, &sc->sc_msa_csr);
-
-	return err;
-}
-
-static int copy_msa_from_sigcontext32(struct sigcontext32 __user *sc)
-{
-	int i;
-	int err = 0;
-	u64 val;
-
-	for (i = 0; i < NUM_FPU_REGS; i++) {
-		err |= __get_user(val, &sc->sc_msaregs[i]);
-		set_fpr64(&current->thread.fpu.fpr[i], 1, val);
-	}
-	err |= __get_user(current->thread.fpu.msacsr, &sc->sc_msa_csr);
-
-	return err;
-}
-
-/*
  * sigcontext handlers
  */
-static int protected_save_fp_context32(struct sigcontext32 __user *sc,
-				       unsigned used_math)
+static int protected_save_fp_context32(struct sigcontext32 __user *sc)
 {
 	int err;
-	bool save_msa = cpu_has_msa && (used_math & USEDMATH_MSA);
 	while (1) {
 		lock_fpu_owner();
 		if (is_fpu_owner()) {
 			err = save_fp_context32(sc);
-			if (save_msa && !err)
-				err = _save_msa_context32(sc);
 			unlock_fpu_owner();
 		} else {
 			unlock_fpu_owner();
 			err = copy_fp_to_sigcontext32(sc);
-			if (save_msa && !err)
-				err = copy_msa_to_sigcontext32(sc);
 		}
 		if (likely(!err))
 			break;
@@ -181,28 +137,17 @@ static int protected_save_fp_context32(struct sigcontext32 __user *sc,
 	return err;
 }
 
-static int protected_restore_fp_context32(struct sigcontext32 __user *sc,
-					  unsigned used_math)
+static int protected_restore_fp_context32(struct sigcontext32 __user *sc)
 {
 	int err, tmp __maybe_unused;
-	bool restore_msa = cpu_has_msa && (used_math & USEDMATH_MSA);
 	while (1) {
 		lock_fpu_owner();
 		if (is_fpu_owner()) {
 			err = restore_fp_context32(sc);
-			if (restore_msa && !err) {
-				enable_msa();
-				err = _restore_msa_context32(sc);
-			} else {
-				/* signal handler may have used MSA */
-				disable_msa();
-			}
 			unlock_fpu_owner();
 		} else {
 			unlock_fpu_owner();
 			err = copy_fp_from_sigcontext32(sc);
-			if (restore_msa && !err)
-				err = copy_msa_from_sigcontext32(sc);
 		}
 		if (likely(!err))
 			break;
@@ -241,8 +186,7 @@ static int setup_sigcontext32(struct pt_regs *regs,
 		err |= __put_user(mflo3(), &sc->sc_lo3);
 	}
 
-	used_math = used_math() ? USEDMATH_FP : 0;
-	used_math |= thread_msa_context_live() ? USEDMATH_MSA : 0;
+	used_math = !!used_math();
 	err |= __put_user(used_math, &sc->sc_used_math);
 
 	if (used_math) {
@@ -250,21 +194,20 @@ static int setup_sigcontext32(struct pt_regs *regs,
 		 * Save FPU state to signal context.  Signal handler
 		 * will "inherit" current FPU state.
 		 */
-		err |= protected_save_fp_context32(sc, used_math);
+		err |= protected_save_fp_context32(sc);
 	}
 	return err;
 }
 
 static int
-check_and_restore_fp_context32(struct sigcontext32 __user *sc,
-			       unsigned used_math)
+check_and_restore_fp_context32(struct sigcontext32 __user *sc)
 {
 	int err, sig;
 
 	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
 	if (err > 0)
 		err = 0;
-	err |= protected_restore_fp_context32(sc, used_math);
+	err |= protected_restore_fp_context32(sc);
 	return err ?: sig;
 }
 
@@ -301,10 +244,9 @@ static int restore_sigcontext32(struct pt_regs *regs,
 	if (used_math) {
 		/* restore fpu context if we have used it before */
 		if (!err)
-			err = check_and_restore_fp_context32(sc, used_math);
+			err = check_and_restore_fp_context32(sc);
 	} else {
-		/* signal handler may have used FPU or MSA. Disable them. */
-		disable_msa();
+		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu(0);
 	}
 
-- 
2.0.0
