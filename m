Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7FCsph12479
	for linux-mips-outgoing; Wed, 15 Aug 2001 05:54:51 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7FCsej12451
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 05:54:40 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA19040
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 05:54:33 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA22700
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 05:54:33 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7FCrCa23780
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 14:53:12 +0200 (MEST)
Message-ID: <3B7A70B8.ED92FE4@mips.com>
Date: Wed, 15 Aug 2001 14:53:12 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: FP emulator patch
Content-Type: multipart/mixed;
 boundary="------------B681E670EA042CA2391804E1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------B681E670EA042CA2391804E1
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

There has been some reports regarding FP emulator failures, which the
attached patch should solve.
The patch include a fix for emulation of instructions in a COP1
delay-slot, a fix for FP context switching and some additional stuff ,
which was needed to pass our torture test.

Ralf could you please apply this patch.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------B681E670EA042CA2391804E1
Content-Type: text/plain; charset=iso-8859-15;
 name="fp_emulator.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fp_emulator.patch"

Index: linux/arch/mips/kernel/signal.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.36
diff -u -r1.36 signal.c
--- linux/arch/mips/kernel/signal.c	2001/06/18 22:43:35	1.36
+++ linux/arch/mips/kernel/signal.c	2001/08/15 12:33:38
@@ -220,6 +220,8 @@
 
 	err |= __get_user(owned_fp, &sc->sc_ownedfp);
 	if (owned_fp) {
+		if (last_task_used_math && (last_task_used_math != current))
+			last_task_used_math->thread.cp0_status &= ~ST0_CU1;
 		err |= restore_fp_context(sc);
 		last_task_used_math = current;
 	}
@@ -353,12 +355,11 @@
 	owned_fp = (current == last_task_used_math);
 	err |= __put_user(owned_fp, &sc->sc_ownedfp);
 
-	if (current->used_math) {	/* fp is active.  */
+	if (owned_fp) { /* fp is active.  */
 		set_cp0_status(ST0_CU1);
 		err |= save_fp_context(sc);
 		last_task_used_math = NULL;
 		regs->cp0_status &= ~ST0_CU1;
-		current->used_math = 0;
 	}
 
 	return err;
@@ -375,6 +376,13 @@
 	/* Default to using normal stack */
 	sp = regs->regs[29];
 
+	/* 
+	 * FPU emulator may have it's own trampoline active just
+	 * above the user stack, 16-bytes before the next lowest
+	 * 16 byte boundary.  Try to avoid trashing it.
+	 */
+	sp -= 32;
+
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if ((ka->sa.sa_flags & SA_ONSTACK) && ! on_sig_stack(sp))
                 sp = current->sas_ss_sp + current->sas_ss_size;
@@ -435,7 +443,7 @@
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%p ra=0x%p\n",
-	       current->comm, current->pid, frame, regs->cp0_epc, frame->code);
+	       current->comm, current->pid, frame, regs->cp0_epc, frame->sf_code);
 #endif
         return;
 
Index: linux/arch/mips/kernel/unaligned.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/unaligned.c,v
retrieving revision 1.12
diff -u -r1.12 unaligned.c
--- linux/arch/mips/kernel/unaligned.c	2001/07/11 22:05:11	1.12
+++ linux/arch/mips/kernel/unaligned.c	2001/08/15 12:33:38
@@ -365,15 +365,12 @@
 		return;
 	}
 
-	die_if_kernel ("Unhandled kernel unaligned access", regs);
 	send_sig(SIGSEGV, current, 1);
 	return;
 sigbus:
-	die_if_kernel ("Unhandled kernel unaligned access", regs);
 	send_sig(SIGBUS, current, 1);
 	return;
 sigill:
-	die_if_kernel ("Unhandled kernel unaligned access or invalid instruction", regs);
 	send_sig(SIGILL, current, 1);
 	return;
 }
