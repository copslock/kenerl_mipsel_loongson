Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2003 17:59:49 +0100 (BST)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:19977 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225226AbTGNQ7r>; Mon, 14 Jul 2003 17:59:47 +0100
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.2)); Mon, 14 Jul 2003 09:59:15 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id JAA12570 for <linux-mips@linux-mips.org>; Mon, 14 Jul 2003 09:48:35
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 h6EGmwov019430 for <linux-mips@linux-mips.org>; Mon, 14 Jul 2003 09:48:
 59 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id JAA00965 for
 <linux-mips@linux-mips.org>; Mon, 14 Jul 2003 09:48:58 -0700
Message-ID: <3F12DEFA.5668FC4@broadcom.com>
Date: Mon, 14 Jul 2003 09:48:58 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [PATCH] o32 sigcontext fixes for mips64
X-WSS-ID: 130C3E852077323-262-01
Content-Type: multipart/mixed;
 boundary=------------920406A1B4583B8D856B46BD
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------920406A1B4583B8D856B46BD
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit


This 2.4 patch fixes some issues with the signal context save and
restore for o32 binaries running on the mips64 kernel.

Any comments?

Kip
--------------920406A1B4583B8D856B46BD
Content-Type: text/plain;
 charset=us-ascii;
 name=o32_sigcontext.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=o32_sigcontext.diff

Index: include/asm-mips64/fpu.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/fpu.h,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 fpu.h
--- include/asm-mips64/fpu.h	9 Apr 2003 00:46:24 -0000	1.1.2.4
+++ include/asm-mips64/fpu.h	14 Jul 2003 16:45:05 -0000
@@ -21,9 +21,13 @@
 #include <asm/current.h>
 
 struct sigcontext;
+struct sigcontext32;
 
 extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
 extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
+
+extern asmlinkage int (*save_fp_context32)(struct sigcontext32 *sc);
+extern asmlinkage int (*restore_fp_context32)(struct sigcontext32 *sc);
 
 extern void fpu_emulator_init_fpu(void);
 extern void _init_fpu(void);
Index: include/asm-mips64/sigcontext.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/sigcontext.h,v
retrieving revision 1.3.2.2
diff -u -r1.3.2.2 sigcontext.h
--- include/asm-mips64/sigcontext.h	4 Nov 2002 19:39:56 -0000	1.3.2.2
+++ include/asm-mips64/sigcontext.h	14 Jul 2003 16:45:05 -0000
@@ -27,4 +27,24 @@
 	unsigned int       sc_badvaddr;
 };
 
+struct sigcontext32 {
+	u32 sc_regmask;		/* Unused */
+	u32 sc_status;
+	u64 sc_pc;
+	u64 sc_regs[32];
+	u64 sc_fpregs[32];
+	u32 sc_ownedfp;		/* Unused */
+	u32 sc_fpc_csr;
+	u32 sc_fpc_eir;		/* Unused */
+	u32 sc_used_math;
+	u32 sc_ssflags;		/* Unused */
+	u64 sc_mdhi;
+	u64 sc_mdlo;
+
+	u32 sc_cause;		/* Unused */
+	u32 sc_badvaddr;	/* Unused */
+
+	u32 sc_sigset[4];	/* kernel's sigset_t */
+};
+
 #endif /* _ASM_SIGCONTEXT_H */
Index: arch/mips/tools/offset.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/tools/Attic/offset.c,v
retrieving revision 1.16.4.6
diff -u -r1.16.4.6 offset.c
--- arch/mips/tools/offset.c	4 Nov 2002 19:39:56 -0000	1.16.4.6
+++ arch/mips/tools/offset.c	14 Jul 2003 16:45:05 -0000
@@ -8,6 +8,7 @@
  * Kevin Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000 MIPS Technologies, Inc.
  */
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -156,6 +157,14 @@
 	offset("#define SC_CAUSE      ", struct sigcontext, sc_cause);
 	offset("#define SC_BADVADDR   ", struct sigcontext, sc_badvaddr);
 	linefeed;
