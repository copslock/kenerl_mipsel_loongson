Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Oct 2004 15:27:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:4817 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225240AbUJIO13>; Sat, 9 Oct 2004 15:27:29 +0100
Received: from localhost (p7219-ipad11funabasi.chiba.ocn.ne.jp [219.162.42.219])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0C7488EF0; Sat,  9 Oct 2004 23:27:25 +0900 (JST)
Date: Sat, 09 Oct 2004 23:38:10 +0900 (JST)
Message-Id: <20041009.233810.74756865.anemo@mba.ocn.ne.jp>
To: jsun@junsun.net
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: fpu_emulator can lose fpu on get_user/put_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041008194514.GB31533@gateway.junsun.net>
References: <20041006220936.GA21135@gateway.junsun.net>
	<20041007.101558.126571743.nemoto@toshiba-tops.co.jp>
	<20041008194514.GB31533@gateway.junsun.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 8 Oct 2004 12:45:14 -0700, Jun Sun <jsun@junsun.net> said:

jsun> This problem is apparently bigger than I thought.

Yes, I agree too!

jsun> Preemption in the middle FPU manipulation in kernel can cause
jsun> trouble to above assumptions but we can avoid it by using proper
jsun> disable_preemption and enable_preemption.

Yes, it is already done in 2.4 preempt-patch.  Applying them to 2.6 is
easy.

jsun> Now we basically face another trouble, i.e., put_user/get_user.

Yes.  And it is not only for preemptable kernel.  So "let's disable
CONFIG_PREEMPT for now" can not be workaround :-) And it affects 2.4
kernel also.

jsun> Maybe the easy way out is to allow FPU trap in kernel.  What do
jsun> you think?  The idea sounds dangerous but seems to be OK for the
jsun> suitations we are discussing here.

I suppose allowing FPU trap in kernel is too dangerous.  I'm not sure
it is really OK, and it will make the FPU management somewhat fragile.
In the past, the "lazy fpu switch" had some bugs which are very hard
to find and fix.  So I prefer simple and robust approach.

jsun> The other approach is basically your fix.  That is, if we are in
jsun> the middle of a block FPU manipulations, we ensure we have
jsun> consistent FPU state after each operation that could potentially
jsun> switch the current process out.

jsun> As to where should we put the "if (....) own_fpu()", I think it
jsun> should be put right after the operation we could be switched
jsun> out, i.e., get_user()/ put_user() in this case.

Hmm... in this case, we do NOT need any real FPU in the emulator.  We
need it to just before restoring FPU reg values from the emulator.
Obtaining FPU on each get_user/put_user seems to be overkill for me.
But this is just a style issue.

And I noticed that my previous patch is not complete.  If context
switch occur on get_user/put_user in fpu_emulator, 'resume' code will
overwrite the current fpu context again (which might be already
modified by fpu emulator).  Calling lose_fpu() explicitly before
calling the fpu emulator will fix this problem.  The fixed do_fpe
should be:

		save_fp(current);
		/* Ensure 'resume' not overwrite saved fp context again. */
		lose_fpu();

		/* Run the emulator */
		sig = fpu_emulator_cop1Handler (0, regs,
			&current->thread.fpu.soft);
		own_fpu();	/* Using the FPU again.  */

jsun> BTW, it is safe to disable preemption before calling anything
jsun> functions that could potentially block or switch current process
jsun> out.

It is safe?  get_user/put_user will fail if preempt disabled.  Excerpt
from do_page_fault:

	/*
	 * If we're in an interrupt or have no user
	 * context, we must not take the fault..
	 */
	if (in_atomic() || !mm)
		goto bad_area_nosemaphore;

And here is a revised patch.  It fixes:

* FPU ownership lost in math-emu.
	(revised fix of "Wed, 06 Oct 2004 10:19:20 +0900 (JST)" patch)
* ieee754_csr corruption by re-entrance of math-emu.
	(from "Wed, 06 Oct 2004 18:40:14 +0900 (JST)" patch)
* FPU ownership lost in setup/restore sigcontext.
	(from "Thu, 07 Oct 2004 15:20:17 +0900 (JST)" patch)
* preemption during middle of FPU manipulation. (for preemptable kernel)
	(derived from 030304-b.preempt-mips.patch)

Any comment are welcome.  Thank you.


diff -ur linux-mips-cvs/arch/mips/kernel/process.c linux-mips/arch/mips/kernel/process.c
--- linux-mips-cvs/arch/mips/kernel/process.c	Fri Sep 17 23:53:28 2004
+++ linux-mips/arch/mips/kernel/process.c	Sat Oct  9 22:19:40 2004
@@ -100,9 +100,11 @@
 
 	childksp = (unsigned long)ti + THREAD_SIZE - 32;
 
