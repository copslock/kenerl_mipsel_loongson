Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 16:53:14 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52963 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992336AbeB1PxCzVChz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 16:53:02 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Ys-0006XP-GI; Wed, 28 Feb 2018 15:22:30 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-00005I-Ez; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Burton" <paul.burton@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>, linux-mips@linux-mips.org,
        "James Hogan" <james.hogan@imgtec.com>
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.57078937@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 105/254] MIPS: Fix FCSR Cause bit handling for
 correct SIGFPE issue
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62737
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

From: "Maciej W. Rozycki" <macro@imgtec.com>

commit 5a1aca4469fdccd5b74ba0b4e490173b2b447895 upstream.

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
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14460/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16:
 - Drop changes in mips-r2-to-r6-emul and simulate_fp()
 - Add #include <asm/fpu.h> in <asm/switch_to.h>
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -65,6 +65,8 @@ extern int do_dsemulret(struct pt_regs *
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
+void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
+		     struct task_struct *tsk);
 int process_fpemu_return(int sig, void __user *fault_addr,
 			 unsigned long fcr31);
 int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
@@ -91,4 +93,15 @@ static inline void fpu_emulator_init_fpu
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
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -17,6 +17,7 @@
 #include <asm/dsp.h>
 #include <asm/cop2.h>
 #include <asm/msa.h>
+#include <asm/fpu.h>
 
 struct task_struct;
 
@@ -80,11 +81,29 @@ do {									\
 		ll_bit = 0;						\
 } while (0)
 
+/*
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
 #define switch_to(prev, next, last)					\
 do {									\
 	u32 __c0_stat;							\
 	s32 __fpsave = FP_SAVE_NONE;					\
 	__mips_mt_fpaff_switch_to(prev);				\
+	if (tsk_used_math(next))					\
+		__sanitize_fcr31(next);					\
 	if (cpu_has_dsp)						\
 		__save_dsp(prev);					\
 	if (cop2_present && (KSTK_STATUS(prev) & ST0_CU2)) {		\
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
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
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -707,6 +707,32 @@ asmlinkage void do_ov(struct pt_regs *re
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
@@ -716,27 +742,7 @@ int process_fpemu_return(int sig, void _
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
@@ -779,7 +785,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 		goto out;
 
 	/* Clear FCSR.Cause before enabling interrupts */
-	write_32bit_cp1_register(CP1_STATUS, fcr31 & ~FPU_CSR_ALL_X);
+	write_32bit_cp1_register(CP1_STATUS, fcr31 & ~mask_fcr31_x(fcr31));
 	local_irq_enable();
 
 	die_if_kernel("FP exception in kernel code", regs);
@@ -801,13 +807,13 @@ asmlinkage void do_fpe(struct pt_regs *r
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
@@ -1302,13 +1308,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 
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
