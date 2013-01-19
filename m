Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jan 2013 10:58:20 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42365 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833247Ab3ASJ5Glf0FH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Jan 2013 10:57:06 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 5/5] MIPS: lantiq: rework external irq code
Date:   Sat, 19 Jan 2013 10:54:27 +0100
Message-Id: <1358589267-11514-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358589267-11514-1-git-send-email-blogic@openwrt.org>
References: <1358589267-11514-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35499
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

This code makes the irqs used by the EIU loadable from the DT. Additionally we
add a helper that allows the pinctrl layer to map external irqs to real irq
numbers.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-lantiq/lantiq.h |    1 +
 arch/mips/lantiq/irq.c                     |  105 +++++++++++++++++++---------
 2 files changed, 74 insertions(+), 32 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index 76be7a0..f196cce 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -34,6 +34,7 @@ extern spinlock_t ebu_lock;
 extern void ltq_disable_irq(struct irq_data *data);
 extern void ltq_mask_and_ack_irq(struct irq_data *data);
 extern void ltq_enable_irq(struct irq_data *data);
+extern int ltq_eiu_get_irq(int exin);
 
 /* clock handling */
 extern int clk_activate(struct clk *clk);
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index f36acd1..6f84009 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -33,17 +33,10 @@
 /* register definitions - external irqs */
 #define LTQ_EIU_EXIN_C		0x0000
 #define LTQ_EIU_EXIN_INIC	0x0004
+#define LTQ_EIU_EXIN_INC	0x0008
 #define LTQ_EIU_EXIN_INEN	0x000C
 
-/* irq numbers used by the external interrupt unit (EIU) */
-#define LTQ_EIU_IR0		(INT_NUM_IM4_IRL0 + 30)
-#define LTQ_EIU_IR1		(INT_NUM_IM3_IRL0 + 31)
-#define LTQ_EIU_IR2		(INT_NUM_IM1_IRL0 + 26)
-#define LTQ_EIU_IR3		INT_NUM_IM1_IRL0
-#define LTQ_EIU_IR4		(INT_NUM_IM1_IRL0 + 1)
-#define LTQ_EIU_IR5		(INT_NUM_IM1_IRL0 + 2)
-#define LTQ_EIU_IR6		(INT_NUM_IM2_IRL0 + 30)
-#define XWAY_EXIN_COUNT		3
+/* number of external interrupts */
 #define MAX_EIU			6
 
 /* the performance counter */
@@ -72,20 +65,19 @@
 int gic_present;
 #endif
 
-static unsigned short ltq_eiu_irq[MAX_EIU] = {
-	LTQ_EIU_IR0,
-	LTQ_EIU_IR1,
-	LTQ_EIU_IR2,
-	LTQ_EIU_IR3,
-	LTQ_EIU_IR4,
-	LTQ_EIU_IR5,
-};
-
 static int exin_avail;
+static struct resource ltq_eiu_irq[MAX_EIU];
 static void __iomem *ltq_icu_membase[MAX_IM];
 static void __iomem *ltq_eiu_membase;
 static struct irq_domain *ltq_domain;
 
+int ltq_eiu_get_irq(int exin)
+{
+	if (exin < exin_avail)
+		return ltq_eiu_irq[exin].start;
+	return -1;
+}
+
 void ltq_disable_irq(struct irq_data *d)
 {
 	u32 ier = LTQ_ICU_IM0_IER;
@@ -128,19 +120,65 @@ void ltq_enable_irq(struct irq_data *d)
 	ltq_icu_w32(im, ltq_icu_r32(im, ier) | BIT(offset), ier);
 }
 
