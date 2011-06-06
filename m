Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 21:22:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11446 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491877Ab1FFTUN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 21:20:13 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ded28ac0001>; Mon, 06 Jun 2011 12:21:16 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 6 Jun 2011 12:20:11 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 6 Jun 2011 12:20:11 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p56JK6BN027131;
        Mon, 6 Jun 2011 12:20:06 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p56JK5GL027130;
        Mon, 6 Jun 2011 12:20:05 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH v5 5/6] MIPS: Octeon: Add irq_create_of_mapping() and GPIO interrupts.
Date:   Mon,  6 Jun 2011 12:19:45 -0700
Message-Id: <1307387986-27069-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1307387986-27069-1-git-send-email-ddaney@caviumnetworks.com>
References: <1307387986-27069-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 06 Jun 2011 19:20:11.0189 (UTC) FILETIME=[C1263E50:01CC247E]
X-archive-position: 30263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4753

This is needed for Octeon to use the Device Tree.

The GPIO interrupts are configured based on Device Tree properties

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |  188 +++++++++++++++++++++++++++++++++-
 1 files changed, 187 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index ffd4ae6..bb10546 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -8,11 +8,14 @@
 
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
+#include <linux/module.h>
 #include <linux/percpu.h>
+#include <linux/of_irq.h>
 #include <linux/irq.h>
 #include <linux/smp.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-gpio-defs.h>
 
 static DEFINE_RAW_SPINLOCK(octeon_irq_ciu0_lock);
 static DEFINE_RAW_SPINLOCK(octeon_irq_ciu1_lock);
@@ -58,6 +61,95 @@ static void __init octeon_irq_set_ciu_mapping(int irq, int line, int bit,
 	octeon_irq_ciu_to_irq[line][bit] = irq;
 }
 
+static unsigned int octeon_irq_gpio_mapping(struct device_node *controller,
+					    const u32 *intspec,
+					    unsigned int intsize)
+{
+	struct of_irq oirq;
+	int i;
+	unsigned int irq = 0;
+	unsigned int type;
+	unsigned int ciu = 0, bit = 0;
+	unsigned int pin = be32_to_cpup(intspec);
+	unsigned int trigger = be32_to_cpup(intspec + 1);
+	bool set_edge_handler = false;
+
+	if (pin >= 16)
+		goto err;
+	i = of_irq_map_one(controller, 0, &oirq);
+	if (i)
+		goto err;
+	if (oirq.size != 2)
+		goto err_put;
+
+	ciu = oirq.specifier[0];
+	bit = oirq.specifier[1] + pin;
+
+	if (ciu >= 8 || bit >= 64)
+		goto err_put;
+
+	irq = octeon_irq_ciu_to_irq[ciu][bit];
+	if (!irq)
+		goto err_put;
+
+	switch (trigger & 0xf) {
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
+		pr_err("Error: Invalid irq trigger specification: %x\n",
+		       trigger);
+		type = IRQ_TYPE_LEVEL_LOW;
+		break;
+	}
+
+	irq_set_irq_type(irq, type);
+
+	if (set_edge_handler)
+		__irq_set_handler(irq, handle_edge_irq, 0, NULL);
+
+err_put:
+	of_node_put(oirq.controller);
+err:
+	return irq;
+}
+
+/*
+ * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
+ *
+ * Octeon irq maps are a pair of indexes.  The first selects either
+ * ciu0 or ciu1, the second is the bit within the ciu register.
+ */
+unsigned int irq_create_of_mapping(struct device_node *controller,
+				   const u32 *intspec, unsigned int intsize)
+{
+	unsigned int irq = 0;
+	unsigned int ciu, bit;
+
+	if (of_device_is_compatible(controller, "cavium,octeon-3860-gpio"))
+		return octeon_irq_gpio_mapping(controller, intspec, intsize);
+
+	ciu = be32_to_cpup(intspec);
+	bit = be32_to_cpup(intspec + 1);
+
+	if (ciu < 8 && bit < 64)
+		irq = octeon_irq_ciu_to_irq[ciu][bit];
+
+	return irq;
+}
+EXPORT_SYMBOL_GPL(irq_create_of_mapping);
+
 static int octeon_coreid_for_cpu(int cpu)
 {
 #ifdef CONFIG_SMP
@@ -505,6 +597,72 @@ static void octeon_irq_ciu_enable_all_v2(struct irq_data *data)
 	}
 }
 
