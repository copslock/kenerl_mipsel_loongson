Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 21:21:36 +0200 (CEST)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:35903
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993949AbdGGTV3ZUVjc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 21:21:29 +0200
Received: by mail-qk0-x243.google.com with SMTP id v143so5498384qkb.3
        for <linux-mips@linux-mips.org>; Fri, 07 Jul 2017 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T5jf8G+lnq8o0tri4tvQsJ0XM4zbkm5FyZPC+05Ch44=;
        b=AFKUOuP/7U1LLSRpwUJ1uODCT8uCsdB7noPH/R83Opik9fMQTJ3fo1H9arSIH+vRDQ
         RZe0e02hUB1JfdzyGS1mStgWuwfmoIvCL9ib5qy+4pFfSr4hDMVgf38f+Si8G4kgCToA
         J4tGOGDSrHMHDLisE9zGxbO2+RN0ONOIhtLPKYGvStIzcoNL3ul+K1scqR0fPRPKTd9+
         qOqFvGgB6x5Iw6OANGPAhBfvWi4/hrWiaAR0Ki/hUsAcAjfoBifanTdjfiorfRbYvlje
         eutBp27aGLp5lfC5KYEu9Q6wbP6qpP0tfUEWUu9mEZ9LWn8qOiFf3zDAjrJhL73qtGOD
         eX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T5jf8G+lnq8o0tri4tvQsJ0XM4zbkm5FyZPC+05Ch44=;
        b=GYxU/x3XgdYIIDGpWccmP/NWe341Vd+Gv9W7wc4aa3TEQyzGdEj+9S6sWbRA6H0cbF
         /e1qnDG9hk+G0st843GLt3VVW8+qK0LEHT7CVexCAzn+ToI8cv+ZhrBbdY+DHkw95LKz
         zNJv1PLfHbWxWrZyt+cY6r2uRJvssAs4uwlLmcNWNVeLEei7WmLtgJUL3LQCE6uXePVT
         se9IxPY+4Z0RjX1gSLjqEaMAeUTCK8KNgw/ewMn9zKUS2gVvB6oIM8g01GDMNTJ5C7mw
         t8JVGcJdoldR9TQMcg1bLBfVJZR6RQbLS1zzJf8DWhG9KfDI1/SyvVRdh21L99OIqKr7
         Ykeg==
X-Gm-Message-State: AIVw112X0c9Zixfb19f0vhnV7ixSuKQnIlLNkkJNJukusWvjfaEELHUD
        xuhJrUAYx4kltg==
X-Received: by 10.55.38.149 with SMTP id m21mr18301880qkm.39.1499455283575;
        Fri, 07 Jul 2017 12:21:23 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id n8sm3437132qtc.5.2017.07.07.12.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 12:21:22 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Doug Berger <opendmb@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-mips@linux-mips.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 4/6] irqchip: brcmstb-l2: Remove some processing from the handler
Date:   Fri,  7 Jul 2017 12:20:14 -0700
Message-Id: <20170707192016.13001-5-opendmb@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170707192016.13001-1-opendmb@gmail.com>
References: <20170707192016.13001-1-opendmb@gmail.com>
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opendmb@gmail.com
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

Saving the generic chip pointer in the brcmstb_l2_intc_data prevents
the need to call irq_get_domain_generic_chip().  Also don't need to
save parent_irq and base there since local variables in the
brcmstb_l2_intc_of_init() function are just as good.

The handle_edge_irq flow or chained_irq_enter takes care of the
acknowledgement of the interrupt so it is redundant to clear it in
brcmstb_l2_intc_irq_handle().

irq_linear_revmap() is a fast path equivalent of irq_find_mapping()
that is appropriate to use for domain controllers of this type.

Defining irq_mask_ack is slightly more efficient than just
implementing irq_mask and irq_ack seperately.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 46 +++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index bddf169c4b37..977ae55d47d4 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -1,7 +1,7 @@
 /*
  * Generic Broadcom Set Top Box Level 2 Interrupt controller driver
  *
- * Copyright (C) 2014 Broadcom Corporation
+ * Copyright (C) 2014-2017 Broadcom
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -41,9 +41,8 @@
 
 /* L2 intc private data structure */
 struct brcmstb_l2_intc_data {
-	int parent_irq;
-	void __iomem *base;
 	struct irq_domain *domain;
+	struct irq_chip_generic *gc;
 	bool can_wake;
 	u32 saved_mask; /* for suspend/resume */
 };
