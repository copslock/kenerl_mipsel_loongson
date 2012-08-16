Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 11:11:14 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50534 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903480Ab2HPJKk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 11:10:40 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/4] MIPS: lantiq: timer irq can be different to 7
Date:   Thu, 16 Aug 2012 11:09:20 +0200
Message-Id: <1345108162-1080-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1345108162-1080-1-git-send-email-blogic@openwrt.org>
References: <1345108162-1080-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The SVIP SoC has its timer IRQ on a different IRQ than 7. Fix up the irq
code to be able to handle this.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/irq.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index a2699a70..0cec43d 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -84,6 +84,7 @@ static unsigned short ltq_eiu_irq[MAX_EIU] = {
 static int exin_avail;
 static void __iomem *ltq_icu_membase[MAX_IM];
 static void __iomem *ltq_eiu_membase;
+static struct irq_domain *ltq_domain;
 
 void ltq_disable_irq(struct irq_data *d)
 {
@@ -219,10 +220,14 @@ DEFINE_HWx_IRQDISPATCH(2)
 DEFINE_HWx_IRQDISPATCH(3)
 DEFINE_HWx_IRQDISPATCH(4)
 
+#if MIPS_CPU_TIMER_IRQ == 7
 static void ltq_hw5_irqdispatch(void)
 {
 	do_IRQ(MIPS_CPU_TIMER_IRQ);
 }
+#else
+DEFINE_HWx_IRQDISPATCH(5)
+#endif
 
 #ifdef CONFIG_MIPS_MT_SMP
 void __init arch_init_ipiirq(int irq, struct irqaction *action)
@@ -270,7 +275,7 @@ asmlinkage void plat_irq_dispatch(void)
 	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
 	unsigned int i;
 
-	if (pending & CAUSEF_IP7) {
+	if ((MIPS_CPU_TIMER_IRQ == 7) && (pending & CAUSEF_IP7)) {
 		do_IRQ(MIPS_CPU_TIMER_IRQ);
 		goto out;
 	} else {
@@ -376,7 +381,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 		set_vi_handler(7, ltq_hw5_irqdispatch);
 	}
 
-	irq_domain_add_linear(node,
+	ltq_domain = irq_domain_add_linear(node,
 		(MAX_IM * INT_NUM_IM_OFFSET) + MIPS_CPU_IRQ_CASCADE,
 		&irq_domain_ops, 0);
 
@@ -401,12 +406,20 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 
 	/* tell oprofile which irq to use */
 	cp0_perfcount_irq = LTQ_PERF_IRQ;
+
+	/*
+	 * if the timer irq is not one of the mips irqs we need to
+	 * create a mapping
+	 */
+	if (MIPS_CPU_TIMER_IRQ != 7)
+		irq_create_mapping(ltq_domain, MIPS_CPU_TIMER_IRQ);
+
 	return 0;
 }
 
 unsigned int __cpuinit get_c0_compare_int(void)
 {
-	return CP0_LEGACY_COMPARE_IRQ;
+	return MIPS_CPU_TIMER_IRQ;
 }
 
 static struct of_device_id __initdata of_irq_ids[] = {
-- 
1.7.9.1
