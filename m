Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:37:59 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025290AbbDCWcIk6C0f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:32:08 +0200
Date:   Fri, 3 Apr 2015 23:32:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: DEC: Implement FPU interrupt counter
Message-ID: <alpine.LFD.2.11.1503041530570.18344@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Implement a cheap way to count FPU interrupts for R2k/R3k DECstation
systems.  Do this manually in handcoded assembly, rather than calling
`kstat_incr_irq_this_cpu' that would require setting up a stack frame
and a lot of redirection.  This is not going to be a problem because the
FPU interrupt is local to the CPU and also there is one CPU only anyway.

So at bootstrap determine the address of the correct location within 
`struct irq_desc', and then only refer to it directly in the interrupt 
handler.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-dec-kstat_irq_fpu.patch
Index: linux-20150220-3maxp/arch/mips/dec/int-handler.S
===================================================================
--- linux-20150220-3maxp.orig/arch/mips/dec/int-handler.S
+++ linux-20150220-3maxp/arch/mips/dec/int-handler.S
@@ -267,8 +267,13 @@
 
 #ifdef CONFIG_32BIT
 fpu:
+		lw	t0,fpu_kstat_irq
+		nop
+		lw	t1,(t0)
+		nop
+		addu	t1,1
 		j	handle_fpe_int
-		 nop
+		 sw	t1,(t0)
 #endif
 
 spurious:
Index: linux-20150220-3maxp/arch/mips/dec/setup.c
===================================================================
--- linux-20150220-3maxp.orig/arch/mips/dec/setup.c
+++ linux-20150220-3maxp/arch/mips/dec/setup.c
@@ -12,13 +12,15 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/irqnr.h>
 #include <linux/module.h>
 #include <linux/param.h>
+#include <linux/percpu-defs.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/pm.h>
-#include <linux/irq.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -98,6 +100,7 @@ int_ptr asic_mask_nr_tbl[DEC_MAX_ASIC_IN
 	{ { .i = ~0 }, { .p = asic_intr_unimplemented } },
 };
 int cpu_fpu_mask = DEC_CPU_IRQ_MASK(DEC_CPU_INR_FPU);
+int *fpu_kstat_irq;
 
 static struct irqaction ioirq = {
 	.handler = no_action,
@@ -755,8 +758,15 @@ void __init arch_init_irq(void)
 		dec_interrupt[DEC_IRQ_HALT] = -1;
 
 	/* Register board interrupts: FPU and cascade. */
-	if (dec_interrupt[DEC_IRQ_FPU] >= 0)
-		setup_irq(dec_interrupt[DEC_IRQ_FPU], &fpuirq);
+	if (dec_interrupt[DEC_IRQ_FPU] >= 0) {
+		struct irq_desc *desc_fpu;
+		int irq_fpu;
+
+		irq_fpu = dec_interrupt[DEC_IRQ_FPU];
+		setup_irq(irq_fpu, &fpuirq);
+		desc_fpu = irq_to_desc(irq_fpu);
+		fpu_kstat_irq = this_cpu_ptr(desc_fpu->kstat_irqs);
+	}
 	if (dec_interrupt[DEC_IRQ_CASCADE] >= 0)
 		setup_irq(dec_interrupt[DEC_IRQ_CASCADE], &ioirq);
 
