Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2016 19:47:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53223 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993123AbcKYSrYPNhDI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Nov 2016 19:47:24 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 044BB7F063B30;
        Fri, 25 Nov 2016 18:47:14 +0000 (GMT)
Received: from localhost (10.100.200.171) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 25 Nov
 2016 18:47:17 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/3] MIPS: Sanitise DMA unmapping cache sync operations
Date:   Fri, 25 Nov 2016 18:46:11 +0000
Message-ID: <20161125184611.28396-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161125184611.28396-1-paul.burton@imgtec.com>
References: <20161125184611.28396-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.171]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The behaviour of mips_dma_unmap_page() & mips_dma_unmap_sg() with
regards to cache maintenance differ for no good reason. Whilst
mips_dma_unmap_page() correctly takes into account whether a CPU may
have speculatively prefetched data into caches by using
cpu_needs_post_dma_flush(), it ignores the direction of the DMA transfer
& thus performs cache maintenance after DMA_TO_DEVICE transfers for no
good reason. Meanwhile mips_dma_unmap_sg() avoids unnecessary cache
maintenance for DMA_TO_DEVICE transfers but performs unnecessary cache
maintenance on CPUs which cannot have speculatively fetched data into
the caches.

Fix this by using the same condition for cache maintenance in both
mips_dma_unmap_page() & mips_dma_unmap_sg(). We perform cache
maintenance when unmapping if and only if both:

  - cpu_needs_post_dma_flush() returns true, indicating that the device
    performing DMA is not cache-coherent and the CPU may speculatively
    prefetch data from memory being DMAed to.

  - The direction of the DMA is not DMA_TO_DEVICE, meaning that the
    device may have written to memory & we should invalidate our cached
    view in order to observe whatever the device wrote.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/mm/dma-default.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 46d5696..53b00a1 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -293,7 +293,7 @@ static inline void __dma_sync(struct page *page,
 static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	size_t size, enum dma_data_direction direction, unsigned long attrs)
 {
-	if (cpu_needs_post_dma_flush(dev))
+	if (cpu_needs_post_dma_flush(dev) && direction != DMA_TO_DEVICE)
 		__dma_sync(dma_addr_to_page(dev, dma_addr),
 			   dma_addr & ~PAGE_MASK, size, direction);
 	plat_post_dma_flush(dev);
@@ -338,7 +338,7 @@ static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *sg;
 
 	for_each_sg(sglist, sg, nhwentries, i) {
-		if (!plat_device_is_coherent(dev) &&
+		if (cpu_needs_post_dma_flush(dev) &&
 		    direction != DMA_TO_DEVICE)
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
-- 
2.10.2
