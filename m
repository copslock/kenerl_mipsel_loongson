Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 01:32:42 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1391 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491160Ab0JUXch (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Oct 2010 01:32:37 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cc0cdb70000>; Thu, 21 Oct 2010 16:33:11 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 21 Oct 2010 16:32:57 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 21 Oct 2010 16:32:57 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o9LNWSr8018716;
        Thu, 21 Oct 2010 16:32:29 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o9LNWR4j018690;
        Thu, 21 Oct 2010 16:32:27 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Camm Maguire <camm@maguirefamily.org>
Subject: [PATCH] MIPS: Send proper signal and siginfo on FP emulator faults.
Date:   Thu, 21 Oct 2010 16:32:26 -0700
Message-Id: <1287703946-18623-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 21 Oct 2010 23:32:57.0215 (UTC) FILETIME=[4A9F28F0:01CB7178]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

We were unconditionally sending SIGBUS with an empty siginfo on FP
emulator faults.  This differs from what happens when real floating
point hardware would get a fault.

For most faults we need to send SIGSEGV with the faulting address
filled in in the struct siginfo.

Reported-by: Camm Maguire <camm@maguirefamily.org>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Camm Maguire <camm@maguirefamily.org>
---
 arch/mips/kernel/traps.c    |   44 +++++++++++++---
 arch/mips/math-emu/cp1emu.c |  116 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 130 insertions(+), 30 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 03ec001..f45beff 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -82,7 +82,8 @@ extern asmlinkage void handle_mcheck(void);
 extern asmlinkage void handle_reserved(void);
 
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
-	struct mips_fpu_struct *ctx, int has_fpu);
+				    struct mips_fpu_struct *ctx, int has_fpu,
+				    void *__user *fault_addr);
 
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
@@ -649,12 +650,36 @@ asmlinkage void do_ov(struct pt_regs *regs)
 	force_sig_info(SIGFPE, &info, current);
 }
 
+static int process_fpemu_return(int sig, void __user *fault_addr)
+{
+	if (sig == SIGSEGV || sig == SIGBUS) {
+		struct siginfo si = {0};
+		si.si_addr = fault_addr;
+		si.si_signo = sig;
+		if (sig == SIGSEGV) {
+			if (find_vma(current->mm, (unsigned long)fault_addr))
+				si.si_code = SEGV_ACCERR;
+			else
+				si.si_code = SEGV_MAPERR;
+		} else {
+			si.si_code = BUS_ADRERR;
+		}
+		force_sig_info(sig, &si, current);
+		return 1;
+	} else if (sig) {
+		force_sig(sig, current);
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
 /*
  * XXX Delayed fp exceptions when doing a lazy ctx switch XXX
  */
 asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
-	siginfo_t info;
+	siginfo_t info = {0};
 
 	if (notify_die(DIE_FP, "FP exception", regs, 0, regs_to_trapnr(regs), SIGFPE)
 	    == NOTIFY_STOP)
@@ -663,6 +688,7 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 
 	if (fcr31 & FPU_CSR_UNI_X) {
 		int sig;
+		void __user *fault_addr = NULL;
 
 		/*
 		 * Unimplemented operation exception.  If we've got the full
@@ -678,7 +704,8 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 		lose_fpu(1);
 
 		/* Run the emulator */
-		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1);
+		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
+					       &fault_addr);
 
 		/*
 		 * We can't allow the emulated instruction to leave any of
@@ -690,8 +717,7 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 		own_fpu(1);	/* Using the FPU again.  */
 
 		/* If something went wrong, signal */
-		if (sig)
-			force_sig(sig, current);
+		process_fpemu_return(sig, fault_addr);
 
 		return;
 	} else if (fcr31 & FPU_CSR_INV_X)
@@ -984,11 +1010,11 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 
 		if (!raw_cpu_has_fpu) {
 			int sig;
+			void __user *fault_addr = NULL;
 			sig = fpu_emulator_cop1Handler(regs,
-						&current->thread.fpu, 0);
-			if (sig)
-				force_sig(sig, current);
-			else
+						       &current->thread.fpu,
+						       0, &fault_addr);
+			if (!process_fpemu_return(sig, fault_addr))
 				mt_ase_fp_affinity();
 		}
 
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 47842b7..452a6aa 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -64,7 +64,7 @@ static int fpu_emu(struct pt_regs *, struct mips_fpu_struct *,
 
 #if __mips >= 4 && __mips != 32
 static int fpux_emu(struct pt_regs *,
-	struct mips_fpu_struct *, mips_instruction);
+	struct mips_fpu_struct *, mips_instruction, void *__user *);
 #endif
 
 /* Further private data for which no space exists in mips_fpu_struct */
