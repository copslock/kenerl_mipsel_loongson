Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:19:18 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:44482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994853AbdFPSMQMUAjW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:12:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1dtxUOxP7ZlKqBs8WTsw3wVNwLvNEAwp0in+GBgczaI=; b=EPMyhyQjO/q0CE6xKavgOu/N0
        I7rfI+HdFYeoTkqQ4EYHVg9y+u2Z0ndkfugoYAD28vwvAUDgreApM7RGBhQ4/923Rno+qfETucUm6
        oYhdaXhekcXCTHW6DhmVzUE8JPSAiW98vUF8IQE4Ckm+CWniRxAmE18WWcHQXdivls5sj0kHtSBRb
        bBrsfOfkYlNBPmT6fxfSgFebEThI3ZzsKbdfoc8DwIZMQQi0si336d0E5qpPOG46uxXuHa1KnkfgS
        dEd7KdSmifgmVynoloWcfg7v0lhm8fwVfHlmXg1TNmg2HWuhzRDS3J4HDinQoZJGAZ0kTjV9M9pAy
        s9UQjg7qw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvj9-0005Pq-5y; Fri, 16 Jun 2017 18:12:11 +0000
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
Subject: [PATCH 18/44] iommu/amd: implement ->mapping_error
Date:   Fri, 16 Jun 2017 20:10:33 +0200
Message-Id: <20170616181059.19206-19-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58549
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
 drivers/iommu/amd_iommu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 63cacf5d6cf2..d41280e869de 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -54,6 +54,8 @@
 #include "amd_iommu_types.h"
 #include "irq_remapping.h"
 
+#define AMD_IOMMU_MAPPING_ERROR	0
+
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
 #define LOOP_TIMEOUT	100000
@@ -2394,7 +2396,7 @@ static dma_addr_t __map_single(struct device *dev,
 	paddr &= PAGE_MASK;
 
 	address = dma_ops_alloc_iova(dev, dma_dom, pages, dma_mask);
-	if (address == DMA_ERROR_CODE)
+	if (address == AMD_IOMMU_MAPPING_ERROR)
 		goto out;
 
 	prot = dir2prot(direction);
@@ -2431,7 +2433,7 @@ static dma_addr_t __map_single(struct device *dev,
 
 	dma_ops_free_iova(dma_dom, address, pages);
 
-	return DMA_ERROR_CODE;
+	return AMD_IOMMU_MAPPING_ERROR;
 }
 
 /*
@@ -2483,7 +2485,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	if (PTR_ERR(domain) == -EINVAL)
 		return (dma_addr_t)paddr;
 	else if (IS_ERR(domain))
-		return DMA_ERROR_CODE;
+		return AMD_IOMMU_MAPPING_ERROR;
 
 	dma_mask = *dev->dma_mask;
 	dma_dom = to_dma_ops_domain(domain);
@@ -2560,7 +2562,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	npages = sg_num_pages(dev, sglist, nelems);
 
 	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
-	if (address == DMA_ERROR_CODE)
+	if (address == AMD_IOMMU_MAPPING_ERROR)
 		goto out_err;
 
 	prot = dir2prot(direction);
@@ -2683,7 +2685,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
 				 size, DMA_BIDIRECTIONAL, dma_mask);
 
-	if (*dma_addr == DMA_ERROR_CODE)
+	if (*dma_addr == AMD_IOMMU_MAPPING_ERROR)
 		goto out_free;
 
 	return page_address(page);
@@ -2732,6 +2734,11 @@ static int amd_iommu_dma_supported(struct device *dev, u64 mask)
 	return check_device(dev);
 }
 
+static int amd_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == AMD_IOMMU_MAPPING_ERROR;
+}
+
 static const struct dma_map_ops amd_iommu_dma_ops = {
 	.alloc		= alloc_coherent,
 	.free		= free_coherent,
@@ -2740,6 +2747,7 @@ static const struct dma_map_ops amd_iommu_dma_ops = {
 	.map_sg		= map_sg,
 	.unmap_sg	= unmap_sg,
 	.dma_supported	= amd_iommu_dma_supported,
+	.mapping_error	= amd_iommu_mapping_error,
 };
 
 static int init_reserved_iova_ranges(void)
-- 
2.11.0
