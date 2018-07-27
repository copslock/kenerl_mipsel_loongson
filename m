Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 19:26:17 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992747AbeG0R0O1ixXN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2018 19:26:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hd/gmJSxy8hYGAg5GoRfsMuA9Rq4/NqMhueUUC/yfKY=; b=tD0zLuJPXMCTvPGyPMaLLaQXL
        LCmdpJb9iOpP454rNM8+ik8cTO3GUwlGXWM3DQVKbFYpshhpDtVAF+T9nljNA681dM2xL5jsIGbGe
        8fY44gP8PhWTOte6ZD4fSRLrM7hi3am1WVduCSwdo31xB/1uZowlsu9xzvbLGU+/VPBG1g8io3vCG
        RSAmM6OsPWALwa2RfiWlh5Dt4l8yLv6ukZjx9dQuC9QrIsfU4CrJjnSrXLc0v49gPwOG5OhyiQ7wm
        VUFcZx/TYXZU6UZ+Y4u9qfqaUWyvRcMn2SSIB+3Yp80Z9B+MzTtHFf7KrV7bMVOSEJPQOi2h1Fk1i
        0xgO8FzTg==;
Received: from 089144192124.atnat0001.highway.a1.net ([89.144.192.124] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fj6VF-00011y-Uu; Fri, 27 Jul 2018 17:26:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: remove mips_swiotlb_ops
Date:   Fri, 27 Jul 2018 19:26:06 +0200
Message-Id: <20180727172606.21253-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+8db18b5b831fdda8eb66+5451+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65207
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

mips_swiotlb_ops differs from the generic swiotlb_dma_ops only in that
it contains a mb() barrier after each operations that maps or syncs
dma memory to the device.

The dma operations are defined to not be memory barriers, but instead
the write* operations to kick the DMA off are supposed to contain them.

For mips this handled by war_io_reorder_wmb(), which evaluates to the
stronger wmb() instead of the pure compiler barrier barrier() for
just those platforms that use swiotlb, so I think we are covered
properly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/dma-mapping.h |  3 +-
 arch/mips/mm/Makefile               |  1 -
 arch/mips/mm/dma-swiotlb.c          | 61 -----------------------------
 3 files changed, 1 insertion(+), 64 deletions(-)
 delete mode 100644 arch/mips/mm/dma-swiotlb.c

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 1c6e0c8ef4830..8ae7b20b68627 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -3,14 +3,13 @@
 #define _ASM_DMA_MAPPING_H
 
 extern const struct dma_map_ops jazz_dma_ops;
-extern const struct dma_map_ops mips_swiotlb_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #if defined(CONFIG_MACH_JAZZ)
 	return &jazz_dma_ops;
 #elif defined(CONFIG_SWIOTLB)
-	return &mips_swiotlb_ops;
+	return &swiotlb_dma_ops;
 #elif defined(CONFIG_DMA_NONCOHERENT_OPS)
 	return &dma_noncoherent_ops;
 #else
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 6922f393af196..3e5bb203c95ac 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_64BIT)		+= pgtable-64.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-noncoherent.o
-obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 
 obj-$(CONFIG_CPU_R4K_CACHE_TLB) += c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R3000)		+= c-r3k.o tlb-r3k.o
diff --git a/arch/mips/mm/dma-swiotlb.c b/arch/mips/mm/dma-swiotlb.c
deleted file mode 100644
index 6014ed3479fd7..0000000000000
--- a/arch/mips/mm/dma-swiotlb.c
+++ /dev/null
@@ -1,61 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/dma-mapping.h>
-#include <linux/swiotlb.h>
-
-static void *mips_swiotlb_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
-{
-	void *ret = swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
-
-	mb();
-	return ret;
-}
-
-static dma_addr_t mips_swiotlb_map_page(struct device *dev,
-		struct page *page, unsigned long offset, size_t size,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
-					dir, attrs);
-	mb();
-	return daddr;
-}
-
-static int mips_swiotlb_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, attrs);
-	mb();
-
-	return r;
-}
-
-static void mips_swiotlb_sync_single_for_device(struct device *dev,
-		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
-{
-	swiotlb_sync_single_for_device(dev, dma_handle, size, dir);
-	mb();
-}
-
-static void mips_swiotlb_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir)
-{
-	swiotlb_sync_sg_for_device(dev, sg, nents, dir);
-	mb();
-}
-
-const struct dma_map_ops mips_swiotlb_ops = {
-	.alloc			= mips_swiotlb_alloc,
-	.free			= swiotlb_free,
-	.map_page		= mips_swiotlb_map_page,
-	.unmap_page		= swiotlb_unmap_page,
-	.map_sg			= mips_swiotlb_map_sg,
-	.unmap_sg		= swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
-	.sync_single_for_device	= mips_swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu	= swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device	= mips_swiotlb_sync_sg_for_device,
-	.mapping_error		= swiotlb_dma_mapping_error,
-	.dma_supported		= swiotlb_dma_supported,
-};
-EXPORT_SYMBOL(mips_swiotlb_ops);
-- 
2.18.0
