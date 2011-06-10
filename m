Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:50:26 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52687 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491143Ab1FJVrn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:43 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 9D55D4C816E;
        Fri, 10 Jun 2011 23:47:38 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id E76F8180665;
        Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id D7A7655B08D; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 09/11] MIPS: BCM63XX: handle 64 bits irq stat register in irq code.
Date:   Fri, 10 Jun 2011 23:47:19 +0200
Message-Id: <1307742441-28284-10-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 30332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9578

bcm6368 has larger irq registers, prepare for this.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/irq.c |   82 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 2e4f317..07909a9 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -20,11 +20,17 @@
 #include <bcm63xx_irq.h>
 
 static void __dispatch_internal(void) __maybe_unused;
+static void __dispatch_internal_64(void) __maybe_unused;
+static void __internal_irq_mask_32(unsigned int irq) __maybe_unused;
+static void __internal_irq_mask_64(unsigned int irq) __maybe_unused;
+static void __internal_irq_unmask_32(unsigned int irq) __maybe_unused;
+static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 
 #ifndef BCMCPU_RUNTIME_DETECT
 #ifdef CONFIG_BCM63XX_CPU_6338
 #define irq_stat_reg		PERF_IRQSTAT_6338_REG
 #define irq_mask_reg		PERF_IRQMASK_6338_REG
+#define irq_bits		32
 #define is_ext_irq_cascaded	0
 #define ext_irq_start		0
 #define ext_irq_end		0
@@ -32,6 +38,7 @@ static void __dispatch_internal(void) __maybe_unused;
 #ifdef CONFIG_BCM63XX_CPU_6345
 #define irq_stat_reg		PERF_IRQSTAT_6345_REG
 #define irq_mask_reg		PERF_IRQMASK_6345_REG
+#define irq_bits		32
 #define is_ext_irq_cascaded	0
 #define ext_irq_start		0
 #define ext_irq_end		0
@@ -39,7 +46,7 @@ static void __dispatch_internal(void) __maybe_unused;
 #ifdef CONFIG_BCM63XX_CPU_6348
 #define irq_stat_reg		PERF_IRQSTAT_6348_REG
 #define irq_mask_reg		PERF_IRQMASK_6348_REG
-#define dispatch_internal	__dispatch_internal
+#define irq_bits		32
 #define is_ext_irq_cascaded	0
 #define ext_irq_start		0
 #define ext_irq_end		0
@@ -47,13 +54,21 @@ static void __dispatch_internal(void) __maybe_unused;
 #ifdef CONFIG_BCM63XX_CPU_6358
 #define irq_stat_reg		PERF_IRQSTAT_6358_REG
 #define irq_mask_reg		PERF_IRQMASK_6358_REG
-#define dispatch_internal	__dispatch_internal
+#define irq_bits		32
 #define is_ext_irq_cascaded	1
 #define ext_irq_start		(BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE)
 #define ext_irq_end		(BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE)
 #endif
 
-#define dispatch_internal	__dispatch_internal
+#if irq_bits == 32
+#define dispatch_internal			__dispatch_internal
+#define internal_irq_mask			__internal_irq_mask_32
+#define internal_irq_unmask			__internal_irq_unmask_32
+#else
+#define dispatch_internal			__dispatch_internal_64
+#define internal_irq_mask			__internal_irq_mask_64
+#define internal_irq_unmask			__internal_irq_unmask_64
+#endif
 
 #define irq_stat_addr	(bcm63xx_regset_address(RSET_PERF) + irq_stat_reg)
 #define irq_mask_addr	(bcm63xx_regset_address(RSET_PERF) + irq_mask_reg)
@@ -67,9 +82,13 @@ static u32 irq_stat_addr, irq_mask_addr;
 static void (*dispatch_internal)(void);
 static int is_ext_irq_cascaded;
 static unsigned int ext_irq_start, ext_irq_end;
