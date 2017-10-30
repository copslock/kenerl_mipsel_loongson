Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Oct 2017 12:58:53 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:51120 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990485AbdJ3L60UpSTC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Oct 2017 12:58:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id E8DD51A2477;
        Mon, 30 Oct 2017 12:58:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id C85FA1A2006;
        Mon, 30 Oct 2017 12:58:20 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@mips.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v6 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC driver
Date:   Mon, 30 Oct 2017 12:56:33 +0100
Message-Id: <1509364642-21771-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60587
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

From: Miodrag Dinic <miodrag.dinic@mips.com>

Add device driver for a virtual programmable interrupt controller

The virtual PIC is designed as a device tree-based interrupt controller.

The compatible string used by OS for binding the driver is
"google,goldfish-pic".

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 MAINTAINERS                        |   1 +
 drivers/irqchip/Kconfig            |   8 +++
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-goldfish-pic.c | 128 +++++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 drivers/irqchip/irq-goldfish-pic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d5108f..f1be016 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -876,6 +876,7 @@ ANDROID GOLDFISH PIC DRIVER
 M:	Miodrag Dinic <miodrag.dinic@mips.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
+F:	drivers/irqchip/irq-goldfish-pic.c
 
 ANDROID GOLDFISH RTC DRIVER
 M:	Miodrag Dinic <miodrag.dinic@mips.com>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 9d8a1dd..712b561 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -321,3 +321,11 @@ config IRQ_UNIPHIER_AIDET
 	select IRQ_DOMAIN_HIERARCHY
 	help
 	  Support for the UniPhier AIDET (ARM Interrupt Detector).
+
+config GOLDFISH_PIC
+	bool "Goldfish programmable interrupt controller"
+	depends on MIPS && (GOLDFISH || COMPILE_TEST)
+	select IRQ_DOMAIN
+	help
+	  Say yes here to enable Goldfish interrupt controller driver used
+	  for Goldfish based virtual platforms.
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 845abc1..0e7a224 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -79,3 +79,4 @@ obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
+obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
new file mode 100644
index 0000000..48fb773
--- /dev/null
+++ b/drivers/irqchip/irq-goldfish-pic.c
@@ -0,0 +1,128 @@
+/*
+ * Driver for MIPS Goldfish Programmable Interrupt Controller.
+ *
+ * Author: Miodrag Dinic <miodrag.dinic@mips.com>
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define GFPIC_NR_IRQS			32
+
+/* 8..39 Cascaded Goldfish PIC interrupts */
+#define GFPIC_IRQ_BASE			8
+
+#define GFPIC_REG_IRQ_PENDING		0x04
+#define GFPIC_REG_IRQ_DISABLE_ALL	0x08
+#define GFPIC_REG_IRQ_DISABLE		0x0c
+#define GFPIC_REG_IRQ_ENABLE		0x10
+
+struct goldfish_pic_data {
+	void __iomem *base;
+	struct irq_domain *irq_domain;
+};
+
+static void goldfish_pic_cascade(struct irq_desc *desc)
+{
+	struct goldfish_pic_data *gfpic = irq_desc_get_handler_data(desc);
+	struct irq_chip *host_chip = irq_desc_get_chip(desc);
+	u32 pending, hwirq, virq;
+
+	chained_irq_enter(host_chip, desc);
+
+	pending = readl(gfpic->base + GFPIC_REG_IRQ_PENDING);
+	while (pending) {
+		hwirq = __fls(pending);
+		virq = irq_linear_revmap(gfpic->irq_domain, hwirq);
+		generic_handle_irq(virq);
+		pending &= ~(1 << hwirq);
+	}
+
+	chained_irq_exit(host_chip, desc);
+}
+
+static const struct irq_domain_ops goldfish_irq_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int __init goldfish_pic_of_init(struct device_node *of_node,
+				       struct device_node *parent)
+{
+	struct goldfish_pic_data *gfpic;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	unsigned int parent_irq;
+	int ret = 0;
+
+	gfpic = kzalloc(sizeof(*gfpic), GFP_KERNEL);
+	if (!gfpic) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	parent_irq = irq_of_parse_and_map(of_node, 0);
+	if (!parent_irq) {
+		pr_err("Failed to map Goldfish PIC parent IRQ\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	gfpic->base = of_iomap(of_node, 0);
+	if (!gfpic->base) {
+		pr_err("Failed to map Goldfish PIC base\n");
+		ret = -ENOMEM;
+		goto out_unmap_irq;
+	}
+
+	/* Mask interrupts. */
+	writel(1, gfpic->base + GFPIC_REG_IRQ_DISABLE_ALL);
+
+	gc = irq_alloc_generic_chip("GFPIC", 1, GFPIC_IRQ_BASE, gfpic->base,
+				    handle_level_irq);
+
+	ct = gc->chip_types;
+	ct->regs.enable = GFPIC_REG_IRQ_ENABLE;
+	ct->regs.disable = GFPIC_REG_IRQ_DISABLE;
+	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
+	ct->chip.irq_mask = irq_gc_mask_disable_reg;
+
+	irq_setup_generic_chip(gc, IRQ_MSK(GFPIC_NR_IRQS), 0, 0,
+			       IRQ_NOPROBE | IRQ_LEVEL);
+
+	gfpic->irq_domain = irq_domain_add_legacy(of_node, GFPIC_NR_IRQS,
+						  GFPIC_IRQ_BASE, 0,
+						  &goldfish_irq_domain_ops,
+						  NULL);
+	if (!gfpic->irq_domain) {
+		pr_err("Failed to add irqdomain for Goldfish PIC\n");
+		ret = -EINVAL;
+		goto out_iounmap;
+	}
+
+	irq_set_chained_handler_and_data(parent_irq,
+					 goldfish_pic_cascade, gfpic);
+
+	pr_info("Successfully registered Goldfish PIC\n");
+	return 0;
+
+out_iounmap:
+	iounmap(gfpic->base);
+out_unmap_irq:
+	irq_dispose_mapping(parent_irq);
+out_free:
+	kfree(gfpic);
+out_err:
+	return ret;
+}
+
+IRQCHIP_DECLARE(google_gf_pic, "google,goldfish-pic", goldfish_pic_of_init);
-- 
2.7.4