+
+#ifdef CONFIG_MIPS64
+	text("/* Linux 32-bit sigcontext offsets. */");
+	offset("#define SC32_FPREGS     ", struct sigcontext32, sc_fpregs);
+	offset("#define SC32_FPC_CSR    ", struct sigcontext32, sc_fpc_csr);
+	offset("#define SC32_FPC_EIR    ", struct sigcontext32, sc_fpc_eir);
+	linefeed;
+#endif
 }
 
 void output_signal_defined(void)
Index: arch/mips64/kernel/signal32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/signal32.c,v
retrieving revision 1.20.2.12
diff -u -r1.20.2.12 signal32.c
--- arch/mips64/kernel/signal32.c	12 Mar 2003 15:44:06 -0000	1.20.2.12
+++ arch/mips64/kernel/signal32.c	14 Jul 2003 16:45:06 -0000
@@ -60,6 +60,14 @@
 	int ss_flags;
 } stack32_t;
 
+struct ucontext32 {
+	u32                 uc_flags;
+	s32                 uc_link;
+	stack32_t           uc_stack;
+	struct sigcontext32 uc_mcontext;
+	sigset_t32          uc_sigmask;   /* mask last for extensibility */
+};
+
 extern void __put_sigset_unknown_nsig(void);
 extern void __get_sigset_unknown_nsig(void);
 
@@ -250,8 +258,8 @@
 	return ret;
 }
 
-static asmlinkage int restore_sigcontext(struct pt_regs *regs,
-					 struct sigcontext *sc)
+static asmlinkage int restore_sigcontext32(struct pt_regs *regs,
+					   struct sigcontext32 *sc)
 {
 	int err = 0;
 
@@ -280,7 +288,7 @@
 	if (current->used_math) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context(sc);
+		err |= restore_fp_context32(sc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		loose_fpu();
@@ -292,7 +300,7 @@
 struct sigframe {
 	u32 sf_ass[4];			/* argument save space for o32 */
 	u32 sf_code[2];			/* signal trampoline */
-	struct sigcontext sf_sc;
+	struct sigcontext32 sf_sc;
 	sigset_t sf_mask;
 };
 
@@ -300,7 +308,7 @@
 	u32 rs_ass[4];			/* argument save space for o32 */
 	u32 rs_code[2];			/* signal trampoline */
 	struct siginfo32 rs_info;
-	struct ucontext rs_uc;
+	struct ucontext32 rs_uc;
 };
 
 static int copy_siginfo_to_user32(siginfo_t32 *to, siginfo_t *from)
@@ -362,7 +370,7 @@
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	if (restore_sigcontext(&regs, &frame->sf_sc))
+	if (restore_sigcontext32(&regs, &frame->sf_sc))
 		goto badframe;
 
 	/*
@@ -386,6 +394,7 @@
 	struct rt_sigframe32 *frame;
 	sigset_t set;
 	stack_t st;
+	s32 sp;
 
 	frame = (struct rt_sigframe32 *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -399,11 +408,18 @@
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	if (restore_sigcontext(&regs, &frame->rs_uc.uc_mcontext))
+	if (restore_sigcontext32(&regs, &frame->rs_uc.uc_mcontext))
 		goto badframe;
 
-	if (__copy_from_user(&st, &frame->rs_uc.uc_stack, sizeof(st)))
+	/* The ucontext contains a stack32_t, so we must convert!  */
+	if (__get_user(sp, &frame->rs_uc.uc_stack.ss_sp))
+		goto badframe;
+	st.ss_size = (long) sp;
+	if (__get_user(st.ss_size, &frame->rs_uc.uc_stack.ss_size))
 		goto badframe;
+	if (__get_user(st.ss_flags, &frame->rs_uc.uc_stack.ss_flags))
+		goto badframe;
+
 	/* It is more difficult to avoid calling this function than to
 	   call it and ignore errors.  */
 	do_sigaltstack(&st, NULL, regs.regs[29]);
@@ -422,8 +438,8 @@
 	force_sig(SIGSEGV, current);
 }
 