+static void (*internal_irq_mask)(unsigned int irq);
+static void (*internal_irq_unmask)(unsigned int irq);
 
 static void bcm63xx_init_irq(void)
 {
+	int irq_bits;
+
 	irq_stat_addr = bcm63xx_regset_address(RSET_PERF);
 	irq_mask_addr = bcm63xx_regset_address(RSET_PERF);
 
@@ -77,18 +96,22 @@ static void bcm63xx_init_irq(void)
 	case BCM6338_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6338_REG;
 		irq_mask_addr += PERF_IRQMASK_6338_REG;
+		irq_bits = 32;
 		break;
 	case BCM6345_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6345_REG;
 		irq_mask_addr += PERF_IRQMASK_6345_REG;
+		irq_bits = 32;
 		break;
 	case BCM6348_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6348_REG;
 		irq_mask_addr += PERF_IRQMASK_6348_REG;
+		irq_bits = 32;
 		break;
 	case BCM6358_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6358_REG;
 		irq_mask_addr += PERF_IRQMASK_6358_REG;
+		irq_bits = 32;
 		is_ext_irq_cascaded = 1;
 		ext_irq_start = BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE;
 		ext_irq_end = BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE;
@@ -97,7 +120,15 @@ static void bcm63xx_init_irq(void)
 		BUG();
 	}
 
-	dispatch_internal = __dispatch_internal;
+	if (irq_bits == 32) {
+		dispatch_internal = __dispatch_internal;
+		internal_irq_mask = __internal_irq_mask_32;
+		internal_irq_unmask = __internal_irq_unmask_32;
+	} else {
+		dispatch_internal = __dispatch_internal_64;
+		internal_irq_mask = __internal_irq_mask_64;
+		internal_irq_unmask = __internal_irq_unmask_64;
+	}
 }
 #endif /* ! BCMCPU_RUNTIME_DETECT */
 
@@ -137,6 +168,27 @@ static void __dispatch_internal(void)
 	}
 }
 
+static void __dispatch_internal_64(void)
+{
+	u64 pending;
+	static int i;
+
+	pending = bcm_readll(irq_stat_addr) & bcm_readll(irq_mask_addr);
+
+	if (!pending)
+		return ;
+
+	while (1) {
+		int to_call = i;
+
+		i = (i + 1) & 0x3f;
+		if (pending & (1ull << to_call)) {
+			handle_internal(to_call);
+			break;
+		}
+	}
+}
+
 asmlinkage void plat_irq_dispatch(void)
 {
 	u32 cause;
@@ -168,7 +220,7 @@ asmlinkage void plat_irq_dispatch(void)
  * internal IRQs operations: only mask/unmask on PERF irq mask
  * register.
  */
-static void internal_irq_mask(unsigned int irq)
+static void __internal_irq_mask_32(unsigned int irq)
 {
 	u32 mask;
 
@@ -177,7 +229,16 @@ static void internal_irq_mask(unsigned int irq)
 	bcm_writel(mask, irq_mask_addr);
 }
 
-static void internal_irq_unmask(unsigned int irq)
+static void __internal_irq_mask_64(unsigned int irq)
+{
+	u64 mask;
+
+	mask = bcm_readll(irq_mask_addr);
+	mask &= ~(1ull << irq);
+	bcm_writell(mask, irq_mask_addr);
+}
+
+static void __internal_irq_unmask_32(unsigned int irq)
 {
 	u32 mask;
 
@@ -186,6 +247,15 @@ static void internal_irq_unmask(unsigned int irq)
 	bcm_writel(mask, irq_mask_addr);
 }
 
+static void __internal_irq_unmask_64(unsigned int irq)
+{
+	u64 mask;
+
+	mask = bcm_readll(irq_mask_addr);
+	mask |= (1ull << irq);
+	bcm_writell(mask, irq_mask_addr);
+}
+
 static void bcm63xx_internal_irq_mask(struct irq_data *d)
 {
 	internal_irq_mask(d->irq - IRQ_INTERNAL_BASE);
-- 
1.7.1.1
