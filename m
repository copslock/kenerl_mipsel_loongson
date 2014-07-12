Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:50:32 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46951 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860083AbaGLKt7VXo1w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:49:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 2EB7928B51A;
        Sat, 12 Jul 2014 12:47:51 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A80DE280133;
        Sat, 12 Jul 2014 12:47:45 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 02/10] MIPS: BCM63XX: move bcm63xx_init_irq down
Date:   Sat, 12 Jul 2014 12:49:34 +0200
Message-Id: <1405162182-30399-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
References: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Allows up to drop the prototypes from the top.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c | 190 +++++++++++++++++++++++-------------------------
 1 file changed, 92 insertions(+), 98 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index a9fb564..f6c933a 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -19,13 +19,6 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_irq.h>
 
-static void __dispatch_internal_32(void) __maybe_unused;
-static void __dispatch_internal_64(void) __maybe_unused;
-static void __internal_irq_mask_32(unsigned int irq) __maybe_unused;
-static void __internal_irq_mask_64(unsigned int irq) __maybe_unused;
-static void __internal_irq_unmask_32(unsigned int irq) __maybe_unused;
-static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
-
 static u32 irq_stat_addr, irq_mask_addr;
 static void (*dispatch_internal)(void);
 static int is_ext_irq_cascaded;
@@ -35,97 +28,6 @@ static unsigned int ext_irq_cfg_reg1, ext_irq_cfg_reg2;
 static void (*internal_irq_mask)(unsigned int irq);
 static void (*internal_irq_unmask)(unsigned int irq);
 
