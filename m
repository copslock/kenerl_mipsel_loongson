Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 20:11:00 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:54160 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903690Ab1KJTKG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2011 20:10:06 +0100
Received: by faar25 with SMTP id r25so119316faa.36
        for <multiple recipients>; Thu, 10 Nov 2011 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=19qXFvN5wIQ0hdTqSxlj+ngS51Tx8pCieEw5c/FrSfQ=;
        b=pKLPFLecLkNs3hiFn8pH890oURY+Gyrcz3XFgWNETYR+fk1j1rKHuWX9gwTo5DQ6pR
         SV4vtMPKVLHd6OBrLUay8ALAScxvoWHunDDKYGr+PrOBXPjvm7pha2/nFQadhyON4kl7
         pxVAonfehayBru/0YHAg6BHcJOVlIzDIogBzA=
Received: by 10.152.0.130 with SMTP id 2mr5358372lae.0.1320952201438;
        Thu, 10 Nov 2011 11:10:01 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-13-175.adsl.highway.telekom.at. [188.22.13.175])
        by mx.google.com with ESMTPS id tu2sm8213580lab.11.2011.11.10.11.09.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 11:10:00 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH mips-next 1/3] MIPS: Alchemy: irq: register pm at irq init time
Date:   Thu, 10 Nov 2011 20:09:36 +0100
Message-Id: <1320952178-14228-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.2
In-Reply-To: <1320952178-14228-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320952178-14228-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9700

no need for a device_initcall.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/gpioint.c |   74 ++++++++++++-----------
 arch/mips/alchemy/common/irq.c     |  113 +++++++++++++++++-------------------
 2 files changed, 91 insertions(+), 96 deletions(-)

diff --git a/arch/mips/alchemy/common/gpioint.c b/arch/mips/alchemy/common/gpioint.c
index b8cd336..5d7729a 100644
--- a/arch/mips/alchemy/common/gpioint.c
+++ b/arch/mips/alchemy/common/gpioint.c
@@ -278,41 +278,7 @@ static int au1300_gpic_settype(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static void __init alchemy_gpic_init_irq(const struct gpic_devint_data *dints)
-{
-	int i;
-	void __iomem *bank_base;
-
-	mips_cpu_irq_init();
-
-	/* disable & ack all possible interrupt sources */
-	for (i = 0; i < 4; i++) {
-		bank_base = AU1300_GPIC_ADDR + (i * 4);
-		__raw_writel(~0UL, bank_base + AU1300_GPIC_IDIS);
-		wmb();
-		__raw_writel(~0UL, bank_base + AU1300_GPIC_IPEND);
-		wmb();
-	}
-
-	/* register an irq_chip for them, with 2nd highest priority */
-	for (i = ALCHEMY_GPIC_INT_BASE; i <= ALCHEMY_GPIC_INT_LAST; i++) {
-		au1300_set_irq_priority(i, 1);
-		au1300_gpic_settype(irq_get_irq_data(i), IRQ_TYPE_NONE);
-	}
-
-	/* setup known on-chip sources */
-	while ((i = dints->irq) != -1) {
-		au1300_gpic_settype(irq_get_irq_data(i), dints->type);
-		au1300_set_irq_priority(i, dints->prio);
-
-		if (dints->internal)
-			au1300_pinfunc_to_dev(i - ALCHEMY_GPIC_INT_BASE);
-
-		dints++;
-	}
-
-	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
-}
+/******************************************************************************/
 
 static unsigned long alchemy_gpic_pmdata[ALCHEMY_GPIC_INT_NUM + 6];
 
@@ -383,6 +349,43 @@ static struct syscore_ops alchemy_gpic_pmops = {
 	.resume		= alchemy_gpic_resume,
 };
 
+static void __init alchemy_gpic_init_irq(const struct gpic_devint_data *dints)
+{
+	int i;
+	void __iomem *bank_base;
+
+	register_syscore_ops(&alchemy_gpic_pmops);
+	mips_cpu_irq_init();
+
+	/* disable & ack all possible interrupt sources */
+	for (i = 0; i < 4; i++) {
+		bank_base = AU1300_GPIC_ADDR + (i * 4);
+		__raw_writel(~0UL, bank_base + AU1300_GPIC_IDIS);
+		wmb();
+		__raw_writel(~0UL, bank_base + AU1300_GPIC_IPEND);
+		wmb();
+	}
+
+	/* register an irq_chip for them, with 2nd highest priority */
+	for (i = ALCHEMY_GPIC_INT_BASE; i <= ALCHEMY_GPIC_INT_LAST; i++) {
+		au1300_set_irq_priority(i, 1);
+		au1300_gpic_settype(irq_get_irq_data(i), IRQ_TYPE_NONE);
+	}
+
+	/* setup known on-chip sources */
+	while ((i = dints->irq) != -1) {
+		au1300_gpic_settype(irq_get_irq_data(i), dints->type);
+		au1300_set_irq_priority(i, dints->prio);
+
+		if (dints->internal)
+			au1300_pinfunc_to_dev(i - ALCHEMY_GPIC_INT_BASE);
+
+		dints++;
+	}
+
+	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
+}
+
 /**********************************************************************/
 
 void __init arch_init_irq(void)
@@ -390,7 +393,6 @@ void __init arch_init_irq(void)
 	switch (alchemy_get_cputype()) {
 	case ALCHEMY_CPU_AU1300:
 		alchemy_gpic_init_irq(&au1300_devints[0]);
-		register_syscore_ops(&alchemy_gpic_pmops);
 		break;
 	}
 }
diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index 2a94a64..f206e24 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -510,6 +510,58 @@ static inline void ic_init(void __iomem *base)
 	wmb();
 }
 
+static unsigned long alchemy_ic_pmdata[7 * 2];
+
+static inline void alchemy_ic_suspend_one(void __iomem *base, unsigned long *d)
+{
+	d[0] = __raw_readl(base + IC_CFG0RD);
+	d[1] = __raw_readl(base + IC_CFG1RD);
+	d[2] = __raw_readl(base + IC_CFG2RD);
+	d[3] = __raw_readl(base + IC_SRCRD);
+	d[4] = __raw_readl(base + IC_ASSIGNRD);
+	d[5] = __raw_readl(base + IC_WAKERD);
+	d[6] = __raw_readl(base + IC_MASKRD);
+	ic_init(base);		/* shut it up too while at it */
+}
+
+static inline void alchemy_ic_resume_one(void __iomem *base, unsigned long *d)
+{
+	ic_init(base);
+
+	__raw_writel(d[0], base + IC_CFG0SET);
+	__raw_writel(d[1], base + IC_CFG1SET);
+	__raw_writel(d[2], base + IC_CFG2SET);
+	__raw_writel(d[3], base + IC_SRCSET);
+	__raw_writel(d[4], base + IC_ASSIGNSET);
+	__raw_writel(d[5], base + IC_WAKESET);
+	wmb();
+
+	__raw_writel(d[6], base + IC_MASKSET);
+	wmb();
+}
+
+static int alchemy_ic_suspend(void)
+{
+	alchemy_ic_suspend_one((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR),
+			       alchemy_ic_pmdata);
+	alchemy_ic_suspend_one((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR),
+			       &alchemy_ic_pmdata[7]);
+	return 0;
+}
+
+static void alchemy_ic_resume(void)
+{
+	alchemy_ic_resume_one((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR),
+			      &alchemy_ic_pmdata[7]);
+	alchemy_ic_resume_one((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR),
+			      alchemy_ic_pmdata);
+}
+
+static struct syscore_ops alchemy_ic_syscore_ops = {
+	.suspend	= alchemy_ic_suspend,
+	.resume		= alchemy_ic_resume,
+};
+
 static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 {
 	unsigned int bit, irq_nr;
@@ -517,6 +569,7 @@ static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 
 	ic_init((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR));
 	ic_init((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR));
+	register_syscore_ops(&alchemy_ic_syscore_ops);
 	mips_cpu_irq_init();
 
 	/* register all 64 possible IC0+IC1 irq sources as type "none".
@@ -573,63 +626,3 @@ void __init arch_init_irq(void)
 		break;
 	}
 }
-
-
-static unsigned long alchemy_ic_pmdata[7 * 2];
-
-static inline void alchemy_ic_suspend_one(void __iomem *base, unsigned long *d)
-{
-	d[0] = __raw_readl(base + IC_CFG0RD);
-	d[1] = __raw_readl(base + IC_CFG1RD);
-	d[2] = __raw_readl(base + IC_CFG2RD);
-	d[3] = __raw_readl(base + IC_SRCRD);
-	d[4] = __raw_readl(base + IC_ASSIGNRD);
-	d[5] = __raw_readl(base + IC_WAKERD);
-	d[6] = __raw_readl(base + IC_MASKRD);
-	ic_init(base);		/* shut it up too while at it */
-}
-
-static inline void alchemy_ic_resume_one(void __iomem *base, unsigned long *d)
-{
-	ic_init(base);
-
-	__raw_writel(d[0], base + IC_CFG0SET);
-	__raw_writel(d[1], base + IC_CFG1SET);
-	__raw_writel(d[2], base + IC_CFG2SET);
-	__raw_writel(d[3], base + IC_SRCSET);
-	__raw_writel(d[4], base + IC_ASSIGNSET);
-	__raw_writel(d[5], base + IC_WAKESET);
-	wmb();
-
-	__raw_writel(d[6], base + IC_MASKSET);
-	wmb();
-}
-
-static int alchemy_ic_suspend(void)
-{
-	alchemy_ic_suspend_one((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR),
-			       alchemy_ic_pmdata);
-	alchemy_ic_suspend_one((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR),
-			       &alchemy_ic_pmdata[7]);
-	return 0;
-}
-
-static void alchemy_ic_resume(void)
-{
-	alchemy_ic_resume_one((void __iomem *)KSEG1ADDR(AU1000_IC1_PHYS_ADDR),
-			      &alchemy_ic_pmdata[7]);
-	alchemy_ic_resume_one((void __iomem *)KSEG1ADDR(AU1000_IC0_PHYS_ADDR),
-			      alchemy_ic_pmdata);
-}
-
-static struct syscore_ops alchemy_ic_syscore_ops = {
-	.suspend	= alchemy_ic_suspend,
-	.resume		= alchemy_ic_resume,
-};
-
-static int __init alchemy_ic_pm_init(void)
-{
-	register_syscore_ops(&alchemy_ic_syscore_ops);
-	return 0;
-}
-device_initcall(alchemy_ic_pm_init);
-- 
1.7.7.2
