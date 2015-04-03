Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:35:32 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025242AbbDCW1PBMLa2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:15 +0200
Date:   Fri, 3 Apr 2015 23:27:15 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 41/48] MIPS: Set `si_code' for SIGFPE signals sent from
 emulation too
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504032026360.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Rework `process_fpemu_return' and move IEEE 754 exception interpretation 
there, from `do_fpe'.  Record the cause bits set in FCSR before they are 
cleared and pass them through to `process_fpemu_return' so as to set 
`si_code' correctly too for SIGFPE signals sent from emulation rather 
than those issued by hardware with the FPE processor exception only.

For simplicity `mipsr2_decoder' assumes `*fcr31' has been preinitialised 
and only sets it to anything if an FPU instruction has been emulated, 
which in turn is the only case SIGFPE can be issued for here.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-fpe-emu-siginfo.diff
Index: linux/arch/mips/include/asm/fpu_emulator.h
===================================================================
--- linux.orig/arch/mips/include/asm/fpu_emulator.h	2015-04-02 20:18:48.693493000 +0100
+++ linux/arch/mips/include/asm/fpu_emulator.h	2015-04-02 20:27:58.453234000 +0100
@@ -65,7 +65,8 @@ extern int do_dsemulret(struct pt_regs *
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
-int process_fpemu_return(int sig, void __user *fault_addr);
+int process_fpemu_return(int sig, void __user *fault_addr,
+			 unsigned long fcr31);
 int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		     unsigned long *contpc);
 
Index: linux/arch/mips/include/asm/mips-r2-to-r6-emul.h
===================================================================
--- linux.orig/arch/mips/include/asm/mips-r2-to-r6-emul.h	2015-04-02 20:27:53.724187000 +0100
+++ linux/arch/mips/include/asm/mips-r2-to-r6-emul.h	2015-04-02 20:27:58.456228000 +0100
@@ -84,11 +84,16 @@ extern void do_trap_or_bp(struct pt_regs
 
 #ifndef CONFIG_MIPSR2_TO_R6_EMULATOR
 static int mipsr2_emulation;
-static inline int mipsr2_decoder(struct pt_regs *regs, u32 inst) { return 0; };
+static inline int mipsr2_decoder(struct pt_regs *regs, u32 inst,
+				 unsigned long *fcr31)
+{
+	return 0;
+};
 #else
 /* MIPS R2 Emulator ON/OFF */
 extern int mipsr2_emulation;
-extern int mipsr2_decoder(struct pt_regs *regs, u32 inst);
+extern int mipsr2_decoder(struct pt_regs *regs, u32 inst,
+			  unsigned long *fcr31);
 #endif /* CONFIG_MIPSR2_TO_R6_EMULATOR */
 
 #define NO_R6EMU	(cpu_has_mips_r6 && !mipsr2_emulation)
Index: linux/arch/mips/kernel/mips-r2-to-r6-emul.c
===================================================================
--- linux.orig/arch/mips/kernel/mips-r2-to-r6-emul.c	2015-04-02 20:27:58.241225000 +0100
+++ linux/arch/mips/kernel/mips-r2-to-r6-emul.c	2015-04-02 20:27:58.460231000 +0100
@@ -898,8 +898,9 @@ static inline int mipsr2_find_op_func(st
  * mipsr2_decoder: Decode and emulate a MIPS R2 instruction
  * @regs: Process register set
  * @inst: Instruction to decode and emulate
+ * @fcr31: Floating Point Control and Status Register returned
  */
-int mipsr2_decoder(struct pt_regs *regs, u32 inst)
+int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 {
 	int err = 0;
 	unsigned long vaddr;
@@ -1168,6 +1169,7 @@ int mipsr2_decoder(struct pt_regs *regs,
 
 		err = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 0,
 					       &fault_addr);
+		*fcr31 = current->thread.fpu.fcr31;
 
 		/*
 		 * We can't allow the emulated instruction to leave any of
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2015-04-02 20:27:58.244233000 +0100
+++ linux/arch/mips/kernel/traps.c	2015-04-02 20:27:58.463232000 +0100
@@ -700,29 +700,60 @@ asmlinkage void do_ov(struct pt_regs *re
 	exception_exit(prev_state);
 }
 
-int process_fpemu_return(int sig, void __user *fault_addr)
+int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 {
-	if (sig == SIGSEGV || sig == SIGBUS) {
-		struct siginfo si = {0};
+	struct siginfo si = { 0 };
+
+	switch (sig) {
+	case 0:
+		return 0;
+
+	case SIGFPE:
 		si.si_addr = fault_addr;
 		si.si_signo = sig;
-		if (sig == SIGSEGV) {
-			down_read(&current->mm->mmap_sem);
-			if (find_vma(current->mm, (unsigned long)fault_addr))
-				si.si_code = SEGV_ACCERR;
-			else
-				si.si_code = SEGV_MAPERR;
-			up_read(&current->mm->mmap_sem);
-		} else {
-			si.si_code = BUS_ADRERR;
-		}
+		/*
+		 * Inexact can happen together with Overflow or Underflow.
+		 * Respect the mask to deliver the correct exception.
+		 */
+		fcr31 &= (fcr31 & FPU_CSR_ALL_E) <<
+			 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E));
+		if (fcr31 & FPU_CSR_INV_X)
+			si.si_code = FPE_FLTINV;
+		else if (fcr31 & FPU_CSR_DIV_X)
+			si.si_code = FPE_FLTDIV;
+		else if (fcr31 & FPU_CSR_OVF_X)
+			si.si_code = FPE_FLTOVF;
+		else if (fcr31 & FPU_CSR_UDF_X)
+			si.si_code = FPE_FLTUND;
+		else if (fcr31 & FPU_CSR_INE_X)
+			si.si_code = FPE_FLTRES;
+		else
+			si.si_code = __SI_FAULT;
 		force_sig_info(sig, &si, current);
 		return 1;
-	} else if (sig) {
+
+	case SIGBUS:
+		si.si_addr = fault_addr;
+		si.si_signo = sig;
+		si.si_code = BUS_ADRERR;
+		force_sig_info(sig, &si, current);
+		return 1;
+
+	case SIGSEGV:
+		si.si_addr = fault_addr;
+		si.si_signo = sig;
+		down_read(&current->mm->mmap_sem);
+		if (find_vma(current->mm, (unsigned long)fault_addr))
+			si.si_code = SEGV_ACCERR;
+		else
+			si.si_code = SEGV_MAPERR;
+		up_read(&current->mm->mmap_sem);
+		force_sig_info(sig, &si, current);
+		return 1;
+
+	default:
 		force_sig(sig, current);
 		return 1;
-	} else {
-		return 0;
 	}
 }
 
