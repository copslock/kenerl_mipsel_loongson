Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2011 15:18:09 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:42041 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491833Ab1BJORW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Feb 2011 15:17:22 +0100
Received: by mail-fx0-f49.google.com with SMTP id 19so1501515fxm.36
        for <linux-mips@linux-mips.org>; Thu, 10 Feb 2011 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Ru8O+rCIZ8AaJyUVKIiPGFWHoYK9T1SQmLnfl4sr9KA=;
        b=WuUY6Lm0oyfFukpC5HEUp/T1p/XmMcI4J/pX0Ds9rt7+vVl+jC44N2fqAEW/RaXEO1
         SBqMoEhDm9aCtrWZfO4TH2mIYiYYKRjeCz/pUo3nVd8uLPjlaPKks29BMyoCVuyECEqn
         e7STvWdZ63/NhBrsQljYsk9w5HbLcwBu/+TAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O02H6+tFeEMoMoOAK8f0imqnxJHhofcPjT/wXM3bCNa/u6IFfI2BPuosvq6KVtzRER
         l982jAkLQ/UfDriIffsCHagcJHK8QI2GE8OeXzSgxrwp8vBEhMYGmBdZm7f60s7urafJ
         DlK74wxQU+zysp17tP0ZMYwkkGemhd8u0kWQs=
Received: by 10.223.72.9 with SMTP id k9mr10889444faj.93.1297347437467;
        Thu, 10 Feb 2011 06:17:17 -0800 (PST)
Received: from localhost.localdomain (178-191-11-137.adsl.highway.telekom.at [178.191.11.137])
        by mx.google.com with ESMTPS id n1sm36732fam.16.2011.02.10.06.17.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 06:17:16 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] Alchemy: irq: replace au_readl/writel accessors.
Date:   Thu, 10 Feb 2011 15:17:09 +0100
Message-Id: <1297347429-18215-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297347429-18215-1-git-send-email-manuel.lauss@googlemail.com>
References: <1297347429-18215-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

replace au_readl/au_writel with __raw_readl/__raw_writel;
this also gives the opportunity to clean up the IC-related #defines a bit.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Depends on patch "Alchemy: Convert to new irq methods".

 arch/mips/alchemy/common/irq.c             |  249 +++++++++++++++-------------
 arch/mips/include/asm/mach-au1x00/au1000.h |  120 +-------------
 2 files changed, 138 insertions(+), 231 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index baef9a5..28a86fb 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -39,6 +39,36 @@
 #include <asm/mach-pb1x00/pb1000.h>
 #endif
 
+/* Interrupt Controller register offsets */
+#define IC_CFG0RD	0x40
+#define IC_CFG0SET	0x40
+#define IC_CFG0CLR	0x44
+#define IC_CFG1RD	0x48
+#define IC_CFG1SET	0x48
+#define IC_CFG1CLR	0x4C
+#define IC_CFG2RD	0x50
+#define IC_CFG2SET	0x50
+#define IC_CFG2CLR	0x54
+#define IC_REQ0INT	0x54
+#define IC_SRCRD	0x58
+#define IC_SRCSET	0x58
+#define IC_SRCCLR	0x5C
+#define IC_REQ1INT	0x5C
+#define IC_ASSIGNRD	0x60
+#define IC_ASSIGNSET	0x60
+#define IC_ASSIGNCLR	0x64
+#define IC_WAKERD	0x68
+#define IC_WAKESET	0x68
+#define IC_WAKECLR	0x6C
+#define IC_MASKRD	0x70
+#define IC_MASKSET	0x70
+#define IC_MASKCLR	0x74
+#define IC_RISINGRD	0x78
+#define IC_RISINGCLR	0x78
+#define IC_FALLINGRD	0x7C
+#define IC_FALLINGCLR	0x7C
+#define IC_TESTBIT	0x80
+
 static int ic_settype(unsigned int irq, unsigned int flow_type);
 
 /* NOTE on interrupt priorities: The original writers of this code said:
@@ -221,89 +251,101 @@ struct au1xxx_irqmap au1200_irqmap[] __initdata = {
 static void alchemy_ic0_unmask(struct irq_data *d)
 {
 	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
-	au_writel(1 << bit, IC0_MASKSET);
-	au_writel(1 << bit, IC0_WAKESET);
-	au_sync();
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR);
+
+	__raw_writel(1 << bit, base + IC_MASKSET);
+	__raw_writel(1 << bit, base + IC_WAKESET);
+	wmb();
 }
 
 static void alchemy_ic1_unmask(struct irq_data *d)
 {
 	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
-	au_writel(1 << bit, IC1_MASKSET);
-	au_writel(1 << bit, IC1_WAKESET);
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR);
+
+	__raw_writel(1 << bit, base + IC_MASKSET);
+	__raw_writel(1 << bit, base + IC_WAKESET);
 
 /* very hacky. does the pb1000 cpld auto-disable this int?
  * nowhere in the current kernel sources is it disabled.	--mlau
  */
 #if defined(CONFIG_MIPS_PB1000)
 	if (d->irq == AU1000_GPIO15_INT)
