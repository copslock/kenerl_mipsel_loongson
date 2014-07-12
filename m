Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:52:20 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46981 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860090AbaGLKuTdibIW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:50:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 6C7732845A0;
        Sat, 12 Jul 2014 12:48:11 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 288F228463D;
        Sat, 12 Jul 2014 12:47:49 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 07/10] MIPS: BCM63XX: protect irq register accesses
Date:   Sat, 12 Jul 2014 12:49:39 +0200
Message-Id: <1405162182-30399-8-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
References: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41167
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

Since we will have the chance of accessing the registers concurrently,
protect any accesses through a spinlock.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 53be291..2f19391 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/spinlock.h>
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
 #include <bcm63xx_cpu.h>
@@ -20,6 +21,9 @@
 #include <bcm63xx_irq.h>
 
 
+static DEFINE_SPINLOCK(ipic_lock);
+static DEFINE_SPINLOCK(epic_lock);
+
 static u32 irq_stat_addr[2];
 static u32 irq_mask_addr[2];
 static void (*dispatch_internal)(int cpu);
@@ -62,8 +66,10 @@ void __dispatch_internal_##width(int cpu)				\
 	bool irqs_pending = false;					\
 	static unsigned int i[2];					\
 	unsigned int *next = &i[cpu];					\
+	unsigned long flags;						\
 									\
 	/* read registers in reverse order */				\
+	spin_lock_irqsave(&ipic_lock, flags);				\
 	for (src = 0, tgt = (width / 32); src < (width / 32); src++) {	\
 		u32 val;						\
 									\
@@ -74,6 +80,7 @@ void __dispatch_internal_##width(int cpu)				\
 		if (val)						\
 			irqs_pending = true;				\
 	}								\
+	spin_unlock_irqrestore(&ipic_lock, flags);			\
 									\
 	if (!irqs_pending)						\
 		return;							\
@@ -94,10 +101,13 @@ static void __internal_irq_mask_##width(unsigned int irq)		\
 	u32 val;							\
 	unsigned reg = (irq / 32) ^ (width/32 - 1);			\
 	unsigned bit = irq & 0x1f;					\
+	unsigned long flags;						\
 									\
+	spin_lock_irqsave(&ipic_lock, flags);				\
 	val = bcm_readl(irq_mask_addr[0] + reg * sizeof(u32));		\
 	val &= ~(1 << bit);						\
 	bcm_writel(val, irq_mask_addr[0] + reg * sizeof(u32));		\
+	spin_unlock_irqrestore(&ipic_lock, flags);			\
 }									\
 									\
 static void __internal_irq_unmask_##width(unsigned int irq)		\
@@ -105,10 +115,13 @@ static void __internal_irq_unmask_##width(unsigned int irq)		\
 	u32 val;							\
 	unsigned reg = (irq / 32) ^ (width/32 - 1);			\
 	unsigned bit = irq & 0x1f;					\
+	unsigned long flags;						\
 									\
+	spin_lock_irqsave(&ipic_lock, flags);				\
 	val = bcm_readl(irq_mask_addr[0] + reg * sizeof(u32));		\
 	val |= (1 << bit);						\
 	bcm_writel(val, irq_mask_addr[0] + reg * sizeof(u32));		\
+	spin_unlock_irqrestore(&ipic_lock, flags);			\
 }
 
 BUILD_IPIC_INTERNAL(32);
@@ -167,8 +180,10 @@ static void bcm63xx_external_irq_mask(struct irq_data *d)
 {
 	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
 	u32 reg, regaddr;
+	unsigned long flags;
 
 	regaddr = get_ext_irq_perf_reg(irq);
+	spin_lock_irqsave(&epic_lock, flags);
 	reg = bcm_perf_readl(regaddr);
 
 	if (BCMCPU_IS_6348())
@@ -177,6 +192,8 @@ static void bcm63xx_external_irq_mask(struct irq_data *d)
 		reg &= ~EXTIRQ_CFG_MASK(irq % 4);
 
 	bcm_perf_writel(reg, regaddr);
+	spin_unlock_irqrestore(&epic_lock, flags);
+
 	if (is_ext_irq_cascaded)
 		internal_irq_mask(irq + ext_irq_start);
 }
@@ -185,8 +202,10 @@ static void bcm63xx_external_irq_unmask(struct irq_data *d)
 {
 	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
 	u32 reg, regaddr;
+	unsigned long flags;
 
 	regaddr = get_ext_irq_perf_reg(irq);
+	spin_lock_irqsave(&epic_lock, flags);
 	reg = bcm_perf_readl(regaddr);
 
 	if (BCMCPU_IS_6348())
@@ -195,6 +214,7 @@ static void bcm63xx_external_irq_unmask(struct irq_data *d)
 		reg |= EXTIRQ_CFG_MASK(irq % 4);
 
 	bcm_perf_writel(reg, regaddr);
+	spin_unlock_irqrestore(&epic_lock, flags);
 
 	if (is_ext_irq_cascaded)
 		internal_irq_unmask(irq + ext_irq_start);
@@ -204,8 +224,10 @@ static void bcm63xx_external_irq_clear(struct irq_data *d)
 {
 	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
 	u32 reg, regaddr;
+	unsigned long flags;
 
 	regaddr = get_ext_irq_perf_reg(irq);
+	spin_lock_irqsave(&epic_lock, flags);
 	reg = bcm_perf_readl(regaddr);
 
 	if (BCMCPU_IS_6348())
@@ -214,6 +236,7 @@ static void bcm63xx_external_irq_clear(struct irq_data *d)
 		reg |= EXTIRQ_CFG_CLEAR(irq % 4);
 
 	bcm_perf_writel(reg, regaddr);
+	spin_unlock_irqrestore(&epic_lock, flags);
 }
 
 static int bcm63xx_external_irq_set_type(struct irq_data *d,
@@ -222,6 +245,7 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 	unsigned int irq = d->irq - IRQ_EXTERNAL_BASE;
 	u32 reg, regaddr;
 	int levelsense, sense, bothedge;
+	unsigned long flags;
 
 	flow_type &= IRQ_TYPE_SENSE_MASK;
 
@@ -256,6 +280,7 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 	}
 
 	regaddr = get_ext_irq_perf_reg(irq);
+	spin_lock_irqsave(&epic_lock, flags);
 	reg = bcm_perf_readl(regaddr);
 	irq %= 4;
 
@@ -300,6 +325,7 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 	}
 
 	bcm_perf_writel(reg, regaddr);
+	spin_unlock_irqrestore(&epic_lock, flags);
 
 	irqd_set_trigger_type(d, flow_type);
 	if (flow_type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
-- 
2.0.0
