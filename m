Received:  by oss.sgi.com id <S553934AbQKAGtr>;
	Tue, 31 Oct 2000 22:49:47 -0800
Received: from short.adgrafix.com ([63.79.128.2]:22768 "EHLO
        short.adgrafix.com") by oss.sgi.com with ESMTP id <S553931AbQKAGti>;
	Tue, 31 Oct 2000 22:49:38 -0800
Received: from ppan2 (c534317-a.stcla1.sfba.home.com [24.20.134.153])
	by short.adgrafix.com (8.9.3/8.9.3) with SMTP id BAA20797;
	Wed, 1 Nov 2000 01:43:23 -0500 (EST)
From:   "Mike Klar" <mfklar@ponymail.com>
To:     "Jun Sun" <jsun@mvista.com>
Cc:     <linux-mips@oss.sgi.com>
Subject: RE: userspace spinlocks
Date:   Tue, 31 Oct 2000 22:50:39 -0800
Message-ID: <NDBBIDGAOKMNJNDAHDDMIECFCNAA.mfklar@ponymail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <39FF414D.6B0A553C@mvista.com>
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Jun Sun wrote:

> BTW, I didn't know the kernel already has ll/sc emulation.  That seems
> to be necessary, even just for the binary compability sake.

It's not complete in the Linux-MIPS tree, it is at least more so in the
Linux VR tree, but still only supports locking between user contexts.  Patch
is below, sorry if it doesn't apply cleanly, there were a few bits that I
cut out that weren't pertinent to LL/SC.

The bits that have to do with ll_task in the below patch look wrong, though,
and I only just noticed when preparing this patch that it had gotten added.
I'm not sure what the motivation for adding it was, maybe clearing ll_bit
only on context switches was not sufficient to cover all cases (like thread
creation, maybe?), but I thought I had looked into that already.

Mike Klar

Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /cvsroot/linux-vr/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.1.1.7
retrieving revision 1.20
diff -u -d -r1.1.1.7 -r1.20
--- arch/mips/kernel/traps.c	2000/09/12 06:41:24	1.1.1.7
+++ arch/mips/kernel/traps.c	2000/09/13 07:24:52	1.20
@@ -95,9 +95,9 @@
 #define RT     0x001f0000
 #define OFFSET 0x0000ffff
 #define LL     0xc0000000
-#define SC     0xd0000000
+#define SC     0xe0000000

-#define DEBUG_LLSC
+#undef DEBUG_LLSC
 #endif

 /*
@@ -418,47 +423,65 @@
 #if !defined(CONFIG_CPU_HAS_LLSC)

 /*
- * userland emulation for R2300 CPUs
+ * userland emulation for R2300 CPUs, and some embedded R4K CPUs
  * needed for the multithreading part of glibc
+ *
+ * this implementation can handle only sychronization between 2 or more
+ * user contexts.
  */
 void do_ri(struct pt_regs *regs)
 {
 	unsigned int opcode;

+	if (!user_mode(regs))
+		BUG();
+
 	if (!get_insn_opcode(regs, &opcode)) {
-		if ((opcode & OPCODE) == LL)
+		if ((opcode & OPCODE) == LL) {
 			simulate_ll(regs, opcode);
-		if ((opcode & OPCODE) == SC)
+			return;
+		}
+		if ((opcode & OPCODE) == SC) {
 			simulate_sc(regs, opcode);
-	} else {
-	printk("[%s:%d] Illegal instruction at %08lx ra=%08lx\n",
-	       current->comm, current->pid, regs->cp0_epc, regs->regs[31]);
+			return;
+		}
 	}
+	printk("[%s:%d] Illegal instruction %08lx at %08lx, ra=%08lx,
CP0_STATUS=%08lx\n",
+	       current->comm, current->pid, *((unsigned long*)regs->cp0_epc),
regs->cp0_epc,
+		regs->regs[31], regs->cp0_status);
 	if (compute_return_epc(regs))
 		return;
 	force_sig(SIGILL, current);
 }

 /*
- * the ll_bit will be cleared by r2300_switch.S
+ * the ll_bit will be cleared by r2300_switch.S or r4k_switch.S
  */
-unsigned long ll_bit, *lladdr;
+unsigned long ll_bit;
+#ifdef CONFIG_SMP
+unsigned long *lladdr;
+#endif
+
+static struct task_struct *ll_task = NULL;

 void simulate_ll(struct pt_regs *regp, unsigned int opcode)
 {
-	unsigned long *addr, *vaddr;
+	unsigned long value, *vaddr;
 	long offset;
+	int signal = 0;
+#ifdef CONFIG_SMP
+	unsigned long *addr;
+#endif

 	/*
 	 * analyse the ll instruction that just caused a ri exception
 	 * and put the referenced address to addr.
 	 */
+
 	/* sign extend offset */
 	offset = opcode & OFFSET;
-	if (offset & 0x00008000)
-		offset = -(offset & 0x00007fff);
-	else
-		offset = (offset & 0x00007fff);
+	offset <<= 16;
+	offset >>= 16;

 	vaddr = (unsigned long *)((long)(regp->regs[(opcode & BASE) >> 21]) +
offset);

@@ -466,31 +489,51 @@
 	printk("ll: vaddr = 0x%08x, reg = %d\n", (unsigned int)vaddr, (opcode &
RT) >> 16);
 #endif

+#ifdef CONFIG_SMP
 	/*
 	 * TODO: compute physical address from vaddr
 	 */
-	panic("ll: emulation not yet finished!");
+	panic("ll: emulation not yet finished for SMP!");

 	lladdr = addr;
-	ll_bit = 1;
-	regp->regs[(opcode & RT) >> 16] = *addr;
+#endif
+	if ((unsigned long)vaddr & 3)
+		signal = SIGBUS;
+	else if (get_user(value, vaddr))
+		signal = SIGSEGV;
+	else {
+		if (ll_task == NULL || ll_task == current) {
+			ll_bit = 1;
+		} else {
+			ll_bit = 0;
+		}
+		ll_task = current;
+		regp->regs[(opcode & RT) >> 16] = value;
+	}
+	if (compute_return_epc(regp))
+		return;
+	if (signal)
+		send_sig(signal, current, 1);
 }

 void simulate_sc(struct pt_regs *regp, unsigned int opcode)
 {
-	unsigned long *addr, *vaddr, reg;
+	unsigned long *vaddr, reg;
 	long offset;
+	int signal = 0;
+#ifdef CONFIG_SMP
+	unsigned long *addr;
+#endif

 	/*
 	 * analyse the sc instruction that just caused a ri exception
 	 * and put the referenced address to addr.
 	 */
+
 	/* sign extend offset */
 	offset = opcode & OFFSET;
-	if (offset & 0x00008000)
-		offset = -(offset & 0x00007fff);
-	else
-		offset = (offset & 0x00007fff);
+	offset <<= 16;
+	offset >>= 16;

 	vaddr = (unsigned long *)((long)(regp->regs[(opcode & BASE) >> 21]) +
offset);
 	reg = (opcode & RT) >> 16;
@@ -499,20 +542,26 @@
 	printk("sc: vaddr = 0x%08x, reg = %d\n", (unsigned int)vaddr, (unsigned
int)reg);
 #endif

+#ifdef CONFIG_SMP
 	/*
 	 * TODO: compute physical address from vaddr
 	 */
-	panic("sc: emulation not yet finished!");
+	panic("sc: emulation not yet finished for SMP!");

 	lladdr = addr;
-
-	if (ll_bit == 0) {
+#endif
+	if ((unsigned long)vaddr & 3)
+		signal = SIGBUS;
+	else if (ll_bit == 0 || ll_task != current)
 		regp->regs[reg] = 0;
+	else if (put_user(regp->regs[reg], vaddr))
+		signal = SIGSEGV;
+	else
+		regp->regs[reg] = 1;
+	if (compute_return_epc(regp))
 		return;
-	}
-
-	*addr = regp->regs[reg];
-	regp->regs[reg] = 1;
+	if (signal)
+		send_sig(signal, current, 1);
 }

 #else /* MIPS 2 or higher */
Index: arch/mips/kernel/r2300_switch.S
===================================================================
RCS file: /cvsroot/linux-vr/linux/arch/mips/kernel/r2300_switch.S,v
retrieving revision 1.1.1.2
retrieving revision 1.2
diff -u -d -r1.1.1.2 -r1.2
--- arch/mips/kernel/r2300_switch.S	2000/04/12 02:42:46	1.1.1.2
+++ arch/mips/kernel/r2300_switch.S	2000/07/19 07:18:06	1.2
@@ -34,6 +34,7 @@
  *                           task_struct *next)
  */
 LEAF(resume)
+	sw	zero, ll_bit
 	.set	reorder
 	mfc0	t1, CP0_STATUS
 	.set	noreorder
Index: arch/mips/kernel/r4k_switch.S
===================================================================
RCS file: /cvsroot/linux-vr/linux/arch/mips/kernel/r4k_switch.S,v
retrieving revision 1.1.1.2
retrieving revision 1.2
diff -u -d -r1.1.1.2 -r1.2
--- arch/mips/kernel/r4k_switch.S	2000/04/12 02:42:47	1.1.1.2
+++ arch/mips/kernel/r4k_switch.S	2000/07/19 07:18:06	1.2
@@ -9,6 +9,7 @@
  * Copyright (C) 1994, 1995, 1996, by Andreas Busse
  * Copyright (C) 1999 Silicon Graphics, Inc.
  */
+#include <linux/config.h>
 #include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
@@ -32,6 +33,9 @@
 	.set	noreorder
 	.align	5
 	LEAF(resume)
+#ifndef CONFIG_CPU_HAS_LLSC
+	sw	zero, ll_bit
+#endif
 	mfc0	t1, CP0_STATUS
 	sw	t1, THREAD_STATUS(a0)
 	CPU_SAVE_NONSCRATCH(a0)
