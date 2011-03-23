Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:15:33 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47452 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491919Ab1CWVJG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:06 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIb-0001w6-08; Wed, 23 Mar 2011 22:09:01 +0100
Message-Id: <20110323210536.185612308@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 17/38] mips: rm7000: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-kernel-rm7000.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/irq-rm7000.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux-mips-next/arch/mips/kernel/irq-rm7000.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/irq-rm7000.c
+++ linux-mips-next/arch/mips/kernel/irq-rm7000.c
@@ -18,23 +18,23 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 
-static inline void unmask_rm7k_irq(unsigned int irq)
+static inline void unmask_rm7k_irq(struct irq_data *d)
 {
-	set_c0_intcontrol(0x100 << (irq - RM7K_CPU_IRQ_BASE));
+	set_c0_intcontrol(0x100 << (d->irq - RM7K_CPU_IRQ_BASE));
 }
 
-static inline void mask_rm7k_irq(unsigned int irq)
+static inline void mask_rm7k_irq(struct irq_data *d)
 {
-	clear_c0_intcontrol(0x100 << (irq - RM7K_CPU_IRQ_BASE));
+	clear_c0_intcontrol(0x100 << (d->irq - RM7K_CPU_IRQ_BASE));
 }
 
 static struct irq_chip rm7k_irq_controller = {
 	.name = "RM7000",
-	.ack = mask_rm7k_irq,
-	.mask = mask_rm7k_irq,
-	.mask_ack = mask_rm7k_irq,
-	.unmask = unmask_rm7k_irq,
-	.eoi	= unmask_rm7k_irq
+	.irq_ack = mask_rm7k_irq,
+	.irq_mask = mask_rm7k_irq,
+	.irq_mask_ack = mask_rm7k_irq,
+	.irq_unmask = unmask_rm7k_irq,
+	.irq_eoi = unmask_rm7k_irq
 };
 
 void __init rm7k_cpu_irq_init(void)
