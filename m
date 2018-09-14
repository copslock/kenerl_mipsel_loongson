Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 11:59:57 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:47858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeINJ6hpM1WI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 11:58:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mBKIY7ltGFEPcnkQoxokdxXsUUzg3Mh9YZOdV8lUC6U=; b=q6Omu+u0v/0sd/sOmEeoyvQpd
        otGJu+0kaoBUVIURSPcVZDksnr/blh8BbnCQd23h/NG96FAU2z/uOROQaul6tzpACka4QhKFvYll+
        3pr4PUovZY1+hXg/3CDp9P2RqupgHoSGY0bd2uThXwkgqB1vpaAn3aQJ8eMJH5o7CSyVReKAFfaXB
        KRSpoIJ+7T5ylie8mOtxyiaLpsQdLH7bi/IIP0jchfisedMh1dxR2caL2+3C5otzuZeCpEGPGyUVR
        wsKUicUZFXVwigGgsr/bRyIpIcbkHwG5BmSyOZcv9ab7gKY+63z6kobOMTR6ZlGeueC6BDUJzx21J
        MYXuR3Vaw==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0krx-0000Y1-52; Fri, 14 Sep 2018 09:58:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] dma-mapping: support non-coherent devices in dma_common_get_sgtable
Date:   Fri, 14 Sep 2018 11:58:08 +0200
Message-Id: <20180914095808.22202-7-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914095808.22202-1-hch@lst.de>
References: <20180914095808.22202-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+df237881911bfff71047+5500+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66256
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

We can use the arch_dma_coherent_to_pfn hook to provide a ->get_sgtable
implementation.  Note that this isn't an endorsement of this interface
(which is a horrible bad idea), but it is required to move arm64 over
to the generic code without a loss of functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c   |  2 +-
 include/linux/dma-mapping.h |  7 ++++---
 kernel/dma/mapping.c        | 23 ++++++++++++++++-------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 470757ddddea..28819a0e61d0 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -689,7 +689,7 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 							   handle, size, attrs);
 	}
 #endif
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
 }
 
 static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c3378d4e0d57..bd81e74cca7b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -483,8 +483,8 @@ dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
 #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
 
 int
-dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
+dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
+		dma_addr_t dma_addr, size_t size, unsigned long attrs);
 
 static inline int
 dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
@@ -496,7 +496,8 @@ dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 	if (ops->get_sgtable)
 		return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
 					attrs);
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
+			attrs);
 }
 
 #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 42fd73aca305..58dec7a92b7b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -202,17 +202,26 @@ EXPORT_SYMBOL(dmam_release_declared_memory);
  * Create scatter-list for the already allocated DMA buffer.
  */
 int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		 void *cpu_addr, dma_addr_t handle, size_t size)
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 unsigned long attrs)
 {
-	struct page *page = virt_to_page(cpu_addr);
+	struct page *page;
 	int ret;
 
-	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-	if (unlikely(ret))
-		return ret;
+	if (!dev_is_dma_coherent(dev)) {
+		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
+			return -ENXIO;
 
-	sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	return 0;
+		page = pfn_to_page(arch_dma_coherent_to_pfn(dev, cpu_addr,
+				dma_addr));
+	} else {
+		page = virt_to_page(cpu_addr);
+	}
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return ret;
 }
 EXPORT_SYMBOL(dma_common_get_sgtable);
 
-- 
2.18.0
