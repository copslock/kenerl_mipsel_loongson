Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:51:26 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46968 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822968AbaGLKuLVMpjw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:50:11 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id EEDCB280133;
        Sat, 12 Jul 2014 12:48:02 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 3C3E12845A0;
        Sat, 12 Jul 2014 12:47:47 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 04/10] MIPS: BCM63XX: append irq line to irq_{stat,mask}*
Date:   Sat, 12 Jul 2014 12:49:36 +0200
Message-Id: <1405162182-30399-5-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
References: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41164
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

The SMP capable irq controllers have two interrupt output pins which are
controlled through separate registers, so make the variables arrays.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c                           | 51 ++++++++++++-----------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 16 +++----
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index db9f2ef..91d1765 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -19,7 +19,8 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_irq.h>
 
-static u32 irq_stat_addr, irq_mask_addr;
+static u32 irq_stat_addr[2];
+static u32 irq_mask_addr[2];
 static void (*dispatch_internal)(void);
 static int is_ext_irq_cascaded;
 static unsigned int ext_irq_count;
@@ -64,8 +65,8 @@ void __dispatch_internal_##width(void)					\
 	for (src = 0, tgt = (width / 32); src < (width / 32); src++) {	\
 		u32 val;						\
 									\
-		val = bcm_readl(irq_stat_addr + src * sizeof(u32));	\
-		val &= bcm_readl(irq_mask_addr + src * sizeof(u32));	\
+		val = bcm_readl(irq_stat_addr[0] + src * sizeof(u32));	\
+		val &= bcm_readl(irq_mask_addr[0] + src * sizeof(u32));	\
 		pending[--tgt] = val;					\
 									\
 		if (val)						\
@@ -92,9 +93,9 @@ static void __internal_irq_mask_##width(unsigned int irq)		\
 	unsigned reg = (irq / 32) ^ (width/32 - 1);			\
 	unsigned bit = irq & 0x1f;					\
 									\
-	val = bcm_readl(irq_mask_addr + reg * sizeof(u32));		\
+	val = bcm_readl(irq_mask_addr[0] + reg * sizeof(u32));		\
 	val &= ~(1 << bit);						\
-	bcm_writel(val, irq_mask_addr + reg * sizeof(u32));		\
+	bcm_writel(val, irq_mask_addr[0] + reg * sizeof(u32));		\
 }									\
 									\
 static void __internal_irq_unmask_##width(unsigned int irq)		\
@@ -103,9 +104,9 @@ static void __internal_irq_unmask_##width(unsigned int irq)		\
 	unsigned reg = (irq / 32) ^ (width/32 - 1);			\
 	unsigned bit = irq & 0x1f;					\
 									\
-	val = bcm_readl(irq_mask_addr + reg * sizeof(u32));		\
+	val = bcm_readl(irq_mask_addr[0] + reg * sizeof(u32));		\
 	val |= (1 << bit);						\
-	bcm_writel(val, irq_mask_addr + reg * sizeof(u32));		\
+	bcm_writel(val, irq_mask_addr[0] + reg * sizeof(u32));		\
 }
 
 BUILD_IPIC_INTERNAL(32);