@@ -51,15 +50,14 @@ struct brcmstb_l2_intc_data {
 static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 {
 	struct brcmstb_l2_intc_data *b = irq_desc_get_handler_data(desc);
-	struct irq_chip_generic *gc = irq_get_domain_generic_chip(b->domain, 0);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int irq;
 	u32 status;
 
 	chained_irq_enter(chip, desc);
 
-	status = irq_reg_readl(gc, CPU_STATUS) &
-		~(irq_reg_readl(gc, CPU_MASK_STATUS));
+	status = irq_reg_readl(b->gc, CPU_STATUS) &
+		~(irq_reg_readl(b->gc, CPU_MASK_STATUS));
 
 	if (status == 0) {
 		raw_spin_lock(&desc->lock);
@@ -70,10 +68,8 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 
 	do {
 		irq = ffs(status) - 1;
-		/* ack at our level */
-		irq_reg_writel(gc, 1 << irq, CPU_CLEAR);
 		status &= ~(1 << irq);
-		generic_handle_irq(irq_find_mapping(b->domain, irq));
+		generic_handle_irq(irq_linear_revmap(b->domain, irq));
 	} while (status);
 out:
 	chained_irq_exit(chip, desc);
@@ -116,32 +112,33 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct brcmstb_l2_intc_data *data;
-	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	int ret;
 	unsigned int flags;
+	int parent_irq;
+	void __iomem *base;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->base = of_iomap(np, 0);
-	if (!data->base) {
+	base = of_iomap(np, 0);
+	if (!base) {
 		pr_err("failed to remap intc L2 registers\n");
 		ret = -ENOMEM;
 		goto out_free;
 	}
 
 	/* Disable all interrupts by default */
-	writel(0xffffffff, data->base + CPU_MASK_SET);
+	writel(0xffffffff, base + CPU_MASK_SET);
 
 	/* Wakeup interrupts may be retained from S5 (cold boot) */
 	data->can_wake = of_property_read_bool(np, "brcm,irq-can-wake");
 	if (!data->can_wake)
-		writel(0xffffffff, data->base + CPU_CLEAR);
+		writel(0xffffffff, base + CPU_CLEAR);
 
-	data->parent_irq = irq_of_parse_and_map(np, 0);
-	if (!data->parent_irq) {
+	parent_irq = irq_of_parse_and_map(np, 0);
+	if (!parent_irq) {
 		pr_err("failed to find parent interrupt\n");
 		ret = -EINVAL;
 		goto out_unmap;
@@ -170,18 +167,19 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	}
 
 	/* Set the IRQ chaining logic */
-	irq_set_chained_handler_and_data(data->parent_irq,
+	irq_set_chained_handler_and_data(parent_irq,
 					 brcmstb_l2_intc_irq_handle, data);
 
-	gc = irq_get_domain_generic_chip(data->domain, 0);
-	gc->reg_base = data->base;
-	gc->private = data;
-	ct = gc->chip_types;
+	data->gc = irq_get_domain_generic_chip(data->domain, 0);
+	data->gc->reg_base = base;
+	data->gc->private = data;
+	ct = data->gc->chip_types;
 
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
 	ct->regs.ack = CPU_CLEAR;
 
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
+	ct->chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
 	ct->regs.disable = CPU_MASK_SET;
 
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
@@ -194,19 +192,19 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		/* This IRQ chip can wake the system, set all child interrupts
 		 * in wake_enabled mask
 		 */
-		gc->wake_enabled = 0xffffffff;
+		data->gc->wake_enabled = 0xffffffff;
 		ct->chip.irq_set_wake = irq_gc_set_wake;
 	}
 
 	pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
-			data->base, data->parent_irq);
+			base, parent_irq);
 
 	return 0;
 
 out_free_domain:
 	irq_domain_remove(data->domain);
 out_unmap:
-	iounmap(data->base);
+	iounmap(base);
 out_free:
 	kfree(data);
 	return ret;
-- 
2.13.0
