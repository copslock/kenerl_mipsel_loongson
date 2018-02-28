Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 16:58:32 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53086 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992604AbeB1P6Wo530z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 16:58:22 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yt-0006Xk-H0; Wed, 28 Feb 2018 15:22:31 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-0008WK-8a; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.898552173@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 098/254] MIPS: Set `si_code' for SIGFPE signals sent
 from emulation too
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit 304acb717e5b67cf56f05bc5b21123758e1f7ea0 upstream.

Rework `process_fpemu_return' and move IEEE 754 exception interpretation
there, from `do_fpe'.  Record the cause bits set in FCSR before they are
cleared and pass them through to `process_fpemu_return' so as to set
`si_code' correctly too for SIGFPE signals sent from emulation rather
than those issued by hardware with the FPE processor exception only.

For simplicity `mipsr2_decoder' assumes `*fcr31' has been preinitialised
and only sets it to anything if an FPU instruction has been emulated,
which in turn is the only case SIGFPE can be issued for here.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9705/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16:
 - Drop changes in mips-r2-to-r6-emul and simulate_fp()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -65,7 +65,8 @@ extern int do_dsemulret(struct pt_regs *
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
-int process_fpemu_return(int sig, void __user *fault_addr);
+int process_fpemu_return(int sig, void __user *fault_addr,
+			 unsigned long fcr31);
 int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		     unsigned long *contpc);
 
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -707,29 +707,60 @@ asmlinkage void do_ov(struct pt_regs *re
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
+		force_sig_info(sig, &si, current);
+		return 1;
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
 		force_sig_info(sig, &si, current);
 		return 1;
-	} else if (sig) {
+
+	default:
 		force_sig(sig, current);
 		return 1;
-	} else {
-		return 0;
 	}
 }
 
@@ -739,7 +770,8 @@ int process_fpemu_return(int sig, void _
 asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
 	enum ctx_state prev_state;
-	siginfo_t info = {0};
+	void __user *fault_addr;
+	int sig;
 
 	prev_state = exception_enter();
 	if (notify_die(DIE_FP, "FP exception", regs, 0, regs_to_trapnr(regs),
@@ -753,9 +785,6 @@ asmlinkage void do_fpe(struct pt_regs *r
 	die_if_kernel("FP exception in kernel code", regs);
 
 	if (fcr31 & FPU_CSR_UNI_X) {
-		int sig;
-		void __user *fault_addr = NULL;
-
 		/*
 		 * Unimplemented operation exception.  If we've got the full
 		 * software emulator on-board, let's use it...
@@ -772,6 +801,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 					       &fault_addr);
+		fcr31 = current->thread.fpu.fcr31;
 
 		/*
 		 * We can't allow the emulated instruction to leave any of
@@ -781,35 +811,13 @@ asmlinkage void do_fpe(struct pt_regs *r
 
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
@@ -1210,10 +1218,13 @@ asmlinkage void do_cpu(struct pt_regs *r
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
@@ -1286,22 +1297,22 @@ asmlinkage void do_cpu(struct pt_regs *r
 	case 1:
 		err = enable_restore_fp_context(0);
 
-		if (!raw_cpu_has_fpu || err) {
-			int sig;
-			void __user *fault_addr = NULL;
-			sig = fpu_emulator_cop1Handler(regs,
-						       &current->thread.fpu,
-						       0, &fault_addr);
-
-			/*
-			 * We can't allow the emulated instruction to leave
-			 * any of the cause bits set in $fcr31.
-			 */
-			current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+		if (raw_cpu_has_fpu && !err)
+			break;
 
-			if (!process_fpemu_return(sig, fault_addr) && !err)
-				mt_ase_fp_affinity();
-		}
+		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 0,
+					       &fault_addr);
+		fcr31 = current->thread.fpu.fcr31;
+
+		/*
+		 * We can't allow the emulated instruction to leave
+		 * any of the cause bits set in $fcr31.
+		 */
+		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+
+		/* Send a signal if required.  */
+		if (!process_fpemu_return(sig, fault_addr, fcr31) && !err)
+			mt_ase_fp_affinity();
 
 		goto out;
 
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -697,7 +697,7 @@ static void emulate_load_store_insn(stru
 		own_fpu(1);	/* Restore FPU state. */
 
 		/* Signal if something went wrong. */
-		process_fpemu_return(res, fault_addr);
+		process_fpemu_return(res, fault_addr, 0);
 
 		if (res == 0)
 			break;
@@ -1129,7 +1129,7 @@ fpu_emul:
 		own_fpu(1);	/* restore FPU state */
 
 		/* If something went wrong, signal */
-		process_fpemu_return(res, fault_addr);
+		process_fpemu_return(res, fault_addr, 0);
 
 		if (res == 0)
 			goto success;