+	preempt_disable();
 	if (is_fpu_owner()) {
 		save_fp(p);
 	}
+	preempt_enable();
 
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
diff -ur linux-mips-cvs/arch/mips/kernel/ptrace.c linux-mips/arch/mips/kernel/ptrace.c
--- linux-mips-cvs/arch/mips/kernel/ptrace.c	Sun May  9 22:31:30 2004
+++ linux-mips/arch/mips/kernel/ptrace.c	Sat Oct  9 22:20:00 2004
@@ -167,10 +167,12 @@
 			if (!cpu_has_fpu)
 				break;
 
+			preempt_disable();
 			flags = read_c0_status();
 			__enable_fpu();
 			__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
 			write_c0_status(flags);
+			preempt_enable();
 			break;
 		}
 		default:
diff -ur linux-mips-cvs/arch/mips/kernel/ptrace32.c linux-mips/arch/mips/kernel/ptrace32.c
--- linux-mips-cvs/arch/mips/kernel/ptrace32.c	Mon Nov 24 20:21:44 2003
+++ linux-mips/arch/mips/kernel/ptrace32.c	Sat Oct  9 22:20:25 2004
@@ -155,10 +155,12 @@
 			if (!cpu_has_fpu)
 				break;
 
+			preempt_disable();
 			flags = read_c0_status();
 			__enable_fpu();
 			__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
 			write_c0_status(flags);
+			preempt_enable();
 			break;
 		}
 		default:
diff -ur linux-mips-cvs/arch/mips/kernel/signal.c linux-mips/arch/mips/kernel/signal.c
--- linux-mips-cvs/arch/mips/kernel/signal.c	Mon Sep 20 23:35:27 2004
+++ linux-mips/arch/mips/kernel/signal.c	Sat Oct  9 22:16:09 2004
@@ -182,12 +182,21 @@
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
 	if (current->used_math) {
+		/* make sure restore_fp_context not sleep */
+		struct sigcontext tmpsc;
+		err |= __copy_from_user(&tmpsc.sc_fpregs, &sc->sc_fpregs, sizeof(tmpsc.sc_fpregs));
+		err |= __get_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+		err |= __get_user(tmpsc.sc_fpc_eir, &sc->sc_fpc_eir);
+		preempt_disable();
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context(sc);
+		err |= restore_fp_context(&tmpsc);
+		preempt_enable();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
+		preempt_disable();
 		lose_fpu();
+		preempt_enable();
 	}
 
 	return err;
@@ -291,6 +300,7 @@
 inline int setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
 	int err = 0;
+	struct sigcontext tmpsc;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 	err |= __put_user(regs->cp0_status, &sc->sc_status);
@@ -319,6 +329,7 @@
 	if (!current->used_math)
 		goto out;
 
+	preempt_disable();
 	/*
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
@@ -327,7 +338,13 @@
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context(sc);
+	/* make sure save_fp_context not sleep */
+	err |= save_fp_context(&tmpsc);
+	preempt_enable();
+	err |= __copy_to_user(&sc->sc_fpregs, &tmpsc.sc_fpregs,
+			      sizeof(tmpsc.sc_fpregs));
+	err |= __put_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+	err |= __put_user(tmpsc.sc_fpc_eir, &sc->sc_fpc_eir);
 
 out:
 	return err;
diff -ur linux-mips-cvs/arch/mips/kernel/signal32.c linux-mips/arch/mips/kernel/signal32.c
--- linux-mips-cvs/arch/mips/kernel/signal32.c	Mon Sep 20 23:35:27 2004
+++ linux-mips/arch/mips/kernel/signal32.c	Sat Oct  9 22:17:18 2004
@@ -365,12 +365,21 @@
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
 	if (current->used_math) {
+		struct sigcontext32 tmpsc;
+		/* make sure restore_fp_context32 not sleep */
+		err |= __copy_from_user(&tmpsc.sc_fpregs, &sc->sc_fpregs, sizeof(tmpsc.sc_fpregs));
+		err |= __get_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+		err |= __get_user(tmpsc.sc_fpc_eir, &sc->sc_fpc_eir);
+		preempt_disable();
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context32(sc);
+		err |= restore_fp_context32(&tmpsc);
+		preempt_enable();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
+		preempt_disable();
 		lose_fpu();
+		preempt_enable();
 	}
 
 	return err;
