Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 19:44:31 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:38229 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903696Ab2ENRnc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 19:43:32 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>
Subject: [RESEND PATCH V2 03/17] OF: MIPS: lantiq: implement irq_domain support
Date:   Mon, 14 May 2012 19:42:29 +0200
Message-Id: <1337017363-14424-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add support for irq_domain on lantiq socs. The conversion is straight forward
as the ICU found inside the socs allows the usage of irq_domain_add_linear.

Harware IRQ 0->7 are the generic MIPS IRQs. 8->199 are the Lantiq IRQ Modules.
Our irq_chip callbacks need to substract 8 (MIPS_CPU_IRQ_CASCADE) from d->hwirq
to find out the correct offset into the Interrupt Modules register range.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: devicetree-discuss@lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>
---
This patch is part of a series moving the mips/lantiq target to OF and clkdev
support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

Changes in V2
* properly reserve 8 irqs for MIPS
* use d->hwirq rather than d->irq
* use BIT(x) instead of (1 << x)
* adds a optional property to allow setting the number of available EIU sources
* simplify icu_map()

 arch/mips/lantiq/irq.c |  178 +++++++++++++++++++++++++++--------------------
 1 files changed, 102 insertions(+), 76 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index d227be1..57c1a4e 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -9,6 +9,11 @@
 
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/sched.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/bootinfo.h>
 #include <asm/irq_cpu.h>
@@ -16,7 +21,7 @@
 #include <lantiq_soc.h>
 #include <irq.h>
 
-/* register definitions */
+/* register definitions - internal irqs */
 #define LTQ_ICU_IM0_ISR		0x0000
 #define LTQ_ICU_IM0_IER		0x0008
 #define LTQ_ICU_IM0_IOSR	0x0010
@@ -25,6 +30,7 @@
 #define LTQ_ICU_IM1_ISR		0x0028
 #define LTQ_ICU_OFFSET		(LTQ_ICU_IM1_ISR - LTQ_ICU_IM0_ISR)
 
+/* register definitions - external irqs */
 #define LTQ_EIU_EXIN_C		0x0000
 #define LTQ_EIU_EXIN_INIC	0x0004
 #define LTQ_EIU_EXIN_INEN	0x000C
@@ -37,13 +43,14 @@
 #define LTQ_EIU_IR4		(INT_NUM_IM1_IRL0 + 1)
 #define LTQ_EIU_IR5		(INT_NUM_IM1_IRL0 + 2)
 #define LTQ_EIU_IR6		(INT_NUM_IM2_IRL0 + 30)
-
+#define XWAY_EXIN_COUNT		3
 #define MAX_EIU			6
 
 /* the performance counter */
 #define LTQ_PERF_IRQ		(INT_NUM_IM4_IRL0 + 31)
 
-/* irqs generated by device attached to the EBU need to be acked in
+/*
+ * irqs generated by devices attached to the EBU need to be acked in
  * a special manner
  */
 #define LTQ_ICU_EBU_IRQ		22
@@ -58,6 +65,9 @@
 #define MIPS_CPU_IPI_RESCHED_IRQ	0
 #define MIPS_CPU_IPI_CALL_IRQ		1
 
+/* we have a cascade of 8 irqs */
+#define MIPS_CPU_IRQ_CASCADE		8
+
 #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
 int gic_present;
 #endif
@@ -71,64 +81,51 @@ static unsigned short ltq_eiu_irq[MAX_EIU] = {
 	LTQ_EIU_IR5,
 };
 
