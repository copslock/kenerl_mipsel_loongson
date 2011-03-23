Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:21:24 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47498 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491937Ab1CWVJT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:19 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIn-0001wx-Ch; Wed, 23 Mar 2011 22:09:14 +0100
Message-Id: <20110323210537.598612403@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:13 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 32/38] mips: sgi32: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-sgi32.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/sgi-ip32/ip32-irq.c |  134 +++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 92 deletions(-)

Index: linux-mips-next/arch/mips/sgi-ip32/ip32-irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/sgi-ip32/ip32-irq.c
+++ linux-mips-next/arch/mips/sgi-ip32/ip32-irq.c
@@ -130,70 +130,48 @@ static struct irqaction cpuerr_irq = {
 
 static uint64_t crime_mask;
 
-static inline void crime_enable_irq(unsigned int irq)
+static inline void crime_enable_irq(struct irq_data *d)
 {
-	unsigned int bit = irq - CRIME_IRQ_BASE;
+	unsigned int bit = d->irq - CRIME_IRQ_BASE;
 
 	crime_mask |= 1 << bit;
 	crime->imask = crime_mask;
 }
 
-static inline void crime_disable_irq(unsigned int irq)
+static inline void crime_disable_irq(struct irq_data *d)
 {
-	unsigned int bit = irq - CRIME_IRQ_BASE;
+	unsigned int bit = d->irq - CRIME_IRQ_BASE;
 
 	crime_mask &= ~(1 << bit);
 	crime->imask = crime_mask;
 	flush_crime_bus();
 }
 
-static void crime_level_mask_and_ack_irq(unsigned int irq)
-{
-	crime_disable_irq(irq);
-}
-
-static void crime_level_end_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		crime_enable_irq(irq);
-}
-
 static struct irq_chip crime_level_interrupt = {
 	.name		= "IP32 CRIME",
-	.ack		= crime_level_mask_and_ack_irq,
-	.mask		= crime_disable_irq,
-	.mask_ack	= crime_level_mask_and_ack_irq,
-	.unmask		= crime_enable_irq,
-	.end		= crime_level_end_irq,
+	.irq_mask	= crime_disable_irq,
+	.irq_unmask	= crime_enable_irq,
 };
 
-static void crime_edge_mask_and_ack_irq(unsigned int irq)
+static void crime_edge_mask_and_ack_irq(struct irq_data *d)
 {
-	unsigned int bit = irq - CRIME_IRQ_BASE;
+	unsigned int bit = d->irq - CRIME_IRQ_BASE;
 	uint64_t crime_int;
 
 	/* Edge triggered interrupts must be cleared. */
-
 	crime_int = crime->hard_int;
 	crime_int &= ~(1 << bit);
 	crime->hard_int = crime_int;
 
-	crime_disable_irq(irq);
-}
-
-static void crime_edge_end_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		crime_enable_irq(irq);
+	crime_disable_irq(d);
 }
 
 static struct irq_chip crime_edge_interrupt = {
 	.name		= "IP32 CRIME",
-	.ack		= crime_edge_mask_and_ack_irq,
-	.mask		= crime_disable_irq,
-	.mask_ack	= crime_edge_mask_and_ack_irq,
-	.unmask		= crime_enable_irq,
-	.end		= crime_edge_end_irq,
+	.irq_ack	= crime_edge_mask_and_ack_irq,
+	.irq_mask	= crime_disable_irq,
+	.irq_mask_ack	= crime_edge_mask_and_ack_irq,
+	.irq_unmask	= crime_enable_irq,
 };
 
 /*
@@ -204,37 +182,28 @@ static struct irq_chip crime_edge_interr
 
 static unsigned long macepci_mask;
 
-static void enable_macepci_irq(unsigned int irq)
+static void enable_macepci_irq(struct irq_data *d)
 {
-	macepci_mask |= MACEPCI_CONTROL_INT(irq - MACEPCI_SCSI0_IRQ);
+	macepci_mask |= MACEPCI_CONTROL_INT(d->irq - MACEPCI_SCSI0_IRQ);
 	mace->pci.control = macepci_mask;
-	crime_mask |= 1 << (irq - CRIME_IRQ_BASE);
+	crime_mask |= 1 << (d->irq - CRIME_IRQ_BASE);
 	crime->imask = crime_mask;
 }
 
-static void disable_macepci_irq(unsigned int irq)
+static void disable_macepci_irq(struct irq_data *d)
 {
-	crime_mask &= ~(1 << (irq - CRIME_IRQ_BASE));
+	crime_mask &= ~(1 << (d->irq - CRIME_IRQ_BASE));
 	crime->imask = crime_mask;
 	flush_crime_bus();
-	macepci_mask &= ~MACEPCI_CONTROL_INT(irq - MACEPCI_SCSI0_IRQ);
+	macepci_mask &= ~MACEPCI_CONTROL_INT(d->irq - MACEPCI_SCSI0_IRQ);
 	mace->pci.control = macepci_mask;
 	flush_mace_bus();
 }
 
-static void end_macepci_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_macepci_irq(irq);
-}
-
 static struct irq_chip ip32_macepci_interrupt = {
 	.name = "IP32 MACE PCI",
-	.ack = disable_macepci_irq,
-	.mask = disable_macepci_irq,
-	.mask_ack = disable_macepci_irq,
-	.unmask = enable_macepci_irq,
-	.end = end_macepci_irq,
+	.irq_mask = disable_macepci_irq,
+	.irq_unmask = enable_macepci_irq,
 };
 
 /* This is used for MACE ISA interrupts.  That means bits 4-6 in the
@@ -276,13 +245,13 @@ static struct irq_chip ip32_macepci_inte
 
 static unsigned long maceisa_mask;
 
-static void enable_maceisa_irq(unsigned int irq)
+static void enable_maceisa_irq(struct irq_data *d)
 {
 	unsigned int crime_int = 0;
 
-	pr_debug("maceisa enable: %u\n", irq);
+	pr_debug("maceisa enable: %u\n", d->irq);
 
-	switch (irq) {
+	switch (d->irq) {
 	case MACEISA_AUDIO_SW_IRQ ... MACEISA_AUDIO3_MERR_IRQ:
 		crime_int = MACE_AUDIO_INT;
 		break;
@@ -296,15 +265,15 @@ static void enable_maceisa_irq(unsigned 
 	pr_debug("crime_int %08x enabled\n", crime_int);
 	crime_mask |= crime_int;
 	crime->imask = crime_mask;
-	maceisa_mask |= 1 << (irq - MACEISA_AUDIO_SW_IRQ);
+	maceisa_mask |= 1 << (d->irq - MACEISA_AUDIO_SW_IRQ);
 	mace->perif.ctrl.imask = maceisa_mask;
 }
 
-static void disable_maceisa_irq(unsigned int irq)
+static void disable_maceisa_irq(struct irq_data *d)
 {
 	unsigned int crime_int = 0;
 
-	maceisa_mask &= ~(1 << (irq - MACEISA_AUDIO_SW_IRQ));
+	maceisa_mask &= ~(1 << (d->irq - MACEISA_AUDIO_SW_IRQ));
         if (!(maceisa_mask & MACEISA_AUDIO_INT))
 		crime_int |= MACE_AUDIO_INT;
         if (!(maceisa_mask & MACEISA_MISC_INT))
@@ -318,76 +287,57 @@ static void disable_maceisa_irq(unsigned
 	flush_mace_bus();
 }
 
-static void mask_and_ack_maceisa_irq(unsigned int irq)
+static void mask_and_ack_maceisa_irq(struct irq_data *d)
 {
 	unsigned long mace_int;
 
 	/* edge triggered */
 	mace_int = mace->perif.ctrl.istat;
