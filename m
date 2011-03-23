Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:16:19 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47458 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491921Ab1CWVJI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:08 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIc-0001wJ-GK; Wed, 23 Mar 2011 22:09:02 +0100
Message-Id: <20110323210536.374252103@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:02 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 19/38] misp: irq_cpu: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=misp-kerenl-irq-cpu.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/irq_cpu.c |   46 ++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

Index: linux-mips-next/arch/mips/kernel/irq_cpu.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/irq_cpu.c
+++ linux-mips-next/arch/mips/kernel/irq_cpu.c
@@ -37,42 +37,38 @@
 #include <asm/mipsmtregs.h>
 #include <asm/system.h>
 
-static inline void unmask_mips_irq(unsigned int irq)
+static inline void unmask_mips_irq(struct irq_data *d)
 {
-	set_c0_status(0x100 << (irq - MIPS_CPU_IRQ_BASE));
+	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
 	irq_enable_hazard();
 }
 
-static inline void mask_mips_irq(unsigned int irq)
+static inline void mask_mips_irq(struct irq_data *d)
 {
-	clear_c0_status(0x100 << (irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
 	irq_disable_hazard();
 }
 
 static struct irq_chip mips_cpu_irq_controller = {
 	.name		= "MIPS",
-	.ack		= mask_mips_irq,
-	.mask		= mask_mips_irq,
-	.mask_ack	= mask_mips_irq,
-	.unmask		= unmask_mips_irq,
-	.eoi		= unmask_mips_irq,
+	.irq_ack	= mask_mips_irq,
+	.irq_mask	= mask_mips_irq,
+	.irq_mask_ack	= mask_mips_irq,
+	.irq_unmask	= unmask_mips_irq,
+	.irq_eoi	= unmask_mips_irq,
 };
 
 /*
  * Basically the same as above but taking care of all the MT stuff
  */
 
-#define unmask_mips_mt_irq	unmask_mips_irq
-#define mask_mips_mt_irq	mask_mips_irq
-
-static unsigned int mips_mt_cpu_irq_startup(unsigned int irq)
+static unsigned int mips_mt_cpu_irq_startup(struct irq_data *d)
 {
 	unsigned int vpflags = dvpe();
 
-	clear_c0_cause(0x100 << (irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_cause(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
 	evpe(vpflags);
-	unmask_mips_mt_irq(irq);
-
+	unmask_mips_irq(d);
 	return 0;
 }
 
@@ -80,22 +76,22 @@ static unsigned int mips_mt_cpu_irq_star
  * While we ack the interrupt interrupts are disabled and thus we don't need
  * to deal with concurrency issues.  Same for mips_cpu_irq_end.
  */
-static void mips_mt_cpu_irq_ack(unsigned int irq)
+static void mips_mt_cpu_irq_ack(struct irq_data *d)
 {
 	unsigned int vpflags = dvpe();
-	clear_c0_cause(0x100 << (irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_cause(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
 	evpe(vpflags);
-	mask_mips_mt_irq(irq);
+	mask_mips_irq(d);
 }
 
 static struct irq_chip mips_mt_cpu_irq_controller = {
 	.name		= "MIPS",
-	.startup	= mips_mt_cpu_irq_startup,
-	.ack		= mips_mt_cpu_irq_ack,
-	.mask		= mask_mips_mt_irq,
-	.mask_ack	= mips_mt_cpu_irq_ack,
-	.unmask		= unmask_mips_mt_irq,
-	.eoi		= unmask_mips_mt_irq,
+	.irq_startup	= mips_mt_cpu_irq_startup,
+	.irq_ack	= mips_mt_cpu_irq_ack,
+	.irq_mask	= mask_mips_irq,
+	.irq_mask_ack	= mips_mt_cpu_irq_ack,
+	.irq_unmask	= unmask_mips_irq,
+	.irq_eoi	= unmask_mips_irq,
 };
 
 void __init mips_cpu_irq_init(void)
