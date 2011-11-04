Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 19:28:55 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:42186 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904133Ab1KDS2s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 19:28:48 +0100
Received: from sakura.staff.proxad.net (unknown [213.36.7.13])
        by smtp4-g21.free.fr (Postfix) with ESMTP id B65AE4C82DD;
        Fri,  4 Nov 2011 19:28:43 +0100 (CET)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id E57EF557C0F; Fri,  4 Nov 2011 19:11:58 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Subject: [PATCH v2 07/11] MIPS: BCM63XX: change irq code to prepare for per-cpu peculiarity.
Date:   Fri,  4 Nov 2011 19:09:31 +0100
Message-Id: <1320430175-13725-8-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
To:     ralf@linux-mips.org
X-archive-position: 31396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3896

No functionnal change is introduced by this patch.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/irq.c                           |   86 ++++++++++++++++++--
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   10 ++-
 2 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 162e11b..a81cd82 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -19,19 +19,86 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_irq.h>
 
+static void __dispatch_internal(void) __maybe_unused;
+
+#ifndef BCMCPU_RUNTIME_DETECT
+#ifdef CONFIG_BCM63XX_CPU_6338
+#define irq_stat_reg		PERF_IRQSTAT_6338_REG
+#define irq_mask_reg		PERF_IRQMASK_6338_REG
+#endif
+#ifdef CONFIG_BCM63XX_CPU_6345
+#define irq_stat_reg		PERF_IRQSTAT_6345_REG
+#define irq_mask_reg		PERF_IRQMASK_6345_REG
+#endif
+#ifdef CONFIG_BCM63XX_CPU_6348
+#define irq_stat_reg		PERF_IRQSTAT_6348_REG
+#define irq_mask_reg		PERF_IRQMASK_6348_REG
+#endif
+#ifdef CONFIG_BCM63XX_CPU_6358
+#define irq_stat_reg		PERF_IRQSTAT_6358_REG
+#define irq_mask_reg		PERF_IRQMASK_6358_REG
+#endif
+
+#define dispatch_internal	__dispatch_internal
+
+#define irq_stat_addr	(bcm63xx_regset_address(RSET_PERF) + irq_stat_reg)
+#define irq_mask_addr	(bcm63xx_regset_address(RSET_PERF) + irq_mask_reg)
+
+static inline void bcm63xx_init_irq(void)
+{
+}
+#else /* ! BCMCPU_RUNTIME_DETECT */
+
+static u32 irq_stat_addr, irq_mask_addr;
+static void (*dispatch_internal)(void);
+
+static void bcm63xx_init_irq(void)
+{
+	irq_stat_addr = bcm63xx_regset_address(RSET_PERF);
+	irq_mask_addr = bcm63xx_regset_address(RSET_PERF);
+
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6338_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6338_REG;
+		irq_mask_addr += PERF_IRQMASK_6338_REG;
+		break;
+	case BCM6345_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6345_REG;
+		irq_mask_addr += PERF_IRQMASK_6345_REG;
+		break;
+	case BCM6348_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6348_REG;
+		irq_mask_addr += PERF_IRQMASK_6348_REG;
+		break;
+	case BCM6358_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6358_REG;
+		irq_mask_addr += PERF_IRQMASK_6358_REG;
+		break;
+	default:
+		BUG();
+	}
+
+	dispatch_internal = __dispatch_internal;
+}
+#endif /* ! BCMCPU_RUNTIME_DETECT */
+
+static inline void handle_internal(int intbit)
+{
+	do_IRQ(intbit + IRQ_INTERNAL_BASE);
+}
+
 /*
  * dispatch internal devices IRQ (uart, enet, watchdog, ...). do not
  * prioritize any interrupt relatively to another. the static counter
  * will resume the loop where it ended the last time we left this
  * function.
  */
-static void bcm63xx_irq_dispatch_internal(void)
+static void __dispatch_internal(void)
 {
 	u32 pending;
 	static int i;
 
-	pending = bcm_perf_readl(PERF_IRQMASK_REG) &
-		bcm_perf_readl(PERF_IRQSTAT_REG);
+	pending = bcm_readl(irq_stat_addr) & bcm_readl(irq_mask_addr);
 
 	if (!pending)
 		return ;
@@ -41,7 +108,7 @@ static void bcm63xx_irq_dispatch_internal(void)
 
 		i = (i + 1) & 0x1f;
 		if (pending & (1 << to_call)) {
-			do_IRQ(to_call + IRQ_INTERNAL_BASE);
+			handle_internal(to_call);
 			break;
 		}
 	}
@@ -60,7 +127,7 @@ asmlinkage void plat_irq_dispatch(void)
 		if (cause & CAUSEF_IP7)
 			do_IRQ(7);
 		if (cause & CAUSEF_IP2)
-			bcm63xx_irq_dispatch_internal();
+			dispatch_internal();
 		if (cause & CAUSEF_IP3)
 			do_IRQ(IRQ_EXT_0);
 		if (cause & CAUSEF_IP4)
@@ -81,9 +148,9 @@ static inline void bcm63xx_internal_irq_mask(struct irq_data *d)
 	unsigned int irq = d->irq - IRQ_INTERNAL_BASE;
 	u32 mask;
 
-	mask = bcm_perf_readl(PERF_IRQMASK_REG);
+	mask = bcm_readl(irq_mask_addr);
 	mask &= ~(1 << irq);
-	bcm_perf_writel(mask, PERF_IRQMASK_REG);
+	bcm_writel(mask, irq_mask_addr);
 }
 
 static void bcm63xx_internal_irq_unmask(struct irq_data *d)
@@ -91,9 +158,9 @@ static void bcm63xx_internal_irq_unmask(struct irq_data *d)
 	unsigned int irq = d->irq - IRQ_INTERNAL_BASE;
 	u32 mask;
 
-	mask = bcm_perf_readl(PERF_IRQMASK_REG);
+	mask = bcm_readl(irq_mask_addr);
 	mask |= (1 << irq);
-	bcm_perf_writel(mask, PERF_IRQMASK_REG);
+	bcm_writel(mask, irq_mask_addr);
 }
 
 /*
@@ -229,6 +296,7 @@ void __init arch_init_irq(void)
 {
 	int i;
 
+	bcm63xx_init_irq();
 	mips_cpu_irq_init();
 	for (i = IRQ_INTERNAL_BASE; i < NR_IRQS; ++i)
 		irq_set_chip_and_handler(i, &bcm63xx_internal_irq_chip,
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 3ea2681..25676cd 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -88,10 +88,16 @@
 #define SYS_PLL_SOFT_RESET		0x1
 
 /* Interrupt Mask register */
-#define PERF_IRQMASK_REG		0xc
+#define PERF_IRQMASK_6338_REG		0xc
+#define PERF_IRQMASK_6345_REG		0xc
+#define PERF_IRQMASK_6348_REG		0xc
+#define PERF_IRQMASK_6358_REG		0xc
 
 /* Interrupt Status register */
-#define PERF_IRQSTAT_REG		0x10
+#define PERF_IRQSTAT_6338_REG		0x10
+#define PERF_IRQSTAT_6345_REG		0x10
+#define PERF_IRQSTAT_6348_REG		0x10
+#define PERF_IRQSTAT_6358_REG		0x10
 
 /* External Interrupt Configuration register */
 #define PERF_EXTIRQ_CFG_REG		0x14
-- 
1.7.1.1
