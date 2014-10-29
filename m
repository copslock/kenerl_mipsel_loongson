Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 05:01:09 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44323 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011839AbaJ2D7WcdWJt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 04:59:22 +0100
Received: by mail-pa0-f50.google.com with SMTP id eu11so2240175pac.23
        for <multiple recipients>; Tue, 28 Oct 2014 20:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OIOtLRpYPeq0rHwuKbrMjVI/x2UK6rxN3smjGYa0siI=;
        b=EBnYcm8NZYQA3W0mv5fpAujJqRgyHeYBCfj5oSZfxIksaIPICQi29lV37UxBRJVc/g
         uVSxb8Yg515tD+69toIJ/pD/lIGi2Odke9l8xpbgXqsTKpeKmX2sILg8oNs6e090a46S
         Xy0L/C/op0zt/N8v6IP5q+C2MJYeBDIXR7W4r62IZHt+sDqOHsRFEyd5SJ57pbm40aDP
         0eR7h9ARoixHzlLJ+A2rcoEDLH2LIvbH4cSgxM0R8kqBO/yxrTEuwLpshk1N3MlmGSzA
         VO6KxX5/6srC7BukvH6C6Y31wrZ9pbZu7bVxkReUdowHcYI9G4bJ1PnUa5YP9718blhx
         k2vA==
X-Received: by 10.68.183.34 with SMTP id ej2mr7596303pbc.75.1414555153316;
        Tue, 28 Oct 2014 20:59:13 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id kj9sm2946249pbc.37.2014.10.28.20.59.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 20:59:12 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH 06/11] irqchip: bcm7120-l2: Use irq_reg_* accessors
Date:   Tue, 28 Oct 2014 20:58:53 -0700
Message-Id: <1414555138-6500-6-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43677
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

This keeps things consistent between the "core" bcm7120-l2 driver and the
helpers in generic-chip.c.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 6472b71..f041992 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -48,7 +48,7 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	status = __raw_readl(b->base + IRQSTAT);
+	status = irq_reg_readl(b->base + IRQSTAT);
 	do {
 		irq = ffs(status) - 1;
 		status &= ~(1 << irq);
@@ -66,10 +66,10 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
 
 	irq_gc_lock(gc);
 	/* Save the current mask and the interrupt forward mask */
-	b->saved_mask = __raw_readl(b->base + IRQEN) | b->irq_fwd_mask;
+	b->saved_mask = irq_reg_readl(b->base + IRQEN) | b->irq_fwd_mask;
 	if (b->can_wake) {
 		reg = b->saved_mask | gc->wake_active;
-		__raw_writel(reg, b->base + IRQEN);
+		irq_reg_writel(reg, b->base + IRQEN);
 	}
 	irq_gc_unlock(gc);
 }
@@ -81,7 +81,7 @@ static void bcm7120_l2_intc_resume(struct irq_data *d)
 
 	/* Restore the saved mask */
 	irq_gc_lock(gc);
-	__raw_writel(b->saved_mask, b->base + IRQEN);
+	irq_reg_writel(b->saved_mask, b->base + IRQEN);
 	irq_gc_unlock(gc);
 }
 
@@ -133,7 +133,7 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 	/* Enable all interrupt specified in the interrupt forward mask and have
 	 * the other disabled
 	 */
-	__raw_writel(data->irq_fwd_mask, data->base + IRQEN);
+	irq_reg_writel(data->irq_fwd_mask, data->base + IRQEN);
 
 	num_parent_irqs = of_irq_count(dn);
 	if (num_parent_irqs <= 0) {
-- 
2.1.1
