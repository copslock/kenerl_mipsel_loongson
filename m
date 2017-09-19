Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2017 03:01:43 +0200 (CEST)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:38009
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdISBAa35Qb- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2017 03:00:30 +0200
Received: by mail-qt0-x241.google.com with SMTP id f24so1426707qte.5
        for <linux-mips@linux-mips.org>; Mon, 18 Sep 2017 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47VLoFVfcT2CJeQ5++WDmMldt86rKmTC1LUYRtnBxrU=;
        b=qFvHb5wcCd29wlCfw6pvqocMVG+FKqUGmhsXZaDvFDonQaBhTHkjbmZ/aspCUIAsIl
         2CUlwA1ESmkY2CLu+pSyb2R8zLWROBOYieSLWFKw+mL4Z8YF+S6XLSWFM9CXSzeKHbFX
         wuWdDdglvaOHEu6UxfhylZrpROXsaOj5xToLsz9QgyzeAGyNFtsu8OyaobkrJdkXSkAQ
         pSrWoMP4GElFkediYdD2IPEa8uFvuOOLqPuvHHJcvTRa/2OKOk6RN5nFG7V/Lgn3JT23
         7MRHNDnTHnnQbrTjn2UV2mr4wLL8+a/W4MZEIU5QqmYwAs5m47sIXcqdNC78g6DGiXxa
         YxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47VLoFVfcT2CJeQ5++WDmMldt86rKmTC1LUYRtnBxrU=;
        b=juNjqWJfk2i3wiAIbl3FgY6OV1qi5UQK1r9p/c9RpSZw80TfouCSILtMRHwxkKeI6k
         2fBNbzUp++OVSiKOIBsQYvf1gS4U0IQ9VFSMNGhBI3/7jKLAmlBUGlaxVG1owroHgqhH
         yMxRNzaENQbwGXvH6macJo7LFUV7AbkeNGfrw8ZFkRpIGRBmVVrTs6h6CJAvp93pXCh/
         BxzPYG8FDK+DWe9heGkywKLc4TZF6eu012bBACuHxhc7cweAjgohxGih7uCD5GUs7uxU
         6EffQeL6GtTkF+iwsMDFAzj+ufBsQj4Vsa9PVMLCOS4S6kQY0z2BEZbBCYkTyXAScdzN
         kX1Q==
X-Gm-Message-State: AHPjjUhBsIsxdrzcphgW6Tjs7k4o6Cafr/cXECkQdGDefuK17A6pt6lj
        Trc4QuFtR9SHkA==
X-Google-Smtp-Source: AOwi7QB6aB72ySjszYPFuI1ZbiBK3PeWjlrBiTFSOYNM2VoGYUM451CoyQxSBpj1mReldwswNcsdcg==
X-Received: by 10.200.41.232 with SMTP id 37mr5462874qtt.47.1505782824489;
        Mon, 18 Sep 2017 18:00:24 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id x39sm6113273qtc.93.2017.09.18.18.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 18:00:23 -0700 (PDT)
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
Subject: [PATCH v4 3/3] irqchip: brcmstb-l2: Add support for the BCM7271 L2 controller
Date:   Mon, 18 Sep 2017 18:00:00 -0700
Message-Id: <20170919010000.32072-4-opendmb@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170919010000.32072-1-opendmb@gmail.com>
References: <20170919010000.32072-1-opendmb@gmail.com>
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60070
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

Add the initialization of the generic irq chip for the BCM7271 L2
interrupt controller.  This controller only supports level
interrupts and uses the "brcm,bcm7271-l2-intc" compatibility
string.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../bindings/interrupt-controller/brcm,l2-intc.txt |  3 +-
 drivers/irqchip/irq-brcmstb-l2.c                   | 86 ++++++++++++++++------
 2 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
index 448273a30a11..36df06c5c567 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
@@ -2,7 +2,8 @@ Broadcom Generic Level 2 Interrupt Controller
 
 Required properties:
 
