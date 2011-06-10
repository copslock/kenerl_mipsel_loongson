Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:51:12 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52695 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491146Ab1FJVrn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:43 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id D9E8B4C8178;
        Fri, 10 Jun 2011 23:47:38 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id F0678180669;
        Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id E5D0355AEB4; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 08/11] MIPS: BCM63XX: prepare irq code to handle different external irq hardware implementation.
Date:   Fri, 10 Jun 2011 23:47:18 +0200
Message-Id: <1307742441-28284-9-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 30334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9581

External irq only works for 6348, change code to prepare support of
other CPUs.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/irq.c |   77 ++++++++++++++++++++++++++++++++++++----------
 1 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index d002831..2e4f317 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -25,18 +25,32 @@ static void __dispatch_internal(void) __maybe_unused;
 #ifdef CONFIG_BCM63XX_CPU_6338
 #define irq_stat_reg		PERF_IRQSTAT_6338_REG
 #define irq_mask_reg		PERF_IRQMASK_6338_REG
+#define is_ext_irq_cascaded	0
+#define ext_irq_start		0
+#define ext_irq_end		0
 #endif
 #ifdef CONFIG_BCM63XX_CPU_6345
 #define irq_stat_reg		PERF_IRQSTAT_6345_REG
 #define irq_mask_reg		PERF_IRQMASK_6345_REG
+#define is_ext_irq_cascaded	0
+#define ext_irq_start		0
+#define ext_irq_end		0
 #endif
 #ifdef CONFIG_BCM63XX_CPU_6348
 #define irq_stat_reg		PERF_IRQSTAT_6348_REG
 #define irq_mask_reg		PERF_IRQMASK_6348_REG
+#define dispatch_internal	__dispatch_internal
+#define is_ext_irq_cascaded	0
+#define ext_irq_start		0
+#define ext_irq_end		0
 #endif
 #ifdef CONFIG_BCM63XX_CPU_6358
 #define irq_stat_reg		PERF_IRQSTAT_6358_REG
 #define irq_mask_reg		PERF_IRQMASK_6358_REG
+#define dispatch_internal	__dispatch_internal
+#define is_ext_irq_cascaded	1
+#define ext_irq_start		(BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE)
+#define ext_irq_end		(BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE)
 #endif
 
 #define dispatch_internal	__dispatch_internal
@@ -51,6 +65,8 @@ static inline void bcm63xx_init_irq(void)
 
 static u32 irq_stat_addr, irq_mask_addr;
 static void (*dispatch_internal)(void);
