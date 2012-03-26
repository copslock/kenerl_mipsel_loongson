Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2012 21:32:57 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:48846 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903656Ab2CZTbf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2012 21:31:35 +0200
Received: by obbup16 with SMTP id up16so6753339obb.36
        for <multiple recipients>; Mon, 26 Mar 2012 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ovRFZy/a9/EA14giYu0DXWjK3KXaHiQVNDBmlGmUAOI=;
        b=oaxJjYU7WbG+i//3OQ+PuO+0hJ0D3azQDmsesYR/0BS0uX68NthRwLfEgUWky29sGM
         hiQg7V3rthyNQePlejIRksxF7JDZNX+6KWfzX11mPNnu2/A7OP3t2if3FsYIUIItskn1
         han3jmBiBRc5fMY898TVFGVqPu9zpCk+94/vsYciNa7k6HZwwKl6KeZrhk84YJWMY5sO
         p5xPDxH74rw3WRCQfsD2R7rVy1iAYp+ZQWDXa3EMdufj96RKpEZG7Pa8T2q9p0cF3ssG
         A1JlL8MQsvT1U9idN48GnLvQE133mnUsAHxACYqk2g+YfsbmVkIToVsLSEJQecwbQ79K
         mOsw==
Received: by 10.182.14.34 with SMTP id m2mr15992398obc.38.1332790289411;
        Mon, 26 Mar 2012 12:31:29 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ch5sm17254870obb.16.2012.03.26.12.31.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 12:31:27 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q2QJVP7k009700;
        Mon, 26 Mar 2012 12:31:25 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q2QJVPM7009699;
        Mon, 26 Mar 2012 12:31:25 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v7 2/4] MIPS: Octeon: Setup irq_domains for interrupts.
Date:   Mon, 26 Mar 2012 12:31:19 -0700
Message-Id: <1332790281-9648-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com>
References: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Create two domains.  One for the GPIO lines, and the other for on-chip
sources.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |  208 ++++++++++++++++++++++++++++++++--
 1 files changed, 199 insertions(+), 9 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 89b6f27..550c03d 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -3,14 +3,17 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2008, 2009, 2010, 2011 Cavium Networks
+ * Copyright (C) 2004-2012 Cavium, Inc.
  */
 
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/bitops.h>
 #include <linux/percpu.h>
+#include <linux/slab.h>
 #include <linux/irq.h>
 #include <linux/smp.h>
+#include <linux/of.h>
 
 #include <asm/octeon/octeon.h>
 
