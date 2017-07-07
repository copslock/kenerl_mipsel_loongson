Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 21:22:25 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:35907
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993951AbdGGTVeVBnbc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 21:21:34 +0200
Received: by mail-qk0-x244.google.com with SMTP id v143so5498669qkb.3
        for <linux-mips@linux-mips.org>; Fri, 07 Jul 2017 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aTkAaqRGq5oh0oJ+ZjE8NanEOZe69UMIegpV63f62yw=;
        b=dDAHredY6nJe1NwDqWoqsRF4avvltydLbx1RKSpZSkJ+1Z/DN6pfMJVEGgSqJcSnqL
         CRhowP01vd2w4XEaknEFw326YbhvTxU9ASeBN05He7tj0CVjaAw/jLIbyJaK3WfbSkDF
         eQqB6KvrPdO+W/5Pv7y3NpiJYXOY20PZFsGEWI1S/A+S9NzUjRNYTfPQpws0+YkAUkXW
         dy8kPQ2pz1dpnzGnduCx9ymnK+ymcefjR6jgLzqDmsEnta6mxlZLqur+Ff6aYMjWvk4s
         L6KfkdklUU9eCDEpe7LXCp+ild1SfjRjR9pWRGzusFqJRLthKK2Qub1HzKZWO8vcgWQc
         loiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aTkAaqRGq5oh0oJ+ZjE8NanEOZe69UMIegpV63f62yw=;
        b=g405ibdCWWqyz/q6lMZGfoMMiwr8Lc4anOs3fAFCHkm2YtKDVzV1iy9+TMqoad+FM8
         z0pWBN4bBzKxn8XAQRo+/0biqJyGiKJdHjHgYQLPxS9XIwpgXPhWdOFt6/PIyn9X6H2l
         G1NlM2AHAHIvQVUUGYsuz0CqZFuRfvHGHl5XcEL+1GzDHUGsPLQLSM/Qnv063lxtL3KB
         eucmzc+xAHxQzMPv2Fu/qRbC36oDomligFjgmlmIAhAGVDfojzb0orCieFmdgY1uxBkN
         /EwSJSXMrC1mqwLpexNVAh+xCQsNZGAwU1HYHTC4gnpAzTGOVhC0FaNTrgNNz71Zapr+
         XeEQ==
X-Gm-Message-State: AKS2vOxhLomVJLPMeEaCRabLUwX1LkOq38zBOwVeds1+rCalSOkdqNSv
        boQls1+bU/Z26Q==
X-Received: by 10.55.134.69 with SMTP id i66mr63817694qkd.33.1499455288512;
        Fri, 07 Jul 2017 12:21:28 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id n8sm3437132qtc.5.2017.07.07.12.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 12:21:27 -0700 (PDT)
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
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-mips@linux-mips.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 6/6] irqchip: brcmstb-l2: Add support for the BCM7271 L2 controller
Date:   Fri,  7 Jul 2017 12:20:16 -0700
Message-Id: <20170707192016.13001-7-opendmb@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170707192016.13001-1-opendmb@gmail.com>
References: <20170707192016.13001-1-opendmb@gmail.com>
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59062
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
index ce3850530e2b..f77e6c9530dc 100644
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
@@ -102,7 +123,7 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	struct brcmstb_l2_intc_data *b = gc->private;
 
 	irq_gc_lock(gc);
-	if (ct->chip.irq_ack != irq_gc_noop) {
+	if (ct->chip.irq_ack) {
 		/* Clear unmasked non-wakeup interrupts */
 		irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active,
 				ct->regs.ack);
@@ -115,7 +136,9 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 }
 
 static int __init brcmstb_l2_intc_of_init(struct device_node *np,
-					  struct device_node *parent)
+					  struct device_node *parent,
+					  const struct brcmstb_intc_init_params
+					  *init_params)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct brcmstb_l2_intc_data *data;
@@ -137,12 +160,12 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
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
@@ -167,7 +190,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 
 	/* Allocate a single Generic IRQ chip for this node */
 	ret = irq_alloc_domain_generic_chips(data->domain, 32, 1,
-				np->full_name, handle_edge_irq, clr, 0, flags);
+			np->full_name, init_params->handler, clr, 0, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
@@ -180,21 +203,26 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
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
+		ct->chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
+	} else {
+		/* No Ack - but still slightly more efficient to define this */
+		ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
+	}
 
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
-	ct->chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
-	ct->regs.disable = CPU_MASK_SET;
-	ct->regs.mask = CPU_MASK_STATUS;
+	ct->regs.disable = init_params->cpu_mask_set;
+	ct->regs.mask = init_params->cpu_mask_status;
 
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
-	ct->regs.enable = CPU_MASK_CLEAR;
+	ct->regs.enable = init_params->cpu_mask_clear;
 
 	ct->chip.irq_suspend = brcmstb_l2_intc_suspend;
 	ct->chip.irq_resume = brcmstb_l2_intc_resume;
@@ -220,4 +248,18 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
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
2.13.0
