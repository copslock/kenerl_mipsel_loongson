Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 09:12:41 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:45706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993859AbdFPHMepBb5t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 09:12:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:To:From:
        Sender:Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cEahlGQ8eVDkeRnRX0ftFCMxy/F3gIvnm8O8gzZkJjE=; b=giV0uV/DbPLe9PHg6DO7+FBbB
        KUiD6rTEwz3nXKowtPUlDpInCGxQ+S3mRWO43ZeivGdjiT15N/L9kMkDxOqhU3WNPEeWCjlcJnbKB
        1p2k2gye1BlBrgHBQ5audEVx4IaaZxPqH98MV4ASDNXPNbZtJTgNjgPtxQuxloP1bztbXA8sJ0gJ6
        //zxpalmr9oh5GGeb9RuAmdDH/0SfzAOcVHP9ftEtuJGY9qDqeELFKxjJ31lV4gz7Dopyn2vroy1v
        FGAn4p4klWL1wvgeh13brVjO1yEZehgRH8mExbZ2GbJVgYr12FrWjvmMskVyzEdJyqNWGUXX4yW6R
        lEtbOmeRQ==;
Received: from 178.114.185.122.wireless.dyn.drei.com ([178.114.185.122] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLlQm-0006D1-7d; Fri, 16 Jun 2017 07:12:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] mips: consolidate coherent and non-coherent dma_alloc code
Date:   Fri, 16 Jun 2017 09:12:29 +0200
Message-Id: <20170616071229.16954-1-hch@lst.de>
X-Mailer: git-send-email 2.11.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58507
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

Besides eliminating lots of duplication this also allows allocations with
the DMA_ATTR_NON_CONSISTENT to use the CMA allocator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Note: compile tested only.

 arch/mips/mm/dma-default.c | 42 +++---------------------------------------
 1 file changed, 3 insertions(+), 39 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index fe8df14b6169..9e0faaf9f96f 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -114,23 +114,6 @@ static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
 	return gfp | dma_flag;
 }
 
-static void *mips_dma_alloc_noncoherent(struct device *dev, size_t size,
-	dma_addr_t * dma_handle, gfp_t gfp)
-{
-	void *ret;
-
-	gfp = massage_gfp_flags(dev, gfp);
-
-	ret = (void *) __get_free_pages(gfp, get_order(size));
-
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = plat_map_dma_mem(dev, ret, size);
-	}
-
-	return ret;
-}
-
 static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
@@ -138,13 +121,6 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	struct page *page = NULL;
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-	/*
-	 * XXX: seems like the coherent and non-coherent implementations could
-	 * be consolidated.
-	 */
-	if (attrs & DMA_ATTR_NON_CONSISTENT)
-		return mips_dma_alloc_noncoherent(dev, size, dma_handle, gfp);
-
 	gfp = massage_gfp_flags(dev, gfp);
 
 	if (IS_ENABLED(CONFIG_DMA_CMA) && gfpflags_allow_blocking(gfp))
@@ -159,7 +135,8 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	ret = page_address(page);
 	memset(ret, 0, size);
 	*dma_handle = plat_map_dma_mem(dev, ret, size);
-	if (!plat_device_is_coherent(dev)) {
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT) &&
+	    !plat_device_is_coherent(dev)) {
 		dma_cache_wback_inv((unsigned long) ret, size);
 		ret = UNCAC_ADDR(ret);
 	}
@@ -167,14 +144,6 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 }
 
-
-static void mips_dma_free_noncoherent(struct device *dev, size_t size,
-		void *vaddr, dma_addr_t dma_handle)
-{
-	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
-	free_pages((unsigned long) vaddr, get_order(size));
-}
-
 static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	dma_addr_t dma_handle, unsigned long attrs)
 {
@@ -182,14 +151,9 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page *page = NULL;
 
-	if (attrs & DMA_ATTR_NON_CONSISTENT) {
-		mips_dma_free_noncoherent(dev, size, vaddr, dma_handle);
-		return;
-	}
-
 	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
 
-	if (!plat_device_is_coherent(dev))
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT) && !plat_device_is_coherent(dev))
 		addr = CAC_ADDR(addr);
 
 	page = virt_to_page((void *) addr);
-- 
2.11.0