-		au_writel(0x4000, PB1000_MDR); /* enable int */
+		__raw_writel(0x4000, (void __iomem *)PB1000_MDR); /* enable int */
 #endif
-	au_sync();
+	wmb();
 }
 
 static void alchemy_ic0_mask(struct irq_data *d)
 {
 	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
-	au_writel(1 << bit, IC0_MASKCLR);
-	au_writel(1 << bit, IC0_WAKECLR);
-	au_sync();
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR);
+
+	__raw_writel(1 << bit, base + IC_MASKCLR);
+	__raw_writel(1 << bit, base + IC_WAKECLR);
+	wmb();
 }
 
 static void alchemy_ic1_mask(struct irq_data *d)
 {
 	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
-	au_writel(1 << bit, IC1_MASKCLR);
-	au_writel(1 << bit, IC1_WAKECLR);
-	au_sync();
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR);
+
+	__raw_writel(1 << bit, base + IC_MASKCLR);
+	__raw_writel(1 << bit, base + IC_WAKECLR);
+	wmb();
 }
 
 static void alchemy_ic0_ack(struct irq_data *d)
 {
 	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR);
 
 	/*
 	 * This may assume that we don't get interrupts from
 	 * both edges at once, or if we do, that we don't care.
 	 */
-	au_writel(1 << bit, IC0_FALLINGCLR);
-	au_writel(1 << bit, IC0_RISINGCLR);
-	au_sync();
+	__raw_writel(1 << bit, base + IC_FALLINGCLR);
+	__raw_writel(1 << bit, base + IC_RISINGCLR);
+	wmb();
 }
 
 static void alchemy_ic1_ack(struct irq_data *d)
 {
 	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR);
 
 	/*
 	 * This may assume that we don't get interrupts from
 	 * both edges at once, or if we do, that we don't care.
 	 */
-	au_writel(1 << bit, IC1_FALLINGCLR);
-	au_writel(1 << bit, IC1_RISINGCLR);
-	au_sync();
+	__raw_writel(1 << bit, base + IC_FALLINGCLR);
+	__raw_writel(1 << bit, base + IC_RISINGCLR);
+	wmb();
 }
 
 static void alchemy_ic0_maskack(struct irq_data *d)
 {
 	unsigned int bit = d->irq - AU1000_INTC0_INT_BASE;
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR);
 
-	au_writel(1 << bit, IC0_WAKECLR);
-	au_writel(1 << bit, IC0_MASKCLR);
-	au_writel(1 << bit, IC0_RISINGCLR);
-	au_writel(1 << bit, IC0_FALLINGCLR);
-	au_sync();
+	__raw_writel(1 << bit, base + IC_WAKECLR);
+	__raw_writel(1 << bit, base + IC_MASKCLR);
+	__raw_writel(1 << bit, base + IC_RISINGCLR);
+	__raw_writel(1 << bit, base + IC_FALLINGCLR);
+	wmb();
 }
 
 static void alchemy_ic1_maskack(struct irq_data *d)
 {
 	unsigned int bit = d->irq - AU1000_INTC1_INT_BASE;
+	void __iomem *base = (void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR);
 
-	au_writel(1 << bit, IC1_WAKECLR);
-	au_writel(1 << bit, IC1_MASKCLR);
-	au_writel(1 << bit, IC1_RISINGCLR);
-	au_writel(1 << bit, IC1_FALLINGCLR);
-	au_sync();
+	__raw_writel(1 << bit, base + IC_WAKECLR);
+	__raw_writel(1 << bit, base + IC_MASKCLR);
+	__raw_writel(1 << bit, base + IC_RISINGCLR);
+	__raw_writel(1 << bit, base + IC_FALLINGCLR);
+	wmb();
 }
 
 static int alchemy_ic1_setwake(struct irq_data *d, unsigned int on)
