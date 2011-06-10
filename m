Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:51:36 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52716 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491148Ab1FJVrp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:45 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 7D2204C8037;
        Fri, 10 Jun 2011 23:47:39 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id 01F5D18066C;
        Fri, 10 Jun 2011 23:47:31 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id EEAB655B08D; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 10/11] MIPS: BCM63XX: add external irq support for non 6348 CPUs.
Date:   Fri, 10 Jun 2011 23:47:20 +0200
Message-Id: <1307742441-28284-11-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 30335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9582

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/irq.c                           |   74 ++++++++++++++++-----
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   20 ++++--
 2 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 07909a9..f2d5e30 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -276,7 +276,12 @@ static void bcm63xx_external_irq_mask(struct irq_data *d)
 	u32 reg;
 
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
-	reg &= ~EXTIRQ_CFG_MASK(irq);
+
+	if (BCMCPU_IS_6348())
+		reg &= ~EXTIRQ_CFG_MASK_6348(irq);
+	else
+		reg &= ~EXTIRQ_CFG_MASK(irq);
+
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
 	if (is_ext_irq_cascaded)
 		internal_irq_mask(irq + ext_irq_start);
@@ -288,7 +293,12 @@ static void bcm63xx_external_irq_unmask(struct irq_data *d)
 	u32 reg;
 
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
-	reg |= EXTIRQ_CFG_MASK(irq);
+
+	if (BCMCPU_IS_6348())
+		reg |= EXTIRQ_CFG_MASK_6348(irq);
+	else
+		reg |= EXTIRQ_CFG_MASK(irq);
+
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
 	if (is_ext_irq_cascaded)
 		internal_irq_unmask(irq + ext_irq_start);
@@ -300,7 +310,12 @@ static void bcm63xx_external_irq_clear(struct irq_data *d)
 	u32 reg;
 
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
-	reg |= EXTIRQ_CFG_CLEAR(irq);
+
+	if (BCMCPU_IS_6348())
+		reg |= EXTIRQ_CFG_CLEAR_6348(irq);
+	else
+		reg |= EXTIRQ_CFG_CLEAR(irq);
+
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
 	if (is_ext_irq_cascaded)
 		internal_irq_mask(irq + ext_irq_start);
@@ -330,45 +345,72 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 {
 	unsigned int irq = d->irq - IRQ_EXT_BASE;
 	u32 reg;
+	int levelsense, sense, bothedge;
 
 	flow_type &= IRQ_TYPE_SENSE_MASK;
 
 	if (flow_type == IRQ_TYPE_NONE)
 		flow_type = IRQ_TYPE_LEVEL_LOW;
 
-	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
+	levelsense = sense = bothedge = 0;
 	switch (flow_type) {
 	case IRQ_TYPE_EDGE_BOTH:
-		reg &= ~EXTIRQ_CFG_LEVELSENSE(irq);
-		reg |= EXTIRQ_CFG_BOTHEDGE(irq);
+		bothedge = 1;
 		break;
 
 	case IRQ_TYPE_EDGE_RISING:
-		reg &= ~EXTIRQ_CFG_LEVELSENSE(irq);
-		reg |= EXTIRQ_CFG_SENSE(irq);
-		reg &= ~EXTIRQ_CFG_BOTHEDGE(irq);
+		sense = 1;
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
-		reg &= ~EXTIRQ_CFG_LEVELSENSE(irq);
-		reg &= ~EXTIRQ_CFG_SENSE(irq);
-		reg &= ~EXTIRQ_CFG_BOTHEDGE(irq);
 		break;
 
 	case IRQ_TYPE_LEVEL_HIGH:
-		reg |= EXTIRQ_CFG_LEVELSENSE(irq);
-		reg |= EXTIRQ_CFG_SENSE(irq);
+		levelsense = 1;
+		sense = 1;
 		break;
 
 	case IRQ_TYPE_LEVEL_LOW:
-		reg |= EXTIRQ_CFG_LEVELSENSE(irq);
-		reg &= ~EXTIRQ_CFG_SENSE(irq);
+		levelsense = 1;
 		break;
 
 	default:
 		printk(KERN_ERR "bogus flow type combination given !\n");
 		return -EINVAL;
 	}
+
+	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
+
+	if (BCMCPU_IS_6348()) {
+		if (levelsense)
+			reg |= EXTIRQ_CFG_LEVELSENSE_6348(irq);
+		else
+			reg &= ~EXTIRQ_CFG_LEVELSENSE_6348(irq);
+		if (sense)
+			reg |= EXTIRQ_CFG_SENSE_6348(irq);
+		else
+			reg &= ~EXTIRQ_CFG_SENSE_6348(irq);
+		if (bothedge)
+			reg |= EXTIRQ_CFG_BOTHEDGE_6348(irq);
+		else
+			reg &= ~EXTIRQ_CFG_BOTHEDGE_6348(irq);
+	}
+
+	if (BCMCPU_IS_6338() || BCMCPU_IS_6358() || BCMCPU_IS_6368()) {
+		if (levelsense)
+			reg |= EXTIRQ_CFG_LEVELSENSE(irq);
+		else
+			reg &= ~EXTIRQ_CFG_LEVELSENSE(irq);
+		if (sense)
+			reg |= EXTIRQ_CFG_SENSE(irq);
+		else
+			reg &= ~EXTIRQ_CFG_SENSE(irq);
+		if (bothedge)
+			reg |= EXTIRQ_CFG_BOTHEDGE(irq);
+		else
+			reg &= ~EXTIRQ_CFG_BOTHEDGE(irq);
+	}
+
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
 
 	irqd_set_trigger_type(d, flow_type);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 4354be1..0fa613c 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -104,12 +104,22 @@
 
 /* External Interrupt Configuration register */
 #define PERF_EXTIRQ_CFG_REG		0x14
+
+/* for 6348 only */
+#define EXTIRQ_CFG_SENSE_6348(x)	(1 << (x))
+#define EXTIRQ_CFG_STAT_6348(x)		(1 << (x + 5))
+#define EXTIRQ_CFG_CLEAR_6348(x)	(1 << (x + 10))
+#define EXTIRQ_CFG_MASK_6348(x)		(1 << (x + 15))
+#define EXTIRQ_CFG_BOTHEDGE_6348(x)	(1 << (x + 20))
+#define EXTIRQ_CFG_LEVELSENSE_6348(x)	(1 << (x + 25))
+
+/* for all others */
 #define EXTIRQ_CFG_SENSE(x)		(1 << (x))
-#define EXTIRQ_CFG_STAT(x)		(1 << (x + 5))
-#define EXTIRQ_CFG_CLEAR(x)		(1 << (x + 10))
-#define EXTIRQ_CFG_MASK(x)		(1 << (x + 15))
-#define EXTIRQ_CFG_BOTHEDGE(x)		(1 << (x + 20))
-#define EXTIRQ_CFG_LEVELSENSE(x)	(1 << (x + 25))
+#define EXTIRQ_CFG_STAT(x)		(1 << (x + 4))
+#define EXTIRQ_CFG_CLEAR(x)		(1 << (x + 8))
+#define EXTIRQ_CFG_MASK(x)		(1 << (x + 12))
+#define EXTIRQ_CFG_BOTHEDGE(x)		(1 << (x + 16))
+#define EXTIRQ_CFG_LEVELSENSE(x)	(1 << (x + 20))
 
 #define EXTIRQ_CFG_CLEAR_ALL		(0xf << 10)
 #define EXTIRQ_CFG_MASK_ALL		(0xf << 15)
-- 
1.7.1.1