+static int ltq_eiu_settype(struct irq_data *d, unsigned int type)
+{
+	int i;
+
+	for (i = 0; i < MAX_EIU; i++) {
+		if (d->hwirq == ltq_eiu_irq[i].start) {
+			int val = 0;
+			int edge = 0;
+
+			switch (type) {
+			case IRQF_TRIGGER_NONE:
+				break;
+			case IRQF_TRIGGER_RISING:
+				val = 1;
+				edge = 1;
+				break;
+			case IRQF_TRIGGER_FALLING:
+				val = 2;
+				edge = 1;
+				break;
+			case IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING:
+				val = 3;
+				edge = 1;
+				break;
+			case IRQF_TRIGGER_HIGH:
+				val = 5;
+				break;
+			case IRQF_TRIGGER_LOW:
+				val = 6;
+				break;
+			default:
+				pr_err("invalid type %d for irq %ld\n",
+					type, d->hwirq);
+				return -EINVAL;
+			}
+
+			if (edge)
+				irq_set_handler(d->hwirq, handle_edge_irq);
+
+			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_C) |
+				(val << (i * 4)), LTQ_EIU_EXIN_C);
+		}
+	}
+
+	return 0;
+}
+
 static unsigned int ltq_startup_eiu_irq(struct irq_data *d)
 {
 	int i;
 
 	ltq_enable_irq(d);
 	for (i = 0; i < MAX_EIU; i++) {
-		if (d->hwirq == ltq_eiu_irq[i]) {
-			/* low level - we should really handle set_type */
-			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_C) |
-				(0x6 << (i * 4)), LTQ_EIU_EXIN_C);
+		if (d->hwirq == ltq_eiu_irq[i].start) {
+			/* by default we are low level triggered */
+			ltq_eiu_settype(d, IRQF_TRIGGER_LOW);
 			/* clear all pending */
-			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INIC) & ~BIT(i),
-				LTQ_EIU_EXIN_INIC);
+			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INC) & ~BIT(i),
+				LTQ_EIU_EXIN_INC);
 			/* enable */
 			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) | BIT(i),
 				LTQ_EIU_EXIN_INEN);
@@ -157,7 +195,7 @@ static void ltq_shutdown_eiu_irq(struct irq_data *d)
 
 	ltq_disable_irq(d);
 	for (i = 0; i < MAX_EIU; i++) {
-		if (d->hwirq == ltq_eiu_irq[i]) {
+		if (d->hwirq == ltq_eiu_irq[i].start) {
 			/* disable */
 			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) & ~BIT(i),
 				LTQ_EIU_EXIN_INEN);
@@ -186,6 +224,7 @@ static struct irq_chip ltq_eiu_type = {
 	.irq_ack = ltq_ack_irq,
 	.irq_mask = ltq_disable_irq,
 	.irq_mask_ack = ltq_mask_and_ack_irq,
+	.irq_set_type = ltq_eiu_settype,
 };
 
 static void ltq_hw_irqdispatch(int module)
@@ -301,7 +340,7 @@ static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 		return 0;
 
 	for (i = 0; i < exin_avail; i++)
-		if (hw == ltq_eiu_irq[i])
+		if (hw == ltq_eiu_irq[i].start)
 			chip = &ltq_eiu_type;
 
 	irq_set_chip_and_handler(hw, chip, handle_level_irq);
@@ -323,7 +362,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 {
 	struct device_node *eiu_node;
 	struct resource res;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < MAX_IM; i++) {
 		if (of_address_to_resource(node, i, &res))
@@ -340,17 +379,19 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	}
 
 	/* the external interrupts are optional and xway only */
-	eiu_node = of_find_compatible_node(NULL, NULL, "lantiq,eiu");
+	eiu_node = of_find_compatible_node(NULL, NULL, "lantiq,eiu-xway");
 	if (eiu_node && !of_address_to_resource(eiu_node, 0, &res)) {
 		/* find out how many external irq sources we have */
-		const __be32 *count = of_get_property(node,
-							"lantiq,count",	NULL);
+		exin_avail = of_irq_count(eiu_node);
 
-		if (count)
-			exin_avail = *count;
 		if (exin_avail > MAX_EIU)
 			exin_avail = MAX_EIU;
 
+		ret = of_irq_to_resource_table(eiu_node,
+						ltq_eiu_irq, exin_avail);
+		if (ret != exin_avail)
+			panic("failed to load external irq resources\n");
+
 		if (request_mem_region(res.start, resource_size(&res),
 							res.name) < 0)
 			pr_err("Failed to request eiu memory");
-- 
1.7.10.4
