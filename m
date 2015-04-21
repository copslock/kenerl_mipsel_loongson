Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 16:53:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64441 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025949AbbDUOxEotZMh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 16:53:04 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CD00CF94C0765
        for <linux-mips@linux-mips.org>; Tue, 21 Apr 2015 15:52:57 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Apr 2015 15:53:00 +0100
Received: from localhost (192.168.159.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 21 Apr
 2015 15:52:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 19/37] MIPS: JZ4740: avoid JZ4740-specific naming
Date:   Tue, 21 Apr 2015 15:46:46 +0100
Message-ID: <1429627624-30525-20-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.67]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46976
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

Rename the functions including jz4740 in their names to be more generic
in preparation for supporting further SoCs, and for moving this
interrupt controller code to drivers/irqchip.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v3:
  - New patch.
---
 arch/mips/jz4740/gpio.c |  4 ++--
 arch/mips/jz4740/irq.c  | 24 ++++++++++++------------
 arch/mips/jz4740/irq.h  |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 00b798d..994a7df 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -442,8 +442,8 @@ static void jz4740_gpio_chip_init(struct jz_gpio_chip *chip, unsigned int id)
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_unmask = jz_gpio_irq_unmask;
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
-	ct->chip.irq_suspend = jz4740_irq_suspend;
-	ct->chip.irq_resume = jz4740_irq_resume;
+	ct->chip.irq_suspend = ingenic_intc_irq_suspend;
+	ct->chip.irq_resume = ingenic_intc_irq_resume;
 	ct->chip.irq_startup = jz_gpio_irq_startup;
 	ct->chip.irq_shutdown = jz_gpio_irq_shutdown;
 	ct->chip.irq_set_type = jz_gpio_irq_set_type;
diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 58fe64f..65b27c8 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -43,7 +43,7 @@ struct ingenic_intc_data {
 #define JZ_REG_INTC_PENDING	0x10
 #define CHIP_SIZE		0x20
 
-static irqreturn_t jz4740_cascade(int irq, void *data)
+static irqreturn_t intc_cascade(int irq, void *data)
 {
 	struct ingenic_intc_data *intc = irq_get_handler_data(irq);
 	uint32_t irq_reg;
@@ -61,7 +61,7 @@ static irqreturn_t jz4740_cascade(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void jz4740_irq_set_mask(struct irq_chip_generic *gc, uint32_t mask)
+static void intc_irq_set_mask(struct irq_chip_generic *gc, uint32_t mask)
 {
 	struct irq_chip_regs *regs = &gc->chip_types->regs;
 
@@ -69,21 +69,21 @@ static void jz4740_irq_set_mask(struct irq_chip_generic *gc, uint32_t mask)
 	writel(~mask, gc->reg_base + regs->disable);
 }
 
-void jz4740_irq_suspend(struct irq_data *data)
+void ingenic_intc_irq_suspend(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	jz4740_irq_set_mask(gc, gc->wake_active);
+	intc_irq_set_mask(gc, gc->wake_active);
 }
 
-void jz4740_irq_resume(struct irq_data *data)
+void ingenic_intc_irq_resume(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	jz4740_irq_set_mask(gc, gc->mask_cache);
+	intc_irq_set_mask(gc, gc->mask_cache);
 }
 
-static struct irqaction jz4740_cascade_action = {
-	.handler = jz4740_cascade,
-	.name = "JZ4740 cascade interrupt",
+static struct irqaction intc_cascade_action = {
+	.handler = intc_cascade,
+	.name = "SoC intc cascade interrupt",
 };
 
 static int __init ingenic_intc_of_init(struct device_node *node,
@@ -134,8 +134,8 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		ct->chip.irq_mask = irq_gc_mask_disable_reg;
 		ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
 		ct->chip.irq_set_wake = irq_gc_set_wake;
-		ct->chip.irq_suspend = jz4740_irq_suspend;
-		ct->chip.irq_resume = jz4740_irq_resume;
+		ct->chip.irq_suspend = ingenic_intc_irq_suspend;
+		ct->chip.irq_resume = ingenic_intc_irq_resume;
 
 		irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0,
 				       IRQ_NOPROBE | IRQ_LEVEL);
@@ -150,7 +150,7 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 	if (err)
 		goto out;
 
-	setup_irq(parent_irq, &jz4740_cascade_action);
+	setup_irq(parent_irq, &intc_cascade_action);
 out:
 	return err;
 }
diff --git a/arch/mips/jz4740/irq.h b/arch/mips/jz4740/irq.h
index 0f48720..601d527 100644
--- a/arch/mips/jz4740/irq.h
+++ b/arch/mips/jz4740/irq.h
@@ -17,7 +17,7 @@
 
 #include <linux/irq.h>
 
-extern void jz4740_irq_suspend(struct irq_data *data);
-extern void jz4740_irq_resume(struct irq_data *data);
+extern void ingenic_intc_irq_suspend(struct irq_data *data);
+extern void ingenic_intc_irq_resume(struct irq_data *data);
 
 #endif
-- 
2.3.5
