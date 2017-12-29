Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:48:08 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:58807 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994655AbdL2IYPYy14f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:24:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZZzVP5HMzNOZdDYvyboMv4t83qc0gwjZ2w8NhH0U9WY=; b=qVXvz1lAzG1r2USh9QINKrOtR
        Fs8Cwf7S8EK7fCLoT7ctUVyQJCdZlm58y65U49XS+lwK/ioTNvHILvmb7Fao0tvtdV/WkbBbW0y1t
        1Sae6i3Q25ZWTo6ew44vE8bzZ2baGRtds0ZFRXuRSh0FoHjSPg1mH5KQ65ZYzmZ+xKDkHDGRcZiFX
        81xn9ZyprjLPix7J8jMHJMbhXqSXHlOFe/u0UBtPciZ+Zsopq3DX+UrS8BIlBsihu3OJXgSr3eZsk
        pKmGhsbA/lByjCWkQR4+DZD+mTsgGYfVmLjwyn83QWApv/m5FGpsz+3yq7plppTYaOo6qNxUwFk4+
        eibUboqRg==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpxO-000400-4u; Fri, 29 Dec 2017 08:23:58 +0000
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
Subject: [PATCH 64/67] arm64: replace ZONE_DMA with ZONE_DMA32
Date:   Fri, 29 Dec 2017 09:19:08 +0100
Message-Id: <20171229081911.2802-65-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61761
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

arm64 uses ZONE_DMA for allocations below 32-bits.  These days we
name the zone for that ZONE_DMA32, which will allow to use the
dma-direct and generic swiotlb code as-is, so rename it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/Kconfig          |  2 +-
 arch/arm64/mm/dma-mapping.c |  6 +++---
 arch/arm64/mm/init.c        | 16 ++++++++--------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c9a7e9e1414f..6b6985f15d02 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -227,7 +227,7 @@ config GENERIC_CSUM
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
-config ZONE_DMA
+config ZONE_DMA32
 	def_bool y
 
 config HAVE_GENERIC_GUP
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 6840426bbe77..0d641875b20e 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -95,9 +95,9 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
 				  unsigned long attrs)
 {
-	if (IS_ENABLED(CONFIG_ZONE_DMA) &&
+	if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
-		flags |= GFP_DMA;
+		flags |= GFP_DMA32;
 	if (dev_get_cma_area(dev) && gfpflags_allow_blocking(flags)) {
 		struct page *page;
 		void *addr;
@@ -397,7 +397,7 @@ static int __init atomic_pool_init(void)
 		page = dma_alloc_from_contiguous(NULL, nr_pages,
 						 pool_size_order, GFP_KERNEL);
 	else
-		page = alloc_pages(GFP_DMA, pool_size_order);
+		page = alloc_pages(GFP_DMA32, pool_size_order);
 
 	if (page) {
 		int ret;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 00e7b900ca41..8f03276443c9 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -217,7 +217,7 @@ static void __init reserve_elfcorehdr(void)
 }
 #endif /* CONFIG_CRASH_DUMP */
 /*
- * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
+ * Return the maximum physical address for ZONE_DMA32 (DMA_BIT_MASK(32)). It
  * currently assumes that for memory starting above 4G, 32-bit devices will
  * use a DMA offset.
  */
@@ -233,8 +233,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 
-	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		max_zone_pfns[ZONE_DMA] = PFN_DOWN(max_zone_dma_phys());
+	if (IS_ENABLED(CONFIG_ZONE_DMA32))
+		max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());
 	max_zone_pfns[ZONE_NORMAL] = max;
 
 	free_area_init_nodes(max_zone_pfns);
@@ -251,9 +251,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	memset(zone_size, 0, sizeof(zone_size));
 
 	/* 4GB maximum for 32-bit only capable devices */
-#ifdef CONFIG_ZONE_DMA
+#ifdef CONFIG_ZONE_DMA32
 	max_dma = PFN_DOWN(arm64_dma_phys_limit);
-	zone_size[ZONE_DMA] = max_dma - min;
+	zone_size[ZONE_DMA32] = max_dma - min;
 #endif
 	zone_size[ZONE_NORMAL] = max - max_dma;
 
@@ -266,10 +266,10 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 		if (start >= max)
 			continue;
 
-#ifdef CONFIG_ZONE_DMA
+#ifdef CONFIG_ZONE_DMA32
 		if (start < max_dma) {
 			unsigned long dma_end = min(end, max_dma);
-			zhole_size[ZONE_DMA] -= dma_end - start;
+			zhole_size[ZONE_DMA32] -= dma_end - start;
 		}
 #endif
 		if (end > max_dma) {
@@ -467,7 +467,7 @@ void __init arm64_memblock_init(void)
 	early_init_fdt_scan_reserved_mem();
 
 	/* 4GB maximum for 32-bit only capable devices */
-	if (IS_ENABLED(CONFIG_ZONE_DMA))
+	if (IS_ENABLED(CONFIG_ZONE_DMA32))
 		arm64_dma_phys_limit = max_zone_dma_phys();
 	else
 		arm64_dma_phys_limit = PHYS_MASK + 1;
-- 
2.14.2
