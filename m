Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:22:21 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:52811 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994554AbeAJIKf0OxAS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QaRfeYU+dux/NV9ElHBpbRyM2tckTUYHcPuObyIRR4A=; b=VHV5rhjNz9Og//NE+1EWVpu3q
        ZtpGKx+er5RtDDzUB5CuYjIh5R346ZDZCV7d5bbrW0TIPD6cvc25NvI2B0RSNJoA8VGNTG6+LDuFi
        oS9EHF4xt4KvAtf3oiELletTO5C/MPt2sqbcmWIZaSiu5/snujQ4r44bvZJV1/nip6jCCmJ9A6RhP
        55DQVPHSRKbOalkuRqs7qhhQIdID+X+hKzKnm8+heQ/klKveU2d8wQ2HJDVwFUJ/dWCnlG7qWiit7
        9v6ZO3vjibaA3Fb2BAuZAch/G4b/2wKniVhO1ixOcvH1wIu3gAMFDWTyBsu/zYSPwcMsRhicbgw6C
        jiddZ1thw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSt-0000Zx-2C; Wed, 10 Jan 2018 08:10:27 +0000
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
Subject: [PATCH 18/22] tile: use generic swiotlb_ops
Date:   Wed, 10 Jan 2018 09:09:28 +0100
Message-Id: <20180110080932.14157-19-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62017
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
index a267fa740048..6a1efe5543fa 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -509,39 +509,9 @@ EXPORT_SYMBOL(gx_pci_dma_map_ops);
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
@@ -552,7 +522,7 @@ static const struct dma_map_ops pci_hybrid_dma_ops = {
 	.sync_sg_for_device = tile_pci_dma_sync_sg_for_device,
 };
 
-const struct dma_map_ops *gx_legacy_pci_dma_map_ops = &pci_swiotlb_dma_ops;
+const struct dma_map_ops *gx_legacy_pci_dma_map_ops = &swiotlb_dma_ops;
 const struct dma_map_ops *gx_hybrid_pci_dma_map_ops = &pci_hybrid_dma_ops;
 #else
 const struct dma_map_ops *gx_legacy_pci_dma_map_ops;
-- 
2.14.2
