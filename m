Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 17:02:46 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:41942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994650AbeDOPAvYLJBu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 17:00:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7B86t5H2GxVvRNjq6VMnMF7/UKSCK8gsOJxCjWfxowk=; b=XUBQYRqhhGM+xcSltS4Ra62di
        n3HGAcaQqp7VH52d34vBkF9ZpCjnDe2HGX+CjcJXb2JMsAZ4/xBxF/KUzBi2p1ZD6m/ZveCBT+F/I
        Zu5HjhWL/UDTlWBm+31YDTAZezETh6cWL/hiWlPc+eOLDLlhvXp+JMUGpALePlLlq7a41GKlH5NZe
        uqzpLKUbquv27cWSpayMgyHWP73Km+OvHrwaYOBvYF/YbGH5L7nFb8Mn4EQZWD+t/4/Qyl1xWxaG9
        r+CFJFgY48ZnAOHz7bCNt8yrEG1ZwqG0pgnop2z7d0LrZ7jOoK/GFWmdsQheMPdZhh/6kjAPeGYGJ
        9uA61ZjXw==;
Received: from 089144200254.atnat0009.highway.a1.net ([89.144.200.254] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1f7j8p-00079u-7G; Sun, 15 Apr 2018 15:00:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/12] swiotlb: remove the CONFIG_DMA_DIRECT_OPS ifdefs
Date:   Sun, 15 Apr 2018 16:59:47 +0200
Message-Id: <20180415145947.1248-13-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415145947.1248-1-hch@lst.de>
References: <20180415145947.1248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+7d17fcac680d61fee2d2+5348+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63548
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
index 47aeb04c1997..07f260319b82 100644
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
 	.dma_supported		= swiotlb_dma_supported,
 };
-#endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.17.0