-static void bcm63xx_init_irq(void)
-{
-	int irq_bits;
-
-	irq_stat_addr = bcm63xx_regset_address(RSET_PERF);
-	irq_mask_addr = bcm63xx_regset_address(RSET_PERF);
-
-	switch (bcm63xx_get_cpu_id()) {
-	case BCM3368_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_3368_REG;
-		irq_mask_addr += PERF_IRQMASK_3368_REG;
-		irq_bits = 32;
-		ext_irq_count = 4;
-		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_3368;
-		break;
-	case BCM6328_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6328_REG;
-		irq_mask_addr += PERF_IRQMASK_6328_REG;
-		irq_bits = 64;
-		ext_irq_count = 4;
-		is_ext_irq_cascaded = 1;
-		ext_irq_start = BCM_6328_EXT_IRQ0 - IRQ_INTERNAL_BASE;
-		ext_irq_end = BCM_6328_EXT_IRQ3 - IRQ_INTERNAL_BASE;
-		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6328;
-		break;
-	case BCM6338_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6338_REG;
-		irq_mask_addr += PERF_IRQMASK_6338_REG;
-		irq_bits = 32;
-		ext_irq_count = 4;
-		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6338;
-		break;
-	case BCM6345_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6345_REG;
-		irq_mask_addr += PERF_IRQMASK_6345_REG;
-		irq_bits = 32;
-		ext_irq_count = 4;
-		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6345;
-		break;
-	case BCM6348_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6348_REG;
-		irq_mask_addr += PERF_IRQMASK_6348_REG;
-		irq_bits = 32;
-		ext_irq_count = 4;
-		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6348;
-		break;
-	case BCM6358_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6358_REG;
-		irq_mask_addr += PERF_IRQMASK_6358_REG;
-		irq_bits = 32;
-		ext_irq_count = 4;
-		is_ext_irq_cascaded = 1;
-		ext_irq_start = BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE;
-		ext_irq_end = BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE;
-		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6358;
-		break;
-	case BCM6362_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6362_REG;
-		irq_mask_addr += PERF_IRQMASK_6362_REG;
-		irq_bits = 64;
-		ext_irq_count = 4;
-		is_ext_irq_cascaded = 1;
-		ext_irq_start = BCM_6362_EXT_IRQ0 - IRQ_INTERNAL_BASE;
-		ext_irq_end = BCM_6362_EXT_IRQ3 - IRQ_INTERNAL_BASE;
-		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6362;
-		break;
-	case BCM6368_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6368_REG;
-		irq_mask_addr += PERF_IRQMASK_6368_REG;
-		irq_bits = 64;
-		ext_irq_count = 6;
-		is_ext_irq_cascaded = 1;
-		ext_irq_start = BCM_6368_EXT_IRQ0 - IRQ_INTERNAL_BASE;
-		ext_irq_end = BCM_6368_EXT_IRQ5 - IRQ_INTERNAL_BASE;
-		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6368;
-		ext_irq_cfg_reg2 = PERF_EXTIRQ_CFG_REG2_6368;
-		break;
-	default:
-		BUG();
-	}
-
-	if (irq_bits == 32) {
-		dispatch_internal = __dispatch_internal_32;
-		internal_irq_mask = __internal_irq_mask_32;
-		internal_irq_unmask = __internal_irq_unmask_32;
-	} else {
-		dispatch_internal = __dispatch_internal_64;
-		internal_irq_mask = __internal_irq_mask_64;
-		internal_irq_unmask = __internal_irq_unmask_64;
-	}
-}
 
 static inline u32 get_ext_irq_perf_reg(int irq)
 {
@@ -451,6 +353,98 @@ static struct irqaction cpu_ext_cascade_action = {
 	.flags		= IRQF_NO_THREAD,
 };
 
+static void bcm63xx_init_irq(void)
+{
+	int irq_bits;
+
+	irq_stat_addr = bcm63xx_regset_address(RSET_PERF);
+	irq_mask_addr = bcm63xx_regset_address(RSET_PERF);
+
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM3368_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_3368_REG;
+		irq_mask_addr += PERF_IRQMASK_3368_REG;
+		irq_bits = 32;
+		ext_irq_count = 4;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_3368;
+		break;
+	case BCM6328_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6328_REG;
+		irq_mask_addr += PERF_IRQMASK_6328_REG;
+		irq_bits = 64;
+		ext_irq_count = 4;
+		is_ext_irq_cascaded = 1;
+		ext_irq_start = BCM_6328_EXT_IRQ0 - IRQ_INTERNAL_BASE;
+		ext_irq_end = BCM_6328_EXT_IRQ3 - IRQ_INTERNAL_BASE;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6328;
+		break;
+	case BCM6338_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6338_REG;
+		irq_mask_addr += PERF_IRQMASK_6338_REG;
+		irq_bits = 32;
+		ext_irq_count = 4;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6338;
+		break;
+	case BCM6345_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6345_REG;
+		irq_mask_addr += PERF_IRQMASK_6345_REG;
+		irq_bits = 32;
+		ext_irq_count = 4;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6345;
+		break;
+	case BCM6348_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6348_REG;
+		irq_mask_addr += PERF_IRQMASK_6348_REG;
+		irq_bits = 32;
+		ext_irq_count = 4;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6348;
+		break;
+	case BCM6358_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6358_REG;
+		irq_mask_addr += PERF_IRQMASK_6358_REG;
+		irq_bits = 32;
+		ext_irq_count = 4;
+		is_ext_irq_cascaded = 1;
+		ext_irq_start = BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE;
+		ext_irq_end = BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6358;
+		break;
+	case BCM6362_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6362_REG;
+		irq_mask_addr += PERF_IRQMASK_6362_REG;
+		irq_bits = 64;
+		ext_irq_count = 4;
+		is_ext_irq_cascaded = 1;
+		ext_irq_start = BCM_6362_EXT_IRQ0 - IRQ_INTERNAL_BASE;
+		ext_irq_end = BCM_6362_EXT_IRQ3 - IRQ_INTERNAL_BASE;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6362;
+		break;
+	case BCM6368_CPU_ID:
+		irq_stat_addr += PERF_IRQSTAT_6368_REG;
+		irq_mask_addr += PERF_IRQMASK_6368_REG;
+		irq_bits = 64;
+		ext_irq_count = 6;
+		is_ext_irq_cascaded = 1;
+		ext_irq_start = BCM_6368_EXT_IRQ0 - IRQ_INTERNAL_BASE;
+		ext_irq_end = BCM_6368_EXT_IRQ5 - IRQ_INTERNAL_BASE;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6368;
+		ext_irq_cfg_reg2 = PERF_EXTIRQ_CFG_REG2_6368;
+		break;
+	default:
+		BUG();
+	}
+
+	if (irq_bits == 32) {
+		dispatch_internal = __dispatch_internal_32;
+		internal_irq_mask = __internal_irq_mask_32;
+		internal_irq_unmask = __internal_irq_unmask_32;
+	} else {
+		dispatch_internal = __dispatch_internal_64;
+		internal_irq_mask = __internal_irq_mask_64;
+		internal_irq_unmask = __internal_irq_unmask_64;
+	}
+}
+
 void __init arch_init_irq(void)
 {
 	int i;
-- 
2.0.0
