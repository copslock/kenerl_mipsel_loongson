Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:19:30 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:49696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994676AbeAJIKPVsq3S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:10:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Tc3sPceDWFtB+WEm9Qvqc2cTzvVMZTjkBzuRcKTyFw=; b=lNitNrQjFV6pTHxPGXe6kyXAl
        hJWcTIrXRLehjBDBv/C2CU9WUeAr9wz+XQ4W+76TpDXDrn3mjBrUS5KE4Lt55iVhwsLAEgehl1KiL
        4cTcttCsXviVUexdf9Po5kDfABeYDnAr2rted5iHvlhwF7ny4k3ej34CMfBwMSBMzgWXqzsS9Cp0e
        uwWWyKeWfb+5cYWKmab5XV5fjRDkObOloh1IX/rGVoMoN/OXSxyaP2LkiXp9bSVzE/2GOlFWcsJh1
        aZ4fsq9yW3MOjQWSDerQdkvem3uSJvjq4e3hCE6jC0EfbkGNyyrepm4eGoHHf5FNXWndjN8F8ozqT
        K6R3LtR1A==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBSY-0008Mu-Rs; Wed, 10 Jan 2018 08:10:07 +0000
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
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/22] swiotlb: remove various exports
Date:   Wed, 10 Jan 2018 09:09:21 +0100
Message-Id: <20180110080932.14157-12-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62010
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

All these symbols are only used by arch dma_ops implementations or
xen-swiotlb.  None of which can be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index bf2d19ee91c1..1eac51ff77a4 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -605,7 +605,6 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 
 	return tlb_addr;
 }
-EXPORT_SYMBOL_GPL(swiotlb_tbl_map_single);
 
 /*
  * Allocates bounce buffer and returns its kernel virtual address.
@@ -675,7 +674,6 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	}
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
-EXPORT_SYMBOL_GPL(swiotlb_tbl_unmap_single);
 
 void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 			     size_t size, enum dma_data_direction dir,
@@ -707,7 +705,6 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 		BUG();
 	}
 }
-EXPORT_SYMBOL_GPL(swiotlb_tbl_sync_single);
 
 static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
 		size_t size)
@@ -884,7 +881,6 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 
 	return swiotlb_phys_to_dma(dev, io_tlb_overflow_buffer);
 }
-EXPORT_SYMBOL_GPL(swiotlb_map_page);
 
 /*
  * Unmap a single streaming mode DMA translation.  The dma_addr and size must
@@ -925,7 +921,6 @@ void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 {
 	unmap_single(hwdev, dev_addr, size, dir, attrs);
 }
-EXPORT_SYMBOL_GPL(swiotlb_unmap_page);
 
 /*
  * Make physical memory consistent for a single streaming mode DMA translation
@@ -963,7 +958,6 @@ swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
 {
 	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
 }
-EXPORT_SYMBOL(swiotlb_sync_single_for_cpu);
 
 void
 swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
@@ -971,7 +965,6 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
 {
 	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
 }
-EXPORT_SYMBOL(swiotlb_sync_single_for_device);
 
 /*
  * Map a set of buffers described by scatterlist in streaming mode for DMA.
@@ -1023,7 +1016,6 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
 	}
 	return nelems;
 }
-EXPORT_SYMBOL(swiotlb_map_sg_attrs);
 
 /*
  * Unmap a set of streaming mode DMA translations.  Again, cpu read rules
@@ -1043,7 +1035,6 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 		unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
 }
-EXPORT_SYMBOL(swiotlb_unmap_sg_attrs);
 
 /*
  * Make physical memory consistent for a set of streaming mode DMA translations
@@ -1071,7 +1062,6 @@ swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
 {
 	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
 }
-EXPORT_SYMBOL(swiotlb_sync_sg_for_cpu);
 
 void
 swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
@@ -1079,14 +1069,12 @@ swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
 {
 	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
 }
-EXPORT_SYMBOL(swiotlb_sync_sg_for_device);
 
 int
 swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
 {
 	return (dma_addr == swiotlb_phys_to_dma(hwdev, io_tlb_overflow_buffer));
 }
-EXPORT_SYMBOL(swiotlb_dma_mapping_error);
 
 /*
  * Return whether the given device DMA address mask can be supported
@@ -1099,7 +1087,6 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
 	return swiotlb_phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
-EXPORT_SYMBOL(swiotlb_dma_supported);
 
 #ifdef CONFIG_DMA_DIRECT_OPS
 void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-- 
2.14.2
