Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 18:43:43 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:7339 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20027652AbXJPRnd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 18:43:33 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4DEE9400A5;
	Tue, 16 Oct 2007 19:43:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id KxtEEmAPGOf4; Tue, 16 Oct 2007 19:43:27 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id CFC3F40085;
	Tue, 16 Oct 2007 19:43:27 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9GHhWOr017600;
	Tue, 16 Oct 2007 19:43:32 +0200
Date:	Tue, 16 Oct 2007 18:43:26 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] SYNC emulation for MIPS I processors
Message-ID: <Pine.LNX.4.64N.0710151504370.16262@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4540/Sun Oct 14 03:43:55 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Userland, including the C library and the dynamic linker, is keen to use 
the SYNC instruction, even for "generic" MIPS I binaries these days.  
Which makes it less than useful on MIPS I processors.

 This change adds the emulation, but as our do_ri() infrastructure was not 
really prepared to take yet another instruction, I have rewritten it and 
its callees slightly as follows.

 Now there is only a single place a possible signal is thrown from.  The 
place is at the end of do_ri().  The instruction word is fetched in 
do_ri() and passed down to handlers.  The handlers are called in sequence 
and return a result that lets the caller decide upon further processing.  
If the result is positive, then the handler has picked the instruction, 
but a signal should be thrown and the result is the signal number.  If the 
result is zero, then the handler has successfully simulated the 
instruction.  If the result is negative, then the handler did not handle 
the instruction; to make it more obvious the calls do not follow the usual 
0/-Exxx result convention they now return -1 instead of -EFAULT.

 The calculation of the return EPC is now at the beginning.  The reason is 
it is easier to handle it there as emulation callees may modify a register 
and an instruction may be located in delay slot of a branch whose result 
depends on the register.  It has to be undone if a signal is to be raised, 
but it is not a problem as this is the slow-path case, and both actions 
are done in single places now rather than the former being scattered 
through emulation handlers.

 The part of do_cpu() being covered follows the changes to do_ri().

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested successfully on an R3000A with an orchestrated test case involving 
instructions being covered, with no regressions and SYNC handled as 
expected.  To follow a good practice established with hardware over the 
years, I decided not to decode the reserved field of the instruction word, 
but I can change it if there is demand for it.

 Please apply,

  Maciej

patch-mips-2.6.23-rc5-20070904-mips-sync-7
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/kernel/traps.c linux-mips-2.6.23-rc5-20070904/arch/mips/kernel/traps.c
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/kernel/traps.c	2007-09-04 04:55:19.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/kernel/traps.c	2007-10-16 00:57:01.000000000 +0000
@@ -9,9 +9,10 @@
  * Copyright (C) 1999 Silicon Graphics, Inc.
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
- * Copyright (C) 2002, 2003, 2004, 2005  Maciej W. Rozycki
+ * Copyright (C) 2002, 2003, 2004, 2005, 2007  Maciej W. Rozycki
  */
 #include <linux/bug.h>
+#include <linux/compiler.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -400,7 +401,7 @@ asmlinkage void do_be(struct pt_regs *re
 }
 
 /*
- * ll/sc emulation
+ * ll/sc, rdhwr, sync emulation
  */
 
 #define OPCODE 0xfc000000
