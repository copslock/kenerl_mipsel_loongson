Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2012 01:58:36 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:41930 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903795Ab2CAA5R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2012 01:57:17 +0100
Received: by ggnf2 with SMTP id f2so16414ggn.36
        for <multiple recipients>; Wed, 29 Feb 2012 16:57:11 -0800 (PST)
Received-SPF: pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.178.65 as permitted sender) client-ip=10.236.178.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.178.65 as permitted sender) smtp.mail=ddaney.cavm@gmail.com; dkim=pass header.i=ddaney.cavm@gmail.com
Received: from mr.google.com ([10.236.178.65])
        by 10.236.178.65 with SMTP id e41mr3866023yhm.130.1330563431025 (num_hops = 1);
        Wed, 29 Feb 2012 16:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lQxZpzwBnAGyJ0BcDtGBBWNINpXQMPoUW36rNL0OK6M=;
        b=MIHd2iOZe4npSRPvtYSLYMeHJBbYGwdJ8wWbvmM1AL7joYYlZYEiRsT4WolLsrIMKF
         p5+7/jVXvLLSTaOUo8eAsGoa5pGNJuqNixv9yZmv74Hz76O80q6IMgvKJ7khGzfulD/0
         4LCFLAq25zpX6oqiKFj0rfSQTfGMwz0+kS4Kk=
Received: by 10.236.178.65 with SMTP id e41mr3033176yhm.130.1330563430969;
        Wed, 29 Feb 2012 16:57:10 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id e45sm517793yhk.2.2012.02.29.16.57.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 16:57:09 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q210v8Or014132;
        Wed, 29 Feb 2012 16:57:08 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q210v839014131;
        Wed, 29 Feb 2012 16:57:08 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 4/5] MIPS: Octeon: Setup irq_domains for interrupts.
Date:   Wed, 29 Feb 2012 16:57:01 -0800
Message-Id: <1330563422-14078-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com>
References: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Select IRQ_DOMAIN so the core irq_domain code and supply
irq_create_of_mapping().

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig                    |    1 +
 arch/mips/cavium-octeon/octeon-irq.c |  301 +++++++++++++++++++++++++++-------
 2 files changed, 239 insertions(+), 63 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ce30e2f..01344ae 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1432,6 +1432,7 @@ config CPU_CAVIUM_OCTEON
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
+	select IRQ_DOMAIN
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
 	  many ethernet hardware widgets for networking tasks. The processor
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index bdcedd3..e9f2f6c 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -3,14 +3,16 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2008, 2009, 2010, 2011 Cavium Networks
+ * Copyright (C) 2004-2008, 2009, 2010, 2011, 2012 Cavium Networks
  */
 
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/bitops.h>
 #include <linux/percpu.h>
 #include <linux/irq.h>
 #include <linux/smp.h>
+#include <linux/of.h>
 
 #include <asm/octeon/octeon.h>
 
