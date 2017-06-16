Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:27:55 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:60052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994855AbdFPSNePWfuW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:13:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YP1GlHzuDHzeCHOaI6bMloC7cS7wXS8NaF48ukdIL/w=; b=LO6ojfDUbLUUnXvFhYNJ3y4q7
        aeLSARhC6ku1j+Xdc8A4Kca3q18Bv94hu0j14Uxv4P30g/QjY7oJWPgWwS0j1w+cl1aAxWWTHwFNn
        xaW93dyqwgCHE9S6KvsxlVaI7QL1Abmc4HqYOVDUOTId/Y3k2QmN3bYf2Od46CsO7YLoMZxZEDaxM
        /CgfjDItBvqkeaYmVFXod4onjhQnPW7M+aoHcRQbEFy2ZpvTG852+7rsR5y2XfTwbJUliNlqOzy+v
        OqAGJ2htSZcrCuY1Z5y6GGhodIe34MEvCN45fj6NOSP1t/Vq6iM8dY/8JouR13iocJ6AMFZZEwHiy
        /4EiqClng==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvkN-00070m-09; Fri, 16 Jun 2017 18:13:27 +0000
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
Subject: [PATCH 39/44] xen-swiotlb: remove xen_swiotlb_set_dma_mask
Date:   Fri, 16 Jun 2017 20:10:54 +0200
Message-Id: <20170616181059.19206-40-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58570
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

This just duplicates the generic implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index c3a04b2d7532..82fc54f8eb77 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -661,17 +661,6 @@ xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return xen_virt_to_bus(xen_io_tlb_end - 1) <= mask;
 }
 
-static int
-xen_swiotlb_set_dma_mask(struct device *dev, u64 dma_mask)
-{
-	if (!dev->dma_mask || !xen_swiotlb_dma_supported(dev, dma_mask))
-		return -EIO;
-
-	*dev->dma_mask = dma_mask;
-
-	return 0;
-}
-
 /*
  * Create userspace mapping for the DMA-coherent memory.
  * This function should be called with the pages from the current domain only,
@@ -734,7 +723,6 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.map_page = xen_swiotlb_map_page,
 	.unmap_page = xen_swiotlb_unmap_page,
 	.dma_supported = xen_swiotlb_dma_supported,
-	.set_dma_mask = xen_swiotlb_set_dma_mask,
 	.mmap = xen_swiotlb_dma_mmap,
 	.get_sgtable = xen_swiotlb_get_sgtable,
 	.mapping_error	= xen_swiotlb_mapping_error,
-- 
2.11.0