+static void octeon_irq_gpio_setup(struct irq_data *data)
+{
+	union cvmx_gpio_bit_cfgx cfg;
+	int bit = data->irq - OCTEON_IRQ_GPIO0;
+	u32 t = irqd_get_trigger_type(data);
+
+	cfg.u64 = 0;
+	cfg.s.int_en = 1;
+	cfg.s.int_type = (t & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) != 0;
+	cfg.s.rx_xor = (t & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)) != 0;
+
+	/* 1 uS glitch filter*/
+	cfg.s.fil_cnt = 7;
+	cfg.s.fil_sel = 3;
+
+	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(bit), cfg.u64);
+}
+
+static void octeon_irq_ciu_enable_gpio_v2(struct irq_data *data)
+{
+	octeon_irq_gpio_setup(data);
+	octeon_irq_ciu_enable_v2(data);
+}
+
+static void octeon_irq_ciu_enable_gpio(struct irq_data *data)
+{
+	octeon_irq_gpio_setup(data);
+	octeon_irq_ciu_enable(data);
+}
+
+static int octeon_irq_ciu_gpio_set_type(struct irq_data *data, unsigned int t)
+{
+	u32 current_type = irqd_get_trigger_type(data);
+
+	/* If the type has been set, don't change it */
+	if (current_type && current_type != t)
+		return -EINVAL;
+
+	irqd_set_trigger_type(data, t);
+	return IRQ_SET_MASK_OK;
+}
+
+static void octeon_irq_ciu_disable_gpio_v2(struct irq_data *data)
+{
+	int bit = data->irq - OCTEON_IRQ_GPIO0;
+	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(bit), 0);
+
+	octeon_irq_ciu_disable_all_v2(data);
+}
+
+static void octeon_irq_ciu_disable_gpio(struct irq_data *data)
+{
+	int bit = data->irq - OCTEON_IRQ_GPIO0;
+	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(bit), 0);
+
+	octeon_irq_ciu_disable_all(data);
+}
+
+static void octeon_irq_ciu_gpio_ack(struct irq_data *data)
+{
+	int bit = data->irq - OCTEON_IRQ_GPIO0;
+	u64 mask = 1ull << bit;
+
+	cvmx_write_csr(CVMX_GPIO_INT_CLR, mask);
+}
+
 #ifdef CONFIG_SMP
 
 static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
@@ -717,6 +875,31 @@ static struct irq_chip octeon_irq_chip_ciu_mbox = {
 	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 };
 
+static struct irq_chip octeon_irq_chip_ciu_gpio_v2 = {
+	.name = "CIU-GPIO",
+	.irq_enable = octeon_irq_ciu_enable_gpio_v2,
+	.irq_disable = octeon_irq_ciu_disable_gpio_v2,
+	.irq_ack = octeon_irq_ciu_gpio_ack,
+	.irq_mask = octeon_irq_ciu_disable_local_v2,
+	.irq_unmask = octeon_irq_ciu_enable_v2,
+	.irq_set_type = octeon_irq_ciu_gpio_set_type,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
+#endif
+};
+
+static struct irq_chip octeon_irq_chip_ciu_gpio = {
+	.name = "CIU-GPIO",
+	.irq_enable = octeon_irq_ciu_enable_gpio,
+	.irq_disable = octeon_irq_ciu_disable_gpio,
+	.irq_mask = octeon_irq_dummy_mask,
+	.irq_ack = octeon_irq_ciu_gpio_ack,
+	.irq_set_type = octeon_irq_ciu_gpio_set_type,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = octeon_irq_ciu_set_affinity,
+#endif
+};
+
 /*
  * Watchdog interrupts are special.  They are associated with a single
  * core, so we hardwire the affinity to that core.
@@ -890,6 +1073,7 @@ static void __init octeon_irq_init_ciu(void)
 	struct irq_chip *chip_edge;
 	struct irq_chip *chip_mbox;
 	struct irq_chip *chip_wd;
+	struct irq_chip *chip_gpio;
 
 	octeon_irq_init_ciu_percpu();
 	octeon_irq_setup_secondary = octeon_irq_setup_secondary_ciu;
@@ -904,6 +1088,7 @@ static void __init octeon_irq_init_ciu(void)
 		chip_edge = &octeon_irq_chip_ciu_edge_v2;
 		chip_mbox = &octeon_irq_chip_ciu_mbox_v2;
 		chip_wd = &octeon_irq_chip_ciu_wd_v2;
+		chip_gpio = &octeon_irq_chip_ciu_gpio_v2;
 	} else {
 		octeon_irq_ip2 = octeon_irq_ip2_v1;
 		octeon_irq_ip3 = octeon_irq_ip3_v1;
@@ -911,6 +1096,7 @@ static void __init octeon_irq_init_ciu(void)
 		chip_edge = &octeon_irq_chip_ciu_edge;
 		chip_mbox = &octeon_irq_chip_ciu_mbox;
 		chip_wd = &octeon_irq_chip_ciu_wd;
+		chip_gpio = &octeon_irq_chip_ciu_gpio;
 	}
 	octeon_irq_ip4 = octeon_irq_ip4_mask;
 
@@ -921,7 +1107,7 @@ static void __init octeon_irq_init_ciu(void)
 	for (i = 0; i < 16; i++)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WORKQ0, 0, i + 0, chip, handle_level_irq);
 	for (i = 0; i < 16; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16, chip, handle_level_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16, chip_gpio, handle_level_irq);
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32, chip_mbox, handle_percpu_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33, chip_mbox, handle_percpu_irq);
-- 
1.7.2.3