@@ -42,9 +45,9 @@ struct octeon_core_chip_data {
 
 static struct octeon_core_chip_data octeon_irq_core_chip_data[MIPS_CORE_IRQ_LINES];
 
-static void __init octeon_irq_set_ciu_mapping(int irq, int line, int bit,
-					      struct irq_chip *chip,
-					      irq_flow_handler_t handler)
+static void octeon_irq_set_ciu_mapping(int irq, int line, int bit,
+				       struct irq_chip *chip,
+				       irq_flow_handler_t handler)
 {
 	union octeon_ciu_chip_data cd;
 
@@ -838,6 +841,171 @@ static struct irq_chip octeon_irq_chip_ciu_wd = {
 	.irq_mask = octeon_irq_dummy_mask,
 };
 
+static bool octeon_irq_ciu_is_edge(unsigned int line, unsigned int bit)
+{
+	bool edge = false;
+
+	if (line == 0)
+		switch (bit) {
+		case 48 ... 49: /* GMX DRP */
+		case 50: /* IPD_DRP */
+		case 52 ... 55: /* Timers */
+		case 58: /* MPI */
+			edge = true;
+			break;
+		default:
+			break;
+		}
+	else /* line == 1 */
+		switch (bit) {
+		case 47: /* PTP */
+			edge = true;
+			break;
+		default:
+			break;
+		}
+	return edge;
+}
+
+struct octeon_irq_gpio_domain_data {
+	unsigned int base_hwirq;
+};
+
+static int octeon_irq_gpio_xlat(struct irq_domain *d,
+				struct device_node *node,
+				const u32 *intspec,
+				unsigned int intsize,
+				unsigned long *out_hwirq,
+				unsigned int *out_type)
+{
+	unsigned int type;
+	unsigned int pin;
+	unsigned int trigger;
+	bool set_edge_handler = false;
+	struct octeon_irq_gpio_domain_data *gpiod;
+
+	if (d->of_node != node)
+		return -EINVAL;
+
+	if (intsize < 2)
+		return -EINVAL;
+
+	pin = intspec[0];
+	if (pin >= 16)
+		return -EINVAL;
+
+	trigger = intspec[1];
+
+	switch (trigger) {
+	case 1:
+		type = IRQ_TYPE_EDGE_RISING;
+		set_edge_handler = true;
+		break;
+	case 2:
+		type = IRQ_TYPE_EDGE_FALLING;
+		set_edge_handler = true;
+		break;
+	case 4:
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case 8:
+		type = IRQ_TYPE_LEVEL_LOW;
+		break;
+	default:
+		pr_err("Error: (%s) Invalid irq trigger specification: %x\n",
+		       node->name,
+		       trigger);
+		type = IRQ_TYPE_LEVEL_LOW;
+		break;
+	}
+	*out_type = type;
+	gpiod = d->host_data;
+	*out_hwirq = gpiod->base_hwirq + pin;
+
+	return 0;
+}
+
+static int octeon_irq_ciu_xlat(struct irq_domain *d,
+			       struct device_node *node,
+			       const u32 *intspec,
+			       unsigned int intsize,
+			       unsigned long *out_hwirq,
+			       unsigned int *out_type)
+{
+	unsigned int ciu, bit;
+
+	ciu = intspec[0];
+	bit = intspec[1];
+
+	if (ciu > 1 || bit > 63)
+		return -EINVAL;
+
+	/* These are the GPIO lines */
+	if (ciu == 0 && bit >= 16 && bit < 32)
+		return -EINVAL;
+
+	*out_hwirq = (ciu << 6) | bit;
+	*out_type = 0;
+
+	return 0;
+}
+
+static struct irq_chip *octeon_irq_ciu_chip;
+static struct irq_chip *octeon_irq_gpio_chip;
+
+static int octeon_irq_ciu_map(struct irq_domain *d,
+			      unsigned int virq, irq_hw_number_t hw)
+{
+	unsigned int line = hw >> 6;
+	unsigned int bit = hw & 63;
+
+	if (virq >= 256)
+		return -EINVAL;
+
+	if (line > 1 || octeon_irq_ciu_to_irq[line][bit] != 0)
+		return -EINVAL;
+
+	if (octeon_irq_ciu_is_edge(line, bit))
+		octeon_irq_set_ciu_mapping(virq, line, bit,
+					   octeon_irq_ciu_chip,
+					   handle_level_irq);
+	else
+		octeon_irq_set_ciu_mapping(virq, line, bit,
+					   octeon_irq_ciu_chip,
+					   handle_edge_irq);
+
+	return 0;
+}
+
+static int octeon_irq_gpio_map(struct irq_domain *d,
+			       unsigned int virq, irq_hw_number_t hw)
+{
+	unsigned int line = hw >> 6;
+	unsigned int bit = hw & 63;
+
+	if (virq >= 256)
+		return -EINVAL;
+
+	if (line > 1 || octeon_irq_ciu_to_irq[line][bit] != 0)
+		return -EINVAL;
+
+	octeon_irq_set_ciu_mapping(virq, line, bit,
+				   octeon_irq_gpio_chip,
+				   octeon_irq_handle_gpio);
+
+	return 0;
+}
+
+static struct irq_domain_ops octeon_irq_domain_ciu_ops = {
+	.map = octeon_irq_ciu_map,
+	.xlate = octeon_irq_ciu_xlat,
+};
+
+static struct irq_domain_ops octeon_irq_domain_gpio_ops = {
+	.map = octeon_irq_gpio_map,
+	.xlate = octeon_irq_gpio_xlat,
+};
+
 static void octeon_irq_ip2_v1(void)
 {
 	const unsigned long core_id = cvmx_get_core_num();
@@ -963,7 +1131,8 @@ static void __init octeon_irq_init_ciu(void)
 	struct irq_chip *chip;
 	struct irq_chip *chip_mbox;
 	struct irq_chip *chip_wd;
-	struct irq_chip *chip_gpio;
+	struct device_node *gpio_node;
+	struct device_node *ciu_node;
 
 	octeon_irq_init_ciu_percpu();
 	octeon_irq_setup_secondary = octeon_irq_setup_secondary_ciu;
@@ -977,15 +1146,16 @@ static void __init octeon_irq_init_ciu(void)
 		chip = &octeon_irq_chip_ciu_v2;
 		chip_mbox = &octeon_irq_chip_ciu_mbox_v2;
 		chip_wd = &octeon_irq_chip_ciu_wd_v2;
-		chip_gpio = &octeon_irq_chip_ciu_gpio_v2;
+		octeon_irq_gpio_chip = &octeon_irq_chip_ciu_gpio_v2;
 	} else {
 		octeon_irq_ip2 = octeon_irq_ip2_v1;
 		octeon_irq_ip3 = octeon_irq_ip3_v1;
 		chip = &octeon_irq_chip_ciu;
 		chip_mbox = &octeon_irq_chip_ciu_mbox;
 		chip_wd = &octeon_irq_chip_ciu_wd;
-		chip_gpio = &octeon_irq_chip_ciu_gpio;
+		octeon_irq_gpio_chip = &octeon_irq_chip_ciu_gpio;
 	}
+	octeon_irq_ciu_chip = chip;
 	octeon_irq_ip4 = octeon_irq_ip4_mask;
 
 	/* Mips internal */
@@ -994,8 +1164,6 @@ static void __init octeon_irq_init_ciu(void)
 	/* CIU_0 */
 	for (i = 0; i < 16; i++)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WORKQ0, 0, i + 0, chip, handle_level_irq);
-	for (i = 0; i < 16; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16, chip_gpio, octeon_irq_handle_gpio);
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32, chip_mbox, handle_percpu_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33, chip_mbox, handle_percpu_irq);
@@ -1026,6 +1194,28 @@ static void __init octeon_irq_init_ciu(void)
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB1, 1, 17, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MII1, 1, 18, chip, handle_level_irq);
 
