Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2017 03:01:19 +0200 (CEST)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:34665
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993411AbdISBA3L9CK- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2017 03:00:29 +0200
Received: by mail-qt0-x241.google.com with SMTP id q8so1435129qtb.1
        for <linux-mips@linux-mips.org>; Mon, 18 Sep 2017 18:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbrrHQz/cgm55gwVaBLNYq1yvs0GincIzQiqR0hbpmQ=;
        b=Tsp6jTR+VS2Lznx1eLtkqULS3KKETeCld+LEhdiOQpnlsNMf3QQqC2bQRchVNPwnEs
         GKGfxBLpbbI4andm06wF6D5Hlyk72FG3KA9Pt7xd8aiYOfyDpg/ud631FlsnivI1Aowu
         0/oC98yNdGLzJDgVq9r9EgphyHKgAx5X84BGIcAPIo8rVsWQRJMh7vaPiVXbK+W+Uoce
         C1MPxqA/NxYyOLWHvmrrylCBOpeohcq1d6TAGmnmYRjqaphgmgRrwL8E/OB2n0KiUGB5
         rxMgY6CK/J+KUVQ4JPwzgGwcql7YlLTKBZjpt8bqu98ml+54x12Sv9TPBIGWrV4gVdzN
         H1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IbrrHQz/cgm55gwVaBLNYq1yvs0GincIzQiqR0hbpmQ=;
        b=ILllAHYTGd6ee6QnkIvCy2TIrKhyddA4FwpFO/fOcd2BOclFulWkOg1kT/B9g7eK/o
         Jn4zD3BNjn9MJwpMYSeIiEfTKO3pa6XnfGduTod6sDTFBWmtMrXpTa2NRFaboHYF4r0j
         As/9XqcfOhVSCVYXgHAa/3Jm+flaoevnHu9KKgo/FfA/JLfCdo99clBcsCM4YLuxfStl
         uewvOKiEfXJ+1mmnPb9jAdZo1AV4ZkUGkXZt/yl4Y1S2Hu39opT6IiH0mi3iLe8idAJI
         /FKZQQSHOttXu8YapaU7IwGMjU8xnwMINEhEVKPFRfeBtWxUgr5CRpdR8ULHk9bzFYfr
         mL5g==
X-Gm-Message-State: AHPjjUg9op6er4kg2Lx/D4TRBfoB3hjEPv1DT9gQVkXoS7c5XZ9NdCUc
        tx7AEWk6I4v1jw==
X-Google-Smtp-Source: AOwi7QAucKF37OzgjdrSbq1iWpzQCmuqOQgnfdgAam+hN0PqEM/f/DxpACOKFRtVcXt8TlgqQ+Mfbg==
X-Received: by 10.237.39.7 with SMTP id n7mr51267531qtd.124.1505782822049;
        Mon, 18 Sep 2017 18:00:22 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id x39sm6113273qtc.93.2017.09.18.18.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 18:00:21 -0700 (PDT)
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
Subject: [PATCH v4 2/3] irqchip: brcmstb-l2: Abstract register accesses
Date:   Mon, 18 Sep 2017 17:59:59 -0700
Message-Id: <20170919010000.32072-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170919010000.32072-1-opendmb@gmail.com>
References: <20170919010000.32072-1-opendmb@gmail.com>
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60069
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
index 48bd1a36c7d4..8d54cd7a090d 100644
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
@@ -82,8 +84,8 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	status = irq_reg_readl(b->gc, CPU_STATUS) &
-		~(irq_reg_readl(b->gc, CPU_MASK_STATUS));
+	status = irq_reg_readl(b->gc, b->status_offset) &
+		~(irq_reg_readl(b->gc, b->mask_offset));
 
 	if (status == 0) {
 		raw_spin_lock(&desc->lock);
@@ -104,16 +106,17 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
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
@@ -121,15 +124,19 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
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
 
@@ -199,6 +206,9 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	data->gc = irq_get_domain_generic_chip(data->domain, 0);
 	data->gc->reg_base = base;
 	data->gc->private = data;
+	data->status_offset = CPU_STATUS;
+	data->mask_offset = CPU_MASK_STATUS;
+
 	ct = data->gc->chip_types;
 
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
@@ -207,6 +217,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_mask_ack = brcmstb_l2_mask_and_ack;
 	ct->regs.disable = CPU_MASK_SET;
+	ct->regs.mask = CPU_MASK_STATUS;
 
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
 	ct->regs.enable = CPU_MASK_CLEAR;
-- 
2.14.1
