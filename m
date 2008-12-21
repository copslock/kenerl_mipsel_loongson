Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:27:49 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:42426 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S22774248AbYLUI03 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:29 +0000
Received: (qmail 3955 invoked from network); 21 Dec 2008 09:24:58 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:58 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 05/14] Alchemy: pb1200: update CPLD cascade irq handler.
Date:	Sun, 21 Dec 2008 09:26:18 +0100
Message-Id: <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
 <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
 <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
 <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Tested on Db1200.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/devboards/pb1200/irqmap.c |   87 +++++++++-----------------
 1 files changed, 30 insertions(+), 57 deletions(-)

diff --git a/arch/mips/alchemy/devboards/pb1200/irqmap.c b/arch/mips/alchemy/devboards/pb1200/irqmap.c
index 1f92fec..fe47498 100644
--- a/arch/mips/alchemy/devboards/pb1200/irqmap.c
+++ b/arch/mips/alchemy/devboards/pb1200/irqmap.c
@@ -47,77 +47,50 @@ struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 /*
  * Support for External interrupts on the Pb1200 Development platform.
  */
-static volatile int pb1200_cascade_en;
 
-irqreturn_t pb1200_cascade_handler(int irq, void *dev_id)
+static void pb1200_cascade_handler(unsigned int irq, struct irq_desc *d)
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
-
-	return IRQ_RETVAL(1);
-}
 
-inline void pb1200_enable_irq(unsigned int irq_nr)
-{
-	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
-	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
+	for ( ; bisr; bisr &= bisr - 1)
+		generic_handle_irq(PB1200_INT_BEGIN + __ffs(bisr));
 }
 
-inline void pb1200_disable_irq(unsigned int irq_nr)
+/* NOTE: both the enable and mask bits must be cleared, otherwise the
+ * CPLD generates tons of spurious interrupts (at least on the DB1200).
+ */
+static void pb1200_mask_irq(unsigned int irq_nr)
 {
 	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
 	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
+	au_sync();
 }
 
-static unsigned int pb1200_setup_cascade(void)
-{
-	return request_irq(AU1000_GPIO_7, &pb1200_cascade_handler,
-			   0, "Pb1200 Cascade", &pb1200_cascade_handler);
-}
-
-static unsigned int pb1200_startup_irq(unsigned int irq)
+static void pb1200_maskack_irq(unsigned int irq_nr)
 {
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
+	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
+	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
+	bcsr->int_status = 1 << (irq_nr - PB1200_INT_BEGIN);	/* ack */
+	au_sync();
 }
 
-static void pb1200_shutdown_irq(unsigned int irq)
+static void pb1200_unmask_irq(unsigned int irq_nr)
 {
-	pb1200_disable_irq(irq);
-	if (--pb1200_cascade_en == 0)
-		free_irq(AU1000_GPIO_7, &pb1200_cascade_handler);
+	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
+	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
+	au_sync();
 }
 
-static struct irq_chip external_irq_type = {
+static struct irq_chip pb1200_cpld_irq_type = {
 #ifdef CONFIG_MIPS_PB1200
 	.name = "Pb1200 Ext",
 #endif
 #ifdef CONFIG_MIPS_DB1200
 	.name = "Db1200 Ext",
 #endif
-	.startup  = pb1200_startup_irq,
-	.shutdown = pb1200_shutdown_irq,
-	.ack      = pb1200_disable_irq,
-	.mask     = pb1200_disable_irq,
-	.mask_ack = pb1200_disable_irq,
-	.unmask   = pb1200_enable_irq,
+	.mask		= pb1200_mask_irq,
+	.mask_ack	= pb1200_maskack_irq,
+	.unmask		= pb1200_unmask_irq,
 };
 
 void __init board_init_irq(void)
@@ -147,15 +120,15 @@ void __init board_init_irq(void)
 		panic("Game over.  Your score is 0.");
 	}
 #endif
+	/* mask & disable & ack all */
+	bcsr->intclr_mask = 0xffff;
+	bcsr->intclr = 0xffff;
+	bcsr->int_status = 0xffff;
+	au_sync();
 
-	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++) {
-		set_irq_chip_and_handler(irq, &external_irq_type,
-					 handle_level_irq);
-		pb1200_disable_irq(irq);
-	}
+	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++)
+		set_irq_chip_and_handler_name(irq, &pb1200_cpld_irq_type,
+					 handle_level_irq, "level");
 
-	/*
-	 * GPIO_7 can not be hooked here, so it is hooked upon first
-	 * request of any source attached to the cascade.
-	 */
+	set_irq_chained_handler(AU1000_GPIO_7, pb1200_cascade_handler);
 }
-- 
1.6.0.4
