Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 15:23:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30856 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026035AbbDXNXDpJUST (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2015 15:23:03 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 553E43CC3295A;
        Fri, 24 Apr 2015 14:22:57 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 24 Apr 2015 14:22:59 +0100
Received: from localhost (192.168.159.76) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 24 Apr
 2015 14:22:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v4 15/37] MIPS: JZ4740: remove jz_intc_base global
Date:   Fri, 24 Apr 2015 14:17:15 +0100
Message-ID: <1429881457-16016-16-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.76]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47049
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

Avoid the need for the global variable jz_intc_base by introducing a
struct ingenic_intc_data and passing it around as the IRQ handler data.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Changes in v4:
  - None.

Changes in v3:
  - New patch.
---
 arch/mips/jz4740/irq.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 615eaa8..498ff28 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -32,7 +32,9 @@
 
 #include "../../drivers/irqchip/irqchip.h"
 
-static void __iomem *jz_intc_base;
+struct ingenic_intc_data {
+	void __iomem *base;
+};
 
 #define JZ_REG_INTC_STATUS	0x00
 #define JZ_REG_INTC_MASK	0x04
@@ -42,9 +44,10 @@ static void __iomem *jz_intc_base;
 
 static irqreturn_t jz4740_cascade(int irq, void *data)
 {
+	struct ingenic_intc_data *intc = irq_get_handler_data(irq);
 	uint32_t irq_reg;
 
-	irq_reg = readl(jz_intc_base + JZ_REG_INTC_PENDING);
+	irq_reg = readl(intc->base + JZ_REG_INTC_PENDING);
 
 	if (irq_reg)
 		generic_handle_irq(__fls(irq_reg) + JZ4740_IRQ_BASE);
@@ -80,21 +83,30 @@ static struct irqaction jz4740_cascade_action = {
 static int __init jz4740_intc_of_init(struct device_node *node,
 	struct device_node *parent)
 {
+	struct ingenic_intc_data *intc;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	struct irq_domain *domain;
-	int parent_irq;
+	int parent_irq, err = 0;
+
+	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
+	if (!intc) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	parent_irq = irq_of_parse_and_map(node, 0);
-	if (!parent_irq)
-		return -EINVAL;
+	if (!parent_irq) {
+		err = -EINVAL;
+		goto out;
+	}
 
-	jz_intc_base = ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
+	intc->base = ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
 
 	/* Mask all irqs */
-	writel(0xffffffff, jz_intc_base + JZ_REG_INTC_SET_MASK);
+	writel(0xffffffff, intc->base + JZ_REG_INTC_SET_MASK);
 
-	gc = irq_alloc_generic_chip("INTC", 1, JZ4740_IRQ_BASE, jz_intc_base,
+	gc = irq_alloc_generic_chip("INTC", 1, JZ4740_IRQ_BASE, intc->base,
 		handle_level_irq);
 
 	gc->wake_enabled = IRQ_MSK(32);
@@ -116,7 +128,12 @@ static int __init jz4740_intc_of_init(struct device_node *node,
 	if (!domain)
 		pr_warn("unable to register IRQ domain\n");
 
+	err = irq_set_handler_data(parent_irq, intc);
+	if (err)
+		goto out;
+
 	setup_irq(parent_irq, &jz4740_cascade_action);
-	return 0;
+out:
+	return err;
 }
 IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
-- 
2.3.5
