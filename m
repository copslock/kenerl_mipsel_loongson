Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:22:35 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47507 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491939Ab1CWVJW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:22 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIq-0001x7-Nh; Wed, 23 Mar 2011 22:09:17 +0100
Message-Id: <20110323210537.879365885@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:16 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 35/38] mips: txx9: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-txx9.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/txx9/generic/irq_tx4939.c |   28 ++++++++---------
 arch/mips/txx9/jmr3927/irq.c        |   14 +++-----
 arch/mips/txx9/rbtx4927/irq.c       |   58 ++++++++++++++++--------------------
 arch/mips/txx9/rbtx4938/irq.c       |   54 ++++++++++++++-------------------
 arch/mips/txx9/rbtx4939/irq.c       |   14 +++-----
 5 files changed, 75 insertions(+), 93 deletions(-)

Index: linux-mips-next/arch/mips/txx9/generic/irq_tx4939.c
===================================================================
--- linux-mips-next.orig/arch/mips/txx9/generic/irq_tx4939.c
+++ linux-mips-next/arch/mips/txx9/generic/irq_tx4939.c
@@ -50,9 +50,9 @@ static struct {
 	unsigned char mode;
 } tx4939irq[TX4939_NUM_IR] __read_mostly;
 
-static void tx4939_irq_unmask(unsigned int irq)
+static void tx4939_irq_unmask(struct irq_data *d)
 {
-	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
 	u32 __iomem *lvlp;
 	int ofs;
 	if (irq_nr < 32) {
@@ -68,9 +68,9 @@ static void tx4939_irq_unmask(unsigned i
 		     lvlp);
 }
 
-static inline void tx4939_irq_mask(unsigned int irq)
+static inline void tx4939_irq_mask(struct irq_data *d)
 {
-	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
 	u32 __iomem *lvlp;
 	int ofs;
 	if (irq_nr < 32) {
@@ -87,11 +87,11 @@ static inline void tx4939_irq_mask(unsig
 	mmiowb();
 }
 
-static void tx4939_irq_mask_ack(unsigned int irq)
+static void tx4939_irq_mask_ack(struct irq_data *d)
 {
-	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
 
-	tx4939_irq_mask(irq);
+	tx4939_irq_mask(d);
 	if (TXx9_IRCR_EDGE(tx4939irq[irq_nr].mode)) {
 		irq_nr--;
 		/* clear edge detection */
@@ -101,9 +101,9 @@ static void tx4939_irq_mask_ack(unsigned
 	}
 }
 
-static int tx4939_irq_set_type(unsigned int irq, unsigned int flow_type)
+static int tx4939_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
 	u32 cr;
 	u32 __iomem *crp;
 	int ofs;
@@ -145,11 +145,11 @@ static int tx4939_irq_set_type(unsigned 
 
 static struct irq_chip tx4939_irq_chip = {
 	.name		= "TX4939",
-	.ack		= tx4939_irq_mask_ack,
-	.mask		= tx4939_irq_mask,
-	.mask_ack	= tx4939_irq_mask_ack,
-	.unmask		= tx4939_irq_unmask,
-	.set_type	= tx4939_irq_set_type,
+	.irq_ack	= tx4939_irq_mask_ack,
+	.irq_mask	= tx4939_irq_mask,
+	.irq_mask_ack	= tx4939_irq_mask_ack,
+	.irq_unmask	= tx4939_irq_unmask,
+	.irq_set_type	= tx4939_irq_set_type,
 };
 
 static int tx4939_irq_set_pri(int irc_irq, int new_pri)
Index: linux-mips-next/arch/mips/txx9/jmr3927/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/txx9/jmr3927/irq.c
+++ linux-mips-next/arch/mips/txx9/jmr3927/irq.c
@@ -47,20 +47,20 @@
  * CP0_STATUS is a thread's resource (saved/restored on context switch).
  * So disable_irq/enable_irq MUST handle IOC/IRC registers.
  */
-static void mask_irq_ioc(unsigned int irq)
+static void mask_irq_ioc(struct irq_data *d)
 {
 	/* 0: mask */
-	unsigned int irq_nr = irq - JMR3927_IRQ_IOC;
+	unsigned int irq_nr = d->irq - JMR3927_IRQ_IOC;
 	unsigned char imask = jmr3927_ioc_reg_in(JMR3927_IOC_INTM_ADDR);
 	unsigned int bit = 1 << irq_nr;
 	jmr3927_ioc_reg_out(imask & ~bit, JMR3927_IOC_INTM_ADDR);
 	/* flush write buffer */
 	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
 }
-static void unmask_irq_ioc(unsigned int irq)
+static void unmask_irq_ioc(struct irq_data *d)
 {
 	/* 0: mask */
-	unsigned int irq_nr = irq - JMR3927_IRQ_IOC;
+	unsigned int irq_nr = d->irq - JMR3927_IRQ_IOC;
 	unsigned char imask = jmr3927_ioc_reg_in(JMR3927_IOC_INTM_ADDR);
 	unsigned int bit = 1 << irq_nr;
 	jmr3927_ioc_reg_out(imask | bit, JMR3927_IOC_INTM_ADDR);
@@ -95,10 +95,8 @@ static int jmr3927_irq_dispatch(int pend
 
 static struct irq_chip jmr3927_irq_ioc = {
 	.name = "jmr3927_ioc",
-	.ack = mask_irq_ioc,
-	.mask = mask_irq_ioc,
-	.mask_ack = mask_irq_ioc,
-	.unmask = unmask_irq_ioc,
+	.irq_mask = mask_irq_ioc,
+	.irq_unmask = unmask_irq_ioc,
 };
 
 void __init jmr3927_irq_setup(void)
Index: linux-mips-next/arch/mips/txx9/rbtx4927/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/txx9/rbtx4927/irq.c
+++ linux-mips-next/arch/mips/txx9/rbtx4927/irq.c
@@ -117,18 +117,6 @@
 #include <asm/txx9/generic.h>
 #include <asm/txx9/rbtx4927.h>
 
-static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq);
-static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq);
-
-#define TOSHIBA_RBTX4927_IOC_NAME "RBTX4927-IOC"
-static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
-	.name = TOSHIBA_RBTX4927_IOC_NAME,
-	.ack = toshiba_rbtx4927_irq_ioc_disable,
-	.mask = toshiba_rbtx4927_irq_ioc_disable,
-	.mask_ack = toshiba_rbtx4927_irq_ioc_disable,
-	.unmask = toshiba_rbtx4927_irq_ioc_enable,
-};
-
 static int toshiba_rbtx4927_irq_nested(int sw_irq)
 {
 	u8 level3;
@@ -139,41 +127,47 @@ static int toshiba_rbtx4927_irq_nested(i
 	return RBTX4927_IRQ_IOC + __fls8(level3);
 }
 
-static void __init toshiba_rbtx4927_irq_ioc_init(void)
-{
-	int i;
-
-	/* mask all IOC interrupts */
-	writeb(0, rbtx4927_imask_addr);
-	/* clear SoftInt interrupts */
-	writeb(0, rbtx4927_softint_addr);
-
-	for (i = RBTX4927_IRQ_IOC;
-	     i < RBTX4927_IRQ_IOC + RBTX4927_NR_IRQ_IOC; i++)
-		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_ioc_type,
-					 handle_level_irq);
-	set_irq_chained_handler(RBTX4927_IRQ_IOCINT, handle_simple_irq);
-}
-
-static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq)
+static void toshiba_rbtx4927_irq_ioc_enable(struct irq_data *d)
 {
 	unsigned char v;
 
 	v = readb(rbtx4927_imask_addr);
-	v |= (1 << (irq - RBTX4927_IRQ_IOC));
+	v |= (1 << (d->irq - RBTX4927_IRQ_IOC));
 	writeb(v, rbtx4927_imask_addr);
 }
 
-static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq)
+static void toshiba_rbtx4927_irq_ioc_disable(struct irq_data *d)
 {
 	unsigned char v;
 
 	v = readb(rbtx4927_imask_addr);
-	v &= ~(1 << (irq - RBTX4927_IRQ_IOC));
+	v &= ~(1 << (d->irq - RBTX4927_IRQ_IOC));
 	writeb(v, rbtx4927_imask_addr);
 	mmiowb();
 }
 
+#define TOSHIBA_RBTX4927_IOC_NAME "RBTX4927-IOC"
+static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
+	.name = TOSHIBA_RBTX4927_IOC_NAME,
+	.irq_mask = toshiba_rbtx4927_irq_ioc_disable,
+	.irq_unmask = toshiba_rbtx4927_irq_ioc_enable,
+};
+
+static void __init toshiba_rbtx4927_irq_ioc_init(void)
+{
+	int i;
+
+	/* mask all IOC interrupts */
+	writeb(0, rbtx4927_imask_addr);
+	/* clear SoftInt interrupts */
+	writeb(0, rbtx4927_softint_addr);
+
+	for (i = RBTX4927_IRQ_IOC;
+	     i < RBTX4927_IRQ_IOC + RBTX4927_NR_IRQ_IOC; i++)
+		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_ioc_type,
+					 handle_level_irq);
+	set_irq_chained_handler(RBTX4927_IRQ_IOCINT, handle_simple_irq);
+}
 
 static int rbtx4927_irq_dispatch(int pending)
 {
Index: linux-mips-next/arch/mips/txx9/rbtx4938/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/txx9/rbtx4938/irq.c
+++ linux-mips-next/arch/mips/txx9/rbtx4938/irq.c
@@ -69,18 +69,6 @@
 #include <asm/txx9/generic.h>
 #include <asm/txx9/rbtx4938.h>
 
-static void toshiba_rbtx4938_irq_ioc_enable(unsigned int irq);
-static void toshiba_rbtx4938_irq_ioc_disable(unsigned int irq);
-
-#define TOSHIBA_RBTX4938_IOC_NAME "RBTX4938-IOC"
-static struct irq_chip toshiba_rbtx4938_irq_ioc_type = {
-	.name = TOSHIBA_RBTX4938_IOC_NAME,
-	.ack = toshiba_rbtx4938_irq_ioc_disable,
-	.mask = toshiba_rbtx4938_irq_ioc_disable,
-	.mask_ack = toshiba_rbtx4938_irq_ioc_disable,
-	.unmask = toshiba_rbtx4938_irq_ioc_enable,
-};
-
 static int toshiba_rbtx4938_irq_nested(int sw_irq)
 {
 	u8 level3;
@@ -92,41 +80,33 @@ static int toshiba_rbtx4938_irq_nested(i
 	return RBTX4938_IRQ_IOC + __fls8(level3);
 }
 
-static void __init
-toshiba_rbtx4938_irq_ioc_init(void)
-{
-	int i;
-
-	for (i = RBTX4938_IRQ_IOC;
-	     i < RBTX4938_IRQ_IOC + RBTX4938_NR_IRQ_IOC; i++)
-		set_irq_chip_and_handler(i, &toshiba_rbtx4938_irq_ioc_type,
-					 handle_level_irq);
-
-	set_irq_chained_handler(RBTX4938_IRQ_IOCINT, handle_simple_irq);
-}
-
-static void
-toshiba_rbtx4938_irq_ioc_enable(unsigned int irq)
+static void toshiba_rbtx4938_irq_ioc_enable(struct irq_data *d)
 {
 	unsigned char v;
 
 	v = readb(rbtx4938_imask_addr);
-	v |= (1 << (irq - RBTX4938_IRQ_IOC));
+	v |= (1 << (d->irq - RBTX4938_IRQ_IOC));
 	writeb(v, rbtx4938_imask_addr);
 	mmiowb();
 }
 
-static void
-toshiba_rbtx4938_irq_ioc_disable(unsigned int irq)
+static void toshiba_rbtx4938_irq_ioc_disable(struct irq_data *d)
 {
 	unsigned char v;
 
 	v = readb(rbtx4938_imask_addr);
-	v &= ~(1 << (irq - RBTX4938_IRQ_IOC));
+	v &= ~(1 << (d->irq - RBTX4938_IRQ_IOC));
 	writeb(v, rbtx4938_imask_addr);
 	mmiowb();
 }
 
+#define TOSHIBA_RBTX4938_IOC_NAME "RBTX4938-IOC"
+static struct irq_chip toshiba_rbtx4938_irq_ioc_type = {
+	.name = TOSHIBA_RBTX4938_IOC_NAME,
+	.irq_mask = toshiba_rbtx4938_irq_ioc_disable,
+	.irq_unmask = toshiba_rbtx4938_irq_ioc_enable,
+};
+
 static int rbtx4938_irq_dispatch(int pending)
 {
 	int irq;
@@ -146,6 +126,18 @@ static int rbtx4938_irq_dispatch(int pen
 	return irq;
 }
 
+static void __init toshiba_rbtx4938_irq_ioc_init(void)
+{
+	int i;
+
+	for (i = RBTX4938_IRQ_IOC;
+	     i < RBTX4938_IRQ_IOC + RBTX4938_NR_IRQ_IOC; i++)
+		set_irq_chip_and_handler(i, &toshiba_rbtx4938_irq_ioc_type,
+					 handle_level_irq);
+
+	set_irq_chained_handler(RBTX4938_IRQ_IOCINT, handle_simple_irq);
+}
+
 void __init rbtx4938_irq_setup(void)
 {
 	txx9_irq_dispatch = rbtx4938_irq_dispatch;
Index: linux-mips-next/arch/mips/txx9/rbtx4939/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/txx9/rbtx4939/irq.c
+++ linux-mips-next/arch/mips/txx9/rbtx4939/irq.c
@@ -19,16 +19,16 @@
  * RBTX4939 IOC controller definition
  */
 
-static void rbtx4939_ioc_irq_unmask(unsigned int irq)
+static void rbtx4939_ioc_irq_unmask(struct irq_data *d)
 {
-	int ioc_nr = irq - RBTX4939_IRQ_IOC;
+	int ioc_nr = d->irq - RBTX4939_IRQ_IOC;
 
 	writeb(readb(rbtx4939_ien_addr) | (1 << ioc_nr), rbtx4939_ien_addr);
 }
 
-static void rbtx4939_ioc_irq_mask(unsigned int irq)
+static void rbtx4939_ioc_irq_mask(struct irq_data *d)
 {
-	int ioc_nr = irq - RBTX4939_IRQ_IOC;
+	int ioc_nr = d->irq - RBTX4939_IRQ_IOC;
 
 	writeb(readb(rbtx4939_ien_addr) & ~(1 << ioc_nr), rbtx4939_ien_addr);
 	mmiowb();
@@ -36,10 +36,8 @@ static void rbtx4939_ioc_irq_mask(unsign
 
 static struct irq_chip rbtx4939_ioc_irq_chip = {
 	.name		= "IOC",
-	.ack		= rbtx4939_ioc_irq_mask,
-	.mask		= rbtx4939_ioc_irq_mask,
-	.mask_ack	= rbtx4939_ioc_irq_mask,
-	.unmask		= rbtx4939_ioc_irq_unmask,
+	.irq_mask	= rbtx4939_ioc_irq_mask,
+	.irq_unmask	= rbtx4939_ioc_irq_unmask,
 };
 
 
