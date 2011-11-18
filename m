Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 19:40:17 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:42260 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904137Ab1KRSkI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 19:40:08 +0100
Received: from [192.168.108.17] (unknown [213.36.7.13])
        by smtp4-g21.free.fr (Postfix) with ESMTP id D383F4C83DA;
        Fri, 18 Nov 2011 19:40:02 +0100 (CET)
Subject: [PATCH v3 10/11] MIPS: BCM63XX: add external irq support for non
 6348 CPUs.
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jonas Gorski <jonas.gorski+openwrt@gmail.com>,
        linux-mips@linux-mips.org
In-Reply-To: <20111116113323.GI1157@linux-mips.org>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
         <1320430175-13725-11-git-send-email-mbizon@freebox.fr>
         <CAOiHx=kLxqVG+x++2NHF9s8tBpxAgt4yS924rUY9T4MA0iXqnA@mail.gmail.com>
         <20111116113323.GI1157@linux-mips.org>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Organization: Freebox
Date:   Fri, 18 Nov 2011 19:40:01 +0100
Message-ID: <1321641601.32730.35.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 31804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15786


On Wed, 2011-11-16 at 11:33 +0000, Ralf Baechle wrote:

> I've queued this one for 3.3 as is but could you take care of Jonas'
> complaints?  You can either send me a replacement for this patch or
> an incremental patch, whatever is easier for you. 

updated patch attached, please also update upcoming patch 11/11


Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/irq.c                           |  141 ++++++++++++++++-----
 arch/mips/bcm63xx/setup.c                         |   36 +++++-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   32 ++++--
 3 files changed, 166 insertions(+), 43 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index fde8bb4..19ce68c 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -34,6 +34,9 @@ static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 #define is_ext_irq_cascaded	0
 #define ext_irq_start		0
 #define ext_irq_end		0
+#define ext_irq_count		4
+#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6338
+#define ext_irq_cfg_reg2	0
 #endif
 #ifdef CONFIG_BCM63XX_CPU_6345
 #define irq_stat_reg		PERF_IRQSTAT_6345_REG
@@ -42,6 +45,9 @@ static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 #define is_ext_irq_cascaded	0
 #define ext_irq_start		0
 #define ext_irq_end		0
+#define ext_irq_count		4
+#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6345
+#define ext_irq_cfg_reg2	0
 #endif
 #ifdef CONFIG_BCM63XX_CPU_6348
 #define irq_stat_reg		PERF_IRQSTAT_6348_REG
@@ -50,6 +56,9 @@ static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 #define is_ext_irq_cascaded	0
 #define ext_irq_start		0
 #define ext_irq_end		0
+#define ext_irq_count		4
+#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6348
+#define ext_irq_cfg_reg2	0
 #endif
 #ifdef CONFIG_BCM63XX_CPU_6358
 #define irq_stat_reg		PERF_IRQSTAT_6358_REG
@@ -58,6 +67,9 @@ static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 #define is_ext_irq_cascaded	1
 #define ext_irq_start		(BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE)
 #define ext_irq_end		(BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE)
+#define ext_irq_count		4
+#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6358
+#define ext_irq_cfg_reg2	0
 #endif
 
 #if irq_bits == 32
@@ -81,7 +93,9 @@ static inline void bcm63xx_init_irq(void)
 static u32 irq_stat_addr, irq_mask_addr;
 static void (*dispatch_internal)(void);
 static int is_ext_irq_cascaded;
+static unsigned int ext_irq_count;
 static unsigned int ext_irq_start, ext_irq_end;
+static unsigned int ext_irq_cfg_reg1, ext_irq_cfg_reg2;
 static void (*internal_irq_mask)(unsigned int irq);
 static void (*internal_irq_unmask)(unsigned int irq);
 
@@ -97,24 +111,32 @@ static void bcm63xx_init_irq(void)
 		irq_stat_addr += PERF_IRQSTAT_6338_REG;
 		irq_mask_addr += PERF_IRQMASK_6338_REG;
 		irq_bits = 32;
+		ext_irq_count = 4;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6338;
 		break;
 	case BCM6345_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6345_REG;
 		irq_mask_addr += PERF_IRQMASK_6345_REG;
 		irq_bits = 32;
+		ext_irq_count = 4;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6345;
 		break;
 	case BCM6348_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6348_REG;
 		irq_mask_addr += PERF_IRQMASK_6348_REG;
 		irq_bits = 32;
+		ext_irq_count = 4;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6348;
 		break;
 	case BCM6358_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6358_REG;
 		irq_mask_addr += PERF_IRQMASK_6358_REG;
 		irq_bits = 32;
