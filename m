Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 23:54:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:57085 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225541AbSLTXyC>;
	Fri, 20 Dec 2002 23:54:02 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBKNrva18963;
	Fri, 20 Dec 2002 15:53:57 -0800
Date: Fri, 20 Dec 2002 15:53:57 -0800
From: Jun Sun <jsun@mvista.com>
To: Colin.Helliwell@Zarlink.Com
Cc: linux-mips@linux-mips.org, rml@mvista.com, jsun@mvista.com
Subject: Re: Problems with CONFIG_PREEMPT
Message-ID: <20021220155357.C17705@mvista.com>
References: <OF2066EDAB.79E8E12E-ON80256C95.00517ECB@zarlink.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF2066EDAB.79E8E12E-ON80256C95.00517ECB@zarlink.com>; from Colin.Helliwell@Zarlink.Com on Fri, Dec 20, 2002 at 02:51:24PM +0000
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I attached the additional patch I was referring to.

Unfortunately it is against our internel kernel base.   I have not had
time to adapt it to the linux-mips.org base yet.  But it should be
easy to adapt it.

Let me know if it makes things better.

Jun

On Fri, Dec 20, 2002 at 02:51:24PM +0000, Colin.Helliwell@Zarlink.Com wrote:
> 
> Think I'm ok with respect to interrupt handling, but what does making
> globals "safe or taken care of" consist of?
> 
> 
> 
> 
>                                                                                                                                        
>                       Jun Sun                                                                                                          
>                       <jsun@mvista.com>        To:       Colin.Helliwell@Zarlink.Com                                                   
>                                                cc:       linux-mips@linux-mips.org, rml@mvista.com, jsun@mvista.com                    
>                       19-Dec-2002 05:59        Subject:  Re: Problems with CONFIG_PREEMPT                                              
>                       PM                                                                                                               
>                                                                                                                                        
>                                                                                                                                        
> 
> 
> 
> 
> On Thu, Dec 19, 2002 at 09:10:40AM +0000, Colin.Helliwell@Zarlink.Com
> wrote:
> >
> > Thanks for the patch, but unfortunately the problem is still the same.
> 
> If the problem happens very soon after you boot up, there is something
> *obviously* wrong.  The most common problem is that you have an interupt
> handling path not going through standard do_IRQ().  Then you need to
> do similar treatment like those in ll_timer_interrupt().
> 
> The second thing is to look for any *new* global variables you may
> introduce in your kernel.  Most of current global variables are either
> safe or taken care of (Although another update patch will come out
> today or tomorrow to really close the final hole we have).
> 
> > I'm
> > not sure whether it occurs as a result of interrupts, or just after a
> > certain amount of scheduler 'activity' as it sits there copying the
> initrd
> > into ram disk. A few interrupts are enabled, but its only the MIPS timer
> > which should be generating any interrupts at that point (I'll check that,
> > in case its relevant).
> 
> FYI, I have mips kernel with initrd running just fine with preemptible
> kernel.
> In fact, it has passed some very stressful tests with initrd.
> 
> > I presume the change from "sti()" to "__sti()" was a semantic (or SMP)
> > thing, since the former is #defined to the latter anyway? Please note
> also
> > the following modification which was required to 2.4.19:
> >
> 
> This is true.  Since our kernel had synchronize_irq() added long time ago,
> I probably forgot about it when I created the pre-k patch.
> 
> Jun
> 
> 
> 
> 
> 

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pre-k-safe-with-new-fpu.patch"

diff -Nru linux2/arch/mips/kernel/traps.c.orig linux2/arch/mips/kernel/traps.c
--- linux2/arch/mips/kernel/traps.c.orig	Wed Dec 18 17:41:11 2002
+++ linux2/arch/mips/kernel/traps.c	Fri Dec 20 15:05:08 2002
@@ -131,12 +131,14 @@
 	else if (get_user(value, vaddr))
 		signal = SIGSEGV;
 	else {
+		preempt_disable();
 		if (ll_task == NULL || ll_task == current) {
 			ll_bit = 1;
 		} else {
 			ll_bit = 0;
 		}
 		ll_task = current;
+		preempt_enable();
 		regp->regs[(opcode & RT) >> 16] = value;
 	}
 	if (compute_return_epc(regp))
@@ -168,6 +170,7 @@
 	sc_ops++;
 #endif
 
+	preempt_disable();
 	if ((unsigned long)vaddr & 3)
 		signal = SIGBUS;
 	else if (ll_bit == 0 || ll_task != current)
@@ -176,6 +179,7 @@
 		signal = SIGSEGV;
 	else
 		regp->regs[reg] = 1;
+	preempt_enable();
 	if (compute_return_epc(regp))
 		return;
 	if (signal)
@@ -551,6 +555,9 @@
 	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
 	if (fcr31 & FPU_CSR_UNI_X) {
 		int sig;
+
+		preempt_disable();
+
 		/*
 	 	 * Unimplemented operation exception.  If we've got the
 	 	 * full software emulator on-board, let's use it...
@@ -576,6 +583,8 @@
 		/* Restore the hardware register state */
 		restore_fp(current);
 
+		preempt_enable();
+
 		/* If something went wrong, signal */
 		if (sig)
 			force_sig(sig, current);
@@ -756,6 +765,8 @@
 
 	die_if_kernel("do_cpu invoked from kernel context!", regs);
 	
+	preempt_disable();
+
 	own_fpu();
 	if (current->used_math) {		/* Using the FPU again.  */
 		restore_fp(current);
@@ -772,6 +783,8 @@
 		}
 	}
 
