Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:48:52 +0100 (CET)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35180 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012109AbaKGGp1SuuMs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:27 +0100
Received: by mail-pd0-f178.google.com with SMTP id fp1so2724852pdb.37
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O4G3U8IODlZ2lYxN6pRD5t1IqT1PDKqWkMiwBezybII=;
        b=yk8RclaIq5dL+gtXaZ3ZhgxFJRJJ40UDP1K2YYJwzN+sJX6kw+sLx2dU9tojlJSdmO
         qerbkzBktpl5TurOSi1jsgN6XJKpGmofAbbeo82peVYDhJHDdtypTsKTMXKpwgtiz6UW
         Oi9VXZJRkGagaErxrWnAhol1A/QqWeu9smoDY0sLFggHv1/Hr2WutDqFbOuOsAbqRTvN
         G3WY0hCUShVu7fXqx7E5jYWsz7uGeLJE29U6hK2rYRG8ID2avH9lQC+rZXgnC7cioJgr
         KpquhD/zbvC8bv0n+pEJJ/YcALiBVmZJ2rO3YjHpNxJFd5e88wLip7mWpMmx9sQ7UNll
         Uvmw==
X-Received: by 10.66.65.137 with SMTP id x9mr10132104pas.0.1415342721678;
        Thu, 06 Nov 2014 22:45:21 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:21 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 13/14] irqchip: bcm7120-l2: Convert driver to use irq_reg_{readl,writel}
Date:   Thu,  6 Nov 2014 22:44:28 -0800
Message-Id: <1415342669-30640-14-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43906
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
