Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:03:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41016 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009981AbbGJPC74VITp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:02:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E9B39CACC5DE;
        Fri, 10 Jul 2015 16:02:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:02:52 +0100
Received: from localhost (10.100.200.2) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:02:51 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 07/16] MIPS: use common FP sigcontext code for O32 compat
Date:   Fri, 10 Jul 2015 16:00:16 +0100
Message-ID: <1436540426-10021-8-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.2]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48183
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

Make use of the common FP sigcontext code for O32 binaries running on
MIPS64 kernels now that it is taking appropriate offsets into struct
sigcontext(32) from struct mips_abi.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/signal.h |   3 +
 arch/mips/kernel/asm-offsets.c |  11 ---
 arch/mips/kernel/r4k_fpu.S     | 114 -------------------------------
 arch/mips/kernel/signal.c      |   4 +-
 arch/mips/kernel/signal32.c    | 150 ++---------------------------------------
 5 files changed, 11 insertions(+), 271 deletions(-)

diff --git a/arch/mips/include/asm/signal.h b/arch/mips/include/asm/signal.h
index 8efe5a9..003e273 100644
--- a/arch/mips/include/asm/signal.h
+++ b/arch/mips/include/asm/signal.h
@@ -23,4 +23,7 @@
 
 #define __ARCH_HAS_IRIX_SIGACTION
 
+extern int protected_save_fp_context(void __user *sc);
+extern int protected_restore_fp_context(void __user *sc);
+
 #endif /* _ASM_SIGNAL_H */
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index beabe19..e5feff4 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -245,17 +245,6 @@ void output_sc_defines(void)
 }
 #endif
 
