Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 02:07:43 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:63573 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012458AbaKBBFHzz2ib (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 02:05:07 +0100
Received: by mail-pd0-f171.google.com with SMTP id r10so9447720pdi.2
        for <multiple recipients>; Sat, 01 Nov 2014 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+FOHGwGwzVi84+dQ1m0wk9nKeavqe8E0jVwM/oqpwQ=;
        b=GpAs3c+J9O7h6bmvPCN03EF5+LYzLEMjbUTLbgy9j3d/ftnWgOzAlSKkb0PVbExZeC
         4a7K1Yiww+Cgfwk0jYai/jCSUXECkojz8cBqK8jWnhzR3LuPtueg5Z3ewIBCIkgujKal
         UGWg9czdTeCpguLvg9ha6ZamSpETL7r0yokjLhzMr/aCKs+7OATRJvVhOBrg7P/gi6xF
         9P8b1AxsfzbWWt0JHK8pjNjJzteaSdb6TtVOrgI1eEOtmPOWInGcwDcBgq81pNvql5YD
         F0wjxVhp04XsA8e4liHfi9GLf+vceZhrhxNdpIyFebFOdaYVKh7jWZNLxrNGjJgcPcHw
         BzTw==
X-Received: by 10.70.46.66 with SMTP id t2mr33923479pdm.51.1414890301857;
        Sat, 01 Nov 2014 18:05:01 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id f7sm13488343pdj.15.2014.11.01.18.05.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Nov 2014 18:05:01 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
Cc:     linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V3 10/14] irqchip: bcm7120-l2: Use gc->mask_cache to simplify suspend/resume functions
Date:   Sat,  1 Nov 2014 18:03:57 -0700
Message-Id: <1414890241-9938-11-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43832
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
