Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:52:38 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46985 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860091AbaGLKuZutXJf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:50:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id C5B5A280133;
        Sat, 12 Jul 2014 12:48:17 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id C0F2728470D;
        Sat, 12 Jul 2014 12:47:49 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 08/10] MIPS: BCM63XX: wire up the second cpu's irq line
Date:   Sat, 12 Jul 2014 12:49:40 +0200
Message-Id: <1405162182-30399-9-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
References: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41168
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

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 2f19391..615b25b 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -102,11 +102,17 @@ static void __internal_irq_mask_##width(unsigned int irq)		\
 	unsigned reg = (irq / 32) ^ (width/32 - 1);			\
 	unsigned bit = irq & 0x1f;					\
 	unsigned long flags;						\
+	int cpu;							\
 									\
 	spin_lock_irqsave(&ipic_lock, flags);				\
-	val = bcm_readl(irq_mask_addr[0] + reg * sizeof(u32));		\
-	val &= ~(1 << bit);						\
-	bcm_writel(val, irq_mask_addr[0] + reg * sizeof(u32));		\
+	for_each_present_cpu(cpu) {					\
+		if (!irq_mask_addr[cpu])				\
+			break;						\
+									\
+		val = bcm_readl(irq_mask_addr[cpu] + reg * sizeof(u32));\
+		val &= ~(1 << bit);					\
+		bcm_writel(val, irq_mask_addr[cpu] + reg * sizeof(u32));\
+	}								\
 	spin_unlock_irqrestore(&ipic_lock, flags);			\
 }									\
 									\
@@ -116,11 +122,20 @@ static void __internal_irq_unmask_##width(unsigned int irq)		\
 	unsigned reg = (irq / 32) ^ (width/32 - 1);			\
 	unsigned bit = irq & 0x1f;					\
 	unsigned long flags;						\
+	int cpu;							\
 									\
 	spin_lock_irqsave(&ipic_lock, flags);				\
-	val = bcm_readl(irq_mask_addr[0] + reg * sizeof(u32));		\
-	val |= (1 << bit);						\
-	bcm_writel(val, irq_mask_addr[0] + reg * sizeof(u32));		\
+	for_each_present_cpu(cpu) {					\
+		if (!irq_mask_addr[cpu])				\
+			break;						\
+									\
+		val = bcm_readl(irq_mask_addr[cpu] + reg * sizeof(u32));\
+		if (cpu_online(cpu))					\
+			val |= (1 << bit);				\
+		else							\
+			val &= ~(1 << bit);				\
+		bcm_writel(val, irq_mask_addr[cpu] + reg * sizeof(u32));\
+	}								\
 	spin_unlock_irqrestore(&ipic_lock, flags);			\
 }
 
@@ -145,7 +160,10 @@ asmlinkage void plat_irq_dispatch(void)
 			do_IRQ(1);
 		if (cause & CAUSEF_IP2)
 			dispatch_internal(0);
-		if (!is_ext_irq_cascaded) {
+		if (is_ext_irq_cascaded) {
+			if (cause & CAUSEF_IP3)
+				dispatch_internal(1);
+		} else {
 			if (cause & CAUSEF_IP3)
 				do_IRQ(IRQ_EXT_0);
 			if (cause & CAUSEF_IP4)
@@ -358,6 +376,14 @@ static struct irqaction cpu_ip2_cascade_action = {
 	.flags		= IRQF_NO_THREAD,
 };
 
+#ifdef CONFIG_SMP
+static struct irqaction cpu_ip3_cascade_action = {
+	.handler	= no_action,
+	.name		= "cascade_ip3",
+	.flags		= IRQF_NO_THREAD,
+};
+#endif
+
 static struct irqaction cpu_ext_cascade_action = {
 	.handler	= no_action,
 	.name		= "cascade_extirq",
@@ -494,4 +520,8 @@ void __init arch_init_irq(void)
 	}
 
 	setup_irq(MIPS_CPU_IRQ_BASE + 2, &cpu_ip2_cascade_action);
+#ifdef CONFIG_SMP
+	if (is_ext_irq_cascaded)
+		setup_irq(MIPS_CPU_IRQ_BASE + 3, &cpu_ip3_cascade_action);
+#endif
 }
-- 
2.0.0
