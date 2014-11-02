Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 02:08:35 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:45323 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012454AbaKBBFM6PmIK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 02:05:12 +0100
Received: by mail-pa0-f54.google.com with SMTP id rd3so9933671pab.41
        for <multiple recipients>; Sat, 01 Nov 2014 18:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O4G3U8IODlZ2lYxN6pRD5t1IqT1PDKqWkMiwBezybII=;
        b=ORczWmM3x6cX1ME/haFVVKmFS6z6+B2pcb7IWaMLsxTRMrtcB+6EEPfl7LMEGIUfSk
         S+Ok+EXPCEHmUlPc4yJNoesXHrQUe+GxpSDcChkjKNu6C+U5PMGWm1c8rp4t6PiNCJnG
         YnjhmlrHjictyu/uNLAcJAXAHHNLtda3Tuy3IgzwcqiCz3jiYrh9kXuHTfDXm9EZltH+
         hDdel04Fz8a4Itrcm3iEhd/XvHPrtj71a582ElNOaBWZc2CDyyNjnfSEY0NENMLWry+u
         emN02V932yh6s4g/dSvYTJUhadCqEdJSQSrl+/GU0ossKL+5iYrr46JYAJ8PDDNQf5qo
         JfFw==
X-Received: by 10.66.157.101 with SMTP id wl5mr8591349pab.37.1414890306822;
        Sat, 01 Nov 2014 18:05:06 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id f7sm13488343pdj.15.2014.11.01.18.05.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Nov 2014 18:05:06 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
Cc:     linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V3 13/14] irqchip: bcm7120-l2: Convert driver to use irq_reg_{readl,writel}
Date:   Sat,  1 Nov 2014 18:04:00 -0700
Message-Id: <1414890241-9938-14-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43835
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

On BE MIPS systems this needs to use the new IRQ_GC_BE_IO gc_flag.  In
all other cases it will use the standard readl/writel accessors.

The initial irq_fwd_mask setup runs before "gc" is initialized, so it
is unchanged for now.  This could potentially be a problem on an ARM
system that boots in LE mode but runs a BE kernel, but currently none
of the supported ARM platforms are ever expected to run BE.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index e53a3a6..e7c6155 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/kconfig.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -60,8 +61,7 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 		int hwirq;
 
 		irq_gc_lock(gc);
-		pending = __raw_readl(b->base[idx] + IRQSTAT) &
-			  gc->mask_cache;
+		pending = irq_reg_readl(gc, IRQSTAT) & gc->mask_cache;
 		irq_gc_unlock(gc);
 
 		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
@@ -79,10 +79,8 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
 	struct bcm7120_l2_intc_data *b = gc->private;
 
 	irq_gc_lock(gc);
-	if (b->can_wake) {
-		__raw_writel(gc->mask_cache | gc->wake_active,
-			     gc->reg_base + IRQEN);
-	}
+	if (b->can_wake)
+		irq_reg_writel(gc, gc->mask_cache | gc->wake_active, IRQEN);
 	irq_gc_unlock(gc);
 }
 
@@ -92,7 +90,7 @@ static void bcm7120_l2_intc_resume(struct irq_data *d)
 
 	/* Restore the saved mask */
 	irq_gc_lock(gc);
-	__raw_writel(gc->mask_cache, gc->reg_base + IRQEN);
+	irq_reg_writel(gc, gc->mask_cache, IRQEN);
 	irq_gc_unlock(gc);
 }
 
@@ -132,7 +130,7 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 	const __be32 *map_mask;
 	int num_parent_irqs;
 	int ret = 0, len;
-	unsigned int idx, irq;
+	unsigned int idx, irq, flags;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -195,9 +193,15 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 		goto out_unmap;
 	}
 
+	/* MIPS chips strapped for BE will automagically configure the
+	 * peripheral registers for CPU-native byte order.
+	 */
+	flags = IRQ_GC_INIT_MASK_CACHE;
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		flags |= IRQ_GC_BE_IO;
+
 	ret = irq_alloc_domain_generic_chips(data->domain, IRQS_PER_WORD, 1,
-				dn->full_name, handle_level_irq, clr, 0,
-				IRQ_GC_INIT_MASK_CACHE);
+				dn->full_name, handle_level_irq, clr, 0, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
-- 
2.1.1
