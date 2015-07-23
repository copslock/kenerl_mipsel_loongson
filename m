Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2015 00:54:31 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36006 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010566AbbGWWy3yTQfx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2015 00:54:29 +0200
Received: by pdjr16 with SMTP id r16so3169033pdj.3
        for <linux-mips@linux-mips.org>; Thu, 23 Jul 2015 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+H3jUXyWsr+D8AWA/w5cjbVWcIteqHFZRBi6XgMpD78=;
        b=vtf6PVt1IufzEof/m2gfhkH+1J0EV0cOTsRCbmRMDvomr0/6vKAt+7EsLsRTBCwOCs
         12LIqgL0Dl+8YqhMyylvkeOCOX2Ht63skJgXipQxGddvtndxQDPFhbNOpAOOYBMab98W
         W8Rwqrl57QQy+dXdWP1ixb/hJp0Kb70f0Cu188kAXa2asyJayAyK4U306CBZhhi9OK4d
         Ct2eQ0wOvGXQmDlimo81MqX7uHne0wSscX5XESfy0TyyvJsiD9tMZK6ejlM3tToizQVr
         4agX2P35eEBgOcw3K+2UCG4E1WgTFCUu8WNYmsntoay/H5aJXTNICQgySpp2q+cWE6Ft
         kjmg==
X-Received: by 10.70.7.162 with SMTP id k2mr23346175pda.128.1437692063790;
        Thu, 23 Jul 2015 15:54:23 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id y2sm786623pdi.80.2015.07.23.15.54.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 15:54:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, cernekee@gmail.com,
        jason@lakedaemon.net, tglx@linutronix.de,
        bcm-kernel-feedback-list@broadcom.com, gregory.0xf0@gmail.com,
        computersforpeace@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] irqchip: bcm7120-l2: Fix interrupt status for multiple parent IRQs
Date:   Thu, 23 Jul 2015 15:52:21 -0700
Message-Id: <1437691941-3100-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Our irq-bcm7120-l2 interrupt controller driver utilizes the same handler
function for the different parent interrupts it services: UPG_MAIN, UPG_BSC for
instance.

The problem is that function reads the IRQSTAT register which can combine
interrupt causes for different parent interrupts, such that we can end-up in
the following situation:

- CPU takes an interrupt
- bcm7120_l2_intc_irq_handle() reads IRQSTAT
- generic_handle_irq() is invoked
- there are still pending interrupts flagged in IRQSTAT from a different parent
- handle_bad_irq() is invoked for these since they come from a different irq_desc/irq

In order to fix this, make sure that we always mask IRQSTAT with the
appropriate bits that correspond go the parent interrupt source this is coming
from. To simplify things, associate an unique structure per parent interrupt
handler to avoid multiplying the number of lookups.

Fixes: a5042de2688d ("irqchip: bcm7120-l2: Add Broadcom BCM7120-style Level 2 interrupt controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 51 ++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 3ba5cc780fcb..8302d45d13ac 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -47,14 +47,20 @@ struct bcm7120_l2_intc_data {
 	struct irq_domain *domain;
 	bool can_wake;
 	u32 irq_fwd_mask[MAX_WORDS];
-	u32 irq_map_mask[MAX_WORDS];
+	struct bcm7120_l1_intc_data *l1_data;
 	int num_parent_irqs;
 	const __be32 *map_mask_prop;
 };
 
