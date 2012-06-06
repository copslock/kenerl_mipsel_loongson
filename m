Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 00:45:48 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53937 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903726Ab2FFWo0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 00:44:26 +0200
Received: by pbbrq13 with SMTP id rq13so164394pbb.36
        for <multiple recipients>; Wed, 06 Jun 2012 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=B3lNbz09Qm+Dzt0yZtBv15tFreeTjJuSb4tuQBZhpho=;
        b=fqDjhDYzNTWrjUrbTSB+5nYddpJ1DnvhZCtTOZF3FSiwEZA/IuQgDKbhn59y5FvCrq
         lcFIOlJEspsAf5JuttaDXiAwBHU0hIU+Y//eWuI/KNV+I/eDXvJZFA5m5oXq71wE8HpD
         nFadRYFS51xpweOWhije+WfY+qK5VbjKYIXcL1saq5eAvK9+SrVg8yzbM40645F7HhOJ
         OIyP6c264lpig56dLB6MK2Ljqe0SoIDgV1jjWhti7irIlzWQDhP5u9+VF/u33gcLBQxg
         SH3ZO297hMKQU5KAgSUdc4UNI/VsN8t+9AWhVSMKnPeuiFhgH+dDfyZPdJXh5XzGoJlm
         R1GA==
Received: by 10.68.233.201 with SMTP id ty9mr2061778pbc.34.1339022659910;
        Wed, 06 Jun 2012 15:44:19 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ip5sm1797007pbc.3.2012.06.06.15.44.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 15:44:18 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q56MiGhD019900;
        Wed, 6 Jun 2012 15:44:16 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q56MiGLq019899;
        Wed, 6 Jun 2012 15:44:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/3] MIPS: Octeon: Add irq handlers for GPIO interrupts.
Date:   Wed,  6 Jun 2012 15:44:13 -0700
Message-Id: <1339022655-19860-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1339022655-19860-1-git-send-email-ddaney.cavm@gmail.com>
References: <1339022655-19860-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33580
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

This is needed for follow-on on patches for Octeon to use the Device
Tree to configure GPIO interrupts.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |  111 +++++++++++++++++++++++++++++++++-
 1 files changed, 110 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index ffd4ae6..168b489 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -505,6 +505,85 @@ static void octeon_irq_ciu_enable_all_v2(struct irq_data *data)
 	}
 }
 
+static void octeon_irq_gpio_setup(struct irq_data *data)
+{
+	union cvmx_gpio_bit_cfgx cfg;
+	union octeon_ciu_chip_data cd;
+	u32 t = irqd_get_trigger_type(data);
+
+	cd.p = irq_data_get_irq_chip_data(data);
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
+	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(cd.s.bit - 16), cfg.u64);
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
+	union octeon_ciu_chip_data cd;
+
+	cd.p = irq_data_get_irq_chip_data(data);
+	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(cd.s.bit - 16), 0);
+
+	octeon_irq_ciu_disable_all_v2(data);
+}
+
+static void octeon_irq_ciu_disable_gpio(struct irq_data *data)
+{
+	union octeon_ciu_chip_data cd;
+
+	cd.p = irq_data_get_irq_chip_data(data);
+	cvmx_write_csr(CVMX_GPIO_BIT_CFGX(cd.s.bit - 16), 0);
+
+	octeon_irq_ciu_disable_all(data);
+}
+
+static void octeon_irq_ciu_gpio_ack(struct irq_data *data)
+{
+	union octeon_ciu_chip_data cd;
+	u64 mask;
+
+	cd.p = irq_data_get_irq_chip_data(data);
+	mask = 1ull << (cd.s.bit - 16);
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
@@ -717,6 +796,33 @@ static struct irq_chip octeon_irq_chip_ciu_mbox = {
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
@@ -890,6 +996,7 @@ static void __init octeon_irq_init_ciu(void)
 	struct irq_chip *chip_edge;
 	struct irq_chip *chip_mbox;
 	struct irq_chip *chip_wd;
+	struct irq_chip *chip_gpio;
 
 	octeon_irq_init_ciu_percpu();
 	octeon_irq_setup_secondary = octeon_irq_setup_secondary_ciu;
@@ -904,6 +1011,7 @@ static void __init octeon_irq_init_ciu(void)
 		chip_edge = &octeon_irq_chip_ciu_edge_v2;
 		chip_mbox = &octeon_irq_chip_ciu_mbox_v2;
 		chip_wd = &octeon_irq_chip_ciu_wd_v2;
+		chip_gpio = &octeon_irq_chip_ciu_gpio_v2;
 	} else {
 		octeon_irq_ip2 = octeon_irq_ip2_v1;
 		octeon_irq_ip3 = octeon_irq_ip3_v1;
@@ -911,6 +1019,7 @@ static void __init octeon_irq_init_ciu(void)
 		chip_edge = &octeon_irq_chip_ciu_edge;
 		chip_mbox = &octeon_irq_chip_ciu_mbox;
 		chip_wd = &octeon_irq_chip_ciu_wd;
+		chip_gpio = &octeon_irq_chip_ciu_gpio;
 	}
 	octeon_irq_ip4 = octeon_irq_ip4_mask;
 
@@ -921,7 +1030,7 @@ static void __init octeon_irq_init_ciu(void)
 	for (i = 0; i < 16; i++)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_WORKQ0, 0, i + 0, chip, handle_level_irq);
 	for (i = 0; i < 16; i++)
-		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16, chip, handle_level_irq);
+		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_GPIO0, 0, i + 16, chip_gpio, octeon_irq_handle_gpio);
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX0, 0, 32, chip_mbox, handle_percpu_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MBOX1, 0, 33, chip_mbox, handle_percpu_irq);
-- 
1.7.2.3
