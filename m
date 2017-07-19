Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 21:10:58 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:36353
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993893AbdGSTI4OvWzC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2017 21:08:56 +0200
Received: by mail-qt0-x244.google.com with SMTP id l55so1271565qtl.3
        for <linux-mips@linux-mips.org>; Wed, 19 Jul 2017 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J7aPmyC71w2/jjfANU/JthB1MI7k55kfKPQSwNwLWOA=;
        b=cHoHE2c4nO4p7fE0vTypCtFu0/CutHwtIJFAgrFv8Sbg5ulsqR9SLeOn8Ny0ct+TVW
         XD4sFpV42haVbgKJ9KVycNxauhI6RMRHagQJtZWElzWn0aWZmotuzHwAg2XuhadCs+Sf
         ohR3rtnyk0FKRdBLPnyH4iGOj/PoFOTaOJW/ixIWMcBSUEYxgjBQ6lvjq+zG/PzBMmvE
         wYZ6uZ2WNBz9ZaZej8wvdkRWRpqZ76SKVR0/7G5j8wuXE269Yuc8StKxS8NQL/MNObOH
         z5xiCwSpnaT0IVUsakn0ELm2V+76PX4vO2hVh6ZdoW/pW7BOMMlpooteqnqTXZf/7jdX
         aqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J7aPmyC71w2/jjfANU/JthB1MI7k55kfKPQSwNwLWOA=;
        b=nC1DZLqnh6deCoY8cm5PYb2j3EOEo7xmpDu+Z+OQa6NUf60byh9AximKbjKYSr7gvq
         7KVs3NsKancE5hySc9TOV4ZQOox1cvZ270rZzaIITf4qa25lH4CDsk0In33l0SbwWP8Y
         /nUHpsxhOnUcO1/+Q3qLcckDnNOqf8VQSa+jDvF7jN2/srxSmHzT+RNq4ycjkiraArG9
         iCDtRvcdGQck+6a+LH95PgvLYSlshu11rd4c4Y19jjaIGYplZVY8I3hEBWl2MGHVyCjq
         l7lWbKeKy56dFhEKBr5D3QUxaca3MDIt1ZbLG1k48vUAecdrSfNFbp3aAPvEE0EVLvHQ
         PXTw==
X-Gm-Message-State: AIVw1110vd2WtyywegxYEL//cV8IRDIiSbTVW/XahnG9FjoBFdtnudQd
        nWspFvb/W30VrA==
X-Received: by 10.237.63.9 with SMTP id p9mr1742559qtf.81.1500491330521;
        Wed, 19 Jul 2017 12:08:50 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id 73sm518082qkx.30.2017.07.19.12.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2017 12:08:49 -0700 (PDT)
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
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Frias <sf84@laposte.net>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/6] irqchip: brcmstb-l2: Abstract register accesses
Date:   Wed, 19 Jul 2017 12:07:33 -0700
Message-Id: <20170719190734.18566-6-opendmb@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170719190734.18566-1-opendmb@gmail.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59157
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

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
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