@@ -526,6 +535,7 @@
 				     struct sigcontext32 *sc)
 {
 	int err = 0;
+	struct sigcontext32 tmpsc;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 	err |= __put_user(regs->cp0_status, &sc->sc_status);
@@ -554,6 +564,7 @@
 	if (!current->used_math)
 		goto out;
 
+	preempt_disable();
 	/* 
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
@@ -562,7 +573,13 @@
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context32(sc);
+	/* make sure save_fp_context32 not sleep */
+	err |= save_fp_context32(&tmpsc);
+	preempt_enable();
+	err |= __copy_to_user(&sc->sc_fpregs, &tmpsc.sc_fpregs,
+			      sizeof(tmpsc.sc_fpregs));
+	err |= __put_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+	err |= __put_user(tmpsc.sc_fpc_eir, &sc->sc_fpc_eir);
 
 out:
 	return err;
diff -ur linux-mips-cvs/arch/mips/kernel/traps.c linux-mips/arch/mips/kernel/traps.c
--- linux-mips-cvs/arch/mips/kernel/traps.c	Wed Jun 30 00:43:15 2004
+++ linux-mips/arch/mips/kernel/traps.c	Sat Oct  9 22:15:13 2004
@@ -494,6 +494,15 @@
 	if (fcr31 & FPU_CSR_UNI_X) {
 		int sig;
 
+		preempt_disable();
+#ifdef CONFIG_PREEMPT
+		if (!is_fpu_owner()) {
+			/* We might lose fpu before disabling preempt... */
+			own_fpu();
+			BUG_ON(!current->used_math);
+			restore_fp(current);
+		}
+#endif
 		/*
 	 	 * Unimplemented operation exception.  If we've got the full
 		 * software emulator on-board, let's use it...
@@ -505,10 +514,13 @@
 		 * a bit extreme for what should be an infrequent event.
 		 */
 		save_fp(current);
+		/* Ensure 'resume' not overwrite saved fp context again. */
+		lose_fpu();
 
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler (0, regs,
 			&current->thread.fpu.soft);
+		own_fpu();	/* Using the FPU again.  */
 
 		/*
 		 * We can't allow the emulated instruction to leave any of
@@ -518,6 +530,7 @@
 
 		/* Restore the hardware register state */
 		restore_fp(current);
+		preempt_enable();
 
 		/* If something went wrong, signal */
 		if (sig)
@@ -638,6 +651,7 @@
 		break;
 
 	case 1:
+		preempt_disable();
 		own_fpu();
 		if (current->used_math) {	/* Using the FPU again.  */
 			restore_fp(current);
@@ -652,6 +666,7 @@
 			if (sig)
 				force_sig(sig, current);
 		}
+		preempt_enable();
 
 		return;
 
diff -ur linux-mips-cvs/arch/mips/math-emu/cp1emu.c linux-mips/arch/mips/math-emu/cp1emu.c
--- linux-mips-cvs/arch/mips/math-emu/cp1emu.c	Sat Jul 31 21:27:26 2004
+++ linux-mips/arch/mips/math-emu/cp1emu.c	Sat Oct  9 22:23:23 2004
@@ -51,6 +51,28 @@
 #include "ieee754.h"
 #include "dsemul.h"
 
+#define math_put_user(x, ptr) \
+({ \
+	long math_pu_err; \
+	struct ieee754_csr pu_csr_save; \
+	pu_csr_save = ieee754_csr; \
+	preempt_enable(); \
+	math_pu_err = put_user(x, ptr); \
+	preempt_disable(); \
+	ieee754_csr = pu_csr_save; \
+	math_pu_err; \
+})
+#define math_get_user(x, ptr) \
+({ \
+	long math_gu_err; \
+	struct ieee754_csr gu_csr_save; \
+	gu_csr_save = ieee754_csr; \
+	preempt_enable(); \
+	math_gu_err = get_user(x, ptr); \
+	preempt_disable(); \
+	ieee754_csr = gu_csr_save; \
+	math_gu_err; \
+})
 /* Strap kernel emulator for full MIPS IV emulation */
 
 #ifdef __mips
@@ -199,7 +221,7 @@
 	vaddr_t emulpc, contpc;
 	unsigned int cond;
 
-	if (get_user(ir, (mips_instruction *) xcp->cp0_epc)) {
+	if (math_get_user(ir, (mips_instruction *) xcp->cp0_epc)) {
 		fpuemuprivate.stats.errors++;
 		return SIGBUS;
 	}
@@ -230,7 +252,7 @@
 #endif
 			return SIGILL;
 		}
-		if (get_user(ir, (mips_instruction *) emulpc)) {
+		if (math_get_user(ir, (mips_instruction *) emulpc)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -254,7 +276,7 @@
 		u64 val;
 
 		fpuemuprivate.stats.loads++;
-		if (get_user(val, va)) {
+		if (math_get_user(val, va)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -269,7 +291,7 @@
 
 		fpuemuprivate.stats.stores++;
 		DIFROMREG(val, MIPSInst_RT(ir));
-		if (put_user(val, va)) {
+		if (math_put_user(val, va)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -283,7 +305,7 @@
 		u32 val;
 
 		fpuemuprivate.stats.loads++;
-		if (get_user(val, va)) {
+		if (math_get_user(val, va)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -310,7 +332,7 @@
 		}
 #endif
 		SIFROMREG(val, MIPSInst_RT(ir));
-		if (put_user(val, va)) {
+		if (math_put_user(val, va)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -365,7 +387,11 @@
 			u32 value;
 
 			if (ir == CP1UNDEF) {
-				return do_dsemulret(xcp);
+				int ret;
+				preempt_enable();
+				ret = do_dsemulret(xcp);
+				preempt_disable();
+				return ret;
 			}
 			if (MIPSInst_RD(ir) == FPCREG_CSR) {
 				value = ctx->fcr31;
@@ -449,7 +475,7 @@
 					(xcp->cp0_epc +
 					(MIPSInst_SIMM(ir) << 2));
 
-				if (get_user(ir, (mips_instruction *)
+				if (math_get_user(ir, (mips_instruction *)
 						REG_TO_VA xcp->cp0_epc)) {
 					fpuemuprivate.stats.errors++;
 					return SIGBUS;
@@ -480,7 +506,13 @@
 				 * Single step the non-cp1
 				 * instruction in the dslot
 				 */
-				return mips_dsemul(xcp, ir, VA_TO_REG contpc);
+				{
+					int ret;
+					preempt_enable();
+					ret = mips_dsemul(xcp, ir, VA_TO_REG contpc);
+					preempt_disable();
+					return ret;
+				}
 			}
 			else {
 				/* branch not taken */
@@ -632,7 +664,7 @@
 				xcp->regs[MIPSInst_FT(ir)]);
 
 			fpuemuprivate.stats.loads++;
-			if (get_user(val, va)) {
+			if (math_get_user(val, va)) {
 				fpuemuprivate.stats.errors++;
 				return SIGBUS;
 			}
@@ -662,7 +694,7 @@
 #endif
 
 			SIFROMREG(val, MIPSInst_FS(ir));
-			if (put_user(val, va)) {
+			if (math_put_user(val, va)) {
 				fpuemuprivate.stats.errors++;
 				return SIGBUS;
 			}
@@ -728,7 +760,7 @@
 				xcp->regs[MIPSInst_FT(ir)]);
 
 			fpuemuprivate.stats.loads++;
-			if (get_user(val, va)) {
+			if (math_get_user(val, va)) {
 				fpuemuprivate.stats.errors++;
 				return SIGBUS;
 			}
@@ -741,7 +773,7 @@
 
 			fpuemuprivate.stats.stores++;
 			DIFROMREG(val, MIPSInst_FS(ir));
-			if (put_user(val, va)) {
+			if (math_put_user(val, va)) {
 				fpuemuprivate.stats.errors++;
 				return SIGBUS;
 			}
@@ -1290,7 +1322,7 @@
 	do {
 		prevepc = xcp->cp0_epc;
 
-		if (get_user(insn, (mips_instruction *) xcp->cp0_epc)) {
+		if (math_get_user(insn, (mips_instruction *) xcp->cp0_epc)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -1310,7 +1342,9 @@
 		if (sig)
 			break;
 
+		preempt_enable();
 		cond_resched();
+		preempt_disable();
 	} while (xcp->cp0_epc > prevepc);
 
 	/* SIGILL indicates a non-fpu instruction */
diff -ur linux-mips-cvs/include/asm-mips/fpu.h linux-mips/include/asm-mips/fpu.h
--- linux-mips-cvs/include/asm-mips/fpu.h	Fri Dec 19 23:54:16 2003
+++ linux-mips/include/asm-mips/fpu.h	Sat Oct  9 22:18:39 2004
@@ -127,8 +127,10 @@
 static inline fpureg_t *get_fpu_regs(struct task_struct *tsk)
 {
 	if (cpu_has_fpu) {
+		preempt_disable();
 		if ((tsk == current) && is_fpu_owner()) 
 			_save_fp(current);
+		preempt_enable();
 		return tsk->thread.fpu.hard.fpr;
 	}
 

---
Atsushi Nemoto
