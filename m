Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 12:42:26 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:51084 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493393Ab1AQLmW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 12:42:22 +0100
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=laptop)
        by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1PenSP-0004PP-A0; Mon, 17 Jan 2011 11:41:09 +0000
Received: by laptop (Postfix, from userid 1000)
        id DC23E10067263; Mon, 17 Jan 2011 12:41:49 +0100 (CET)
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
 smp_send_reschedule()
From:   Peter Zijlstra <peterz@infradead.org>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
        Linux-Arch <linux-arch@vger.kernel.org>
In-Reply-To: <1295263884.30950.54.camel@laptop>
References: <1295262433.30950.53.camel@laptop>
         <20110117112637.GA18599@n2100.arm.linux.org.uk>
         <1295263884.30950.54.camel@laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Mon, 17 Jan 2011 12:41:49 +0100
Message-ID: <1295264509.30950.59.camel@laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

On Mon, 2011-01-17 at 12:31 +0100, Peter Zijlstra wrote:
> On Mon, 2011-01-17 at 11:26 +0000, Russell King - ARM Linux wrote:

> > Maybe remove the comment "everything is done on the interrupt return path"
> > as with this function call, that is no longer the case.

(Removed am33, m32r-ka, m32r, arm-kernel lists because they kept sending
bounces)

---
Subject: sched: provide scheduler_ipi() callback in response to smp_send_reschedule()
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 17 Jan 2011 12:07:13 +0100

For future rework of try_to_wake_up() we'd like to push part of that
onto the CPU the task is actually going to run on, in order to do so we
need a generic callback from the existing scheduler IPI.

This patch introduces such a generic callback: scheduler_ipi() and
implements it as a NOP.

I visited existing smp_send_reschedule() implementations and tried to
add a call to scheduler_ipi() in their handler part, but esp. for MIPS
I'm not quite sure I actually got all of them.

Also, while reading through all this, I noticed the blackfin SMP code
looks to be broken, it simply discards any IPI when low on memory.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
LKML-Reference: <new-submission>
---
 arch/alpha/kernel/smp.c         |    3 +--
 arch/arm/kernel/smp.c           |    5 +----
 arch/blackfin/mach-common/smp.c |    5 ++---
 arch/cris/arch-v32/kernel/smp.c |   13 ++++++++-----
 arch/ia64/kernel/irq_ia64.c     |    2 ++
 arch/ia64/xen/irq_xen.c         |   10 +++++++++-
 arch/m32r/kernel/smp.c          |    4 +---
 arch/mips/kernel/smtc.c         |    2 +-
 arch/mips/sibyte/bcm1480/smp.c  |    7 +++----
 arch/mips/sibyte/sb1250/smp.c   |    7 +++----
 arch/mn10300/kernel/smp.c       |    5 +----
 arch/parisc/kernel/smp.c        |    5 +----
 arch/powerpc/kernel/smp.c       |    2 +-
 arch/s390/kernel/smp.c          |    6 +++---
 arch/sh/kernel/smp.c            |    2 ++
 arch/sparc/kernel/smp_32.c      |    2 +-
 arch/sparc/kernel/smp_64.c      |    1 +
 arch/tile/kernel/smp.c          |    6 +-----
 arch/um/kernel/smp.c            |    2 +-
 arch/x86/kernel/smp.c           |    5 ++---
 arch/x86/xen/smp.c              |    5 ++---
 include/linux/sched.h           |    1 +
 22 files changed, 48 insertions(+), 52 deletions(-)

