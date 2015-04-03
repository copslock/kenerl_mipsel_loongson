Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Apr 2015 04:41:37 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35513 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008967AbbDCClTJzdt0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Apr 2015 04:41:19 +0200
Received: by pddn5 with SMTP id n5so107817151pdd.2;
        Thu, 02 Apr 2015 19:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iF3PtfRrrqKF7jQE4rqbFY6/35jZh6u+5k1muhWw9zg=;
        b=eRdA0MtPWA0wQeRmEMegKS5STuLuVFN34zFA/0varZAHA4JF3X6N6UEHFZcTHRHv6z
         G36r7rogiY/fnmMNtd0MZb7KLi40Z35u4deKS44/ZSIcvNNQywi3lVuEURmhMQ867rhP
         /2RlE28pNsHidLzUwx6GnuiEp0P/9wfSDltkKH24EiulaGN01ZIqVMhd08X725MoHtAn
         N4deCPy0U8aADOapOQ7YT34VBIN+PFCMFJIWaxqux+LHF08VKbt8PPHQ3cNzQW8HTmh5
         TD+nbUkBDxsxG7D4rvomtPiTU1J68sPGcE8XWgWwYGZ9w8LYfgwZflVHVbPtG2p76BRs
         Icnw==
X-Received: by 10.66.146.231 with SMTP id tf7mr542639pab.130.1428028874036;
        Thu, 02 Apr 2015 19:41:14 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id fk4sm6492867pbb.80.2015.04.02.19.41.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2015 19:41:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        mbizon@freebox.fr, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] MIPS: BMIPS: Create bmips-dma-coherence.h
Date:   Thu,  2 Apr 2015 19:40:18 -0700
Message-Id: <1428028819-28236-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1428028819-28236-1-git-send-email-f.fainelli@gmail.com>
References: <1428028819-28236-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

arch/mips/include/asm/mach-bmips/dma-coherence.h contains a number of
BMIPS-specific DMA coherency overrides which are not mach-bmips
specific, but specific to the BMIPS CPUs, move this code to a common
location such that BCM63xx can also utilize it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/bmips-dma-coherence.h      | 68 ++++++++++++++++++++++++
 arch/mips/include/asm/mach-bmips/dma-coherence.h | 64 +---------------------
 2 files changed, 69 insertions(+), 63 deletions(-)
 create mode 100644 arch/mips/include/asm/bmips-dma-coherence.h

diff --git a/arch/mips/include/asm/bmips-dma-coherence.h b/arch/mips/include/asm/bmips-dma-coherence.h
new file mode 100644
index 000000000000..bd4aac47b832
--- /dev/null
+++ b/arch/mips/include/asm/bmips-dma-coherence.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2006 Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2009 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ASM_BMIPS_DMA_COHERENCE_H
+#define __ASM_BMIPS_DMA_COHERENCE_H
+
+#include <asm/bmips.h>
+#include <asm/cpu-type.h>
+#include <asm/cpu.h>
+
+struct device;
+
+extern dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size);
+extern dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page);
+extern unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr);
+
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
+{
+}
+
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+
+	return 1;
+}
+
+static inline int plat_device_is_coherent(struct device *dev)
+{
+	return 0;
+}
+
+static inline void plat_post_dma_flush(struct device *dev)
+{
+	void __iomem *cbr = BMIPS_GET_CBR();
+	u32 cfg;
+
+	if (boot_cpu_type() != CPU_BMIPS3300 &&
+	    boot_cpu_type() != CPU_BMIPS4350 &&
+	    boot_cpu_type() != CPU_BMIPS4380)
+		return;
+
+	/* Flush stale data out of the readahead cache */
+	cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
+	__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
+	__raw_readl(cbr + BMIPS_RAC_CONFIG);
+}
+
+#endif /* __ASM_BMIPS_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-bmips/dma-coherence.h b/arch/mips/include/asm/mach-bmips/dma-coherence.h
index ee3c713d642e..4d88233a82fd 100644
--- a/arch/mips/include/asm/mach-bmips/dma-coherence.h
+++ b/arch/mips/include/asm/mach-bmips/dma-coherence.h
@@ -1,68 +1,6 @@
-/*
- * Copyright (C) 2006 Ralf Baechle <ralf@linux-mips.org>
- * Copyright (C) 2009 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
 #ifndef __ASM_MACH_BMIPS_DMA_COHERENCE_H
 #define __ASM_MACH_BMIPS_DMA_COHERENCE_H
 
-#include <asm/bmips.h>
-#include <asm/cpu-type.h>
-#include <asm/cpu.h>
-
-struct device;
-
-extern dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size);
-extern dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page);
-extern unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr);
-
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
-{
-}
-
-static inline int plat_dma_supported(struct device *dev, u64 mask)
-{
-	/*
-	 * we fall back to GFP_DMA when the mask isn't all 1s,
-	 * so we can't guarantee allocations that must be
-	 * within a tighter range than GFP_DMA..
-	 */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 0;
-}
-
-static inline void plat_post_dma_flush(struct device *dev)
-{
-	void __iomem *cbr = BMIPS_GET_CBR();
-	u32 cfg;
-
-	if (boot_cpu_type() != CPU_BMIPS3300 &&
-	    boot_cpu_type() != CPU_BMIPS4350 &&
-	    boot_cpu_type() != CPU_BMIPS4380)
-		return;
-
-	/* Flush stale data out of the readahead cache */
-	cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-	__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
-	__raw_readl(cbr + BMIPS_RAC_CONFIG);
-}
+#include <asm/bmips-dma-coherence.h>
 
 #endif /* __ASM_MACH_BMIPS_DMA_COHERENCE_H */
-- 
2.1.0