@@ -208,16 +208,23 @@ static inline int cop1_64bit(struct pt_regs *xcp)
  * Two instructions if the instruction is in a branch delay slot.
  */
 
-static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
+static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
+		       void *__user *fault_addr)
 {
 	mips_instruction ir;
 	unsigned long emulpc, contpc;
 	unsigned int cond;
 
-	if (get_user(ir, (mips_instruction __user *) xcp->cp0_epc)) {
+	if (!access_ok(VERIFY_READ, xcp->cp0_epc, sizeof(mips_instruction))) {
 		MIPS_FPU_EMU_INC_STATS(errors);
+		*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
 		return SIGBUS;
 	}
+	if (__get_user(ir, (mips_instruction __user *) xcp->cp0_epc)) {
+		MIPS_FPU_EMU_INC_STATS(errors);
+		*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
+		return SIGSEGV;
+	}
 
 	/* XXX NEC Vr54xx bug workaround */
 	if ((xcp->cp0_cause & CAUSEF_BD) && !isBranchInstr(&ir))
@@ -245,10 +252,16 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 #endif
 			return SIGILL;
 		}
-		if (get_user(ir, (mips_instruction __user *) emulpc)) {
+		if (!access_ok(VERIFY_READ, emulpc, sizeof(mips_instruction))) {
 			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = (mips_instruction __user *)emulpc;
 			return SIGBUS;
 		}
+		if (__get_user(ir, (mips_instruction __user *) emulpc)) {
+			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = (mips_instruction __user *)emulpc;
+			return SIGSEGV;
+		}
 		/* __compute_return_epc() will have updated cp0_epc */
 		contpc = xcp->cp0_epc;
 		/* In order not to confuse ptrace() et al, tweak context */
@@ -267,10 +280,17 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 		u64 val;
 
 		MIPS_FPU_EMU_INC_STATS(loads);
-		if (get_user(val, va)) {
+
+		if (!access_ok(VERIFY_READ, va, sizeof(u64))) {
 			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = va;
 			return SIGBUS;
 		}
+		if (__get_user(val, va)) {
+			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = va;
+			return SIGSEGV;
+		}
 		DITOREG(val, MIPSInst_RT(ir));
 		break;
 	}
@@ -282,10 +302,16 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 
 		MIPS_FPU_EMU_INC_STATS(stores);
 		DIFROMREG(val, MIPSInst_RT(ir));
-		if (put_user(val, va)) {
+		if (!access_ok(VERIFY_WRITE, va, sizeof(u64))) {
 			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = va;
 			return SIGBUS;
 		}
+		if (__put_user(val, va)) {
+			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = va;
+			return SIGSEGV;
+		}
 		break;
 	}
 
@@ -295,10 +321,16 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 		u32 val;
 
 		MIPS_FPU_EMU_INC_STATS(loads);
-		if (get_user(val, va)) {
+		if (!access_ok(VERIFY_READ, va, sizeof(u32))) {
 			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = va;
 			return SIGBUS;
 		}
+		if (__get_user(val, va)) {
+			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = va;
+			return SIGSEGV;
+		}
 		SITOREG(val, MIPSInst_RT(ir));
 		break;
 	}
@@ -310,10 +342,16 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 
 		MIPS_FPU_EMU_INC_STATS(stores);
 		SIFROMREG(val, MIPSInst_RT(ir));
-		if (put_user(val, va)) {
+		if (!access_ok(VERIFY_WRITE, va, sizeof(u32))) {
 			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = va;
 			return SIGBUS;
 		}
+		if (__put_user(val, va)) {
+			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = va;
+			return SIGSEGV;
+		}
 		break;
 	}
 
@@ -438,11 +476,18 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 				contpc = (xcp->cp0_epc +
 					(MIPSInst_SIMM(ir) << 2));
 
-				if (get_user(ir,
-				    (mips_instruction __user *) xcp->cp0_epc)) {
+				if (!access_ok(VERIFY_READ, xcp->cp0_epc,
+					       sizeof(mips_instruction))) {
 					MIPS_FPU_EMU_INC_STATS(errors);
+					*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
 					return SIGBUS;
 				}
+				if (__get_user(ir,
+				    (mips_instruction __user *) xcp->cp0_epc)) {
+					MIPS_FPU_EMU_INC_STATS(errors);
+					*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
+					return SIGSEGV;
+				}
 
 				switch (MIPSInst_OPCODE(ir)) {
 				case lwc1_op:
@@ -504,9 +549,8 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 
 #if __mips >= 4 && __mips != 32
 	case cop1x_op:{
-		int sig;
-
-		if ((sig = fpux_emu(xcp, ctx, ir)))
+		int sig = fpux_emu(xcp, ctx, ir, fault_addr);
+		if (sig)
 			return sig;
 		break;
 	}
@@ -602,7 +646,7 @@ DEF3OP(nmadd, dp, ieee754dp_mul, ieee754dp_add, ieee754dp_neg);
 DEF3OP(nmsub, dp, ieee754dp_mul, ieee754dp_sub, ieee754dp_neg);
 
 static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
-	mips_instruction ir)
+	mips_instruction ir, void *__user *fault_addr)
 {
 	unsigned rcsr = 0;	/* resulting csr */
 
@@ -622,10 +666,16 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				xcp->regs[MIPSInst_FT(ir)]);
 
 			MIPS_FPU_EMU_INC_STATS(loads);
-			if (get_user(val, va)) {
+			if (!access_ok(VERIFY_READ, va, sizeof(u32))) {
 				MIPS_FPU_EMU_INC_STATS(errors);
+				*fault_addr = va;
 				return SIGBUS;
 			}
+			if (__get_user(val, va)) {
+				MIPS_FPU_EMU_INC_STATS(errors);
+				*fault_addr = va;
+				return SIGSEGV;
+			}
 			SITOREG(val, MIPSInst_FD(ir));
 			break;
 
@@ -636,10 +686,16 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			MIPS_FPU_EMU_INC_STATS(stores);
 
 			SIFROMREG(val, MIPSInst_FS(ir));
-			if (put_user(val, va)) {
+			if (!access_ok(VERIFY_WRITE, va, sizeof(u32))) {
 				MIPS_FPU_EMU_INC_STATS(errors);
+				*fault_addr = va;
 				return SIGBUS;
 			}
+			if (put_user(val, va)) {
+				MIPS_FPU_EMU_INC_STATS(errors);
+				*fault_addr = va;
+				return SIGSEGV;
+			}
 			break;
 
 		case madd_s_op:
@@ -699,10 +755,16 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				xcp->regs[MIPSInst_FT(ir)]);
 
 			MIPS_FPU_EMU_INC_STATS(loads);
-			if (get_user(val, va)) {
+			if (!access_ok(VERIFY_READ, va, sizeof(u64))) {
 				MIPS_FPU_EMU_INC_STATS(errors);
+				*fault_addr = va;
 				return SIGBUS;
 			}
+			if (__get_user(val, va)) {
+				MIPS_FPU_EMU_INC_STATS(errors);
+				*fault_addr = va;
+				return SIGSEGV;
+			}
 			DITOREG(val, MIPSInst_FD(ir));
 			break;
 
@@ -712,10 +774,16 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 
 			MIPS_FPU_EMU_INC_STATS(stores);
 			DIFROMREG(val, MIPSInst_FS(ir));
-			if (put_user(val, va)) {
+			if (!access_ok(VERIFY_WRITE, va, sizeof(u64))) {
 				MIPS_FPU_EMU_INC_STATS(errors);
+				*fault_addr = va;
 				return SIGBUS;
 			}
+			if (__put_user(val, va)) {
+				MIPS_FPU_EMU_INC_STATS(errors);
+				*fault_addr = va;
+				return SIGSEGV;
+			}
 			break;
 
 		case madd_d_op:
@@ -1240,7 +1308,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 }
 
 int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
-	int has_fpu)
+	int has_fpu, void *__user *fault_addr)
 {
 	unsigned long oldepc, prevepc;
 	mips_instruction insn;
@@ -1250,10 +1318,16 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	do {
 		prevepc = xcp->cp0_epc;
 
-		if (get_user(insn, (mips_instruction __user *) xcp->cp0_epc)) {
+		if (!access_ok(VERIFY_READ, xcp->cp0_epc, sizeof(mips_instruction))) {
 			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
 			return SIGBUS;
 		}
+		if (__get_user(insn, (mips_instruction __user *) xcp->cp0_epc)) {
+			MIPS_FPU_EMU_INC_STATS(errors);
+			*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
+			return SIGSEGV;
+		}
 		if (insn == 0)
 			xcp->cp0_epc += 4;	/* skip nops */
 		else {
@@ -1265,7 +1339,7 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			 */
 			/* convert to ieee library modes */
 			ieee754_csr.rm = ieee_rm[ieee754_csr.rm];
-			sig = cop1Emulate(xcp, ctx);
+			sig = cop1Emulate(xcp, ctx, fault_addr);
 			/* revert to mips rounding mode */
 			ieee754_csr.rm = mips_rm[ieee754_csr.rm];
 		}
-- 
1.7.2.3