+static int is_ext_irq_cascaded;
+static unsigned int ext_irq_start, ext_irq_end;
 
 static void bcm63xx_init_irq(void)
 {
@@ -73,6 +89,9 @@ static void bcm63xx_init_irq(void)
 	case BCM6358_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6358_REG;
 		irq_mask_addr += PERF_IRQMASK_6358_REG;
+		is_ext_irq_cascaded = 1;
+		ext_irq_start = BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE;
+		ext_irq_end = BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE;
 		break;
 	default:
 		BUG();
@@ -84,7 +103,11 @@ static void bcm63xx_init_irq(void)
 
 static inline void handle_internal(int intbit)
 {
-	do_IRQ(intbit + IRQ_INTERNAL_BASE);
+	if (is_ext_irq_cascaded &&
+	    intbit >= ext_irq_start && intbit <= ext_irq_end)
+		do_IRQ(intbit - ext_irq_start + IRQ_EXT_BASE);
+	else
+		do_IRQ(intbit + IRQ_INTERNAL_BASE);
 }
 
 /*
@@ -128,14 +151,16 @@ asmlinkage void plat_irq_dispatch(void)
 			do_IRQ(7);
 		if (cause & CAUSEF_IP2)
 			dispatch_internal();
-		if (cause & CAUSEF_IP3)
-			do_IRQ(IRQ_EXT_0);
-		if (cause & CAUSEF_IP4)
-			do_IRQ(IRQ_EXT_1);
-		if (cause & CAUSEF_IP5)
-			do_IRQ(IRQ_EXT_2);
-		if (cause & CAUSEF_IP6)
-			do_IRQ(IRQ_EXT_3);
+		if (!is_ext_irq_cascaded) {
+			if (cause & CAUSEF_IP3)
+				do_IRQ(IRQ_EXT_0);
+			if (cause & CAUSEF_IP4)
+				do_IRQ(IRQ_EXT_1);
+			if (cause & CAUSEF_IP5)
+				do_IRQ(IRQ_EXT_2);
+			if (cause & CAUSEF_IP6)
+				do_IRQ(IRQ_EXT_3);
+		}
 	} while (1);
 }
 
@@ -143,9 +168,8 @@ asmlinkage void plat_irq_dispatch(void)
  * internal IRQs operations: only mask/unmask on PERF irq mask
  * register.
  */
-static inline void bcm63xx_internal_irq_mask(struct irq_data *d)
+static void internal_irq_mask(unsigned int irq)
 {
-	unsigned int irq = d->irq - IRQ_INTERNAL_BASE;
 	u32 mask;
 
 	mask = bcm_readl(irq_mask_addr);
@@ -153,9 +177,8 @@ static inline void bcm63xx_internal_irq_mask(struct irq_data *d)
 	bcm_writel(mask, irq_mask_addr);
 }
 
-static void bcm63xx_internal_irq_unmask(struct irq_data *d)
+static void internal_irq_unmask(unsigned int irq)
 {
-	unsigned int irq = d->irq - IRQ_INTERNAL_BASE;
 	u32 mask;
 
 	mask = bcm_readl(irq_mask_addr);
@@ -163,6 +186,16 @@ static void bcm63xx_internal_irq_unmask(struct irq_data *d)
 	bcm_writel(mask, irq_mask_addr);
 }
 
+static void bcm63xx_internal_irq_mask(struct irq_data *d)
+{
+	internal_irq_mask(d->irq - IRQ_INTERNAL_BASE);
+}
+
+static void bcm63xx_internal_irq_unmask(struct irq_data *d)
+{
+	internal_irq_unmask(d->irq - IRQ_INTERNAL_BASE);
+}
+
 /*
  * external IRQs operations: mask/unmask and clear on PERF external
  * irq control register.
@@ -175,6 +208,8 @@ static void bcm63xx_external_irq_mask(struct irq_data *d)
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
 	reg &= ~EXTIRQ_CFG_MASK(irq);
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+	if (is_ext_irq_cascaded)
+		internal_irq_mask(irq + ext_irq_start);
 }
 
 static void bcm63xx_external_irq_unmask(struct irq_data *d)
@@ -185,6 +220,8 @@ static void bcm63xx_external_irq_unmask(struct irq_data *d)
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
 	reg |= EXTIRQ_CFG_MASK(irq);
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+	if (is_ext_irq_cascaded)
+		internal_irq_unmask(irq + ext_irq_start);
 }
 
 static void bcm63xx_external_irq_clear(struct irq_data *d)
@@ -195,12 +232,16 @@ static void bcm63xx_external_irq_clear(struct irq_data *d)
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
 	reg |= EXTIRQ_CFG_CLEAR(irq);
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+	if (is_ext_irq_cascaded)
+		internal_irq_mask(irq + ext_irq_start);
 }
 
 static unsigned int bcm63xx_external_irq_startup(struct irq_data *d)
 {
-	set_c0_status(0x100 << (d->irq - IRQ_MIPS_BASE));
-	irq_enable_hazard();
+	if (!is_ext_irq_cascaded) {
+		set_c0_status(0x100 << (d->irq - IRQ_MIPS_BASE));
+		irq_enable_hazard();
+	}
 	bcm63xx_external_irq_unmask(d);
 	return 0;
 }
@@ -208,8 +249,10 @@ static unsigned int bcm63xx_external_irq_startup(struct irq_data *d)
 static void bcm63xx_external_irq_shutdown(struct irq_data *d)
 {
 	bcm63xx_external_irq_mask(d);
-	clear_c0_status(0x100 << (d->irq - IRQ_MIPS_BASE));
-	irq_disable_hazard();
+	if (!is_ext_irq_cascaded) {
+		clear_c0_status(0x100 << (d->irq - IRQ_MIPS_BASE));
+		irq_disable_hazard();
+	}
 }
 
 static int bcm63xx_external_irq_set_type(struct irq_data *d,
-- 
1.7.1.1
