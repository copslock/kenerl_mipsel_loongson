Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 19:29:25 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:42185 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904134Ab1KDS2t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 19:28:49 +0100
Received: from sakura.staff.proxad.net (unknown [213.36.7.13])
        by smtp4-g21.free.fr (Postfix) with ESMTP id B65684C8079;
        Fri,  4 Nov 2011 19:28:43 +0100 (CET)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 025D8557C11; Fri,  4 Nov 2011 19:11:58 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Subject: [PATCH v2 08/11] MIPS: BCM63XX: prepare irq code to handle different external irq hardware implementation.
Date:   Fri,  4 Nov 2011 19:09:32 +0100
Message-Id: <1320430175-13725-9-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
To:     ralf@linux-mips.org
X-archive-position: 31397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3897

External irq only works for 6348, change code to prepare support of
other CPUs.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/irq.c                          |  104 ++++++++++++++--------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_irq.h |   12 +--
 arch/mips/include/asm/mach-bcm63xx/irq.h         |    8 ++
 3 files changed, 80 insertions(+), 44 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/irq.h

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index a81cd82..cdf352b 100644
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
+		do_IRQ(intbit - ext_irq_start + IRQ_EXTERNAL_BASE);
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
@@ -163,33 +186,47 @@ static void bcm63xx_internal_irq_unmask(struct irq_data *d)
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
  */
 static void bcm63xx_external_irq_mask(struct irq_data *d)
 {
-	unsigned int irq = d->irq - IRQ_EXT_BASE;
+	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
 	u32 reg;
 
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
 	reg &= ~EXTIRQ_CFG_MASK(irq);
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+	if (is_ext_irq_cascaded)
+		internal_irq_mask(irq + ext_irq_start);
 }
 
 static void bcm63xx_external_irq_unmask(struct irq_data *d)
 {
-	unsigned int irq = d->irq - IRQ_EXT_BASE;
+	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
 	u32 reg;
 
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
 	reg |= EXTIRQ_CFG_MASK(irq);
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
+	if (is_ext_irq_cascaded)
+		internal_irq_unmask(irq + ext_irq_start);
 }
 
 static void bcm63xx_external_irq_clear(struct irq_data *d)
 {
-	unsigned int irq = d->irq - IRQ_EXT_BASE;
+	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
 	u32 reg;
 
 	reg = bcm_perf_readl(PERF_EXTIRQ_CFG_REG);
@@ -197,25 +234,10 @@ static void bcm63xx_external_irq_clear(struct irq_data *d)
 	bcm_perf_writel(reg, PERF_EXTIRQ_CFG_REG);
 }
 
-static unsigned int bcm63xx_external_irq_startup(struct irq_data *d)
-{
-	set_c0_status(0x100 << (d->irq - IRQ_MIPS_BASE));
-	irq_enable_hazard();
-	bcm63xx_external_irq_unmask(d);
-	return 0;
-}
-
-static void bcm63xx_external_irq_shutdown(struct irq_data *d)
-{
-	bcm63xx_external_irq_mask(d);
-	clear_c0_status(0x100 << (d->irq - IRQ_MIPS_BASE));
-	irq_disable_hazard();
-}
-
 static int bcm63xx_external_irq_set_type(struct irq_data *d,
 					 unsigned int flow_type)
 {
-	unsigned int irq = d->irq - IRQ_EXT_BASE;
+	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
 	u32 reg;
 
 	flow_type &= IRQ_TYPE_SENSE_MASK;
@@ -275,9 +297,6 @@ static struct irq_chip bcm63xx_internal_irq_chip = {
 
 static struct irq_chip bcm63xx_external_irq_chip = {
 	.name		= "bcm63xx_epic",
-	.irq_startup	= bcm63xx_external_irq_startup,
-	.irq_shutdown	= bcm63xx_external_irq_shutdown,
-
 	.irq_ack	= bcm63xx_external_irq_clear,
 
 	.irq_mask	= bcm63xx_external_irq_mask,
@@ -292,6 +311,12 @@ static struct irqaction cpu_ip2_cascade_action = {
 	.flags		= IRQF_NO_THREAD,
 };
 
+static struct irqaction cpu_ext_cascade_action = {
+	.handler	= no_action,
+	.name		= "cascade_extirq",
+	.flags		= IRQF_NO_THREAD,
+};
+
 void __init arch_init_irq(void)
 {
 	int i;
@@ -302,9 +327,14 @@ void __init arch_init_irq(void)
 		irq_set_chip_and_handler(i, &bcm63xx_internal_irq_chip,
 					 handle_level_irq);
 
-	for (i = IRQ_EXT_BASE; i < IRQ_EXT_BASE + 4; ++i)
+	for (i = IRQ_EXTERNAL_BASE; i < IRQ_EXTERNAL_BASE + 4; ++i)
 		irq_set_chip_and_handler(i, &bcm63xx_external_irq_chip,
 					 handle_edge_irq);
 
-	setup_irq(IRQ_MIPS_BASE + 2, &cpu_ip2_cascade_action);
+	if (!is_ext_irq_cascaded) {
+		for (i = 3; i < 7; ++i)
+			setup_irq(MIPS_CPU_IRQ_BASE + i, &cpu_ext_cascade_action);
+	}
+
+	setup_irq(MIPS_CPU_IRQ_BASE + 2, &cpu_ip2_cascade_action);
 }
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_irq.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_irq.h
index 5f95577..0c3074b 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_irq.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_irq.h
@@ -3,13 +3,11 @@
 
 #include <bcm63xx_cpu.h>
 
-#define IRQ_MIPS_BASE			0
 #define IRQ_INTERNAL_BASE		8
-
-#define IRQ_EXT_BASE			(IRQ_MIPS_BASE + 3)
-#define IRQ_EXT_0			(IRQ_EXT_BASE + 0)
-#define IRQ_EXT_1			(IRQ_EXT_BASE + 1)
-#define IRQ_EXT_2			(IRQ_EXT_BASE + 2)
-#define IRQ_EXT_3			(IRQ_EXT_BASE + 3)
+#define IRQ_EXTERNAL_BASE		100
+#define IRQ_EXT_0			(IRQ_EXTERNAL_BASE + 0)
+#define IRQ_EXT_1			(IRQ_EXTERNAL_BASE + 1)
+#define IRQ_EXT_2			(IRQ_EXTERNAL_BASE + 2)
+#define IRQ_EXT_3			(IRQ_EXTERNAL_BASE + 3)
 
 #endif /* ! BCM63XX_IRQ_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/irq.h b/arch/mips/include/asm/mach-bcm63xx/irq.h
new file mode 100644
index 0000000..d66fbab
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/irq.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_MACH_BCM63XX_IRQ_H
+#define __ASM_MACH_BCM63XX_IRQ_H
+
+#define NR_IRQS	128
+#define MIPS_CPU_IRQ_BASE 0
+
+#endif
+
-- 
1.7.1.1
