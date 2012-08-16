Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 14:41:21 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:43859 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903504Ab2HPMlN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 14:41:13 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 1/4] MIPS: lantiq: split up IRQ IM ranges
Date:   Thu, 16 Aug 2012 14:39:57 +0200
Message-Id: <1345120797-13542-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1345120797-13542-1-git-send-email-blogic@openwrt.org>
References: <1345120797-13542-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34206
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

Up to now all our SoCs had the 5 IM ranges in a consecutive order. To accomodate
the SVIP we need to support IM ranges that are scattered inside the register range.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
Changes in V2
* fixes a typo in the commit description

 .../include/asm/mach-lantiq/falcon/falcon_irq.h    |    2 +
 .../mips/include/asm/mach-lantiq/xway/lantiq_irq.h |    2 +
 arch/mips/lantiq/irq.c                             |   60 ++++++++++---------
 3 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h b/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
index 318f982..c6b63a4 100644
--- a/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
+++ b/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
@@ -20,4 +20,6 @@
 
 #define MIPS_CPU_TIMER_IRQ			7
 
+#define MAX_IM			5
+
 #endif /* _FALCON_IRQ__ */
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
index aa0b3b8..5eadfe5 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
@@ -21,4 +21,6 @@
 
 #define MIPS_CPU_TIMER_IRQ	7
 
+#define MAX_IM			5
+
 #endif
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 57c1a4e..a2699a70 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -55,8 +55,8 @@
  */
 #define LTQ_ICU_EBU_IRQ		22
 
-#define ltq_icu_w32(x, y)	ltq_w32((x), ltq_icu_membase + (y))
-#define ltq_icu_r32(x)		ltq_r32(ltq_icu_membase + (x))
+#define ltq_icu_w32(m, x, y)	ltq_w32((x), ltq_icu_membase[m] + (y))
+#define ltq_icu_r32(m, x)	ltq_r32(ltq_icu_membase[m] + (x))
 
 #define ltq_eiu_w32(x, y)	ltq_w32((x), ltq_eiu_membase + (y))
 #define ltq_eiu_r32(x)		ltq_r32(ltq_eiu_membase + (x))
@@ -82,17 +82,17 @@ static unsigned short ltq_eiu_irq[MAX_EIU] = {
 };
 
 static int exin_avail;
-static void __iomem *ltq_icu_membase;
+static void __iomem *ltq_icu_membase[MAX_IM];
 static void __iomem *ltq_eiu_membase;
 
 void ltq_disable_irq(struct irq_data *d)
 {
 	u32 ier = LTQ_ICU_IM0_IER;
 	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
+	int im = offset / INT_NUM_IM_OFFSET;
 
-	ier += LTQ_ICU_OFFSET * (offset / INT_NUM_IM_OFFSET);
 	offset %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(ltq_icu_r32(ier) & ~BIT(offset), ier);
+	ltq_icu_w32(im, ltq_icu_r32(im, ier) & ~BIT(offset), ier);
 }
 
 void ltq_mask_and_ack_irq(struct irq_data *d)
@@ -100,32 +100,31 @@ void ltq_mask_and_ack_irq(struct irq_data *d)
 	u32 ier = LTQ_ICU_IM0_IER;
 	u32 isr = LTQ_ICU_IM0_ISR;
 	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
+	int im = offset / INT_NUM_IM_OFFSET;
 
-	ier += LTQ_ICU_OFFSET * (offset / INT_NUM_IM_OFFSET);
-	isr += LTQ_ICU_OFFSET * (offset / INT_NUM_IM_OFFSET);
 	offset %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(ltq_icu_r32(ier) & ~BIT(offset), ier);
