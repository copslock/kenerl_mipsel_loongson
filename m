Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2017 17:07:27 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:56343 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992544AbdHYPHR3j9au (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2017 17:07:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=stS2IZ/P859W3k/hi4CVHGW3ps2J7XEFTSf0Y194u2w=; b=uxpAyCR4oG/B3n1+LyqZ8uiVN
        Aq+1QIaXYvtJz50hNkN9cF5iO7aWggBPX0UKVJa3kN0eSQIYu1/cYlJmiqVp3Kgzu6E4tn0A9i+eS
        PtnFKd4rKJKy94fMdERwcWmhO7f0iyHJZVKxPTqWopkzT+sqtmigItN6QF4A9J45siz1QDD/ck40x
        rNunAlONfOVb5POB8jKp9K/GjaacxikTpMCNOB8dgr718TGKEFNYPKA+NXb2OEa3YQQ+ela+voLnE
        BHFID4NTuXf54jNldH1EmFylRq7B75qffNm/Gba2yMdqUY6n5+MasYRYW4LHSOi4243fWTSw5JLaO
        8iW4piOVA==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dlGCZ-0008MY-Cw; Fri, 25 Aug 2017 15:07:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH, resend] mips: consolidate coherent and non-coherent dma_alloc code
Date:   Fri, 25 Aug 2017 17:07:12 +0200
Message-Id: <20170825150712.30311-1-hch@lst.de>
X-Mailer: git-send-email 2.11.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+28109c3b3a6592123617+5115+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59800
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
 arch/mips/mm/dma-default.c | 42 +++---------------------------------------
 1 file changed, 3 insertions(+), 39 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 8e78251eccc2..93bab5d73d10 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -127,23 +127,6 @@ static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
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
@@ -151,13 +134,6 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
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
@@ -172,7 +148,8 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	ret = page_address(page);
 	memset(ret, 0, size);
 	*dma_handle = plat_map_dma_mem(dev, ret, size);
-	if (!plat_device_is_coherent(dev)) {
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT) &&
+	    !plat_device_is_coherent(dev)) {
 		dma_cache_wback_inv((unsigned long) ret, size);
 		ret = UNCAC_ADDR(ret);
 	}
@@ -180,14 +157,6 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
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
@@ -195,14 +164,9 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
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
