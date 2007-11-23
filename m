Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2007 19:52:18 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:62694 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20029219AbXKWTwJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2007 19:52:09 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IveZL-0004Ev-00; Fri, 23 Nov 2007 20:52:07 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id BADCCC2DDE; Fri, 23 Nov 2007 20:51:04 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:	Fri, 23 Nov 2007 20:34:16 +0100
Subject: [PATCH] IP22: Fix broken EISA interrupt setup by switching to generic i8259
Message-Id: <20071123195104.BADCCC2DDE@solo.franken.de>
To:	undisclosed-recipients:;
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips


Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/Kconfig              |    1 +
 arch/mips/sgi-ip22/ip22-eisa.c |  134 +---------------------------------------
 2 files changed, 3 insertions(+), 132 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2f2ce0c..84059da 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -385,6 +385,7 @@ config SGI_IP22
 	select DMA_NONCOHERENT
 	select HW_HAS_EISA
 	select I8253
+	select I8259
 	select IP22_CPU_SCACHE
 	select IRQ_CPU
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
diff --git a/arch/mips/sgi-ip22/ip22-eisa.c b/arch/mips/sgi-ip22/ip22-eisa.c
index 26854fb..1617241 100644
--- a/arch/mips/sgi-ip22/ip22-eisa.c
+++ b/arch/mips/sgi-ip22/ip22-eisa.c
@@ -36,6 +36,7 @@
 #include <asm/sgi/ioc.h>
 #include <asm/sgi/mc.h>
 #include <asm/sgi/ip22.h>
+#include <asm/i8259.h>
 
 /* I2 has four EISA slots. */
 #define IP22_EISA_MAX_SLOTS	  4
@@ -93,126 +94,11 @@ static irqreturn_t ip22_eisa_intr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static void enable_eisa1_irq(unsigned int irq)
-{
-	u8 mask;
-
-	mask = inb(EISA_INT1_MASK);
-	mask &= ~((u8) (1 << irq));
-	outb(mask, EISA_INT1_MASK);
-}
-
-static unsigned int startup_eisa1_irq(unsigned int irq)
-{
-	u8 edge;
-
-	/* Only use edge interrupts for EISA */
-
-	edge = inb(EISA_INT1_EDGE_LEVEL);
-	edge &= ~((u8) (1 << irq));
-	outb(edge, EISA_INT1_EDGE_LEVEL);
-
-	enable_eisa1_irq(irq);
-	return 0;
-}
-
-static void disable_eisa1_irq(unsigned int irq)
-{
-	u8 mask;
-
-	mask = inb(EISA_INT1_MASK);
-	mask |= ((u8) (1 << irq));
-	outb(mask, EISA_INT1_MASK);
-}
-
-static void mask_and_ack_eisa1_irq(unsigned int irq)
-{
-	disable_eisa1_irq(irq);
-
-	outb(0x20, EISA_INT1_CTRL);
-}
-
-static void end_eisa1_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		enable_eisa1_irq(irq);
-}
-
-static struct irq_chip ip22_eisa1_irq_type = {
-	.name		= "IP22 EISA",
-	.startup	= startup_eisa1_irq,
-	.ack		= mask_and_ack_eisa1_irq,
-	.mask		= disable_eisa1_irq,
-	.mask_ack	= mask_and_ack_eisa1_irq,
-	.unmask		= enable_eisa1_irq,
-	.end		= end_eisa1_irq,
-};
-
-static void enable_eisa2_irq(unsigned int irq)
-{
-	u8 mask;
-
-	mask = inb(EISA_INT2_MASK);
-	mask &= ~((u8) (1 << (irq - 8)));
-	outb(mask, EISA_INT2_MASK);
-}
-
-static unsigned int startup_eisa2_irq(unsigned int irq)
-{
-	u8 edge;
-
-	/* Only use edge interrupts for EISA */
-
-	edge = inb(EISA_INT2_EDGE_LEVEL);
-	edge &= ~((u8) (1 << (irq - 8)));
-	outb(edge, EISA_INT2_EDGE_LEVEL);
-
-	enable_eisa2_irq(irq);
-	return 0;
-}
-
-static void disable_eisa2_irq(unsigned int irq)
-{
-	u8 mask;
-
-	mask = inb(EISA_INT2_MASK);
-	mask |= ((u8) (1 << (irq - 8)));
-	outb(mask, EISA_INT2_MASK);
-}
-
-static void mask_and_ack_eisa2_irq(unsigned int irq)
-{
-	disable_eisa2_irq(irq);
-
-	outb(0x20, EISA_INT2_CTRL);
-}
-
-static void end_eisa2_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		enable_eisa2_irq(irq);
-}
-
-static struct irq_chip ip22_eisa2_irq_type = {
-	.name		= "IP22 EISA",
-	.startup	= startup_eisa2_irq,
-	.ack		= mask_and_ack_eisa2_irq,
-	.mask		= disable_eisa2_irq,
-	.mask_ack	= mask_and_ack_eisa2_irq,
-	.unmask		= enable_eisa2_irq,
-	.end		= end_eisa2_irq,
-};
-
 static struct irqaction eisa_action = {
 	.handler	= ip22_eisa_intr,
 	.name		= "EISA",
 };
 
-static struct irqaction cascade_action = {
-	.handler	= no_action,
-	.name		= "EISA cascade",
-};
-
 int __init ip22_eisa_init(void)
 {
 	int i, c;
@@ -248,29 +134,13 @@ int __init ip22_eisa_init(void)
 	outb(1, EISA_EXT_NMI_RESET_CTRL);
 	udelay(50);	/* Wait long enough for the dust to settle */
 	outb(0, EISA_EXT_NMI_RESET_CTRL);
-	outb(0x11, EISA_INT1_CTRL);
-	outb(0x11, EISA_INT2_CTRL);
-	outb(0, EISA_INT1_MASK);
-	outb(8, EISA_INT2_MASK);
-	outb(4, EISA_INT1_MASK);
-	outb(2, EISA_INT2_MASK);
-	outb(1, EISA_INT1_MASK);
-	outb(1, EISA_INT2_MASK);
-	outb(0xfb, EISA_INT1_MASK);
-	outb(0xff, EISA_INT2_MASK);
 	outb(0, EISA_DMA2_WRITE_SINGLE);
 
-	for (i = SGINT_EISA; i < (SGINT_EISA + EISA_MAX_IRQ); i++) {
-		if (i < (SGINT_EISA + 8))
-			set_irq_chip(i, &ip22_eisa1_irq_type);
-		else
-			set_irq_chip(i, &ip22_eisa2_irq_type);
-	}
+	init_i8259_irqs();
 
 	/* Cannot use request_irq because of kmalloc not being ready at such
 	 * an early stage. Yes, I've been bitten... */
 	setup_irq(SGI_EISA_IRQ, &eisa_action);
-	setup_irq(SGINT_EISA + 2, &cascade_action);
 
 	EISA_bus = 1;
 	return 0;
-- 
1.4.4.4
