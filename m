Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 18:57:26 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:37506 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993955AbdGUQ5CaChJm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 18:57:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 0372A1A4A6E;
        Fri, 21 Jul 2017 18:56:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id D58491A498D;
        Fri, 21 Jul 2017 18:56:56 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 4/8] MIPS: ranchu: Add Goldfish PIC driver
Date:   Fri, 21 Jul 2017 18:53:33 +0200
Message-Id: <1500656111-9520-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

Add device driver for a virtual programmable interrupt controller

The virtual PIC is designed as a device tree-based interrupt controller.

The compatible string used by OS for binding the driver is
"google,goldfish-pic".

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 MAINTAINERS                        |   1 +
 drivers/irqchip/Kconfig            |   8 +++
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-goldfish-pic.c | 142 +++++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 drivers/irqchip/irq-goldfish-pic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b4d74ab..5476a52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ ANDROID GOLDFISH PIC DRIVER
 M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
+F:	drivers/irqchip/irq-goldfish-pic.c
 
 ANDROID GOLDFISH RTC DRIVER
 M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f1fd5f4..21fab14 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -306,3 +306,11 @@ config QCOM_IRQ_COMBINER
 	help
 	  Say yes here to add support for the IRQ combiner devices embedded
 	  in Qualcomm Technologies chips.
+
+config GOLDFISH_PIC
+	bool "Goldfish programmable interrupt controller"
+	depends on MIPS && (GOLDFISH || COMPILE_TEST)
+	select IRQ_DOMAIN
+	help
+	  Say yes here to enable Goldfish interrupt controller driver used
+	  for Goldfish based virtual platforms.
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e88d856..ade04a1 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
+obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
new file mode 100644
index 0000000..4dad03c
--- /dev/null
+++ b/drivers/irqchip/irq-goldfish-pic.c
@@ -0,0 +1,142 @@
+/*
+ * Copyright (C) 2017 Imagination Technologies Ltd.	All rights reserved
+ *	Author: Miodrag Dinic <miodrag.dinic@imgtec.com>
+ *
+ * This file implements interrupt controller driver for MIPS Goldfish PIC.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <asm/setup.h>
+
+/* 0..7 MIPS CPU interrupts */
+#define GF_CPU_IRQ_PIC		(MIPS_CPU_IRQ_BASE + 2)
+#define GF_CPU_IRQ_COMPARE	(MIPS_CPU_IRQ_BASE + 7)
+
+#define GF_NR_IRQS		40
+/* 8..39 Cascaded Goldfish PIC interrupts */
+#define GF_IRQ_OFFSET		8
+
+#define GF_PIC_NUMBER		0x04
+#define GF_PIC_DISABLE_ALL	0x08
+#define GF_PIC_DISABLE		0x0c
+#define GF_PIC_ENABLE		0x10
+
+static struct irq_domain *irq_domain;
+static void __iomem *gf_pic_base;
+
+static inline void unmask_goldfish_irq(struct irq_data *d)
+{
+	writel(d->hwirq - GF_IRQ_OFFSET,
+		gf_pic_base + GF_PIC_ENABLE);
+	irq_enable_hazard();
+}
+
+static inline void mask_goldfish_irq(struct irq_data *d)
+{
+	writel(d->hwirq - GF_IRQ_OFFSET,
+		gf_pic_base + GF_PIC_DISABLE);
+	irq_disable_hazard();
+}
+
+static struct irq_chip goldfish_irq_controller = {
+	.name		= "Goldfish PIC",
+	.irq_ack	= mask_goldfish_irq,
+	.irq_mask	= mask_goldfish_irq,
+	.irq_mask_ack	= mask_goldfish_irq,
+	.irq_unmask	= unmask_goldfish_irq,
+	.irq_eoi	= unmask_goldfish_irq,
+	.irq_disable	= mask_goldfish_irq,
+	.irq_enable	= unmask_goldfish_irq,
+};
+
+static void goldfish_irq_dispatch(void)
+{
+	uint32_t irq;
+	uint32_t virq;
+
+	irq = readl(gf_pic_base + GF_PIC_NUMBER);
+	if (irq == 0) {
+		/* Timer interrupt */
+		do_IRQ(GF_CPU_IRQ_COMPARE);
+		return;
+	}
+
+	virq = irq_linear_revmap(irq_domain, irq);
+	virq += GF_IRQ_OFFSET;
+	do_IRQ(virq);
+}
+
+static void goldfish_ip2_irq_dispatch(struct irq_desc *desc)
+{
+	unsigned long pending = read_c0_cause() & read_c0_status() & ST0_IM;
+
+	if (pending & CAUSEF_IP2)
+		goldfish_irq_dispatch();
+	else
+		spurious_interrupt();
+}
+
+static int goldfish_pic_map(struct irq_domain *d, unsigned int irq,
+			    irq_hw_number_t hw)
+{
+	if (cpu_has_vint)
+		set_vi_handler(hw, goldfish_irq_dispatch);
+
+	irq_set_chip_and_handler(irq, &goldfish_irq_controller,
+				 handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops gf_pic_irq_domain_ops = {
+	.map = goldfish_pic_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+static struct irqaction cascade = {
+	.handler	= no_action,
+	.flags		= IRQF_PROBE_SHARED,
+	.name		= "cascade",
+};
+
+static void __init __goldfish_pic_init(struct device_node *of_node)
+{
+	gf_pic_base = of_iomap(of_node, 0);
+	if (!gf_pic_base)
+		panic("Failed to map Goldfish PIC base : No such device!");
+
+	/* Mask interrupts. */
+	writel(1, gf_pic_base + GF_PIC_DISABLE_ALL);
+
+	if (!cpu_has_vint)
+		irq_set_chained_handler(GF_CPU_IRQ_PIC,
+					goldfish_ip2_irq_dispatch);
+
+	setup_irq(GF_CPU_IRQ_PIC, &cascade);
+
+	irq_domain = irq_domain_add_legacy(of_node, GF_NR_IRQS,
+		GF_IRQ_OFFSET, 0, &gf_pic_irq_domain_ops, NULL);
+	if (!irq_domain)
+		panic("Failed to add irqdomain for Goldfish PIC");
+}
+
+int __init goldfish_pic_of_init(struct device_node *of_node,
+				struct device_node *parent)
+{
+	__goldfish_pic_init(of_node);
+	return 0;
+}
+IRQCHIP_DECLARE(google_gf_pic, "google,goldfish-pic", goldfish_pic_of_init);
-- 
2.7.4