+		ext_irq_count = 4;
 		is_ext_irq_cascaded = 1;
 		ext_irq_start = BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE;
 		ext_irq_end = BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6358;
 		break;
 	default:
 		BUG();
@@ -132,6 +154,13 @@ static void bcm63xx_init_irq(void)
 }
 #endif /* ! BCMCPU_RUNTIME_DETECT */
 
+static inline u32 get_ext_irq_perf_reg(int irq)
+{
+	if (irq < 4)
+		return ext_irq_cfg_reg1;
+	return ext_irq_cfg_reg2;
+}
+
 static inline void handle_internal(int intbit)
 {
 	if (is_ext_irq_cascaded &&
@@ -273,11 +302,17 @@ static void bcm63xx_internal_irq_unmask(struct irq_data *d)
 static void bcm63xx_external_irq_mask(struct irq_data *d)
 {
 	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
-	u32 reg;
+	u32 reg, regaddr;
+
+	regaddr = get_ext_irq_perf_reg(irq);
+	reg = bcm_perf_readl(regaddr);
 
-	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
-	reg &= ~EXTIRQ_CFG_MASK(irq);
-	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+	if (BCMCPU_IS_6348())
+		reg &= ~EXTIRQ_CFG_MASK_6348(irq % 4);
+	else
+		reg &= ~EXTIRQ_CFG_MASK(irq % 4);
+
+	bcm_perf_writel(reg, regaddr);
 	if (is_ext_irq_cascaded)
 		internal_irq_mask(irq + ext_irq_start);
 }
@@ -285,11 +320,18 @@ static void bcm63xx_external_irq_mask(struct irq_data *d)
 static void bcm63xx_external_irq_unmask(struct irq_data *d)
 {
 	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
-	u32 reg;
+	u32 reg, regaddr;
+
+	regaddr = get_ext_irq_perf_reg(irq);
+	reg = bcm_perf_readl(regaddr);
+
+	if (BCMCPU_IS_6348())
+		reg |= EXTIRQ_CFG_MASK_6348(irq % 4);
+	else
+		reg |= EXTIRQ_CFG_MASK(irq % 4);
+
+	bcm_perf_writel(reg, regaddr);
 
-	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
-	reg |= EXTIRQ_CFG_MASK(irq);
-	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
 	if (is_ext_irq_cascaded)
 		internal_irq_unmask(irq + ext_irq_start);
 }
@@ -297,58 +339,99 @@ static void bcm63xx_external_irq_unmask(struct irq_data *d)
 static void bcm63xx_external_irq_clear(struct irq_data *d)
 {
 	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
-	u32 reg;
+	u32 reg, regaddr;
+
+	regaddr = get_ext_irq_perf_reg(irq);
+	reg = bcm_perf_readl(regaddr);
 
-	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
-	reg |= EXTIRQ_CFG_CLEAR(irq);
-	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+	if (BCMCPU_IS_6348())
+		reg |= EXTIRQ_CFG_CLEAR_6348(irq % 4);
+	else
+		reg |= EXTIRQ_CFG_CLEAR(irq % 4);
+
+	bcm_perf_writel(reg, regaddr);
 }
 
 static int bcm63xx_external_irq_set_type(struct irq_data *d,
 					 unsigned int flow_type)
 {
 	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
-	u32 reg;
+	u32 reg, regaddr;
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
-	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+
+	regaddr = get_ext_irq_perf_reg(irq);
+	reg = bcm_perf_readl(regaddr);
+	irq %= 4;
+
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6348_CPU_ID:
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
+		break;
+
+	case BCM6338_CPU_ID:
+	case BCM6345_CPU_ID:
+	case BCM6358_CPU_ID:
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
+		break;
+	default:
+		BUG();
+	}
+
+	bcm_perf_writel(reg, regaddr);
 
 	irqd_set_trigger_type(d, flow_type);
 	if (flow_type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
@@ -397,12 +480,12 @@ void __init arch_init_irq(void)
 		irq_set_chip_and_handler(i, &bcm63xx_internal_irq_chip,
 					 handle_level_irq);
 
-	for (i = IRQ_EXTERNAL_BASE; i < IRQ_EXTERNAL_BASE + 4; ++i)
+	for (i = IRQ_EXTERNAL_BASE; i < IRQ_EXTERNAL_BASE + ext_irq_count; ++i)
 		irq_set_chip_and_handler(i, &bcm63xx_external_irq_chip,
 					 handle_edge_irq);
 
 	if (!is_ext_irq_cascaded) {
-		for (i = 3; i < 7; ++i)
+		for (i = 3; i < 3 + ext_irq_count; ++i)
 			setup_irq(MIPS_CPU_IRQ_BASE + i, &cpu_ext_cascade_action);
 	}
 
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 04a3499..535e587 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -63,13 +63,39 @@ static void bcm6348_a1_reboot(void)
 
 void bcm63xx_machine_reboot(void)
 {
-	u32 reg;
+	u32 reg, perf_regs[2] = { 0, 0 };
+	unsigned int i;
 
 	/* mask and clear all external irq */
-	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
-	reg &= ~EXTIRQ_CFG_MASK_ALL;
-	reg |= EXTIRQ_CFG_CLEAR_ALL;
-	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6338_CPU_ID:
+		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6338;
+		break;
+	case BCM6345_CPU_ID:
+		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6345;
+		break;
+	case BCM6348_CPU_ID:
+		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6348;
+		break;
+	case BCM6358_CPU_ID:
+		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6358;
+		break;
+	}
+
+	for (i = 0; i < 2; i++) {
+		if (!perf_regs[i])
+			break;
+
+		reg = bcm_perf_readl(perf_regs[i]);
+		if (BCMCPU_IS_6348()) {
+			reg &= ~EXTIRQ_CFG_MASK_ALL_6348;
+			reg |= EXTIRQ_CFG_CLEAR_ALL_6348;
+		} else {
+			reg &= ~EXTIRQ_CFG_MASK_ALL;
+			reg |= EXTIRQ_CFG_CLEAR_ALL;
+		}
+		bcm_perf_writel(reg, perf_regs[i]);
+	}
 
 	if (BCMCPU_IS_6348() && (bcm63xx_get_cpu_rev() == 0xa1))
 		bcm6348_a1_reboot();
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 25676cd..09887a2 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -100,16 +100,30 @@
 #define PERF_IRQSTAT_6358_REG		0x10
 
 /* External Interrupt Configuration register */
-#define PERF_EXTIRQ_CFG_REG		0x14
+#define PERF_EXTIRQ_CFG_REG_6338	0x14
+#define PERF_EXTIRQ_CFG_REG_6345	0x14
+#define PERF_EXTIRQ_CFG_REG_6348	0x14
+#define PERF_EXTIRQ_CFG_REG_6358	0x14
+
+/* for 6348 only */
+#define EXTIRQ_CFG_SENSE_6348(x)	(1 << (x))
+#define EXTIRQ_CFG_STAT_6348(x)		(1 << (x + 5))
+#define EXTIRQ_CFG_CLEAR_6348(x)	(1 << (x + 10))
+#define EXTIRQ_CFG_MASK_6348(x)		(1 << (x + 15))
+#define EXTIRQ_CFG_BOTHEDGE_6348(x)	(1 << (x + 20))
+#define EXTIRQ_CFG_LEVELSENSE_6348(x)	(1 << (x + 25))
+#define EXTIRQ_CFG_CLEAR_ALL_6348	(0xf << 10)
+#define EXTIRQ_CFG_MASK_ALL_6348	(0xf << 15)
+
+/* for all others */
 #define EXTIRQ_CFG_SENSE(x)		(1 << (x))
-#define EXTIRQ_CFG_STAT(x)		(1 << (x + 5))
-#define EXTIRQ_CFG_CLEAR(x)		(1 << (x + 10))
-#define EXTIRQ_CFG_MASK(x)		(1 << (x + 15))
-#define EXTIRQ_CFG_BOTHEDGE(x)		(1 << (x + 20))
-#define EXTIRQ_CFG_LEVELSENSE(x)	(1 << (x + 25))
-
-#define EXTIRQ_CFG_CLEAR_ALL		(0xf << 10)
-#define EXTIRQ_CFG_MASK_ALL		(0xf << 15)
+#define EXTIRQ_CFG_STAT(x)		(1 << (x + 4))
+#define EXTIRQ_CFG_CLEAR(x)		(1 << (x + 8))
+#define EXTIRQ_CFG_MASK(x)		(1 << (x + 12))
+#define EXTIRQ_CFG_BOTHEDGE(x)		(1 << (x + 16))
+#define EXTIRQ_CFG_LEVELSENSE(x)	(1 << (x + 20))
+#define EXTIRQ_CFG_CLEAR_ALL		(0xf << 8)
+#define EXTIRQ_CFG_MASK_ALL		(0xf << 12)
 
 /* Soft Reset register */
 #define PERF_SOFTRESET_REG		0x28
-- 
1.7.1.1




-- 
Maxime
