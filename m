Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2004 16:34:18 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:53722 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225281AbUJXPeM>; Sun, 24 Oct 2004 16:34:12 +0100
Received: from localhost (p4005-ipad02funabasi.chiba.ocn.ne.jp [61.207.151.5])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0FA191178; Mon, 25 Oct 2004 00:34:09 +0900 (JST)
Date: Mon, 25 Oct 2004 00:36:19 +0900 (JST)
Message-Id: <20041025.003619.92586674.anemo@mba.ocn.ne.jp>
To: jsun@junsun.net
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: fpu_emulator can lose fpu on get_user/put_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041012.191154.90115222.nemoto@toshiba-tops.co.jp>
	<20041009.233810.74756865.anemo@mba.ocn.ne.jp>
References: <20041009.233810.74756865.anemo@mba.ocn.ne.jp>
	<20041011165424.GA28667@gateway.junsun.net>
	<20041012.191154.90115222.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 6194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sat, 09 Oct 2004 23:38:10 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> And here is a revised patch.  It fixes:
anemo> * FPU ownership lost in math-emu.
anemo> 	(revised fix of "Wed, 06 Oct 2004 10:19:20 +0900 (JST)" patch)
anemo> * ieee754_csr corruption by re-entrance of math-emu.
anemo> 	(from "Wed, 06 Oct 2004 18:40:14 +0900 (JST)" patch)
anemo> * FPU ownership lost in setup/restore sigcontext.
anemo> 	(from "Thu, 07 Oct 2004 15:20:17 +0900 (JST)" patch)
anemo> * preemption during middle of FPU manipulation. (for preemptable kernel)
anemo> 	(derived from 030304-b.preempt-mips.patch)

Again, here is a revised patch (against CVS which include some
preemption fixes now)

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
--- linux-mips-cvs/arch/mips/kernel/signal.c	Sun Oct 24 23:36:08 2004
+++ linux-mips/arch/mips/kernel/signal.c	Sun Oct 24 23:43:36 2004
@@ -181,14 +181,19 @@
 
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
-	preempt_disable();
-
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
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
+		preempt_disable();
 		lose_fpu();
 	}
 
@@ -295,6 +300,7 @@
 inline int setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
 	int err = 0;
+	struct sigcontext tmpsc;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 	err |= __put_user(regs->cp0_status, &sc->sc_status);
@@ -333,9 +339,15 @@
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context(sc);
+	/* make sure save_fp_context not sleep */
+	err |= save_fp_context(&tmpsc);
 
 	preempt_enable();
+
+	err |= __copy_to_user(&sc->sc_fpregs, &tmpsc.sc_fpregs,
+			      sizeof(tmpsc.sc_fpregs));
+	err |= __put_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+	err |= __put_user(tmpsc.sc_fpc_eir, &sc->sc_fpc_eir);
 
 out:
 	return err;
diff -ur linux-mips-cvs/arch/mips/kernel/signal32.c linux-mips/arch/mips/kernel/signal32.c
--- linux-mips-cvs/arch/mips/kernel/signal32.c	Sun Oct 24 23:36:09 2004
+++ linux-mips/arch/mips/kernel/signal32.c	Sun Oct 24 23:43:30 2004
@@ -364,14 +364,19 @@
 
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
-	preempt_disable();
-
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
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
+		preempt_disable();
 		lose_fpu();
 	}
 
@@ -530,6 +535,7 @@
 				     struct sigcontext32 *sc)
 {
 	int err = 0;
+	struct sigcontext32 tmpsc;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 	err |= __put_user(regs->cp0_status, &sc->sc_status);
@@ -568,9 +574,15 @@
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context32(sc);
+	/* make sure save_fp_context32 not sleep */
+	err |= save_fp_context32(&tmpsc);
 
 	preempt_enable();
+
+	err |= __copy_to_user(&sc->sc_fpregs, &tmpsc.sc_fpregs,
+			      sizeof(tmpsc.sc_fpregs));
+	err |= __put_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+	err |= __put_user(tmpsc.sc_fpc_eir, &sc->sc_fpc_eir);
 
 out:
 	return err;
diff -ur linux-mips-cvs/arch/mips/kernel/traps.c linux-mips/arch/mips/kernel/traps.c
--- linux-mips-cvs/arch/mips/kernel/traps.c	Sun Oct 24 23:36:09 2004
+++ linux-mips/arch/mips/kernel/traps.c	Sun Oct 24 23:47:04 2004
@@ -506,6 +506,14 @@
 
 		preempt_disable();
 
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
@@ -517,10 +525,13 @@
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
