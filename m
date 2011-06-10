Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:50:03 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52681 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491140Ab1FJVrn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:43 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 7AEF34C816A;
        Fri, 10 Jun 2011 23:47:38 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id D919A180663;
        Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id CBAC655B091; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 07/11] MIPS: BCM63XX: change irq code to prepare for per-cpu peculiarity.
Date:   Fri, 10 Jun 2011 23:47:17 +0200
Message-Id: <1307742441-28284-8-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 30331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9577

No functionnal change is introduced by this patch.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/irq.c                           |   86 ++++++++++++++++++--
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    9 ++
 2 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index cea6021..d002831 100644
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
@@ -228,6 +295,7 @@ void __init arch_init_irq(void)
 {
 	int i;
 
+	bcm63xx_init_irq();
 	mips_cpu_irq_init();
 	for (i = IRQ_INTERNAL_BASE; i < NR_IRQS; ++i)
 		irq_set_chip_and_handler(i, &bcm63xx_internal_irq_chip,
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 3ea2681..4354be1 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -89,9 +89,18 @@
 
 /* Interrupt Mask register */
 #define PERF_IRQMASK_REG		0xc
+#define PERF_IRQSTAT_REG		0x10
+#define PERF_IRQMASK_6338_REG		0xc
+#define PERF_IRQMASK_6345_REG		0xc
+#define PERF_IRQMASK_6348_REG		0xc
+#define PERF_IRQMASK_6358_REG		0xc
 
 /* Interrupt Status register */
 #define PERF_IRQSTAT_REG		0x10
+#define PERF_IRQSTAT_6338_REG		0x10
+#define PERF_IRQSTAT_6345_REG		0x10
+#define PERF_IRQSTAT_6348_REG		0x10
+#define PERF_IRQSTAT_6358_REG		0x10
 
 /* External Interrupt Configuration register */
 #define PERF_EXTIRQ_CFG_REG		0x14
-- 
1.7.1.1