+	gpio_node = of_find_compatible_node(NULL, NULL, "cavium,octeon-3860-gpio");
+	if (gpio_node) {
+		struct octeon_irq_gpio_domain_data *gpiod;
+
+		gpiod = kzalloc(sizeof (*gpiod), GFP_KERNEL);
+		if (gpiod) {
+			/* gpio domain host_data is the base hwirq number. */
+			gpiod->base_hwirq = 16;
+			irq_domain_add_linear(gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);
+			of_node_put(gpio_node);
+		} else
+			pr_warning("Cannot allocate memory for GPIO irq_domain.\n");
+	} else
+		pr_warning("Cannot find device node for cavium,octeon-3860-gpio.\n");
+
+	ciu_node = of_find_compatible_node(NULL, NULL, "cavium,octeon-3860-ciu");
+	if (ciu_node) {
+		irq_domain_add_tree(ciu_node, &octeon_irq_domain_ciu_ops, NULL);
+		of_node_put(ciu_node);
+	} else
+		pr_warning("Cannot find device node for cavium,octeon-3860-ciu.\n");
+
 	/* Enable the CIU lines */
 	set_c0_status(STATUSF_IP3 | STATUSF_IP2);
 	clear_c0_status(STATUSF_IP4);
-- 
1.7.2.3
