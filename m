Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 12:43:36 +0000 (GMT)
Received: from p508B6B70.dip.t-dialin.net ([IPv6:::ffff:80.139.107.112]:25745
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225263AbSLQMnf>; Tue, 17 Dec 2002 12:43:35 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBHChXh26402
	for linux-mips@linux-mips.org; Tue, 17 Dec 2002 13:43:33 +0100
Date: Tue, 17 Dec 2002 13:43:33 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: compute_return_epc
Message-ID: <20021217134333.A26119@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The current kernel code is calling compute_return_epc() in most exception
handlers for skipping over the instruction.  We're doing thins in practically
all cases.  To my knowledge we're the only MIPS UNIX flavor doing that
which my result in software portabilitiy problems.  It also means that
debuggers and signal handlers in such a case will only ever see the new
program counter but never a pointer to the actually faulting instruction.

So I'd like to apply the following patch which limits the use of
compute_return_epc to those cases where we actually did some sort of
instruction emulation.  Comments?

  Ralf

Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.99.2.36
diff -u -r1.99.2.36 traps.c
--- arch/mips/kernel/traps.c	17 Dec 2002 01:43:05 -0000	1.99.2.36
+++ arch/mips/kernel/traps.c	17 Dec 2002 12:07:48 -0000
@@ -96,7 +96,7 @@
 
 static struct task_struct *ll_task = NULL;
 
-static inline void simulate_ll(struct pt_regs *regp, unsigned int opcode)
+static inline void simulate_ll(struct pt_regs *regs, unsigned int opcode)
 {
 	unsigned long value, *vaddr;
 	long offset;
@@ -112,32 +112,37 @@
 	offset <<= 16;
 	offset >>= 16;
 
-	vaddr = (unsigned long *)((long)(regp->regs[(opcode & BASE) >> 21]) + offset);
+	vaddr = (unsigned long *)((long)(regs->regs[(opcode & BASE) >> 21]) + offset);
 
 #ifdef CONFIG_PROC_FS
 	ll_ops++;
 #endif
 
-	if ((unsigned long)vaddr & 3)
+	if ((unsigned long)vaddr & 3) {
 		signal = SIGBUS;
-	else if (get_user(value, vaddr))
+		goto sig;
+	}
+	if (get_user(value, vaddr)) {
 		signal = SIGSEGV;
-	else {
-		if (ll_task == NULL || ll_task == current) {
-			ll_bit = 1;
-		} else {
-			ll_bit = 0;
-		}
-		ll_task = current;
-		regp->regs[(opcode & RT) >> 16] = value;
+		goto sig;
 	}
-	if (compute_return_epc(regp))
-		return;
-	if (signal)
-		send_sig(signal, current, 1);
+
+	if (ll_task == NULL || ll_task == current) {
+		ll_bit = 1;
+	} else {
+		ll_bit = 0;
+	}
+	ll_task = current;
+	regs->regs[(opcode & RT) >> 16] = value;
+
+	compute_return_epc(regs);
+	return;
+
+sig:
+	send_sig(signal, current, 1);
 }
 
-static inline void simulate_sc(struct pt_regs *regp, unsigned int opcode)
+static inline void simulate_sc(struct pt_regs *regs, unsigned int opcode)
 {
 	unsigned long *vaddr, reg;
 	long offset;
@@ -153,25 +158,32 @@
 	offset <<= 16;
 	offset >>= 16;
 
-	vaddr = (unsigned long *)((long)(regp->regs[(opcode & BASE) >> 21]) + offset);
+	vaddr = (unsigned long *)((long)(regs->regs[(opcode & BASE) >> 21]) + offset);
 	reg = (opcode & RT) >> 16;
 
 #ifdef CONFIG_PROC_FS
 	sc_ops++;
 #endif
 
-	if ((unsigned long)vaddr & 3)
+	if ((unsigned long)vaddr & 3) {
 		signal = SIGBUS;
-	else if (ll_bit == 0 || ll_task != current)
-		regp->regs[reg] = 0;
-	else if (put_user(regp->regs[reg], vaddr))
+		goto sig;
+	}
+	if (ll_bit == 0 || ll_task != current) {
+		regs->regs[reg] = 0;
+		goto sig;
+	}
+
+	if (put_user(regs->regs[reg], vaddr))
 		signal = SIGSEGV;
 	else
-		regp->regs[reg] = 1;
-	if (compute_return_epc(regp))
-		return;
-	if (signal)
-		send_sig(signal, current, 1);
+		regs->regs[reg] = 1;
+
+	compute_return_epc(regs);
+	return;
+
+sig:
+	send_sig(signal, current, 1);
 }
 
 /*
@@ -489,9 +501,6 @@
 {
 	siginfo_t info;
 
-	if (compute_return_epc(regs))
-		return;
-
 	info.si_code = FPE_INTOVF;
 	info.si_signo = SIGFPE;
 	info.si_errno = 0;
@@ -534,20 +543,11 @@
 
 		/* If something went wrong, signal */
 		if (sig)
-		{
-			/*
-			 * Return EPC is not calculated in the FPU emulator,
-			 * if a signal is being send. So we calculate it here.
-			 */
-			compute_return_epc(regs);
 			force_sig(sig, current);
-		}
 
 		return;
 	}
 
-	if (compute_return_epc(regs))
-		return;
 	force_sig(SIGFPE, current);
 }
 