-static int inline setup_sigcontext(struct pt_regs *regs,
-				   struct sigcontext *sc)
+static int inline setup_sigcontext32(struct pt_regs *regs,
+				     struct sigcontext32 *sc)
 {
 	int err = 0;
 
@@ -462,7 +478,7 @@
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context(sc);
+	err |= save_fp_context32(sc);
 
 out:
 	return err;
@@ -513,7 +529,7 @@
 	err |= __put_user(0x0000000c                     , frame->sf_code + 1);
 	flush_cache_sigtramp((unsigned long) frame->sf_code);
 
-	err |= setup_sigcontext(regs, &frame->sf_sc);
+	err |= setup_sigcontext32(regs, &frame->sf_sc);
 	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
 	if (err)
 		goto give_sigsegv;
@@ -554,6 +570,7 @@
 {
 	struct rt_sigframe32 *frame;
 	int err = 0;
+	s32 sp;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
@@ -577,13 +594,14 @@
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->rs_uc.uc_flags);
 	err |= __put_user(0, &frame->rs_uc.uc_link);
-	err |= __put_user((void *)current->sas_ss_sp,
+	sp = (int) (long) current->sas_ss_sp;
+	err |= __put_user(sp,
 	                  &frame->rs_uc.uc_stack.ss_sp);
 	err |= __put_user(sas_ss_flags(regs->regs[29]),
 	                  &frame->rs_uc.uc_stack.ss_flags);
 	err |= __put_user(current->sas_ss_size,
 	                  &frame->rs_uc.uc_stack.ss_size);
-	err |= setup_sigcontext(regs, &frame->rs_uc.uc_mcontext);
+	err |= setup_sigcontext32(regs, &frame->rs_uc.uc_mcontext);
 	err |= __copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set));
 
 	if (err)
Index: arch/mips64/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/traps.c,v
retrieving revision 1.30.2.54
diff -u -r1.30.2.54 traps.c
--- arch/mips64/kernel/traps.c	6 Jun 2003 04:36:37 -0000	1.30.2.54
+++ arch/mips64/kernel/traps.c	14 Jul 2003 16:45:06 -0000
@@ -781,12 +781,21 @@
 asmlinkage int (*save_fp_context)(struct sigcontext *sc);
 asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
 
+asmlinkage int (*save_fp_context32)(struct sigcontext32 *sc);
+asmlinkage int (*restore_fp_context32)(struct sigcontext32 *sc);
+
 extern asmlinkage int _save_fp_context(struct sigcontext *sc);
 extern asmlinkage int _restore_fp_context(struct sigcontext *sc);
 
+extern asmlinkage int _save_fp_context32(struct sigcontext32 *sc);
+extern asmlinkage int _restore_fp_context32(struct sigcontext32 *sc);
+
 extern asmlinkage int fpu_emulator_save_context(struct sigcontext *sc);
 extern asmlinkage int fpu_emulator_restore_context(struct sigcontext *sc);
 
