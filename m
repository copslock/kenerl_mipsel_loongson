Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:46:15 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36130 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012014AbaKGGpMxFThX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:12 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so2924573pab.28
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UflaXURxjky6DUrAwDOmCqTBcDxFSeUwgHmcgxFFPGM=;
        b=J2b6rfztWksq0sv1T2DNQ+P30l8jxicp0TMBcmrxFPxXkF42K/ilZakM03k8rN39r4
         q7tJPcd7n9PLjFrz8+l1JLiPdBw4tWs7MzgM5apI+ISp2Hik6VHPD5IDuthQDz4022QC
         rPIygO7AFVuAZbesuY6sSk+Hi/EFF6jg2i+Chf4wLSc/+pZ5kK4lIbfRDECjTeI64pAz
         mJg+9zHkqJFBXrVj2OtFhkDbBegRciQiVSSlEzqcXmKNIuOsO9+zj6jhqOcuQJoWA6rs
         ADQ7yuww0FbuGDqQNcClcIVUuV/aY0t51Tca5IZKSjCdx8HG4tcbsqV/aykciuegZ+FP
         QA/A==
X-Received: by 10.66.155.2 with SMTP id vs2mr9755752pab.135.1415342707084;
        Thu, 06 Nov 2014 22:45:07 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:06 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 04/14] genirq: Generic chip: Add big endian I/O accessors
Date:   Thu,  6 Nov 2014 22:44:19 -0800
Message-Id: <1415342669-30640-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43897
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

Use io{read,write}32be if the caller specified IRQ_GC_BE_IO when creating
the irqchip.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 include/linux/irq.h       |  2 ++
 kernel/irq/generic-chip.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0fecd95..8588e5e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -738,12 +738,14 @@ struct irq_chip_generic {
  *				the parent irq. Usually GPIO implementations
  * @IRQ_GC_MASK_CACHE_PER_TYPE:	Mask cache is chip type private
  * @IRQ_GC_NO_MASK:		Do not calculate irq_data->mask
+ * @IRQ_GC_BE_IO:		Use big-endian register accesses (default: LE)
  */
 enum irq_gc_flags {
 	IRQ_GC_INIT_MASK_CACHE		= 1 << 0,
 	IRQ_GC_INIT_NESTED_LOCK		= 1 << 1,
 	IRQ_GC_MASK_CACHE_PER_TYPE	= 1 << 2,
 	IRQ_GC_NO_MASK			= 1 << 3,
+	IRQ_GC_BE_IO			= 1 << 4,
 };
 
 /*
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index db458c6..61024e8 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -191,6 +191,16 @@ int irq_gc_set_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
+static u32 irq_readl_be(void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+static void irq_writel_be(u32 val, void __iomem *addr)
+{
+	iowrite32be(val, addr);
+}
+
 static void
 irq_init_generic_chip(struct irq_chip_generic *gc, const char *name,
 		      int num_ct, unsigned int irq_base,
@@ -300,7 +310,13 @@ int irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 		dgc->gc[i] = gc = tmp;
 		irq_init_generic_chip(gc, name, num_ct, i * irqs_per_chip,
 				      NULL, handler);
+
 		gc->domain = d;
+		if (gcflags & IRQ_GC_BE_IO) {
+			gc->reg_readl = &irq_readl_be;
+			gc->reg_writel = &irq_writel_be;
+		}
+
 		raw_spin_lock_irqsave(&gc_lock, flags);
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
-- 
2.1.1