@@ -730,7 +761,8 @@ static int simulate_fp(struct pt_regs *r
 		       unsigned long old_epc, unsigned long old_ra)
 {
 	union mips_instruction inst = { .word = opcode };
-	void __user *fault_addr = NULL;
+	void __user *fault_addr;
+	unsigned long fcr31;
 	int sig;
 
 	/* If it's obviously not an FP instruction, skip it */
@@ -760,6 +792,7 @@ static int simulate_fp(struct pt_regs *r
 	/* Run the emulator */
 	sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 				       &fault_addr);
+	fcr31 = current->thread.fpu.fcr31;
 
 	/*
 	 * We can't allow the emulated instruction to leave any of
@@ -767,12 +800,12 @@ static int simulate_fp(struct pt_regs *r
 	 */
 	current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
 
-	/* If something went wrong, signal */
-	process_fpemu_return(sig, fault_addr);
-
 	/* Restore the hardware register state */
 	own_fpu(1);
 
+	/* Send a signal if required.  */
+	process_fpemu_return(sig, fault_addr, fcr31);
+
 	return 0;
 }
 
@@ -782,7 +815,8 @@ static int simulate_fp(struct pt_regs *r
 asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
 	enum ctx_state prev_state;
-	siginfo_t info = {0};
+	void __user *fault_addr;
+	int sig;
 
 	prev_state = exception_enter();
 	if (notify_die(DIE_FP, "FP exception", regs, 0, regs_to_trapnr(regs),
@@ -791,9 +825,6 @@ asmlinkage void do_fpe(struct pt_regs *r
 	die_if_kernel("FP exception in kernel code", regs);
 
 	if (fcr31 & FPU_CSR_UNI_X) {
-		int sig;
-		void __user *fault_addr = NULL;
-
 		/*
 		 * Unimplemented operation exception.  If we've got the full
 		 * software emulator on-board, let's use it...
@@ -810,6 +841,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 					       &fault_addr);
+		fcr31 = current->thread.fpu.fcr31;
 
 		/*
 		 * We can't allow the emulated instruction to leave any of
@@ -819,35 +851,13 @@ asmlinkage void do_fpe(struct pt_regs *r
 
 		/* Restore the hardware register state */
 		own_fpu(1);	/* Using the FPU again.	 */
-
-		/* If something went wrong, signal */
-		process_fpemu_return(sig, fault_addr);
-
-		goto out;
+	} else {
+		sig = SIGFPE;
+		fault_addr = (void __user *) regs->cp0_epc;
 	}
 
-	/*
-	 * Inexact can happen together with Overflow or Underflow.
-	 * Respect the mask to deliver the correct exception.
-	 */
-	fcr31 &= (fcr31 & FPU_CSR_ALL_E) <<
-		 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E));
-	if (fcr31 & FPU_CSR_INV_X)
-		info.si_code = FPE_FLTINV;
-	else if (fcr31 & FPU_CSR_DIV_X)
-		info.si_code = FPE_FLTDIV;
-	else if (fcr31 & FPU_CSR_OVF_X)
-		info.si_code = FPE_FLTOVF;
-	else if (fcr31 & FPU_CSR_UDF_X)
-		info.si_code = FPE_FLTUND;
-	else if (fcr31 & FPU_CSR_INE_X)
-		info.si_code = FPE_FLTRES;
-	else
-		info.si_code = __SI_FAULT;
-	info.si_signo = SIGFPE;
-	info.si_errno = 0;
-	info.si_addr = (void __user *) regs->cp0_epc;
-	force_sig_info(SIGFPE, &info, current);
+	/* Send a signal if required.  */
+	process_fpemu_return(sig, fault_addr, fcr31);
 
 out:
 	exception_exit(prev_state);
@@ -1050,7 +1060,9 @@ asmlinkage void do_ri(struct pt_regs *re
 	if (mipsr2_emulation && cpu_has_mips_r6 &&
 	    likely(user_mode(regs)) &&
 	    likely(get_user(opcode, epc) >= 0)) {
-		status = mipsr2_decoder(regs, opcode);
+		unsigned long fcr31 = 0;
+
+		status = mipsr2_decoder(regs, opcode, &fcr31);
 		switch (status) {
 		case 0:
 		case SIGEMT:
@@ -1060,7 +1072,8 @@ asmlinkage void do_ri(struct pt_regs *re
 			goto no_r2_instr;
 		default:
 			process_fpemu_return(status,
-					     &current->thread.cp0_baduaddr);
+					     &current->thread.cp0_baduaddr,
+					     fcr31);
 			task_thread_info(current)->r2_emul_return = 1;
 			return;
 		}
@@ -1307,10 +1320,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 	enum ctx_state prev_state;
 	unsigned int __user *epc;
 	unsigned long old_epc, old31;
+	void __user *fault_addr;
 	unsigned int opcode;
+	unsigned long fcr31;
 	unsigned int cpid;
 	int status, err;
 	unsigned long __maybe_unused flags;
+	int sig;
 
 	prev_state = exception_enter();
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
@@ -1384,22 +1400,22 @@ asmlinkage void do_cpu(struct pt_regs *r
 	case 1:
 		err = enable_restore_fp_context(0);
 
-		if (!raw_cpu_has_fpu || err) {
-			int sig;
-			void __user *fault_addr = NULL;
-			sig = fpu_emulator_cop1Handler(regs,
-						       &current->thread.fpu,
-						       0, &fault_addr);
+		if (raw_cpu_has_fpu && !err)
+			break;
 
-			/*
-			 * We can't allow the emulated instruction to leave
-			 * any of the cause bits set in $fcr31.
-			 */
-			current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 0,
+					       &fault_addr);
+		fcr31 = current->thread.fpu.fcr31;
 
-			if (!process_fpemu_return(sig, fault_addr) && !err)
-				mt_ase_fp_affinity();
-		}
+		/*
+		 * We can't allow the emulated instruction to leave
+		 * any of the cause bits set in $fcr31.
+		 */
+		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+
+		/* Send a signal if required.  */
+		if (!process_fpemu_return(sig, fault_addr, fcr31) && !err)
+			mt_ase_fp_affinity();
 
 		break;
 
Index: linux/arch/mips/kernel/unaligned.c
===================================================================
--- linux.orig/arch/mips/kernel/unaligned.c	2015-04-02 20:18:48.702496000 +0100
+++ linux/arch/mips/kernel/unaligned.c	2015-04-02 20:27:58.466232000 +0100
@@ -1076,7 +1076,7 @@ static void emulate_load_store_insn(stru
 		own_fpu(1);	/* Restore FPU state. */
 
 		/* Signal if something went wrong. */
-		process_fpemu_return(res, fault_addr);
+		process_fpemu_return(res, fault_addr, 0);
 
 		if (res == 0)
 			break;
@@ -1511,7 +1511,7 @@ static void emulate_load_store_microMIPS
 		own_fpu(1);	/* restore FPU state */
 
 		/* If something went wrong, signal */
-		process_fpemu_return(res, fault_addr);
+		process_fpemu_return(res, fault_addr, 0);
 
 		if (res == 0)
 			goto success;
