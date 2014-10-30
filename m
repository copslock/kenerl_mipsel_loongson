Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:23:56 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:53499 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012203AbaJ3CUDQ17E8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:20:03 +0100
Received: by mail-pa0-f49.google.com with SMTP id lj1so4397492pab.22
        for <multiple recipients>; Wed, 29 Oct 2014 19:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UVBi1PbHhswWnyAW1+/usbVskmHaY0tQmZO078sD170=;
        b=Rwo5ZCiIi/sLmUA8isQg7R40+VUiWKFi9SEvuVeV96DYpSEj0hFKxWiL3hCLGdyrP7
         /HPEKlq/i1uPV0J+MC7YXCTxNCQ0hBW6WgLC++LwnuqL6BygboBKR+sk9UMXtt18PX76
         DTfbqjJHDmoPKkVNZEWW/8pmZzHi117qgmwM2dLKskuXsPmf3jzXVroqM/nwOd5dVUh8
         w0pl5zjoVZU4qDkJbPKsUDm1IExCQJLtZUfPR9DNnaLcr9N8ThRutQbbjS64diiVOcet
         6oQZrVbcgfPd1NDQmyImDLft1r0e+vEtbfx76jN2DAjLodr5sx3AJFiJbO/YaHEw5wuD
         7N1w==
X-Received: by 10.68.57.171 with SMTP id j11mr13861760pbq.68.1414635597117;
        Wed, 29 Oct 2014 19:19:57 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.19.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:19:56 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 12/15] irqchip: bcm7120-l2: Use gc->mask_cache to simplify suspend/resume functions
Date:   Wed, 29 Oct 2014 19:18:05 -0700
Message-Id: <1414635488-14137-13-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43751
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

The cached value already incorporates irq_fwd_mask, and was saved the
last time an IRQ was enabled/disabled.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index e3cfff5..ec84f65 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -37,7 +37,6 @@ struct bcm7120_l2_intc_data {
 	bool can_wake;
 	u32 irq_fwd_mask;
 	u32 irq_map_mask;
-	u32 saved_mask;
 };
 
 static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
@@ -62,14 +61,11 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct bcm7120_l2_intc_data *b = gc->private;
-	u32 reg;
 
 	irq_gc_lock(gc);
-	/* Save the current mask and the interrupt forward mask */
-	b->saved_mask = __raw_readl(b->base + IRQEN) | b->irq_fwd_mask;
 	if (b->can_wake) {
-		reg = b->saved_mask | gc->wake_active;
-		__raw_writel(reg, b->base + IRQEN);
+		__raw_writel(gc->mask_cache | gc->wake_active,
+			     b->base + IRQEN);
 	}
 	irq_gc_unlock(gc);
 }
@@ -77,11 +73,10 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
 static void bcm7120_l2_intc_resume(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct bcm7120_l2_intc_data *b = gc->private;
 
 	/* Restore the saved mask */
 	irq_gc_lock(gc);
-	__raw_writel(b->saved_mask, b->base + IRQEN);
+	__raw_writel(gc->mask_cache, b->base + IRQEN);
 	irq_gc_unlock(gc);
 }
 
-- 
2.1.1