-static struct resource ltq_icu_resource = {
-	.name	= "icu",
-	.start	= LTQ_ICU_BASE_ADDR,
-	.end	= LTQ_ICU_BASE_ADDR + LTQ_ICU_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct resource ltq_eiu_resource = {
-	.name	= "eiu",
-	.start	= LTQ_EIU_BASE_ADDR,
-	.end	= LTQ_EIU_BASE_ADDR + LTQ_ICU_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
+static int exin_avail;
 static void __iomem *ltq_icu_membase;
 static void __iomem *ltq_eiu_membase;
 
 void ltq_disable_irq(struct irq_data *d)
 {
 	u32 ier = LTQ_ICU_IM0_IER;
-	int irq_nr = d->irq - INT_NUM_IRQ0;
+	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
 
-	ier += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
-	irq_nr %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(ltq_icu_r32(ier) & ~(1 << irq_nr), ier);
+	ier += LTQ_ICU_OFFSET * (offset / INT_NUM_IM_OFFSET);
+	offset %= INT_NUM_IM_OFFSET;
+	ltq_icu_w32(ltq_icu_r32(ier) & ~BIT(offset), ier);
 }
 
 void ltq_mask_and_ack_irq(struct irq_data *d)
 {
 	u32 ier = LTQ_ICU_IM0_IER;
 	u32 isr = LTQ_ICU_IM0_ISR;
-	int irq_nr = d->irq - INT_NUM_IRQ0;
+	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
 
-	ier += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
-	isr += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
-	irq_nr %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(ltq_icu_r32(ier) & ~(1 << irq_nr), ier);
-	ltq_icu_w32((1 << irq_nr), isr);
+	ier += LTQ_ICU_OFFSET * (offset / INT_NUM_IM_OFFSET);
+	isr += LTQ_ICU_OFFSET * (offset / INT_NUM_IM_OFFSET);
+	offset %= INT_NUM_IM_OFFSET;
+	ltq_icu_w32(ltq_icu_r32(ier) & ~BIT(offset), ier);
+	ltq_icu_w32(BIT(offset), isr);
 }
 
 static void ltq_ack_irq(struct irq_data *d)
 {
 	u32 isr = LTQ_ICU_IM0_ISR;
-	int irq_nr = d->irq - INT_NUM_IRQ0;
+	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
 
-	isr += LTQ_ICU_OFFSET * (irq_nr / INT_NUM_IM_OFFSET);
-	irq_nr %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32((1 << irq_nr), isr);
+	isr += LTQ_ICU_OFFSET * (offset / INT_NUM_IM_OFFSET);
+	offset %= INT_NUM_IM_OFFSET;
+	ltq_icu_w32(BIT(offset), isr);
 }
 
 void ltq_enable_irq(struct irq_data *d)
 {
 	u32 ier = LTQ_ICU_IM0_IER;
-	int irq_nr = d->irq - INT_NUM_IRQ0;
+	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
 
-	ier += LTQ_ICU_OFFSET  * (irq_nr / INT_NUM_IM_OFFSET);
-	irq_nr %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(ltq_icu_r32(ier) | (1 << irq_nr), ier);
+	ier += LTQ_ICU_OFFSET  * (offset / INT_NUM_IM_OFFSET);
+	offset %= INT_NUM_IM_OFFSET;
+	ltq_icu_w32(ltq_icu_r32(ier) | BIT(offset), ier);
 }
 
 static unsigned int ltq_startup_eiu_irq(struct irq_data *d)
@@ -137,15 +134,15 @@ static unsigned int ltq_startup_eiu_irq(struct irq_data *d)
 
 	ltq_enable_irq(d);
 	for (i = 0; i < MAX_EIU; i++) {
-		if (d->irq == ltq_eiu_irq[i]) {
+		if (d->hwirq == ltq_eiu_irq[i]) {
 			/* low level - we should really handle set_type */
 			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_C) |
 				(0x6 << (i * 4)), LTQ_EIU_EXIN_C);
 			/* clear all pending */
-			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INIC) & ~(1 << i),
+			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INIC) & ~BIT(i),
 				LTQ_EIU_EXIN_INIC);
 			/* enable */
-			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) | (1 << i),
+			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) | BIT(i),
 				LTQ_EIU_EXIN_INEN);
 			break;
 		}
@@ -160,9 +157,9 @@ static void ltq_shutdown_eiu_irq(struct irq_data *d)
 
 	ltq_disable_irq(d);
 	for (i = 0; i < MAX_EIU; i++) {
-		if (d->irq == ltq_eiu_irq[i]) {
+		if (d->hwirq == ltq_eiu_irq[i]) {
 			/* disable */
-			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) & ~(1 << i),
+			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) & ~BIT(i),
 				LTQ_EIU_EXIN_INEN);
 			break;
 		}
@@ -199,14 +196,15 @@ static void ltq_hw_irqdispatch(int module)
 	if (irq == 0)
 		return;
 
-	/* silicon bug causes only the msb set to 1 to be valid. all
+	/*
+	 * silicon bug causes only the msb set to 1 to be valid. all
 	 * other bits might be bogus
 	 */
 	irq = __fls(irq);
-	do_IRQ((int)irq + INT_NUM_IM0_IRL0 + (INT_NUM_IM_OFFSET * module));
+	do_IRQ((int)irq + MIPS_CPU_IRQ_CASCADE + (INT_NUM_IM_OFFSET * module));
 
 	/* if this is a EBU irq, we need to ack it or get a deadlock */
-	if ((irq == LTQ_ICU_EBU_IRQ) && (module == 0))
+	if ((irq == LTQ_ICU_EBU_IRQ) && (module == 0) && LTQ_EBU_PCC_ISTAT)
 		ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_PCC_ISTAT) | 0x10,
 			LTQ_EBU_PCC_ISTAT);
 }
@@ -290,38 +288,67 @@ out:
 	return;
 }
 