+struct bcm7120_l1_intc_data {
+	struct bcm7120_l2_intc_data *b;
+	u32 irq_map_mask[MAX_WORDS];
+};
+
 static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 {
-	struct bcm7120_l2_intc_data *b = irq_desc_get_handler_data(desc);
+	struct bcm7120_l1_intc_data *data = irq_desc_get_handler_data(desc);
+	struct bcm7120_l2_intc_data *b = data->b;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int idx;
 
@@ -69,7 +75,8 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 
 		irq_gc_lock(gc);
 		pending = irq_reg_readl(gc, b->stat_offset[idx]) &
-					    gc->mask_cache;
+					    gc->mask_cache &
+					    data->irq_map_mask[idx];
 		irq_gc_unlock(gc);
 
 		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
@@ -107,8 +114,9 @@ static void bcm7120_l2_intc_resume(struct irq_data *d)
 
 static int bcm7120_l2_intc_init_one(struct device_node *dn,
 					struct bcm7120_l2_intc_data *data,
-					int irq)
+					int irq, u32 *valid_mask)
 {
+	struct bcm7120_l1_intc_data *l1_data = &data->l1_data[irq];
 	int parent_irq;
 	unsigned int idx;
 
@@ -120,18 +128,27 @@ static int bcm7120_l2_intc_init_one(struct device_node *dn,
 
 	/* For multiple parent IRQs with multiple words, this looks like:
 	 * <irq0_w0 irq0_w1 irq1_w0 irq1_w1 ...>
+	 *
+	 * We need to associate a given parent interrupt with its corresponding
+	 * map_mask in order to mask the status register with it because we
+	 * have the same handler being called for multiple parent interrupts.
+	 *
+	 * This is typically something needed on BCM7xxx (STB chips).
 	 */
 	for (idx = 0; idx < data->n_words; idx++) {
 		if (data->map_mask_prop) {
-			data->irq_map_mask[idx] |=
+			l1_data->irq_map_mask[idx] |=
 				be32_to_cpup(data->map_mask_prop +
 					     irq * data->n_words + idx);
 		} else {
-			data->irq_map_mask[idx] = 0xffffffff;
+			l1_data->irq_map_mask[idx] = 0xffffffff;
 		}
+		valid_mask[idx] |= l1_data->irq_map_mask[idx];
 	}
 
-	irq_set_handler_data(parent_irq, data);
+	l1_data->b = data;
+
+	irq_set_handler_data(parent_irq, l1_data);
 	irq_set_chained_handler(parent_irq, bcm7120_l2_intc_irq_handle);
 
 	return 0;
@@ -214,6 +231,7 @@ int __init bcm7120_l2_intc_probe(struct device_node *dn,
 	struct irq_chip_type *ct;
 	int ret = 0;
 	unsigned int idx, irq, flags;
+	u32 valid_mask[MAX_WORDS] = { };
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -226,9 +244,16 @@ int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		goto out_unmap;
 	}
 
+	data->l1_data = kcalloc(data->num_parent_irqs, sizeof(*data->l1_data),
+				GFP_KERNEL);
+	if (!data->l1_data) {
+		ret = -ENOMEM;
+		goto out_free_l1_data;
+	}
+
 	ret = iomap_regs_fn(dn, data);
 	if (ret < 0)
-		goto out_unmap;
+		goto out_free_l1_data;
 
 	for (idx = 0; idx < data->n_words; idx++) {
 		__raw_writel(data->irq_fwd_mask[idx],
@@ -237,16 +262,16 @@ int __init bcm7120_l2_intc_probe(struct device_node *dn,
 	}
 
 	for (irq = 0; irq < data->num_parent_irqs; irq++) {
-		ret = bcm7120_l2_intc_init_one(dn, data, irq);
+		ret = bcm7120_l2_intc_init_one(dn, data, irq, valid_mask);
 		if (ret)
-			goto out_unmap;
+			goto out_free_l1_data;
 	}
 
 	data->domain = irq_domain_add_linear(dn, IRQS_PER_WORD * data->n_words,
 					     &irq_generic_chip_ops, NULL);
 	if (!data->domain) {
 		ret = -ENOMEM;
-		goto out_unmap;
+		goto out_free_l1_data;
 	}
 
 	/* MIPS chips strapped for BE will automagically configure the
@@ -270,7 +295,7 @@ int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		irq = idx * IRQS_PER_WORD;
 		gc = irq_get_domain_generic_chip(data->domain, irq);
 
-		gc->unused = 0xffffffff & ~data->irq_map_mask[idx];
+		gc->unused = 0xffffffff & ~valid_mask[idx];
 		gc->private = data;
 		ct = gc->chip_types;
 
@@ -300,6 +325,8 @@ int __init bcm7120_l2_intc_probe(struct device_node *dn,
 
 out_free_domain:
 	irq_domain_remove(data->domain);
+out_free_l1_data:
+	kfree(data->l1_data);
 out_unmap:
 	for (idx = 0; idx < MAX_MAPPINGS; idx++) {
 		if (data->map_base[idx])
-- 
2.1.0
