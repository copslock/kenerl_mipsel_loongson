Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:39:29 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:54079 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993974AbdFHN1wr4m0T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:27:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NsCauiJjtxIL6EQZRTdwQUm2PGp36ycj6PWtgh9RHl4=; b=EB7Kvf7dk9MzqSukbykqAvOYC
        s7tkGo3n3ULPLIBeBGi9y6hWHI742ghfHoiECoZjlH70B4IvPFwMvLDzlGGMI17ArpY3CkTvm4Q2L
        uOhqjp8OnxodxuzLIL3NDi9HjZksTqK9ueXBp2Bi04l/geaMf7nPTvehihJ6WtSccEWqMdiRLiXFE
        PPWqB7+lEn4twW/KprsyXaGa7qzkynDOZRw7iVbsMrAqWGNWte6LW1mD+zZN5Izw6btsr7TkepRAC
        2Xzks0zkGslXzR6ORbXpr6TU6OhnKKUa5Vx8a/iAyfOrUnlIpn2v5RAXWOkIOFEtUwfFdVI4asjaY
        MpF3Jqd0w==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxTW-0006kC-4A; Thu, 08 Jun 2017 13:27:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 23/44] x86/calgary: implement ->mapping_error
Date:   Thu,  8 Jun 2017 15:25:48 +0200
Message-Id: <20170608132609.32662-24-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58334
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

DMA_ERROR_CODE is going to go away, so don't rely on it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/pci-calgary_64.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index fda7867046d0..e75b490f2b0b 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -50,6 +50,8 @@
 #include <asm/x86_init.h>
 #include <asm/iommu_table.h>
 
+#define CALGARY_MAPPING_ERROR	0
+
 #ifdef CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT
 int use_calgary __read_mostly = 1;
 #else
@@ -252,7 +254,7 @@ static unsigned long iommu_range_alloc(struct device *dev,
 			if (panic_on_overflow)
 				panic("Calgary: fix the allocator.\n");
 			else
-				return DMA_ERROR_CODE;
+				return CALGARY_MAPPING_ERROR;
 		}
 	}
 
@@ -272,10 +274,10 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 
 	entry = iommu_range_alloc(dev, tbl, npages);
 
-	if (unlikely(entry == DMA_ERROR_CODE)) {
+	if (unlikely(entry == CALGARY_MAPPING_ERROR)) {
 		pr_warn("failed to allocate %u pages in iommu %p\n",
 			npages, tbl);
-		return DMA_ERROR_CODE;
+		return CALGARY_MAPPING_ERROR;
 	}
 
 	/* set the return dma address */
@@ -295,7 +297,7 @@ static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 	unsigned long flags;
 
 	/* were we called with bad_dma_address? */
-	badend = DMA_ERROR_CODE + (EMERGENCY_PAGES * PAGE_SIZE);
+	badend = CALGARY_MAPPING_ERROR + (EMERGENCY_PAGES * PAGE_SIZE);
 	if (unlikely(dma_addr < badend)) {
 		WARN(1, KERN_ERR "Calgary: driver tried unmapping bad DMA "
 		       "address 0x%Lx\n", dma_addr);
@@ -380,7 +382,7 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 		npages = iommu_num_pages(vaddr, s->length, PAGE_SIZE);
 
 		entry = iommu_range_alloc(dev, tbl, npages);
-		if (entry == DMA_ERROR_CODE) {
+		if (entry == CALGARY_MAPPING_ERROR) {
 			/* makes sure unmap knows to stop */
 			s->dma_length = 0;
 			goto error;
@@ -398,7 +400,7 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 error:
 	calgary_unmap_sg(dev, sg, nelems, dir, 0);
 	for_each_sg(sg, s, nelems, i) {
-		sg->dma_address = DMA_ERROR_CODE;
+		sg->dma_address = CALGARY_MAPPING_ERROR;
 		sg->dma_length = 0;
 	}
 	return 0;
@@ -453,7 +455,7 @@ static void* calgary_alloc_coherent(struct device *dev, size_t size,
 
 	/* set up tces to cover the allocated range */
 	mapping = iommu_alloc(dev, tbl, ret, npages, DMA_BIDIRECTIONAL);
-	if (mapping == DMA_ERROR_CODE)
+	if (mapping == CALGARY_MAPPING_ERROR)
 		goto free;
 	*dma_handle = mapping;
 	return ret;
@@ -478,6 +480,11 @@ static void calgary_free_coherent(struct device *dev, size_t size,
 	free_pages((unsigned long)vaddr, get_order(size));
 }
 
+static int calgary_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == CALGARY_MAPPING_ERROR;
+}
+
 static const struct dma_map_ops calgary_dma_ops = {
 	.alloc = calgary_alloc_coherent,
 	.free = calgary_free_coherent,
@@ -485,6 +492,7 @@ static const struct dma_map_ops calgary_dma_ops = {
 	.unmap_sg = calgary_unmap_sg,
 	.map_page = calgary_map_page,
 	.unmap_page = calgary_unmap_page,
+	.mapping_error = calgary_mapping_error,
 };
 
 static inline void __iomem * busno_to_bbar(unsigned char num)
@@ -732,7 +740,7 @@ static void __init calgary_reserve_regions(struct pci_dev *dev)
 	struct iommu_table *tbl = pci_iommu(dev->bus);
 
 	/* reserve EMERGENCY_PAGES from bad_dma_address and up */
-	iommu_range_reserve(tbl, DMA_ERROR_CODE, EMERGENCY_PAGES);
+	iommu_range_reserve(tbl, CALGARY_MAPPING_ERROR, EMERGENCY_PAGES);
 
 	/* avoid the BIOS/VGA first 640KB-1MB region */
 	/* for CalIOC2 - avoid the entire first MB */
-- 
2.11.0
