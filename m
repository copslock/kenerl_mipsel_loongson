Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:49:24 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46037 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012112AbaKGGp3GcwpT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:29 +0100
Received: by mail-pa0-f42.google.com with SMTP id bj1so2954578pad.1
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ufBomCgKcn54a1fMOIHIEk8eGwcJ8UaPoWJ6+v66xfo=;
        b=Q77M7re5HfekNcM4cmbmo3Dxyqgn1BW/i7XXn1zbPu1kuQRGmXpzQuqRVtW8VSSs/N
         UtH7D+dEiMk+BEvo1FTQjayhu1dsPNcBhqoQc6f7XKot08RkWS0JA8gLdlI+UzrxgbeQ
         r4MtVkILfqRQ1Ut6rn3IqNeBGoPOw3Yz463oBwZtsj6UdfWaMNUUjeam9ubFp0l7gMg7
         eO7WVo8BNiJ6siA52qkPHoFn/jtEuUOPw7xXY7ATIEKZslY/wxeW+h/8hQXYmJ9Ke0If
         TangDJ+5U6M23fvVcbJBFAPL7yexL8oeMgBDWyiXiFkL8OnCA9dSiDRmK3CNb1nRxfbd
         pH/g==
X-Received: by 10.70.128.203 with SMTP id nq11mr9961984pdb.88.1415342723264;
        Thu, 06 Nov 2014 22:45:23 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:22 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 14/14] irqchip: brcmstb-l2: Convert driver to use irq_reg_{readl,writel}
Date:   Thu,  6 Nov 2014 22:44:29 -0800
Message-Id: <1415342669-30640-15-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43907
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

This effectively converts the __raw_ accessors to the non-__raw_
equivalents.  To handle BE, we pass IRQ_GC_BE_IO, similar to what was
done in irq-bcm7120-l2.c.

Since irq_reg_writel now takes an irq_chip_generic argument, writel must
be used for the initial hardware reset in the probe function.  But that
operation never needs endian swapping, so it's probably not a big deal.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index c9bdf20..4aa653a 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/kconfig.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
@@ -53,13 +54,14 @@ struct brcmstb_l2_intc_data {
 static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 {
 	struct brcmstb_l2_intc_data *b = irq_desc_get_handler_data(desc);
+	struct irq_chip_generic *gc = irq_get_domain_generic_chip(b->domain, 0);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	u32 status;
 
 	chained_irq_enter(chip, desc);
 
-	status = __raw_readl(b->base + CPU_STATUS) &
-		~(__raw_readl(b->base + CPU_MASK_STATUS));
+	status = irq_reg_readl(gc, CPU_STATUS) &
+		~(irq_reg_readl(gc, CPU_MASK_STATUS));
 
 	if (status == 0) {
 		raw_spin_lock(&desc->lock);
@@ -71,7 +73,7 @@ static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 	do {
 		irq = ffs(status) - 1;
 		/* ack at our level */
-		__raw_writel(1 << irq, b->base + CPU_CLEAR);
+		irq_reg_writel(gc, 1 << irq, CPU_CLEAR);
 		status &= ~(1 << irq);
 		generic_handle_irq(irq_find_mapping(b->domain, irq));
 	} while (status);
@@ -86,12 +88,12 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 
 	irq_gc_lock(gc);
 	/* Save the current mask */
-	b->saved_mask = __raw_readl(b->base + CPU_MASK_STATUS);
+	b->saved_mask = irq_reg_readl(gc, CPU_MASK_STATUS);
 
 	if (b->can_wake) {
 		/* Program the wakeup mask */
-		__raw_writel(~gc->wake_active, b->base + CPU_MASK_SET);
-		__raw_writel(gc->wake_active, b->base + CPU_MASK_CLEAR);
+		irq_reg_writel(gc, ~gc->wake_active, CPU_MASK_SET);
+		irq_reg_writel(gc, gc->wake_active, CPU_MASK_CLEAR);
 	}
 	irq_gc_unlock(gc);
 }
@@ -103,11 +105,11 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 
 	irq_gc_lock(gc);
 	/* Clear unmasked non-wakeup interrupts */
-	__raw_writel(~b->saved_mask & ~gc->wake_active, b->base + CPU_CLEAR);
+	irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active, CPU_CLEAR);
 
 	/* Restore the saved mask */
-	__raw_writel(b->saved_mask, b->base + CPU_MASK_SET);
-	__raw_writel(~b->saved_mask, b->base + CPU_MASK_CLEAR);
+	irq_reg_writel(gc, b->saved_mask, CPU_MASK_SET);
+	irq_reg_writel(gc, ~b->saved_mask, CPU_MASK_CLEAR);
 	irq_gc_unlock(gc);
 }
 
@@ -119,6 +121,7 @@ int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	int ret;
+	unsigned int flags;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -132,8 +135,8 @@ int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	}
 
 	/* Disable all interrupts by default */
-	__raw_writel(0xffffffff, data->base + CPU_MASK_SET);
-	__raw_writel(0xffffffff, data->base + CPU_CLEAR);
+	writel(0xffffffff, data->base + CPU_MASK_SET);
+	writel(0xffffffff, data->base + CPU_CLEAR);
 
 	data->parent_irq = irq_of_parse_and_map(np, 0);
 	if (data->parent_irq < 0) {
@@ -149,9 +152,16 @@ int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		goto out_unmap;
 	}
 
+	/* MIPS chips strapped for BE will automagically configure the
+	 * peripheral registers for CPU-native byte order.
+	 */
+	flags = 0;
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		flags |= IRQ_GC_BE_IO;
+
 	/* Allocate a single Generic IRQ chip for this node */
 	ret = irq_alloc_domain_generic_chips(data->domain, 32, 1,
-				np->full_name, handle_edge_irq, clr, 0, 0);
+				np->full_name, handle_edge_irq, clr, 0, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
-- 
2.1.1
