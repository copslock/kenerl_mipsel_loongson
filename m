Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2017 03:00:56 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:35428
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993301AbdISBA0qObB- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2017 03:00:26 +0200
Received: by mail-qt0-x242.google.com with SMTP id l25so1437433qtf.2
        for <linux-mips@linux-mips.org>; Mon, 18 Sep 2017 18:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jCBliR1Y+ATmklN7eSpv/XggHvhmhHArCeCzpHmAxSk=;
        b=tNXvzSWW98Lv+4LZQTQuwiZ7LG/R9iCsDLgbgXRnmLqOWFzZcN69ZAVcMByiic5444
         dXFMziIzAZMinfgPR6wVsqmMzwbD8jhA7n8Qosu/iH6ftrVEPer790wG4t4ayyRUTl8z
         sr+KlwJ2M/OCiAkydUt0gxiBqEAVFXeUPxsaUv1AfX9KUxTmy17To8V47ixYJa0bmlM8
         Z7nD0NlGFKlB3s42QY7xja0zvCTG1BrxdyQNPXwiHJw/kw3bLkVjNPTmZwJr1V8Z0sPr
         yr4MiTZWNK7abps3etijz267jMdoCtwaeD7mwGHC9kYGao6yBI8n7WoD1HYepo8eOt5I
         yT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jCBliR1Y+ATmklN7eSpv/XggHvhmhHArCeCzpHmAxSk=;
        b=o+RdvOalToZACgG+qzTr7Zl6MEB/7Y5OCqJtRhtJ+jwCfZQqbF+3023w8fHKQ9o188
         bK+QifhPfbVC3eKVhLC1OqA5lBagw49EQjNHhtHwF3VZ6et7WFOtoxO9zxtaZNYSki5w
         lXrON9WfQhVBvgsgbm5+55LLPfkkdYzjBqqcBFS6g/1wIEfqNBZyu/zpFEwZL8p8ji4E
         Q4U/Vre1F1GKJwEbO1AkSFny6yL87TENFOYzrBfMIEHPXEke9psYQU0DfodfjiXuwMcw
         B0pAaI35Wcrlsq5U0NQfWnqnMCo8gFQQzGANAP1Fo+ZxkVVTjBmOtdO1ao8ItJwrClDF
         myaA==
X-Gm-Message-State: AHPjjUhRF2U1ilt3xol/vJEAuBEjiVCfOYGdkVuFE2cvOqJlVIFeIT8Z
        +Lso5Fgp7R92Ew==
X-Google-Smtp-Source: AOwi7QDIBnArCHKL62HndrGTND0ALDqn6MsqbDp3b1sLEObQ17ZTNFo94yqzHfiy8tXxh71iMeasyQ==
X-Received: by 10.200.44.123 with SMTP id e56mr654576qta.308.1505782819663;
        Mon, 18 Sep 2017 18:00:19 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id x39sm6113273qtc.93.2017.09.18.18.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 18:00:19 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Doug Berger <opendmb@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Mans Rullgard <mans@mansr.com>, Mason <slash.tmp@free.fr>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Frias <sf84@laposte.net>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] irqchip: brcmstb-l2: Remove some processing from the handler
Date:   Mon, 18 Sep 2017 17:59:58 -0700
Message-Id: <20170919010000.32072-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170919010000.32072-1-opendmb@gmail.com>
References: <20170919010000.32072-1-opendmb@gmail.com>
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60068
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
acknowledgment of the interrupt so it is redundant to clear it in
brcmstb_l2_intc_irq_handle().

irq_linear_revmap() is a fast path equivalent of irq_find_mapping()
that is appropriate to use for domain controllers of this type.

Defining irq_mask_ack is slightly more efficient than just
implementing irq_mask and irq_ack separately.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 72 ++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index b009b916a292..48bd1a36c7d4 100644
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
@@ -41,25 +41,49 @@
 
 /* L2 intc private data structure */
 struct brcmstb_l2_intc_data {
-	int parent_irq;
-	void __iomem *base;
 	struct irq_domain *domain;
+	struct irq_chip_generic *gc;
 	bool can_wake;
 	u32 saved_mask; /* for suspend/resume */
 };
 
+/**
+ * brcmstb_l2_mask_and_ack - Mask and ack pending interrupt
+ * @d: irq_data
+ *
+ * Chip has separate enable/disable registers instead of a single mask
+ * register and pending interrupt is acknowledged by setting a bit.
+ *
+ * Note: This function is generic and could easily be added to the
+ * generic irqchip implementation if there ever becomes a will to do so.
+ * Perhaps with a name like irq_gc_mask_disable_and_ack_set().
+ *
+ * e.g.: https://patchwork.kernel.org/patch/9831047/
+ */
+static void brcmstb_l2_mask_and_ack(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	irq_reg_writel(gc, mask, ct->regs.disable);
+	*ct->mask_cache &= ~mask;
+	irq_reg_writel(gc, mask, ct->regs.ack);
+	irq_gc_unlock(gc);
+}
+
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
@@ -70,10 +94,8 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 
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
@@ -116,32 +138,33 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
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
@@ -170,18 +193,19 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
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
+	ct->chip.irq_mask_ack = brcmstb_l2_mask_and_ack;
 	ct->regs.disable = CPU_MASK_SET;
 
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
@@ -195,19 +219,19 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
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
2.14.1
