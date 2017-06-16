Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:18:28 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:41646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994835AbdFPSMJaXzOW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:12:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ePQ8csrt/oyFhH0nzoCi2cHiPMc1yqeYFTxB0Nl1Vj0=; b=Usn4V+AWUOYqmd/4E4HD/tLzu
        upLgVrKvg8RQVJ1Y23OFhSkN57aZB1nnOgXmXYvF7NJpKbTgjgi8vvyQdAHgaSsRyRywcZsG62XLc
        2rY9UHeNlzUALa8awG5PRLAwQvM6q8VRxCzQwtmnJ+FDSHhAAdR2SEtJfavjk5bhl7cjZOq/IgjPf
        nkE+5RFTOBsA9Zfqv3GCJJvVYYutSWbp1B/H+aRvICD8XkWVt10dsFGRRvolIuaZLIZIxq+Mvwc09
        fizP5jHO6IqdlZDYBeGkjGDFIXpnppDW75H2GFYGZ7t3f28aTZ5yGj64HWBi1kDt4psFmVgPeOLJ7
        n66s+TXcQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvj2-0005Lg-H3; Fri, 16 Jun 2017 18:12:05 +0000
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
Subject: [PATCH 16/44] arm64: remove DMA_ERROR_CODE
Date:   Fri, 16 Jun 2017 20:10:31 +0200
Message-Id: <20170616181059.19206-17-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58547
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

The dma alloc interface returns an error by return NULL, and the
mapping interfaces rely on the mapping_error method, which the dummy
ops already implement correctly.

Thus remove the DMA_ERROR_CODE define.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/dma-mapping.h | 1 -
 arch/arm64/mm/dma-mapping.c          | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 5392dbeffa45..cf8fc8f05580 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -24,7 +24,6 @@
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 
-#define DMA_ERROR_CODE	(~(dma_addr_t)0)
 extern const struct dma_map_ops dummy_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3216e098c058..147fbb907a2f 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -184,7 +184,6 @@ static void *__dma_alloc(struct device *dev, size_t size,
 no_map:
 	__dma_free_coherent(dev, size, ptr, *dma_handle, attrs);
 no_mem:
-	*dma_handle = DMA_ERROR_CODE;
 	return NULL;
 }
 
@@ -487,7 +486,7 @@ static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
 				   enum dma_data_direction dir,
 				   unsigned long attrs)
 {
-	return DMA_ERROR_CODE;
+	return 0;
 }
 
 static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
-- 
2.11.0
