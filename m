Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2012 23:52:49 +0100 (CET)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:54753 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903742Ab2CWWvz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2012 23:51:55 +0100
Received: by obbup16 with SMTP id up16so3428992obb.36
        for <multiple recipients>; Fri, 23 Mar 2012 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E2+xjwg0XVcDaPG8/4F+Yw2N1yjE3h9Ct/nyd8dwws4=;
        b=XvDVHWF0F52IA5E7XsFQwkNTKoo22E/8C5k1LoRqkSsP0wvBTMK5VR7vQN7zR3lmXy
         3rf65AZHwWtuKpu8utF0wmDnQq0zKgQXzdy88wc41Ch4NPyNQSN4WsMcXan+UscSP0e2
         K1DCrMM+fCwg3T/k1ArUIrrLnCmd0Cc958F6WzJ6roThzkKdygVAOt2yUeCuI0PWxEFV
         +Yr/tWaFWVlT4RQnriOHVUQo5KM8BWRJCTX+FTnZhPp3KuYARNx3J7beBZuWfP8e85sk
         k3GHNZMYux1LFBSjI0mrXCUCr12k4ILZAjmR4NBzFVBzXDy4LIRThJjdvEFN0fL0TiT+
         tl4Q==
Received: by 10.182.147.99 with SMTP id tj3mr13277841obb.40.1332543109491;
        Fri, 23 Mar 2012 15:51:49 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id t5sm7128397oef.10.2012.03.23.15.51.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:51:48 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q2NMpkVr019970;
        Fri, 23 Mar 2012 15:51:46 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q2NMpk9t019969;
        Fri, 23 Mar 2012 15:51:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/3] MIPS: Octeon: Add irq handlers for GPIO interrupts.
Date:   Fri, 23 Mar 2012 15:51:40 -0700
Message-Id: <1332543102-19922-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1332543102-19922-1-git-send-email-ddaney.cavm@gmail.com>
References: <1332543102-19922-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

This is needed for follow-on on patches for Octeon to use the Device
Tree to configure GPIO interrupts.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |  102 +++++++++++++++++++++++++++++++++-
 1 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index ffd4ae6..61980d0 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -505,6 +505,76 @@ static void octeon_irq_ciu_enable_all_v2(struct irq_data *data)
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
+	cfg.s.int_type = (t & IRQ_TYPE_EDGE_BOTH) != 0;
+	cfg.s.rx_xor = (t & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)) != 0;
+
+	/* 140 nS glitch filter*/
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
+	irqd_set_trigger_type(data, t);
+	octeon_irq_gpio_setup(data);
+
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
+static void octeon_irq_handle_gpio(unsigned int irq, struct irq_desc *desc)
+{
+	if (irqd_get_trigger_type(irq_desc_get_irq_data(desc)) & IRQ_TYPE_EDGE_BOTH)
+		handle_edge_irq(irq, desc);
+	else
+		handle_level_irq(irq, desc);
+}
+
 #ifdef CONFIG_SMP
 
 static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
@@ -717,6 +787,33 @@ static struct irq_chip octeon_irq_chip_ciu_mbox = {
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
+	.flags = IRQCHIP_SET_TYPE_MASKED,
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
+	.flags = IRQCHIP_SET_TYPE_MASKED,
+};
+
 /*
  * Watchdog interrupts are special.  They are associated with a single
  * core, so we hardwire the affinity to that core.
@@ -890,6 +987,7 @@ static void __init octeon_irq_init_ciu(void)
 	struct irq_chip *chip_edge;
 	struct irq_chip *chip_mbox;
 	struct irq_chip *chip_wd;
+	struct irq_chip *chip_gpio;
 
 	octeon_irq_init_ciu_percpu();
 	octeon_irq_setup_secondary = octeon_irq_setup_secondary_ciu;
@@ -904,6 +1002,7 @@ static void __init octeon_irq_init_ciu(void)
 		chip_edge = &octeon_irq_chip_ciu_edge_v2;
 		chip_mbox = &octeon_irq_chip_ciu_mbox_v2;
 		chip_wd = &octeon_irq_chip_ciu_wd_v2;
+		chip_gpio = &octeon_irq_chip_ciu_gpio_v2;
 	} else {
 		octeon_irq_ip2 = octeon_irq_ip2_v1;
 		octeon_irq_ip3 = octeon_irq_ip3_v1;
@@ -911,6 +1010,7 @@ static void __init octeon_irq_init_ciu(void)
 		chip_edge = &octeon_irq_chip_ciu_edge;
 		chip_mbox = &octeon_irq_chip_ciu_mbox;
 		chip_wd = &octeon_irq_chip_ciu_wd;
+		chip_gpio = &octeon_irq_chip_ciu_gpio;
 	}
 	octeon_irq_ip4 = octeon_irq_ip4_mask;
 
@@ -921,7 +1021,7 @@ static void __init octeon_irq_init_ciu(void)
 	for (i = 0; i < 16; i++)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WORKQ0, 0, i + 0, chip, handle_level_irq);
 	for (i = 0; i < 16; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16, chip, handle_level_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16, chip_gpio, octeon_irq_handle_gpio);
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32, chip_mbox, handle_percpu_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33, chip_mbox, handle_percpu_irq);
-- 
1.7.2.3
