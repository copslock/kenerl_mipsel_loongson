Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2016 09:21:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41116 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992847AbcJ1HVTSRoms (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Oct 2016 09:21:19 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 73A605F68B1F2;
        Fri, 28 Oct 2016 08:21:10 +0100 (IST)
Received: from [10.20.78.229] (10.20.78.229) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 28 Oct 2016
 08:21:11 +0100
Date:   Fri, 28 Oct 2016 08:21:03 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: Fix FCSR Cause bit handling for correct SIGFPE
 issue
In-Reply-To: <alpine.DEB.2.00.1610272159160.31859@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1610272258130.31859@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1610272159160.31859@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.229]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Sanitize FCSR Cause bit handling, following a trail of past attempts:

* commit 4249548454f7 ("MIPS: ptrace: Fix FP context restoration FCSR 
regression"),

* commit 443c44032a54 ("MIPS: Always clear FCSR cause bits after 
emulation"),

* commit 64bedffe4968 ("MIPS: Clear [MSA]FPE CSR.Cause after 
notify_die()"),

* commit b1442d39fac2 ("MIPS: Prevent user from setting FCSR cause 
bits"),

* commit b54d2901517d ("Properly handle branch delay slots in connection 
with signals.").

Specifically do not mask these bits out in ptrace(2) processing and send 
a SIGFPE signal instead whenever a matching pair of an FCSR Cause and 
Enable bit is seen as execution of an affected context is about to 
resume.  Only then clear Cause bits, and even then do not clear any bits 
that are set but masked with the respective Enable bits.  Adjust Cause 
bit clearing throughout code likewise, except within the FPU emulator 
proper where they are set according to IEEE 754 exceptions raised as the 
operation emulated executed.  Do so so that any IEEE 754 exceptions 
subject to their default handling are recorded like with operations 
executed by FPU hardware.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Hi,

 This for a change I actually verified, by poking at FCSR with GDB, via 
`gdbserver'.  With this change you can now set any Cause bits and at the 
resumption of the debuggee it will receive a SIGFPE with the right code, 
according to the priority set in `force_fcr31_sig'.  Any transient FCSR 
state does not matter of course.  The R6 emulation bits have only been 
verified by building an R6 configuration though.  They are consistent 
with the rest of the changes so they should be good.  Please apply.

  Maciej

linux-mips-ptrace-fcsr-set-cause.diff
Index: linux-sfr-test/arch/mips/include/asm/fpu_emulator.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/fpu_emulator.h	2016-10-22 07:10:07.271290000 +0100
+++ linux-sfr-test/arch/mips/include/asm/fpu_emulator.h	2016-10-22 07:10:47.019621000 +0100
@@ -63,6 +63,8 @@ do {									\
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
+void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
+		     struct task_struct *tsk);
 int process_fpemu_return(int sig, void __user *fault_addr,
 			 unsigned long fcr31);
 int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
@@ -81,4 +83,15 @@ static inline void fpu_emulator_init_fpu
 		set_fpr64(&t->thread.fpu.fpr[i], 0, SIGNALLING_NAN);
 }
 
+/*
+ * Mask the FCSR Cause bits according to the Enable bits, observing
+ * that Unimplemented is always enabled.
+ */
+static inline unsigned long mask_fcr31_x(unsigned long fcr31)
+{
+	return fcr31 & (FPU_CSR_UNI_X |
+			((fcr31 & FPU_CSR_ALL_E) <<
+			 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E))));
+}
+
 #endif /* _ASM_FPU_EMULATOR_H */
Index: linux-sfr-test/arch/mips/include/asm/switch_to.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/switch_to.h	2016-10-22 07:10:07.275287000 +0100
+++ linux-sfr-test/arch/mips/include/asm/switch_to.h	2016-10-22 07:10:47.037633000 +0100
@@ -76,6 +76,22 @@ do {	if (cpu_has_rw_llb) {						\
 } while (0)
 
 /*
+ * Check FCSR for any unmasked exceptions pending set with `ptrace',
+ * clear them and send a signal.
+ */
+#define __sanitize_fcr31(next)						\
+do {									\
+	unsigned long fcr31 = mask_fcr31_x(next->thread.fpu.fcr31);	\
+	void __user *pc;						\
+									\
+	if (unlikely(fcr31)) {						\
+		pc = (void __user *)task_pt_regs(next)->cp0_epc;	\
+		next->thread.fpu.fcr31 &= ~fcr31;			\
+		force_fcr31_sig(fcr31, pc, next);			\
+	}								\
+} while (0)
+
+/*
  * For newly created kernel threads switch_to() will return to
  * ret_from_kernel_thread, newly created user threads to ret_from_fork.
  * That is, everything following resume() will be skipped for new threads.
@@ -85,6 +101,8 @@ do {	if (cpu_has_rw_llb) {						\
 do {									\
 	__mips_mt_fpaff_switch_to(prev);				\
 	lose_fpu_inatomic(1, prev);					\
+	if (tsk_used_math(next))					\
+		__sanitize_fcr31(next);					\
 	if (cpu_has_dsp) {						\
 		__save_dsp(prev);					\
 		__restore_dsp(next);					\
Index: linux-sfr-test/arch/mips/kernel/mips-r2-to-r6-emul.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/mips-r2-to-r6-emul.c	2016-10-22 07:10:07.312291000 +0100
+++ linux-sfr-test/arch/mips/kernel/mips-r2-to-r6-emul.c	2016-10-22 07:10:47.065621000 +0100
@@ -899,7 +899,7 @@ static inline int mipsr2_find_op_func(st
  * mipsr2_decoder: Decode and emulate a MIPS R2 instruction
  * @regs: Process register set
  * @inst: Instruction to decode and emulate
- * @fcr31: Floating Point Control and Status Register returned
+ * @fcr31: Floating Point Control and Status Register Cause bits returned
  */
 int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 {
@@ -1172,13 +1172,13 @@ int mipsr2_decoder(struct pt_regs *regs,
 
 		err = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 0,
 					       &fault_addr);
-		*fcr31 = current->thread.fpu.fcr31;
 
 		/*
-		 * We can't allow the emulated instruction to leave any of
-		 * the cause bits set in $fcr31.
+		 * We can't allow the emulated instruction to leave any
+		 * enabled Cause bits set in $fcr31.
 		 */
-		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+		*fcr31 = res = mask_fcr31_x(current->thread.fpu.fcr31);
+		current->thread.fpu.fcr31 &= ~res;
 
 		/*
 		 * this is a tricky issue - lose_fpu() uses LL/SC atomics
Index: linux-sfr-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2016-10-22 07:10:45.047625000 +0100
+++ linux-sfr-test/arch/mips/kernel/ptrace.c	2016-10-22 07:10:47.068623000 +0100
@@ -79,16 +79,15 @@ void ptrace_disable(struct task_struct *
 }
 
 /*
- * Poke at FCSR according to its mask.  Don't set the cause bits as
- * this is currently not handled correctly in FP context restoration
- * and will cause an oops if a corresponding enable bit is set.
+ * Poke at FCSR according to its mask.  Set the Cause bits even
+ * if a corresponding Enable bit is set.  This will be noticed at
+ * the time the thread is switched to and SIGFPE thrown accordingly.
  */
 static void ptrace_setfcr31(struct task_struct *child, u32 value)
 {
 	u32 fcr31;
 	u32 mask;
 
-	value &= ~FPU_CSR_ALL_X;
 	fcr31 = child->thread.fpu.fcr31;
 	mask = boot_cpu_data.fpu_msk31;
 	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
Index: linux-sfr-test/arch/mips/kernel/traps.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/traps.c	2016-10-22 07:10:07.375283000 +0100
+++ linux-sfr-test/arch/mips/kernel/traps.c	2016-10-22 07:10:47.076623000 +0100
@@ -705,6 +705,32 @@ asmlinkage void do_ov(struct pt_regs *re
 	exception_exit(prev_state);
 }
 
+/*
+ * Send SIGFPE according to FCSR Cause bits, which must have already
+ * been masked against Enable bits.  This is impotant as Inexact can
+ * happen together with Overflow or Underflow, and `ptrace' can set
+ * any bits.
+ */
+void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
+		     struct task_struct *tsk)
+{
+	struct siginfo si = { .si_addr = fault_addr, .si_signo = SIGFPE };
+
+	if (fcr31 & FPU_CSR_INV_X)
+		si.si_code = FPE_FLTINV;
+	else if (fcr31 & FPU_CSR_DIV_X)
+		si.si_code = FPE_FLTDIV;
+	else if (fcr31 & FPU_CSR_OVF_X)
+		si.si_code = FPE_FLTOVF;
+	else if (fcr31 & FPU_CSR_UDF_X)
+		si.si_code = FPE_FLTUND;
+	else if (fcr31 & FPU_CSR_INE_X)
+		si.si_code = FPE_FLTRES;
+	else
+		si.si_code = __SI_FAULT;
+	force_sig_info(SIGFPE, &si, tsk);
+}
+
 int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 {
 	struct siginfo si = { 0 };
@@ -715,27 +741,7 @@ int process_fpemu_return(int sig, void _
 		return 0;
 
 	case SIGFPE:
-		si.si_addr = fault_addr;
-		si.si_signo = sig;
-		/*
-		 * Inexact can happen together with Overflow or Underflow.
-		 * Respect the mask to deliver the correct exception.
-		 */
-		fcr31 &= (fcr31 & FPU_CSR_ALL_E) <<
-			 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E));
-		if (fcr31 & FPU_CSR_INV_X)
-			si.si_code = FPE_FLTINV;
-		else if (fcr31 & FPU_CSR_DIV_X)
-			si.si_code = FPE_FLTDIV;
-		else if (fcr31 & FPU_CSR_OVF_X)
-			si.si_code = FPE_FLTOVF;
-		else if (fcr31 & FPU_CSR_UDF_X)
-			si.si_code = FPE_FLTUND;
-		else if (fcr31 & FPU_CSR_INE_X)
-			si.si_code = FPE_FLTRES;
-		else
-			si.si_code = __SI_FAULT;
-		force_sig_info(sig, &si, current);
+		force_fcr31_sig(fcr31, fault_addr, current);
 		return 1;
 
 	case SIGBUS:
@@ -799,13 +805,13 @@ static int simulate_fp(struct pt_regs *r
 	/* Run the emulator */
 	sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 				       &fault_addr);
-	fcr31 = current->thread.fpu.fcr31;
 
 	/*
-	 * We can't allow the emulated instruction to leave any of
-	 * the cause bits set in $fcr31.
+	 * We can't allow the emulated instruction to leave any
+	 * enabled Cause bits set in $fcr31.
 	 */
-	current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+	fcr31 = mask_fcr31_x(current->thread.fpu.fcr31);
+	current->thread.fpu.fcr31 &= ~fcr31;
 
 	/* Restore the hardware register state */
 	own_fpu(1);
@@ -831,7 +837,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 		goto out;
 
 	/* Clear FCSR.Cause before enabling interrupts */
-	write_32bit_cp1_register(CP1_STATUS, fcr31 & ~FPU_CSR_ALL_X);
+	write_32bit_cp1_register(CP1_STATUS, fcr31 & ~mask_fcr31_x(fcr31));
 	local_irq_enable();
 
 	die_if_kernel("FP exception in kernel code", regs);
@@ -853,13 +859,13 @@ asmlinkage void do_fpe(struct pt_regs *r
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 					       &fault_addr);
-		fcr31 = current->thread.fpu.fcr31;
 
 		/*
-		 * We can't allow the emulated instruction to leave any of
-		 * the cause bits set in $fcr31.
+		 * We can't allow the emulated instruction to leave any
+		 * enabled Cause bits set in $fcr31.
 		 */
-		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+		fcr31 = mask_fcr31_x(current->thread.fpu.fcr31);
+		current->thread.fpu.fcr31 &= ~fcr31;
 
 		/* Restore the hardware register state */
 		own_fpu(1);	/* Using the FPU again.	 */
@@ -1424,13 +1430,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 
 		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 0,
 					       &fault_addr);
-		fcr31 = current->thread.fpu.fcr31;
 
 		/*
 		 * We can't allow the emulated instruction to leave
-		 * any of the cause bits set in $fcr31.
+		 * any enabled Cause bits set in $fcr31.
 		 */
-		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+		fcr31 = mask_fcr31_x(current->thread.fpu.fcr31);
+		current->thread.fpu.fcr31 &= ~fcr31;
 
 		/* Send a signal if required.  */
 		if (!process_fpemu_return(sig, fault_addr, fcr31) && !err)