@@ -318,13 +360,13 @@ static int alchemy_ic1_setwake(struct irq_data *d, unsigned int on)
 		return -EINVAL;
 
 	local_irq_save(flags);
-	wakemsk = au_readl(SYS_WAKEMSK);
+	wakemsk = __raw_readl((void __iomem *)SYS_WAKEMSK);
 	if (on)
 		wakemsk |= 1 << bit;
 	else
 		wakemsk &= ~(1 << bit);
-	au_writel(wakemsk, SYS_WAKEMSK);
-	au_sync();
+	__raw_writel(wakemsk, (void __iomem *)SYS_WAKEMSK);
+	wmb();
 	local_irq_restore(flags);
 
 	return 0;
@@ -361,79 +403,72 @@ static struct irq_chip alchemy_ic1_chip = {
 static int ic_settype(unsigned int irq, unsigned int flow_type)
 {
 	struct irq_chip *chip;
-	unsigned long icr[6];
-	unsigned int bit, ic;
+	unsigned int bit;
+	void __iomem *base;
 	int ret;
 
 	if (irq >= AU1000_INTC1_INT_BASE) {
 		bit = irq - AU1000_INTC1_INT_BASE;
 		chip = &alchemy_ic1_chip;
-		ic = 1;
+		base = (void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR);
 	} else {
 		bit = irq - AU1000_INTC0_INT_BASE;
 		chip = &alchemy_ic0_chip;
-		ic = 0;
+		base = (void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR);
 	}
 
 	if (bit > 31)
 		return -EINVAL;
 
-	icr[0] = ic ? IC1_CFG0SET : IC0_CFG0SET;
-	icr[1] = ic ? IC1_CFG1SET : IC0_CFG1SET;
-	icr[2] = ic ? IC1_CFG2SET : IC0_CFG2SET;
-	icr[3] = ic ? IC1_CFG0CLR : IC0_CFG0CLR;
-	icr[4] = ic ? IC1_CFG1CLR : IC0_CFG1CLR;
-	icr[5] = ic ? IC1_CFG2CLR : IC0_CFG2CLR;
-
 	ret = 0;
 
 	switch (flow_type) {	/* cfgregs 2:1:0 */
 	case IRQ_TYPE_EDGE_RISING:	/* 0:0:1 */
-		au_writel(1 << bit, icr[5]);
-		au_writel(1 << bit, icr[4]);
-		au_writel(1 << bit, icr[0]);
+		__raw_writel(1 << bit, base + IC_CFG2CLR);
+		__raw_writel(1 << bit, base + IC_CFG1CLR);
+		__raw_writel(1 << bit, base + IC_CFG0SET);
 		set_irq_chip_and_handler_name(irq, chip,
 				handle_edge_irq, "riseedge");
 		break;
 	case IRQ_TYPE_EDGE_FALLING:	/* 0:1:0 */
-		au_writel(1 << bit, icr[5]);
-		au_writel(1 << bit, icr[1]);
-		au_writel(1 << bit, icr[3]);
+		__raw_writel(1 << bit, base + IC_CFG2CLR);
+		__raw_writel(1 << bit, base + IC_CFG1SET);
+		__raw_writel(1 << bit, base + IC_CFG0CLR);
 		set_irq_chip_and_handler_name(irq, chip,
 				handle_edge_irq, "falledge");
 		break;
 	case IRQ_TYPE_EDGE_BOTH:	/* 0:1:1 */
-		au_writel(1 << bit, icr[5]);
-		au_writel(1 << bit, icr[1]);
-		au_writel(1 << bit, icr[0]);
+		__raw_writel(1 << bit, base + IC_CFG2CLR);
+		__raw_writel(1 << bit, base + IC_CFG1SET);
+		__raw_writel(1 << bit, base + IC_CFG0SET);
 		set_irq_chip_and_handler_name(irq, chip,
 				handle_edge_irq, "bothedge");
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:	/* 1:0:1 */
-		au_writel(1 << bit, icr[2]);
-		au_writel(1 << bit, icr[4]);
-		au_writel(1 << bit, icr[0]);
+		__raw_writel(1 << bit, base + IC_CFG2SET);
+		__raw_writel(1 << bit, base + IC_CFG1CLR);
+		__raw_writel(1 << bit, base + IC_CFG0SET);
 		set_irq_chip_and_handler_name(irq, chip,
 				handle_level_irq, "hilevel");
 		break;
 	case IRQ_TYPE_LEVEL_LOW:	/* 1:1:0 */
-		au_writel(1 << bit, icr[2]);
-		au_writel(1 << bit, icr[1]);
-		au_writel(1 << bit, icr[3]);
+		__raw_writel(1 << bit, base + IC_CFG2SET);
+		__raw_writel(1 << bit, base + IC_CFG1SET);
+		__raw_writel(1 << bit, base + IC_CFG0CLR);
 		set_irq_chip_and_handler_name(irq, chip,
 				handle_level_irq, "lowlevel");
 		break;
 	case IRQ_TYPE_NONE:		/* 0:0:0 */
-		au_writel(1 << bit, icr[5]);
-		au_writel(1 << bit, icr[4]);
-		au_writel(1 << bit, icr[3]);
+		__raw_writel(1 << bit, base + IC_CFG2CLR);
+		__raw_writel(1 << bit, base + IC_CFG1CLR);
+		__raw_writel(1 << bit, base + IC_CFG0CLR);
 		/* set at least chip so we can call set_irq_type() on it */
 		set_irq_chip(irq, chip);
 		break;
 	default:
 		ret = -EINVAL;
 	}
-	au_sync();
+	wmb();
 
 	return ret;
 }
@@ -447,21 +482,21 @@ asmlinkage void plat_irq_dispatch(void)
 		off = MIPS_CPU_IRQ_BASE + 7;
 		goto handle;
 	} else if (pending & CAUSEF_IP2) {
-		s = IC0_REQ0INT;
+		s = KSEG1ADDR(AU1000_IC0_PHYS_ADDR) + IC_REQ0INT;
 		off = AU1000_INTC0_INT_BASE;
 	} else if (pending & CAUSEF_IP3) {
-		s = IC0_REQ1INT;
+		s = KSEG1ADDR(AU1000_IC0_PHYS_ADDR) + IC_REQ1INT;
 		off = AU1000_INTC0_INT_BASE;
 	} else if (pending & CAUSEF_IP4) {
-		s = IC1_REQ0INT;
+		s = KSEG1ADDR(AU1000_IC1_PHYS_ADDR) + IC_REQ0INT;
 		off = AU1000_INTC1_INT_BASE;
 	} else if (pending & CAUSEF_IP5) {
-		s = IC1_REQ1INT;
+		s = KSEG1ADDR(AU1000_IC1_PHYS_ADDR) + IC_REQ1INT;
 		off = AU1000_INTC1_INT_BASE;
 	} else
 		goto spurious;
 
