Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:20:06 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:50420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994859AbdFPSMYG4zwW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:12:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UpkgGwuwItt4QuRFXbLZqM0hROek/SC1Yd8LK8nr0CI=; b=Z5wAgr8CoUDXI3jWyDTuz+iNz
        yYDBiKK0OjhKglvwQOHvn/OcAw4A9hKwE1WocesESlqTomulOrZV8g58KgejoF6Wfv3SLRgc0oiEw
        26y3+7b/roWyWu6YXb0rShSwVbkw/bwob9/ShjZSKi8AB2fKFLFLH56gY3S3C5wdfPHM3TAKkOC5Z
        aQ9VuBRjqzbW2DqJYE+3be+Bm4ITLx7eBvdZhZxOD4xAyhkTizfJ1J4BQAaNo1HOgSrpYpGy2Kv7n
        RuOA3IoT+q+iZhDh5BREf+B1lRoxXigfIeSH/GKC1FRJpBJRXt7cof6ck4Xmzn87wuDUMwNTj1eVU
        Cy7JjyczQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvjF-0005XK-R6; Fri, 16 Jun 2017 18:12:18 +0000
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
Subject: [PATCH 20/44] sparc: implement ->mapping_error
Date:   Fri, 16 Jun 2017 20:10:35 +0200
Message-Id: <20170616181059.19206-21-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58551
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
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma-mapping.h |  2 --
 arch/sparc/kernel/iommu.c            | 12 +++++++++---
 arch/sparc/kernel/iommu_common.h     |  2 ++
 arch/sparc/kernel/pci_sun4v.c        | 14 ++++++++++----
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 69cc627779f2..b8e8dfcd065d 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -5,8 +5,6 @@
 #include <linux/mm.h>
 #include <linux/dma-debug.h>
 
-#define DMA_ERROR_CODE	(~(dma_addr_t)0x0)
-
 #define HAVE_ARCH_DMA_SUPPORTED 1
 int dma_supported(struct device *dev, u64 mask);
 
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index c63ba99ca551..dafa316d978d 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -314,7 +314,7 @@ static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
 bad_no_ctx:
 	if (printk_ratelimit())
 		WARN_ON(1);
-	return DMA_ERROR_CODE;
+	return SPARC_MAPPING_ERROR;
 }
 
 static void strbuf_flush(struct strbuf *strbuf, struct iommu *iommu,
@@ -547,7 +547,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 
 	if (outcount < incount) {
 		outs = sg_next(outs);
-		outs->dma_address = DMA_ERROR_CODE;
+		outs->dma_address = SPARC_MAPPING_ERROR;
 		outs->dma_length = 0;
 	}
 
@@ -573,7 +573,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 			iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
 					     IOMMU_ERROR_CODE);
 
-			s->dma_address = DMA_ERROR_CODE;
+			s->dma_address = SPARC_MAPPING_ERROR;
 			s->dma_length = 0;
 		}
 		if (s == outs)
@@ -741,6 +741,11 @@ static void dma_4u_sync_sg_for_cpu(struct device *dev,
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+static int dma_4u_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == SPARC_MAPPING_ERROR;
+}
+
 static const struct dma_map_ops sun4u_dma_ops = {
 	.alloc			= dma_4u_alloc_coherent,
 	.free			= dma_4u_free_coherent,
@@ -750,6 +755,7 @@ static const struct dma_map_ops sun4u_dma_ops = {
 	.unmap_sg		= dma_4u_unmap_sg,
 	.sync_single_for_cpu	= dma_4u_sync_single_for_cpu,
 	.sync_sg_for_cpu	= dma_4u_sync_sg_for_cpu,
+	.mapping_error		= dma_4u_mapping_error,
 };
 
 const struct dma_map_ops *dma_ops = &sun4u_dma_ops;
diff --git a/arch/sparc/kernel/iommu_common.h b/arch/sparc/kernel/iommu_common.h
index 828493329f68..5ea5c192b1d9 100644
--- a/arch/sparc/kernel/iommu_common.h
+++ b/arch/sparc/kernel/iommu_common.h
@@ -47,4 +47,6 @@ static inline int is_span_boundary(unsigned long entry,
 	return iommu_is_span_boundary(entry, nr, shift, boundary_size);
 }
 
+#define SPARC_MAPPING_ERROR	(~(dma_addr_t)0x0)
+
 #endif /* _IOMMU_COMMON_H */
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 68bec7c97cb8..8e2a56f4c03a 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -412,12 +412,12 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 bad:
 	if (printk_ratelimit())
 		WARN_ON(1);
-	return DMA_ERROR_CODE;
+	return SPARC_MAPPING_ERROR;
 
 iommu_map_fail:
 	local_irq_restore(flags);
 	iommu_tbl_range_free(tbl, bus_addr, npages, IOMMU_ERROR_CODE);
-	return DMA_ERROR_CODE;
+	return SPARC_MAPPING_ERROR;
 }
 
 static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
@@ -590,7 +590,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 
 	if (outcount < incount) {
 		outs = sg_next(outs);
-		outs->dma_address = DMA_ERROR_CODE;
+		outs->dma_address = SPARC_MAPPING_ERROR;
 		outs->dma_length = 0;
 	}
 
@@ -607,7 +607,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 			iommu_tbl_range_free(tbl, vaddr, npages,
 					     IOMMU_ERROR_CODE);
 			/* XXX demap? XXX */
-			s->dma_address = DMA_ERROR_CODE;
+			s->dma_address = SPARC_MAPPING_ERROR;
 			s->dma_length = 0;
 		}
 		if (s == outs)
@@ -669,6 +669,11 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	local_irq_restore(flags);
 }
 
+static int dma_4v_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == SPARC_MAPPING_ERROR;
+}
+
 static const struct dma_map_ops sun4v_dma_ops = {
 	.alloc				= dma_4v_alloc_coherent,
 	.free				= dma_4v_free_coherent,
@@ -676,6 +681,7 @@ static const struct dma_map_ops sun4v_dma_ops = {
 	.unmap_page			= dma_4v_unmap_page,
 	.map_sg				= dma_4v_map_sg,
 	.unmap_sg			= dma_4v_unmap_sg,
+	.mapping_error			= dma_4v_mapping_error,
 };
 
 static void pci_sun4v_scan_bus(struct pci_pbm_info *pbm, struct device *parent)
-- 
2.11.0
