Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Aug 2012 01:00:52 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:39594 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903556Ab2HJXAo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Aug 2012 01:00:44 +0200
Received: by pbbrq8 with SMTP id rq8so2057385pbb.36
        for <multiple recipients>; Fri, 10 Aug 2012 16:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=pZo61AtxWn1xf+avJl0cqcjVfoojig+CxUCCjRlOn3U=;
        b=Rw6DK8e8RAmcKzdhtBwUu5zQgnDOJykzMPWzhvgdP0ffgqBb0NXYMFWVqdfS1+YSU7
         +JSo1YKE3ioFiT9mowmB99faQ40+mhK4kRTX4kjmXT2wDy3zTMvM0q7Xlr2/dJXq5geL
         M9fQspbyvRVu/YTf5ed4swhRyTAg7rRqsgVj29iscvfJTwjb0Z8kS+dG1vm0ClS89bgS
         BA0CDpja9A+bHNPjISWHnh6gwg9H0z8QjczGCtJU0vbSd39fmBiELkr5N3SYNhIDc9QS
         sCQwupLHHFMX6eNG+8W9vrZNkj1XAmtP38v229bumuXPmVor2BHOseLx+XHivUGWGrmZ
         XXtQ==
Received: by 10.68.218.163 with SMTP id ph3mr16328225pbc.58.1344639637163;
        Fri, 10 Aug 2012 16:00:37 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id rp9sm121752pbc.52.2012.08.10.16.00.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Aug 2012 16:00:36 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q7AN0YLo008922;
        Fri, 10 Aug 2012 16:00:34 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q7AN0XPX008921;
        Fri, 10 Aug 2012 16:00:33 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: OCTEON: Fix broken interrupt controller code.
Date:   Fri, 10 Aug 2012 16:00:31 -0700
Message-Id: <1344639631-8890-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 34092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Since 3.6.0-rc1,  We are getting many messages like:

WARNING: at kernel/irq/irqdomain.c:444 irq_domain_associate_many+0x23c/0x260()
Modules linked in:
Call Trace:
[<ffffffff814cb698>] dump_stack+0x8/0x34
[<ffffffff81133d00>] warn_slowpath_common+0x78/0xa8
[<ffffffff81187e44>] irq_domain_associate_many+0x23c/0x260
[<ffffffff81187f38>] irq_create_mapping+0xd0/0x220
[<ffffffff81188104>] irq_create_of_mapping+0x7c/0x158
[<ffffffff813e5f08>] irq_of_parse_and_map+0x28/0x40
.
.
.

Both the CIU and GPIO interrupt domains were somewhat screwed up.

For the CIU domain, we need to call irq_domain_associate() for each of
the preassigned irq numbers.  For the GPIO domain, we were applying
the register bit offset in octeon_irq_gpio_xlat, but it should be done
in octeon_irq_gpio_map instead.

Also: Reserve all 8 'core' irqs for the 'core' irq_chip so that they
don't get used by the other domains.  Remove unused OCTEON_IRQ_*
symbols.

Signed-off-by: David Daney <david.daney@cavium.com>
---

Ralf, can we send this for 3.6-rc?  It fixes regressions that seem to
have occured during the merge window.

 arch/mips/cavium-octeon/octeon-irq.c           |   89 +++++++++++------------
 arch/mips/include/asm/mach-cavium-octeon/irq.h |   10 +---
 2 files changed, 44 insertions(+), 55 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 7fb1f22..274cd4f 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -61,6 +61,12 @@ static void octeon_irq_set_ciu_mapping(int irq, int line, int bit,
 	octeon_irq_ciu_to_irq[line][bit] = irq;
 }
 