Index: linux-2.6/arch/alpha/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/alpha/kernel/smp.c
+++ linux-2.6/arch/alpha/kernel/smp.c
@@ -585,8 +585,7 @@ handle_ipi(struct pt_regs *regs)
 
 		switch (which) {
 		case IPI_RESCHEDULE:
-			/* Reschedule callback.  Everything to be done
-			   is done by the interrupt return path.  */
+			scheduler_ipi();
 			break;
 
 		case IPI_CALL_FUNC:
Index: linux-2.6/arch/arm/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/smp.c
+++ linux-2.6/arch/arm/kernel/smp.c
@@ -575,10 +575,7 @@ asmlinkage void __exception do_IPI(struc
 				break;
 
 			case IPI_RESCHEDULE:
-				/*
-				 * nothing more to do - eveything is
-				 * done on the interrupt return path
-				 */
+				scheduler_ipi();
 				break;
 
 			case IPI_CALL_FUNC:
Index: linux-2.6/arch/blackfin/mach-common/smp.c
===================================================================
--- linux-2.6.orig/arch/blackfin/mach-common/smp.c
+++ linux-2.6/arch/blackfin/mach-common/smp.c
@@ -154,8 +154,7 @@ static irqreturn_t ipi_handler(int irq, 
 		list_del(&msg->list);
 		switch (msg->type) {
 		case BFIN_IPI_RESCHEDULE:
-			/* That's the easiest one; leave it to
-			 * return_from_int. */
+			scheduler_ipi();
 			kfree(msg);
 			break;
 		case BFIN_IPI_CALL_FUNC:
@@ -301,7 +300,7 @@ void smp_send_reschedule(int cpu)
 
 	msg = kzalloc(sizeof(*msg), GFP_ATOMIC);
 	if (!msg)
-		return;
+		return; /* XXX unreliable needs fixing ! */
 	INIT_LIST_HEAD(&msg->list);
 	msg->type = BFIN_IPI_RESCHEDULE;
 
Index: linux-2.6/arch/cris/arch-v32/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/kernel/smp.c
+++ linux-2.6/arch/cris/arch-v32/kernel/smp.c
@@ -340,15 +340,18 @@ irqreturn_t crisv32_ipi_interrupt(int ir
 
 	ipi = REG_RD(intr_vect, irq_regs[smp_processor_id()], rw_ipi);
 
+	if (ipi.vector & IPI_SCHEDULE) {
+		scheduler_ipi();
+	}
 	if (ipi.vector & IPI_CALL) {
-	         func(info);
+		func(info);
 	}
 	if (ipi.vector & IPI_FLUSH_TLB) {
-		     if (flush_mm == FLUSH_ALL)
-			 __flush_tlb_all();
-		     else if (flush_vma == FLUSH_ALL)
+		if (flush_mm == FLUSH_ALL)
+			__flush_tlb_all();
+		else if (flush_vma == FLUSH_ALL)
 			__flush_tlb_mm(flush_mm);
-		     else
+		else
 			__flush_tlb_page(flush_vma, flush_addr);
 	}
 
Index: linux-2.6/arch/ia64/kernel/irq_ia64.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/irq_ia64.c
+++ linux-2.6/arch/ia64/kernel/irq_ia64.c
@@ -31,6 +31,7 @@
 #include <linux/irq.h>
 #include <linux/ratelimit.h>
 #include <linux/acpi.h>
+#include <linux/sched.h>
 
 #include <asm/delay.h>
 #include <asm/intrinsics.h>
@@ -496,6 +497,7 @@ ia64_handle_irq (ia64_vector vector, str
 			smp_local_flush_tlb();
 			kstat_incr_irqs_this_cpu(irq, desc);
 		} else if (unlikely(IS_RESCHEDULE(vector))) {
+			scheduler_ipi();
 			kstat_incr_irqs_this_cpu(irq, desc);
 		} else {
 			ia64_setreg(_IA64_REG_CR_TPR, vector);
Index: linux-2.6/arch/ia64/xen/irq_xen.c
===================================================================
--- linux-2.6.orig/arch/ia64/xen/irq_xen.c
+++ linux-2.6/arch/ia64/xen/irq_xen.c
@@ -92,6 +92,8 @@ static unsigned short saved_irq_cnt;
 static int xen_slab_ready;
 
 #ifdef CONFIG_SMP
+#include <linux/sched.h>
+
 /* Dummy stub. Though we may check XEN_RESCHEDULE_VECTOR before __do_IRQ,
  * it ends up to issue several memory accesses upon percpu data and
  * thus adds unnecessary traffic to other paths.
@@ -99,7 +101,13 @@ static int xen_slab_ready;
 static irqreturn_t
 xen_dummy_handler(int irq, void *dev_id)
 {
+	return IRQ_HANDLED;
+}
 
+static irqreturn_t
+xen_resched_handler(int irq, void *dev_id)
+{
+	scheduler_ipi();
 	return IRQ_HANDLED;
 }
 
@@ -110,7 +118,7 @@ static struct irqaction xen_ipi_irqactio
 };
 
 static struct irqaction xen_resched_irqaction = {
-	.handler =	xen_dummy_handler,
+	.handler =	xen_resched_handler,
 	.flags =	IRQF_DISABLED,
 	.name =		"resched"
 };
Index: linux-2.6/arch/m32r/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/smp.c
+++ linux-2.6/arch/m32r/kernel/smp.c
@@ -122,8 +122,6 @@ void smp_send_reschedule(int cpu_id)
  *
  * Description:  This routine executes on CPU which received
  *               'RESCHEDULE_IPI'.
- *               Rescheduling is processed at the exit of interrupt
- *               operation.
  *
  * Born on Date: 2002.02.05
  *
@@ -138,7 +136,7 @@ void smp_send_reschedule(int cpu_id)
  *==========================================================================*/
 void smp_reschedule_interrupt(void)
 {
-	/* nothing to do */
+	scheduler_ipi();
 }
 
 /*==========================================================================*
Index: linux-2.6/arch/mips/kernel/smtc.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/smtc.c
+++ linux-2.6/arch/mips/kernel/smtc.c
@@ -930,7 +930,7 @@ static void post_direct_ipi(int cpu, str
 
 static void ipi_resched_interrupt(void)
 {
-	/* Return from interrupt should be enough to cause scheduler check */
+	scheduler_ipi();
 }
 
 static void ipi_call_interrupt(void)
Index: linux-2.6/arch/mips/sibyte/bcm1480/smp.c
===================================================================
--- linux-2.6.orig/arch/mips/sibyte/bcm1480/smp.c
+++ linux-2.6/arch/mips/sibyte/bcm1480/smp.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/smp.h>
 #include <linux/kernel_stat.h>
+#include <linux/sched.h>
 
 #include <asm/mmu_context.h>
 #include <asm/io.h>
@@ -189,10 +190,8 @@ void bcm1480_mailbox_interrupt(void)
 	/* Clear the mailbox to clear the interrupt */
 	__raw_writeq(((u64)action)<<48, mailbox_0_clear_regs[cpu]);
 
-	/*
-	 * Nothing to do for SMP_RESCHEDULE_YOURSELF; returning from the
-	 * interrupt will do the reschedule for us
-	 */
+	if (actione & SMP_RESCHEDULE_YOURSELF)
+		scheduler_ipi();
 
 	if (action & SMP_CALL_FUNCTION)
 		smp_call_function_interrupt();
Index: linux-2.6/arch/mips/sibyte/sb1250/smp.c
===================================================================
--- linux-2.6.orig/arch/mips/sibyte/sb1250/smp.c
+++ linux-2.6/arch/mips/sibyte/sb1250/smp.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/kernel_stat.h>
+#include <linux/sched.h>
 
 #include <asm/mmu_context.h>
 #include <asm/io.h>
@@ -177,10 +178,8 @@ void sb1250_mailbox_interrupt(void)
 	/* Clear the mailbox to clear the interrupt */
 	____raw_writeq(((u64)action) << 48, mailbox_clear_regs[cpu]);
 
-	/*
-	 * Nothing to do for SMP_RESCHEDULE_YOURSELF; returning from the
-	 * interrupt will do the reschedule for us
-	 */
+	if (action & SMP_RESCHEDULE_YOURSELF)
+		scheduler_ipi();
 
 	if (action & SMP_CALL_FUNCTION)
 		smp_call_function_interrupt();
Index: linux-2.6/arch/mn10300/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/mn10300/kernel/smp.c
+++ linux-2.6/arch/mn10300/kernel/smp.c
@@ -464,14 +464,11 @@ void smp_send_stop(void)
  * @irq: The interrupt number.
  * @dev_id: The device ID.
  *
- * We need do nothing here, since the scheduling will be effected on our way
- * back through entry.S.
- *
  * Returns IRQ_HANDLED to indicate we handled the interrupt successfully.
  */
 static irqreturn_t smp_reschedule_interrupt(int irq, void *dev_id)
 {
-	/* do nothing */
+	scheduler_ipi();
 	return IRQ_HANDLED;
 }
 
Index: linux-2.6/arch/parisc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/smp.c
+++ linux-2.6/arch/parisc/kernel/smp.c
@@ -155,10 +155,7 @@ ipi_interrupt(int irq, void *dev_id) 
 				
 			case IPI_RESCHEDULE:
 				smp_debug(100, KERN_DEBUG "CPU%d IPI_RESCHEDULE\n", this_cpu);
-				/*
-				 * Reschedule callback.  Everything to be
-				 * done is done by the interrupt return path.
-				 */
+				scheduler_ipi();
 				break;
 
 			case IPI_CALL_FUNC:
Index: linux-2.6/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6/arch/powerpc/kernel/smp.c
@@ -127,7 +127,7 @@ static irqreturn_t call_function_action(
 
 static irqreturn_t reschedule_action(int irq, void *data)
 {
-	/* we just need the return path side effect of checking need_resched */
+	scheduler_ipi();
 	return IRQ_HANDLED;
 }
 
Index: linux-2.6/arch/s390/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/smp.c
+++ linux-2.6/arch/s390/kernel/smp.c
@@ -163,12 +163,12 @@ static void do_ext_call_interrupt(unsign
 
 	/*
 	 * handle bit signal external calls
-	 *
-	 * For the ec_schedule signal we have to do nothing. All the work
-	 * is done automatically when we return from the interrupt.
 	 */
 	bits = xchg(&S390_lowcore.ext_call_fast, 0);
 
+	if (test_bit(ec_schedule, &bits))
+		scheduler_ipi();
+
 	if (test_bit(ec_call_function, &bits))
 		generic_smp_call_function_interrupt();
 
Index: linux-2.6/arch/sh/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/smp.c
+++ linux-2.6/arch/sh/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
+#include <linux/sched.h>
 #include <asm/atomic.h>
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -323,6 +324,7 @@ void smp_message_recv(unsigned int msg)
 		generic_smp_call_function_interrupt();
 		break;
 	case SMP_MSG_RESCHEDULE:
+		scheduler_ipi();
 		break;
 	case SMP_MSG_FUNCTION_SINGLE:
 		generic_smp_call_function_single_interrupt();
Index: linux-2.6/arch/sparc/kernel/smp_32.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/smp_32.c
+++ linux-2.6/arch/sparc/kernel/smp_32.c
@@ -125,7 +125,7 @@ struct linux_prom_registers smp_penguin_
 
 void smp_send_reschedule(int cpu)
 {
-	/* See sparc64 */
+	scheduler_ipi();
 }
 
 void smp_send_stop(void)
Index: linux-2.6/arch/sparc/kernel/smp_64.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/smp_64.c
+++ linux-2.6/arch/sparc/kernel/smp_64.c
@@ -1369,6 +1369,7 @@ void smp_send_reschedule(int cpu)
 void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs)
 {
 	clear_softint(1 << irq);
+	scheduler_ipi();
 }
 
 /* This is a nop because we capture all other cpus
Index: linux-2.6/arch/tile/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/tile/kernel/smp.c
+++ linux-2.6/arch/tile/kernel/smp.c
@@ -184,12 +184,8 @@ void flush_icache_range(unsigned long st
 /* Called when smp_send_reschedule() triggers IRQ_RESCHEDULE. */
 static irqreturn_t handle_reschedule_ipi(int irq, void *token)
 {
-	/*
-	 * Nothing to do here; when we return from interrupt, the
-	 * rescheduling will occur there. But do bump the interrupt
-	 * profiler count in the meantime.
-	 */
 	__get_cpu_var(irq_stat).irq_resched_count++;
+	scheduler_ipi();
 
 	return IRQ_HANDLED;
 }
Index: linux-2.6/arch/um/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/smp.c
+++ linux-2.6/arch/um/kernel/smp.c
@@ -173,7 +173,7 @@ void IPI_handler(int cpu)
 			break;
 
 		case 'R':
-			set_tsk_need_resched(current);
+			scheduler_ipi();
 			break;
 
 		case 'S':
Index: linux-2.6/arch/x86/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/smp.c
+++ linux-2.6/arch/x86/kernel/smp.c
@@ -194,14 +194,13 @@ static void native_stop_other_cpus(int w
 }
 
 /*
- * Reschedule call back. Nothing to do,
- * all the work is done automatically when
- * we return from the interrupt.
+ * Reschedule call back.
  */
 void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
 	inc_irq_stat(irq_resched_count);
+	scheduler_ipi();
 	/*
 	 * KVM uses this interrupt to force a cpu out of guest mode
 	 */
Index: linux-2.6/arch/x86/xen/smp.c
===================================================================
--- linux-2.6.orig/arch/x86/xen/smp.c
+++ linux-2.6/arch/x86/xen/smp.c
@@ -46,13 +46,12 @@ static irqreturn_t xen_call_function_int
 static irqreturn_t xen_call_function_single_interrupt(int irq, void *dev_id);
 
 /*
- * Reschedule call back. Nothing to do,
- * all the work is done automatically when
- * we return from the interrupt.
+ * Reschedule call back.
  */
 static irqreturn_t xen_reschedule_interrupt(int irq, void *dev_id)
 {
 	inc_irq_stat(irq_resched_count);
+	scheduler_ipi();
 
 	return IRQ_HANDLED;
 }
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -2183,6 +2183,7 @@ extern void set_task_comm(struct task_st
 extern char *get_task_comm(char *to, struct task_struct *tsk);
 
 #ifdef CONFIG_SMP
+static inline void scheduler_ipi(void) { }
 extern unsigned long wait_task_inactive(struct task_struct *, long match_state);
 #else
 static inline unsigned long wait_task_inactive(struct task_struct *p,