+	preempt_enable();
+
 	TRACE_TRAP_EXIT();
 	return;
 
diff -Nru linux2/arch/mips/kernel/process.c.orig linux2/arch/mips/kernel/process.c
--- linux2/arch/mips/kernel/process.c.orig	Wed Dec 18 17:41:11 2002
+++ linux2/arch/mips/kernel/process.c	Fri Dec 20 15:04:38 2002
@@ -80,9 +80,11 @@
 
 	childksp = (unsigned long)p + KERNEL_STACK_SIZE - 32;
 
+	preempt_disable();
 	if (is_fpu_owner()) {
 		save_fp(p);
 	}
+	preempt_enable();
 
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
diff -Nru linux2/arch/mips/kernel/signal.c.orig linux2/arch/mips/kernel/signal.c
--- linux2/arch/mips/kernel/signal.c.orig	Wed Dec 18 17:41:11 2002
+++ linux2/arch/mips/kernel/signal.c	Fri Dec 20 15:04:54 2002
@@ -214,6 +214,8 @@
 
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
+	preempt_disable();
+
 	if (current->used_math) {
 		own_fpu();
 		err |= restore_fp_context(sc);
@@ -221,6 +223,8 @@
 		loose_fpu();
 	}
 
+	preempt_enable();
+
 	return err;
 }
 
@@ -348,6 +352,8 @@
 	if (!current->used_math)
 		goto out;
 
+	preempt_disable();
+
 	/* There exists FP thread state that may be trashed by signal */
 	if (!is_fpu_owner()) {
 		own_fpu();
@@ -357,6 +363,8 @@
 	/* fp is active.  Save context from FPU */
 	err |= save_fp_context(sc);
 
+	preempt_enable();
+
 out:
 	return err;
 }
diff -Nru linux2/include/asm-mips/pgalloc.h.orig linux2/include/asm-mips/pgalloc.h
--- linux2/include/asm-mips/pgalloc.h.orig	Mon Dec 16 18:16:04 2002
+++ linux2/include/asm-mips/pgalloc.h	Wed Dec 18 17:46:06 2002
@@ -11,6 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
+#include <linux/sched.h>
 #include <asm/fixmap.h>
 
 /* TLB flushing:
@@ -84,20 +85,26 @@
 {
 	unsigned long *ret;
 
+	preempt_disable();
 	if((ret = pgd_quicklist) != NULL) {
 		pgd_quicklist = (unsigned long *)(*ret);
 		ret[0] = ret[1];
 		pgtable_cache_size--;
-	} else
+		preempt_enable();
+	} else {
+		preempt_enable();
 		ret = (unsigned long *)get_pgd_slow();
+	}
 	return (pgd_t *)ret;
 }
 
 extern __inline__ void free_pgd_fast(pgd_t *pgd)
 {
+	preempt_disable();
 	*(unsigned long *)pgd = (unsigned long) pgd_quicklist;
 	pgd_quicklist = (unsigned long *) pgd;
 	pgtable_cache_size++;
+	preempt_enable();
 }
 
 extern __inline__ void free_pgd_slow(pgd_t *pgd)
@@ -109,19 +116,23 @@
 {
 	unsigned long *ret;
 
+	preempt_disable();
 	if((ret = (unsigned long *)pte_quicklist) != NULL) {
 		pte_quicklist = (unsigned long *)(*ret);
 		ret[0] = ret[1];
 		pgtable_cache_size--;
 	}
+	preempt_enable();
 	return (pte_t *)ret;
 }
 
 extern __inline__ void free_pte_fast(pte_t *pte)
 {
+	preempt_disable();
 	*(unsigned long *)pte = (unsigned long) pte_quicklist;
 	pte_quicklist = (unsigned long *) pte;
 	pgtable_cache_size++;
+	preempt_enable();
 }
 
 extern __inline__ void free_pte_slow(pte_t *pte)
diff -Nru linux2/include/asm-mips/fpu.h.orig linux2/include/asm-mips/fpu.h
--- linux2/include/asm-mips/fpu.h.orig	Wed Dec 18 17:53:17 2002
+++ linux2/include/asm-mips/fpu.h	Fri Dec 20 15:03:32 2002
@@ -120,11 +120,14 @@
 
 static inline unsigned long long *get_fpu_regs(struct task_struct *tsk)
 {
+	preempt_disable();
 	if(mips_cpu.options & MIPS_CPU_FPU) {
 		if ((tsk == current) && is_fpu_owner()) 
 			_save_fp(current);
+		preempt_enable();
 		return (unsigned long long *)&tsk->thread.fpu.hard.fp_regs[0];
 	} else {
+		preempt_enable();
 		return (unsigned long long *)tsk->thread.fpu.soft.regs;
 	}
 }

--UlVJffcvxoiEqYs2--
