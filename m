Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 05:01:46 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55854 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011847AbaJ2D7Ys1o7w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 04:59:24 +0100
Received: by mail-pa0-f42.google.com with SMTP id bj1so2273840pad.29
        for <multiple recipients>; Tue, 28 Oct 2014 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FF2LReocnTEbyJ90snFvWVmtgF7x74axQyHNgl4tW6Y=;
        b=weOwjadkAcWMFo3THOnBH2Up88czLksPog6jpBpUiO2S2wSF3Ltr5JJkfptu64FfpJ
         JduZLMfKncEbSjYkdwS3gw2THGQILa+8/9yUFWtFJ2S7ZYjjYhwcQnPEzjSDQB2qCsYT
         Pevj4iwhXh0BxSE8Z4iiz9xGPwtvCmYu5blGpOH/lC0E9uGaK0MoeyJUoRDTzmG2LvQs
         N2SiXoWS0cHH4aIrM9lU0sNSVtCkychvGx3/10Zu5O7SP17MGI3Oq3wC30b8MQmpOAfk
         qnTO+fbSzvE4XahFAjllDPt9RBiQNoqjacTdTK9OJfAMqWyTjv+gi/OOhqMK7+Bmfrcu
         G/4A==
X-Received: by 10.68.93.228 with SMTP id cx4mr7702275pbb.45.1414555158416;
        Tue, 28 Oct 2014 20:59:18 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id kj9sm2946249pbc.37.2014.10.28.20.59.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 20:59:17 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH 09/11] irqchip: bcm7120-l2: Use gc->mask_cache to simplify suspend/resume functions
Date:   Tue, 28 Oct 2014 20:58:56 -0700
Message-Id: <1414555138-6500-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43679
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
---
 drivers/irqchip/irq-bcm7120-l2.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index e9331f8..c76c9ad 100644
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
-	b->saved_mask = irq_reg_readl(b->base + IRQEN) | b->irq_fwd_mask;
 	if (b->can_wake) {
-		reg = b->saved_mask | gc->wake_active;
-		irq_reg_writel(reg, b->base + IRQEN);
+		irq_reg_writel(gc->mask_cache | gc->wake_active,
+			       b->base + IRQEN);
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
-	irq_reg_writel(b->saved_mask, b->base + IRQEN);
+	irq_reg_writel(gc->mask_cache, b->base + IRQEN);
 	irq_gc_unlock(gc);
 }
 
-- 
2.1.1
