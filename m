Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:46:52 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:39325 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994656AbdL2IYDy3Zxj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:24:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IhQmNFvS37SrlefQ2IszwATdl4fz37diwdJg0nSvCrY=; b=DcyRZbTpjS2FECkzajuGxJDgL
        s0orQtXqydM+6bSodmrv/yCYwLb8Nopj6FrkKJTEFT8Ev5zo8z5I2zbpZkcNFQO44pfgEHcvzWCye
        rqb4w+DP0fO/xbXA7PAqvVnihl+4JgBqfgCd/f1+cTq47sA2pMKOAYXKJeuJ8q/8QsoJsMGHADvOP
        R/HhvrihrFB7lI64M872QQYvbxghmEExwS+Aaxd0gVTIWBqN6N9BpRRthuLlojtYLZCRKISO08gi4
        Z5Xi070UTvlekO4gTR+RrxMZCfxspj2lVOY7ZhkTB3mL9iyKNl+7EECHYITTT0X9fYEcvnXKz7/Dk
        sYh+C7z8Q==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpxA-0003r5-Dv; Fri, 29 Dec 2017 08:23:45 +0000
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
Subject: [PATCH 61/67] tile: use generic swiotlb_ops
Date:   Fri, 29 Dec 2017 09:19:05 +0100
Message-Id: <20171229081911.2802-62-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61758
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

These are identical to the tile ops, and would also support CMA
if enabled on tile.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/tile/Kconfig          |  1 +
 arch/tile/kernel/pci-dma.c | 36 +++---------------------------------
 2 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 30c586686f29..ef9d403cbbe4 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -261,6 +261,7 @@ config NEED_SG_DMA_LENGTH
 config SWIOTLB
 	bool
 	default TILEGX
+	select DMA_DIRECT_OPS
 	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
index a9b48520eeb9..6e9365234b6a 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -511,39 +511,9 @@ EXPORT_SYMBOL(gx_pci_dma_map_ops);
 /* PCI DMA mapping functions for legacy PCI devices */
 
 #ifdef CONFIG_SWIOTLB
-static void *tile_swiotlb_alloc_coherent(struct device *dev, size_t size,
-					 dma_addr_t *dma_handle, gfp_t gfp,
-					 unsigned long attrs)
-{
-	gfp |= GFP_DMA32;
-	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
-}
-
-static void tile_swiotlb_free_coherent(struct device *dev, size_t size,
-				       void *vaddr, dma_addr_t dma_addr,
-				       unsigned long attrs)
-{
-	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-}
-
-static const struct dma_map_ops pci_swiotlb_dma_ops = {
-	.alloc = tile_swiotlb_alloc_coherent,
-	.free = tile_swiotlb_free_coherent,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.dma_supported = swiotlb_dma_supported,
-	.mapping_error = swiotlb_dma_mapping_error,
-};
-
 static const struct dma_map_ops pci_hybrid_dma_ops = {
-	.alloc = tile_swiotlb_alloc_coherent,
-	.free = tile_swiotlb_free_coherent,
+	.alloc = swiotlb_alloc,
+	.free = swiotlb_free,
 	.map_page = tile_pci_dma_map_page,
 	.unmap_page = tile_pci_dma_unmap_page,
 	.map_sg = tile_pci_dma_map_sg,
@@ -554,7 +524,7 @@ static const struct dma_map_ops pci_hybrid_dma_ops = {
 	.sync_sg_for_device = tile_pci_dma_sync_sg_for_device,
 };
 
-const struct dma_map_ops *gx_legacy_pci_dma_map_ops = &pci_swiotlb_dma_ops;
+const struct dma_map_ops *gx_legacy_pci_dma_map_ops = &swiotlb_dma_ops;
 const struct dma_map_ops *gx_hybrid_pci_dma_map_ops = &pci_hybrid_dma_ops;
 #else
 const struct dma_map_ops *gx_legacy_pci_dma_map_ops;
-- 
2.14.2
