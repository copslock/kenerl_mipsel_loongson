Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 07:18:42 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:34226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994687AbeDYFQuSwXHp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 07:16:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wWeeMK/OGPFNhg62rEG7YNxHCRAWoCl5VpvwITCHOhY=; b=bqhbwX8Iw2BFkrPvQsD0G1khO
        yBQ638vSzpGxbcJK2bP/pBM5EuGiudG1yHv/0mdGnahPKW6nyxt5jupBPfB2lvDYlMH+oe2ou/G5T
        qxaxPA5saJ1m4+Rl7FNjy3R5M8UicC1y8K1LOgIdz+Jd+HrzsnLXbsPz7M3JbqZ4kY+h9CTISn+8p
        5GFdfKBHCtdmxK/R4x+2r5j6ilPhP/y0ydjn0/aTQvvyEFKZf3ndNvXzBZcaG2/tO7mZf6sUlgCXc
        dDtwWiZDTv3StOmuc49jBKR/Mdh8NqwJPBQ7F+vu/405LtDZ5QSd3u97ZSdc8zXhMKnLROJxMii3m
        sPheJy7Vg==;
Received: from [93.83.86.253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fBCn5-0005MH-7w; Wed, 25 Apr 2018 05:16:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     sstabellini@kernel.org, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/13] swiotlb: remove the CONFIG_DMA_DIRECT_OPS ifdefs
Date:   Wed, 25 Apr 2018 07:15:39 +0200
Message-Id: <20180425051539.1989-14-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425051539.1989-1-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63752
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

swiotlb now selects the DMA_DIRECT_OPS config symbol, so this will
always be true.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index fece57566d45..6954f7ad200a 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -692,7 +692,6 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 	}
 }
 
-#ifdef CONFIG_DMA_DIRECT_OPS
 static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
 		size_t size)
 {
@@ -764,7 +763,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 				 DMA_ATTR_SKIP_CPU_SYNC);
 	return true;
 }
-#endif
 
 static void
 swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
@@ -1045,7 +1043,6 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
 
-#ifdef CONFIG_DMA_DIRECT_OPS
 void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
@@ -1089,4 +1086,3 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_page		= swiotlb_unmap_page,
 	.dma_supported		= dma_direct_supported,
 };
-#endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.17.0
