Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:48:37 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:47111 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990718AbdL2IYUA3F0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:24:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d9yo9fHW4ItpknfB0sU/txVi1NJGOiW6nZtuvSW+jKA=; b=qIV2UL2SQJj1BQZCBnl2SHv5z
        PxI7bH7IixCKsvhI533I/qy3mexHbiqtZ0/kIEEicLNUo9VS3SWzK4itsVurSgrcWCA+ycX3v+y1v
        V2GmvoL3sVUXa6Qxz6ayDfO0xeXtQWEKaiYvGeFfcY+EjwnZHpXPBJsIkUqrq3JoV9usVBu9x9H79
        pcgeYlRgGKEpswY15/s9M6HzOlCsWrlSKnNfQdYiJDCG55kvtI2adKpQ/wrHCslKJjn0Ovj/bfKyv
        6HKJTgGdOrD75Za9IUlFPUtkff9X2RyX7S0ApM8VIXGB3in9zb4687+dImmeiCI4Zqi09/5F/gZIg
        2MXwyWk5w==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpxS-00042x-LI; Fri, 29 Dec 2017 08:24:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 65/67] arm64: use swiotlb_alloc and swiotlb_free
Date:   Fri, 29 Dec 2017 09:19:09 +0100
Message-Id: <20171229081911.2802-66-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61762
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
