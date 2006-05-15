Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 18:25:37 +0200 (CEST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:59613 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133535AbWEOQZY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 18:25:24 +0200
Received: from localhost (p6076-ipad203funabasi.chiba.ocn.ne.jp [222.146.85.76])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2A1A1B69B; Tue, 16 May 2006 01:25:19 +0900 (JST)
Date:	Tue, 16 May 2006 01:26:03 +0900 (JST)
Message-Id: <20060516.012603.41010976.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] unify mips_fpu_soft_struct and mips_fpu_hard_struct
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The struct mips_fpu_soft_struct and mips_fpu_hard_struct are
completely same now and the kernel fpu emulator assumes that.  This
patch unifies them to mips_fpu_struct and get rid of mips_fpu_union.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/kernel/asm-offsets.c      |   66 ++++++++++++++++++------------------
 arch/mips/kernel/branch.c           |    2 -
 arch/mips/kernel/irixsig.c          |    2 -
 arch/mips/kernel/ptrace.c           |   26 ++++----------
 arch/mips/kernel/ptrace32.c         |   16 ++------
 arch/mips/kernel/traps.c            |    9 ++--
 arch/mips/math-emu/cp1emu.c         |   15 +++-----
 arch/mips/math-emu/ieee754.h        |    2 -
 arch/mips/math-emu/kernel_linkage.c |   24 +++++--------
 include/asm-mips/fpu.h              |    3 -
 include/asm-mips/fpu_emulator.h     |    4 +-
 include/asm-mips/processor.h        |   16 +-------
 12 files changed, 76 insertions(+), 109 deletions(-)

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 0facfaf..f1bb6a2 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -141,72 +141,72 @@ void output_thread_defines(void)
 void output_thread_fpu_defines(void)
 {
 	offset("#define THREAD_FPR0    ",
-	       struct task_struct, thread.fpu.hard.fpr[0]);
+	       struct task_struct, thread.fpu.fpr[0]);
 	offset("#define THREAD_FPR1    ",
-	       struct task_struct, thread.fpu.hard.fpr[1]);
+	       struct task_struct, thread.fpu.fpr[1]);
 	offset("#define THREAD_FPR2    ",
-	       struct task_struct, thread.fpu.hard.fpr[2]);
+	       struct task_struct, thread.fpu.fpr[2]);
 	offset("#define THREAD_FPR3    ",
-	       struct task_struct, thread.fpu.hard.fpr[3]);
+	       struct task_struct, thread.fpu.fpr[3]);
 	offset("#define THREAD_FPR4    ",
-	       struct task_struct, thread.fpu.hard.fpr[4]);
+	       struct task_struct, thread.fpu.fpr[4]);
 	offset("#define THREAD_FPR5    ",
-	       struct task_struct, thread.fpu.hard.fpr[5]);
+	       struct task_struct, thread.fpu.fpr[5]);
 	offset("#define THREAD_FPR6    ",
-	       struct task_struct, thread.fpu.hard.fpr[6]);
+	       struct task_struct, thread.fpu.fpr[6]);
 	offset("#define THREAD_FPR7    ",
-	       struct task_struct, thread.fpu.hard.fpr[7]);
+	       struct task_struct, thread.fpu.fpr[7]);
 	offset("#define THREAD_FPR8    ",
-	       struct task_struct, thread.fpu.hard.fpr[8]);
+	       struct task_struct, thread.fpu.fpr[8]);
 	offset("#define THREAD_FPR9    ",
-	       struct task_struct, thread.fpu.hard.fpr[9]);
+	       struct task_struct, thread.fpu.fpr[9]);
 	offset("#define THREAD_FPR10   ",
-	       struct task_struct, thread.fpu.hard.fpr[10]);
+	       struct task_struct, thread.fpu.fpr[10]);
 	offset("#define THREAD_FPR11   ",
-	       struct task_struct, thread.fpu.hard.fpr[11]);
+	       struct task_struct, thread.fpu.fpr[11]);
 	offset("#define THREAD_FPR12   ",
-	       struct task_struct, thread.fpu.hard.fpr[12]);
+	       struct task_struct, thread.fpu.fpr[12]);
 	offset("#define THREAD_FPR13   ",
-	       struct task_struct, thread.fpu.hard.fpr[13]);
+	       struct task_struct, thread.fpu.fpr[13]);
 	offset("#define THREAD_FPR14   ",
-	       struct task_struct, thread.fpu.hard.fpr[14]);
+	       struct task_struct, thread.fpu.fpr[14]);
 	offset("#define THREAD_FPR15   ",
-	       struct task_struct, thread.fpu.hard.fpr[15]);
+	       struct task_struct, thread.fpu.fpr[15]);
 	offset("#define THREAD_FPR16   ",
-	       struct task_struct, thread.fpu.hard.fpr[16]);
+	       struct task_struct, thread.fpu.fpr[16]);
 	offset("#define THREAD_FPR17   ",
-	       struct task_struct, thread.fpu.hard.fpr[17]);
+	       struct task_struct, thread.fpu.fpr[17]);
 	offset("#define THREAD_FPR18   ",
-	       struct task_struct, thread.fpu.hard.fpr[18]);
+	       struct task_struct, thread.fpu.fpr[18]);
 	offset("#define THREAD_FPR19   ",
-	       struct task_struct, thread.fpu.hard.fpr[19]);
+	       struct task_struct, thread.fpu.fpr[19]);
 	offset("#define THREAD_FPR20   ",
-	       struct task_struct, thread.fpu.hard.fpr[20]);
+	       struct task_struct, thread.fpu.fpr[20]);
 	offset("#define THREAD_FPR21   ",
-	       struct task_struct, thread.fpu.hard.fpr[21]);
+	       struct task_struct, thread.fpu.fpr[21]);
 	offset("#define THREAD_FPR22   ",
-	       struct task_struct, thread.fpu.hard.fpr[22]);
+	       struct task_struct, thread.fpu.fpr[22]);
 	offset("#define THREAD_FPR23   ",
-	       struct task_struct, thread.fpu.hard.fpr[23]);
+	       struct task_struct, thread.fpu.fpr[23]);
 	offset("#define THREAD_FPR24   ",
-	       struct task_struct, thread.fpu.hard.fpr[24]);
+	       struct task_struct, thread.fpu.fpr[24]);
 	offset("#define THREAD_FPR25   ",
-	       struct task_struct, thread.fpu.hard.fpr[25]);
+	       struct task_struct, thread.fpu.fpr[25]);
 	offset("#define THREAD_FPR26   ",
-	       struct task_struct, thread.fpu.hard.fpr[26]);
+	       struct task_struct, thread.fpu.fpr[26]);
 	offset("#define THREAD_FPR27   ",
-	       struct task_struct, thread.fpu.hard.fpr[27]);
+	       struct task_struct, thread.fpu.fpr[27]);
 	offset("#define THREAD_FPR28   ",
-	       struct task_struct, thread.fpu.hard.fpr[28]);
+	       struct task_struct, thread.fpu.fpr[28]);
 	offset("#define THREAD_FPR29   ",
-	       struct task_struct, thread.fpu.hard.fpr[29]);
+	       struct task_struct, thread.fpu.fpr[29]);
 	offset("#define THREAD_FPR30   ",
-	       struct task_struct, thread.fpu.hard.fpr[30]);
+	       struct task_struct, thread.fpu.fpr[30]);
 	offset("#define THREAD_FPR31   ",
-	       struct task_struct, thread.fpu.hard.fpr[31]);
+	       struct task_struct, thread.fpu.fpr[31]);
 
 	offset("#define THREAD_FCR31   ",
-	       struct task_struct, thread.fpu.hard.fcr31);
+	       struct task_struct, thread.fpu.fcr31);
 	linefeed;
 }
 
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index b6232d9..76fd3f2 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -178,7 +178,7 @@ int __compute_return_epc(struct pt_regs 
 		if (is_fpu_owner())
 			asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
 		else
-			fcr31 = current->thread.fpu.hard.fcr31;
+			fcr31 = current->thread.fpu.fcr31;
 		preempt_enable();
 
 		bit = (insn.i_format.rt >> 2);
diff --git a/arch/mips/kernel/irixsig.c b/arch/mips/kernel/irixsig.c
index 8150f07..a9bf6cc 100644
--- a/arch/mips/kernel/irixsig.c
+++ b/arch/mips/kernel/irixsig.c
@@ -260,7 +260,7 @@ irix_sigreturn(struct pt_regs *regs)
 
 		for(i = 0; i < 32; i++)
 			error |= __get_user(fregs[i], &context->fpregs[i]);
-		error |= __get_user(current->thread.fpu.hard.fcr31, &context->fpcsr);
+		error |= __get_user(current->thread.fpu.fcr31, &context->fpcsr);
 	}
 
 	/* XXX do sigstack crapola here... XXX */
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 539b357..823c679 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -120,11 +120,11 @@ int ptrace_getfpregs (struct task_struct
 			__put_user ((__u64) -1, i + (__u64 __user *) data);
 	}
 