+static void octeon_irq_force_ciu_mapping(struct irq_domain *domain,
+					 int irq, int line, int bit)
+{
+	irq_domain_associate(domain, irq, line << 6 | bit);
+}
+
 static int octeon_coreid_for_cpu(int cpu)
 {
 #ifdef CONFIG_SMP
@@ -183,19 +189,9 @@ static void __init octeon_irq_init_core(void)
 		mutex_init(&cd->core_irq_mutex);
 
 		irq = OCTEON_IRQ_SW0 + i;
-		switch (irq) {
-		case OCTEON_IRQ_TIMER:
-		case OCTEON_IRQ_SW0:
-		case OCTEON_IRQ_SW1:
-		case OCTEON_IRQ_5:
-		case OCTEON_IRQ_PERF:
-			irq_set_chip_data(irq, cd);
-			irq_set_chip_and_handler(irq, &octeon_irq_chip_core,
-						 handle_percpu_irq);
-			break;
-		default:
-			break;
-		}
+		irq_set_chip_data(irq, cd);
+		irq_set_chip_and_handler(irq, &octeon_irq_chip_core,
+					 handle_percpu_irq);
 	}
 }
 
@@ -890,7 +886,6 @@ static int octeon_irq_gpio_xlat(struct irq_domain *d,
 	unsigned int type;
 	unsigned int pin;
 	unsigned int trigger;
-	struct octeon_irq_gpio_domain_data *gpiod;
 
 	if (d->of_node != node)
 		return -EINVAL;
@@ -925,8 +920,7 @@ static int octeon_irq_gpio_xlat(struct irq_domain *d,
 		break;
 	}
 	*out_type = type;
-	gpiod = d->host_data;
-	*out_hwirq = gpiod->base_hwirq + pin;
+	*out_hwirq = pin;
 
 	return 0;
 }
@@ -996,19 +990,21 @@ static int octeon_irq_ciu_map(struct irq_domain *d,
 static int octeon_irq_gpio_map(struct irq_domain *d,
 			       unsigned int virq, irq_hw_number_t hw)
 {
-	unsigned int line = hw >> 6;
-	unsigned int bit = hw & 63;
+	struct octeon_irq_gpio_domain_data *gpiod = d->host_data;
+	unsigned int line, bit;
 
 	if (!octeon_irq_virq_in_range(virq))
 		return -EINVAL;
 
+	hw += gpiod->base_hwirq;
+	line = hw >> 6;
+	bit = hw & 63;
 	if (line > 1 || octeon_irq_ciu_to_irq[line][bit] != 0)
 		return -EINVAL;
 
 	octeon_irq_set_ciu_mapping(virq, line, bit,
 				   octeon_irq_gpio_chip,
 				   octeon_irq_handle_gpio);
-
 	return 0;
 }
 
@@ -1149,6 +1145,7 @@ static void __init octeon_irq_init_ciu(void)
 	struct irq_chip *chip_wd;
 	struct device_node *gpio_node;
 	struct device_node *ciu_node;
+	struct irq_domain *ciu_domain = NULL;
 
 	octeon_irq_init_ciu_percpu();
 	octeon_irq_setup_secondary = octeon_irq_setup_secondary_ciu;
@@ -1177,31 +1174,6 @@ static void __init octeon_irq_init_ciu(void)
 	/* Mips internal */
 	octeon_irq_init_core();
 
-	/* CIU_0 */
-	for (i = 0; i < 16; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WORKQ0, 0, i + 0, chip, handle_level_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32, chip_mbox, handle_percpu_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33, chip_mbox, handle_percpu_irq);
-
-	for (i = 0; i < 4; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_PCI_INT0, 0, i + 36, chip, handle_level_irq);
-	for (i = 0; i < 4; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_PCI_MSI0, 0, i + 40, chip, handle_level_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RML, 0, 46, chip, handle_level_irq);
-	for (i = 0; i < 4; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_TIMER0, 0, i + 52, chip, handle_edge_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB0, 0, 56, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_BOOTDMA, 0, 63, chip, handle_level_irq);
-
-	/* CIU_1 */
-	for (i = 0; i < 16; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WDOG0, 1, i + 0, chip_wd, handle_level_irq);
-
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB1, 1, 17, chip, handle_level_irq);
-
 	gpio_node = of_find_compatible_node(NULL, NULL, "cavium,octeon-3860-gpio");
 	if (gpio_node) {
 		struct octeon_irq_gpio_domain_data *gpiod;
@@ -1219,10 +1191,35 @@ static void __init octeon_irq_init_ciu(void)
 
 	ciu_node = of_find_compatible_node(NULL, NULL, "cavium,octeon-3860-ciu");
 	if (ciu_node) {
-		irq_domain_add_tree(ciu_node, &octeon_irq_domain_ciu_ops, NULL);
+		ciu_domain = irq_domain_add_tree(ciu_node, &octeon_irq_domain_ciu_ops, NULL);
 		of_node_put(ciu_node);
 	} else
-		pr_warn("Cannot find device node for cavium,octeon-3860-ciu.\n");
+		panic("Cannot find device node for cavium,octeon-3860-ciu.");
+
+	/* CIU_0 */
+	for (i = 0; i < 16; i++)
+		octeon_irq_force_ciu_mapping(ciu_domain, i + OCTEON_IRQ_WORKQ0, 0, i + 0);
+
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32, chip_mbox, handle_percpu_irq);
+	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33, chip_mbox, handle_percpu_irq);
+
+	for (i = 0; i < 4; i++)
+		octeon_irq_force_ciu_mapping(ciu_domain, i + OCTEON_IRQ_PCI_INT0, 0, i + 36);
+	for (i = 0; i < 4; i++)
+		octeon_irq_force_ciu_mapping(ciu_domain, i + OCTEON_IRQ_PCI_MSI0, 0, i + 40);
+
+	octeon_irq_force_ciu_mapping(ciu_domain, OCTEON_IRQ_RML, 0, 46);
+	for (i = 0; i < 4; i++)
+		octeon_irq_force_ciu_mapping(ciu_domain, i + OCTEON_IRQ_TIMER0, 0, i + 52);
+
+	octeon_irq_force_ciu_mapping(ciu_domain, OCTEON_IRQ_USB0, 0, 56);
+	octeon_irq_force_ciu_mapping(ciu_domain, OCTEON_IRQ_BOOTDMA, 0, 63);
+
+	/* CIU_1 */
+	for (i = 0; i < 16; i++)
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WDOG0, 1, i + 0, chip_wd, handle_level_irq);
+
+	octeon_irq_force_ciu_mapping(ciu_domain, OCTEON_IRQ_USB1, 1, 17);
 
 	/* Enable the CIU lines */
 	set_c0_status(STATUSF_IP3 | STATUSF_IP2);
diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index 4189920..c22a307 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -21,14 +21,10 @@ enum octeon_irq {
 	OCTEON_IRQ_TIMER,
 /* sources in CIU_INTX_EN0 */
 	OCTEON_IRQ_WORKQ0,
-	OCTEON_IRQ_GPIO0 = OCTEON_IRQ_WORKQ0 + 16,
-	OCTEON_IRQ_WDOG0 = OCTEON_IRQ_GPIO0 + 16,
+	OCTEON_IRQ_WDOG0 = OCTEON_IRQ_WORKQ0 + 16,
 	OCTEON_IRQ_WDOG15 = OCTEON_IRQ_WDOG0 + 15,
 	OCTEON_IRQ_MBOX0 = OCTEON_IRQ_WDOG0 + 16,
 	OCTEON_IRQ_MBOX1,
-	OCTEON_IRQ_UART0,
-	OCTEON_IRQ_UART1,
-	OCTEON_IRQ_UART2,
 	OCTEON_IRQ_PCI_INT0,
 	OCTEON_IRQ_PCI_INT1,
 	OCTEON_IRQ_PCI_INT2,
@@ -38,8 +34,6 @@ enum octeon_irq {
 	OCTEON_IRQ_PCI_MSI2,
 	OCTEON_IRQ_PCI_MSI3,
 
-	OCTEON_IRQ_TWSI,
-	OCTEON_IRQ_TWSI2,
 	OCTEON_IRQ_RML,
 	OCTEON_IRQ_TIMER0,
 	OCTEON_IRQ_TIMER1,
@@ -47,8 +41,6 @@ enum octeon_irq {
 	OCTEON_IRQ_TIMER3,
 	OCTEON_IRQ_USB0,
 	OCTEON_IRQ_USB1,
-	OCTEON_IRQ_MII0,
-	OCTEON_IRQ_MII1,
 	OCTEON_IRQ_BOOTDMA,
 #ifndef CONFIG_PCI_MSI
 	OCTEON_IRQ_LAST = 127
-- 
1.7.2.3