-- compatible: should be "brcm,l2-intc"
+- compatible: should be "brcm,l2-intc" for latched interrupt controllers
+              should be "brcm,bcm7271-l2-intc" for level interrupt controllers
 - reg: specifies the base physical address and size of the registers
 - interrupt-controller: identifies the node as an interrupt controller
 - #interrupt-cells: specifies the number of cells needed to encode an
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 8d54cd7a090d..691d20eb0bec 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -31,13 +31,34 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 
-/* Register offsets in the L2 interrupt controller */
-#define CPU_STATUS	0x00
-#define CPU_SET		0x04
-#define CPU_CLEAR	0x08
-#define CPU_MASK_STATUS	0x0c
-#define CPU_MASK_SET	0x10
-#define CPU_MASK_CLEAR	0x14
+struct brcmstb_intc_init_params {
+	irq_flow_handler_t handler;
+	int cpu_status;
+	int cpu_clear;
+	int cpu_mask_status;
+	int cpu_mask_set;
+	int cpu_mask_clear;
+};
+
+/* Register offsets in the L2 latched interrupt controller */
+static const struct brcmstb_intc_init_params l2_edge_intc_init = {
+	.handler		= handle_edge_irq,
+	.cpu_status		= 0x00,
+	.cpu_clear		= 0x08,
+	.cpu_mask_status	= 0x0c,
+	.cpu_mask_set		= 0x10,
+	.cpu_mask_clear		= 0x14
+};
+
+/* Register offsets in the L2 level interrupt controller */
+static const struct brcmstb_intc_init_params l2_lvl_intc_init = {
+	.handler		= handle_level_irq,
+	.cpu_status		= 0x00,
+	.cpu_clear		= -1, /* Register not present */
+	.cpu_mask_status	= 0x04,
+	.cpu_mask_set		= 0x08,
+	.cpu_mask_clear		= 0x0C
+};
 
 /* L2 intc private data structure */
 struct brcmstb_l2_intc_data {
@@ -128,7 +149,7 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	struct brcmstb_l2_intc_data *b = gc->private;
 
 	irq_gc_lock(gc);
-	if (ct->chip.irq_ack != irq_gc_noop) {
+	if (ct->chip.irq_ack) {
 		/* Clear unmasked non-wakeup interrupts */
 		irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active,
 				ct->regs.ack);
@@ -141,7 +162,9 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 }
 
 static int __init brcmstb_l2_intc_of_init(struct device_node *np,
-					  struct device_node *parent)
+					  struct device_node *parent,
+					  const struct brcmstb_intc_init_params
+					  *init_params)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct brcmstb_l2_intc_data *data;
@@ -163,12 +186,12 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	}
 
 	/* Disable all interrupts by default */
-	writel(0xffffffff, base + CPU_MASK_SET);
+	writel(0xffffffff, base + init_params->cpu_mask_set);
 
 	/* Wakeup interrupts may be retained from S5 (cold boot) */
 	data->can_wake = of_property_read_bool(np, "brcm,irq-can-wake");
-	if (!data->can_wake)
-		writel(0xffffffff, base + CPU_CLEAR);
+	if (!data->can_wake && (init_params->cpu_clear >= 0))
+		writel(0xffffffff, base + init_params->cpu_clear);
 
 	parent_irq = irq_of_parse_and_map(np, 0);
 	if (!parent_irq) {
@@ -193,7 +216,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 
 	/* Allocate a single Generic IRQ chip for this node */
 	ret = irq_alloc_domain_generic_chips(data->domain, 32, 1,
-				np->full_name, handle_edge_irq, clr, 0, flags);
+			np->full_name, init_params->handler, clr, 0, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
@@ -206,21 +229,26 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	data->gc = irq_get_domain_generic_chip(data->domain, 0);
 	data->gc->reg_base = base;
 	data->gc->private = data;
-	data->status_offset = CPU_STATUS;
-	data->mask_offset = CPU_MASK_STATUS;
+	data->status_offset = init_params->cpu_status;
+	data->mask_offset = init_params->cpu_mask_status;
 
 	ct = data->gc->chip_types;
 
-	ct->chip.irq_ack = irq_gc_ack_set_bit;
-	ct->regs.ack = CPU_CLEAR;
+	if (init_params->cpu_clear >= 0) {
+		ct->regs.ack = init_params->cpu_clear;
+		ct->chip.irq_ack = irq_gc_ack_set_bit;
+		ct->chip.irq_mask_ack = brcmstb_l2_mask_and_ack;
+	} else {
+		/* No Ack - but still slightly more efficient to define this */
+		ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
+	}
 
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
-	ct->chip.irq_mask_ack = brcmstb_l2_mask_and_ack;
-	ct->regs.disable = CPU_MASK_SET;
-	ct->regs.mask = CPU_MASK_STATUS;
+	ct->regs.disable = init_params->cpu_mask_set;
+	ct->regs.mask = init_params->cpu_mask_status;
 
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
-	ct->regs.enable = CPU_MASK_CLEAR;
+	ct->regs.enable = init_params->cpu_mask_clear;
 
 	ct->chip.irq_suspend = brcmstb_l2_intc_suspend;
 	ct->chip.irq_resume = brcmstb_l2_intc_resume;
@@ -247,4 +275,18 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	kfree(data);
 	return ret;
 }
-IRQCHIP_DECLARE(brcmstb_l2_intc, "brcm,l2-intc", brcmstb_l2_intc_of_init);
+
+int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
+	struct device_node *parent)
+{
+	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
+}
+IRQCHIP_DECLARE(brcmstb_l2_intc, "brcm,l2-intc", brcmstb_l2_edge_intc_of_init);
+
+int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
+	struct device_node *parent)
+{
+	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
+}
+IRQCHIP_DECLARE(bcm7271_l2_intc, "brcm,bcm7271-l2-intc",
+	brcmstb_l2_lvl_intc_of_init);
-- 
2.14.1