@@ -391,11 +388,10 @@
 	 * of the CPU after executing the instruction
 	 * in the delay slot of an emulated branch.
 	 */
+	/* Terminate if exception was recognized as a delay slot return */
+	if(do_dsemulret(regs)) return;
 
-	if ((unsigned long)regs->cp0_epc == current->thread.dsemul_aerpc) {
-		do_dsemulret(regs);
-		return;
-	}
+	/* Otherwise handle as normal */
 
 	/*
 	 * Did we catch a fault trying to load an instruction?
@@ -417,7 +413,6 @@
 	return;
 
 sigbus:
-	die_if_kernel ("Kernel unaligned instruction access", regs);
 	force_sig(SIGBUS, current);
 
 	return;
Index: linux/arch/mips/math-emu/cp1emu.c
===================================================================
RCS file: /cvs/linux/arch/mips/math-emu/cp1emu.c,v
retrieving revision 1.7
diff -u -r1.7 cp1emu.c
--- linux/arch/mips/math-emu/cp1emu.c	2001/08/02 21:55:26	1.7
+++ linux/arch/mips/math-emu/cp1emu.c	2001/08/15 12:33:38
@@ -6,7 +6,7 @@
  * http://www.algor.co.uk
  *
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000  MIPS Technologies, Inc.
+ * Copyright (C) 2000-2001  MIPS Technologies, Inc.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -273,7 +273,10 @@
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
+		/* __computer_return_epc() will have updated cp0_epc */
 		contpc = REG_TO_VA xcp->cp0_epc;
