Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:37:02 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:42835 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993936AbdFHN1lU36ST (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:27:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0pQM296cOAN5HCVAlroZai7dK3o9yZmTCDhfK9xt9Xc=; b=PXwu9ucoFB1f8Jh90h65lGVVI
        HoFQy2SrDkiDWxDjCgJuV8lg8KiDxy3jI6UAKG/qg8F92mgtXPQ808QdT6y8/fAMGTQe8lvy+Vszu
        gNz3/JsQLXWJ6rUU/T0WTuKGobb9noy0SjqqXk2HZfU70B/9tmyy4cI5qWkqv4MvjOn87hl8B9doV
        yW8ncM1vSri8mkEt3EiXWUIYz/1WihvPvne1AbHE+SS7r53VoBv/JYHrrgR+AL1R7nXacCCJI38H+
        KlxHY6ocykWVT2O9QJnwMPg2y6FCJuh9JE6z2NccdTw7aKcCrAW4G40PXESg1fEc84WEgGuaJZVjF
        sdFBOYQZw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxTH-0006Rc-PV; Thu, 08 Jun 2017 13:27:32 +0000
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
Subject: [PATCH 19/44] s390: implement ->mapping_error
Date:   Thu,  8 Jun 2017 15:25:44 +0200
Message-Id: <20170608132609.32662-20-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58329
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

s390 can also use noop_dma_ops, and while that currently does not return
errors it will so in the future.  Implementing the mapping_error method
is the proper way to have per-ops error conditions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/include/asm/dma-mapping.h |  2 --
 arch/s390/pci/pci_dma.c             | 18 +++++++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 3108b8dbe266..512ad0eaa11a 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -8,8 +8,6 @@
 #include <linux/dma-debug.h>
 #include <linux/io.h>
 
-#define DMA_ERROR_CODE		(~(dma_addr_t) 0x0)
-
 extern const struct dma_map_ops s390_pci_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 9081a57fa340..ea623faab525 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -14,6 +14,8 @@
 #include <linux/pci.h>
 #include <asm/pci_dma.h>
 
+#define S390_MAPPING_ERROR		(~(dma_addr_t) 0x0)
+
 static struct kmem_cache *dma_region_table_cache;
 static struct kmem_cache *dma_page_table_cache;
 static int s390_iommu_strict;
@@ -281,7 +283,7 @@ static dma_addr_t dma_alloc_address(struct device *dev, int size)
 
 out_error:
 	spin_unlock_irqrestore(&zdev->iommu_bitmap_lock, flags);
-	return DMA_ERROR_CODE;
+	return S390_MAPPING_ERROR;
 }
 
 static void dma_free_address(struct device *dev, dma_addr_t dma_addr, int size)
@@ -329,7 +331,7 @@ static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 	/* This rounds up number of pages based on size and offset */
 	nr_pages = iommu_num_pages(pa, size, PAGE_SIZE);
 	dma_addr = dma_alloc_address(dev, nr_pages);
-	if (dma_addr == DMA_ERROR_CODE) {
+	if (dma_addr == S390_MAPPING_ERROR) {
 		ret = -ENOSPC;
 		goto out_err;
 	}
@@ -352,7 +354,7 @@ static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 out_err:
 	zpci_err("map error:\n");
 	zpci_err_dma(ret, pa);
-	return DMA_ERROR_CODE;
+	return S390_MAPPING_ERROR;
 }
 
 static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
@@ -429,7 +431,7 @@ static int __s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	int ret;
 
 	dma_addr_base = dma_alloc_address(dev, nr_pages);
-	if (dma_addr_base == DMA_ERROR_CODE)
+	if (dma_addr_base == S390_MAPPING_ERROR)
 		return -ENOMEM;
 
 	dma_addr = dma_addr_base;
@@ -476,7 +478,7 @@ static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	for (i = 1; i < nr_elements; i++) {
 		s = sg_next(s);
 
-		s->dma_address = DMA_ERROR_CODE;
+		s->dma_address = S390_MAPPING_ERROR;
 		s->dma_length = 0;
 
 		if (s->offset || (size & ~PAGE_MASK) ||
@@ -525,6 +527,11 @@ static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		s->dma_length = 0;
 	}
 }
+	
+static int s390_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == S390_MAPPING_ERROR;
+}
 
 int zpci_dma_init_device(struct zpci_dev *zdev)
 {
@@ -657,6 +664,7 @@ const struct dma_map_ops s390_pci_dma_ops = {
 	.unmap_sg	= s390_dma_unmap_sg,
 	.map_page	= s390_dma_map_pages,
 	.unmap_page	= s390_dma_unmap_pages,
+	.mapping_error	= s390_mapping_error,
 	/* if we support direct DMA this must be conditional */
 	.is_phys	= 0,
 	/* dma_supported is unconditionally true without a callback */
-- 
2.11.0
