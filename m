Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:16:42 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491922Ab1CWVJI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:08 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VId-0001wM-AA; Wed, 23 Mar 2011 22:09:03 +0100
Message-Id: <20110323210536.466199919@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:02 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 20/38] mips: txx9: Convert core to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-kernel-txx9.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/irq_txx9.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

Index: linux-mips-next/arch/mips/kernel/irq_txx9.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/irq_txx9.c
+++ linux-mips-next/arch/mips/kernel/irq_txx9.c
@@ -63,9 +63,9 @@ static struct {
 	unsigned char mode;
 } txx9irq[TXx9_MAX_IR] __read_mostly;
 
-static void txx9_irq_unmask(unsigned int irq)
+static void txx9_irq_unmask(struct irq_data *d)
 {
-	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
 	u32 __iomem *ilrp = &txx9_ircptr->ilr[(irq_nr % 16 ) / 2];
 	int ofs = irq_nr / 16 * 16 + (irq_nr & 1) * 8;
 
@@ -79,9 +79,9 @@ static void txx9_irq_unmask(unsigned int
 #endif
 }
 
-static inline void txx9_irq_mask(unsigned int irq)
+static inline void txx9_irq_mask(struct irq_data *d)
 {
-	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
 	u32 __iomem *ilrp = &txx9_ircptr->ilr[(irq_nr % 16) / 2];
 	int ofs = irq_nr / 16 * 16 + (irq_nr & 1) * 8;
 
@@ -99,19 +99,19 @@ static inline void txx9_irq_mask(unsigne
 #endif
 }
 
-static void txx9_irq_mask_ack(unsigned int irq)
+static void txx9_irq_mask_ack(struct irq_data *d)
 {
-	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
 
-	txx9_irq_mask(irq);
+	txx9_irq_mask(d);
 	/* clear edge detection */
 	if (unlikely(TXx9_IRCR_EDGE(txx9irq[irq_nr].mode)))
 		__raw_writel(TXx9_IRSCR_EIClrE | irq_nr, &txx9_ircptr->scr);
 }
 
-static int txx9_irq_set_type(unsigned int irq, unsigned int flow_type)
+static int txx9_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
 	u32 cr;
 	u32 __iomem *crp;
 	int ofs;
@@ -139,11 +139,11 @@ static int txx9_irq_set_type(unsigned in
 
 static struct irq_chip txx9_irq_chip = {
 	.name		= "TXX9",
-	.ack		= txx9_irq_mask_ack,
-	.mask		= txx9_irq_mask,
-	.mask_ack	= txx9_irq_mask_ack,
-	.unmask		= txx9_irq_unmask,
-	.set_type	= txx9_irq_set_type,
+	.irq_ack	= txx9_irq_mask_ack,
+	.irq_mask	= txx9_irq_mask,
+	.irq_mask_ack	= txx9_irq_mask_ack,
+	.irq_unmask	= txx9_irq_unmask,
+	.irq_set_type	= txx9_irq_set_type,
 };
 
 void __init txx9_irq_init(unsigned long baseaddr)
