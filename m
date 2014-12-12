Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:10:05 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:64517 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008600AbaLLWI2MuqfK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:28 +0100
Received: by mail-pa0-f50.google.com with SMTP id bj1so8034788pad.37
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nOSxOnGAmQYvqqGUoIAL4cJGNrofOhfctgPW9Nrdako=;
        b=FVX8mgB1vuj3znEoBm2sVUH07zU/ZIUXKJFFGSK4+XKJ15wtc+VE6sskgZJGKRILnI
         kDG3TA683/bHo5l+9ggOpfsgWL9k673OkYNegW1CUwUjtXecH2sOXeiWOeT/PRAks6gk
         r+5RH3jXxU9UMiY5FGJvWgs7oM1k7XxAnyGcLlNkATe3b/tokeuWj8gFcPoKflr0X4HX
         IeQhcsF2sI0X4yiPmlqpxtForqRpm8VMob7HNGsvcqp4QzJxfqhOwDa+hrzweAm6quq9
         Sxur+WozkOEJJd2VB/bAroeGjpEXPK82o5rwZCuKrSM3RVX0GQg3Gytg0ctWz/908ukZ
         KURA==
X-Received: by 10.66.218.202 with SMTP id pi10mr30983627pac.28.1418422102545;
        Fri, 12 Dec 2014 14:08:22 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:21 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 06/23] irqchip: bcm7120-l2: Refactor driver for arbitrary IRQEN/IRQSTAT offsets
Date:   Fri, 12 Dec 2014 14:06:57 -0800
Message-Id: <1418422034-17099-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Currently the driver assumes that REG_BASE+0x00 is the IRQ enable mask,
and REG_BASE+0x04 is the IRQ status mask.  This is true on BCM3384 and
BCM7xxx, but it is not true for some of the controllers found on BCM63xx
chips.  So we will change a couple of key assumptions:

 - Don't assume that both the IRQEN and IRQSTAT registers will be
   covered by a single ioremap() operation.

 - Don't assume any particular ordering (IRQSTAT might show up before
   IRQEN on some chips).

 - For an L2 controller with >=64 IRQs, don't assume that every
   IRQEN/IRQSTAT pair will use the same register spacing.

This patch changes the "plumbing" but doesn't yet provide a way for users
to instantiate a controller with arbitrary IRQEN/IRQSTAT offsets.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 41 +++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 8eec8e1..e8441ee 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -34,11 +34,15 @@
 #define IRQSTAT		0x04
 
 #define MAX_WORDS	4
+#define MAX_MAPPINGS	MAX_WORDS
 #define IRQS_PER_WORD	32
 
 struct bcm7120_l2_intc_data {
 	unsigned int n_words;
-	void __iomem *base[MAX_WORDS];
+	void __iomem *map_base[MAX_MAPPINGS];
+	void __iomem *pair_base[MAX_WORDS];
+	int en_offset[MAX_WORDS];
+	int stat_offset[MAX_WORDS];
 	struct irq_domain *domain;
 	bool can_wake;
 	u32 irq_fwd_mask[MAX_WORDS];
@@ -61,7 +65,8 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 		int hwirq;
 
 		irq_gc_lock(gc);
-		pending = irq_reg_readl(gc, IRQSTAT) & gc->mask_cache;
+		pending = irq_reg_readl(gc, b->stat_offset[idx]) &
+					    gc->mask_cache;
 		irq_gc_unlock(gc);
 
 		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
@@ -76,21 +81,24 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 static void bcm7120_l2_intc_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct bcm7120_l2_intc_data *b = gc->private;
 
 	irq_gc_lock(gc);
 	if (b->can_wake)
-		irq_reg_writel(gc, gc->mask_cache | gc->wake_active, IRQEN);
+		irq_reg_writel(gc, gc->mask_cache | gc->wake_active,
+			       ct->regs.mask);
 	irq_gc_unlock(gc);
 }
 
 static void bcm7120_l2_intc_resume(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 
 	/* Restore the saved mask */
 	irq_gc_lock(gc);
-	irq_reg_writel(gc, gc->mask_cache, IRQEN);
+	irq_reg_writel(gc, gc->mask_cache, ct->regs.mask);
 	irq_gc_unlock(gc);
 }
 
@@ -137,9 +145,14 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 		return -ENOMEM;
 
 	for (idx = 0; idx < MAX_WORDS; idx++) {
-		data->base[idx] = of_iomap(dn, idx);
-		if (!data->base[idx])
+		data->map_base[idx] = of_iomap(dn, idx);
+		if (!data->map_base[idx])
 			break;
+
+		data->pair_base[idx] = data->map_base[idx];
+		data->en_offset[idx] = IRQEN;
+		data->stat_offset[idx] = IRQSTAT;
+
 		data->n_words = idx + 1;
 	}
 	if (!data->n_words) {
@@ -157,7 +170,8 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 	if (ret == 0 || ret == -EINVAL) {
 		for (idx = 0; idx < data->n_words; idx++)
 			__raw_writel(data->irq_fwd_mask[idx],
-				     data->base[idx] + IRQEN);
+				     data->pair_base[idx] +
+				     data->en_offset[idx]);
 	} else {
 		/* property exists but has the wrong number of words */
 		pr_err("invalid int-fwd-mask property\n");
@@ -215,11 +229,12 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 		gc = irq_get_domain_generic_chip(data->domain, irq);
 
 		gc->unused = 0xffffffff & ~data->irq_map_mask[idx];
-		gc->reg_base = data->base[idx];
 		gc->private = data;
 		ct = gc->chip_types;
 
-		ct->regs.mask = IRQEN;
+		gc->reg_base = data->pair_base[idx];
+		ct->regs.mask = data->en_offset[idx];
+
 		ct->chip.irq_mask = irq_gc_mask_clr_bit;
 		ct->chip.irq_unmask = irq_gc_mask_set_bit;
 		ct->chip.irq_ack = irq_gc_noop;
@@ -237,16 +252,16 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 	}
 
 	pr_info("registered BCM7120 L2 intc (mem: 0x%p, parent IRQ(s): %d)\n",
-			data->base[0], num_parent_irqs);
+			data->map_base[0], num_parent_irqs);
 
 	return 0;
 
 out_free_domain:
 	irq_domain_remove(data->domain);
 out_unmap:
-	for (idx = 0; idx < MAX_WORDS; idx++) {
-		if (data->base[idx])
-			iounmap(data->base[idx]);
+	for (idx = 0; idx < MAX_MAPPINGS; idx++) {
+		if (data->map_base[idx])
+			iounmap(data->map_base[idx]);
 	}
 	kfree(data);
 	return ret;
-- 
2.1.1
