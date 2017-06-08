Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:30:17 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:56786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993865AbdFHN0opjpkT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:26:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dS/Sr4yNzJTgOXlGLtQH5Z/3++0lO3XctvhSysctBVY=; b=J7iaT5DsQQGQH6fXQTn0oiwAq
        t7d34/pUtKmTj4DTUOAVEWvPTnHn/H9qpyAu8jyZzIG8ZgsNysbIJoo0XyPU9b7QVRzf0s3I1oWvW
        wskQlQhlpbAuRJDUdKhJr5XIpmldANwYce6Qj03Ugs01bTCeyvuD/pwhJD0UdkxY+r5Uy9iTh5W5e
        SKhuFCQJ518poxTKjPdtEBsw7HH1WegPLjsLPOQcX1L4namoFhJdHkFAUN96YGZieeiS71PmRXk9d
        GhwpVxiFTTqz7BHMffRP5Nsqm1oEiq805XmRqvjAaee2/EEJU7ZPa2reEWJHZwlNeqHfCAvXlWcN5
        if8GU0O+g==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxSS-0005G8-M4; Thu, 08 Jun 2017 13:26:41 +0000
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
Subject: [PATCH 06/44] iommu/dma: don't rely on DMA_ERROR_CODE
Date:   Thu,  8 Jun 2017 15:25:31 +0200
Message-Id: <20170608132609.32662-7-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58316
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

DMA_ERROR_CODE is not a public API and will go away soon.  dma dma-iommu
driver already implements a proper ->mapping_error method, so it's only
using the value internally.  Add a new local define using the value
that arm64 which is the only current user of dma-iommu.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 62618e77bedc..638aea814b94 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -31,6 +31,8 @@
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
 
+#define IOMMU_MAPPING_ERROR	(~(dma_addr_t)0)
+
 struct iommu_dma_msi_page {
 	struct list_head	list;
 	dma_addr_t		iova;
@@ -500,7 +502,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 {
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), *handle, size);
 	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
-	*handle = DMA_ERROR_CODE;
+	*handle = IOMMU_MAPPING_ERROR;
 }
 
 /**
@@ -533,7 +535,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	dma_addr_t iova;
 	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
 
-	*handle = DMA_ERROR_CODE;
+	*handle = IOMMU_MAPPING_ERROR;
 
 	min_size = alloc_sizes & -alloc_sizes;
 	if (min_size < PAGE_SIZE) {
@@ -627,11 +629,11 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
 	if (!iova)
-		return DMA_ERROR_CODE;
+		return IOMMU_MAPPING_ERROR;
 
 	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
 		iommu_dma_free_iova(cookie, iova, size);
-		return DMA_ERROR_CODE;
+		return IOMMU_MAPPING_ERROR;
 	}
 	return iova + iova_off;
 }
@@ -671,7 +673,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 		s->offset += s_iova_off;
 		s->length = s_length;
-		sg_dma_address(s) = DMA_ERROR_CODE;
+		sg_dma_address(s) = IOMMU_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
 		/*
@@ -714,11 +716,11 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		if (sg_dma_address(s) != DMA_ERROR_CODE)
+		if (sg_dma_address(s) != IOMMU_MAPPING_ERROR)
 			s->offset += sg_dma_address(s);
 		if (sg_dma_len(s))
 			s->length = sg_dma_len(s);
-		sg_dma_address(s) = DMA_ERROR_CODE;
+		sg_dma_address(s) = IOMMU_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 	}
 }
@@ -836,7 +838,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
-	return dma_addr == DMA_ERROR_CODE;
+	return dma_addr == IOMMU_MAPPING_ERROR;
 }
 
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
-- 
2.11.0
