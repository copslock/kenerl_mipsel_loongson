Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:22:00 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:47448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994682AbeAJIKedNJ3S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c8GccIKaECffRbMBTVTcR4/ve8yibihJK/p+u5zIuEQ=; b=e20Gz1TJN2CDpzrNtWaJ3th1p
        fbvgsIFS+dpakun6ZrjXbhpaJXeU6LEossIJqILCJPSI6ai+lBFPVfHceNj1LuWOq7QV+MbcBBU/v
        aZbL57bICDii3510LzM/MagpTduiSpotCrF8l/AxvFrfyGyVbYejq9g31Eikx7PfwzMbVwRgzdREg
        h/EfHxRra131N5VmTYBZcKEimOiDImhm6HMD/copLDCj2oQhdPCBAfFkyCQsX9V7SokL0nkWMG9Ol
        Z1g78Oel+jjoeEadaG1pHb3jAQP45PXG4Kt6pTjJcYjmo5YmmqVxUfihQcmy4uWZg94J3skohSMTF
        5OBQUFiyw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSn-0000NA-5B; Wed, 10 Jan 2018 08:10:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/22] unicore32: use generic swiotlb_ops
Date:   Wed, 10 Jan 2018 09:09:26 +0100
Message-Id: <20180110080932.14157-17-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

These are identical to the unicore32 ops, and would also support CMA
if enabled on unicore32.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/unicore32/include/asm/dma-mapping.h |  9 +-----
 arch/unicore32/mm/Kconfig                |  1 +
 arch/unicore32/mm/Makefile               |  2 --
 arch/unicore32/mm/dma-swiotlb.c          | 48 --------------------------------
 4 files changed, 2 insertions(+), 58 deletions(-)
 delete mode 100644 arch/unicore32/mm/dma-swiotlb.c

diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
index f2bfec273aa7..790bc2ef4af2 100644
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ b/arch/unicore32/include/asm/dma-mapping.h
@@ -12,18 +12,11 @@
 #ifndef __UNICORE_DMA_MAPPING_H__
 #define __UNICORE_DMA_MAPPING_H__
 
-#ifdef __KERNEL__
-
-#include <linux/mm_types.h>
-#include <linux/scatterlist.h>
 #include <linux/swiotlb.h>
 
-extern const struct dma_map_ops swiotlb_dma_map_ops;
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return &swiotlb_dma_map_ops;
+	return &swiotlb_dma_ops;
 }
 
-#endif /* __KERNEL__ */
 #endif
diff --git a/arch/unicore32/mm/Kconfig b/arch/unicore32/mm/Kconfig
index c256460cd363..e9154a59d561 100644
--- a/arch/unicore32/mm/Kconfig
+++ b/arch/unicore32/mm/Kconfig
@@ -42,6 +42,7 @@ config CPU_TLB_SINGLE_ENTRY_DISABLE
 
 config SWIOTLB
 	def_bool y
+	select DMA_DIRECT_OPS
 
 config IOMMU_HELPER
 	def_bool SWIOTLB
diff --git a/arch/unicore32/mm/Makefile b/arch/unicore32/mm/Makefile
index 681c0ef5ec9e..8106260583ab 100644
--- a/arch/unicore32/mm/Makefile
+++ b/arch/unicore32/mm/Makefile
@@ -6,8 +6,6 @@
 obj-y				:= extable.o fault.o init.o pgd.o mmu.o
 obj-y				+= flush.o ioremap.o
 
-obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
-
 obj-$(CONFIG_MODULES)		+= proc-syms.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
deleted file mode 100644
index 525413d6690e..000000000000
--- a/arch/unicore32/mm/dma-swiotlb.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Contains routines needed to support swiotlb for UniCore32.
- *
- * Copyright (C) 2010 Guan Xuetao
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/pci.h>
-#include <linux/cache.h>
-#include <linux/module.h>
-#include <linux/dma-mapping.h>
-#include <linux/swiotlb.h>
-#include <linux/bootmem.h>
-
-#include <asm/dma.h>
-
-static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
-					    dma_addr_t *dma_handle, gfp_t flags,
-					    unsigned long attrs)
-{
-	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
-}
-
-static void unicore_swiotlb_free_coherent(struct device *dev, size_t size,
-					  void *vaddr, dma_addr_t dma_addr,
-					  unsigned long attrs)
-{
-	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-}
-
-const struct dma_map_ops swiotlb_dma_map_ops = {
-	.alloc = unicore_swiotlb_alloc_coherent,
-	.free = unicore_swiotlb_free_coherent,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.dma_supported = swiotlb_dma_supported,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.mapping_error = swiotlb_dma_mapping_error,
-};
-EXPORT_SYMBOL(swiotlb_dma_map_ops);
-- 
2.14.2
