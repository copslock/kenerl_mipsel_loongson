Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 21:22:00 +0200 (CEST)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:35540
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993950AbdGGTVbhW6Bc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 21:21:31 +0200
Received: by mail-qk0-x241.google.com with SMTP id 16so5501326qkg.2
        for <linux-mips@linux-mips.org>; Fri, 07 Jul 2017 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nib2BZbWVEq2Pz475P985PczVP4sJuzQw4h1knYXl+M=;
        b=jX3BVCUybIq4AuwTBlgRVxhum1s2agb3hCRPQqakpPKviJM5Q1OKfRz7dsI1CSRjG/
         RQB0JQWqPanNyuoqi1y6CEwsLUhPlskKW7BGW5zlL2zFEDqzHOkVPyYVfGxns95EmTbh
         JBZwlNyEPpOGKi1GeJHfnf39U5/FDaAd0RpJntZkBZz/SVYTVUbTGvVQi1JSOESsDSgI
         iRnTyvP9gbljb178OY7SQQYrEYxoPZlPegUt/EqXR5+4YLRUsGIXUgJXD74RY2Q2MPXK
         +J9h8dqY/OPpEnf3ePaBfiu3uZ86eJQmWv3ISd5P7aSx9o95CDrLhv40X8BkopPR0JOE
         bvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nib2BZbWVEq2Pz475P985PczVP4sJuzQw4h1knYXl+M=;
        b=CR7oEa2E38iH2daoR/ZfuOSTQBtITyF/1YS9/Ju8/ZfqTp2MiccHm27Crw/6RvfY/E
         kV6Z7Y6b0nQU8eZ/0zNbDgykRhu4po9r74LVZjoUN2KP/ElgBtAo07qQXkR95M+Jnwq0
         mnQfEmyCnB/0Lw/GbrFZ8xETXnQO1E2qh2tVMRChzupy24RcR3YWHdbpHNQOJE3DPEih
         yVtRovv63nu8OqznoHBW4uN3suh0iSxZwE202ec4KulSDRe8IZXxOtBozmsZ2GKu2ItL
         G45b8lJmBiDELTJ2cFNX8KzKlzHoWibmCNEt8CRG39kXQR0UqbqS6m7uXcaTBrR1Pxdb
         VKQA==
X-Gm-Message-State: AIVw1131CrTsy3s6sO8D1fQp0/l5YwkUjAKJDGk8XN8phnnf2N9CKzot
        b3c2MAMUv3EMZA==
X-Received: by 10.55.111.195 with SMTP id k186mr21971292qkc.206.1499455285963;
        Fri, 07 Jul 2017 12:21:25 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id n8sm3437132qtc.5.2017.07.07.12.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 12:21:25 -0700 (PDT)
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
Subject: [PATCH 5/6] irqchip: brcmstb-l2: Abstract register accesses
Date:   Fri,  7 Jul 2017 12:20:15 -0700
Message-Id: <20170707192016.13001-6-opendmb@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170707192016.13001-1-opendmb@gmail.com>
References: <20170707192016.13001-1-opendmb@gmail.com>
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59061
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

Added register block offsets to the brcmstb_l2_intc_data structure
for the status and mask registers to support reading the active
interupts in an abstracted way.  It seems like an irq_chip method
should have been provided for this, but it's not there yet.

Abstracted the implementation of the handler, suspend, and resume
functions to not use any hard coded register offsets.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 977ae55d47d4..ce3850530e2b 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -43,6 +43,8 @@
 struct brcmstb_l2_intc_data {
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
+	int status_offset;
+	int mask_offset;
 	bool can_wake;
 	u32 saved_mask; /* for suspend/resume */
 };
@@ -56,8 +58,8 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	status = irq_reg_readl(b->gc, CPU_STATUS) &
-		~(irq_reg_readl(b->gc, CPU_MASK_STATUS));
+	status = irq_reg_readl(b->gc, b->status_offset) &
+		~(irq_reg_readl(b->gc, b->mask_offset));
 
 	if (status == 0) {
 		raw_spin_lock(&desc->lock);
@@ -78,16 +80,17 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 static void brcmstb_l2_intc_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
 
 	irq_gc_lock(gc);
 	/* Save the current mask */
-	b->saved_mask = irq_reg_readl(gc, CPU_MASK_STATUS);
+	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
 
 	if (b->can_wake) {
 		/* Program the wakeup mask */
-		irq_reg_writel(gc, ~gc->wake_active, CPU_MASK_SET);
-		irq_reg_writel(gc, gc->wake_active, CPU_MASK_CLEAR);
+		irq_reg_writel(gc, ~gc->wake_active, ct->regs.disable);
+		irq_reg_writel(gc, gc->wake_active, ct->regs.enable);
 	}
 	irq_gc_unlock(gc);
 }
@@ -95,15 +98,19 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 static void brcmstb_l2_intc_resume(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
 
 	irq_gc_lock(gc);
-	/* Clear unmasked non-wakeup interrupts */
-	irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active, CPU_CLEAR);
+	if (ct->chip.irq_ack != irq_gc_noop) {
+		/* Clear unmasked non-wakeup interrupts */
+		irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active,
+				ct->regs.ack);
+	}
 
 	/* Restore the saved mask */
-	irq_reg_writel(gc, b->saved_mask, CPU_MASK_SET);
-	irq_reg_writel(gc, ~b->saved_mask, CPU_MASK_CLEAR);
+	irq_reg_writel(gc, b->saved_mask, ct->regs.disable);
+	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
 	irq_gc_unlock(gc);
 }
 
@@ -173,6 +180,9 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	data->gc = irq_get_domain_generic_chip(data->domain, 0);
 	data->gc->reg_base = base;
 	data->gc->private = data;
+	data->status_offset = CPU_STATUS;
+	data->mask_offset = CPU_MASK_STATUS;
+
 	ct = data->gc->chip_types;
 
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
@@ -181,6 +191,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
 	ct->regs.disable = CPU_MASK_SET;
+	ct->regs.mask = CPU_MASK_STATUS;
 
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
 	ct->regs.enable = CPU_MASK_CLEAR;
-- 
2.13.0
