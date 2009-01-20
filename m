Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2009 10:03:56 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:7629 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366208AbZATKDy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Jan 2009 10:03:54 +0000
Received: (qmail 19003 invoked by uid 1000); 20 Jan 2009 11:03:53 +0100
Date:	Tue, 20 Jan 2009 11:03:53 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] Alchemy: fix edge irq handling
Message-ID: <20090120100353.GA18971@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Introduce separate mack_ack callbacks which really do shut up the
edge-triggered irqs when called.  Without this change, high-frequency
edge interrupts can result in an endless irq storm, hanging the system.

This can be easily triggered for example by setting an irq to falling
edge type and manually connecting the associated pin to ground.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/irq.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index c88c821..60da581 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -320,6 +320,16 @@ static void au1x_ic0_mask(unsigned int irq_nr)
 	au_sync();
 }
 
+static void au1x_ic0_maskack(unsigned int irq_nr)
+{
+	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
+	au_writel(1 << bit, IC0_MASKCLR);
+	au_writel(1 << bit, IC0_WAKECLR);
+	au_writel(1 << bit, IC0_FALLINGCLR);
+	au_writel(1 << bit, IC0_RISINGCLR);
+	au_sync();
+}
+
 static void au1x_ic1_mask(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
@@ -328,6 +338,16 @@ static void au1x_ic1_mask(unsigned int irq_nr)
 	au_sync();
 }
 
+static void au1x_ic1_maskack(unsigned int irq_nr)
+{
+	unsigned int bit = irq_nr - AU1000_INTC1_INT_BASE;
+	au_writel(1 << bit, IC1_MASKCLR);
+	au_writel(1 << bit, IC1_WAKECLR);
+	au_writel(1 << bit, IC1_FALLINGCLR);
+	au_writel(1 << bit, IC1_RISINGCLR);
+	au_sync();
+}
+
 static void au1x_ic0_ack(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
@@ -379,25 +399,21 @@ static int au1x_ic1_setwake(unsigned int irq, unsigned int on)
 /*
  * irq_chips for both ICs; this way the mask handlers can be
  * as short as possible.
- *
- * NOTE: the ->ack() callback is used by the handle_edge_irq
- *	 flowhandler only, the ->mask_ack() one by handle_level_irq,
- *	 so no need for an irq_chip for each type of irq (level/edge).
  */
 static struct irq_chip au1x_ic0_chip = {
 	.name		= "Alchemy-IC0",
-	.ack		= au1x_ic0_ack,		/* edge */
+	.ack		= au1x_ic0_ack,
 	.mask		= au1x_ic0_mask,
-	.mask_ack	= au1x_ic0_mask,	/* level */
+	.mask_ack	= au1x_ic0_maskack,
 	.unmask		= au1x_ic0_unmask,
 	.set_type	= au1x_ic_settype,
 };
 
 static struct irq_chip au1x_ic1_chip = {
 	.name		= "Alchemy-IC1",
-	.ack		= au1x_ic1_ack,		/* edge */
+	.ack		= au1x_ic1_ack,
 	.mask		= au1x_ic1_mask,
-	.mask_ack	= au1x_ic1_mask,	/* level */
+	.mask_ack	= au1x_ic1_maskack,
 	.unmask		= au1x_ic1_unmask,
 	.set_type	= au1x_ic_settype,
 	.set_wake	= au1x_ic1_setwake,
-- 
1.6.1
