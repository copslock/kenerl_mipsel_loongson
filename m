Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:12:36 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59656 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008617AbaLLWIoMaafe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:44 +0100
Received: by mail-pa0-f42.google.com with SMTP id et14so8071060pad.29
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/LC+KjCuS7SwNvFMURtE6ZDt90zgsf/oJ9zPv4LD9vk=;
        b=AhYq9fSJ3t7yB0mOmQhUixTmNVQNSKkGFz4mjLKUBfI4GBGx4BgSG0VmpRiQ8vTy9O
         BsV7ftSl8LlaYCJP6PMlsIVlX1Tb6gcwzxNuW1CT9B3t4zW6KpsCP7TFRccEeORGkuqS
         RxskWbHbH/sh01tCL18w6luhFhVwcMIrBukp+d0QKhqNWlZIG6PeVo/ClejnsrqWoFII
         CIwrJQ+GhXDnql9wWNd9ex6L1/UT3OYRhnDoJsnO3OoybSxSX5yLmHZuxittlUVHV3ZQ
         MqoyMIqfD7ZFCJ69uKxLPaCfaXY30LOVmsTG6UybbiD78OJcF/AF8o/fqE7SJYsBcEXf
         SYGQ==
X-Received: by 10.68.247.98 with SMTP id yd2mr26759498pbc.38.1418422118563;
        Fri, 12 Dec 2014 14:08:38 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:38 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 15/23] MIPS: BMIPS: Rewrite DMA code to use "dma-ranges" property
Date:   Fri, 12 Dec 2014 14:07:06 -0800
Message-Id: <1418422034-17099-16-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44653
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

This is a more standardized way of handling DMA remapping, and it is
suitable for the memory map found on BCM3384.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/bmips/dma.c | 100 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 32 deletions(-)

diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index ea42012..04790f4 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -6,76 +6,112 @@
  * Copyright (C) 2014 Kevin Cernekee <cernekee@gmail.com>
  */
 
+#define pr_fmt(fmt)		"bmips-dma: " fmt
+
 #include <linux/device.h>
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
-#include <linux/mm.h>
+#include <linux/io.h>
 #include <linux/of.h>
-#include <linux/pci.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 #include <dma-coherence.h>
 
 /*
- * BCM3384 has configurable address translation windows which allow the
+ * BCM338x has configurable address translation windows which allow the
  * peripherals' DMA addresses to be different from the Zephyr-visible
  * physical addresses.  e.g. usb_dma_addr = zephyr_pa ^ 0x08000000
  *
- * If our DT "memory" node has a "dma-xor-mask" property we will enable this
- * translation using the provided offset.
+ * If the "brcm,ubus" node has a "dma-ranges" property we will enable this
+ * translation globally using the provided information.  This implements a
+ * very limited subset of "dma-ranges" support and it will probably be
+ * replaced by a more generic version later.
  */
-static u32 bcm3384_dma_xor_mask;
-static u32 bcm3384_dma_xor_limit = 0xffffffff;
 
-/*
- * PCI collapses the memory hole at 0x10000000 - 0x1fffffff.
- * On systems with a dma-xor-mask, this range is guaranteed to live above
- * the dma-xor-limit.
- */
-#define BCM3384_MEM_HOLE_PA	0x10000000
-#define BCM3384_MEM_HOLE_SIZE	0x10000000
+struct bmips_dma_range {
+	u32			child_addr;
+	u32			parent_addr;
+	u32			size;
+};
 
-static dma_addr_t bcm3384_phys_to_dma(struct device *dev, phys_addr_t pa)
+static struct bmips_dma_range *bmips_dma_ranges;
+
+#define FLUSH_RAC		0x100
+
+static dma_addr_t bmips_phys_to_dma(struct device *dev, phys_addr_t pa)
 {
-	if (dev && dev_is_pci(dev) &&
-	    pa >= (BCM3384_MEM_HOLE_PA + BCM3384_MEM_HOLE_SIZE))
-		return pa - BCM3384_MEM_HOLE_SIZE;
-	if (pa <= bcm3384_dma_xor_limit)
-		return pa ^ bcm3384_dma_xor_mask;
+	struct bmips_dma_range *r;
+
+	for (r = bmips_dma_ranges; r && r->size; r++) {
+		if (pa >= r->child_addr &&
+		    pa < (r->child_addr + r->size))
+			return pa - r->child_addr + r->parent_addr;
+	}
 	return pa;
 }
 
 dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size)
 {
-	return bcm3384_phys_to_dma(dev, virt_to_phys(addr));
+	return bmips_phys_to_dma(dev, virt_to_phys(addr));
 }
 
 dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
 {
-	return bcm3384_phys_to_dma(dev, page_to_phys(page));
+	return bmips_phys_to_dma(dev, page_to_phys(page));
 }
 
 unsigned long plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
-	if (dev && dev_is_pci(dev) &&
-	    dma_addr >= BCM3384_MEM_HOLE_PA)
-		return dma_addr + BCM3384_MEM_HOLE_SIZE;
-	if ((dma_addr ^ bcm3384_dma_xor_mask) <= bcm3384_dma_xor_limit)
-		return dma_addr ^ bcm3384_dma_xor_mask;
+	struct bmips_dma_range *r;
+
+	for (r = bmips_dma_ranges; r && r->size; r++) {
+		if (dma_addr >= r->parent_addr &&
+		    dma_addr < (r->parent_addr + r->size))
+			return dma_addr - r->parent_addr + r->child_addr;
+	}
 	return dma_addr;
 }
 
-static int __init bcm3384_init_dma_xor(void)
+static int __init bmips_init_dma_ranges(void)
 {
-	struct device_node *np = of_find_node_by_type(NULL, "memory");
+	struct device_node *np =
+		of_find_compatible_node(NULL, NULL, "brcm,ubus");
+	const __be32 *data;
+	struct bmips_dma_range *r;
+	int len;
 
 	if (!np)
 		return 0;
 
-	of_property_read_u32(np, "dma-xor-mask", &bcm3384_dma_xor_mask);
-	of_property_read_u32(np, "dma-xor-limit", &bcm3384_dma_xor_limit);
+	data = of_get_property(np, "dma-ranges", &len);
+	if (!data)
+		goto out_good;
+
+	len /= sizeof(*data) * 3;
+	if (!len)
+		goto out_bad;
+
+	/* add a dummy (zero) entry at the end as a sentinel */
+	bmips_dma_ranges = kzalloc(sizeof(struct bmips_dma_range) * (len + 1),
+				   GFP_KERNEL);
+	if (!bmips_dma_ranges)
+		goto out_bad;
 
+	for (r = bmips_dma_ranges; len; len--, r++) {
+		r->child_addr = be32_to_cpup(data++);
+		r->parent_addr = be32_to_cpup(data++);
+		r->size = be32_to_cpup(data++);
+	}
+
+out_good:
 	of_node_put(np);
 	return 0;
+
+out_bad:
+	pr_err("error parsing dma-ranges property\n");
+	of_node_put(np);
+	return -EINVAL;
 }
-arch_initcall(bcm3384_init_dma_xor);
+arch_initcall(bmips_init_dma_ranges);
-- 
2.1.1
