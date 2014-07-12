Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:52:57 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46989 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860092AbaGLKu1BD8rw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:50:27 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id E62972845A0;
        Sat, 12 Jul 2014 12:48:18 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id F21A3280164;
        Sat, 12 Jul 2014 12:47:50 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 10/10] MIPS: BCM63XX: allow setting affinity for IPIC
Date:   Sat, 12 Jul 2014 12:49:42 +0200
Message-Id: <1405162182-30399-11-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
References: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41169
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

Wire up the set_affinity call for the internal PIC if booting on
a cpu supporting it.
Affinity is kept to boot cpu as default.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index a53305f..37eb2d1 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -32,7 +32,7 @@ static unsigned int ext_irq_count;
 static unsigned int ext_irq_start, ext_irq_end;
 static unsigned int ext_irq_cfg_reg1, ext_irq_cfg_reg2;
 static void (*internal_irq_mask)(struct irq_data *d);
-static void (*internal_irq_unmask)(struct irq_data *d);
+static void (*internal_irq_unmask)(struct irq_data *d, const struct cpumask *m);
 
 
 static inline u32 get_ext_irq_perf_reg(int irq)
@@ -51,6 +51,20 @@ static inline void handle_internal(int intbit)
 		do_IRQ(intbit + IRQ_INTERNAL_BASE);
 }
 
+static inline int enable_irq_for_cpu(int cpu, struct irq_data *d,
+				     const struct cpumask *m)
+{
+	bool enable = cpu_online(cpu);
+
+#ifdef CONFIG_SMP
+	if (m)
+		enable &= cpu_isset(cpu, *m);
+	else if (irqd_affinity_was_set(d))
+		enable &= cpu_isset(cpu, *d->affinity);
+#endif
+	return enable;
+}
+
 /*
  * dispatch internal devices IRQ (uart, enet, watchdog, ...). do not
  * prioritize any interrupt relatively to another. the static counter
@@ -117,7 +131,8 @@ static void __internal_irq_mask_##width(struct irq_data *d)		\
 	spin_unlock_irqrestore(&ipic_lock, flags);			\
 }									\
 									\
-static void __internal_irq_unmask_##width(struct irq_data *d)		\
+static void __internal_irq_unmask_##width(struct irq_data *d,		\
+					  const struct cpumask *m)	\
 {									\
 	u32 val;							\
 	unsigned irq = d->irq - IRQ_INTERNAL_BASE;			\
@@ -132,7 +147,7 @@ static void __internal_irq_unmask_##width(struct irq_data *d)		\
 			break;						\
 									\
 		val = bcm_readl(irq_mask_addr[cpu] + reg * sizeof(u32));\
-		if (cpu_online(cpu))					\
+		if (enable_irq_for_cpu(cpu, d, m))			\
 			val |= (1 << bit);				\
 		else							\
 			val &= ~(1 << bit);				\
@@ -189,7 +204,7 @@ static void bcm63xx_internal_irq_mask(struct irq_data *d)
 
 static void bcm63xx_internal_irq_unmask(struct irq_data *d)
 {
-	internal_irq_unmask(d);
+	internal_irq_unmask(d, NULL);
 }
 
 /*
@@ -237,7 +252,8 @@ static void bcm63xx_external_irq_unmask(struct irq_data *d)
 	spin_unlock_irqrestore(&epic_lock, flags);
 
 	if (is_ext_irq_cascaded)
-		internal_irq_unmask(irq_get_irq_data(irq + ext_irq_start));
+		internal_irq_unmask(irq_get_irq_data(irq + ext_irq_start),
+				    NULL);
 }
 
 static void bcm63xx_external_irq_clear(struct irq_data *d)
@@ -356,6 +372,18 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 	return IRQ_SET_MASK_OK_NOCOPY;
 }
 
+#ifdef CONFIG_SMP
+static int bcm63xx_internal_set_affinity(struct irq_data *data,
+					 const struct cpumask *dest,
+					 bool force)
+{
+	if (!irqd_irq_disabled(data))
+		internal_irq_unmask(data, dest);
+
+	return 0;
+}
+#endif
+
 static struct irq_chip bcm63xx_internal_irq_chip = {
 	.name		= "bcm63xx_ipic",
 	.irq_mask	= bcm63xx_internal_irq_mask,
@@ -523,7 +551,13 @@ void __init arch_init_irq(void)
 
 	setup_irq(MIPS_CPU_IRQ_BASE + 2, &cpu_ip2_cascade_action);
 #ifdef CONFIG_SMP
-	if (is_ext_irq_cascaded)
+	if (is_ext_irq_cascaded) {
 		setup_irq(MIPS_CPU_IRQ_BASE + 3, &cpu_ip3_cascade_action);
+		bcm63xx_internal_irq_chip.irq_set_affinity =
+			bcm63xx_internal_set_affinity;
+
+		cpumask_clear(irq_default_affinity);
+		cpumask_set_cpu(smp_processor_id(), irq_default_affinity);
+	}
 #endif
 }
-- 
2.0.0