+		/* In order not to confuse ptrace() et al, tweak context */
+		xcp->cp0_epc = VA_TO_REG emulpc - 4;
 	} else {
 		emulpc = REG_TO_VA xcp->cp0_epc;
 		contpc = REG_TO_VA xcp->cp0_epc + 4;
@@ -753,29 +756,73 @@
  *  execution of delay-slot instruction execution.
  */
 
+* Instruction inserted following delay slot instruction to force trap */
+
+#define AdELOAD 0x8c000001     /* lw $0,1($0) */
+
+/* Instruction inserted following the AdELOAD to further tag the sequence */
+
+#define BD_COOKIE 0x0000bd36 /* tne $0,$0 with baggage */
+
 int do_dsemulret(struct pt_regs *xcp)
 {
+	unsigned long *pinst;
+	unsigned long stackitem;
+	int err = 0;
+
+	/* See if this trap was deliberate. First check the instruction */
+
+	pinst = (unsigned long *) REG_TO_VA(xcp->cp0_epc);
+
+	/* 
+	 * If we can't even access the area, something is very
+	 * wrong, but we'll leave that to the default handling
+	 */
+	if (verify_area(VERIFY_READ, pinst, sizeof(unsigned long) * 3))
+		return 0;
+
+	/* Is the instruction pointed to by the EPC an AdELOAD? */
+	stackitem = mips_get_word(xcp, pinst, &err);
+	if (err || (stackitem != AdELOAD)) return 0;
+	/* Is the following memory word the BD_COOKIE? */
+	stackitem = mips_get_word(xcp, pinst+1, &err);
+	if (err || (stackitem != BD_COOKIE)) return 0;
+	
+	/* 
+	 * At this point, we are satisfied that it's a BD emulation 
+	 * trap.  Yes, a user might have deliberately put two
+	 * malformed and useless instructions in a row in his program,
+	 * in which case he's in for a nasty surprise - the
+	 * next instruction will be treated as a continuation
+	 * address!  Alas, this seems to be the only way that
+	 * we can handle signals, recursion, and longjmps()
+	 * in the context of emulating the branch delay instruction.
+	 */
+
 #ifdef DSEMUL_TRACE
 	printk("desemulret\n");
 #endif
+
+	/* Fetch the Saved EPC to Resume */
+ 
+	stackitem = mips_get_word(xcp, pinst+2, &err);
+	if (err) {
+		/* This is not a good situation to be in */
+		fpuemuprivate.stats.errors++;
+		force_sig(SIGBUS, current);
+		return(1);
+	}
+ 
 	/* Set EPC to return to post-branch instruction */
-	xcp->cp0_epc = current->thread.dsemul_epc;
-	/*
-	 * Clear the state that got us here.
-	 */
-	current->thread.dsemul_aerpc = (unsigned long) 0;
+	xcp->cp0_epc = stackitem;
 
-	return 0;
+	return 1;
 }
 
-
-#define AdELOAD 0x8c000001	/* lw $0,1($0) */
-
 static int
 mips_dsemul(struct pt_regs *xcp, mips_instruction ir, vaddr_t cpc)
 {
 	mips_instruction *dsemul_insns;
-	mips_instruction forcetrap;
 	extern asmlinkage void handle_dsemulret(void);
 
 	if (ir == 0) {		/* a nop is easy */
@@ -791,13 +838,22 @@
 	 * and put a trap after it which we can catch and jump to 
 	 * the required address any alternative apart from full 
 	 * instruction emulation!!.
+	 * 
+	 * Algorithmics used a system call instruction, and
+	 * borrowed that vector.  MIPS/Linux version is a bit
+	 * more heavyweight in the interests of portability and
+	 * multiprocessor support.  We flag the thread for special
+	 * handling in the unaligned access handler and force an
+	 * address error excpetion.
 	 */
-	dsemul_insns = (mips_instruction *) (xcp->regs[29] & ~3);
-	dsemul_insns -= 3;	/* Two instructions, plus one for luck ;-) */
+
+	/* Ensure that the two instructions are in the same cache line */
+	dsemul_insns = (mips_instruction *) (xcp->regs[29] & ~0xf);
+	dsemul_insns -= 4;      /* Retain 16-byte alignment */
 
 	/* Verify that the stack pointer is not competely insane */
 	if (verify_area(VERIFY_WRITE, dsemul_insns,
-	                sizeof(mips_instruction) * 2))
+	                sizeof(mips_instruction) * 4))
 		return SIGBUS;
 
 	if (mips_put_word(xcp, &dsemul_insns[0], ir)) {
@@ -805,29 +861,22 @@
 		return SIGBUS;
 	}
 
-	/* 
-	 * Algorithmics used a system call instruction, and
-	 * borrowed that vector.  MIPS/Linux version is a bit
-	 * more heavyweight in the interests of portability and
-	 * multiprocessor support.  We flag the thread for special
-	 * handling in the unaligned access handler and force an
-	 * address error excpetion.
-	 */
+	if (mips_put_word(xcp, &dsemul_insns[1], (mips_instruction)AdELOAD)) {
+		fpuemuprivate.stats.errors++;
+		return (SIGBUS);
+	}
 
-	/* If one is *really* paranoid, one tests for a bad stack pointer */
-	if ((xcp->regs[29] & 0x3) == 0x3)
-		forcetrap = AdELOAD - 1;
-	else
-		forcetrap = AdELOAD;
+	if (mips_put_word(xcp, &dsemul_insns[2], 
+			  (mips_instruction)BD_COOKIE)) {
+		fpuemuprivate.stats.errors++;
+		return (SIGBUS);
+	}
 
-	if (mips_put_word(xcp, &dsemul_insns[1], forcetrap)) {
+	if (mips_put_word(xcp, &dsemul_insns[3], (mips_instruction)cpc)) {
 		fpuemuprivate.stats.errors++;
 		return (SIGBUS);
 	}
 
-	/* Set thread state to catch and handle the exception */
-	current->thread.dsemul_epc = (unsigned long) cpc;
-	current->thread.dsemul_aerpc = (unsigned long) &dsemul_insns[1];
 	xcp->cp0_epc = VA_TO_REG & dsemul_insns[0];
 	flush_cache_sigtramp((unsigned long) dsemul_insns);
 
Index: linux/arch/mips/math-emu/kernel_linkage.c
===================================================================
RCS file: /cvs/linux/arch/mips/math-emu/kernel_linkage.c,v
retrieving revision 1.3
diff -u -r1.3 kernel_linkage.c
--- linux/arch/mips/math-emu/kernel_linkage.c	2001/01/13 18:17:58	1.3
+++ linux/arch/mips/math-emu/kernel_linkage.c	2001/08/15 12:33:38
@@ -3,7 +3,7 @@
  *  arch/mips/math_emu/kernel_linkage.c
  *
  *  Kevin D. Kissell, kevink@mips and Carsten Langgaard, carstenl@mips.com
- *  Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ *  Copyright (C) 2000-2001 MIPS Technologies, Inc.  All rights reserved.
  *
  * ########################################################################
  *
@@ -45,7 +45,7 @@
  
 	if (first) {
 		first = 0;
-		printk("Algorithmics/MIPS FPU Emulator v1.4\n");
+		printk("Algorithmics/MIPS FPU Emulator v1.5\n");
 	}
 
 	current->thread.fpu.soft.sr = 0;
Index: linux/arch/mips/tools/offset.c
===================================================================
RCS file: /cvs/linux/arch/mips/tools/offset.c,v
retrieving revision 1.16
diff -u -r1.16 offset.c
--- linux/arch/mips/tools/offset.c	2000/12/10 07:56:02	1.16
+++ linux/arch/mips/tools/offset.c	2001/08/15 12:33:39
@@ -121,10 +121,6 @@
 	       thread.irix_trampoline);
 	offset("#define THREAD_OLDCTX  ", struct task_struct, \
 	       thread.irix_oldctx);
-	offset("#define THREAD_DSEEPC  ", struct task_struct, \
-	       thread.dsemul_epc);
-	offset("#define THREAD_DSEAERPC ", struct task_struct, \
-	       thread.dsemul_aerpc);
 	linefeed;
 }
 
