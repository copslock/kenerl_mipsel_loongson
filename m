Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:15:15 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:49155 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994665AbeAJIJpumymS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:09:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BeZZ84RWAToWmyQM402TgnuGUv0YXlTNCCAbwjSSR0Y=; b=Lul4JdagXYKxiZmVawRfNzoyF
        alsysOkMXB6CeoCk/xMPkIwUzsINXuuGE9ay3sln4/zVRStn5kyaPVeq2z44/AGD+fw8QwsR1pirX
        SE8uEBhMrvb++hJneGIUvlDJoMgEnjYVxvxVnz6RBKKa+5yxHE9n2FzzzbfGZy4z6siiKQc3yy+4D
        pDmKxh63PtltqDPC5BCRxJOeCW64bU8jd6B6Z9C4hRnxvewiyxvNIOyf3X1Z2CFkD0dvQHaGBOs5y
        uzDC/noiED5l25SNzHN8XHCvbe+B1ICKqkq9tc1kmcRI+HE2EUEMSwNzmsISsTCc+qOUowggMYBvU
        nO59eiNZw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBS5-0007hV-RL; Wed, 10 Jan 2018 08:09:38 +0000
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
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        stable@vger.kernel.org
Subject: [PATCH 01/22] swiotlb: suppress warning when __GFP_NOWARN is set
Date:   Wed, 10 Jan 2018 09:09:11 +0100
Message-Id: <20180110080932.14157-2-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62000
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

TTM tries to allocate coherent memory in chunks of 2MB first to improve
TLB efficiency and falls back to allocating 4K pages if that fails.

Suppress the warning when the 2MB allocations fails since there is a
valid fall back path.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Mike Galbraith <efault@gmx.de>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Bug: https://bugs.freedesktop.org/show_bug.cgi?id=104082
CC: stable@vger.kernel.org
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 6583f3512386..125c1062119f 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -586,7 +586,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 
 not_found:
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
-	if (printk_ratelimit())
+	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return SWIOTLB_MAP_ERROR;
 found:
@@ -713,6 +713,7 @@ void *
 swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		       dma_addr_t *dma_handle, gfp_t flags)
 {
+	bool warn = !(flags & __GFP_NOWARN);
 	dma_addr_t dev_addr;
 	void *ret;
 	int order = get_order(size);
@@ -738,8 +739,8 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		 * GFP_DMA memory; fall back on map_single(), which
 		 * will grab memory from the lowest available address range.
 		 */
-		phys_addr_t paddr = map_single(hwdev, 0, size,
-					       DMA_FROM_DEVICE, 0);
+		phys_addr_t paddr = map_single(hwdev, 0, size, DMA_FROM_DEVICE,
+					       warn ? 0 : DMA_ATTR_NO_WARN);
 		if (paddr == SWIOTLB_MAP_ERROR)
 			goto err_warn;
 
@@ -769,9 +770,11 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	return ret;
 
 err_warn:
-	pr_warn("swiotlb: coherent allocation failed for device %s size=%zu\n",
-		dev_name(hwdev), size);
-	dump_stack();
+	if (warn && printk_ratelimit()) {
+		pr_warn("swiotlb: coherent allocation failed for device %s size=%zu\n",
+			dev_name(hwdev), size);
+		dump_stack();
+	}
 
 	return NULL;
 }
-- 
2.14.2