-	ltq_icu_w32(BIT(offset), isr);
+	ltq_icu_w32(im, ltq_icu_r32(im, ier) & ~BIT(offset), ier);
+	ltq_icu_w32(im, BIT(offset), isr);
 }
 
 static void ltq_ack_irq(struct irq_data *d)
 {
 	u32 isr = LTQ_ICU_IM0_ISR;
 	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
+	int im = offset / INT_NUM_IM_OFFSET;
 
-	isr += LTQ_ICU_OFFSET * (offset / INT_NUM_IM_OFFSET);
 	offset %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(BIT(offset), isr);
+	ltq_icu_w32(im, BIT(offset), isr);
 }
 
 void ltq_enable_irq(struct irq_data *d)
 {
 	u32 ier = LTQ_ICU_IM0_IER;
 	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
+	int im = offset / INT_NUM_IM_OFFSET;
 
-	ier += LTQ_ICU_OFFSET  * (offset / INT_NUM_IM_OFFSET);
 	offset %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(ltq_icu_r32(ier) | BIT(offset), ier);
+	ltq_icu_w32(im, ltq_icu_r32(im, ier) | BIT(offset), ier);
 }
 
 static unsigned int ltq_startup_eiu_irq(struct irq_data *d)
@@ -192,7 +191,7 @@ static void ltq_hw_irqdispatch(int module)
 {
 	u32 irq;
 
-	irq = ltq_icu_r32(LTQ_ICU_IM0_IOSR + (module * LTQ_ICU_OFFSET));
+	irq = ltq_icu_r32(module, LTQ_ICU_IM0_IOSR);
 	if (irq == 0)
 		return;
 
@@ -275,7 +274,7 @@ asmlinkage void plat_irq_dispatch(void)
 		do_IRQ(MIPS_CPU_TIMER_IRQ);
 		goto out;
 	} else {
-		for (i = 0; i < 5; i++) {
+		for (i = 0; i < MAX_IM; i++) {
 			if (pending & (CAUSEF_IP2 << i)) {
 				ltq_hw_irqdispatch(i);
 				goto out;
@@ -318,15 +317,19 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	struct resource res;
 	int i;
 
-	if (of_address_to_resource(node, 0, &res))
-		panic("Failed to get icu memory range");
+	for (i = 0; i < MAX_IM; i++) {
+		if (of_address_to_resource(node, i, &res))
+			panic("Failed to get icu memory range");
 
-	if (request_mem_region(res.start, resource_size(&res), res.name) < 0)
-		pr_err("Failed to request icu memory");
+		if (request_mem_region(res.start, resource_size(&res),
+					res.name) < 0)
+			pr_err("Failed to request icu memory");
 
-	ltq_icu_membase = ioremap_nocache(res.start, resource_size(&res));
-	if (!ltq_icu_membase)
-		panic("Failed to remap icu memory");
+		ltq_icu_membase[i] = ioremap_nocache(res.start,
+					resource_size(&res));
+		if (!ltq_icu_membase[i])
+			panic("Failed to remap icu memory");
+	}
 
 	/* the external interrupts are optional and xway only */
 	eiu_node = of_find_compatible_node(NULL, NULL, "lantiq,eiu");
@@ -351,17 +354,17 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	}
 
 	/* turn off all irqs by default */
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < MAX_IM; i++) {
 		/* make sure all irqs are turned off by default */
-		ltq_icu_w32(0, LTQ_ICU_IM0_IER + (i * LTQ_ICU_OFFSET));
+		ltq_icu_w32(i, 0, LTQ_ICU_IM0_IER);
 		/* clear all possibly pending interrupts */
-		ltq_icu_w32(~0, LTQ_ICU_IM0_ISR + (i * LTQ_ICU_OFFSET));
+		ltq_icu_w32(i, ~0, LTQ_ICU_IM0_ISR);
 	}
 
 	mips_cpu_irq_init();
 
-	for (i = 2; i <= 6; i++)
-		setup_irq(i, &cascade);
+	for (i = 0; i < MAX_IM; i++)
+		setup_irq(i + 2, &cascade);
 
 	if (cpu_has_vint) {
 		pr_info("Setting up vectored interrupts\n");
@@ -373,7 +376,8 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 		set_vi_handler(7, ltq_hw5_irqdispatch);
 	}
 
-	irq_domain_add_linear(node, 6 * INT_NUM_IM_OFFSET,
+	irq_domain_add_linear(node,
+		(MAX_IM * INT_NUM_IM_OFFSET) + MIPS_CPU_IRQ_CASCADE,
 		&irq_domain_ops, 0);
 
 #if defined(CONFIG_MIPS_MT_SMP)
-- 
1.7.9.1
