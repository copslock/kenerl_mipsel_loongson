Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 20:21:32 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:38626 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28591902AbYHLTVZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Aug 2008 20:21:25 +0100
Received: (qmail 9777 invoked from network); 12 Aug 2008 21:21:22 +0200
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 12 Aug 2008 21:21:22 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kevin Hickey <khickey@rmicorp.com>, linux-mips@linux-mips.org,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] Alchemy: modernize Pb1200 IRQ cascade handling code.
Date:	Tue, 12 Aug 2008 21:21:21 +0200
Message-Id: <1218568881-3544-2-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.5.6.4
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/pb1200/irqmap.c |   75 +++++++++-----------------------------
 1 files changed, 18 insertions(+), 57 deletions(-)

diff --git a/arch/mips/au1000/pb1200/irqmap.c b/arch/mips/au1000/pb1200/irqmap.c
index 2a505ad..7229f30 100644
--- a/arch/mips/au1000/pb1200/irqmap.c
+++ b/arch/mips/au1000/pb1200/irqmap.c
@@ -48,62 +48,26 @@ int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
 /*
  * Support for External interrupts on the Pb1200 Development platform.
  */
-static volatile int pb1200_cascade_en;
 
-irqreturn_t pb1200_cascade_handler(int irq, void *dev_id)
+static void pb1200_cascade_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned short bisr = bcsr->int_status;
-	int extirq_nr = 0;
-
-	/* Clear all the edge interrupts. This has no effect on level. */
-	bcsr->int_status = bisr;
-	for ( ; bisr; bisr &= bisr - 1) {
-		extirq_nr = PB1200_INT_BEGIN + __ffs(bisr);
-		/* Ack and dispatch IRQ */
-		do_IRQ(extirq_nr);
-	}
 
-	return IRQ_RETVAL(1);
+	for ( ; bisr; bisr &= bisr - 1)
+		generic_handle_irq(PB1200_INT_BEGIN + __ffs(bisr));
 }
 
-inline void pb1200_enable_irq(unsigned int irq_nr)
+static void pb1200_unmask_irq(unsigned int irq_nr)
 {
 	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
 	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
 }
 
-inline void pb1200_disable_irq(unsigned int irq_nr)
+static void pb1200_maskack_irq(unsigned int irq_nr)
 {
 	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
 	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
-}
-
-static unsigned int pb1200_setup_cascade(void)
-{
-	return request_irq(AU1000_GPIO_7, &pb1200_cascade_handler,
-			   0, "Pb1200 Cascade", &pb1200_cascade_handler);
-}
-
-static unsigned int pb1200_startup_irq(unsigned int irq)
-{
-	if (++pb1200_cascade_en == 1) {
-		int res;
-
-		res = pb1200_setup_cascade();
-		if (res)
-			return res;
-	}
-
-	pb1200_enable_irq(irq);
-
-	return 0;
-}
-
-static void pb1200_shutdown_irq(unsigned int irq)
-{
-	pb1200_disable_irq(irq);
-	if (--pb1200_cascade_en == 0)
-		free_irq(AU1000_GPIO_7, &pb1200_cascade_handler);
+	bcsr->int_status = 1 << (irq_nr - PB1200_INT_BEGIN);	/* ack */
 }
 
 static struct irq_chip external_irq_type = {
@@ -113,12 +77,9 @@ static struct irq_chip external_irq_type = {
 #ifdef CONFIG_MIPS_DB1200
 	.name = "Db1200 Ext",
 #endif
-	.startup  = pb1200_startup_irq,
-	.shutdown = pb1200_shutdown_irq,
-	.ack      = pb1200_disable_irq,
-	.mask     = pb1200_disable_irq,
-	.mask_ack = pb1200_disable_irq,
-	.unmask   = pb1200_enable_irq,
+	.mask		= pb1200_maskack_irq,
+	.mask_ack	= pb1200_maskack_irq,
+	.unmask		= pb1200_unmask_irq,
 };
 
 void _board_init_irq(void)
@@ -147,14 +108,14 @@ void _board_init_irq(void)
 	}
 #endif
 
-	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++) {
-		set_irq_chip_and_handler(irq, &external_irq_type,
-					 handle_level_irq);
-		pb1200_disable_irq(irq);
-	}
+	/* mask & disable & ack all */
+	bcsr->intclr_mask = 0xffff;
+	bcsr->intclr = 0xffff;
+	bcsr->int_status = 0xffff;
+
+	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++)
+		set_irq_chip_and_handler_name(irq, &external_irq_type,
+					 handle_level_irq, "level");
 
-	/*
-	 * GPIO_7 can not be hooked here, so it is hooked upon first
-	 * request of any source attached to the cascade.
-	 */
+	set_irq_chained_handler(AU1000_GPIO_7, pb1200_cascade_handler);
 }
-- 
1.5.6.4
