Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 19:07:12 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:20221 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225223AbUJVSHF>; Fri, 22 Oct 2004 19:07:05 +0100
Received: from prometheus.mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id C6D5D18541; Fri, 22 Oct 2004 11:06:43 -0700 (PDT)
Subject: [PATCH]Preemption patch for 2.6
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Content-Type: text/plain
Organization: 
Message-Id: <1098468403.4266.42.camel@prometheus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Oct 2004 11:06:43 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

The attached patch incorporates preemption enable/disable in some parts
of the kernel. I have tested this on the Broadcom Sibyte. Please review
...

Thanks
Manish Lachwani

Index: linux-2.6.8.1/arch/mips/kernel/signal32.c
===================================================================
--- linux-2.6.8.1.orig/arch/mips/kernel/signal32.c
+++ linux-2.6.8.1/arch/mips/kernel/signal32.c
@@ -295,6 +295,8 @@
 
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
+	preempt_disable();
+
 	if (current->used_math) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
@@ -304,6 +306,8 @@
 		lose_fpu();
 	}
 
+	preempt_enable();
+
 	return err;
 }
 
@@ -489,12 +493,16 @@
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
 	 */
+	preempt_disable();
+
 	if (!is_fpu_owner()) {
 		own_fpu();
 		restore_fp(current);
 	}
 	err |= save_fp_context32(sc);
 
+	preempt_enable();
+
 out:
 	return err;
 }
Index: linux-2.6.8.1/arch/mips/mm/c-sb1.c
===================================================================
--- linux-2.6.8.1.orig/arch/mips/mm/c-sb1.c
+++ linux-2.6.8.1/arch/mips/mm/c-sb1.c
@@ -197,10 +197,14 @@
 	if (!(vma->vm_flags & VM_EXEC))
 		return;
 
+	preempt_disable();
+
 	addr &= PAGE_MASK;
 	args.vma = vma;
 	args.addr = addr;
 	on_each_cpu(sb1_flush_cache_page_ipi, (void *) &args, 1, 1);
+
+	preempt_enable();
 }
 #else
 void sb1_flush_cache_page(struct vm_area_struct *vma, unsigned long
addr)
@@ -243,7 +247,9 @@
 
 static void sb1___flush_cache_all(void)
 {
+	preempt_disable();
 	on_each_cpu(sb1___flush_cache_all_ipi, 0, 1, 1);
+	preempt_enable();
 }
 #else
 void sb1___flush_cache_all(void)
@@ -291,9 +297,13 @@
 {
 	struct flush_icache_range_args args;
 
+	preempt_disable();
+
 	args.start = start;
 	args.end = end;
 	on_each_cpu(sb1_flush_icache_range_ipi, &args, 1, 1);
+
+	preempt_enable();
 }
 #else
 void sb1_flush_icache_range(unsigned long start, unsigned long end)
@@ -348,9 +358,14 @@
 
 	if (!(vma->vm_flags & VM_EXEC))
 		return;
+
+	preempt_disable();
+
 	args.vma = vma;
 	args.page = page;
 	on_each_cpu(sb1_flush_icache_page_ipi, (void *) &args, 1, 1);
+
+	preempt_enable();
 }
 #else
 void sb1_flush_icache_page(struct vm_area_struct *vma, struct page
*page)
@@ -377,7 +392,9 @@
 
 static void sb1_flush_cache_sigtramp(unsigned long addr)
 {
+	preempt_disable();
 	on_each_cpu(sb1_flush_cache_sigtramp_ipi, (void *) addr, 1, 1);
+	preempt_enable();
 }
 #else
 void sb1_flush_cache_sigtramp(unsigned long addr)
Index: linux-2.6.8.1/arch/mips/mm/tlb-sb1.c
===================================================================
--- linux-2.6.8.1.orig/arch/mips/mm/tlb-sb1.c
+++ linux-2.6.8.1/arch/mips/mm/tlb-sb1.c
@@ -286,10 +286,17 @@
    these entries, we just bump the asid. */
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
-	int cpu = smp_processor_id();
+	int cpu;
+
+	preempt_disable();
+
+	cpu = smp_processor_id();
+
 	if (cpu_context(cpu, mm) != 0) {
 		drop_mmu_context(mm, cpu);
 	}
+
+	preempt_enable();
 }
 
 /* Stolen from mips32 routines */
Index: linux-2.6.8.1/arch/mips/kernel/traps.c
===================================================================
--- linux-2.6.8.1.orig/arch/mips/kernel/traps.c
+++ linux-2.6.8.1/arch/mips/kernel/traps.c
@@ -411,6 +411,8 @@
 		goto sig;
 	}
 
+	preempt_disable();
+
 	if (ll_task == NULL || ll_task == current) {
 		ll_bit = 1;
 	} else {
@@ -418,6 +420,8 @@
 	}
 	ll_task = current;
 
+	preempt_enable();
+
 	regs->regs[(opcode & RT) >> 16] = value;
 
 	compute_return_epc(regs);
@@ -450,12 +454,18 @@
 		signal = SIGBUS;
 		goto sig;
 	}
+
+	preempt_disable();
+
 	if (ll_bit == 0 || ll_task != current) {
 		regs->regs[reg] = 0;
+		preempt_enable();
 		compute_return_epc(regs);
 		return;
 	}
 
+	preempt_enable();
+
 	if (put_user(regs->regs[reg], vaddr)) {
 		signal = SIGSEGV;
 		goto sig;
@@ -515,6 +525,8 @@
 	if (fcr31 & FPU_CSR_UNI_X) {
 		int sig;
 
+		preempt_disable();
+
 		/*
 	 	 * Unimplemented operation exception.  If we've got the full
 		 * software emulator on-board, let's use it...
@@ -540,6 +552,8 @@
 		/* Restore the hardware register state */
 		restore_fp(current);
 
+		preempt_enable();
+
 		/* If something went wrong, signal */
 		if (sig)
 			force_sig(sig, current);
@@ -659,6 +673,8 @@
 		break;
 
 	case 1:
+		preempt_disable();
+
 		own_fpu();
 		if (current->used_math) {	/* Using the FPU again.  */
 			restore_fp(current);
@@ -674,6 +690,8 @@
 				force_sig(sig, current);
 		}
 
+		preempt_enable();
+
 		return;
 
 	case 2:
Index: linux-2.6.8.1/arch/mips/kernel/process.c
===================================================================
--- linux-2.6.8.1.orig/arch/mips/kernel/process.c
+++ linux-2.6.8.1/arch/mips/kernel/process.c
@@ -99,10 +99,14 @@
 
 	childksp = (unsigned long)ti + THREAD_SIZE - 32;
 
+	preempt_disable();
+
 	if (is_fpu_owner()) {
 		save_fp(p);
 	}
 
+	preempt_enable();
+
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
 	*childregs = *regs;
Index: linux-2.6.8.1/arch/mips/kernel/signal.c
===================================================================
--- linux-2.6.8.1.orig/arch/mips/kernel/signal.c
+++ linux-2.6.8.1/arch/mips/kernel/signal.c
@@ -178,6 +178,8 @@
 
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
+	preempt_disable();
+
 	if (current->used_math) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
@@ -187,6 +189,8 @@
 		lose_fpu();
 	}
 
+	preempt_enable();
+
 	return err;
 }
 
@@ -320,12 +324,16 @@
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
 	 */
+	preempt_disable();
+
 	if (!is_fpu_owner()) {
 		own_fpu();
 		restore_fp(current);
 	}
 	err |= save_fp_context(sc);
 
+	preempt_enable();
+
 out:
 	return err;
 }
