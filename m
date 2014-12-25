Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:02:09 +0100 (CET)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:59344 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009761AbaLYR5cOUa7m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:32 +0100
Received: by mail-pd0-f178.google.com with SMTP id r10so11799730pdi.23;
        Thu, 25 Dec 2014 09:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/LC+KjCuS7SwNvFMURtE6ZDt90zgsf/oJ9zPv4LD9vk=;
        b=yeuGdbBgs8HpF+s/ySeNUY2sWv7G96E7AGWC42vSxCtkPtszr4y5QG3I3hgcpu1e/F
         4HDg7odR1vXTMmGjoz09GW4ONQcoevuTaGplxtWiT76sNzelkNGuaixQQEqErENhUfDK
         sRZhZc9rHWJDyIz3lqRtFWmlgA3Tjk2eNmnAfY0gNIUrT3j6lOlQz3N3AttVxoRSO2yE
         JlxTFeF9uTU32rfI/OCdlwJG9I7yYHcuwwFM0d1XKbjmi1N0MuakV1Kq7a77tgulAeDq
         AXKwcYJvfxgAMPTm8/qkiRbt4BSIe/Y6vssjofJU0QYN+yxVpZZDQEQ2sruaO+/3dJC+
         dbww==
X-Received: by 10.68.65.79 with SMTP id v15mr63293263pbs.56.1419530246607;
        Thu, 25 Dec 2014 09:57:26 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.25
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:26 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 17/25] MIPS: BMIPS: Rewrite DMA code to use "dma-ranges" property
Date:   Thu, 25 Dec 2014 09:49:12 -0800
Message-Id: <1419529760-9520-18-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44927
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