+static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	struct irq_chip *chip = &ltq_irq_type;
+	int i;
+
+	for (i = 0; i < exin_avail; i++)
+		if (hw == ltq_eiu_irq[i])
+			chip = &ltq_eiu_type;
+
+	irq_set_chip_and_handler(hw, chip, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops irq_domain_ops = {
+	.xlate = irq_domain_xlate_onetwocell,
+	.map = icu_map,
+};
+
 static struct irqaction cascade = {
 	.handler = no_action,
 	.name = "cascade",
 };
 
-void __init arch_init_irq(void)
+int __init icu_of_init(struct device_node *node, struct device_node *parent)
 {
+	struct device_node *eiu_node;
+	struct resource res;
 	int i;
 
-	if (insert_resource(&iomem_resource, &ltq_icu_resource) < 0)
-		panic("Failed to insert icu memory");
+	if (of_address_to_resource(node, 0, &res))
+		panic("Failed to get icu memory range");
 
-	if (request_mem_region(ltq_icu_resource.start,
-			resource_size(&ltq_icu_resource), "icu") < 0)
-		panic("Failed to request icu memory");
+	if (request_mem_region(res.start, resource_size(&res), res.name) < 0)
+		pr_err("Failed to request icu memory");
 
-	ltq_icu_membase = ioremap_nocache(ltq_icu_resource.start,
-				resource_size(&ltq_icu_resource));
+	ltq_icu_membase = ioremap_nocache(res.start, resource_size(&res));
 	if (!ltq_icu_membase)
 		panic("Failed to remap icu memory");
 
-	if (insert_resource(&iomem_resource, &ltq_eiu_resource) < 0)
-		panic("Failed to insert eiu memory");
-
-	if (request_mem_region(ltq_eiu_resource.start,
-			resource_size(&ltq_eiu_resource), "eiu") < 0)
-		panic("Failed to request eiu memory");
-
-	ltq_eiu_membase = ioremap_nocache(ltq_eiu_resource.start,
-				resource_size(&ltq_eiu_resource));
-	if (!ltq_eiu_membase)
-		panic("Failed to remap eiu memory");
+	/* the external interrupts are optional and xway only */
+	eiu_node = of_find_compatible_node(NULL, NULL, "lantiq,eiu");
+	if (eiu_node && of_address_to_resource(eiu_node, 0, &res)) {
+		/* find out how many external irq sources we have */
+		const __be32 *count = of_get_property(node,
+							"lantiq,count",	NULL);
+
+		if (count)
+			exin_avail = *count;
+		if (exin_avail > MAX_EIU)
+			exin_avail = MAX_EIU;
+
+		if (request_mem_region(res.start, resource_size(&res),
+							res.name) < 0)
+			pr_err("Failed to request eiu memory");
+
+		ltq_eiu_membase = ioremap_nocache(res.start,
+							resource_size(&res));
+		if (!ltq_eiu_membase)
+			panic("Failed to remap eiu memory");
+	}
 
 	/* turn off all irqs by default */
 	for (i = 0; i < 5; i++) {
@@ -346,20 +373,8 @@ void __init arch_init_irq(void)
 		set_vi_handler(7, ltq_hw5_irqdispatch);
 	}
 
-	for (i = INT_NUM_IRQ0;
-		i <= (INT_NUM_IRQ0 + (5 * INT_NUM_IM_OFFSET)); i++)
-		if ((i == LTQ_EIU_IR0) || (i == LTQ_EIU_IR1) ||
-			(i == LTQ_EIU_IR2))
-			irq_set_chip_and_handler(i, &ltq_eiu_type,
-				handle_level_irq);
-		/* EIU3-5 only exist on ar9 and vr9 */
-		else if (((i == LTQ_EIU_IR3) || (i == LTQ_EIU_IR4) ||
-			(i == LTQ_EIU_IR5)) && (ltq_is_ar9() || ltq_is_vr9()))
-			irq_set_chip_and_handler(i, &ltq_eiu_type,
-				handle_level_irq);
-		else
-			irq_set_chip_and_handler(i, &ltq_irq_type,
-				handle_level_irq);
+	irq_domain_add_linear(node, 6 * INT_NUM_IM_OFFSET,
+		&irq_domain_ops, 0);
 
 #if defined(CONFIG_MIPS_MT_SMP)
 	if (cpu_has_vint) {
@@ -382,9 +397,20 @@ void __init arch_init_irq(void)
 
 	/* tell oprofile which irq to use */
 	cp0_perfcount_irq = LTQ_PERF_IRQ;
+	return 0;
 }
 
 unsigned int __cpuinit get_c0_compare_int(void)
 {
 	return CP0_LEGACY_COMPARE_IRQ;
 }
+
+static struct of_device_id __initdata of_irq_ids[] = {
+	{ .compatible = "lantiq,icu", .data = icu_of_init },
+	{},
+};
+
+void __init arch_init_irq(void)
+{
+	of_irq_init(of_irq_ids);
+}
-- 
1.7.9.1