-#ifdef CONFIG_MIPS32_COMPAT
-void output_sc32_defines(void)
-{
-	COMMENT("Linux 32-bit sigcontext offsets.");
-	OFFSET(SC32_FPREGS, sigcontext32, sc_fpregs);
-	OFFSET(SC32_FPC_CSR, sigcontext32, sc_fpc_csr);
-	OFFSET(SC32_FPC_EIR, sigcontext32, sc_fpc_eir);
-	BLANK();
-}
-#endif
-
 void output_signal_defined(void)
 {
 	COMMENT("Linux signal numbers.");
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 9e2d18d..aa11f43 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -106,66 +106,6 @@ LEAF(_save_fp_context)
 	.set pop
 	END(_save_fp_context)
 
-#ifdef CONFIG_MIPS32_COMPAT
-	/* Save 32-bit process floating point context */
-LEAF(_save_fp_context32)
-	.set push
-	.set MIPS_ISA_ARCH_LEVEL_RAW
-	SET_HARDFLOAT
-	cfc1	t1, fcr31
-
-#ifndef CONFIG_CPU_MIPS64_R6
-	mfc0	t0, CP0_STATUS
-	sll	t0, t0, 5
-	bgez	t0, 1f			# skip storing odd if FR=0
-	 nop
-#endif
-
-	/* Store the 16 odd double precision registers */
-	EX      sdc1 $f1, SC32_FPREGS+8(a0)
-	EX      sdc1 $f3, SC32_FPREGS+24(a0)
-	EX      sdc1 $f5, SC32_FPREGS+40(a0)
-	EX      sdc1 $f7, SC32_FPREGS+56(a0)
-	EX      sdc1 $f9, SC32_FPREGS+72(a0)
-	EX      sdc1 $f11, SC32_FPREGS+88(a0)
-	EX      sdc1 $f13, SC32_FPREGS+104(a0)
-	EX      sdc1 $f15, SC32_FPREGS+120(a0)
-	EX      sdc1 $f17, SC32_FPREGS+136(a0)
-	EX      sdc1 $f19, SC32_FPREGS+152(a0)
-	EX      sdc1 $f21, SC32_FPREGS+168(a0)
-	EX      sdc1 $f23, SC32_FPREGS+184(a0)
-	EX      sdc1 $f25, SC32_FPREGS+200(a0)
-	EX      sdc1 $f27, SC32_FPREGS+216(a0)
-	EX      sdc1 $f29, SC32_FPREGS+232(a0)
-	EX      sdc1 $f31, SC32_FPREGS+248(a0)
-
-	/* Store the 16 even double precision registers */
-1:	EX	sdc1 $f0, SC32_FPREGS+0(a0)
-	EX	sdc1 $f2, SC32_FPREGS+16(a0)
-	EX	sdc1 $f4, SC32_FPREGS+32(a0)
-	EX	sdc1 $f6, SC32_FPREGS+48(a0)
-	EX	sdc1 $f8, SC32_FPREGS+64(a0)
-	EX	sdc1 $f10, SC32_FPREGS+80(a0)
-	EX	sdc1 $f12, SC32_FPREGS+96(a0)
-	EX	sdc1 $f14, SC32_FPREGS+112(a0)
-	EX	sdc1 $f16, SC32_FPREGS+128(a0)
-	EX	sdc1 $f18, SC32_FPREGS+144(a0)
-	EX	sdc1 $f20, SC32_FPREGS+160(a0)
-	EX	sdc1 $f22, SC32_FPREGS+176(a0)
-	EX	sdc1 $f24, SC32_FPREGS+192(a0)
-	EX	sdc1 $f26, SC32_FPREGS+208(a0)
-	EX	sdc1 $f28, SC32_FPREGS+224(a0)
-	EX	sdc1 $f30, SC32_FPREGS+240(a0)
-	EX	sw t1, SC32_FPC_CSR(a0)
-	cfc1	t0, $0				# implementation/version
-	EX	sw t0, SC32_FPC_EIR(a0)
-	.set pop
-
-	jr	ra
-	 li	v0, 0					# success
-	END(_save_fp_context32)
-#endif
-
 /**
  * _restore_fp_context() - restore FP context to the FPU
  * @a0 - pointer to fpregs field of sigcontext
@@ -231,60 +171,6 @@ LEAF(_restore_fp_context)
 	 li	v0, 0					# success
 	END(_restore_fp_context)
 
-#ifdef CONFIG_MIPS32_COMPAT
-LEAF(_restore_fp_context32)
-	/* Restore an o32 sigcontext.  */
-	.set push
-	SET_HARDFLOAT
-	EX	lw t1, SC32_FPC_CSR(a0)
-
-#ifndef CONFIG_CPU_MIPS64_R6
-	mfc0	t0, CP0_STATUS
-	sll	t0, t0, 5
-	bgez	t0, 1f			# skip loading odd if FR=0
-	 nop
-#endif
-
-	EX      ldc1 $f1, SC32_FPREGS+8(a0)
-	EX      ldc1 $f3, SC32_FPREGS+24(a0)
-	EX      ldc1 $f5, SC32_FPREGS+40(a0)
-	EX      ldc1 $f7, SC32_FPREGS+56(a0)
-	EX      ldc1 $f9, SC32_FPREGS+72(a0)
-	EX      ldc1 $f11, SC32_FPREGS+88(a0)
-	EX      ldc1 $f13, SC32_FPREGS+104(a0)
-	EX      ldc1 $f15, SC32_FPREGS+120(a0)
-	EX      ldc1 $f17, SC32_FPREGS+136(a0)
-	EX      ldc1 $f19, SC32_FPREGS+152(a0)
-	EX      ldc1 $f21, SC32_FPREGS+168(a0)
-	EX      ldc1 $f23, SC32_FPREGS+184(a0)
-	EX      ldc1 $f25, SC32_FPREGS+200(a0)
-	EX      ldc1 $f27, SC32_FPREGS+216(a0)
-	EX      ldc1 $f29, SC32_FPREGS+232(a0)
-	EX      ldc1 $f31, SC32_FPREGS+248(a0)
-
-1:	EX	ldc1 $f0, SC32_FPREGS+0(a0)
-	EX	ldc1 $f2, SC32_FPREGS+16(a0)
-	EX	ldc1 $f4, SC32_FPREGS+32(a0)
-	EX	ldc1 $f6, SC32_FPREGS+48(a0)
-	EX	ldc1 $f8, SC32_FPREGS+64(a0)
-	EX	ldc1 $f10, SC32_FPREGS+80(a0)
-	EX	ldc1 $f12, SC32_FPREGS+96(a0)
-	EX	ldc1 $f14, SC32_FPREGS+112(a0)
-	EX	ldc1 $f16, SC32_FPREGS+128(a0)
-	EX	ldc1 $f18, SC32_FPREGS+144(a0)
-	EX	ldc1 $f20, SC32_FPREGS+160(a0)
-	EX	ldc1 $f22, SC32_FPREGS+176(a0)
-	EX	ldc1 $f24, SC32_FPREGS+192(a0)
-	EX	ldc1 $f26, SC32_FPREGS+208(a0)
-	EX	ldc1 $f28, SC32_FPREGS+224(a0)
-	EX	ldc1 $f30, SC32_FPREGS+240(a0)
-	ctc1	t1, fcr31
-	jr	ra
-	 li	v0, 0					# success
-	.set pop
-	END(_restore_fp_context32)
-#endif
-
 	.set	reorder
 
 	.type	fault@function
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 23913ad..5b28f67 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -124,7 +124,7 @@ static int restore_hw_fp_context(void __user *sc)
 /*
  * Helper routines
  */
-static int protected_save_fp_context(void __user *sc)
+int protected_save_fp_context(void __user *sc)
 {
 	struct mips_abi *abi = current->thread.abi;
 	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
@@ -167,7 +167,7 @@ static int protected_save_fp_context(void __user *sc)
 	return err;
 }
 
-static int protected_restore_fp_context(void __user *sc)
+int protected_restore_fp_context(void __user *sc)
 {
 	struct mips_abi *abi = current->thread.abi;
 	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 6b65658..2a7c6dd 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -36,12 +36,6 @@
 
 #include "signal-common.h"
 
-static int (*save_fp_context32)(struct sigcontext32 __user *sc);
-static int (*restore_fp_context32)(struct sigcontext32 __user *sc);
-
-extern asmlinkage int _save_fp_context32(struct sigcontext32 __user *sc);
-extern asmlinkage int _restore_fp_context32(struct sigcontext32 __user *sc);
-
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
  */
@@ -74,99 +68,11 @@ struct rt_sigframe32 {
 	struct ucontext32 rs_uc;
 };
 
-/*
- * Thread saved context copy to/from a signal context presumed to be on the
- * user stack, and therefore accessed with appropriate macros from uaccess.h.
- */
-static int copy_fp_to_sigcontext32(struct sigcontext32 __user *sc)
-{
-	int i;
-	int err = 0;
-	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
-
-	for (i = 0; i < NUM_FPU_REGS; i += inc) {
-		err |=
-		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
-			       &sc->sc_fpregs[i]);
-	}
-	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-static int copy_fp_from_sigcontext32(struct sigcontext32 __user *sc)
-{
-	int i;
-	int err = 0;
-	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
-	u64 fpr_val;
-
-	for (i = 0; i < NUM_FPU_REGS; i += inc) {
-		err |= __get_user(fpr_val, &sc->sc_fpregs[i]);
-		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
-	}
-	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-/*
- * sigcontext handlers
- */
-static int protected_save_fp_context32(struct sigcontext32 __user *sc)
-{
-	int err;
-	while (1) {
-		lock_fpu_owner();
-		if (is_fpu_owner()) {
-			err = save_fp_context32(sc);
-			unlock_fpu_owner();
-		} else {
-			unlock_fpu_owner();
-			err = copy_fp_to_sigcontext32(sc);
-		}
-		if (likely(!err))
-			break;
-		/* touch the sigcontext and try again */
-		err = __put_user(0, &sc->sc_fpregs[0]) |
-			__put_user(0, &sc->sc_fpregs[31]) |
-			__put_user(0, &sc->sc_fpc_csr);
-		if (err)
-			break;	/* really bad sigcontext */
-	}
-	return err;
-}
-
-static int protected_restore_fp_context32(struct sigcontext32 __user *sc)
-{
-	int err, tmp __maybe_unused;
-	while (1) {
-		lock_fpu_owner();
-		if (is_fpu_owner()) {
-			err = restore_fp_context32(sc);
-			unlock_fpu_owner();
-		} else {
-			unlock_fpu_owner();
-			err = copy_fp_from_sigcontext32(sc);
-		}
-		if (likely(!err))
-			break;
-		/* touch the sigcontext and try again */
-		err = __get_user(tmp, &sc->sc_fpregs[0]) |
-			__get_user(tmp, &sc->sc_fpregs[31]) |
-			__get_user(tmp, &sc->sc_fpc_csr);
-		if (err)
-			break;	/* really bad sigcontext */
-	}
-	return err;
-}
-
 static int setup_sigcontext32(struct pt_regs *regs,
 			      struct sigcontext32 __user *sc)
 {
 	int err = 0;
 	int i;
-	u32 used_math;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 
@@ -186,35 +92,18 @@ static int setup_sigcontext32(struct pt_regs *regs,
 		err |= __put_user(mflo3(), &sc->sc_lo3);
 	}
 
-	used_math = !!used_math();
-	err |= __put_user(used_math, &sc->sc_used_math);
+	/*
+	 * Save FPU state to signal context.  Signal handler
+	 * will "inherit" current FPU state.
+	 */
+	err |= protected_save_fp_context(sc);
 
-	if (used_math) {
-		/*
-		 * Save FPU state to signal context.  Signal handler
-		 * will "inherit" current FPU state.
-		 */
-		err |= protected_save_fp_context32(sc);
-	}
 	return err;
 }
 
-static int
-check_and_restore_fp_context32(struct sigcontext32 __user *sc)
-{
-	int err, sig;
-
-	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
-	if (err > 0)
-		err = 0;
-	err |= protected_restore_fp_context32(sc);
-	return err ?: sig;
-}
-
 static int restore_sigcontext32(struct pt_regs *regs,
 				struct sigcontext32 __user *sc)
 {
-	u32 used_math;
 	int err = 0;
 	s32 treg;
 	int i;
@@ -238,19 +127,7 @@ static int restore_sigcontext32(struct pt_regs *regs,
 	for (i = 1; i < 32; i++)
 		err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
 
-	err |= __get_user(used_math, &sc->sc_used_math);
-	conditional_used_math(used_math);
-
-	if (used_math) {
-		/* restore fpu context if we have used it before */
-		if (!err)
-			err = check_and_restore_fp_context32(sc);
-	} else {
-		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu(0);
-	}
-
-	return err;
+	return err ?: protected_restore_fp_context(sc);
 }
 
 /*
@@ -593,18 +470,3 @@ struct mips_abi mips_abi_32 = {
 	.off_sc_fpc_csr = offsetof(struct sigcontext32, sc_fpc_csr),
 	.off_sc_used_math = offsetof(struct sigcontext32, sc_used_math),
 };
-
-static int signal32_init(void)
-{
-	if (cpu_has_fpu) {
-		save_fp_context32 = _save_fp_context32;
-		restore_fp_context32 = _restore_fp_context32;
-	} else {
-		save_fp_context32 = copy_fp_to_sigcontext32;
-		restore_fp_context32 = copy_fp_from_sigcontext32;
-	}
-
-	return 0;
-}
-
-arch_initcall(signal32_init);
-- 
2.4.4
