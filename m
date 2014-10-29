Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 05:00:47 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:43345 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011841AbaJ2D7WcdWJt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 04:59:22 +0100
Received: by mail-pd0-f172.google.com with SMTP id r10so2125168pdi.17
        for <multiple recipients>; Tue, 28 Oct 2014 20:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKc6kPevAKhH9JRHA5SEppvTQiscCJM20lww7wZ7tR4=;
        b=T3UtnhtxpxKR99Hh4X0NcJwnW1jT2TqBbAzt5XYkWHhYyTbNF0I/UrLOTxSRjyHZjN
         9S0fsLbBnqL9ksZgdDeU0lpX3QWUeQyYki7KkdejUW2axB2bqFrQsN3cU2oYlKhRimW0
         ZRrCNg97RNAKO5sbw2g9q5ehu0o1AEUIDUCn15gR1b/KNFUNhBWEa619HXnthK4GFxnL
         8rf5A3I6xnPQ1WI1zRuVw61RZXrAF/XWE3tpPquTScn0EfUPUTZxnoKg+iPxRLP/1JXW
         8oENY/kHqdFDnHzbyQ6XLOxubrwvg83E8n9AqJAebXRt/SLQHXp2ifv/FdaHjfVNWYkH
         6wIA==
X-Received: by 10.68.87.37 with SMTP id u5mr7743947pbz.128.1414555154753;
        Tue, 28 Oct 2014 20:59:14 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id kj9sm2946249pbc.37.2014.10.28.20.59.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 20:59:14 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH 07/11] irqchip: brcmstb-l2: Use irq_reg_* accessors
Date:   Tue, 28 Oct 2014 20:58:54 -0700
Message-Id: <1414555138-6500-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43676
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

This change was just made on bcm7120-l2, so let's keep things consistent
between the two drivers.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index c9bdf20..8b82b86 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -58,8 +58,8 @@ static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	status = __raw_readl(b->base + CPU_STATUS) &
-		~(__raw_readl(b->base + CPU_MASK_STATUS));
+	status = irq_reg_readl(b->base + CPU_STATUS) &
+		~(irq_reg_readl(b->base + CPU_MASK_STATUS));
 
 	if (status == 0) {
 		raw_spin_lock(&desc->lock);
@@ -71,7 +71,7 @@ static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 	do {
 		irq = ffs(status) - 1;
 		/* ack at our level */
-		__raw_writel(1 << irq, b->base + CPU_CLEAR);
+		irq_reg_writel(1 << irq, b->base + CPU_CLEAR);
 		status &= ~(1 << irq);
 		generic_handle_irq(irq_find_mapping(b->domain, irq));
 	} while (status);
@@ -86,12 +86,12 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 
 	irq_gc_lock(gc);
 	/* Save the current mask */
-	b->saved_mask = __raw_readl(b->base + CPU_MASK_STATUS);
+	b->saved_mask = irq_reg_readl(b->base + CPU_MASK_STATUS);
 
 	if (b->can_wake) {
 		/* Program the wakeup mask */
-		__raw_writel(~gc->wake_active, b->base + CPU_MASK_SET);
-		__raw_writel(gc->wake_active, b->base + CPU_MASK_CLEAR);
+		irq_reg_writel(~gc->wake_active, b->base + CPU_MASK_SET);
+		irq_reg_writel(gc->wake_active, b->base + CPU_MASK_CLEAR);
 	}
 	irq_gc_unlock(gc);
 }
@@ -103,11 +103,11 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 
 	irq_gc_lock(gc);
 	/* Clear unmasked non-wakeup interrupts */
-	__raw_writel(~b->saved_mask & ~gc->wake_active, b->base + CPU_CLEAR);
+	irq_reg_writel(~b->saved_mask & ~gc->wake_active, b->base + CPU_CLEAR);
 
 	/* Restore the saved mask */
-	__raw_writel(b->saved_mask, b->base + CPU_MASK_SET);
-	__raw_writel(~b->saved_mask, b->base + CPU_MASK_CLEAR);
+	irq_reg_writel(b->saved_mask, b->base + CPU_MASK_SET);
+	irq_reg_writel(~b->saved_mask, b->base + CPU_MASK_CLEAR);
 	irq_gc_unlock(gc);
 }
 
@@ -132,8 +132,8 @@ int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	}
 
 	/* Disable all interrupts by default */
-	__raw_writel(0xffffffff, data->base + CPU_MASK_SET);
-	__raw_writel(0xffffffff, data->base + CPU_CLEAR);
+	irq_reg_writel(0xffffffff, data->base + CPU_MASK_SET);
+	irq_reg_writel(0xffffffff, data->base + CPU_CLEAR);
 
 	data->parent_irq = irq_of_parse_and_map(np, 0);
 	if (data->parent_irq < 0) {
-- 
2.1.1
