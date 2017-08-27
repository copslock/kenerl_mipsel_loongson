Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2017 18:15:41 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:40724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994947AbdH0QLHvygnp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Aug 2017 18:11:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kgNysyjYcPnDRwL3fNO+ZZ6QEX1wS5LsiSP4LsCn9F0=; b=Q72jTQ+llCfRCDtvJn+03HqT7
        2gbXxlSVVceE4/9NJNYFXSHTAsdnrMYu6nHrAmatg3eSYqYCFt2uACqru11PQcFjQzFYMpq6FEnJs
        zh9K3N/KBxn1oUK42vUH6jTfsYuW3R9PBbfitWPHTUiT76ExeNDYjWntjnXAISEbZO2niVuIicjTM
        Ozoq3LgnXHKCieSqIp0GKk5rju7TfKpx2F877kQ5pSccyd6+pPkVUNWRt5EIKmnL3oLegBQ7VZSZF
        ARDPyw9Mmx3NDOrTuCRAZd9EacdcQunDUx3miPAkc6TzaAaQPHlUmmHHLwSj3QJUFmYLUAiYRq3rE
        +kpo8eDDg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dm09O-0006tz-2g; Sun, 27 Aug 2017 16:11:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        David Howells <dhowells@redhat.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] xtensa: make dma_cache_sync a no-op
Date:   Sun, 27 Aug 2017 18:10:30 +0200
Message-Id: <20170827161032.22772-11-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170827161032.22772-1-hch@lst.de>
References: <20170827161032.22772-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0d43c28c1e7909f7e68d+5117+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59825
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

xtensa does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
doesn't make any sense to do any work in dma_cache_sync given that it
must be a no-op when dma_alloc_attrs returns coherent memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/dma-mapping.h |  6 ++++--
 arch/xtensa/kernel/pci-dma.c          | 23 -----------------------
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index 269738dc9d1d..353e0314d6ba 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -23,8 +23,10 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &xtensa_dma_map_ops;
 }
 
-void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		    enum dma_data_direction direction);
+static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		    enum dma_data_direction direction)
+{
+}
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index cec86a1c2acc..623720a11143 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -26,29 +26,6 @@
 #include <asm/cacheflush.h>
 #include <asm/io.h>
 
-void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		    enum dma_data_direction dir)
-{
-	switch (dir) {
-	case DMA_BIDIRECTIONAL:
-		__flush_invalidate_dcache_range((unsigned long)vaddr, size);
-		break;
-
-	case DMA_FROM_DEVICE:
-		__invalidate_dcache_range((unsigned long)vaddr, size);
-		break;
-
-	case DMA_TO_DEVICE:
-		__flush_dcache_range((unsigned long)vaddr, size);
-		break;
-
-	case DMA_NONE:
-		BUG();
-		break;
-	}
-}
-EXPORT_SYMBOL(dma_cache_sync);
-
 static void do_cache_op(dma_addr_t dma_handle, size_t size,
 			void (*fn)(unsigned long, unsigned long))
 {
-- 
2.11.0