-	mace_int &= ~(1 << (irq - MACEISA_AUDIO_SW_IRQ));
+	mace_int &= ~(1 << (d->irq - MACEISA_AUDIO_SW_IRQ));
 	mace->perif.ctrl.istat = mace_int;
 
-	disable_maceisa_irq(irq);
-}
-
-static void end_maceisa_irq(unsigned irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		enable_maceisa_irq(irq);
+	disable_maceisa_irq(d);
 }
 
 static struct irq_chip ip32_maceisa_level_interrupt = {
 	.name		= "IP32 MACE ISA",
-	.ack		= disable_maceisa_irq,
-	.mask		= disable_maceisa_irq,
-	.mask_ack	= disable_maceisa_irq,
-	.unmask		= enable_maceisa_irq,
-	.end		= end_maceisa_irq,
+	.irq_mask	= disable_maceisa_irq,
+	.irq_unmask	= enable_maceisa_irq,
 };
 
 static struct irq_chip ip32_maceisa_edge_interrupt = {
 	.name		= "IP32 MACE ISA",
-	.ack		= mask_and_ack_maceisa_irq,
-	.mask		= disable_maceisa_irq,
-	.mask_ack	= mask_and_ack_maceisa_irq,
-	.unmask		= enable_maceisa_irq,
-	.end		= end_maceisa_irq,
+	.irq_ack	= mask_and_ack_maceisa_irq,
+	.irq_mask	= disable_maceisa_irq,
+	.irq_mask_ack	= mask_and_ack_maceisa_irq,
+	.irq_unmask	= enable_maceisa_irq,
 };
 
 /* This is used for regular non-ISA, non-PCI MACE interrupts.  That means
  * bits 0-3 and 7 in the CRIME register.
  */
 
-static void enable_mace_irq(unsigned int irq)
+static void enable_mace_irq(struct irq_data *d)
 {
-	unsigned int bit = irq - CRIME_IRQ_BASE;
+	unsigned int bit = d->irq - CRIME_IRQ_BASE;
 
 	crime_mask |= (1 << bit);
 	crime->imask = crime_mask;
 }
 
-static void disable_mace_irq(unsigned int irq)
+static void disable_mace_irq(struct irq_data *d)
 {
-	unsigned int bit = irq - CRIME_IRQ_BASE;
+	unsigned int bit = d->irq - CRIME_IRQ_BASE;
 
 	crime_mask &= ~(1 << bit);
 	crime->imask = crime_mask;
 	flush_crime_bus();
 }
 
-static void end_mace_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_mace_irq(irq);
-}
-
 static struct irq_chip ip32_mace_interrupt = {
 	.name = "IP32 MACE",
-	.ack = disable_mace_irq,
-	.mask = disable_mace_irq,
-	.mask_ack = disable_mace_irq,
-	.unmask = enable_mace_irq,
-	.end = end_mace_irq,
+	.irq_mask = disable_mace_irq,
+	.irq_unmask = enable_mace_irq,
 };
 
 static void ip32_unknown_interrupt(void)