@@ -670,8 +670,6 @@
 	}
 #endif /* CONFIG_CPU_HAS_LLSC */
 
-	if (compute_return_epc(regs))
-		return;
 	force_sig(SIGILL, current);
 }
 
@@ -695,14 +693,8 @@
 
 	if (!(mips_cpu.options & MIPS_CPU_FPU)) {
 		int sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
-		if (sig) {
-			/*
-		 	 * Return EPC is not calculated in the FPU emulator, if
-		   	 * a signal is being send. So we calculate it here.
-		 	 */
-			compute_return_epc(regs);
+		if (sig)
 			force_sig(sig, current);
-		}
 	}
 
 	return;
@@ -716,7 +708,6 @@
 		return;
 	}
 #endif
-	compute_return_epc(regs);
 	force_sig(SIGILL, current);
 }
 
@@ -823,28 +814,28 @@
  */
 void ejtag_exception_handler(struct pt_regs *regs)
 {
-        unsigned long depc, old_epc;
-        unsigned int debug;
+	unsigned long depc, old_epc;
+	unsigned int debug;
 
-        printk("SDBBP EJTAG debug exception - not handled yet, just ignored!\n");
-        depc = read_c0_depc();
-        debug = read_c0_debug();
-        printk("c0_depc = %08lx, DEBUG = %08x\n", depc, debug);
-        if (debug & 0x80000000) {
-                /*
-                 * In branch delay slot.
-                 * We cheat a little bit here and use EPC to calculate the
-                 * debug return address (DEPC). EPC is restored after the
-                 * calculation.
-                 */
-                old_epc = regs->cp0_epc;
-                regs->cp0_epc = depc;
-                __compute_return_epc(regs);
-                depc = regs->cp0_epc;
-                regs->cp0_epc = old_epc;
-        } else
-                depc += 4;
-        write_c0_depc(depc);
+	printk("SDBBP EJTAG debug exception - not handled yet, just ignored!\n");
+	depc = read_c0_depc();
+	debug = read_c0_debug();
+	printk("c0_depc = %08lx, DEBUG = %08x\n", depc, debug);
+	if (debug & 0x80000000) {
+		/*
+		 * In branch delay slot.
+		 * We cheat a little bit here and use EPC to calculate the
+		 * debug return address (DEPC). EPC is restored after the
+		 * calculation.
+		 */
+		old_epc = regs->cp0_epc;
+		regs->cp0_epc = depc;
+		__compute_return_epc(regs);
+		depc = regs->cp0_epc;
+		regs->cp0_epc = old_epc;
+	} else
+		depc += 4;
+	write_c0_depc(depc);
 
 #if 0
 	printk("\n\n----- Enable EJTAG single stepping ----\n\n");
Index: arch/mips/kernel/unaligned.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/unaligned.c,v
retrieving revision 1.15.2.9
diff -u -r1.15.2.9 unaligned.c
--- arch/mips/kernel/unaligned.c	7 Dec 2002 17:46:47 -0000	1.15.2.9
+++ arch/mips/kernel/unaligned.c	17 Dec 2002 12:07:48 -0000
@@ -88,6 +88,10 @@
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
 
+#ifdef CONFIG_PROC_FS
+unsigned long unaligned_instructions;
+#endif
+
 static inline int emulate_load_store_insn(struct pt_regs *regs,
 	unsigned long addr, unsigned long pc)
 {
@@ -447,6 +451,13 @@
 		 */
 		goto sigill;
 	}
+
+	compute_return_epc(regs);
+
+#ifdef CONFIG_PROC_FS
+	unaligned_instructions++;
+#endif
+
 	return 0;
 
 fault:
@@ -479,10 +490,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-unsigned long unaligned_instructions;
-#endif
-
 asmlinkage void do_ade(struct pt_regs *regs)
 {
 	unsigned long pc;
@@ -516,12 +523,7 @@
 	 * Do branch emulation only if we didn't forward the exception.
 	 * This is all so but ugly ...
 	 */
-	if (!emulate_load_store_insn(regs, regs->cp0_badvaddr, pc))
-		compute_return_epc(regs);
-
-#ifdef CONFIG_PROC_FS
-	unaligned_instructions++;
-#endif
+	emulate_load_store_insn(regs, regs->cp0_badvaddr, pc);
 
 	return;
 
Index: arch/mips64/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/traps.c,v
retrieving revision 1.30.2.39
diff -u -r1.30.2.39 traps.c
--- arch/mips64/kernel/traps.c	17 Dec 2002 01:43:05 -0000	1.30.2.39
+++ arch/mips64/kernel/traps.c	17 Dec 2002 12:07:49 -0000
@@ -400,9 +400,6 @@
 {
 	siginfo_t info;
 
-	if (compute_return_epc(regs))
-		return;
-
 	info.si_code = FPE_INTOVF;
 	info.si_signo = SIGFPE;
 	info.si_errno = 0;
@@ -445,20 +442,11 @@
 
 		/* If something went wrong, signal */
 		if (sig)
-		{
-			/*
-			 * Return EPC is not calculated in the FPU emulator,
-			 * if a signal is being send. So we calculate it here.
-			 */
-			compute_return_epc(regs);
 			force_sig(sig, current);
-		}
 
 		return;
 	}
 
-	if (compute_return_epc(regs))
-		return;
 	force_sig(SIGFPE, current);
 }
 
@@ -552,9 +540,6 @@
 {
 	die_if_kernel("Reserved instruction in kernel code", regs);
 
-	if (compute_return_epc(regs))
-		return;
-
 	force_sig(SIGILL, current);
 }
 
@@ -578,20 +563,13 @@
 
 	if (!(mips_cpu.options & MIPS_CPU_FPU)) {
 		int sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
-		if (sig) {
-			/*
-			 * Return EPC is not calculated in the FPU emulator, if
-			 * a signal is being send. So we calculate it here.
-			 */
-			compute_return_epc(regs);
+		if (sig)
 			force_sig(sig, current);
-		}
 	}
 
 	return;
 
 bad_cid:
-	compute_return_epc(regs);
 	force_sig(SIGILL, current);
 }
 
