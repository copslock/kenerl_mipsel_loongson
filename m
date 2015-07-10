Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:02:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28691 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010019AbbGJPCJeN4Ip (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:02:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0946F2CBF6CF6;
        Fri, 10 Jul 2015 16:02:00 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:02:02 +0100
Received: from localhost (10.100.200.2) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:02:01 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <james.hogan@imgtec.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Manuel Lauss" <manuel.lauss@gmail.com>,
        "Maciej W. Rozycki" <macro@codesourcery.com>
Subject: [PATCH 04/16] MIPS: use struct mips_abi offsets to save FP context
Date:   Fri, 10 Jul 2015 16:00:13 +0100
Message-ID: <1436540426-10021-5-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 48180
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

When saving FP state to struct sigcontext, make use of the offsets
provided by struct mips_abi to obtain appropriate addresses for the
sc_fpregs & sc_fpc_csr fields of the sigcontext. This is done only for
the native struct sigcontext in this patch (ie. for O32 in CONFIG_32BIT
kernels or for N64 in CONFIG_64BIT kernels) but is done in preparation
for sharing this code with compat ABIs in further patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/r4k_fpu.S       | 151 +++++++++++++++++++++------------------
 arch/mips/kernel/signal-common.h |   6 ++
 arch/mips/kernel/signal.c        |  85 +++++++++++++++-------
 3 files changed, 145 insertions(+), 97 deletions(-)

diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 1d88af2..9e2d18d 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -35,6 +35,14 @@
 
 	.set	noreorder
 
+/**
+ * _save_fp_context() - save FP context from the FPU
+ * @a0 - pointer to fpregs field of sigcontext
+ * @a1 - pointer to fpc_csr field of sigcontext
+ *
+ * Save FP context, including the 32 FP data registers and the FP
+ * control & status register, from the FPU to signal context.
+ */
 LEAF(_save_fp_context)
 	.set	push
 	SET_HARDFLOAT
@@ -54,45 +62,45 @@ LEAF(_save_fp_context)
 	 nop
 #endif
 	/* Store the 16 odd double precision registers */
-	EX	sdc1 $f1, SC_FPREGS+8(a0)
-	EX	sdc1 $f3, SC_FPREGS+24(a0)
-	EX	sdc1 $f5, SC_FPREGS+40(a0)
-	EX	sdc1 $f7, SC_FPREGS+56(a0)
-	EX	sdc1 $f9, SC_FPREGS+72(a0)
-	EX	sdc1 $f11, SC_FPREGS+88(a0)
-	EX	sdc1 $f13, SC_FPREGS+104(a0)
-	EX	sdc1 $f15, SC_FPREGS+120(a0)
-	EX	sdc1 $f17, SC_FPREGS+136(a0)
-	EX	sdc1 $f19, SC_FPREGS+152(a0)
-	EX	sdc1 $f21, SC_FPREGS+168(a0)
-	EX	sdc1 $f23, SC_FPREGS+184(a0)
-	EX	sdc1 $f25, SC_FPREGS+200(a0)
-	EX	sdc1 $f27, SC_FPREGS+216(a0)
-	EX	sdc1 $f29, SC_FPREGS+232(a0)
-	EX	sdc1 $f31, SC_FPREGS+248(a0)
+	EX	sdc1 $f1, 8(a0)
+	EX	sdc1 $f3, 24(a0)
+	EX	sdc1 $f5, 40(a0)
+	EX	sdc1 $f7, 56(a0)
+	EX	sdc1 $f9, 72(a0)
+	EX	sdc1 $f11, 88(a0)
+	EX	sdc1 $f13, 104(a0)
+	EX	sdc1 $f15, 120(a0)
+	EX	sdc1 $f17, 136(a0)
+	EX	sdc1 $f19, 152(a0)
+	EX	sdc1 $f21, 168(a0)
+	EX	sdc1 $f23, 184(a0)
+	EX	sdc1 $f25, 200(a0)
+	EX	sdc1 $f27, 216(a0)
+	EX	sdc1 $f29, 232(a0)
+	EX	sdc1 $f31, 248(a0)
 1:	.set	pop
 #endif
 
 	.set push
 	SET_HARDFLOAT
 	/* Store the 16 even double precision registers */
-	EX	sdc1 $f0, SC_FPREGS+0(a0)
-	EX	sdc1 $f2, SC_FPREGS+16(a0)
-	EX	sdc1 $f4, SC_FPREGS+32(a0)
-	EX	sdc1 $f6, SC_FPREGS+48(a0)
-	EX	sdc1 $f8, SC_FPREGS+64(a0)
-	EX	sdc1 $f10, SC_FPREGS+80(a0)
-	EX	sdc1 $f12, SC_FPREGS+96(a0)
-	EX	sdc1 $f14, SC_FPREGS+112(a0)
-	EX	sdc1 $f16, SC_FPREGS+128(a0)
-	EX	sdc1 $f18, SC_FPREGS+144(a0)
-	EX	sdc1 $f20, SC_FPREGS+160(a0)
-	EX	sdc1 $f22, SC_FPREGS+176(a0)
-	EX	sdc1 $f24, SC_FPREGS+192(a0)
-	EX	sdc1 $f26, SC_FPREGS+208(a0)
-	EX	sdc1 $f28, SC_FPREGS+224(a0)
-	EX	sdc1 $f30, SC_FPREGS+240(a0)
-	EX	sw t1, SC_FPC_CSR(a0)
+	EX	sdc1 $f0, 0(a0)
+	EX	sdc1 $f2, 16(a0)
+	EX	sdc1 $f4, 32(a0)
+	EX	sdc1 $f6, 48(a0)
+	EX	sdc1 $f8, 64(a0)
+	EX	sdc1 $f10, 80(a0)
+	EX	sdc1 $f12, 96(a0)
+	EX	sdc1 $f14, 112(a0)
+	EX	sdc1 $f16, 128(a0)
+	EX	sdc1 $f18, 144(a0)
+	EX	sdc1 $f20, 160(a0)
+	EX	sdc1 $f22, 176(a0)
+	EX	sdc1 $f24, 192(a0)
+	EX	sdc1 $f26, 208(a0)
+	EX	sdc1 $f28, 224(a0)
+	EX	sdc1 $f30, 240(a0)
+	EX	sw t1, 0(a1)
 	jr	ra
 	 li	v0, 0					# success
 	.set pop
@@ -158,13 +166,16 @@ LEAF(_save_fp_context32)
 	END(_save_fp_context32)
 #endif
 
-/*
- * Restore FPU state:
- *  - fp gp registers
- *  - cp1 status/control register
+/**
+ * _restore_fp_context() - restore FP context to the FPU
+ * @a0 - pointer to fpregs field of sigcontext
+ * @a1 - pointer to fpc_csr field of sigcontext
+ *
+ * Restore FP context, including the 32 FP data registers and the FP
+ * control & status register, from signal context to the FPU.
  */
 LEAF(_restore_fp_context)
-	EX	lw t1, SC_FPC_CSR(a0)
+	EX	lw t1, 0(a1)
 
 #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)  || \
 		defined(CONFIG_CPU_MIPS32_R6)
@@ -178,42 +189,42 @@ LEAF(_restore_fp_context)
 	bgez	t0, 1f			# skip loading odd if FR=0
 	 nop
 #endif
-	EX	ldc1 $f1, SC_FPREGS+8(a0)
-	EX	ldc1 $f3, SC_FPREGS+24(a0)
-	EX	ldc1 $f5, SC_FPREGS+40(a0)
-	EX	ldc1 $f7, SC_FPREGS+56(a0)
-	EX	ldc1 $f9, SC_FPREGS+72(a0)
-	EX	ldc1 $f11, SC_FPREGS+88(a0)
-	EX	ldc1 $f13, SC_FPREGS+104(a0)
-	EX	ldc1 $f15, SC_FPREGS+120(a0)
-	EX	ldc1 $f17, SC_FPREGS+136(a0)
-	EX	ldc1 $f19, SC_FPREGS+152(a0)
-	EX	ldc1 $f21, SC_FPREGS+168(a0)
-	EX	ldc1 $f23, SC_FPREGS+184(a0)
-	EX	ldc1 $f25, SC_FPREGS+200(a0)
-	EX	ldc1 $f27, SC_FPREGS+216(a0)
-	EX	ldc1 $f29, SC_FPREGS+232(a0)
-	EX	ldc1 $f31, SC_FPREGS+248(a0)
+	EX	ldc1 $f1, 8(a0)
+	EX	ldc1 $f3, 24(a0)
+	EX	ldc1 $f5, 40(a0)
+	EX	ldc1 $f7, 56(a0)
+	EX	ldc1 $f9, 72(a0)
+	EX	ldc1 $f11, 88(a0)
+	EX	ldc1 $f13, 104(a0)
+	EX	ldc1 $f15, 120(a0)
+	EX	ldc1 $f17, 136(a0)
+	EX	ldc1 $f19, 152(a0)
+	EX	ldc1 $f21, 168(a0)
+	EX	ldc1 $f23, 184(a0)
+	EX	ldc1 $f25, 200(a0)
+	EX	ldc1 $f27, 216(a0)
+	EX	ldc1 $f29, 232(a0)
+	EX	ldc1 $f31, 248(a0)
 1:	.set pop
 #endif
 	.set push
 	SET_HARDFLOAT
-	EX	ldc1 $f0, SC_FPREGS+0(a0)
-	EX	ldc1 $f2, SC_FPREGS+16(a0)
-	EX	ldc1 $f4, SC_FPREGS+32(a0)
-	EX	ldc1 $f6, SC_FPREGS+48(a0)
-	EX	ldc1 $f8, SC_FPREGS+64(a0)
-	EX	ldc1 $f10, SC_FPREGS+80(a0)
-	EX	ldc1 $f12, SC_FPREGS+96(a0)
-	EX	ldc1 $f14, SC_FPREGS+112(a0)
-	EX	ldc1 $f16, SC_FPREGS+128(a0)
-	EX	ldc1 $f18, SC_FPREGS+144(a0)
-	EX	ldc1 $f20, SC_FPREGS+160(a0)
-	EX	ldc1 $f22, SC_FPREGS+176(a0)
-	EX	ldc1 $f24, SC_FPREGS+192(a0)
-	EX	ldc1 $f26, SC_FPREGS+208(a0)
-	EX	ldc1 $f28, SC_FPREGS+224(a0)
-	EX	ldc1 $f30, SC_FPREGS+240(a0)
+	EX	ldc1 $f0, 0(a0)
+	EX	ldc1 $f2, 16(a0)
+	EX	ldc1 $f4, 32(a0)
+	EX	ldc1 $f6, 48(a0)
+	EX	ldc1 $f8, 64(a0)
+	EX	ldc1 $f10, 80(a0)
+	EX	ldc1 $f12, 96(a0)
+	EX	ldc1 $f14, 112(a0)
+	EX	ldc1 $f16, 128(a0)
+	EX	ldc1 $f18, 144(a0)
+	EX	ldc1 $f20, 160(a0)
+	EX	ldc1 $f22, 176(a0)
+	EX	ldc1 $f24, 192(a0)
+	EX	ldc1 $f26, 208(a0)
+	EX	ldc1 $f28, 224(a0)
+	EX	ldc1 $f30, 240(a0)
 	ctc1	t1, fcr31
 	.set pop
 	jr	ra
diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 06805e0..d594695 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -36,4 +36,10 @@ extern int fpcsr_pending(unsigned int __user *fpcsr);
 #define unlock_fpu_owner()	pagefault_enable()
 #endif
 
+/* Assembly functions to move context to/from the FPU */
+extern asmlinkage int
+_save_fp_context(void __user *fpregs, void __user *csr);
+extern asmlinkage int
+_restore_fp_context(void __user *fpregs, void __user *csr);
+
 #endif	/* __SIGNAL_COMMON_H */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index ddf8318..10f7dbc 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -41,11 +41,8 @@
 
 #include "signal-common.h"
 
-static int (*save_fp_context)(struct sigcontext __user *sc);
-static int (*restore_fp_context)(struct sigcontext __user *sc);
-
-extern asmlinkage int _save_fp_context(struct sigcontext __user *sc);
-extern asmlinkage int _restore_fp_context(struct sigcontext __user *sc);
+static int (*save_fp_context)(void __user *sc);
+static int (*restore_fp_context)(void __user *sc);
 
 struct sigframe {
 	u32 sf_ass[4];		/* argument save space for o32 */
@@ -65,41 +62,71 @@ struct rt_sigframe {
  * Thread saved context copy to/from a signal context presumed to be on the
  * user stack, and therefore accessed with appropriate macros from uaccess.h.
  */
-static int copy_fp_to_sigcontext(struct sigcontext __user *sc)
+static int copy_fp_to_sigcontext(void __user *sc)
 {
+	struct mips_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint32_t __user *csr = sc + abi->off_sc_fpc_csr;
 	int i;
 	int err = 0;
 
 	for (i = 0; i < NUM_FPU_REGS; i++) {
 		err |=
 		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
-			       &sc->sc_fpregs[i]);
+			       &fpregs[i]);
 	}
-	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
+	err |= __put_user(current->thread.fpu.fcr31, csr);
 
 	return err;
 }
 
-static int copy_fp_from_sigcontext(struct sigcontext __user *sc)
+static int copy_fp_from_sigcontext(void __user *sc)
 {
+	struct mips_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint32_t __user *csr = sc + abi->off_sc_fpc_csr;
 	int i;
 	int err = 0;
 	u64 fpr_val;
 
 	for (i = 0; i < NUM_FPU_REGS; i++) {
-		err |= __get_user(fpr_val, &sc->sc_fpregs[i]);
+		err |= __get_user(fpr_val, &fpregs[i]);
 		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
 	}
-	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
+	err |= __get_user(current->thread.fpu.fcr31, csr);
 
 	return err;
 }
 
 /*
+ * Wrappers for the assembly _{save,restore}_fp_context functions.
+ */
+static int save_hw_fp_context(void __user *sc)
+{
+	struct mips_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint32_t __user *csr = sc + abi->off_sc_fpc_csr;
+
+	return _save_fp_context(fpregs, csr);
+}
+
+static int restore_hw_fp_context(void __user *sc)
+{
+	struct mips_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint32_t __user *csr = sc + abi->off_sc_fpc_csr;
+
+	return _restore_fp_context(fpregs, csr);
+}
+
+/*
  * Helper routines
  */
-static int protected_save_fp_context(struct sigcontext __user *sc)
+static int protected_save_fp_context(void __user *sc)
 {
+	struct mips_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint32_t __user *csr = sc + abi->off_sc_fpc_csr;
 	int err;
 
 	/*
@@ -121,9 +148,9 @@ static int protected_save_fp_context(struct sigcontext __user *sc)
 		if (likely(!err))
 			break;
 		/* touch the sigcontext and try again */
-		err = __put_user(0, &sc->sc_fpregs[0]) |
-			__put_user(0, &sc->sc_fpregs[31]) |
-			__put_user(0, &sc->sc_fpc_csr);
+		err = __put_user(0, &fpregs[0]) |
+			__put_user(0, &fpregs[31]) |
+			__put_user(0, csr);
 		if (err)
 			break;	/* really bad sigcontext */
 	}
@@ -131,8 +158,11 @@ static int protected_save_fp_context(struct sigcontext __user *sc)
 	return err;
 }
 