@@ -409,9 +410,11 @@ asmlinkage void do_be(struct pt_regs *re
 #define OFFSET 0x0000ffff
 #define LL     0xc0000000
 #define SC     0xe0000000
+#define SPEC0  0x00000000
 #define SPEC3  0x7c000000
 #define RD     0x0000f800
 #define FUNC   0x0000003f
+#define SYNC   0x0000000f
 #define RDHWR  0x0000003b
 
 /*
@@ -422,11 +425,10 @@ unsigned long ll_bit;
 
 static struct task_struct *ll_task = NULL;
 
-static inline void simulate_ll(struct pt_regs *regs, unsigned int opcode)
+static inline int simulate_ll(struct pt_regs *regs, unsigned int opcode)
 {
 	unsigned long value, __user *vaddr;
 	long offset;
-	int signal = 0;
 
 	/*
 	 * analyse the ll instruction that just caused a ri exception
@@ -441,14 +443,10 @@ static inline void simulate_ll(struct pt
 	vaddr = (unsigned long __user *)
 	        ((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
 
-	if ((unsigned long)vaddr & 3) {
-		signal = SIGBUS;
-		goto sig;
-	}
-	if (get_user(value, vaddr)) {
-		signal = SIGSEGV;
-		goto sig;
-	}
+	if ((unsigned long)vaddr & 3)
+		return SIGBUS;
+	if (get_user(value, vaddr))
+		return SIGSEGV;
 
 	preempt_disable();
 
@@ -461,22 +459,16 @@ static inline void simulate_ll(struct pt
 
 	preempt_enable();
 
-	compute_return_epc(regs);
-
 	regs->regs[(opcode & RT) >> 16] = value;
 
-	return;
-
-sig:
-	force_sig(signal, current);
+	return 0;
 }
 
-static inline void simulate_sc(struct pt_regs *regs, unsigned int opcode)
+static inline int simulate_sc(struct pt_regs *regs, unsigned int opcode)
 {
 	unsigned long __user *vaddr;
 	unsigned long reg;
 	long offset;
-	int signal = 0;
 
 	/*
 	 * analyse the sc instruction that just caused a ri exception
@@ -492,34 +484,25 @@ static inline void simulate_sc(struct pt
 	        ((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
 	reg = (opcode & RT) >> 16;
 
-	if ((unsigned long)vaddr & 3) {
-		signal = SIGBUS;
-		goto sig;
-	}
+	if ((unsigned long)vaddr & 3)
+		return SIGBUS;
 
 	preempt_disable();
 
 	if (ll_bit == 0 || ll_task != current) {
-		compute_return_epc(regs);
 		regs->regs[reg] = 0;
 		preempt_enable();
-		return;
+		return 0;
 	}
 
 	preempt_enable();
 
-	if (put_user(regs->regs[reg], vaddr)) {
-		signal = SIGSEGV;
-		goto sig;
-	}
+	if (put_user(regs->regs[reg], vaddr))
+		return SIGSEGV;
 
-	compute_return_epc(regs);
 	regs->regs[reg] = 1;
 
-	return;
-
-sig:
-	force_sig(signal, current);
+	return 0;
 }
 
 /*
@@ -529,27 +512,14 @@ sig:
  * few processors such as NEC's VR4100 throw reserved instruction exceptions
  * instead, so we're doing the emulation thing in both exception handlers.
  */
-static inline int simulate_llsc(struct pt_regs *regs)
+static int simulate_llsc(struct pt_regs *regs, unsigned int opcode)
 {
-	unsigned int opcode;
-
-	if (get_user(opcode, (unsigned int __user *) exception_epc(regs)))
-		goto out_sigsegv;
+	if ((opcode & OPCODE) == LL)
+		return simulate_ll(regs, opcode);
+	if ((opcode & OPCODE) == SC)
+		return simulate_sc(regs, opcode);
 
-	if ((opcode & OPCODE) == LL) {
-		simulate_ll(regs, opcode);
-		return 0;
-	}
-	if ((opcode & OPCODE) == SC) {
-		simulate_sc(regs, opcode);
-		return 0;
-	}
-
-	return -EFAULT;			/* Strange things going on ... */
-
-out_sigsegv:
-	force_sig(SIGSEGV, current);
-	return -EFAULT;
+	return -1;			/* Must be something else ... */
 }
 
 /*
@@ -557,16 +527,9 @@ out_sigsegv:
  * registers not implemented in hardware.  The only current use of this
  * is the thread area pointer.
  */
-static inline int simulate_rdhwr(struct pt_regs *regs)
+static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
 {
 	struct thread_info *ti = task_thread_info(current);
-	unsigned int opcode;
-
-	if (get_user(opcode, (unsigned int __user *) exception_epc(regs)))
-		goto out_sigsegv;
-
-	if (unlikely(compute_return_epc(regs)))
-		return -EFAULT;
 
 	if ((opcode & OPCODE) == SPEC3 && (opcode & FUNC) == RDHWR) {
 		int rd = (opcode & RD) >> 11;
@@ -576,16 +539,20 @@ static inline int simulate_rdhwr(struct 
 				regs->regs[rt] = ti->tp_value;
 				return 0;
 			default:
-				return -EFAULT;
+				return -1;
 		}
 	}
 
 	/* Not ours.  */
-	return -EFAULT;
+	return -1;
+}
 
-out_sigsegv:
-	force_sig(SIGSEGV, current);
-	return -EFAULT;
+static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
+{
+	if ((opcode & OPCODE) == SPEC0 && (opcode & FUNC) == SYNC)
+		return 0;
+
+	return -1;			/* Must be something else ... */
 }
 
 asmlinkage void do_ov(struct pt_regs *regs)
@@ -757,16 +724,35 @@ out_sigsegv:
 
 asmlinkage void do_ri(struct pt_regs *regs)
 {
-	die_if_kernel("Reserved instruction in kernel code", regs);
+	unsigned int __user *epc = (unsigned int __user *)exception_epc(regs);
+	unsigned long old_epc = regs->cp0_epc;
+	unsigned int opcode = 0;
+	int status = -1;
 
-	if (!cpu_has_llsc)
-		if (!simulate_llsc(regs))
-			return;
+	die_if_kernel("Reserved instruction in kernel code", regs);
 
-	if (!simulate_rdhwr(regs))
+	if (unlikely(compute_return_epc(regs) < 0))
 		return;
 
-	force_sig(SIGILL, current);
+	if (unlikely(get_user(opcode, epc) < 0))
+		status = SIGSEGV;
+
+	if (!cpu_has_llsc && status < 0)
+		status = simulate_llsc(regs, opcode);
+
+	if (status < 0)
+		status = simulate_rdhwr(regs, opcode);
+
+	if (status < 0)
+		status = simulate_sync(regs, opcode);
+
+	if (status < 0)
+		status = SIGILL;
+
+	if (unlikely(status > 0)) {
+		regs->cp0_epc = old_epc;		/* Undo skip-over.  */
+		force_sig(status, current);
+	}
 }
 
 /*
@@ -798,7 +784,11 @@ static void mt_ase_fp_affinity(void)
 
 asmlinkage void do_cpu(struct pt_regs *regs)
 {
+	unsigned int __user *epc;
+	unsigned long old_epc;
+	unsigned int opcode;
 	unsigned int cpid;
+	int status;
 
 	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
@@ -806,14 +796,32 @@ asmlinkage void do_cpu(struct pt_regs *r
 
 	switch (cpid) {
 	case 0:
-		if (!cpu_has_llsc)
-			if (!simulate_llsc(regs))
-				return;
+		epc = (unsigned int __user *)exception_epc(regs);
+		old_epc = regs->cp0_epc;
+		opcode = 0;
+		status = -1;
 
-		if (!simulate_rdhwr(regs))
+		if (unlikely(compute_return_epc(regs) < 0))
 			return;
 
-		break;
+		if (unlikely(get_user(opcode, epc) < 0))
+			status = SIGSEGV;
+
+		if (!cpu_has_llsc && status < 0)
+			status = simulate_llsc(regs, opcode);
+
+		if (status < 0)
+			status = simulate_rdhwr(regs, opcode);
+
+		if (status < 0)
+			status = SIGILL;
+
+		if (unlikely(status > 0)) {
+			regs->cp0_epc = old_epc;	/* Undo skip-over.  */
+			force_sig(status, current);
+		}
+
+		return;
 
 	case 1:
 		if (used_math())	/* Using the FPU again.  */