+extern asmlinkage int fpu_emulator_save_context32(struct sigcontext32 *sc);
+extern asmlinkage int fpu_emulator_restore_context32(struct sigcontext32 *sc);
+
 void __init per_cpu_trap_init(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -904,9 +913,13 @@
 	if (cpu_has_fpu) {
 	        save_fp_context = _save_fp_context;
 		restore_fp_context = _restore_fp_context;
+	        save_fp_context32 = _save_fp_context32;
+		restore_fp_context32 = _restore_fp_context32;
 	} else {
 		save_fp_context = fpu_emulator_save_context;
 		restore_fp_context = fpu_emulator_restore_context;
+		save_fp_context32 = fpu_emulator_save_context32;
+		restore_fp_context32 = fpu_emulator_restore_context32;
 	}
 
 	flush_icache_range(KSEG0, KSEG0 + 0x400);
Index: arch/mips64/kernel/r4k_fpu.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/r4k_fpu.S,v
retrieving revision 1.3.2.1
diff -u -r1.3.2.1 r4k_fpu.S
--- arch/mips64/kernel/r4k_fpu.S	31 Jul 2002 02:41:21 -0000	1.3.2.1
+++ arch/mips64/kernel/r4k_fpu.S	14 Jul 2003 16:45:06 -0000
@@ -5,6 +5,8 @@
  *
  * Save/restore floating point context for signal handlers.
  *
+ * Copyright (C) 2003 Broadcom Corporation
+ *
  * Copyright (C) 1996, 1998, 1999, 2001 by Ralf Baechle
  *
  * Multi-arch abstraction and asm macros for easier reading:
@@ -32,11 +34,8 @@
 	.set	noreorder
 	/* Save floating point context */
 LEAF(_save_fp_context)
-	mfc0	t1, CP0_STATUS
-	sll	t2, t1,5
+	cfc1	t1, fcr31
 
-	bgez	t2, 1f
-	 cfc1	t1, fcr31
 	/* Store the 16 odd double precision registers */
 	EX	sdc1 $f1, SC_FPREGS+8(a0)
 	EX	sdc1 $f3, SC_FPREGS+24(a0)
@@ -56,7 +55,6 @@
 	EX	sdc1 $f31, SC_FPREGS+248(a0)
 
 	/* Store the 16 even double precision registers */
-1:
 	EX	sdc1 $f0, SC_FPREGS+0(a0)
 	EX	sdc1 $f2, SC_FPREGS+16(a0)
 	EX	sdc1 $f4, SC_FPREGS+32(a0)
@@ -81,24 +79,42 @@
 	 li	v0, 0					# success
 	END(_save_fp_context)
 
+	/* Save 32-bit process floating point context */
+LEAF(_save_fp_context32)
+	cfc1	t1, fcr31
+
+	EX	sdc1 $f0, SC32_FPREGS+0(a0)
+	EX	sdc1 $f2, SC32_FPREGS+16(a0)
+	EX	sdc1 $f4, SC32_FPREGS+32(a0)
+	EX	sdc1 $f6, SC32_FPREGS+48(a0)
+	EX	sdc1 $f8, SC32_FPREGS+64(a0)
+	EX	sdc1 $f10, SC32_FPREGS+80(a0)
+	EX	sdc1 $f12, SC32_FPREGS+96(a0)
+	EX	sdc1 $f14, SC32_FPREGS+112(a0)
+	EX	sdc1 $f16, SC32_FPREGS+128(a0)
+	EX	sdc1 $f18, SC32_FPREGS+144(a0)
+	EX	sdc1 $f20, SC32_FPREGS+160(a0)
+	EX	sdc1 $f22, SC32_FPREGS+176(a0)
+	EX	sdc1 $f24, SC32_FPREGS+192(a0)
+	EX	sdc1 $f26, SC32_FPREGS+208(a0)
+	EX	sdc1 $f28, SC32_FPREGS+224(a0)
+	EX	sdc1 $f30, SC32_FPREGS+240(a0)
+	EX	sw t1, SC32_FPC_CSR(a0)
+	cfc1	t0, $0				# implementation/version
+	EX	sw t0, SC32_FPC_EIR(a0)
+
+	jr	ra
+	 li	v0, 0					# success
+	END(_save_fp_context32)
+
 /*
  * Restore FPU state:
  *  - fp gp registers
  *  - cp1 status/control register
- *
- * We base the decision which registers to restore from the signal stack
- * frame on the current content of c0_status, not on the content of the
- * stack frame which might have been changed by the user.
  */
 LEAF(_restore_fp_context)
-	mfc0	t1, CP0_STATUS
-	sll	t0, t1,5
-	bgez	t0, 1f
-	 EX	lw t0, SC_FPC_CSR(a0)
-
-	/* Restore the 16 odd double precision registers only
-	 * when enabled in the cp0 status register.
-	 */
+	/* Restore an o32/64 sigcontext. */
+	EX	lw t0, SC_FPC_CSR(a0)
 	EX	ldc1 $f1, SC_FPREGS+8(a0)
 	EX	ldc1 $f3, SC_FPREGS+24(a0)
 	EX	ldc1 $f5, SC_FPREGS+40(a0)
@@ -116,11 +132,7 @@
 	EX	ldc1 $f29, SC_FPREGS+232(a0)
 	EX	ldc1 $f31, SC_FPREGS+248(a0)
 
-	/*
-	 * Restore the 16 even double precision registers
-	 * when cp1 was enabled in the cp0 status register.
-	 */
-1:	EX	ldc1 $f0, SC_FPREGS+0(a0)
+	EX	ldc1 $f0, SC_FPREGS+0(a0)
 	EX	ldc1 $f2, SC_FPREGS+16(a0)
 	EX	ldc1 $f4, SC_FPREGS+32(a0)
 	EX	ldc1 $f6, SC_FPREGS+48(a0)
@@ -140,6 +152,30 @@
 	jr	ra
 	 li	v0, 0					# success
 	END(_restore_fp_context)
+
+LEAF(_restore_fp_context32)
+	/* Restore an o32 sigcontext.  */
+	EX	lw t0, SC32_FPC_CSR(a0)
+	EX	ldc1 $f0, SC32_FPREGS+0(a0)
+	EX	ldc1 $f2, SC32_FPREGS+16(a0)
+	EX	ldc1 $f4, SC32_FPREGS+32(a0)
+	EX	ldc1 $f6, SC32_FPREGS+48(a0)
+	EX	ldc1 $f8, SC32_FPREGS+64(a0)
+	EX	ldc1 $f10, SC32_FPREGS+80(a0)
+	EX	ldc1 $f12, SC32_FPREGS+96(a0)
+	EX	ldc1 $f14, SC32_FPREGS+112(a0)
+	EX	ldc1 $f16, SC32_FPREGS+128(a0)
+	EX	ldc1 $f18, SC32_FPREGS+144(a0)
+	EX	ldc1 $f20, SC32_FPREGS+160(a0)
+	EX	ldc1 $f22, SC32_FPREGS+176(a0)
+	EX	ldc1 $f24, SC32_FPREGS+192(a0)
+	EX	ldc1 $f26, SC32_FPREGS+208(a0)
+	EX	ldc1 $f28, SC32_FPREGS+224(a0)
+	EX	ldc1 $f30, SC32_FPREGS+240(a0)
+	ctc1	t0, fcr31
+	jr	ra
+	 li	v0, 0					# success
+	END(_restore_fp_context32)
 
 	.type	fault@function
 	.ent	fault
Index: arch/mips/math-emu/kernel_linkage.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/math-emu/kernel_linkage.c,v
retrieving revision 1.5.2.1
diff -u -r1.5.2.1 kernel_linkage.c
--- arch/mips/math-emu/kernel_linkage.c	5 Aug 2002 23:53:34 -0000	1.5.2.1
+++ arch/mips/math-emu/kernel_linkage.c	14 Jul 2003 16:45:06 -0000
@@ -90,3 +90,40 @@
 	return err;
 }
 
+#ifdef CONFIG_MIPS64
+/*
+ * This is the o32 version
+ */
+
+int fpu_emulator_save_context32(struct sigcontext32 *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i+=2) {
+		err |=
+		    __put_user(current->thread.fpu.soft.regs[i],
+			       &sc->sc_fpregs[i]);
+	}
+	err |= __put_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
+	err |= __put_user(fpuemuprivate.eir, &sc->sc_fpc_eir);
+
+	return err;
+}
+
+int fpu_emulator_restore_context32(struct sigcontext32 *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i+=2) {
+		err |=
+		    __get_user(current->thread.fpu.soft.regs[i],
+			       &sc->sc_fpregs[i]);
+	}
+	err |= __get_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
+	err |= __get_user(fpuemuprivate.eir, &sc->sc_fpc_eir);
+
+	return err;
+}
+#endif

--------------920406A1B4583B8D856B46BD--