-static int protected_restore_fp_context(struct sigcontext __user *sc)
+static int protected_restore_fp_context(void __user *sc)
 {
+	struct mips_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint32_t __user *csr = sc + abi->off_sc_fpc_csr;
 	int err, tmp __maybe_unused;
 
 	/*
@@ -155,9 +185,9 @@ static int protected_restore_fp_context(struct sigcontext __user *sc)
 		if (likely(!err))
 			break;
 		/* touch the sigcontext and try again */
-		err = __get_user(tmp, &sc->sc_fpregs[0]) |
-			__get_user(tmp, &sc->sc_fpregs[31]) |
-			__get_user(tmp, &sc->sc_fpc_csr);
+		err = __get_user(tmp, &fpregs[0]) |
+			__get_user(tmp, &fpregs[31]) |
+			__get_user(tmp, csr);
 		if (err)
 			break;	/* really bad sigcontext */
 	}
@@ -225,11 +255,12 @@ int fpcsr_pending(unsigned int __user *fpcsr)
 }
 
 static int
-check_and_restore_fp_context(struct sigcontext __user *sc)
+check_and_restore_fp_context(void __user *sc)
 {
+	struct mips_abi *abi = current->thread.abi;
 	int err, sig;
 
-	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
+	err = sig = fpcsr_pending(sc + abi->off_sc_fpc_csr);
 	if (err > 0)
 		err = 0;
 	err |= protected_restore_fp_context(sc);
@@ -634,17 +665,17 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 }
 
 #ifdef CONFIG_SMP
-static int smp_save_fp_context(struct sigcontext __user *sc)
+static int smp_save_fp_context(void __user *sc)
 {
 	return raw_cpu_has_fpu
-	       ? _save_fp_context(sc)
+	       ? save_hw_fp_context(sc)
 	       : copy_fp_to_sigcontext(sc);
 }
 
-static int smp_restore_fp_context(struct sigcontext __user *sc)
+static int smp_restore_fp_context(void __user *sc)
 {
 	return raw_cpu_has_fpu
-	       ? _restore_fp_context(sc)
+	       ? restore_hw_fp_context(sc)
 	       : copy_fp_from_sigcontext(sc);
 }
 #endif
@@ -657,8 +688,8 @@ static int signal_setup(void)
 	restore_fp_context = smp_restore_fp_context;
 #else
 	if (cpu_has_fpu) {
-		save_fp_context = _save_fp_context;
-		restore_fp_context = _restore_fp_context;
+		save_fp_context = save_hw_fp_context;
+		restore_fp_context = restore_hw_fp_context;
 	} else {
 		save_fp_context = copy_fp_to_sigcontext;
 		restore_fp_context = copy_fp_from_sigcontext;
-- 
2.4.4