+	__put_user (child->thread.fpu.fcr31, data + 64);
+
 	if (cpu_has_fpu) {
 		unsigned int flags, tmp;
 
-		__put_user (child->thread.fpu.hard.fcr31, data + 64);
-
 		preempt_disable();
 		if (cpu_has_mipsmt) {
 			unsigned int vpflags = dvpe();
@@ -142,7 +142,6 @@ int ptrace_getfpregs (struct task_struct
 		preempt_enable();
 		__put_user (tmp, data + 65);
 	} else {
-		__put_user (child->thread.fpu.soft.fcr31, data + 64);
 		__put_user ((__u32) 0, data + 65);
 	}
 
@@ -162,10 +161,7 @@ int ptrace_setfpregs (struct task_struct
 	for (i = 0; i < 32; i++)
 		__get_user (fregs[i], i + (__u64 __user *) data);
 
-	if (cpu_has_fpu)
-		__get_user (child->thread.fpu.hard.fcr31, data + 64);
-	else
-		__get_user (child->thread.fpu.soft.fcr31, data + 64);
+	__get_user (child->thread.fpu.fcr31, data + 64);
 
 	/* FIR may not be written.  */
 
@@ -241,10 +237,7 @@ long arch_ptrace(struct task_struct *chi
 			tmp = regs->lo;
 			break;
 		case FPC_CSR:
-			if (cpu_has_fpu)
-				tmp = child->thread.fpu.hard.fcr31;
-			else
-				tmp = child->thread.fpu.soft.fcr31;
+			tmp = child->thread.fpu.fcr31;
 			break;
 		case FPC_EIR: {	/* implementation / version register */
 			unsigned int flags;
@@ -336,9 +329,9 @@ long arch_ptrace(struct task_struct *chi
 
 			if (!tsk_used_math(child)) {
 				/* FP not yet used  */
-				memset(&child->thread.fpu.hard, ~0,
-				       sizeof(child->thread.fpu.hard));
-				child->thread.fpu.hard.fcr31 = 0;
+				memset(&child->thread.fpu, ~0,
+				       sizeof(child->thread.fpu));
+				child->thread.fpu.fcr31 = 0;
 			}
 #ifdef CONFIG_32BIT
 			/*
@@ -369,10 +362,7 @@ long arch_ptrace(struct task_struct *chi
 			regs->lo = data;
 			break;
 		case FPC_CSR:
-			if (cpu_has_fpu)
-				child->thread.fpu.hard.fcr31 = data;
-			else
-				child->thread.fpu.soft.fcr31 = data;
+			child->thread.fpu.fcr31 = data;
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 8704dc0..f40ecd8 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -166,10 +166,7 @@ asmlinkage int sys32_ptrace(int request,
 			tmp = regs->lo;
 			break;
 		case FPC_CSR:
-			if (cpu_has_fpu)
-				tmp = child->thread.fpu.hard.fcr31;
-			else
-				tmp = child->thread.fpu.soft.fcr31;
+			tmp = child->thread.fpu.fcr31;
 			break;
 		case FPC_EIR: {	/* implementation / version register */
 			unsigned int flags;
@@ -288,9 +285,9 @@ asmlinkage int sys32_ptrace(int request,
 
 			if (!tsk_used_math(child)) {
 				/* FP not yet used  */
-				memset(&child->thread.fpu.hard, ~0,
-				       sizeof(child->thread.fpu.hard));
-				child->thread.fpu.hard.fcr31 = 0;
+				memset(&child->thread.fpu, ~0,
+				       sizeof(child->thread.fpu));
+				child->thread.fpu.fcr31 = 0;
 			}
 			/*
 			 * The odd registers are actually the high order bits
@@ -318,10 +315,7 @@ asmlinkage int sys32_ptrace(int request,
 			regs->lo = data;
 			break;
 		case FPC_CSR:
-			if (cpu_has_fpu)
-				child->thread.fpu.hard.fcr31 = data;
-			else
-				child->thread.fpu.soft.fcr31 = data;
+			child->thread.fpu.fcr31 = data;
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 35cb08d..8b3822a 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -65,7 +65,7 @@ extern asmlinkage void handle_mcheck(voi
 extern asmlinkage void handle_reserved(void);
 
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
-	struct mips_fpu_soft_struct *ctx);
+	struct mips_fpu_struct *ctx);
 
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
@@ -600,8 +600,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 		preempt_enable();
 
 		/* Run the emulator */
-		sig = fpu_emulator_cop1Handler (regs,
-			&current->thread.fpu.soft);
+		sig = fpu_emulator_cop1Handler (regs, &current->thread.fpu);
 
 		preempt_disable();
 
@@ -610,7 +609,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 		 * We can't allow the emulated instruction to leave any of
 		 * the cause bit set in $fcr31.
 		 */
-		current->thread.fpu.soft.fcr31 &= ~FPU_CSR_ALL_X;
+		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
 
 		/* Restore the hardware register state */
 		restore_fp(current);
@@ -755,7 +754,7 @@ asmlinkage void do_cpu(struct pt_regs *r
 
 		if (!cpu_has_fpu) {
 			int sig = fpu_emulator_cop1Handler(regs,
-						&current->thread.fpu.soft);
+						&current->thread.fpu);
 			if (sig)
 				force_sig(sig, current);
 #ifdef CONFIG_MIPS_MT_FPAFF
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index aa5818a..3f0d5d2 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -60,15 +60,15 @@
 
 /* Function which emulates a floating point instruction. */
 
-static int fpu_emu(struct pt_regs *, struct mips_fpu_soft_struct *,
+static int fpu_emu(struct pt_regs *, struct mips_fpu_struct *,
 	mips_instruction);
 
 #if __mips >= 4 && __mips != 32
 static int fpux_emu(struct pt_regs *,
-	struct mips_fpu_soft_struct *, mips_instruction);
+	struct mips_fpu_struct *, mips_instruction);
 #endif
 
-/* Further private data for which no space exists in mips_fpu_soft_struct */
+/* Further private data for which no space exists in mips_fpu_struct */
 
 struct mips_fpu_emulator_stats fpuemustats;
 
@@ -203,7 +203,7 @@ static int isBranchInstr(mips_instructio
  * Two instructions if the instruction is in a branch delay slot.
  */
 
-static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_soft_struct *ctx)
+static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 {
 	mips_instruction ir;
 	void * emulpc, *contpc;
@@ -595,7 +595,7 @@ DEF3OP(msub, dp, ieee754dp_mul, ieee754d
 DEF3OP(nmadd, dp, ieee754dp_mul, ieee754dp_add, ieee754dp_neg);
 DEF3OP(nmsub, dp, ieee754dp_mul, ieee754dp_sub, ieee754dp_neg);
 
-static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_soft_struct *ctx,
+static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	mips_instruction ir)
 {
 	unsigned rcsr = 0;	/* resulting csr */
@@ -759,7 +759,7 @@ static int fpux_emu(struct pt_regs *xcp,
 /*
  * Emulate a single COP1 arithmetic instruction.
  */
-static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_soft_struct *ctx,
+static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	mips_instruction ir)
 {
 	int rfmt;		/* resulting format */
@@ -1233,8 +1233,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 	return 0;
 }
 
-int fpu_emulator_cop1Handler(struct pt_regs *xcp,
-	struct mips_fpu_soft_struct *ctx)
+int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 {
 	unsigned long oldepc, prevepc;
 	mips_instruction insn;
diff --git a/arch/mips/math-emu/ieee754.h b/arch/mips/math-emu/ieee754.h
index 171f177..dd91733 100644
--- a/arch/mips/math-emu/ieee754.h
+++ b/arch/mips/math-emu/ieee754.h
@@ -329,7 +329,7 @@ struct _ieee754_csr {
 	unsigned pad0:7;
 #endif
 };
-#define ieee754_csr (*(struct _ieee754_csr *)(&current->thread.fpu.soft.fcr31))
+#define ieee754_csr (*(struct _ieee754_csr *)(&current->thread.fpu.fcr31))
 
 static inline unsigned ieee754_getrm(void)
 {
diff --git a/arch/mips/math-emu/kernel_linkage.c b/arch/mips/math-emu/kernel_linkage.c
index d187ab7..56ca0c6 100644
--- a/arch/mips/math-emu/kernel_linkage.c
+++ b/arch/mips/math-emu/kernel_linkage.c
@@ -39,9 +39,9 @@ void fpu_emulator_init_fpu(void)
 		printk("Algorithmics/MIPS FPU Emulator v1.5\n");
 	}
 
-	current->thread.fpu.soft.fcr31 = 0;
+	current->thread.fpu.fcr31 = 0;
 	for (i = 0; i < 32; i++) {
-		current->thread.fpu.soft.fpr[i] = SIGNALLING_NAN;
+		current->thread.fpu.fpr[i] = SIGNALLING_NAN;
 	}
 }
 
@@ -59,10 +59,9 @@ int fpu_emulator_save_context(struct sig
 
 	for (i = 0; i < 32; i++) {
 		err |=
-		    __put_user(current->thread.fpu.soft.fpr[i],
-			       &sc->sc_fpregs[i]);
+		    __put_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
 	}
-	err |= __put_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
+	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
 
 	return err;
 }
@@ -74,10 +73,9 @@ int fpu_emulator_restore_context(struct 
 
 	for (i = 0; i < 32; i++) {
 		err |=
-		    __get_user(current->thread.fpu.soft.fpr[i],
-			       &sc->sc_fpregs[i]);
+		    __get_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
 	}
-	err |= __get_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
+	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
 
 	return err;
 }
@@ -94,10 +92,9 @@ int fpu_emulator_save_context32(struct s
 
 	for (i = 0; i < 32; i+=2) {
 		err |=
-		    __put_user(current->thread.fpu.soft.fpr[i],
-			       &sc->sc_fpregs[i]);
+		    __put_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
 	}
-	err |= __put_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
+	err |= __put_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
 
 	return err;
 }
@@ -109,10 +106,9 @@ int fpu_emulator_restore_context32(struc
 
 	for (i = 0; i < 32; i+=2) {
 		err |=
-		    __get_user(current->thread.fpu.soft.fpr[i],
-			       &sc->sc_fpregs[i]);
+		    __get_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
 	}
-	err |= __get_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
+	err |= __get_user(current->thread.fpu.fcr31, &sc->sc_fpc_csr);
 
 	return err;
 }
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index b0f5001..8bf510a 100644
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -138,10 +138,9 @@ static inline fpureg_t *get_fpu_regs(str
 	if (cpu_has_fpu) {
 		if ((tsk == current) && __is_fpu_owner())
 			_save_fp(current);
-		return tsk->thread.fpu.hard.fpr;
 	}
 
-	return tsk->thread.fpu.soft.fpr;
+	return tsk->thread.fpu.fpr;
 }
 
 #endif /* _ASM_FPU_H */
diff --git a/include/asm-mips/fpu_emulator.h b/include/asm-mips/fpu_emulator.h
index 16cb4d1..2731c38 100644
--- a/include/asm-mips/fpu_emulator.h
+++ b/include/asm-mips/fpu_emulator.h
@@ -12,8 +12,8 @@
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
  *
- * Further private data for which no space exists in mips_fpu_soft_struct.
- * This should be subsumed into the mips_fpu_soft_struct structure as
+ * Further private data for which no space exists in mips_fpu_struct.
+ * This should be subsumed into the mips_fpu_struct structure as
  * defined in processor.h as soon as the absurd wired absolute assembler
  * offsets become dynamic at compile time.
  *
diff --git a/include/asm-mips/processor.h b/include/asm-mips/processor.h
index 0fb75f0..8393646 100644
--- a/include/asm-mips/processor.h
+++ b/include/asm-mips/processor.h
@@ -71,11 +71,6 @@ extern unsigned int vced_count, vcei_cou
 
 typedef __u64 fpureg_t;
 
-struct mips_fpu_hard_struct {
-	fpureg_t	fpr[NUM_FPU_REGS];
-	unsigned int	fcr31;
-};
-
 /*
  * It would be nice to add some more fields for emulator statistics, but there
  * are a number of fixed offsets in offset.h and elsewhere that would have to
@@ -83,18 +78,13 @@ struct mips_fpu_hard_struct {
  * the FPU emulator for now.  See asm-mips/fpu_emulator.h.
  */
 
-struct mips_fpu_soft_struct {
+struct mips_fpu_struct {
 	fpureg_t	fpr[NUM_FPU_REGS];
 	unsigned int	fcr31;
 };
 
-union mips_fpu_union {
-        struct mips_fpu_hard_struct hard;
-        struct mips_fpu_soft_struct soft;
-};
-
 #define INIT_FPU { \
-	{{0,},} \
+	{0,} \
 }
 
 #define NUM_DSP_REGS   6
@@ -133,7 +123,7 @@ struct thread_struct {
 	unsigned long cp0_status;
 
 	/* Saved fpu/fpu emulator stuff. */
-	union mips_fpu_union fpu;
+	struct mips_fpu_struct fpu;
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* Emulated instruction count */
 	unsigned long emulated_fp;