@@ -42,20 +44,27 @@ struct octeon_core_chip_data {
 
 static struct octeon_core_chip_data octeon_irq_core_chip_data[MIPS_CORE_IRQ_LINES];
 
-static void __init octeon_irq_set_ciu_mapping(int irq, int line, int bit,
+static void __init octeon_irq_set_ciu_mapping(unsigned int irq,
+					      unsigned int line,
+					      unsigned int bit,
+					      struct irq_domain *domain,
 					      struct irq_chip *chip,
 					      irq_flow_handler_t handler)
 {
+	struct irq_data *irqd;
 	union octeon_ciu_chip_data cd;
 
 	irq_set_chip_and_handler(irq, chip, handler);
-
 	cd.l = 0;
 	cd.s.line = line;
 	cd.s.bit = bit;
 
 	irq_set_chip_data(irq, cd.p);
 	octeon_irq_ciu_to_irq[line][bit] = irq;
+
+	irqd = irq_get_irq_data(irq);
+	irqd->hwirq = line << 6 | bit;
+	irqd->domain = domain;
 }
 
 static int octeon_coreid_for_cpu(int cpu)
@@ -855,6 +864,107 @@ static struct irq_chip octeon_irq_chip_ciu_wd = {
 	.irq_mask = octeon_irq_dummy_mask,
 };
 
+static int octeon_irq_gpio_xlat(struct irq_domain *d,
+				struct device_node *node,
+				const u32 *intspec,
+				unsigned int intsize,
+				unsigned long *out_hwirq,
+				unsigned int *out_type)
+{
+	unsigned int irq;
+	unsigned int type;
+	unsigned int ciu = 0, bit = 0;
+	unsigned int pin;
+	unsigned int trigger;
+	bool set_edge_handler = false;
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
+	*out_hwirq = ((unsigned long)d->host_data) + pin;
+
+	ciu = *out_hwirq >> 6;
+	bit = *out_hwirq & 0x3f;
+
+	irq = octeon_irq_ciu_to_irq[ciu][bit];
+
+	if (set_edge_handler)
+		__irq_set_handler(irq, handle_edge_irq, 0, NULL);
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
+	if (octeon_irq_ciu_to_irq[ciu][bit] == 0)
+		return -EINVAL;
+
+	*out_hwirq = (ciu << 6) | bit;
+	*out_type = 0;
+
+	return 0;
+}
+static int octeon_irq_dummy_map(struct irq_domain *d,
+				unsigned int virq, irq_hw_number_t hw)
+{
+	return 0;
+}
+
+static struct irq_domain_ops octeon_irq_domain_ciu_ops = {
+	.map = octeon_irq_dummy_map,
+	.xlate = octeon_irq_ciu_xlat,
+};
+
+static struct irq_domain_ops octeon_irq_domain_gpio_ops = {
+	.map = octeon_irq_dummy_map,
+	.xlate = octeon_irq_gpio_xlat,
+};
+
 static void octeon_irq_ip2_v1(void)
 {
 	const unsigned long core_id = cvmx_get_core_num();
@@ -982,6 +1092,10 @@ static void __init octeon_irq_init_ciu(void)
 	struct irq_chip *chip_mbox;
 	struct irq_chip *chip_wd;
 	struct irq_chip *chip_gpio;
+	struct device_node *gpio_node;
+	struct device_node *ciu_node;
+	struct irq_domain *gpio_domain;
+	struct irq_domain *ciu_domain;
 
 	octeon_irq_init_ciu_percpu();
 	octeon_irq_setup_secondary = octeon_irq_setup_secondary_ciu;
@@ -1011,83 +1125,144 @@ static void __init octeon_irq_init_ciu(void)
 	/* Mips internal */
 	octeon_irq_init_core();
 
+	gpio_node = of_find_compatible_node(NULL, NULL, "cavium,octeon-3860-gpio");
+	ciu_node = of_find_compatible_node(NULL, NULL, "cavium,octeon-3860-ciu");
+	/* gpio domain host_data is the base hwirq number. */
+	gpio_domain = irq_domain_add_linear(gpio_node, 16, &octeon_irq_domain_gpio_ops, (void *)16);
+	ciu_domain = irq_domain_add_tree(ciu_node, &octeon_irq_domain_ciu_ops, NULL);
+
 	/* CIU_0 */
 	for (i = 0; i < 16; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WORKQ0, 0, i + 0, chip, handle_level_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WORKQ0, 0, i + 0,
+					   ciu_domain, chip, handle_level_irq);
+
 	for (i = 0; i < 16; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16, chip_gpio, handle_level_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16,
+					   gpio_domain, chip_gpio, handle_level_irq);
 
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32, chip_mbox, handle_percpu_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33, chip_mbox, handle_percpu_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32,
+				   ciu_domain, chip_mbox, handle_percpu_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33,
+				   ciu_domain, chip_mbox, handle_percpu_irq);
 
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART0, 0, 34, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART1, 0, 35, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART0, 0, 34,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART1, 0, 35,
+				   ciu_domain, chip, handle_level_irq);
 
 	for (i = 0; i < 4; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_PCI_INT0, 0, i + 36, chip, handle_level_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_PCI_INT0, 0, i + 36,
+					   ciu_domain, chip, handle_level_irq);
 	for (i = 0; i < 4; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_PCI_MSI0, 0, i + 40, chip, handle_level_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_PCI_MSI0, 0, i + 40,
+					   ciu_domain, chip, handle_level_irq);
 
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI, 0, 45, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RML, 0, 46, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TRACE0, 0, 47, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI, 0, 45,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RML, 0, 46,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TRACE0, 0, 47,
+				   ciu_domain, chip, handle_level_irq);
 
 	for (i = 0; i < 2; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GMX_DRP0, 0, i + 48, chip_edge, handle_edge_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GMX_DRP0, 0, i + 48,
+					   ciu_domain, chip_edge, handle_edge_irq);
 
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IPD_DRP, 0, 50, chip_edge, handle_edge_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_KEY_ZERO, 0, 51, chip_edge, handle_edge_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IPD_DRP, 0, 50,
+				   ciu_domain, chip_edge, handle_edge_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_KEY_ZERO, 0, 51,
+				   ciu_domain, chip_edge, handle_edge_irq);
 
 	for (i = 0; i < 4; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_TIMER0, 0, i + 52, chip_edge, handle_edge_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB0, 0, 56, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PCM, 0, 57, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MPI, 0, 58, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI2, 0, 59, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_POWIQ, 0, 60, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IPDPPTHR, 0, 61, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MII0, 0, 62, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_BOOTDMA, 0, 63, chip, handle_level_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_TIMER0, 0, i + 52,
+					   ciu_domain, chip_edge, handle_edge_irq);
+
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB0, 0, 56,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PCM, 0, 57,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MPI, 0, 58,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI2, 0, 59,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_POWIQ, 0, 60,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IPDPPTHR, 0, 61,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MII0, 0, 62,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_BOOTDMA, 0, 63,
+				   ciu_domain, chip, handle_level_irq);
 
 	/* CIU_1 */
 	for (i = 0; i < 16; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WDOG0, 1, i + 0, chip_wd, handle_level_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART2, 1, 16, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB1, 1, 17, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MII1, 1, 18, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_NAND, 1, 19, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MIO, 1, 20, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IOB, 1, 21, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_FPA, 1, 22, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_POW, 1, 23, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_L2C, 1, 24, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IPD, 1, 25, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PIP, 1, 26, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PKO, 1, 27, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_ZIP, 1, 28, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TIM, 1, 29, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RAD, 1, 30, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_KEY, 1, 31, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_DFA, 1, 32, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USBCTL, 1, 33, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_SLI, 1, 34, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_DPI, 1, 35, chip, handle_level_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_AGX0, 1, 36, chip, handle_level_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_AGL, 1, 46, chip, handle_level_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PTP, 1, 47, chip_edge, handle_edge_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PEM0, 1, 48, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PEM1, 1, 49, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_SRIO0, 1, 50, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_SRIO1, 1, 51, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_LMC0, 1, 52, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_DFM, 1, 56, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RST, 1, 63, chip, handle_level_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WDOG0, 1, i + 0,
+					   ciu_domain, chip_wd, handle_level_irq);
+
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_UART2, 1, 16,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB1, 1, 17,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MII1, 1, 18,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_NAND, 1, 19,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MIO, 1, 20,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IOB, 1, 21,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_FPA, 1, 22,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_POW, 1, 23,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_L2C, 1, 24,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_IPD, 1, 25,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PIP, 1, 26,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PKO, 1, 27,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_ZIP, 1, 28,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TIM, 1, 29,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RAD, 1, 30,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_KEY, 1, 31,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_DFA, 1, 32,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USBCTL, 1, 33,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_SLI, 1, 34,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_DPI, 1, 35,
+				   ciu_domain, chip, handle_level_irq);
+
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_AGX0, 1, 36,
+				   ciu_domain, chip, handle_level_irq);
+
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_AGL, 1, 46,
+				   ciu_domain, chip, handle_level_irq);
+
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PTP, 1, 47,
+				   ciu_domain, chip_edge, handle_edge_irq);
+
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PEM0, 1, 48,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_PEM1, 1, 49,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_SRIO0, 1, 50,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_SRIO1, 1, 51,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_LMC0, 1, 52,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_DFM, 1, 56,
+				   ciu_domain, chip, handle_level_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RST, 1, 63,
+				   ciu_domain, chip, handle_level_irq);
 
 	/* Enable the CIU lines */
 	set_c0_status(STATUSF_IP3 | STATUSF_IP2);
-- 
1.7.2.3
