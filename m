Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:47:59 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57916 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012061AbaKGGpWaXMT8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:22 +0100
Received: by mail-pd0-f181.google.com with SMTP id y10so2746752pdj.12
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+FOHGwGwzVi84+dQ1m0wk9nKeavqe8E0jVwM/oqpwQ=;
        b=bSQCdtLWoBE8Psav4F9KwH11G3l+WVSe6kIlacVelB20bdstJ8683F6s3adGW7mM4Y
         ypkrohhzGPiXYL9izAvvc7F6swtSlQCNcIZE9qvnvwptm9Xe7BIQH2MVwxJwMtVna3wh
         Rwm9Fi55vFUmzxQI25hKryckjg++uciWLB60PUAtCHTJNTvqmmx0HqqT5xnGMJwv8ak5
         WqZGstPoAZDNoK0y34EMnFRyO3P1ZEn/SF8iO//EmJpeqCdNoX+4zb7MwW85WsB9cZKO
         E2ahDihjwF6LBsn2RqdRiX5aO5ku9gFbtpZPGPCxJf9LmUo8ZpY28yOrifs53VUieA0p
         uYrg==
X-Received: by 10.68.215.100 with SMTP id oh4mr9928768pbc.11.1415342716883;
        Thu, 06 Nov 2014 22:45:16 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:16 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 10/14] irqchip: bcm7120-l2: Use gc->mask_cache to simplify suspend/resume functions
Date:   Thu,  6 Nov 2014 22:44:25 -0800
Message-Id: <1415342669-30640-11-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43903
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
index b70679f8..9841121 100644
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