-	s = au_readl(s);
+	s = __raw_readl((void __iomem *)s);
 	if (unlikely(!s)) {
 spurious:
 		spurious_interrupt();
@@ -472,48 +507,41 @@ handle:
 	do_IRQ(off);
 }
 
+static inline void ic_init(void __iomem *base)
+{
+	/* initialize interrupt controller to a safe state */
+	__raw_writel(0xffffffff, base + IC_CFG0CLR);
+	__raw_writel(0xffffffff, base + IC_CFG1CLR);
+	__raw_writel(0xffffffff, base + IC_CFG2CLR);
+	__raw_writel(0xffffffff, base + IC_MASKCLR);
+	__raw_writel(0xffffffff, base + IC_ASSIGNCLR);
+	__raw_writel(0xffffffff, base + IC_WAKECLR);
+	__raw_writel(0xffffffff, base + IC_SRCSET);
+	__raw_writel(0xffffffff, base + IC_FALLINGCLR);
+	__raw_writel(0xffffffff, base + IC_RISINGCLR);
+	__raw_writel(0x00000000, base + IC_TESTBIT);
+	wmb();
+}
+
 static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 {
 	unsigned int bit, irq_nr;
-	int i;
-
-	/*
-	 * Initialize interrupt controllers to a safe state.
-	 */
-	au_writel(0xffffffff, IC0_CFG0CLR);
-	au_writel(0xffffffff, IC0_CFG1CLR);
-	au_writel(0xffffffff, IC0_CFG2CLR);
-	au_writel(0xffffffff, IC0_MASKCLR);
-	au_writel(0xffffffff, IC0_ASSIGNCLR);
-	au_writel(0xffffffff, IC0_WAKECLR);
-	au_writel(0xffffffff, IC0_SRCSET);
-	au_writel(0xffffffff, IC0_FALLINGCLR);
-	au_writel(0xffffffff, IC0_RISINGCLR);
-	au_writel(0x00000000, IC0_TESTBIT);
-
-	au_writel(0xffffffff, IC1_CFG0CLR);
-	au_writel(0xffffffff, IC1_CFG1CLR);
-	au_writel(0xffffffff, IC1_CFG2CLR);
-	au_writel(0xffffffff, IC1_MASKCLR);
-	au_writel(0xffffffff, IC1_ASSIGNCLR);
-	au_writel(0xffffffff, IC1_WAKECLR);
-	au_writel(0xffffffff, IC1_SRCSET);
-	au_writel(0xffffffff, IC1_FALLINGCLR);
-	au_writel(0xffffffff, IC1_RISINGCLR);
-	au_writel(0x00000000, IC1_TESTBIT);
+	void __iomem *base;
 
+	ic_init((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR));
+	ic_init((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR));
 	mips_cpu_irq_init();
 
 	/* register all 64 possible IC0+IC1 irq sources as type "none".
 	 * Use set_irq_type() to set edge/level behaviour at runtime.
 	 */
-	for (i = AU1000_INTC0_INT_BASE;
-	     (i < AU1000_INTC0_INT_BASE + 32); i++)
-		ic_settype(i, IRQ_TYPE_NONE);
+	for (irq_nr = AU1000_INTC0_INT_BASE;
+	     (irq_nr < AU1000_INTC0_INT_BASE + 32); irq_nr++)
+		ic_settype(irq_nr, IRQ_TYPE_NONE);
 
-	for (i = AU1000_INTC1_INT_BASE;
-	     (i < AU1000_INTC1_INT_BASE + 32); i++)
-		ic_settype(i, IRQ_TYPE_NONE);
+	for (irq_nr = AU1000_INTC1_INT_BASE;
+	     (irq_nr < AU1000_INTC1_INT_BASE + 32); irq_nr++)
+		ic_settype(irq_nr, IRQ_TYPE_NONE);
 
 	/*
 	 * Initialize IC0, which is fixed per processor.
@@ -523,13 +551,13 @@ static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 
 		if (irq_nr >= AU1000_INTC1_INT_BASE) {
 			bit = irq_nr - AU1000_INTC1_INT_BASE;
-			if (map->im_request)
-				au_writel(1 << bit, IC1_ASSIGNSET);
+			base = (void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR);
 		} else {
 			bit = irq_nr - AU1000_INTC0_INT_BASE;
-			if (map->im_request)
-				au_writel(1 << bit, IC0_ASSIGNSET);
+			base = (void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR);
 		}
+		if (map->im_request)
+			__raw_writel(1 << bit, base + IC_ASSIGNSET);
 
 		ic_settype(irq_nr, map->im_type);
 		++map;
@@ -586,17 +614,8 @@ static int alchemy_ic_resume(struct sys_device *dev)
 	struct alchemy_ic_sysdev *icdev =
 			container_of(dev, struct alchemy_ic_sysdev, sysdev);
 
-	__raw_writel(0xffffffff, icdev->base + IC_MASKCLR);
-	__raw_writel(0xffffffff, icdev->base + IC_CFG0CLR);
-	__raw_writel(0xffffffff, icdev->base + IC_CFG1CLR);
-	__raw_writel(0xffffffff, icdev->base + IC_CFG2CLR);
-	__raw_writel(0xffffffff, icdev->base + IC_SRCCLR);
-	__raw_writel(0xffffffff, icdev->base + IC_ASSIGNCLR);
-	__raw_writel(0xffffffff, icdev->base + IC_WAKECLR);
-	__raw_writel(0xffffffff, icdev->base + IC_RISINGCLR);
-	__raw_writel(0xffffffff, icdev->base + IC_FALLINGCLR);
-	__raw_writel(0x00000000, icdev->base + IC_TESTBIT);
-	wmb();
+	ic_init(icdev->base);
+
 	__raw_writel(icdev->pmdata[0], icdev->base + IC_CFG0SET);
 	__raw_writel(icdev->pmdata[1], icdev->base + IC_CFG1SET);
 	__raw_writel(icdev->pmdata[2], icdev->base + IC_CFG2SET);
@@ -620,7 +639,7 @@ static struct sysdev_class alchemy_ic_sysdev_class = {
 static int __init alchemy_ic_sysdev_init(void)
 {
 	struct alchemy_ic_sysdev *icdev;
-	unsigned long icbase[2] = { IC0_PHYS_ADDR, IC1_PHYS_ADDR };
+	unsigned long icbase[2] = { AU1000_IC0_PHYS_ADDR, AU1000_IC1_PHYS_ADDR };
 	int err, i;
 
 	err = sysdev_class_register(&alchemy_ic_sysdev_class);
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index a697661..f11e9d9 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -632,6 +632,10 @@ enum soc_au1200_ints {
  * Physical base addresses for integrated peripherals
  */
 
+#define AU1000_IC0_PHYS_ADDR	0x10400000
+#define AU1000_IC1_PHYS_ADDR	0x11800000
+
+
 #ifdef CONFIG_SOC_AU1000
 #define	MEM_PHYS_ADDR		0x14000000
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
@@ -643,8 +647,6 @@ enum soc_au1200_ints {
 #define	DMA5_PHYS_ADDR		0x14002500
 #define	DMA6_PHYS_ADDR		0x14002600
 #define	DMA7_PHYS_ADDR		0x14002700
-#define	IC0_PHYS_ADDR		0x10400000
-#define	IC1_PHYS_ADDR		0x11800000
 #define	AC97_PHYS_ADDR		0x10000000
 #define	USBH_PHYS_ADDR		0x10100000
 #define	USBD_PHYS_ADDR		0x10200000
@@ -680,8 +682,6 @@ enum soc_au1200_ints {
 #define	DMA5_PHYS_ADDR		0x14002500
 #define	DMA6_PHYS_ADDR		0x14002600
 #define	DMA7_PHYS_ADDR		0x14002700
-#define	IC0_PHYS_ADDR		0x10400000
-#define	IC1_PHYS_ADDR		0x11800000
 #define	AC97_PHYS_ADDR		0x10000000
 #define	USBH_PHYS_ADDR		0x10100000
 #define	USBD_PHYS_ADDR		0x10200000
@@ -718,10 +718,8 @@ enum soc_au1200_ints {
 #define	DMA5_PHYS_ADDR		0x14002500
 #define	DMA6_PHYS_ADDR		0x14002600
 #define	DMA7_PHYS_ADDR		0x14002700
-#define	IC0_PHYS_ADDR		0x10400000
 #define SD0_PHYS_ADDR		0x10600000
 #define SD1_PHYS_ADDR		0x10680000
-#define	IC1_PHYS_ADDR		0x11800000
 #define	AC97_PHYS_ADDR		0x10000000
 #define	USBH_PHYS_ADDR		0x10100000
 #define	USBD_PHYS_ADDR		0x10200000
@@ -749,8 +747,6 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1550
 #define	MEM_PHYS_ADDR		0x14000000
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define	IC0_PHYS_ADDR		0x10400000
-#define	IC1_PHYS_ADDR		0x11800000
 #define	USBH_PHYS_ADDR		0x14020000
 #define	USBD_PHYS_ADDR		0x10200000
 #define PCI_PHYS_ADDR		0x14005000
@@ -786,8 +782,6 @@ enum soc_au1200_ints {
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
 #define AES_PHYS_ADDR		0x10300000
 #define CIM_PHYS_ADDR		0x14004000
-#define	IC0_PHYS_ADDR		0x10400000
-#define	IC1_PHYS_ADDR		0x11800000
 #define USBM_PHYS_ADDR		0x14020000
 #define	USBH_PHYS_ADDR		0x14020100
 #define	UART0_PHYS_ADDR		0x11100000
@@ -835,112 +829,6 @@ enum soc_au1200_ints {
 #endif
 
 
-/* Interrupt Controller register offsets */
-#define IC_CFG0RD		0x40
-#define IC_CFG0SET		0x40
-#define IC_CFG0CLR		0x44
-#define IC_CFG1RD		0x48
-#define IC_CFG1SET		0x48
-#define IC_CFG1CLR		0x4C
-#define IC_CFG2RD		0x50
-#define IC_CFG2SET		0x50
-#define IC_CFG2CLR		0x54
-#define IC_REQ0INT		0x54
-#define IC_SRCRD		0x58
-#define IC_SRCSET		0x58
-#define IC_SRCCLR		0x5C
-#define IC_REQ1INT		0x5C
-#define IC_ASSIGNRD		0x60
-#define IC_ASSIGNSET		0x60
-#define IC_ASSIGNCLR		0x64
-#define IC_WAKERD		0x68
-#define IC_WAKESET		0x68
-#define IC_WAKECLR		0x6C
-#define IC_MASKRD		0x70
-#define IC_MASKSET		0x70
-#define IC_MASKCLR		0x74
-#define IC_RISINGRD		0x78
-#define IC_RISINGCLR		0x78
-#define IC_FALLINGRD		0x7C
-#define IC_FALLINGCLR		0x7C
-#define IC_TESTBIT		0x80
-
-
-/* Interrupt Controller 0 */
-#define IC0_CFG0RD		0xB0400040
-#define IC0_CFG0SET		0xB0400040
-#define IC0_CFG0CLR		0xB0400044
-
-#define IC0_CFG1RD		0xB0400048
-#define IC0_CFG1SET		0xB0400048
-#define IC0_CFG1CLR		0xB040004C
-
-#define IC0_CFG2RD		0xB0400050
-#define IC0_CFG2SET		0xB0400050
-#define IC0_CFG2CLR		0xB0400054
-
-#define IC0_REQ0INT		0xB0400054
-#define IC0_SRCRD		0xB0400058
-#define IC0_SRCSET		0xB0400058
-#define IC0_SRCCLR		0xB040005C
-#define IC0_REQ1INT		0xB040005C
-
-#define IC0_ASSIGNRD		0xB0400060
-#define IC0_ASSIGNSET		0xB0400060
-#define IC0_ASSIGNCLR		0xB0400064
-
-#define IC0_WAKERD		0xB0400068
-#define IC0_WAKESET		0xB0400068
-#define IC0_WAKECLR		0xB040006C
-
-#define IC0_MASKRD		0xB0400070
-#define IC0_MASKSET		0xB0400070
-#define IC0_MASKCLR		0xB0400074
-
-#define IC0_RISINGRD		0xB0400078
-#define IC0_RISINGCLR		0xB0400078
-#define IC0_FALLINGRD		0xB040007C
-#define IC0_FALLINGCLR		0xB040007C
-
-#define IC0_TESTBIT		0xB0400080
-
-/* Interrupt Controller 1 */
-#define IC1_CFG0RD		0xB1800040
-#define IC1_CFG0SET		0xB1800040
-#define IC1_CFG0CLR		0xB1800044
-
-#define IC1_CFG1RD		0xB1800048
-#define IC1_CFG1SET		0xB1800048
-#define IC1_CFG1CLR		0xB180004C
-
-#define IC1_CFG2RD		0xB1800050
-#define IC1_CFG2SET		0xB1800050
-#define IC1_CFG2CLR		0xB1800054
-
-#define IC1_REQ0INT		0xB1800054
-#define IC1_SRCRD		0xB1800058
-#define IC1_SRCSET		0xB1800058
-#define IC1_SRCCLR		0xB180005C
-#define IC1_REQ1INT		0xB180005C
-
-#define IC1_ASSIGNRD            0xB1800060
-#define IC1_ASSIGNSET           0xB1800060
-#define IC1_ASSIGNCLR           0xB1800064
-
-#define IC1_WAKERD		0xB1800068
-#define IC1_WAKESET		0xB1800068
-#define IC1_WAKECLR		0xB180006C
-
-#define IC1_MASKRD		0xB1800070
-#define IC1_MASKSET		0xB1800070
-#define IC1_MASKCLR		0xB1800074
-
-#define IC1_RISINGRD		0xB1800078
-#define IC1_RISINGCLR		0xB1800078
-#define IC1_FALLINGRD		0xB180007C
-#define IC1_FALLINGCLR		0xB180007C
-
-#define IC1_TESTBIT		0xB1800080
 
 
 /* Au1000 */
-- 
1.7.4
