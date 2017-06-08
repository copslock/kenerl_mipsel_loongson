Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:31:25 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:53084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbdFHN04x12DT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:26:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vTzoM7J9JqaEJB5GCYD40QbDafafNo997nHJCC9zKZk=; b=lKNA0j9T+WRAOR9oDKBt5EZyG
        WtRyYmB4xPTQO7iH0H2AeGKgr+oPJyM84Q7sppd9EprD05SpXgUjiJ2A+xvdihq+HYyrXQ88YXHA5
        0yLKlVU78CbDPwNSPfta7UfcqyAm7PzRPbPiElOL+R8rNeM5pV43lzeUKCTCnHw+rd3M5MUnCtzoY
        B+vUE0gsWlh+Axd+DjDPdNvIfAfWH97eQX5ZL9uft6e8UTDJ4fi7kMLdRoj4wwzFLEv8GW4DuQRKY
        jby3zU32aISC6M9/HpmWlmIDf3t9OHN1YcQr4fS763OySU9HsjFUbgcZtE57PxZMFkJaZO7Ujx1Um
        ja9xCxmOg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxSa-0005RU-Ko; Thu, 08 Jun 2017 13:26:49 +0000
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
Subject: [PATCH 08/44] xen-swiotlb: implement ->mapping_error
Date:   Thu,  8 Jun 2017 15:25:33 +0200
Message-Id: <20170608132609.32662-9-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58318
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
 drivers/xen/swiotlb-xen.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a0f006daab48..c3a04b2d7532 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -67,6 +67,8 @@ static unsigned long dma_alloc_coherent_mask(struct device *dev,
 }
 #endif
 
+#define XEN_SWIOTLB_ERROR_CODE	(~(dma_addr_t)0x0)
+
 static char *xen_io_tlb_start, *xen_io_tlb_end;
 static unsigned long xen_io_tlb_nslabs;
 /*
@@ -410,7 +412,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
 				     attrs);
 	if (map == SWIOTLB_MAP_ERROR)
-		return DMA_ERROR_CODE;
+		return XEN_SWIOTLB_ERROR_CODE;
 
 	dev_addr = xen_phys_to_bus(map);
 	xen_dma_map_page(dev, pfn_to_page(map >> PAGE_SHIFT),
@@ -425,7 +427,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
 	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
 
-	return DMA_ERROR_CODE;
+	return XEN_SWIOTLB_ERROR_CODE;
 }
 
 /*
@@ -715,6 +717,11 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size);
 }
 
+static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == XEN_SWIOTLB_ERROR_CODE;
+}
+
 const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.alloc = xen_swiotlb_alloc_coherent,
 	.free = xen_swiotlb_free_coherent,
@@ -730,4 +737,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.set_dma_mask = xen_swiotlb_set_dma_mask,
 	.mmap = xen_swiotlb_dma_mmap,
 	.get_sgtable = xen_swiotlb_get_sgtable,
+	.mapping_error	= xen_swiotlb_mapping_error,
 };
-- 
2.11.0
