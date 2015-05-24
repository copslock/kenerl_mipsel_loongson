Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 17:21:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44372 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007004AbbEXPUzaze9f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 17:20:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F1CE282ACAF14;
        Sun, 24 May 2015 16:20:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 24 May 2015 16:20:51 +0100
Received: from localhost (192.168.159.140) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 24 May
 2015 16:20:49 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v5 16/37] MIPS: JZ4740: support >32 interrupts
Date:   Sun, 24 May 2015 16:11:26 +0100
Message-ID: <1432480307-23789-17-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
References: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.140]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On newer Ingenic SoCs the interrupt controller supports more than 32
interrupts, which it does by duplicating the registers at intervals
of 0x20 bytes within its address space. Add support for an arbitrary
number of interrupts using multiple generic chips, and provide the
number of chips to register from the interrupt controller probe
function.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

Changes in v5: None
Changes in v4: None
Changes in v3:
- Name probe functions a little more generically, ie. "1chip" rather
  than "jz4740". This is more for consistency with the later "2chip"
  variant that is used across a number of SoCs.

Changes in v2: None

 arch/mips/jz4740/irq.c | 71 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 854cd14..7ad6688 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -34,6 +34,7 @@
 
 struct ingenic_intc_data {
 	void __iomem *base;
+	unsigned num_chips;
 };
 
 #define JZ_REG_INTC_STATUS	0x00
@@ -41,16 +42,22 @@ struct ingenic_intc_data {
 #define JZ_REG_INTC_SET_MASK	0x08
 #define JZ_REG_INTC_CLEAR_MASK	0x0c
 #define JZ_REG_INTC_PENDING	0x10
+#define CHIP_SIZE		0x20
 
 static irqreturn_t jz4740_cascade(int irq, void *data)
 {
 	struct ingenic_intc_data *intc = irq_get_handler_data(irq);
 	uint32_t irq_reg;
+	unsigned i;
 
-	irq_reg = readl(intc->base + JZ_REG_INTC_PENDING);
+	for (i = 0; i < intc->num_chips; i++) {
+		irq_reg = readl(intc->base + (i * CHIP_SIZE) +
+				JZ_REG_INTC_PENDING);
+		if (!irq_reg)
+			continue;
 
-	if (irq_reg)
-		generic_handle_irq(__fls(irq_reg) + JZ4740_IRQ_BASE);
+		generic_handle_irq(__fls(irq_reg) + (i * 32) + JZ4740_IRQ_BASE);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -80,14 +87,15 @@ static struct irqaction jz4740_cascade_action = {
 	.name = "JZ4740 cascade interrupt",
 };
 
-static int __init jz4740_intc_of_init(struct device_node *node,
-	struct device_node *parent)
+static int __init ingenic_intc_of_init(struct device_node *node,
+				       unsigned num_chips)
 {
 	struct ingenic_intc_data *intc;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	struct irq_domain *domain;
 	int parent_irq, err = 0;
+	unsigned i;
 
 	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
 	if (!intc) {
@@ -105,27 +113,34 @@ static int __init jz4740_intc_of_init(struct device_node *node,
 	if (err)
 		goto out_unmap_irq;
 
+	intc->num_chips = num_chips;
 	intc->base = ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
 
-	/* Mask all irqs */
-	writel(0xffffffff, intc->base + JZ_REG_INTC_SET_MASK);
-
-	gc = irq_alloc_generic_chip("INTC", 1, JZ4740_IRQ_BASE, intc->base,
-		handle_level_irq);
-
-	gc->wake_enabled = IRQ_MSK(32);
-
-	ct = gc->chip_types;
-	ct->regs.enable = JZ_REG_INTC_CLEAR_MASK;
-	ct->regs.disable = JZ_REG_INTC_SET_MASK;
-	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
-	ct->chip.irq_mask = irq_gc_mask_disable_reg;
-	ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
-	ct->chip.irq_set_wake = irq_gc_set_wake;
-	ct->chip.irq_suspend = jz4740_irq_suspend;
-	ct->chip.irq_resume = jz4740_irq_resume;
-
-	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0, IRQ_NOPROBE | IRQ_LEVEL);
+	for (i = 0; i < num_chips; i++) {
+		/* Mask all irqs */
+		writel(0xffffffff, intc->base + (i * CHIP_SIZE) +
+		       JZ_REG_INTC_SET_MASK);
+
+		gc = irq_alloc_generic_chip("INTC", 1,
+					    JZ4740_IRQ_BASE + (i * 32),
+					    intc->base + (i * CHIP_SIZE),
+					    handle_level_irq);
+
+		gc->wake_enabled = IRQ_MSK(32);
+
+		ct = gc->chip_types;
+		ct->regs.enable = JZ_REG_INTC_CLEAR_MASK;
+		ct->regs.disable = JZ_REG_INTC_SET_MASK;
+		ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
+		ct->chip.irq_mask = irq_gc_mask_disable_reg;
+		ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
+		ct->chip.irq_set_wake = irq_gc_set_wake;
+		ct->chip.irq_suspend = jz4740_irq_suspend;
+		ct->chip.irq_resume = jz4740_irq_resume;
+
+		irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0,
+				       IRQ_NOPROBE | IRQ_LEVEL);
+	}
 
 	domain = irq_domain_add_legacy(node, num_chips * 32, JZ4740_IRQ_BASE, 0,
 				       &irq_domain_simple_ops, NULL);
@@ -142,4 +157,10 @@ out_free:
 out_err:
 	return err;
 }
-IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
+
+static int __init intc_1chip_of_init(struct device_node *node,
+				     struct device_node *parent)
+{
+	return ingenic_intc_of_init(node, 1);
+}
+IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", intc_1chip_of_init);
-- 
2.4.1