Index: linux/include/asm-mips/processor.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/processor.h,v
retrieving revision 1.37
diff -u -r1.37 processor.h
--- linux/include/asm-mips/processor.h	2001/07/23 00:17:39	1.37
+++ linux/include/asm-mips/processor.h	2001/08/15 12:33:42
@@ -151,21 +151,6 @@
 	mm_segment_t current_ds;
 	unsigned long irix_trampoline;  /* Wheee... */
 	unsigned long irix_oldctx;
-
-	/*
-	 * These are really only needed if the full FPU emulator is configured.
-	 * Would be made conditional on MIPS_FPU_EMULATOR if it weren't for the
-	 * fact that having offset.h rebuilt differently for different config
-	 * options would be asking for trouble.
-	 *
-	 * Saved EPC during delay-slot emulation (see math-emu/cp1emu.c)
-	 */
-	unsigned long dsemul_epc;
-
-	/*
-	 * Pointer to instruction used to induce address error
-	 */
-	unsigned long dsemul_aerpc;
 };
 
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
@@ -195,11 +180,6 @@
 	 * For now the default is to fix address errors \
 	 */ \
 	MF_FIXADE, { 0 }, 0, 0, \
-	/* \
-	 * dsemul_epc and dsemul_aerpc should never be used uninitialized, \
-	 * but... \
-	 */ \
-	0 ,0 \
 }
 
 #ifdef __KERNEL__
@@ -235,8 +215,8 @@
  * Do necessary setup to start up a newly executed thread.
  */
 #define start_thread(regs, new_pc, new_sp) do {				\
-	/* New thread looses kernel privileges. */			\
-	regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU)) | KU_USER;\
+	/* New thread loses kernel and FPU privileges. */               \
+        regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU|ST0_CU1)) | KU_USER;\
 	regs->cp0_epc = new_pc;						\
 	regs->regs[29] = new_sp;					\
 	current->thread.current_ds = USER_DS;				\

--------------B681E670EA042CA2391804E1--
