Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:19:52 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47485 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491930Ab1CWVJP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:15 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIk-0001wk-4S; Wed, 23 Mar 2011 22:09:10 +0100
Message-Id: <20110323210537.218350094@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:09 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 28/38] mips: powertv: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-powertv.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/powertv/asic/irq_asic.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: linux-mips-next/arch/mips/powertv/asic/irq_asic.c
===================================================================
--- linux-mips-next.orig/arch/mips/powertv/asic/irq_asic.c
+++ linux-mips-next/arch/mips/powertv/asic/irq_asic.c
@@ -21,9 +21,10 @@
 
 #include <asm/mach-powertv/asic_regs.h>
 
-static inline void unmask_asic_irq(unsigned int irq)
+static inline void unmask_asic_irq(struct irq_data *d)
 {
 	unsigned long enable_bit;
+	unsigned int irq = d->irq;
 
 	enable_bit = (1 << (irq & 0x1f));
 
@@ -45,9 +46,10 @@ static inline void unmask_asic_irq(unsig
 	}
 }
 
-static inline void mask_asic_irq(unsigned int irq)
+static inline void mask_asic_irq(struct irq_data *d)
 {
 	unsigned long disable_mask;
+	unsigned int irq = d->irq;
 
 	disable_mask = ~(1 << (irq & 0x1f));
 
@@ -71,11 +73,8 @@ static inline void mask_asic_irq(unsigne
 
 static struct irq_chip asic_irq_chip = {
 	.name = "ASIC Level",
-	.ack = mask_asic_irq,
-	.mask = mask_asic_irq,
-	.mask_ack = mask_asic_irq,
-	.unmask = unmask_asic_irq,
-	.eoi = unmask_asic_irq,
+	.irq_mask = mask_asic_irq,
+	.irq_unmask = unmask_asic_irq,
 };
 
 void __init asic_irq_init(void)