@@ -339,20 +340,20 @@ static void bcm63xx_init_irq(void)
 {
 	int irq_bits;
 
-	irq_stat_addr = bcm63xx_regset_address(RSET_PERF);
-	irq_mask_addr = bcm63xx_regset_address(RSET_PERF);
+	irq_stat_addr[0] = bcm63xx_regset_address(RSET_PERF);
+	irq_mask_addr[0] = bcm63xx_regset_address(RSET_PERF);
 
 	switch (bcm63xx_get_cpu_id()) {
 	case BCM3368_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_3368_REG;
-		irq_mask_addr += PERF_IRQMASK_3368_REG;
+		irq_stat_addr[0] += PERF_IRQSTAT_3368_REG;
+		irq_mask_addr[0] += PERF_IRQMASK_3368_REG;
 		irq_bits = 32;
 		ext_irq_count = 4;
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_3368;
 		break;
 	case BCM6328_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6328_REG;
-		irq_mask_addr += PERF_IRQMASK_6328_REG;
+		irq_stat_addr[0] += PERF_IRQSTAT_6328_REG(0);
+		irq_mask_addr[0] += PERF_IRQMASK_6328_REG(0);
 		irq_bits = 64;
 		ext_irq_count = 4;
 		is_ext_irq_cascaded = 1;
@@ -361,29 +362,29 @@ static void bcm63xx_init_irq(void)
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6328;
 		break;
 	case BCM6338_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6338_REG;
-		irq_mask_addr += PERF_IRQMASK_6338_REG;
+		irq_stat_addr[0] += PERF_IRQSTAT_6338_REG;
+		irq_mask_addr[0] += PERF_IRQMASK_6338_REG;
 		irq_bits = 32;
 		ext_irq_count = 4;
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6338;
 		break;
 	case BCM6345_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6345_REG;
-		irq_mask_addr += PERF_IRQMASK_6345_REG;
+		irq_stat_addr[0] += PERF_IRQSTAT_6345_REG;
+		irq_mask_addr[0] += PERF_IRQMASK_6345_REG;
 		irq_bits = 32;
 		ext_irq_count = 4;
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6345;
 		break;
 	case BCM6348_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6348_REG;
-		irq_mask_addr += PERF_IRQMASK_6348_REG;
+		irq_stat_addr[0] += PERF_IRQSTAT_6348_REG;
+		irq_mask_addr[0] += PERF_IRQMASK_6348_REG;
 		irq_bits = 32;
 		ext_irq_count = 4;
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6348;
 		break;
 	case BCM6358_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6358_REG;
-		irq_mask_addr += PERF_IRQMASK_6358_REG;
+		irq_stat_addr[0] += PERF_IRQSTAT_6358_REG(0);
+		irq_mask_addr[0] += PERF_IRQMASK_6358_REG(0);
 		irq_bits = 32;
 		ext_irq_count = 4;
 		is_ext_irq_cascaded = 1;
@@ -392,8 +393,8 @@ static void bcm63xx_init_irq(void)
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6358;
 		break;
 	case BCM6362_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6362_REG;
-		irq_mask_addr += PERF_IRQMASK_6362_REG;
+		irq_stat_addr[0] += PERF_IRQSTAT_6362_REG(0);
+		irq_mask_addr[0] += PERF_IRQMASK_6362_REG(0);
 		irq_bits = 64;
 		ext_irq_count = 4;
 		is_ext_irq_cascaded = 1;
@@ -402,8 +403,8 @@ static void bcm63xx_init_irq(void)
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6362;
 		break;
 	case BCM6368_CPU_ID:
-		irq_stat_addr += PERF_IRQSTAT_6368_REG;
-		irq_mask_addr += PERF_IRQMASK_6368_REG;
+		irq_stat_addr[0] += PERF_IRQSTAT_6368_REG(0);
+		irq_mask_addr[0] += PERF_IRQMASK_6368_REG(0);
 		irq_bits = 64;
 		ext_irq_count = 6;
 		is_ext_irq_cascaded = 1;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index ab427f8..4794067 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -215,23 +215,23 @@
 
 /* Interrupt Mask register */
 #define PERF_IRQMASK_3368_REG		0xc
-#define PERF_IRQMASK_6328_REG		0x20
+#define PERF_IRQMASK_6328_REG(x)	(0x20 + (x) * 0x10)
 #define PERF_IRQMASK_6338_REG		0xc
 #define PERF_IRQMASK_6345_REG		0xc
 #define PERF_IRQMASK_6348_REG		0xc
-#define PERF_IRQMASK_6358_REG		0xc
-#define PERF_IRQMASK_6362_REG		0x20
-#define PERF_IRQMASK_6368_REG		0x20
+#define PERF_IRQMASK_6358_REG(x)	(0xc + (x) * 0x2c)
+#define PERF_IRQMASK_6362_REG(x)	(0x20 + (x) * 0x10)
+#define PERF_IRQMASK_6368_REG(x)	(0x20 + (x) * 0x10)
 
 /* Interrupt Status register */
 #define PERF_IRQSTAT_3368_REG		0x10
-#define PERF_IRQSTAT_6328_REG		0x28
+#define PERF_IRQSTAT_6328_REG(x)	(0x28 + (x) * 0x10)
 #define PERF_IRQSTAT_6338_REG		0x10
 #define PERF_IRQSTAT_6345_REG		0x10
 #define PERF_IRQSTAT_6348_REG		0x10
-#define PERF_IRQSTAT_6358_REG		0x10
-#define PERF_IRQSTAT_6362_REG		0x28
-#define PERF_IRQSTAT_6368_REG		0x28
+#define PERF_IRQSTAT_6358_REG(x)	(0x10 + (x) * 0x2c)
+#define PERF_IRQSTAT_6362_REG(x)	(0x28 + (x) * 0x10)
+#define PERF_IRQSTAT_6368_REG(x)	(0x28 + (x) * 0x10)
 
 /* External Interrupt Configuration register */
 #define PERF_EXTIRQ_CFG_REG_3368	0x14
-- 
2.0.0