Index: arch/mips64/kernel/unaligned.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/unaligned.c,v
retrieving revision 1.6.2.8
diff -u -r1.6.2.8 unaligned.c
--- arch/mips64/kernel/unaligned.c	7 Dec 2002 17:46:47 -0000	1.6.2.8
+++ arch/mips64/kernel/unaligned.c	17 Dec 2002 12:07:50 -0000
@@ -88,6 +88,10 @@
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
 
+#ifdef CONFIG_PROC_FS
+unsigned long unaligned_instructions;
+#endif
+
 static inline int emulate_load_store_insn(struct pt_regs *regs,
 	unsigned long addr, unsigned long pc)
 {
@@ -447,6 +451,13 @@
 		 */
 		goto sigill;
 	}
+
+	compute_return_epc(regs);
+
+#ifdef CONFIG_PROC_FS
+	unaligned_instructions++;
+#endif
+
 	return 0;
 
 fault:
@@ -479,10 +490,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-unsigned long unaligned_instructions;
-#endif
-
 asmlinkage void do_ade(struct pt_regs *regs)
 {
 	unsigned long pc;
@@ -516,12 +523,7 @@
 	 * Do branch emulation only if we didn't forward the exception.
 	 * This is all so but ugly ...
 	 */
-	if (!emulate_load_store_insn(regs, regs->cp0_badvaddr, pc))
-		compute_return_epc(regs);
-
-#ifdef CONFIG_PROC_FS
-	unaligned_instructions++;
-#endif
+	emulate_load_store_insn(regs, regs->cp0_badvaddr, pc);
 
 	return;
 
