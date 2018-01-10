Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:23:17 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:42953 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994658AbeAJIKmXmu9S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gfCa4i5CyZEikn5WDU5+lgokjLRketpgU5nNf7Pg+qI=; b=VnPJYfusDYcNz8najPUNtE43A
        0fOy8wcPjYvISujQIDHItHu7ftBK2MKNE7iHF/3U32HNQ1hkOuzsjBBtNg1eKf1t5yZQSYwe/+5O4
        ICpZOwtPdR9hBZ+MDDmAoOV74A1+njjX3Z57kkOahJ7VEBX0GcaGA5eJk9o1h1HKz/mXL7GpHgG5C
        AW/oGuQLSGDa44Fr9YELMr96Vsop4iKVqJCRUQ9Z+9X9HZ+pVvYkb491vgGBLc4/T7Dx76W69sHrO
        652uVINy2SF2l6UHCKxNqQOXjUr1PeWHhCTuRJA9xQzLZfdJU9RbmKMZsJcAsrWaGTknT2fbx/fkq
        nGAjDEW5g==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSz-0000me-0k; Wed, 10 Jan 2018 08:10:33 +0000
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
Subject: [PATCH 20/22] mips: use swiotlb_{alloc,free}
Date:   Wed, 10 Jan 2018 09:09:30 +0100
Message-Id: <20180110080932.14157-21-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62019
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

These already include the GFP_DMA/GFP_DMA32 usage, and will use CMA
memory if enabled, thus avoiding the GFP_NORETRY hack.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/cavium-octeon/Kconfig           |  1 +
 arch/mips/cavium-octeon/dma-octeon.c      | 26 +++-----------------------
 arch/mips/loongson64/Kconfig              |  1 +
 arch/mips/loongson64/common/dma-swiotlb.c | 21 ++-------------------
 4 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 204a1670fd9b..b5eee1a57d6c 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -75,6 +75,7 @@ config NEED_SG_DMA_LENGTH
 
 config SWIOTLB
 	def_bool y
+	select DMA_DIRECT_OPS
 	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
 
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 5baf79fce643..c7bb8a407041 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -159,33 +159,13 @@ static void octeon_dma_sync_sg_for_device(struct device *dev,
 static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	void *ret;
-
-	if (IS_ENABLED(CONFIG_ZONE_DMA) && dev == NULL)
-		gfp |= __GFP_DMA;
-	else if (IS_ENABLED(CONFIG_ZONE_DMA) &&
-		 dev->coherent_dma_mask <= DMA_BIT_MASK(24))
-		gfp |= __GFP_DMA;
-	else if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-		 dev->coherent_dma_mask <= DMA_BIT_MASK(32))
-		gfp |= __GFP_DMA32;
-
-	/* Don't invoke OOM killer */
-	gfp |= __GFP_NORETRY;
-
-	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
+	void *ret = swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
 
 	mb();
 
 	return ret;
 }
 
-static void octeon_dma_free_coherent(struct device *dev, size_t size,
-	void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
-{
-	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
-}
-
 static dma_addr_t octeon_unity_phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	return paddr;
@@ -225,7 +205,7 @@ EXPORT_SYMBOL(dma_to_phys);
 static struct octeon_dma_map_ops octeon_linear_dma_map_ops = {
 	.dma_map_ops = {
 		.alloc = octeon_dma_alloc_coherent,
-		.free = octeon_dma_free_coherent,
+		.free = swiotlb_free,
 		.map_page = octeon_dma_map_page,
 		.unmap_page = swiotlb_unmap_page,
 		.map_sg = octeon_dma_map_sg,
@@ -311,7 +291,7 @@ void __init plat_swiotlb_setup(void)
 static struct octeon_dma_map_ops _octeon_pci_dma_map_ops = {
 	.dma_map_ops = {
 		.alloc = octeon_dma_alloc_coherent,
-		.free = octeon_dma_free_coherent,
+		.free = swiotlb_free,
 		.map_page = octeon_dma_map_page,
 		.unmap_page = swiotlb_unmap_page,
 		.map_sg = octeon_dma_map_sg,
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 0d249fc3cfe9..6f109bb54cdb 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -136,6 +136,7 @@ config SWIOTLB
 	bool "Soft IOMMU Support for All-Memory DMA"
 	default y
 	depends on CPU_LOONGSON3
+	select DMA_DIRECT_OPS
 	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
 	select NEED_DMA_MAP_STATE
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index 15388c24a504..7bbcf89475f3 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -13,29 +13,12 @@
 static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	void *ret;
+	void *ret = swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
 
-	if ((IS_ENABLED(CONFIG_ISA) && dev == NULL) ||
-	    (IS_ENABLED(CONFIG_ZONE_DMA) &&
-	     dev->coherent_dma_mask < DMA_BIT_MASK(32)))
-		gfp |= __GFP_DMA;
-	else if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-		 dev->coherent_dma_mask < DMA_BIT_MASK(40))
-		gfp |= __GFP_DMA32;
-
-	gfp |= __GFP_NORETRY;
-
-	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
 	mb();
 	return ret;
 }
 
-static void loongson_dma_free_coherent(struct device *dev, size_t size,
-		void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
-{
-	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
-}
-
 static dma_addr_t loongson_dma_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t size,
 				enum dma_data_direction dir,
@@ -106,7 +89,7 @@ phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 
 static const struct dma_map_ops loongson_dma_map_ops = {
 	.alloc = loongson_dma_alloc_coherent,
-	.free = loongson_dma_free_coherent,
+	.free = swiotlb_free,
 	.map_page = loongson_dma_map_page,
 	.unmap_page = swiotlb_unmap_page,
 	.map_sg = loongson_dma_map_sg,
-- 
2.14.2
