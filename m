Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:24:07 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:40063 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994689AbeAJIKwhYLTS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d9yo9fHW4ItpknfB0sU/txVi1NJGOiW6nZtuvSW+jKA=; b=FJ0PmtksAGKFV16X/WnZjl+U7
        txbd/mrmE8kvKFPyd2KlpbnZRbl/lPxn/+F4yBXXUXYR5qgHAOiaxP6Lcp28/HEWkNR6OsFxHS2oe
        m0xf7ECh2zc03shfW/aYAUVXyhNUmC6I6CMTvQ/tqSWZwv5+iZXD/SqI4JkhBSJcP3K3walYffpRa
        XBLEiyMgaWdelVSb1VRYCoEK6eavgp3tEfae/odwB+JJY/b+AqDam7KiXoNv/smNhObud2PvjCZFq
        VpF+tllrJiM+c7sE9jKseiQvq3kZBvajKe6bkO062ylqHIbjtoBpDkBsBcO98KX2GqolWadn8wIn+
        rug8NUZGQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBT4-0000y5-SE; Wed, 10 Jan 2018 08:10:39 +0000
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
Subject: [PATCH 22/22] arm64: use swiotlb_alloc and swiotlb_free
Date:   Wed, 10 Jan 2018 09:09:32 +0100
Message-Id: <20180110080932.14157-23-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62021
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

The generic swiotlb_alloc and swiotlb_free routines already take care
of CMA allocations and adding GFP_DMA32 where needed, so use them
instead of the arm specific helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/mm/dma-mapping.c | 46 +++------------------------------------------
 2 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6b6985f15d02..53205c02b18a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -59,6 +59,7 @@ config ARM64
 	select COMMON_CLK
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS
+	select DMA_DIRECT_OPS
 	select EDAC_SUPPORT
 	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 0d641875b20e..a96ec0181818 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -91,46 +91,6 @@ static int __free_from_pool(void *start, size_t size)
 	return 1;
 }
 
-static void *__dma_alloc_coherent(struct device *dev, size_t size,
-				  dma_addr_t *dma_handle, gfp_t flags,
-				  unsigned long attrs)
-{
-	if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
-		flags |= GFP_DMA32;
-	if (dev_get_cma_area(dev) && gfpflags_allow_blocking(flags)) {
-		struct page *page;
-		void *addr;
-
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-						 get_order(size), flags);
-		if (!page)
-			return NULL;
-
-		*dma_handle = phys_to_dma(dev, page_to_phys(page));
-		addr = page_address(page);
-		memset(addr, 0, size);
-		return addr;
-	} else {
-		return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
-	}
-}
-
-static void __dma_free_coherent(struct device *dev, size_t size,
-				void *vaddr, dma_addr_t dma_handle,
-				unsigned long attrs)
-{
-	bool freed;
-	phys_addr_t paddr = dma_to_phys(dev, dma_handle);
-
-
-	freed = dma_release_from_contiguous(dev,
-					phys_to_page(paddr),
-					size >> PAGE_SHIFT);
-	if (!freed)
-		swiotlb_free_coherent(dev, size, vaddr, dma_handle);
-}
-
 static void *__dma_alloc(struct device *dev, size_t size,
 			 dma_addr_t *dma_handle, gfp_t flags,
 			 unsigned long attrs)
@@ -152,7 +112,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
 		return addr;
 	}
 
-	ptr = __dma_alloc_coherent(dev, size, dma_handle, flags, attrs);
+	ptr = swiotlb_alloc(dev, size, dma_handle, flags, attrs);
 	if (!ptr)
 		goto no_mem;
 
@@ -173,7 +133,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
 	return coherent_ptr;
 
 no_map:
-	__dma_free_coherent(dev, size, ptr, *dma_handle, attrs);
+	swiotlb_free(dev, size, ptr, *dma_handle, attrs);
 no_mem:
 	return NULL;
 }
@@ -191,7 +151,7 @@ static void __dma_free(struct device *dev, size_t size,
 			return;
 		vunmap(vaddr);
 	}
-	__dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
+	swiotlb_free(dev, size, swiotlb_addr, dma_handle, attrs);
 }
 
 static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
-- 
2.14.2
